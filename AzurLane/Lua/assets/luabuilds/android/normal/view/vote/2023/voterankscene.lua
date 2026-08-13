class = var_0_10000

local var_0_0 = "VoteRankScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..VoteScene"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	setActive = var_1

	local var_1_0 = arg_1_0._tf

	var_1(var_2.Find(var_1_0, "blur_panel/adapt/top/title_rank"), true)

	setActive = var_1

	local var_1_1 = arg_1_0._tf

	var_1(var_2.Find(var_1_1, "blur_panel/adapt/top/title"), false)

	setActive = var_1

	local var_1_2 = arg_1_0._tf

	var_1(var_2.Find(var_1_2, "main/right_panel/filter_bg"), false)

	setActive = var_1

	local var_1_3 = arg_1_0._tf

	var_1(var_2.Find(var_1_3, "main/right_panel/title/help"), false)

	setActive = var_1

	local var_1_4 = arg_1_0._tf

	var_1(var_2.Find(var_1_4, "main/right_panel/title/schedule"), false)

	setActive = var_1

	local var_1_5 = arg_1_0._tf

	var_1(var_2.Find(var_1_5, "main/right_panel/title/Text"), false)

	return
end

function var_0_1.GetPageMap(arg_2_0)
	local var_2_0 = {}

	VoteConst = var_1_10002

	local var_2_1 = var_1_10002.RACE_TYPE_PRE
	local var_2_2 = {}

	VotePreRaceShipPage = var_1_10004
	var_2_2[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_2_2[2] = var_1_10004
	var_2_0[var_2_1] = var_2_2
	VoteConst = var_2_1

	local var_2_3 = var_2_1.RACE_TYPE_GROUP
	local var_2_4 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_2_4[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_2_4[2] = var_1_10004
	var_2_0[var_2_3] = var_2_4
	VoteConst = var_2_3

	local var_2_5 = var_2_3.RACE_TYPE_RESURGENCE
	local var_2_6 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_2_6[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_2_6[2] = var_1_10004
	var_2_0[var_2_5] = var_2_6
	VoteConst = var_2_5

	local var_2_7 = var_2_5.RACE_TYPE_FINAL
	local var_2_8 = {}

	VoteFinalsRaceShipsPageForRank = var_1_10004
	var_2_8[1] = var_1_10004
	VoteFinalsRaceRankPage = var_1_10004
	var_2_8[2] = var_1_10004
	var_2_0[var_2_7] = var_2_8
	VoteConst = var_2_7

	local var_2_9 = var_2_7.RACE_TYPE_PRE_RESURGENCE
	local var_2_10 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_2_10[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_2_10[2] = var_1_10004
	var_2_0[var_2_9] = var_2_10
	VoteConst = var_2_9

	local var_2_11 = var_2_9.RACE_TYPE_FUN
	local var_2_12 = {}

	VoteFunRaceShipsPageForRank = var_1_10004
	var_2_12[1] = var_1_10004
	VoteFunRaceRankPage = var_1_10004
	var_2_12[2] = var_1_10004
	var_2_0[var_2_11] = var_2_12

	return var_2_0
end

function var_0_1.initShips(arg_3_0)
	arg_3_0.displays = {}

	local var_3_0 = arg_3_0.contextData.voteGroup
	local var_3_1 = var_1.GetRankList(var_3_0)

	getInputText = var_3_0

	local var_3_2 = var_3_0(arg_3_0.search)

	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(var_3_1) do
		table = var_1_10008

		var_1_10008.insert(arg_3_0.displays, iter_3_1)
	end

	local var_3_3 = arg_3_0:GetVotes()
	local var_3_4 = arg_3_0.shipsPage

	var_4.ExecuteAction(var_3_4, "Update", arg_3_0.contextData.voteGroup, arg_3_0.displays, var_3_3)

	return
end

return var_0_1
