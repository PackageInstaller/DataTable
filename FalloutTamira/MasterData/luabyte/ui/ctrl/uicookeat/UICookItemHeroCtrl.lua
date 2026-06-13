-- baoruichang
-- 吃饭 选择英雄item
-- 2022/8/29 20:19:42
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UICookItemHeroCtrl = BaseClass("UICookItemHeroCtrl", CircularScrollViewItem)
local M = UICookItemHeroCtrl

function M:Init()
    self._view:onClick(Bind(self, self._OnBtnClick))
    self._tempRefresItemState = EventMgr:AddListener(UIMessageNames.COOKING_REFCHOOSE, Bind(self, self._RefresItemState))
end

function M:UpdateItem(data)
    self.data = data
    self._view.stateItem:SetState(1)
    self._view.imgHero:SetAvatarIcon(self.data.heroId, RoleType.ERT_Hero)
    self._view.txtHero:SetAvatarName(self.data.heroId, RoleType.ERT_Hero)
    self._view.sbarSatiety.size = self.data.completion

    if self.data.completion < 0.25 then
        self._view.stateSatiety:SetState(1)
    elseif self.data.completion < 0.5 then
        self._view.stateSatiety:SetState(2)
    elseif self.data.completion < 0.75 then
        self._view.stateSatiety:SetState(3)
    else
        self._view.stateSatiety:SetState(4)
    end

    self:_SetSkillInfo(data.heroBreak)
    self._view.stateItem:SetState(self.data.select and 2 or 1)
end

function M:_OnBtnClick()
    if self.selectCallBack then
        self.selectCallBack(self.data.heroId)
    end
end

function M:SetSelectCallback(selectCallBack)
    self.selectCallBack = selectCallBack
end

function M:SetState(state)
    self._view.stateItem:SetState(state)
end

function M:_RefresItemState(heroId)
    if not self.data then
        return
    end

    if self.data.heroId ~= heroId then
        return
    end
    self._view.stateItem:SetState(1)
end

function M:_SetSkillInfo(heroBreak)
    if not heroBreak then
        Logger.LogError("heroBreak 表里没有配置 heroId = " .. data.heroData:GetHeroId() .. "数据")
    end

    local hasAddition = false
    local powerId = heroBreak.powerId
    local powerId2 = heroBreak.powerId2
    local count = powerId.Length
    local count2 = powerId2.Length

    for i = 0, 1 do
        local isNot = i + 1 > count2

        if isNot then
            self:_SetHideSkillItem(i)
            break
        end

        local power2 = powerId2[i]
        local isLock = false

        -- 进行是否解锁匹配
        for k = 0, count - 1 do
            local power = powerId[k]

            if power == power2 then
                isLock = true
            end
        end

        if isLock then
            hasAddition = not hasAddition and self:_SetSkilItem(i, power2)
        else
            self:_SetLockSkilItem(i, heroBreak.language[i])
        end
    end

    local additionState = hasAddition == true and 1 or 2
    self._view.stateAddition:SetState(additionState)
end

function M:_SetSkilItem(index, power)
    local powerCfg = ConfigHelper.GetCfg("power", power)
    local skillName = "txtSkill" .. index + 1
    local stateName = "stateSkill" .. index + 1
    self._view[skillName]:SetText(powerCfg.powerDes)
    
    self._view[skillName]:SetActive(true)
    if powerCfg.label == 6 then -- 餐厅
        self._view[stateName]:SetState(1)
    else
        self._view[stateName]:SetState(2)
    end
    return false
end

function M:_SetLockSkilItem(index, des)
    local skillName = "txtSkill" .. index + 1
    local stateName = "stateSkill" .. index + 1
    self._view[skillName]:SetText(des)
    self._view[stateName]:SetState(2)
    self._view[skillName]:SetActive(true)
end

function M:_SetHideSkillItem(index)
    local skillName = "txtSkill" .. index + 1
    self._view[skillName]:SetActive(false)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.COOKING_REFCHOOSE, self._tempRefresItemState)
    M.super.OnDispose(self)
end

return UICookItemHeroCtrl
