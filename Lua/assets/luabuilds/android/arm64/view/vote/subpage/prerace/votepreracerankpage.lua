local var_0_0 = class("VotePreRaceRankPage", import("....base.BaseSubView"))

var_0_0.RANK_DISPLAY_COUNT = 15

function var_0_0.getUIName(arg_1_0)
	return "PreRaceRank"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.uiitemlist = UIItemList.New(arg_2_0._tf:Find("content"), arg_2_0._tf:Find("content/tpl"))
	arg_2_0.prevBtn = arg_2_0._tf:Find("prev")
	arg_2_0.nextBtn = arg_2_0._tf:Find("next")
	arg_2_0.tip = arg_2_0._tf:Find("tip")
	arg_2_0.title1 = arg_2_0._tf:Find("stages/title1")
	arg_2_0.title2 = arg_2_0._tf:Find("stages/title2")
	arg_2_0.rankTitle = arg_2_0._tf:Find("titles/rank_title")

	onButton(arg_2_0, arg_2_0.nextBtn, function()
		local var_3_0 = arg_2_0.page + 1

		if arg_2_0.page + 1 > arg_2_0.maxPage then
			var_3_0 = 1
		end

		arg_2_0.page = var_3_0

		arg_2_0:initRank(arg_2_0.page)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.prevBtn, function()
		local var_4_0 = arg_2_0.page - 1

		if arg_2_0.page - 1 <= 0 then
			var_4_0 = arg_2_0.maxPage
		end

		arg_2_0.page = var_4_0

		arg_2_0:initRank(arg_2_0.page)

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("titles/rank_title"), i18n("vote_label_rank"))
	setText(arg_2_0._tf:Find("tip"), i18n("vote_label_rank_fresh_time_tip"))

	return
end

function var_0_0.initRank(arg_5_0, arg_5_1)
	local var_5_0 = (arg_5_1 - 1) * var_0_0.RANK_DISPLAY_COUNT
	local var_5_1 = arg_5_0.voteShips

	arg_5_0.uiitemlist:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			if var_5_1[var_5_0 + arg_6_1 + 1] then
				arg_5_0:UpdateShipInfo(arg_6_2, var_5_1[var_5_0 + arg_6_1 + 1]:getShipName(), var_5_0 + arg_6_1 + 1)
			end

			setActive(arg_6_2, var_5_1[var_5_0 + arg_6_1 + 1])
		end

		return
	end)
	arg_5_0.uiitemlist:align(var_0_0.RANK_DISPLAY_COUNT)
	arg_5_0:UpdateTitle()

	return
end

function var_0_0.UpdateShipInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.voteGroup:GetRiseColor(arg_7_3)

	setText(arg_7_1:Find("Text"), setColorStr(shortenString(arg_7_2, 9), var_7_0))
	setText(arg_7_1:Find("number"), setColorStr(arg_7_3, var_7_0))

	return
end

function var_0_0.UpdateTitle(arg_8_0)
	local var_8_0 = arg_8_0.voteGroup:getConfig("next_round_number")

	setActive(arg_8_0.rankTitle, true)

	return
end

function var_0_0.Update(arg_9_0, arg_9_1)
	arg_9_0.voteGroup = arg_9_1
	arg_9_0.voteShips = arg_9_1:getList()
	arg_9_0.page = 1
	arg_9_0.maxPage = math.ceil(#arg_9_0.voteShips / var_0_0.RANK_DISPLAY_COUNT)
	arg_9_0.phase = arg_9_1:GetStage()

	setActive(arg_9_0.title1, arg_9_0.phase == VoteGroup.VOTE_STAGE)
	setActive(arg_9_0.title2, arg_9_0.phase ~= VoteGroup.VOTE_STAGE)
	setActive(arg_9_0.tip, arg_9_0.phase == VoteGroup.VOTE_STAGE)
	arg_9_0:UpdateTitle()
	arg_9_0:initRank(arg_9_0.page)
	arg_9_0:Show()

	return
end

function var_0_0.OnDestroy(arg_10_0)
	return
end

return var_0_0
