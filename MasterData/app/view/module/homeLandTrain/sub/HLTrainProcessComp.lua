local var_0_0 = g.core.common.Path
local HLTrainProcessComp = class("HLTrainProcessComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainProcessComp"))

function HLTrainProcessComp:updateAward(arg_1_1, arg_1_2, arg_1_3)
	self.m_rewardLoader:setURL((var_0_0:getIconByTypeValue(arg_1_1, arg_1_2, false)))
	self.m_luckyEffDad:removeAllEffect()

	if arg_1_3 then
		self.m_luckyEffDad:addEffectSpine({
			name = "eff_ui_homelandtrain_luckyget",
			scale = 1,
			isLoop = true
		})
	end
end

function HLTrainProcessComp:updateProgress(arg_2_1, arg_2_2)
	self:setMax(arg_2_2)
	self:setValue(arg_2_1)
end

return HLTrainProcessComp
