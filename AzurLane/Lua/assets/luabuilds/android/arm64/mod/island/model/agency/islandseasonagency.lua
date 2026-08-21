local var_0_0 = class("IslandSeasonAgency", import(".IslandBaseAgency"))

var_0_0.ADD_PT = "IslandSeasonAgency.ADD_PT"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.season = IslandSeason.New(arg_1_1.season)
	arg_1_0.reviews = {}

	local var_1_0 = arg_1_1.season_review_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.reviews[iter_1_1.id] = IslandSeasonReview.New(iter_1_1)
	end

	return
end

function var_0_0.NeedReset(arg_2_0)
	return arg_2_0.season.id < var_0_0.GetCurrentSeason() and arg_2_0.season:IsEnd()
end

function var_0_0.Reset(arg_3_0, arg_3_1)
	arg_3_0.season = IslandSeason.New({
		id = var_0_0.GetCurrentSeason()
	})

	if arg_3_1 then
		arg_3_0.reviews[arg_3_1.id] = arg_3_1
	end

	return
end

function var_0_0.IsShowResetTip(arg_4_0)
	return arg_4_0.season:NeedTip()
end

function var_0_0.SetResetTipFlag(arg_5_0, arg_5_1)
	arg_5_0.season:SetTipFlag(arg_5_1)

	return
end

function var_0_0.GetSeason(arg_6_0)
	return arg_6_0.season
end

function var_0_0.AddPt(arg_7_0, arg_7_1)
	arg_7_0.season:AddPt(arg_7_1)
	arg_7_0:DispatchEvent(var_0_0.ADD_PT)

	return
end

function var_0_0.GetReviewData(arg_8_0, arg_8_1)
	return arg_8_0.reviews[arg_8_1]
end

function var_0_0.GetHighestRank(arg_9_0)
	local var_9_0 = math.huge

	for iter_9_0, iter_9_1 in pairs(arg_9_0.reviews) do
		local var_9_1 = iter_9_1:GetRecordData(IslandSeasonReview.KEYS.PT_RANK)

		if var_9_1 < var_9_0 then
			var_9_0 = var_9_1
		end
	end

	return var_9_0
end

function var_0_0.GetSeasonNum(arg_10_0)
	return #underscore.keys(arg_10_0.reviews) + (arg_10_0.season:GetPt() > 0 and 1 or 0)
end

function var_0_0.IsCurSeasonPtZero(arg_11_0)
	return arg_11_0.season:GetPt() == 0
end

function var_0_0.GetCurrentSeason()
	return pg.island_set.season_now.key_value_int
end

var_0_0.seasonResetData = nil

function var_0_0.AddResetData(arg_13_0)
	var_0_0.seasonResetData = {
		awards = arg_13_0.awards,
		pt = arg_13_0.pt,
		seasonId = arg_13_0.seasonId,
		rank = arg_13_0.rank
	}

	return
end

function var_0_0.CheckReset()
	if var_0_0.seasonResetData then
		var_0_0.seasonResetData = nil

		return true, (Clone(var_0_0.seasonResetData))
	else
		return false, nil
	end

	return
end

return var_0_0
