local DormAtmosphereItemCtrl = BaseClass("DormAtmosphereItemCtrl")
local M = DormAtmosphereItemCtrl

function M:__init(view)
    self._view = view
    self._view.Atmosphere:onClick(Bind(self, self.OnClickAtmosphere))
    self.UpdateHandle = EventMgr:AddListener(UIMessageNames.DORM_UPDATE_ATMOSPHERE, Bind(self, self.Update))
end

function M:Update(heroId)
    self.heroId = heroId
    self:AtmosphereRedPointCheck()
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    self.curAtmosphere = OtakuFurniturDataMgr:GetAtmosphere(heroId)
    self.isMax = self:IsMaxLevel()
    if self.isMax then
        self._view.curNum:SetText(tostring(self.curAtmosphere))
        self._view.Scrollbar:SetSize(1)
        self._view.UIState:SetState(2)
    else
        local targetCfg = ConfigHelper.GetCfgsByLua("atmosphere",
            { heroId = self.heroId, level = self.rshd.Atmosphere + 1 })
        self._view.curNum:SetText(tostring(self.curAtmosphere))
        self._view.maxNum:SetText(tostring(targetCfg[1].buffLabel))
        self.canReward = self.curAtmosphere >= targetCfg[1].buffLabel
        self._view.Scrollbar:SetSize(self.curAtmosphere / targetCfg[1].buffLabel)
        self._view.UIState:SetState(1)
    end
end

function M:AtmosphereRedPointCheck()
    self._view.AtmosphereRedPoint:SetParam(0, self.heroId)
    self._view.AtmosphereRedPoint:Check()
end

function M:IsMaxLevel()
    local heroAtmospheres = ConfigHelper.GetCfgsByLua("atmosphere", { heroId = self.heroId })
    self.maxLevel = 0
    for k, v in pairs(heroAtmospheres) do
        if v.level > self.maxLevel then
            self.maxLevel = v.level
        end
    end
    if self.rshd.Atmosphere == self.maxLevel then
        return true
    end
    return false
end

function M:OnClickAtmosphere()
    UIContextMgr:GetInstance():Show("DormAtmospherePopup", self.heroId)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_UPDATE_ATMOSPHERE, self.UpdateHandle)

    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormAtmosphereItemCtrl
