local MallUtil = class("MallUtil")

MallUtil.FLOOR_RANK = {
	CLOSE = 4,
	S = 1,
	A = 2,
	B = 3
}
MallUtil.RANK2NAME = {
	[MallUtil.FLOOR_RANK.S] = i18n("mall_rank_s"),
	[MallUtil.FLOOR_RANK.A] = i18n("mall_rank_a"),
	[MallUtil.FLOOR_RANK.B] = i18n("mall_rank_b"),
	[MallUtil.FLOOR_RANK.CLOSE] = i18n("mall_rank_close")
}

function MallUtil:GetFloorRank(arg_1_1)
	if self / arg_1_1 <= 0 then
		return MallUtil.FLOOR_RANK.CLOSE
	end

	if self / arg_1_1 >= 1.5 then
		return MallUtil.FLOOR_RANK.S
	end

	if self / arg_1_1 >= 1 and self / arg_1_1 < 1.5 then
		return MallUtil.FLOOR_RANK.A
	end

	return MallUtil.FLOOR_RANK.B
end

function MallUtil:GetFloorFactor()
	for iter_2_0, iter_2_1 in ipairs(pg.gameset.activity_mall_profit_factor.description) do
		if self == pg.gameset.activity_mall_profit_factor.description[1] then
			return iter_2_1[2]
		end
	end

	return pg.gameset.activity_mall_profit_factor.description[#pg.gameset.activity_mall_profit_factor.description][2]
end

return MallUtil
