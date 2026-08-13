class = var_0_10000

local var_0_0 = "IslandSeasonAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.ADD_PT = "IslandSeasonAgency.ADD_PT"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	IslandSeason = var_1_10002
	arg_1_0.season = var_1_10002.New(arg_1_1.season)
	arg_1_0.reviews = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.season_review_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		local var_1_1 = arg_1_0.reviews
		local var_1_2 = iter_1_1.id

		IslandSeasonReview = var_1_10009
		var_1_1[var_1_2] = var_1_10009.New(iter_1_1)
	end

	return
end

function var_0_1.NeedReset(arg_2_0)
	local var_2_1

	if arg_2_0.season.id < var_0_1.GetCurrentSeason() then
		local var_2_0 = arg_2_0.season

		var_2_1 = var_1.IsEnd(var_2_0)
	else
		var_2_1 = false
	end

	if false then
		var_2_1 = true
	end

	return var_2_1
end

function var_0_1.Reset(arg_3_0, arg_3_1)
	IslandSeason = var_1_10002
	arg_3_0.season = var_1_10002.New({
		id = var_0_1.GetCurrentSeason()
	})

	if arg_3_1 then
		arg_3_0.reviews[arg_3_1.id] = arg_3_1
	end

	return
end

function var_0_1.IsShowResetTip(arg_4_0)
	local var_4_0 = arg_4_0.season

	return var_1.NeedTip(var_4_0)
end

function var_0_1.SetResetTipFlag(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.season

	var_2.SetTipFlag(var_5_0, arg_5_1)

	return
end

function var_0_1.GetSeason(arg_6_0)
	return arg_6_0.season
end

function var_0_1.AddPt(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.season

	var_2.AddPt(var_7_0, arg_7_1)
	arg_7_0:DispatchEvent(var_0_1.ADD_PT)

	return
end

function var_0_1.GetReviewData(arg_8_0, arg_8_1)
	return arg_8_0.reviews[arg_8_1]
end

function var_0_1.GetHighestRank(arg_9_0)
	math = var_1_10001

	local var_9_0 = var_1_10001.huge

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.reviews) do
		local var_9_1 = iter_9_1
		local var_9_2 = iter_9_1.GetRecordData

		IslandSeasonReview = var_1_10010

		if var_9_2(var_9_1, var_1_10010.KEYS.PT_RANK) < var_9_0 then
			var_9_0 = var_7
		end
	end

	return var_9_0
end

function var_0_1.GetSeasonNum(arg_10_0)
	underscore = var_1_10001

	local var_10_0 = #var_1_10001.keys(arg_10_0.reviews)
	local var_10_1 = arg_10_0.season

	return var_10_0 + (var_2.GetPt(var_10_1) > 0 and 1 or 0)
end

function var_0_1.IsCurSeasonPtZero(arg_11_0)
	local var_11_0 = arg_11_0.season

	return var_1.GetPt(var_11_0) == 0
end

function var_0_1.GetCurrentSeason()
	pg = var_1_10000

	return var_1_10000.island_set.season_now.key_value_int
end

var_0_1.seasonResetData = nil

function var_0_1.AddResetData(arg_13_0)
	var_0_1.seasonResetData = {
		awards = arg_13_0.awards,
		pt = arg_13_0.pt,
		seasonId = arg_13_0.seasonId,
		rank = arg_13_0.rank
	}

	return
end

function var_0_1.CheckReset()
	if var_0_1.seasonResetData then
		Clone = var_0

		local var_14_0 = var_0(var_0_1.seasonResetData)

		var_0_1.seasonResetData = nil

		return true, var_14_0
	else
		return false, nil
	end

	return
end

return var_0_1
