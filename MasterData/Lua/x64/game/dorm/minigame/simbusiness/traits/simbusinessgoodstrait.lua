local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = SimBusinessTools.GetShelfOverrideLevel(arg_1_0)

	return var_1_0 or SimBusinessData:GetShelfLevel(arg_1_0), var_1_0 ~= nil
end

local var_0_2 = {
	[0] = function()
		return 0
	end,
	function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		if (arg_3_3[1] or 0) >= SimBusinessTools.GetSellGoodsShelfCnt(arg_3_2) then
			return arg_3_3[2] or 0
		end
	end,
	function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if (arg_4_3[1] or 0) <= SimBusinessTools.GetSellGoodsShelfCnt(arg_4_2) then
			return arg_4_3[2] or 0
		end
	end,
	function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		if SimBusinessShelfCfg[arg_5_1].sell_direction == 2 or SimBusinessShelfCfg[arg_5_1].sell_direction == 3 then
			return arg_5_3[1] or 0
		end
	end,
	function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if (arg_6_3[1] or 0) <= var_0_1(arg_6_1) then
			return arg_6_3[2] or 0
		end
	end,
	function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		if (arg_7_3[1] or 0) >= var_0_1(arg_7_1) then
			return arg_7_3[2] or 0
		end
	end,
	function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		return math.min(math.floor(SimBusinessTools.GetShelfTotalLevel() / (arg_8_3[1] or 1)) * (arg_8_3[2] or 0), arg_8_3[3] or math.huge)
	end,
	function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		if (arg_9_3[1] or 0) < SimBusinessTools.GetShelfTotalCnt() then
			return arg_9_3[2] or 0
		end
	end,
	function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		if arg_10_0 == nil or nullable(SimBusinessGuestCfg, arg_10_0, "love_type") == SimBusinessGoodsCfg[arg_10_2].type then
			return 0
		else
			return -2 * (SimBusinessGoodsCfg[arg_10_2].sell_ability_addition or 0)
		end
	end,
	function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		return math.min(math.floor(SimBusinessTools.GetShelfTotalCnt() / (arg_11_3[1] or 1)) * (arg_11_3[2] or 0), arg_11_3[3] or math.huge)
	end,
	function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		if (arg_12_3[1] or 0) < SimBusinessTools.GetPreviewPathLength() then
			return arg_12_3[2] or 0
		end
	end,
	function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		return math.min(math.floor(SimBusinessTools.GetPreviewPathLength() / (arg_13_3[1] or 1)) * (arg_13_3[2] or 0), arg_13_3[3] or math.huge)
	end
}
local var_0_3 = {
	[8] = function(arg_14_0)
		return {
			[arg_14_0[1]] = true
		}
	end
}

function var_0_0.Apply(arg_15_0, arg_15_1, arg_15_2)
	if var_0_2[nullable(SimBusinessGoodsCfg[arg_15_0], "special_effect") or 0] then
		return var_0_2[nullable(SimBusinessGoodsCfg[arg_15_0], "special_effect") or 0](arg_15_1, arg_15_2, arg_15_0, (nullable(SimBusinessGoodsCfg[arg_15_0], "special_effect_args"))) or 0
	end

	Debug.LogWarning(string.format("Unknown goods trait %s", arg_15_0))

	return 0
end

function var_0_0.GoodsTraitAffectPreference(arg_16_0, arg_16_1)
	local var_16_0 = nullable(var_0_3, (nullable(SimBusinessGoodsCfg, arg_16_0, "special_effect")))

	if var_16_0 then
		return nullable(var_16_0((nullable(SimBusinessGoodsCfg, arg_16_0, "special_effect_args"))), arg_16_1)
	end
end

return var_0_0
