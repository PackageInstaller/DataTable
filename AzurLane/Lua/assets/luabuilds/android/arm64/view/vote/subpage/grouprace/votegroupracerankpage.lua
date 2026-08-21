local var_0_0 = class("VoteGroupRaceRankPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GroupRaceRank"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.cards = {}
	arg_2_0.title1 = arg_2_0._tf:Find("stages/title1")
	arg_2_0.title2 = arg_2_0._tf:Find("stages/title2")
	arg_2_0.scrollRect = arg_2_0._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(arg_2_0._tf:Find("titles/rank_title"), i18n("vote_label_rank"))
	setText(arg_2_0._tf:Find("titles/votes"), i18n("word_votes"))
	setText(arg_2_0._tf:Find("tip"), i18n("vote_label_rank_fresh_time_tip"))

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	arg_5_0.voteGroup = arg_5_1
	arg_5_0.phase = arg_5_1:GetStage()

	setActive(arg_5_0.title1, arg_5_0.phase == VoteGroup.VOTE_STAGE)
	setActive(arg_5_0.title2, arg_5_0.phase ~= VoteGroup.VOTE_STAGE)
	setActive(arg_5_0._tf:Find("tip"), arg_5_0.phase == VoteGroup.VOTE_STAGE)
	arg_5_0:UpdateList()

	return
end

function var_0_0.UpdateList(arg_6_0)
	arg_6_0.displays = arg_6_0.voteGroup:GetRankList()

	arg_6_0.scrollRect:SetTotalCount(#arg_6_0.displays)

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	arg_7_0.cards[arg_7_1] = arg_7_0:NewCard(arg_7_1)

	return
end

function var_0_0.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.cards[arg_8_2].Update(arg_8_0.displays[arg_8_1 + 1], arg_8_1 + 1, arg_8_0.voteGroup:GetVotes(arg_8_0.displays[arg_8_1 + 1]), (arg_8_0.voteGroup:GetRiseColor(arg_8_1 + 1)))

	return
end

function var_0_0.NewCard(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.transform

	return {
		Update = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
			setText(var_9_0:Find("number"), setColorStr(arg_10_1, arg_10_3))
			setText(var_9_0:Find("name"), setColorStr(shortenString(arg_10_0:getShipName(), 6), arg_10_3))
			setText(var_9_0:Find("Text"), setColorStr(arg_10_2, arg_10_3))

			return
		end
	}
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
