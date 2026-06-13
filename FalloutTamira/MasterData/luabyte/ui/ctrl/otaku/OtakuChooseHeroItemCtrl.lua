local OtakuChooseHeroItemCtrl = BaseClass("OtakuChooseHeroItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuChooseHeroItemCtrl
local DeployHeroState = OtakuType.DeployHeroState

function M:UpdateItem(data, position, ctrl)
    if data == nil then
        return
    end

    self.chooseHeroCtrl = ctrl
    self._data = data
    self:_SetBaseInfo(data)
    self:_SetSkillInfo(data)
    self:_SetStateInfo(data, position)
end

function M:_SetBaseInfo(data)
    self._view.imgHero:SetAvatarIcon(data.heroId, RoleType.ERT_Hero)
    self._view.txtHero:SetAvatarName(data.heroId, RoleType.ERT_Hero)
    self._view.stateItem:SetState(data.state)
end

function M:_SetSkillInfo(data)
    local heroBreak = data.heroData:GetHeroBreak()

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
        local unLock = false
        local powerCfg = ConfigHelper.GetCfg("power", power2)
        if powerCfg.label == data.roomType then
            -- 进行是否解锁匹配
            for k = 0, count - 1 do
                local power = powerId[k]
                if power == power2 then
                    unLock = true
                end
            end

            if unLock then
                local isSkill = self:_SetSkilItem(i, powerCfg, data)
                hasAddition = hasAddition or isSkill
            else
                self:_SetLockSkilItem(i, powerCfg, data, heroBreak.language[i])
            end
        end
    end

    local additionState = hasAddition == true and 1 or 2
    self._view.stateAddition:SetState(additionState)
end

function M:_SetSkilItem(index, powerCfg, data)
    local skillState = powerCfg.label == data.roomType and 1 or 2
    local skillName = "txtSkill" .. index + 1
    local stateName = "stateSkill" .. index + 1
    local skillIcom = "skillIcon" .. index + 1
    self._view[skillName]:SetText(powerCfg.powerDes)
    self._view[stateName]:SetState(skillState)
    self._view[skillName]:SetActive(true)
    self._view[skillIcom]:SetPic(powerCfg.powerIcon)
    return powerCfg.label == data.roomType
end

function M:_SetLockSkilItem(index, powerCfg, data, des)
    local skillState = powerCfg.label == data.roomType and 3 or 4
    local skillName = "txtSkill" .. index + 1
    local stateName = "stateSkill" .. index + 1
    local skillIcom = "skillIcon" .. index + 1
    local des1 = ConfigHelper.GetLocalString(powerCfg.powerDes)
    local des2 = ConfigHelper.GetLocalString(des)
    self._view[skillName]:SetText(des1 .. " (" .. des2 .. ")")
    self._view[stateName]:SetState(skillState)
    self._view[skillName]:SetActive(true)
    self._view[skillIcom]:SetPic(powerCfg.powerIcon)
end

function M:_SetHideSkillItem(index)
    local skillName = "txtSkill" .. index + 1
    self._view[skillName]:SetActive(false)
end

function M:_SetStateInfo(data, position)
    self._view.typeState:SetState(1)
    if data.state ~= DeployHeroState.Idle then
        self._view.txtRoomName:SetText(data.otherRoomName)

        if data.roomType == OtakuType.OtakuRoomType.EST_Bridge then
            self._view.txtRoomIndex:SetText("")
        else
            self._view.txtRoomIndex:SetText(string.format("%02d", data.otherRoomIndex))
        end
    end

    if data.select then
        self._view.SelectState:SetState(2)
    end

    local satiety = data.roleStudioHeroData:GetEater()
    local maxSatiety = data.heroData:GetHeroCfg().eater
    local satietyRatio = satiety / maxSatiety
    satietyRatio = satietyRatio > 1 and 1 or satietyRatio
    satietyRatio = MathUtil.GetPreciseDecimal(satietyRatio, 2)

    if satietyRatio == 0 then
        self._view.stateSatiety:SetState(1)
    elseif satietyRatio < 0.2 then
        self._view.stateSatiety:SetState(2)
    elseif satietyRatio <= 0.8 then
        self._view.stateSatiety:SetState(3)
    else
        self._view.stateSatiety:SetState(4)
    end

    self._view.sbarSatiety.size = satietyRatio
end

function M:Init()
    self._data = nil
    self._view.stateItem:onClick(Bind(self, self.OnItemClick))
end

function M:OnItemClick()
    if self._data.select then
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_SELECT_HERO, self, false)
        self._view.SelectState:SetState(1)
        self._data.select = false
    else
        if #self.chooseHeroCtrl.selectHeros >= self.chooseHeroCtrl.m_DeployMaxNum and self.chooseHeroCtrl.m_DeployMaxNum > 1 then
            return
        end
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_SELECT_HERO, self, true)
        self._view.SelectState:SetState(2)
        self._data.select = true
    end
end

function M:OnDispose()
    self._data = nil
    self.chooseHeroCtrl = nil
    M.super.OnDispose(self)
end

return OtakuChooseHeroItemCtrl
