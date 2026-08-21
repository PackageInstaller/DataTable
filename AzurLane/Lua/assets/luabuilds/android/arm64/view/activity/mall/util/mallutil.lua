local var_0_0 = class("MallUtil")

var_0_0.FLOOR_RANK = {
	CLOSE = 4,
	S = 1,
	A = 2,
	B = 3
}
var_0_0.RANK2NAME = {
	[var_0_0.FLOOR_RANK.S] = i18n("mall_rank_s"),
	[var_0_0.FLOOR_RANK.A] = i18n("mall_rank_a"),
	[var_0_0.FLOOR_RANK.B] = i18n("mall_rank_b"),
	[var_0_0.FLOOR_RANK.CLOSE] = i18n("mall_rank_close")
}

function var_0_0.GetFloorRank(arg_1_0, arg_1_1)
	if arg_1_0 / arg_1_1 <= 0 then
		return var_0_0.FLOOR_RANK.CLOSE
	end

	if arg_1_0 / arg_1_1 >= 1.5 then
		return var_0_0.FLOOR_RANK.S
	end

	if arg_1_0 / arg_1_1 >= 1 and arg_1_0 / arg_1_1 < 1.5 then
		return var_0_0.FLOOR_RANK.A
	end

	return var_0_0.FLOOR_RANK.B
end

function var_0_0.GetFloorFactor(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(pg.gameset.activity_mall_profit_factor.description) do
		if arg_2_0 == pg.gameset.activity_mall_profit_factor.description[1] then
			return iter_2_1[2]
		end
	end

	return pg.gameset.activity_mall_profit_factor.description[#pg.gameset.activity_mall_profit_factor.description][2]
end

return var_0_0
