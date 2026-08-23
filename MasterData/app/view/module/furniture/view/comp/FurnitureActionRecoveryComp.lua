local var_0_0 = g.core.model.User.furnitureData
local FurnitureActionRecoveryComp = class("FurnitureActionRecoveryComp", require("app.fairyGUI.furniture.UI_FurnitureActionRecoveryComp"))

function FurnitureActionRecoveryComp:ctor()
	self._dormId = nil
	self._comfort = 0
end

function FurnitureActionRecoveryComp:updateComp(arg_2_1)
	self._dormId = arg_2_1

	local var_2_0 = var_0_0:getRoomInfo(arg_2_1)

	self._comfort = var_2_0:getComfort()

	if arg_2_1 == self._dormId and self._comfort < self._comfort then
		self:playAddComfortEff()
	end

	self.m_recoveryMinTxt:setText((var_2_0:getMobilityRecoverBaseSpeed()))
	self.m_recoveryAddTxt:setText(g.core.lang:get(112535, {
		num = var_2_0:getMobilityRecoverAddSpeed()
	}))
end

function FurnitureActionRecoveryComp:playAddComfortEff()
	self.m_effDadComp:addEffectSpine({
		remove = true,
		name = "eff_ui_furniture_action",
		isLoop = false
	})
end

return FurnitureActionRecoveryComp
