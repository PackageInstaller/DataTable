class = var_0_10000

local var_0_0 = "VotePreRaceRankPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

var_0_1.RANK_DISPLAY_COUNT = 15

function var_0_1.getUIName(arg_1_0)
	return "PreRaceRank"
end

function var_0_1.OnInit(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiitemlist = var_2_0(var_2_2, var_4.Find(var_2_3, "content/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.prevBtn = var_1.Find(var_2_4, "prev")

	local var_2_5 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_5, "next")

	local var_2_6 = arg_2_0._tf

	arg_2_0.tip = var_1.Find(var_2_6, "tip")

	local var_2_7 = arg_2_0._tf

	arg_2_0.title1 = var_1.Find(var_2_7, "stages/title1")

	local var_2_8 = arg_2_0._tf

	arg_2_0.title2 = var_1.Find(var_2_8, "stages/title2")

	local var_2_9 = arg_2_0._tf

	arg_2_0.rankTitle = var_1.Find(var_2_9, "titles/rank_title")
	onButton = var_1

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.nextBtn

	local function var_2_12()
		local var_3_0

		if arg_2_0.page + 1 > arg_2_0.maxPage then
			var_3_0 = 1
		end

		arg_2_0.page = var_3_0

		local var_3_1 = arg_2_0

		var_1.initRank(var_3_1, arg_2_0.page)

		return
	end

	SFX_PANEL = var_2_3

	var_1(var_2_10, var_2_11, var_2_12, var_2_3)

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.prevBtn

	local function var_2_15()
		local var_4_0

		if arg_2_0.page - 1 <= 0 then
			var_4_0 = arg_2_0.maxPage
		end

		arg_2_0.page = var_4_0

		local var_4_1 = arg_2_0

		var_1.initRank(var_4_1, arg_2_0.page)

		return
	end

	SFX_PANEL = var_2_3

	var_1(var_2_13, var_2_14, var_2_15, var_2_3)

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "titles/rank_title")

	i18n = var_2_14

	var_1(var_2_17, var_2_14("vote_label_rank"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "tip")

	i18n = var_4

	var_1(var_2_19, var_4("vote_label_rank_fresh_time_tip"))

	return
end

function var_0_1.initRank(arg_5_0, arg_5_1)
	local var_5_0 = (arg_5_1 - 1) * var_0_1.RANK_DISPLAY_COUNT
	local var_5_1 = arg_5_0.voteShips
	local var_5_2 = arg_5_0.uiitemlist

	var_4.make(var_5_2, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_5_0 + arg_6_1 + 1

			if var_5_1[var_6_0] then
				local var_6_1 = arg_5_0

				var_2_10005.UpdateShipInfo(var_6_1, arg_6_2, var_4:getShipName(), var_6_0)
			end

			setActive = var_2_10005

			var_2_10005(arg_6_2, var_4)
		end

		return
	end)

	local var_5_3 = arg_5_0.uiitemlist

	var_4.align(var_5_3, var_0_1.RANK_DISPLAY_COUNT)
	arg_5_0:UpdateTitle()

	return
end

function var_0_1.UpdateShipInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.voteGroup
	local var_7_1 = var_4.GetRiseColor(var_7_0, arg_7_3)

	setText = var_1_10006

	local var_7_2 = arg_7_1:Find("Text")

	setColorStr = var_1_10009
	shortenString = var_11

	var_1_10006(var_7_2, var_1_10009(var_11(arg_7_2, 9), var_7_1))

	setText = var_1_10006

	local var_7_3 = arg_7_1:Find("number")

	setColorStr = var_9

	var_1_10006(var_7_3, var_9(arg_7_3, var_7_1))

	return
end

function var_0_1.UpdateTitle(arg_8_0)
	local var_8_0 = arg_8_0.voteGroup
	local var_8_1 = var_1.getConfig(var_8_0, "next_round_number")

	setActive = var_1_10003

	var_1_10003(arg_8_0.rankTitle, true)

	return
end

function var_0_1.Update(arg_9_0, arg_9_1)
	arg_9_0.voteGroup = arg_9_1
	arg_9_0.voteShips = arg_9_1:getList()
	arg_9_0.page = 1
	math = var_2
	arg_9_0.maxPage = var_2.ceil(#arg_9_0.voteShips / var_0_1.RANK_DISPLAY_COUNT)
	arg_9_0.phase = arg_9_1:GetStage()
	setActive = var_2

	local var_9_0 = arg_9_0.title1
	local var_9_1 = arg_9_0.phase

	VoteGroup = var_1_10006

	var_2(var_9_0, var_9_1 == var_1_10006.VOTE_STAGE)

	setActive = var_2

	local var_9_2 = arg_9_0.title2
	local var_9_3 = arg_9_0.phase

	VoteGroup = var_6

	var_2(var_9_2, var_9_3 ~= var_6.VOTE_STAGE)

	setActive = var_2

	local var_9_4 = arg_9_0.tip
	local var_9_5 = arg_9_0.phase

	VoteGroup = var_6

	var_2(var_9_4, var_9_5 == var_6.VOTE_STAGE)
	arg_9_0:UpdateTitle()
	arg_9_0:initRank(arg_9_0.page)
	arg_9_0:Show()

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

return var_0_1
