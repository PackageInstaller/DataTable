local var_0_0 = {
	WORKING = 2,
	CHECK_IN = 1,
	IDLE = 0,
	MOBILITY_0 = 3
}
local var_0_1 = g.core.model.User.hlTrainData
local var_0_2 = g.core.common.Path
local FurnitureStayInfoKnightCell = class("FurnitureStayInfoKnightCell", require("app.fairyGUI.furniture.UI_FurnitureStayInfoKnightCell"))

function FurnitureStayInfoKnightCell:updateCell(arg_1_1, arg_1_2, arg_1_3)
	self.m_picComp:setIcon((var_0_2:getKnightBookPicRes(arg_1_1:getResInfo().painted_id)))
	self.m_qualityLoader:setURL(var_0_2:getCardQualityLine(arg_1_1:getBaseInfo().quality), true)
	self:setChose(arg_1_2)

	local var_1_0 = arg_1_1:getStarLv() or 0

	self.m_starComp:initStar({
		index = 3,
		gap = -7,
		num = var_1_0
	})

	local var_1_1 = self:_getStateCtrlIndex(arg_1_1, arg_1_3)

	self.m_stateController:setSelectedIndex(var_1_1)

	if var_1_1 == var_0_0.WORKING then
		self.m_dispatchRoomNameTxt:setText(var_0_1:getRoomStruct((var_0_1:getDispatchedAdvanceId(arg_1_1:getServerId()))).refCfgBaseInfo.name)
	elseif var_1_1 == var_0_0.CHECK_IN then
		self.m_checkInDormIdTxt:setText((g.core.lang:get(111051, {
			dormId = arg_1_3
		})))
	end

	self:updateMobility(arg_1_1)
end

function FurnitureStayInfoKnightCell:setChose(arg_2_1)
	if arg_2_1 ~= self:_isChose() then
		self.m_choseController:setSelectedIndex(arg_2_1 and 1 or 0)
	end
end

function FurnitureStayInfoKnightCell:_isChose()
	return self.m_choseController:getSelectedIndex() == 1
end

function FurnitureStayInfoKnightCell:_getStateCtrlIndex(arg_4_1, arg_4_2)
	return checkbool(arg_4_2) and var_0_0.CHECK_IN or var_0_1:isKnightDispatched((arg_4_1:getServerId())) and var_0_0.WORKING or arg_4_1:getMobilityVal() <= 0 and var_0_0.MOBILITY_0 or var_0_0.IDLE
end

function FurnitureStayInfoKnightCell:updateMobility(arg_5_1)
	if arg_5_1 then
		local var_5_0 = arg_5_1:getMobilityVal()
		local var_5_1 = arg_5_1:getMaxMobility()

		self.m_mobilityBar:setValue(var_5_0)
		self.m_mobilityBar:setMax(var_5_1)
		self.m_mobilityCircleBarComp:setCurMax(var_5_0, var_5_1)
	end
end

return FurnitureStayInfoKnightCell
