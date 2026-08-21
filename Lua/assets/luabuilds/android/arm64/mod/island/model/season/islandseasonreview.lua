local var_0_0 = class("IslandSeasonReview", import("model.vo.BaseVO"))

var_0_0.KEYS = {
	TECHNOLOGY = 3,
	MINIGAME = 9,
	FORMULA = 7,
	PT = 4,
	FISHING = 8,
	ORDER = 6,
	LEVEL = 1,
	SHIP = 2,
	PT_RANK = 5
}
var_0_0.KEY2NAME = {
	[var_0_0.KEYS.LEVEL] = i18n("island_season_charts_level"),
	[var_0_0.KEYS.SHIP] = i18n("island_season_review_charnum"),
	[var_0_0.KEYS.TECHNOLOGY] = i18n("island_season_review_projuctnum"),
	[var_0_0.KEYS.PT] = i18n("island_season_review_ptnum"),
	[var_0_0.KEYS.PT_RANK] = i18n("island_season_review_ptrank"),
	[var_0_0.KEYS.ORDER] = i18n("island_season_review_ordernum"),
	[var_0_0.KEYS.FORMULA] = i18n("island_season_review_formulanum"),
	[var_0_0.KEYS.FISHING] = i18n("island_season_review_fishnum"),
	[var_0_0.KEYS.MINIGAME] = i18n("island_season_review_gamenum")
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.data = {}

	local var_1_0 = arg_1_1.count_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.data[iter_1_1.key] = iter_1_1.value
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_season
end

function var_0_0.GetRecordData(arg_3_0, arg_3_1)
	return arg_3_0.data[arg_3_1] or 0
end

return var_0_0
