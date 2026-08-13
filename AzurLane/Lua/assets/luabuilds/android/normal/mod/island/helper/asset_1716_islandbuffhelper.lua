class = var_0_10000

local var_0_0 = var_0_10000("IslandBuffHelper")

function var_0_0.GetAllBuffsByType(arg_1_0, arg_1_1)
	table = var_1_10002

	return var_1_10002.mergeArray(var_0_0.GetShipBuffsByType(arg_1_0, arg_1_1), var_0_0.GetGlobalBuffsByType(arg_1_1))
end

function var_0_0.GetShipBuffsByType(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0) do
		ipairs = var_1_10008

		local var_2_1 = iter_2_1:GetSkill()

		for iter_2_2, iter_2_3 in var_1_10008(var_9.GetUnlockShipEffectIds(var_2_1)) do
			pg = var_1_10013

			if var_1_10013.island_buff_template[iter_2_3].buff_type == arg_2_1 then
				table = var_1_10013
				var_1_10013 = var_1_10013.insert

				local var_2_2 = var_2_0

				IslandShipStatus = var_1_10015

				var_1_10013(var_2_2, var_1_10015.New({
					isSkill = true,
					id = iter_2_3
				}))
			end
		end

		table = var_1_10008
		var_2_0 = var_1_10008.mergeArray(var_2_0, iter_2_1:GetVaildStatusByType(arg_2_1))
	end

	return var_2_0
end

function var_0_0.GetGlobalBuffsByType(arg_3_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.GetIsland(var_3_0)
	local var_3_2 = var_1.GetGlobalBuffAgency(var_3_1)

	return var_1.GetBuffsByType(var_3_2, arg_3_0)
end

function var_0_0.GetAllShipManageBuffs(arg_4_0, arg_4_1)
	local var_4_0 = {}

	IslandBuffType = var_1_10003
	var_4_0[1] = var_1_10003.SHIP_MANAGE_SELL_PRICE
	IslandBuffType = var_3
	var_4_0[2] = var_3.SHIP_MANAGE_SELL_NUM

	local var_4_1 = {}

	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(var_4_0) do
		underscore = var_1_10009
		var_1_10009 = var_1_10009.select(var_0_0.GetShipBuffsByType({
			arg_4_0
		}, iter_4_1), function(arg_5_0)
			table = var_2_10001

			return var_2_10001.contains(arg_5_0:GetBuffEffect()[1], arg_4_1)
		end)
		table = var_10
		var_4_1 = var_10.mergeArray(var_4_1, var_1_10009)
	end

	return var_4_1
end

function var_0_0.GetManageSellPriceBuffs(arg_6_0, arg_6_1)
	local var_6_0 = {}

	IslandBuffType = var_1_10003
	var_6_0[1] = var_1_10003.SHIP_MANAGE_SELL_PRICE
	IslandBuffType = var_3
	var_6_0[2] = var_3.GLOBAL_MANAGE_SELL_PRICE

	local var_6_1 = {}

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_0) do
		underscore = var_1_10009
		var_1_10009 = var_1_10009.select(var_0_0.GetAllBuffsByType(arg_6_0, iter_6_1), function(arg_7_0)
			table = var_2_10001

			return var_2_10001.contains(arg_7_0:GetBuffEffect()[1], arg_6_1)
		end)
		table = var_10
		var_6_1 = var_10.mergeArray(var_6_1, var_1_10009)
	end

	return var_6_1
end

function var_0_0.GetManageSellNumBuffs(arg_8_0, arg_8_1)
	local var_8_0 = {}

	IslandBuffType = var_1_10003
	var_8_0[1] = var_1_10003.SHIP_MANAGE_SELL_NUM
	IslandBuffType = var_3
	var_8_0[2] = var_3.GLOBAL_MANAGE_SELL_NUM

	local var_8_1 = {}

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(var_8_0) do
		underscore = var_1_10009
		var_1_10009 = var_1_10009.select(var_0_0.GetAllBuffsByType(arg_8_0, iter_8_1), function(arg_9_0)
			table = var_2_10001

			return var_2_10001.contains(arg_9_0:GetBuffEffect()[1], arg_8_1)
		end)
		table = var_10
		var_8_1 = var_10.mergeArray(var_8_1, var_1_10009)
	end

	return var_8_1
end

function var_0_0.GetManageStatus(arg_10_0, arg_10_1)
	local var_10_0 = {}

	IslandBuffType = var_1_10003
	var_10_0[1] = var_1_10003.SHIP_MANAGE_SELL_PRICE
	IslandBuffType = var_3
	var_10_0[2] = var_3.SHIP_MANAGE_SELL_NUM

	local var_10_1 = {}

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(var_10_0) do
		ipairs = var_1_10009

		for iter_10_2, iter_10_3 in var_1_10009(arg_10_0) do
			underscore = var_1_10014
			var_1_10014 = var_1_10014.select(iter_10_3:GetVaildStatusByType(iter_10_1), function(arg_11_0)
				table = var_2_10001

				return var_2_10001.contains(arg_11_0:GetBuffEffect()[1], arg_10_1)
			end)
			table = var_15
			var_10_1 = var_15.mergeArray(var_10_1, var_1_10014)
		end
	end

	return var_10_1
end

return var_0_0
