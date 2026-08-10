local var_0_0 = {}
local var_0_1 = {
	Exit = 2,
	Global = 1,
	Normal = 0
}

local function var_0_2(arg_1_0)
	return function(arg_2_0)
		if arg_2_0.traitType == var_0_1.Global then
			return arg_1_0(arg_2_0)
		end
	end
end

local function var_0_3(arg_3_0)
	return function(arg_4_0)
		if arg_4_0.traitType == var_0_1.Normal then
			return arg_3_0(arg_4_0)
		end
	end
end

local function var_0_4(arg_5_0)
	return function(arg_6_0)
		if arg_6_0.traitType == var_0_1.Exit then
			return arg_5_0(arg_6_0)
		end
	end
end

local var_0_5 = {
	[0] = function()
		return 0
	end,
	var_0_3(function(arg_8_0)
		local var_8_0 = arg_8_0.goods
		local var_8_1 = arg_8_0.args
		local var_8_2 = var_8_1[1] or {}
		local var_8_3 = var_8_1[2] or 0

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			if iter_8_1 == var_8_0 then
				return var_8_3
			end
		end
	end),
	var_0_2(function(arg_9_0)
		local var_9_0 = arg_9_0.args[1]

		if arg_9_0.goodsCfg and arg_9_0.goodsCfg.type == var_9_0 then
			local var_9_1 = arg_9_0.args[2] or 0
			local var_9_2 = arg_9_0.args[3] or 0

			if SimBusinessTools.GetSellGoodsTypeCntInCatagory(arg_9_0.goodsCfg.type) == 1 then
				return var_9_1
			else
				return -var_9_2
			end
		end
	end),
	var_0_3(function(arg_10_0)
		local var_10_0 = arg_10_0.customerData
		local var_10_1
		local var_10_2 = var_10_0.lastPick

		var_10_0.lastPick = arg_10_0.goods

		if var_10_2 == arg_10_0.goods then
			var_10_0.samePick = (var_10_0.samePick or 0) + 1

			if var_10_0.samePick > 1 then
				return arg_10_0.args[1] * (var_10_0.samePick - 1)
			end
		else
			var_10_0.samePick = 1
		end
	end),
	var_0_2(function(arg_11_0)
		local var_11_0 = SimBusinessTools.GetEachCatagoryGoodsShelfCnt()
		local var_11_1 = arg_11_0.args
		local var_11_2 = {}

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			table.insert(var_11_2, iter_11_1)
		end

		local var_11_3 = math.max(unpack(var_11_2))

		if var_11_1[1] ~= 0 and arg_11_0.goodsCfg and var_11_1[1] == arg_11_0.goodsCfg.type then
			if var_11_0[arg_11_0.goodsCfg.type] == var_11_3 then
				return var_11_1[2] or 0
			else
				return -var_11_1[3] or 0
			end
		end
	end),
	var_0_3(function(arg_12_0)
		return
	end),
	var_0_2(function(arg_13_0)
		local var_13_0 = arg_13_0.args[1] or 0
		local var_13_1 = arg_13_0.args[2]
		local var_13_2 = arg_13_0.args[3] or 0
		local var_13_3 = arg_13_0.args[4] or 0

		if arg_13_0.goodsCfg and arg_13_0.goodsCfg.type == var_13_1 then
			if var_13_0 < SimBusinessTools.GetPreviewPathLength() then
				return var_13_2
			else
				return var_13_3
			end
		end
	end),
	var_0_3(function(arg_14_0)
		return
	end),
	(var_0_2(function(arg_15_0)
		if arg_15_0.goodsCfg then
			if arg_15_0.goodsCfg.type == arg_15_0.args[1] then
				return arg_15_0.args[2] or 0
			else
				return arg_15_0.args[3] or 0
			end
		end
	end))
}

local function var_0_6(arg_16_0)
	return function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = SimBusinessGuestCfg[arg_17_0].special_effect
		local var_17_1 = var_0_5[var_17_0]

		if var_17_1 then
			local var_17_2 = DormUtils.GetEntityData(arg_17_1)
			local var_17_3 = DormUtils.GetEntityData(arg_17_2)
			local var_17_4 = nullable(SimBusinessGoodsCfg, arg_17_3)

			return var_17_1({
				traitType = arg_16_0,
				customer = arg_17_1,
				shelf = arg_17_2,
				customerData = var_17_2,
				shelfData = var_17_3,
				customerCfgID = var_17_2.cfgID,
				shelfCfgID = var_17_3.cfgID,
				goods = arg_17_3,
				goodsCfg = var_17_4,
				args = SimBusinessGuestCfg[arg_17_0].special_effect_args or {}
			}) or 0
		end

		Debug.LogWarning(string.format("Unknown guest trait %s", var_17_0))

		return 0
	end
end

var_0_0.ApplyNormalTrait = var_0_6(var_0_1.Normal)
var_0_0.ApplyGlobalTrait = var_0_6(var_0_1.Global)
var_0_0.ApplyExitTrait = var_0_6(var_0_1.Exit)

return var_0_0
