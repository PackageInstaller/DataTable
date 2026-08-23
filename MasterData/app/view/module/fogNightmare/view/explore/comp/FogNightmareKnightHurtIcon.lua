local FogNightmareKnightHurtIcon = class("FogNightmareKnightHurtIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareKnightHurtIcon"))

function FogNightmareKnightHurtIcon:updateKnightIcon(arg_1_1, arg_1_2)
	self.m_stateController:setSelectedIndex(arg_1_2)
	self.m_knightIcon:updateIcon({
		changeControllers = true,
		struct = arg_1_1
	})
	self.m_knightIcon:hideAdvanceShow()
	self.m_hpBar:setMax(100)
	self.m_hpBar:setValue(arg_1_1:getHpPercent())
end

function FogNightmareKnightHurtIcon:playIconEff()
	self.m_effIcon:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_icon",
		isLoop = false
	})
	self.m_enterTransition:play()
end

return FogNightmareKnightHurtIcon
