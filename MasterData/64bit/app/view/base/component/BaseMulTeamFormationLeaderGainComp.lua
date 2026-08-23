local var_0_0 = {
	WHITE = 1,
	BLACK = 0
}
local var_0_1 = {
	[var_0_0.BLACK] = 4,
	[var_0_0.WHITE] = 6
}
local var_0_2 = {
	16,
	32,
	50,
	66,
	84,
	100
}
local var_0_3 = g.core.common.Path
local BaseMulTeamFormationLeaderGainComp = class("BaseMulTeamFormationLeaderGainComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationLeaderGainComp"))

function BaseMulTeamFormationLeaderGainComp:updateComp(arg_1_1, arg_1_2)
	self.m_campLoader:setURL((var_0_3:getCampURL(arg_1_1, var_0_1[self.m_colorController:getSelectedIndex()])))
	self.m_gainBarImg:setFillAmount((self:_getFillAmount(arg_1_2)))
	self:_playEffect(arg_1_2)
end

function BaseMulTeamFormationLeaderGainComp:_getFillAmount(arg_2_1)
	if #var_0_2 <= arg_2_1 then
		return 1
	else
		return (var_0_2[arg_2_1] or 0) / var_0_2[#var_0_2]
	end
end

function BaseMulTeamFormationLeaderGainComp:_playEffect(arg_3_1)
	self.m_effDadComp:removeAllEffect()

	if arg_3_1 >= 6 then
		self.m_effDadComp:addEffectSpine({
			scale = 1,
			isLoop = true,
			anim = "play2",
			name = "eff_ui_formation_gain"
		})
	elseif arg_3_1 >= 2 then
		self.m_effDadComp:addEffectSpine({
			scale = 1,
			isLoop = true,
			anim = "play1",
			name = "eff_ui_formation_gain"
		})
	end
end

return BaseMulTeamFormationLeaderGainComp
