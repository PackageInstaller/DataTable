-- baoruichang
-- 2021/12/28 17:38:26
local UICookingSelectHeroCtrl = BaseClass("UICookingSelectHeroCtrl", BaseUICtrl)
local M = UICookingSelectHeroCtrl
local UICookHeroItemCtrl = require("UI.Ctrl.UICookingSelectHero.UICookHeroItemCtrl")
local UICookHeroItemView = require("UI.View.UICookingSelectHero.UICookHeroItemView")
local tInsert = table.insert
local tSort = table.sort

function M:Init()
    self.ScrollView = self._view.ScrollView
    self.ScrollView:Init(UICookHeroItemCtrl, UICookHeroItemView)
    self.ScrollView:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    self._view.btnOk:onClick(Bind(self, self.OnClickOk))
    self._view.btnClean:onClick(Bind(self, self.OnClickCancel))
    self._view.mask:onClick(Bind(self, self.Close))
end

function M.SortFun(data1, data2)
    if data1.sortId ~= data2.sortId then
        return data1.sortId > data2.sortId
    end

    if data1.feedDegree == data2.feedDegree then
        return data1.heroId < data2.heroId
    end
    return data1.feedDegree < data2.feedDegree
end

-- 进入UI，可传参数
function M:OnEnter()
    local heroDatas = IHeroDataMgr:GetHeros()
    self.allHeroIds = {}

    local selectHeroId = 0
    local selectId = 0
    for id, v in pairs(heroDatas) do
        local data = {}
        local curEater = self:GetNowHeroEat(v:GetHeroId())
        local maxHeroEat = self:GetMaxHeroEat(v:GetHeroId())
        data.select = false
        data.feedDegree = curEater / maxHeroEat

        if data.select and selectHeroId == 0 then
            selectHeroId = v:GetHeroId()
            selectId = id
        end
        data.id = id
        data.sortId = data.select and 1 or 0

        data.heroId = v:GetHeroId()
        tInsert(self.allHeroIds, data)
    end

    tSort(self.allHeroIds, self.SortFun)
    self.ScrollView:SetDataList(self.allHeroIds)
    self:UpdateSelectArea(selectHeroId, selectId, true)
end

function M:IsSelect(heroId)
    for _, v in pairs(self.allHeroIds) do
        if v.heroId == heroId then
            return v.select
        end
    end
end

function M:OnCreateItem(itemCtrl)
    itemCtrl:SetSelectCallback(Bind(self, self.OnSelect))
end

function M:OnSelect(heroId, id)
    if self:IsSelect(heroId) then -- 如果是已经选中状态
        self:UpdateSelectArea(0, id)
    else
        self:UpdateSelectArea(heroId, id)
    end
end

function M:UpdateSelectArea(heroId, selectId, first)
    if heroId <= 0 then -- 未选中状态
        self._view.tfHeroItem:SetActive(false)
        if not first then
            EventMgr:Broadcast(UIMessageNames.COOKING_UPDATEHEROITEM, selectId)
        end
        return
    end

    local ids = self:GetSelectHeros()
    if #ids >= 8 then
        GameHelper.TipsById(6)
        return
    end

    if not first then
        EventMgr:Broadcast(UIMessageNames.COOKING_UPDATEHEROITEM, selectId)
    end
    self._view.tfHeroItem:SetActive(true)
    self._view.skillContent:ClearChildren()
    self._view.skill1:SetActive(false)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local powerIdArr = rshd:GetPowerIds()
    local powerIds = {}

    for i = 0, powerIdArr.Length - 1 do
        table.insert(powerIds, powerIdArr[i])
    end

    for i, v in ipairs(powerIds) do
        local skillView = self._view.skill1:Instantiate()
        skillView:SetActive(true)
        skillView:SetParent(self._view.skillContent)
        local powerCfg = ConfigHelper.GetCfg("power", v)
        skillView.skillName:SetText(powerCfg.powerName)
        skillView.skillDesc:SetText(powerCfg.powerDes)
        skillView.skilIcon:SetPic(powerCfg.powerIcon)
    end

    local curEater = self:GetNowHeroEat(heroId)
    local maxHeroEat = self:GetMaxHeroEat(heroId)
    self._view.eaterNum:SetText(curEater .. "/" .. maxHeroEat)
    self._view.value:SetValue(curEater / maxHeroEat)
    -- self._view.valueBg:SetColorTo16(self:GetTag3Color(curEater / maxHeroEat))
    -- self._view.HeroItem:Init(0, heroId)
    -- self._view.HeroIcon:SetImageWhole(heroId, RoleType.ERT_Hero)
    self._view.labName:SetAvatarName(heroId, RoleType.ERT_Hero)
    local path = string.format("UI/SpritePics/portrait/portrait_battle/%d", heroId)
    self._view.HeroIcon:SetPic(path)

    local data = IHeroDataMgr:GetMyHeroDataById(heroId)

    if data then
        self._view.labLevel:SetText(tostring(data:GetLevel()))
    end
end

function M:GetTag3Color(value)
    if value > 0.8 then
        return "F1AA2E"
    end

    if value > 0.2 then
        return "FF7C4E"
    end

    return "F44E4E"
end

function M:GetNowHeroEat(heroId)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)

    if not rshd then
        Logger.LogError("获取英雄当前饱食度，未找到该英雄")
        return 0
    end
    return rshd:GetEater()
end

-- 获取英雄最大饱食度
function M:GetMaxHeroEat(heroId)
    return ConfigHelper.GetCfgPropByLua("hero", heroId, "eater")
end

function M:OnClickOk()
    local ids = self:GetSelectHeros()

    if #ids > 8 then
        GameHelper.TipsById(6) -- self._deloyNum
        return
    end
    self:Close()
end

function M:GetSelectHeros()
    local ids = {}

    for key, value in pairs(self.allHeroIds) do
        if value.select then
            tInsert(ids, value.heroId)
        end
    end
    return ids
end

function M:OnClickCancel()
    for _, heroData in pairs(self.allHeroIds) do
        heroData.select = false
    end

    self.ScrollView:UpdateList()
end
return UICookingSelectHeroCtrl
