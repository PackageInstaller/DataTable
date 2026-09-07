local IslandBuffHelper = class("IslandBuffHelper")

function IslandBuffHelper:GetAllBuffsByType(arg_1_1)
	return table.mergeArray(IslandBuffHelper.GetShipBuffsByType(self, arg_1_1), IslandBuffHelper.GetGlobalBuffsByType(arg_1_1))
end

function IslandBuffHelper:GetShipBuffsByType(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1:GetSkill():GetUnlockShipEffectIds()) do
			if pg.island_buff_template[iter_2_3].buff_type == arg_2_1 then
				table.insert(var_2_0, IslandShipStatus.New({
					isSkill = true,
					id = iter_2_3
				}))
			end
		end

		var_2_0 = table.mergeArray(var_2_0, iter_2_1:GetVaildStatusByType(arg_2_1))
	end

	return var_2_0
end

function IslandBuffHelper:GetGlobalBuffsByType()
	return getProxy(IslandProxy):GetIsland():GetGlobalBuffAgency():GetBuffsByType(self)
end

function IslandBuffHelper:GetAllShipManageBuffs(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs({
		IslandBuffType.SHIP_MANAGE_SELL_PRICE,
		IslandBuffType.SHIP_MANAGE_SELL_NUM
	}) do
		var_4_0 = table.mergeArray(var_4_0, (underscore.select(IslandBuffHelper.GetShipBuffsByType({
			self
		}, iter_4_1), function(arg_5_0)
			return table.contains(arg_5_0:GetBuffEffect()[1], arg_4_1)
		end)))
	end

	return var_4_0
end

function IslandBuffHelper:GetManageSellPriceBuffs(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs({
		IslandBuffType.SHIP_MANAGE_SELL_PRICE,
		IslandBuffType.GLOBAL_MANAGE_SELL_PRICE
	}) do
		var_6_0 = table.mergeArray(var_6_0, (underscore.select(IslandBuffHelper.GetAllBuffsByType(self, iter_6_1), function(arg_7_0)
			return table.contains(arg_7_0:GetBuffEffect()[1], arg_6_1)
		end)))
	end

	return var_6_0
end

function IslandBuffHelper:GetManageSellNumBuffs(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs({
		IslandBuffType.SHIP_MANAGE_SELL_NUM,
		IslandBuffType.GLOBAL_MANAGE_SELL_NUM
	}) do
		var_8_0 = table.mergeArray(var_8_0, (underscore.select(IslandBuffHelper.GetAllBuffsByType(self, iter_8_1), function(arg_9_0)
			return table.contains(arg_9_0:GetBuffEffect()[1], arg_8_1)
		end)))
	end

	return var_8_0
end

function IslandBuffHelper:GetManageStatus(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs({
		IslandBuffType.SHIP_MANAGE_SELL_PRICE,
		IslandBuffType.SHIP_MANAGE_SELL_NUM
	}) do
		for iter_10_2, iter_10_3 in ipairs(self) do
			var_10_0 = table.mergeArray(var_10_0, (underscore.select(iter_10_3:GetVaildStatusByType(iter_10_1), function(arg_11_0)
				return table.contains(arg_11_0:GetBuffEffect()[1], arg_10_1)
			end)))
		end
	end

	return var_10_0
end

return IslandBuffHelper
