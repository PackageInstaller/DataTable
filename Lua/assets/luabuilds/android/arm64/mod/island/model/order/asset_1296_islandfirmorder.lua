local IslandFirmOrder = class("IslandFirmOrder", import(".IslandOrder"))

IslandFirmOrder.FIRM_ORDER_TYPE_COMMON = 1
IslandFirmOrder.FIRM_ORDER_TYPE_URGENCY = 2
IslandFirmOrder.FIRM_ORDER_TYPE_ACT = 3

function IslandFirmOrder:IsFirm()
	return true
end

function IslandFirmOrder:CanReplace()
	return false
end

function IslandFirmOrder:bindConfigTable()
	return pg.island_order
end

function IslandFirmOrder:IsEmpty()
	return self.showFlag == IslandOrderSlot.SHOW_FLAG_TOMORROW
end

function IslandFirmOrder:GetAwardItemAndExp()
	local var_5_0, var_5_1 = self:GenAwards((self:getConfig("award")))
	local var_5_2 = self:GenPtAwards()

	if var_5_2 then
		table.insert(var_5_0, var_5_2)
	end

	return var_5_0, var_5_1
end

function IslandFirmOrder:GenPtAwards()
	local var_6_0 = self:getConfig("season_pt_num")

	if var_6_0 > 0 then
		return {
			id = 0,
			type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT,
			count = var_6_0 or 0
		}
	end

	return nil
end

function IslandFirmOrder:GetActivityId()
	return self:getConfig("activity_id")
end

function IslandFirmOrder:GetGroupId()
	return self:getConfig("group_id")
end

return IslandFirmOrder
