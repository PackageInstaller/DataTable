local var_0_0 = {
	LOCKED = 2,
	NO_CHECK_IN = 1,
	CHECK_IN = 0
}
local var_0_1 = g.core.model.User.furnitureData
local var_0_2 = g.core.model.User
local var_0_3 = g.core.common.Path
local FurnitureDistKnightIcon = class("FurnitureDistKnightIcon", require("app.fairyGUI.furniture.UI_FurnitureDistKnightIcon"))

function FurnitureDistKnightIcon:updateCell(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1:getUnlockLevelByCount(arg_1_2, arg_1_1)
	local var_1_1

	if var_0_1:getCheckInCountLimit(arg_1_2) < arg_1_1 then
		var_1_1 = var_0_0.LOCKED
	elseif arg_1_3 and arg_1_3 > 0 then
		var_1_1 = var_0_0.CHECK_IN

		self:_updateKnight(arg_1_3)
	else
		var_1_1 = var_0_0.NO_CHECK_IN
	end

	self.m_stateController:setSelectedIndex(var_1_1)
	self.m_unLockLvTxt:setText(g.core.lang:get(112510, {
		level = var_1_0
	}))
end

function FurnitureDistKnightIcon:_updateKnight(arg_2_1)
	local var_2_0 = var_0_2.knightsData:getKnightById(arg_2_1)

	self.m_iconLoader:setURL(var_0_3:getKnightIconById(var_2_0:getResInfo().icon_id), true)
	self.m_mobilityCircleBarComp:setCurMax(var_2_0:getMobilityVal(), (var_2_0:getMaxMobility()))
end

return FurnitureDistKnightIcon
