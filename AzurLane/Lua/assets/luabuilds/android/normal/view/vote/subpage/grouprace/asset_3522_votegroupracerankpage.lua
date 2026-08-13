class = var_0_10000

local var_0_0 = "VoteGroupRaceRankPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GroupRaceRank"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.cards = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.title1 = var_1.Find(var_2_0, "stages/title1")

	local var_2_1 = arg_2_0._tf

	arg_2_0.title2 = var_1.Find(var_2_1, "stages/title2")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_3, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_4 = arg_2_0.scrollRect

	function var_2_4.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	setText = var_2_4

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "titles/rank_title")

	i18n = var_2_5

	var_2_4(var_2_6, var_2_5("vote_label_rank"))

	setText = var_2_4

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "titles/votes")

	i18n = var_2_7

	var_2_4(var_2_8, var_2_7("word_votes"))

	setText = var_2_4

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "tip")

	i18n = var_2_9

	var_2_4(var_2_10, var_2_9("vote_label_rank_fresh_time_tip"))

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	arg_5_0.voteGroup = arg_5_1
	arg_5_0.phase = arg_5_1:GetStage()
	setActive = var_2

	local var_5_0 = arg_5_0.title1
	local var_5_1 = arg_5_0.phase

	VoteGroup = var_1_10005

	var_2(var_5_0, var_5_1 == var_1_10005.VOTE_STAGE)

	setActive = var_2

	local var_5_2 = arg_5_0.title2
	local var_5_3 = arg_5_0.phase

	VoteGroup = var_5

	var_2(var_5_2, var_5_3 ~= var_5.VOTE_STAGE)

	setActive = var_2

	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_3.Find(var_5_4, "tip")
	local var_5_6 = arg_5_0.phase

	VoteGroup = var_5

	var_2(var_5_5, var_5_6 == var_5.VOTE_STAGE)
	arg_5_0:UpdateList()

	return
end

function var_0_1.UpdateList(arg_6_0)
	local var_6_0 = arg_6_0.voteGroup

	arg_6_0.displays = var_1.GetRankList(var_6_0)

	local var_6_1 = arg_6_0.scrollRect

	var_1.SetTotalCount(var_6_1, #arg_6_0.displays)

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:NewCard(arg_7_1)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.cards[arg_8_2]
	local var_8_1 = arg_8_0.displays[arg_8_1 + 1]
	local var_8_2 = arg_8_0.voteGroup
	local var_8_3 = var_5.GetVotes(var_8_2, var_8_1)
	local var_8_4 = arg_8_1 + 1
	local var_8_5 = arg_8_0.voteGroup
	local var_8_6 = var_7.GetRiseColor(var_8_5, var_8_4)

	var_8_0.Update(var_8_1, var_8_4, var_8_3, var_8_6)

	return
end

function var_0_1.NewCard(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.transform

	return {
		Update = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
			setText = var_2_10004

			local var_10_0 = var_9_0
			local var_10_1 = var_5.Find(var_10_0, "number")

			setColorStr = var_10_0

			var_2_10004(var_10_1, var_10_0(arg_10_1, arg_10_3))

			setText = var_2_10004

			local var_10_2 = var_9_0
			local var_10_3 = var_5.Find(var_10_2, "name")

			setColorStr = var_10_2
			shortenString = var_7

			var_2_10004(var_10_3, var_10_2(var_7(arg_10_0:getShipName(), 6), arg_10_3))

			setText = var_2_10004

			local var_10_4 = var_9_0
			local var_10_5 = var_5.Find(var_10_4, "Text")

			setColorStr = var_10_4

			var_2_10004(var_10_5, var_10_4(arg_10_2, arg_10_3))

			return
		end
	}
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
