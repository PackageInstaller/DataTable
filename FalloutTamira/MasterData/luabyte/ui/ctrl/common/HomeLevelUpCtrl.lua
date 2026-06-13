local M = BaseClass("HomeLevelUpCtrl", BaseUICtrl)

function M:Init()
    self._view.CloseBtn:onClick(Bind(self, self.Close))
end

function M:OnEnter(old, now)
    self:SetLevel(old, now)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:SetLevel(old, now)
    local oldCfg = ConfigHelper.GetCfg("homepageLevel", old) or {}
    local newCfg = ConfigHelper.GetCfg("homepageLevel", now) or {}
    local energy = EnergyMgr:GetInstance():EnergyValue()
    local preEnergy = energy - newCfg.energyReward

    self._view.OldLevel:SetText(tostring(old))
    self._view.NewLevel:SetText(tostring(now))

    self._view.OldEnergy:SetText(tostring(preEnergy))
    self._view.OldLimit:SetText(tostring(oldCfg.energy))
    self._view.OldAttr:SetText(tostring(oldCfg.playerAttrValue[0]))

    self._view.NewEnergy:SetText(tostring(energy))
    self._view.NewLimit:SetText(tostring(newCfg.energy))
    self._view.NewAttr:SetText(tostring(newCfg.playerAttrValue[0]))
end

return M
