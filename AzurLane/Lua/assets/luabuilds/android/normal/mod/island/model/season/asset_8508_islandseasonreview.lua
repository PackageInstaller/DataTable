class = var_0_10000

local var_0_0 = "IslandSeasonReview"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.KEYS = {
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

local var_0_2 = {}
local var_0_3 = var_0_1.KEYS.LEVEL

i18n = var_3
var_0_2[var_0_3] = var_3("island_season_charts_level")

local var_0_4 = var_0_1.KEYS.SHIP

i18n = var_3
var_0_2[var_0_4] = var_3("island_season_review_charnum")

local var_0_5 = var_0_1.KEYS.TECHNOLOGY

i18n = var_3
var_0_2[var_0_5] = var_3("island_season_review_projuctnum")

local var_0_6 = var_0_1.KEYS.PT

i18n = var_3
var_0_2[var_0_6] = var_3("island_season_review_ptnum")

local var_0_7 = var_0_1.KEYS.PT_RANK

i18n = var_3
var_0_2[var_0_7] = var_3("island_season_review_ptrank")

local var_0_8 = var_0_1.KEYS.ORDER

i18n = var_3
var_0_2[var_0_8] = var_3("island_season_review_ordernum")

local var_0_9 = var_0_1.KEYS.FORMULA

i18n = var_3
var_0_2[var_0_9] = var_3("island_season_review_formulanum")

local var_0_10 = var_0_1.KEYS.FISHING

i18n = var_3
var_0_2[var_0_10] = var_3("island_season_review_fishnum")

local var_0_11 = var_0_1.KEYS.MINIGAME

i18n = var_3
var_0_2[var_0_11] = var_3("island_season_review_gamenum")
var_0_1.KEY2NAME = var_0_2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.data = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.count_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		arg_1_0.data[iter_1_1.key] = iter_1_1.value
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_season
end

function var_0_1.GetRecordData(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0.data[arg_3_1] then
		var_3_0 = 0
	end

	return var_3_0
end

return var_0_1
