local var_0_0 = 0
local var_0_1 = {
	LOCKED = 2,
	CHOSE = 1,
	CAN_CHOOSE = 0
}
local var_0_2 = g.core.model.User
local HLTrainWorkChoseKnightComp = class("HLTrainWorkChoseKnightComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainWorkChoseKnightComp"))

function HLTrainWorkChoseKnightComp:ctor()
	self._index = 1
	self._knightId = 0
end

function HLTrainWorkChoseKnightComp:updateComp(arg_2_1, arg_2_2)
	if arg_2_1 then
		self._knightId = var_0_0

		self.m_stateController:setSelectedIndex(var_0_1.LOCKED)
	elseif arg_2_2 then
		self._knightId = arg_2_2

		local var_2_0 = var_0_2.knightsData:getKnightById(arg_2_2)

		self.m_actionCircleBar:setCurMax(var_2_0:getMobilityVal(), (var_2_0:getMaxMobility()))
		self.m_knightIcon:updateIcon({
			scaleIndex = 2,
			struct = var_2_0
		})
		self.m_knightIcon:setAdvanceLevel(0)
		self.m_percentageAddTxt:setText(g.core.lang:get(111048, {
			num = math.ceil(var_2_0:getHomeLandTalent() / 10)
		}))
		self.m_stateController:setSelectedIndex(var_0_1.CHOSE)
	else
		self._knightId = var_0_0

		self.m_stateController:setSelectedIndex(var_0_1.CAN_CHOOSE)
	end
end

function HLTrainWorkChoseKnightComp:getIndex()
	return self._index
end

function HLTrainWorkChoseKnightComp:setIndex(arg_4_1)
	self._index = arg_4_1
end

function HLTrainWorkChoseKnightComp:isEmpty()
	return self._knightId == var_0_0
end

function HLTrainWorkChoseKnightComp:getKnightId()
	return self._knightId
end

return HLTrainWorkChoseKnightComp
