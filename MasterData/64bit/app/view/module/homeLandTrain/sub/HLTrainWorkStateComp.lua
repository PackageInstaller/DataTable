local var_0_0 = {
	NULL = 0,
	MOBILITY_EMPTY = 2,
	WORKING = 1
}
local var_0_1 = g.core.model.User
local HLTrainWorkStateComp = class("HLTrainWorkStateComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainWorkStateComp"))

function HLTrainWorkStateComp:ctor()
	self._placeCompArr = {
		self.m_placeComp_1,
		self.m_placeComp_2,
		self.m_placeComp_3
	}
end

function HLTrainWorkStateComp:updateComp(arg_2_1)
	local var_2_0 = self:_getWorkState((var_0_1.hlTrainData:getRoomStruct(arg_2_1)))

	self.m_workStateController:setSelectedIndex(var_2_0)
	self.m_workingEffDad:removeAllEffect()

	if var_2_0 == var_0_0.WORKING then
		self.m_workingEffDad:addEffectSpine({
			isLoop = true,
			name = "eff_ui_homelandtrain_working",
			scale = 1
		})
	end
end

function HLTrainWorkStateComp:_getWorkState(arg_3_1)
	if arg_3_1:isWorking() then
		return var_0_0.WORKING
	elseif #arg_3_1.knightIdArr > 0 then
		return var_0_0.MOBILITY_EMPTY
	else
		return var_0_0.NULL
	end
end

return HLTrainWorkStateComp
