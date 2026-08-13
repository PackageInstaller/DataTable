class = var_0_10000

local var_0_0 = var_0_10000("MallUtil")

var_0_0.FLOOR_RANK = {
	CLOSE = 4,
	S = 1,
	A = 2,
	B = 3
}

local var_0_1 = {}
local var_0_2 = var_0_0.FLOOR_RANK.S

i18n = var_0_10003
var_0_1[var_0_2] = var_0_10003("mall_rank_s")

local var_0_3 = var_0_0.FLOOR_RANK.A

i18n = var_3
var_0_1[var_0_3] = var_3("mall_rank_a")

local var_0_4 = var_0_0.FLOOR_RANK.B

i18n = var_3
var_0_1[var_0_4] = var_3("mall_rank_b")

local var_0_5 = var_0_0.FLOOR_RANK.CLOSE

i18n = var_3
var_0_1[var_0_5] = var_3("mall_rank_close")
var_0_0.RANK2NAME = var_0_1

function var_0_0.GetFloorRank(arg_1_0, arg_1_1)
	if arg_1_0 / arg_1_1 <= 0 then
		return var_0_0.FLOOR_RANK.CLOSE
	end

	if var_2 >= 1.5 then
		return var_0_0.FLOOR_RANK.S
	end

	if var_2 >= 1 and var_2 < 1.5 then
		return var_0_0.FLOOR_RANK.A
	end

	return var_0_0.FLOOR_RANK.B
end

function var_0_0.GetFloorFactor(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.gameset.activity_mall_profit_factor.description

	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(var_2_0) do
		if arg_2_0 == var_2_0[1] then
			return iter_2_1[2]
		end
	end

	return var_2_0[#var_2_0][2]
end

return var_0_0
