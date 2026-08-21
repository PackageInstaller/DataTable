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
		local var_3_0 = arg_3_3[1] or 0
		local var_3_1 = arg_3_3[2] or 0

		if var_3_0 >= SimBusinessTools.GetSellGoodsShelfCnt(arg_3_2) then
			return var_3_1
		end
	end,
	function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_4_3[1] or 0
		local var_4_1 = arg_4_3[2] or 0

		if var_4_0 <= SimBusinessTools.GetSellGoodsShelfCnt(arg_4_2) then
			return var_4_1
		end
	end,
	function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_5_3[1] or 0
		local var_5_1 = SimBusinessShelfCfg[arg_5_1].sell_direction

		if var_5_1 == 2 or var_5_1 == 3 then
			return var_5_0
		end
	end,
	function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_6_3[1] or 0
		local var_6_1 = arg_6_3[2] or 0

		if var_6_0 <= var_0_1(arg_6_1) then
			return var_6_1
		end
	end,
	function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = arg_7_3[1] or 0
		local var_7_1 = arg_7_3[2] or 0

		if var_7_0 >= var_0_1(arg_7_1) then
			return var_7_1
		end
	end,
	function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = SimBusinessTools.GetShelfTotalLevel()
		local var_8_1 = arg_8_3[1] or 1
		local var_8_2 = math.floor(var_8_0 / var_8_1)
		local var_8_3 = arg_8_3[2] or 0
		local var_8_4 = arg_8_3[3] or math.huge

		return math.min(var_8_2 * var_8_3, var_8_4)
	end,
	function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		local var_9_0 = arg_9_3[1] or 0
		local var_9_1 = arg_9_3[2] or 0

		if var_9_0 < SimBusinessTools.GetShelfTotalCnt() then
			return var_9_1
		end
	end,
	function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = SimBusinessGoodsCfg[arg_10_2]

		if arg_10_0 == nil or nullable(SimBusinessGuestCfg, arg_10_0, "love_type") == var_10_0.type then
			return 0
		else
			return -2 * (var_10_0.sell_ability_addition or 0)
		end
	end,
	function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = SimBusinessTools.GetShelfTotalCnt()
		local var_11_1 = arg_11_3[1] or 1
		local var_11_2 = math.floor(var_11_0 / var_11_1)
		local var_11_3 = arg_11_3[2] or 0
		local var_11_4 = arg_11_3[3] or math.huge

		return math.min(var_11_2 * var_11_3, var_11_4)
	end,
	function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_12_3[1] or 0
		local var_12_1 = arg_12_3[2] or 0

		if var_12_0 < SimBusinessTools.GetPreviewPathLength() then
			return var_12_1
		end
	end,
	function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = SimBusinessTools.GetPreviewPathLength()
		local var_13_1 = arg_13_3[1] or 1
		local var_13_2 = math.floor(var_13_0 / var_13_1)
		local var_13_3 = arg_13_3[2] or 0
		local var_13_4 = arg_13_3[3] or math.huge

		return math.min(var_13_2 * var_13_3, var_13_4)
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
	local var_15_0 = SimBusinessGoodsCfg[arg_15_0]
	local var_15_1 = nullable(var_15_0, "special_effect") or 0
	local var_15_2 = nullable(var_15_0, "special_effect_args")
	local var_15_3 = var_0_2[var_15_1]

	if var_15_3 then
		return var_15_3(arg_15_1, arg_15_2, arg_15_0, var_15_2) or 0
	end

	Debug.LogWarning(string.format("Unknown goods trait %s", arg_15_0))

	return 0
end

function var_0_0.GoodsTraitAffectPreference(arg_16_0, arg_16_1)
	local var_16_0 = nullable(SimBusinessGoodsCfg, arg_16_0, "special_effect")
	local var_16_1 = nullable(SimBusinessGoodsCfg, arg_16_0, "special_effect_args")
	local var_16_2 = nullable(var_0_3, var_16_0)

	if var_16_2 then
		return nullable(var_16_2(var_16_1), arg_16_1)
	end
end

return var_0_0
