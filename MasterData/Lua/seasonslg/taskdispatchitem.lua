require("SeasonSLG/EventPopUp/HeroHeadItem")

TaskDispatchItem = {}
TaskDispatchItem.__index = TaskDispatchItem

local objs = {
    root = { path = "root", type = "Transform" },
    teamName = { path = "root/name", type = "Text" },
    worldTeamName = { path = "root/nameWorld", type = "Text" },
    productAdditionDesc = { path = "root/product", type = "Text" },
    teamMembersContent = { path = "root/tranLocContent", type = "Transform" },
    teamWorldMembersContent = { path = "root/tranWorldContent", type = "Transform" },
    startDispatchBtn = { path = "root/dispatch", type = "Button" },
    memberEditorBtn = { path = "root/editor", type = "Button" },
    headItem = { path = "root/temp/headItem", type = "GameObject" },
}

function TaskDispatchItem.New()
    local self = {}
    setmetatable(self, TaskDispatchItem)
    self.rawData = nil
    self.dispatchIndex = 1
    return self
end

function TaskDispatchItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.heroUIList=UIListView.New(self.teamMembersContent)
    self.worldHeroUIList=UIListView.New(self.teamWorldMembersContent)

    self.OpenCallBack = function(dispatchIndex)
        local itemData = self:GetItemData()
        if itemData ~= nil and itemData.openCallBack ~= nil then
            self.dispatchIndex = dispatchIndex or 1
            itemData.openCallBack(self)
        end
    end

    self.DispatchCallBack = function()
        local itemData = self:GetItemData()
        if itemData ~= nil and itemData.dispatchCallBack ~= nil then
            itemData.dispatchCallBack(self)
        end
    end

    if not IsObjectNull(self.startDispatchBtn) then
        LuaMgr.AddClick(self.startDispatchBtn, self.DispatchCallBack)
    end
    if not IsObjectNull(self.memberEditorBtn) then
        LuaMgr.AddClick(self.memberEditorBtn, self.DispatchCallBack)
    end
end

function TaskDispatchItem:GetItemData()
    return self.rawData ~= nil and self.rawData.data or nil
end

function TaskDispatchItem:GetGridId()
    local itemData = self:GetItemData()
    return itemData ~= nil and itemData.gridId or nil
end

function TaskDispatchItem:GetGuardId1()
    local itemData = self:GetItemData()
    return itemData ~= nil and itemData.guardId1 or nil
end

function TaskDispatchItem:GetGuardId2()
    local itemData = self:GetItemData()
    return itemData ~= nil and itemData.guardId2 or nil
end

function TaskDispatchItem:GetGuardData()
    local itemData = self:GetItemData()
    return itemData ~= nil and itemData.data or nil
end

function TaskDispatchItem:GetDispatchIndex()
    return self.dispatchIndex or 1
end

function TaskDispatchItem:GetMembers(dispatchIndex)
    local guardData = self:GetGuardData()
    if guardData == nil then
        return {}
    end
    if dispatchIndex == 2 then
        return guardData.Members2 or {}
    end
    return guardData.Members1 or {}
end

function TaskDispatchItem:GetOtherMembers(dispatchIndex)
    if dispatchIndex == 2 then
        return self:GetMembers(1)
    end
    return self:GetMembers(2)
end

function TaskDispatchItem:SetMembers(dispatchIndex, members)
    local guardData = self:GetGuardData()
    if guardData == nil then
        return
    end
    if dispatchIndex == 2 then
        guardData.Members2 = members or {}
    else
        guardData.Members1 = members or {}
    end
end

function TaskDispatchItem:IsDispatching()
    local guardData = self:GetGuardData()
    if guardData == nil then
        return false
    end
    local id1 = guardData.Id1
    local id2 = guardData.Id2
    return not IsNullOrEmpty(id1) or not IsNullOrEmpty(id2)
end

function TaskDispatchItem:SetData(data)
    self.rawData = data
    self.data = self:GetItemData()
    local guardData = self:GetGuardData()
    if self.data == nil or guardData == nil then
        return
    end

    local config1 = ConfigMgr.Config.SeasonalGridGuardMap[tostring(self:GetGuardId1())]
    local config2 = ConfigMgr.Config.SeasonalGridGuardMap[tostring(self:GetGuardId2())]
    if self.teamName ~= nil and config1 ~= nil then
        self.teamName.text = LuaMgr.GetLangText(config1.NameLan);
    end
    if self.worldTeamName ~= nil and config2 ~= nil then
        self.worldTeamName.text = LuaMgr.GetLangText(config2.NameLan);
    end

    if self.productAdditionDesc ~= nil then
        local totalProduce, addRate = SeasonSLGMapMgr.GetDispatchGroupProduceInfo(
                self:GetGuardId1(),
                self:GetMembers(1),
                self:GetGuardId2(),
                self:GetMembers(2))
        local productText = LuaMgr.GetLangText("TaskDispatchItem_0")
        if totalProduce ~= nil and #totalProduce > 0 then
            productText = string.format(LuaMgr.GetLangText("TaskDispatchItem_1"), addRate or 0)
        end
        self.productAdditionDesc.text = productText
    end

    self:SetHeroList(self.heroUIList, self:GetMembers(1), 1)
    self:SetHeroList(self.worldHeroUIList, self:GetMembers(2), 2)
    local isDispatched = self:IsDispatching()
    if not IsObjectNull(self.startDispatchBtn) then
        SetActive(self.startDispatchBtn.gameObject, not isDispatched)
    end
    if not IsObjectNull(self.memberEditorBtn) then
        SetActive(self.memberEditorBtn.gameObject, isDispatched)
    end
end

function TaskDispatchItem:SetHeroList(heroUIList, heroIds, dispatchIndex)
    if heroUIList == nil then
        return
    end
    heroUIList:Clear()
    local memberSlots = {}
    for i = 1, 6 do

        local heroId = heroIds ~= nil and heroIds[i] or nil
        local heroItem = {
            index = i,
            callBack=function()
                self.OpenCallBack(dispatchIndex)
            end
        }
        if heroId ~= nil and heroId ~= "" then
            local cfgHero = ConfigMgr.Config.characterTable[heroId]
            if cfgHero ~= nil then
                heroItem = {
                    index = i,
                    id = heroId,
                    rare = HeroMgr.GetHeroNowRare(heroId),
                    job = cfgHero.job,
                    name = LuaMgr.GetLangText(cfgHero.namelan),
                    level = DataMgr.Player.characters[heroId] ~= nil and DataMgr.Player.characters[heroId].level or 1,
                    sLevel = 1,
                    select = false,
                    callBack=function()
                        self.OpenCallBack(dispatchIndex)
                    end
                }
            end
        end

        local heroData=UIListData.GetData(self.headItem,"HeroHeadItem",heroItem);
        table.insert(memberSlots,heroData);

    end
    heroUIList:SetData(memberSlots);
end

function TaskDispatchItem:Clear()
    self.data = nil
    self.rawData = nil
    self.dispatchIndex = 1
    if self.heroUIList ~= nil then
        self.heroUIList:Clear()
    end
    if self.worldHeroUIList ~= nil then
        self.worldHeroUIList:Clear()
    end
    UIListView.ClearItem("HeroHeadItem")
end

function TaskDispatchItem:Destroy()
    UIListView.ClearItem("HeroHeadItem")
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end