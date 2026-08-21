local var_0_0 = class("VoteRankScene", import("..VoteScene"))

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)
	setActive(arg_1_0._tf:Find("blur_panel/adapt/top/title_rank"), true)
	setActive(arg_1_0._tf:Find("blur_panel/adapt/top/title"), false)
	setActive(arg_1_0._tf:Find("main/right_panel/filter_bg"), false)
	setActive(arg_1_0._tf:Find("main/right_panel/title/help"), false)
	setActive(arg_1_0._tf:Find("main/right_panel/title/schedule"), false)
	setActive(arg_1_0._tf:Find("main/right_panel/title/Text"), false)

	return
end

function var_0_0.GetPageMap(arg_2_0)
	return {
		[VoteConst.RACE_TYPE_PRE] = {
			VotePreRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_GROUP] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FINAL] = {
			VoteFinalsRaceShipsPageForRank,
			VoteFinalsRaceRankPage
		},
		[VoteConst.RACE_TYPE_PRE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FUN] = {
			VoteFunRaceShipsPageForRank,
			VoteFunRaceRankPage
		}
	}
end

function var_0_0.initShips(arg_3_0)
	arg_3_0.displays = {}

	local var_3_0 = getInputText(arg_3_0.search)

	for iter_3_0, iter_3_1 in ipairs((arg_3_0.contextData.voteGroup:GetRankList())) do
		table.insert(arg_3_0.displays, iter_3_1)
	end

	arg_3_0.shipsPage:ExecuteAction("Update", arg_3_0.contextData.voteGroup, arg_3_0.displays, (arg_3_0:GetVotes()))

	return
end

return var_0_0
