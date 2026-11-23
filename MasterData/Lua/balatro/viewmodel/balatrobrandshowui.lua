







require("Balatro/ViewModel/BalatroBrandShowItem")





BalatroBrandShowUI = {}
BalatroBrandShowUI.__index = BalatroBrandShowUI

local objs = {
    balatroGroup = {path = "BrandGroup/BalatroGroup", type = BalatroUtil.Transform},
    balatroGroupRect = {path = "BrandGroup/BalatroGroup", type = BalatroUtil.RectTransform},
    propsGroup = {path = "BrandGroup/PropsGroup", type = BalatroUtil.Transform}
}

function BalatroBrandShowUI.New(obj, itemPrefab, canDrag)

    local self = {}
    setmetatable(self, BalatroBrandShowUI)
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs)
    self.canDrag = canDrag
    local onPointerDown = function(index, eventData)
        self:OnPointerDown(index, eventData)
    end
    local onDrag = function(eventData)
        self:OnDrag(eventData)
    end
    local onPointerUp = function(eventData)
        self:OnPointerUp(eventData)
    end

    self.cacheItem = {}

    self.cacheBalatroItem = {}

    self.cachePropsItem = {}
    self.balatroBrandPosList = {}
    local pos1 = Vector3(-5, 105, 0)
    local pos2 = Vector3(30, 105, 0)
    local totalCount = BalatroConstVal.MaxBalatroBrandCount + BalatroConstVal.MaxPropsBrandCount
    for i = 1, totalCount do
        local parent = self.balatroGroup
        local pos = Vector3.zero
        local itemType = nil
        if i <= BalatroConstVal.MaxBalatroBrandCount then
            itemType = BalatroBrandShowItem.ItemType.Balatro
            parent = self.balatroGroup
            pos = pos1
        else
            itemType = BalatroBrandShowItem.ItemType.Props
            parent = self.propsGroup
            pos = pos2
        end
        local item = BalatroBrandShowItem.New(itemPrefab, parent, itemType, i)
        item.transform.localPosition = pos
        local itemName = item.gameObject.name
        if i <= BalatroConstVal.MaxBalatroBrandCount then
            table.insert(self.cacheBalatroItem, item)
        else
            table.insert(self.cachePropsItem, item)
        end
        self.cacheItem[itemName] = item
        if self.canDrag == true then
            item:SetDragEvent(i, onPointerDown, onDrag, onPointerUp)
        end
        item:SetVisible(false)
    end

    self.curSelectItem = nil
    self.downTime = 0
    return self
end

function BalatroBrandShowUI:InitItem()
    local datas = BalatroDataMgr.GetUsingBalatroLst()
    for i = 1, BalatroConstVal.MaxBalatroBrandCount do
        local item = self.cacheBalatroItem[i]
        item:SetVisible(false)
    end
    for _, value in pairs(datas) do
        self:ChangeBalatroItem(value, true)
    end
    for i = 1, BalatroConstVal.MaxPropsBrandCount do
        local item = self.cachePropsItem[i]
        item:SetPropsData(nil)
        item:SetVisible(false)
    end
    local propDatas = BalatroDataMgr.GetPropsBrandDatas()
    local index = 0
    for key, value in pairs(propDatas) do
        self:AddPropsItem(value, true)
    end
    self:OnRefreshShowBalatro()
end



function BalatroBrandShowUI:ChangeBalatroItem(data, isSelected)
    if isSelected == false then
        for i = 1, BalatroConstVal.MaxBalatroBrandCount do
            local item = self.cacheBalatroItem[i]
            local itemData = item:GetBalatroData()
            if itemData then
                local itemDataID = itemData:GetUID()
                if itemDataID == data:GetUID() then
                    item:SetVisible(false)
                    break
                end
            end
        end
    else
        for i = 1, BalatroConstVal.MaxBalatroBrandCount do
            local item = self.cacheBalatroItem[i]
            if item:IsVisible() == false then
                item:SetVisible(true)
                item:SetBalatroData(data)
                break
            end
        end
    end
    local startPosX, startPosY = 35, 105
    local visibleCount = 0
    self.balatroBrandPosList = {}
    local callback = function(item)
        for key, value in pairs(self.cacheBalatroItem) do
            table.insert(self.balatroBrandPosList, value:GetPosition())
        end
    end
    for i = 1, BalatroConstVal.MaxBalatroBrandCount do
        local item = self.cacheBalatroItem[i]
        if item:IsVisible() == true then
            visibleCount = visibleCount + 1
            local posY = startPosY + (visibleCount - 1) * -52
            item:SetPosition(startPosX, posY, nil, callback)
            item:SetSiblingIndex(i - 1)
        end
    end
    self:SetLeftAndRightItem()
end

function BalatroBrandShowUI:OnRefreshShowBalatro()
    for key, value in pairs(self.cacheBalatroItem) do
        if value:IsVisible() == true then
            local balatroData = value:GetBalatroData()
            if balatroData ~= nil and (balatroData:GetInvalid() == true or balatroData:GetIsDestroy() == true) then
                value:SetInValid(true)
            else
                value:SetInValid(false)
            end
        end
    end
end



function BalatroBrandShowUI:GetBalatroShowItems()
    local tempDatas = {}
    for key, value in pairs(self.cacheBalatroItem) do
        if value:IsVisible() == true then
            table.insert(tempDatas, value)
        end
    end
    return tempDatas
end

function BalatroBrandShowUI:SetLeftAndRightItem()
    local thisTrans = self.balatroGroup.transform
    local count = thisTrans.childCount
    BalatroDataMgr.SetMaxLeftBalatro()
    BalatroDataMgr.SetMaxRightBalatro()
    for i = 1, count do
        local tempTrans = thisTrans:GetChild(i - 1)
        local balatroItem = self.cacheItem[tempTrans.name]
        if balatroItem and balatroItem.gameObject.activeSelf then
            local balatroData = balatroItem:GetBalatroData()
            if balatroData and balatroData:CanCopyAbility() and not BalatroDataMgr.GetMaxLeftBalatro() then
                BalatroDataMgr.SetMaxLeftBalatro(balatroData)
            end
            if BalatroDataMgr.GetMaxLeftBalatro() ~= nil then
                break
            end
        end
    end
    for i = count, 1, -1 do
        local tempTrans = thisTrans:GetChild(i - 1)
        local balatroItem = self.cacheItem[tempTrans.name]
        if balatroItem and balatroItem.gameObject.activeSelf then
            local balatroData = balatroItem:GetBalatroData()
            if balatroData and balatroData:CanCopyAbility() and not BalatroDataMgr.GetMaxRightBalatro() then
                BalatroDataMgr.SetMaxRightBalatro(balatroData)
            end
            if BalatroDataMgr.GetMaxRightBalatro() ~= nil then
                break
            end
        end
    end
end



function BalatroBrandShowUI:AddPropsItem(data, isAdd)
    if isAdd == false then
        for i = 1, BalatroConstVal.MaxPropsBrandCount do
            local item = self.cachePropsItem[i]
            local itemData = item:GetPropsData()
            if itemData then
                local itemDataID = itemData:GetUID()
                if itemDataID == data:GetUID() then
                    item:SetVisible(false)
                    break
                end
            end
        end
    else
        for i = 1, BalatroConstVal.MaxPropsBrandCount do
            local item = self.cachePropsItem[i]
            if item:IsVisible() == false then
                item:SetVisible(true)
                item:SetPropsData(data)
                break
            end
        end
    end
    local startPosX, startPosY = 35, 105
    local visibleCount = 0
    for i = 1, BalatroConstVal.MaxPropsBrandCount do
        local item = self.cachePropsItem[i]
        if item:IsVisible() == true then
            visibleCount = visibleCount + 1
            local posY = startPosY + (visibleCount - 1) * -52
            item:SetPosition(startPosX, posY)
            item:SetSiblingIndex(i)
        end
    end
end

function BalatroBrandShowUI:OnPointerDown(index, eventData)
    if eventData.pointerEnter then
        self.curSelectItem = self.cacheItem[eventData.pointerEnter.name]
        self.downTime = CS.UnityEngine.Time.realtimeSinceStartup
        local screenPos = RaycastTool.GetMousePosition()
        self.pointerDownPosX = screenPos.x
        self.pointerDownPosY = screenPos.y
    end
end

function BalatroBrandShowUI:OnDrag(eventData)
    if BalatroStepMgr.CheckGameRealStart() == false then
        return
    end
    if not self.curSelectItem then
        return
    end
    local itemType = self.curSelectItem:GetItemType()
    if itemType ~= BalatroBrandShowItem.ItemType.Balatro then
        return
    end
    local eventPos = LuaMgr.Screen2Local(eventData.position, self.balatroGroupRect)
    for key, value in pairs(self.cacheItem) do
        if key ~= self.curSelectItem:GetObjName() and value:GetItemType() == BalatroBrandShowItem.ItemType.Balatro and value:IsVisible() == true then
            local itemPos = value:GetPosition()
            local itemSiblingIndex = value:GetSiblingIndex()
            if eventPos.y > itemPos.y and itemSiblingIndex < self.curSelectItem:GetSiblingIndex() then
                value:SetPosition(itemPos.x, itemPos.y - 50)
                self.curSelectItem:SetSiblingIndex(self.curSelectItem:GetSiblingIndex() - 1)
                value:SetSiblingIndex(itemSiblingIndex + 1)
            elseif eventPos.y < itemPos.y and itemSiblingIndex > self.curSelectItem:GetSiblingIndex() then
                value:SetPosition(itemPos.x, itemPos.y + 50)
                value:SetSiblingIndex(itemSiblingIndex - 1)
                self.curSelectItem:SetSiblingIndex(self.curSelectItem:GetSiblingIndex() + 1)
            end
        end
    end
    self.curSelectItem:SetPosition(36.275, eventPos.y)
end

function BalatroBrandShowUI:OnPointerUp(eventData)
    if not self.curSelectItem then
        return
    end
    local itemType = self.curSelectItem:GetItemType()
    local upTime = CS.UnityEngine.Time.realtimeSinceStartup
    if itemType == BalatroBrandShowItem.ItemType.Balatro then
        local balatroData = self.curSelectItem:GetBalatroData()
        local deltaX = math.abs(eventData.position.x - self.pointerDownPosX)
        local deltaY = math.abs(eventData.position.y - self.pointerDownPosY)
        if (deltaX == 0 and deltaY == 0) then
            local data = {
                UID = balatroData:GetUID(),
                previewType = BalatroUtil.BrandPreviewType.BalatroBrand
            }
            LuaMgr.ShowLuaPanel(UIName.BalatroBrandPreviewPopup, data)
        else
            for i = 1, #self.cacheBalatroItem do
                local item = self.cacheBalatroItem[i]
                local siblingIndex = item:GetRealSiblingIndex()
                local pos = self.balatroBrandPosList[siblingIndex + 1]
                if pos then
                    item:SetPosition(pos.x, pos.y)
                end
            end
        end
    else
        local propsData = self.curSelectItem:GetPropsData()
        if upTime - self.downTime < 0.5 then
            local tempData = {}
            tempData.leftStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20006")
            tempData.rightStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20007")
            tempData.content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20008") .. propsData:GetDes()
            tempData.data = self.curSelectItem
            tempData.callBackConfirm = function(param)
                if BalatroDataMgr.GetSettlingStatus() == true then
                    local tipsTxt = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20033")
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsTxt)
                    return
                end
                local tempPropsData = param.data:GetPropsData()
                local useRes, tips = self:UsePropsBrand(tempPropsData)
                if useRes == false then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
                else
                    local tipsText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20030")
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsText)
                    self:AddPropsItem(tempPropsData, false)
                    BalatroUtil.PlaySound(6)
                end
            end
            LuaMgr.ShowLuaPanel(UIName.BalatroMsgboxPopUp, tempData)
        else
            local data = {
                UID = propsData:GetUID(),
                previewType = BalatroUtil.BrandPreviewType.PropsBrand
            }
            LuaMgr.ShowLuaPanel(UIName.BalatroBrandPreviewPopup, data)
        end
    end
    self.curSelectItem = nil
end


function BalatroBrandShowUI:UsePropsBrand(data)
    return BalatroDataMgr.UsePropsBrandData(data:GetUID())
end



function BalatroBrandShowUI.SortItem(item1, item2)
    if item1:IsVisible() and not item2:IsVisible() then
        return -1
    end
    if not item1:IsVisible() and item2:IsVisible() then
        return 1
    end
    return 0
end