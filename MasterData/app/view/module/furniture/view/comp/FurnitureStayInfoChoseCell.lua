local var_0_0 = {
	NO_CHECK_IN = 1,
	LOCKED = 2,
	CHECK_IN = 0
}
local var_0_1 = g.core.model.User
local FurnitureStayInfoChoseCell = class("FurnitureStayInfoChoseCell", require("app.fairyGUI.furniture.UI_FurnitureStayInfoChoseCell"))

function FurnitureStayInfoChoseCell:updateCell(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0

	if var_0_1.furnitureData:getCheckInCountLimit(arg_1_2) < arg_1_1 then
		var_1_0 = var_0_0.LOCKED

		self.m_unLockLvTxt:setText(g.core.lang:get(112510, {
			level = var_0_1.furnitureData:getUnlockLevelByCount(arg_1_2, arg_1_1)
		}))
	elseif arg_1_3 and arg_1_3 > 0 then
		var_1_0 = var_0_0.CHECK_IN

		self.m_knightIcon:updateIcon({
			sid = arg_1_3
		})
		self.m_knightIcon:setAdvanceLevel(0)
		self:_updateCircleBar(arg_1_3)
	else
		var_1_0 = var_0_0.NO_CHECK_IN
	end

	self.m_stateController:setSelectedIndex(var_1_0)
end

function FurnitureStayInfoChoseCell:_updateCircleBar(arg_2_1)
	local var_2_0 = var_0_1.knightsData:getKnightById(arg_2_1)

	self.m_mobilityCircleBarComp:setCurMax(var_2_0:getMobilityVal(), (var_2_0:getMaxMobility()))
end

return FurnitureStayInfoChoseCell
