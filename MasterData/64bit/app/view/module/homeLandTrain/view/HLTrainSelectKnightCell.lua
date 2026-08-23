local var_0_0 = {
	MOBILITY_0 = 3,
	WORKING = 2,
	CHECK_IN = 1,
	IDLE = 0
}
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.furnitureData
local var_0_3 = g.core.common.Path
local HLTrainSelectKnightCell = class("HLTrainSelectKnightCell", require("app.fairyGUI.homeLandTrain.UI_HLTrainSelectKnightCell"))

function HLTrainSelectKnightCell:ctor()
	self._knightId = nil
end

function HLTrainSelectKnightCell:updateCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._knightId = arg_2_1:getServerId()
	arg_2_4 = arg_2_4 or ""

	self.m_picComp:setIcon((var_0_3:getKnightBookPicRes(arg_2_1:getResInfo().painted_id)))
	self.m_percentageTalentTxt:setText(g.core.lang:get(111048, {
		num = arg_2_1:getHomeLandTalent() / 10
	}))
	self.m_recommendController:setSelectedIndex(arg_2_3 and 1 or 0)
	self.m_qualityLoader:setURL(var_0_3:getCardQualityLine(arg_2_1:getBaseInfo().quality))
	self:setChose(arg_2_2)

	local var_2_0 = arg_2_1:getStarLv() or 0

	self.m_starComp:initStar({
		index = 3,
		gap = -7,
		num = var_2_0
	})

	local var_2_1 = self:_getStateCtrlIndex(arg_2_1, arg_2_4)

	self.m_stateController:setSelectedIndex(var_2_1)

	if var_2_1 == var_0_0.WORKING then
		self.m_dispatchRoomNameTxt:setText(arg_2_4)
	elseif var_2_1 == var_0_0.CHECK_IN then
		self.m_checkInDormIdTxt:setText((g.core.lang:get(111051, {
			dormId = var_0_2:getCheckInDormId(self._knightId)
		})))
	end

	self:updateMobility()
end

function HLTrainSelectKnightCell:updateMobility()
	if self._knightId then
		local var_3_0 = var_0_1.knightsData:getKnightById(self._knightId)
		local var_3_1 = var_3_0:getMobilityVal()
		local var_3_2 = var_3_0:getMaxMobility()

		self.m_mobilityBar:setValue(var_3_1)
		self.m_mobilityBar:setMax(var_3_2)
		self.m_mobilityCircleBarComp:setCurMax(var_3_1, var_3_2)
	end
end

function HLTrainSelectKnightCell:setChose(arg_4_1)
	if arg_4_1 ~= self:_isChose() then
		self.m_choseController:setSelectedIndex(arg_4_1 and 1 or 0)
	end
end

function HLTrainSelectKnightCell:_isChose()
	return self.m_choseController:getSelectedIndex() == 1
end

function HLTrainSelectKnightCell:_getStateCtrlIndex(arg_6_1, arg_6_2)
	return #arg_6_2 > 0 and var_0_0.WORKING or var_0_2:isKnightCheckIn((arg_6_1:getServerId())) and var_0_0.CHECK_IN or arg_6_1:getMobilityVal() <= 0 and var_0_0.MOBILITY_0 or var_0_0.IDLE
end

return HLTrainSelectKnightCell
