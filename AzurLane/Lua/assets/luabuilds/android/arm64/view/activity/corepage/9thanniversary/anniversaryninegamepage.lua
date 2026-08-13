class = var_0_10000

local var_0_0 = "AnniversaryNineGamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 84

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0.mgHubData = var_1.GetHubByGameId(var_1_0, var_0_2)
	pg = var_1
	arg_1_0.drops = var_1.mini_game[var_0_2].simple_config_data.drop_ids
	arg_1_0.totalTimes = #arg_1_0.drops
	arg_1_0.useTimes = arg_1_0.mgHubData.usedtime
	arg_1_0.gameTimes = arg_1_0.mgHubData.count

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	findTF = var_1_10001
	arg_2_0.highScoreText = var_1_10001(arg_2_0._tf, "ad/high/text")
	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0._tf, "ad/rule")
	findTF = var_1
	arg_2_0.btnRank = var_1(arg_2_0._tf, "ad/rank")
	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnRank

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.getRankData(var_3_0, var_0_2, function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.UpdateRankData(var_4_0, arg_4_0)

			return
		end)

		local var_3_1 = arg_2_0

		var_0.PopRankUI(var_3_1, true)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	local var_2_3 = arg_2_0

	arg_2_0.initRankUI(var_2_3)

	setText = var_1
	findTF = var_2_3

	local var_2_4 = var_2_3(arg_2_0.btnRule, "text")

	i18n = var_2_1

	var_1(var_2_4, var_2_1("pac_game_rule_btn"))

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.btnRule

	local function var_2_7()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.sort_minigame_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_5, var_2_6, var_2_7, var_6)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0._tf, "ad/start")
	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.btnStart

	local function var_2_10()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_8, var_2_9, var_2_10, var_6)

	arg_2_0.battleItems = {}
	findTF = var_1
	arg_2_0._tplBattleItem = var_1(arg_2_0._tf, "ad/awards/Viewport/Content/item_tpl")
	setActive = var_1

	var_1(arg_2_0._tplBattleItem, false)

	local var_2_11 = arg_2_0.drops

	for iter_2_0 = 1, 7 do
		local var_2_12 = iter_2_0

		tf = var_1_10007
		instantiate = var_1_10009
		var_1_10007 = var_1_10007(var_1_10009(arg_2_0._tplBattleItem))
		var_1_10007.name = "award_" .. iter_2_0
		setParent = var_8

		local var_2_13 = var_1_10007

		findTF = var_11

		var_8(var_2_13, var_11(arg_2_0._tf, "ad/awards/Viewport/Content"))

		local var_2_14 = iter_2_0

		setText = var_1_10009
		findTF = var_11

		var_1_10009(var_11(var_1_10007, "ad/desc"), "DAY" .. var_2_14)

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_1_10007, "ad/iconMask/icon")

		local var_2_15 = {
			type = var_2_11[iter_2_0][1],
			id = var_2_11[iter_2_0][2],
			count = var_2_11[iter_2_0][3]
		}

		updateDrop = var_11

		var_11(var_1_10009, var_2_15)

		onButton = var_11

		local var_2_16 = arg_2_0
		local var_2_17 = var_1_10009

		local function var_2_18()
			local var_7_0 = arg_2_0
			local var_7_1 = var_0.emit

			BaseUI = var_2_10003

			var_7_1(var_7_0, var_2_10003.ON_DROP, var_2_15)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_2_16, var_2_17, var_2_18, var_1_10016)

		setActive = var_11

		var_11(var_1_10007, true)

		table = var_11

		var_11.insert(arg_2_0.battleItems, var_1_10007)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	for iter_8_0 = 1, 7 do
		findTF = var_1_10005
		var_1_10005 = var_1_10005(arg_8_0.battleItems[iter_8_0], "ad/lock")
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_8_0.battleItems[iter_8_0], "ad/got")
		setActive = var_7

		var_7(var_1_10005, false)

		setActive = var_7

		var_7(var_1_10006, false)

		if iter_8_0 <= arg_8_0.useTimes then
			setActive = var_7

			var_7(var_1_10006, true)
		elseif iter_8_0 == arg_8_0.useTimes + 1 and arg_8_0.gameTimes >= 1 then
			-- block empty
		elseif arg_8_0.useTimes < iter_8_0 and iter_8_0 <= arg_8_0.useTimes + arg_8_0.gameTimes then
			-- block empty
		else
			setActive = var_7

			var_7(var_1_10005, true)
		end
	end

	getProxy = var_1
	MiniGameProxy = var_3

	local var_8_0 = var_1(var_3)

	if var_1.GetHighScore(var_8_0, var_0_2) then
		local var_8_1 = #var_1
		local var_8_2

		if not (0 < var_8_1) or not var_1[1] then
			var_8_2 = 0
		end

		setText = var_8_0

		local var_8_3 = arg_8_0.highScoreText

		tostring = var_1_10006

		var_8_0(var_8_3, var_1_10006(var_8_2))

		local var_8_4 = arg_8_0.coreActivityUI
		local var_8_6

		if var_3.GetActivityIdByPageClass(var_8_4, "AnniversaryNineInvitationPage") then
			::label_8_0::

			getProxy = var_8_6
			ActivityProxy = var_6

			local var_8_5 = var_8_6(var_6)

			var_8_6 = var_8_6.getActivityById(var_8_5, var_3)
		end

		if var_8_6 and not var_8_6:isEnd() then
			updateActivityTaskStatus = var_5

			var_5(var_8_6)
		end

		return
	end
end

function var_0_1.initRankUI(arg_9_0)
	findTF = var_1_10001
	arg_9_0.rankUI = var_1_10001(arg_9_0._tf, "pop/RankUI")

	arg_9_0:PopRankUI(false)

	findTF = var_1
	arg_9_0._rankImg = var_1(arg_9_0.rankUI, "ad/img")
	findTF = var_1
	arg_9_0._rankBtnClose = var_1(arg_9_0.rankUI, "ad/btnClose")
	findTF = var_1
	arg_9_0._rankContent = var_1(arg_9_0.rankUI, "ad/list/content")
	findTF = var_1
	arg_9_0._rankItemTpl = var_1(arg_9_0.rankUI, "ad/list/content/itemTpl")
	findTF = var_1
	arg_9_0._rankEmpty = var_1(arg_9_0.rankUI, "ad/empty")
	findTF = var_1
	arg_9_0._rankDesc = var_1(arg_9_0.rankUI, "ad/desc")
	arg_9_0._rankItems = {}
	setActive = var_1

	var_1(arg_9_0._rankItemTpl, false)

	onButton = var_1

	local var_9_0 = arg_9_0._event

	findTF = var_4

	local var_9_1 = var_4(arg_9_0.rankUI, "ad/close")

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.PopRankUI(var_10_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_9_0, var_9_1, var_9_2, var_6)

	onButton = var_1

	local var_9_3 = arg_9_0._event
	local var_9_4 = arg_9_0._rankBtnClose

	local function var_9_5()
		local var_11_0 = arg_9_0

		var_0.PopRankUI(var_11_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_9_3, var_9_4, var_9_5, var_6)

	setText = var_1

	local var_9_6 = arg_9_0._rankDesc

	i18n = var_9_4

	var_1(var_9_6, var_9_4("pipe_minigame_rank"))

	setText = var_1
	findTF = var_9_6

	local var_9_7 = var_9_6(arg_9_0.rankUI, "ad/bg/bg_high/text")

	i18n = var_4

	var_1(var_9_7, var_4("series_enemy_reward_tip4"))

	return
end

function var_0_1.UpdateRankData(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_1 do
		var_1_10006 = nil

		if #arg_12_0._rankItems < iter_12_0 then
			tf = var_7
			instantiate = var_1_10009

			local var_12_0 = var_7(var_1_10009(arg_12_0._rankItemTpl))

			setActive = var_1_10008

			var_1_10008(var_12_0, false)

			setParent = var_1_10008

			var_1_10008(var_12_0, arg_12_0._rankContent)

			table = var_1_10008

			var_1_10008.insert(arg_12_0._rankItems, var_12_0)
		end

		var_1_10006 = arg_12_0._rankItems[iter_12_0]
		var_1_10009 = arg_12_0

		arg_12_0.SetRankItemData(var_1_10009, var_1_10006, arg_12_1[iter_12_0], iter_12_0)

		setActive = var_7

		var_7(var_1_10006, true)
	end

	for iter_12_1 = #arg_12_1 + 1, #arg_12_0._rankItems do
		setActive = var_1_10006

		var_1_10006(arg_12_0._rankItems, false)
	end

	setActive = var_2

	var_2(arg_12_0._rankEmpty, #arg_12_1 == 0)

	setActive = var_2

	var_2(arg_12_0._rankImg, #arg_12_1 > 0)

	return
end

function var_0_1.SetRankItemData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2.name
	local var_13_1 = arg_13_2.player_id
	local var_13_2 = arg_13_2.position
	local var_13_3 = arg_13_2.score
	local var_13_4 = arg_13_2.time_data

	getProxy = var_1_10009
	PlayerProxy = var_1_10011

	local var_13_5 = var_1_10009(var_1_10011)
	local var_13_6 = var_9.isSelf(var_13_5, var_13_1)

	setText = var_1_10010
	findTF = var_12

	var_1_10010(var_12(arg_13_1, "nameText"), var_13_0)

	local var_13_7 = arg_13_0
	local var_13_8 = arg_13_0.setChildVisible

	findTF = var_13

	var_13_8(var_13_7, var_13(arg_13_1, "bg"), false)

	local var_13_9 = arg_13_0
	local var_13_10 = arg_13_0.setChildVisible

	findTF = var_13

	var_13_10(var_13_9, var_13(arg_13_1, "rank"), false)

	if arg_13_3 <= 3 then
		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "bg/" .. arg_13_3), true)

		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "rank/" .. arg_13_3), true)
	elseif var_13_6 then
		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "bg/me"), true)

		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "rank/count"), true)
	else
		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "bg/other"), true)

		setActive = var_10
		findTF = var_13_9

		var_10(var_13_9(arg_13_1, "rank/count"), true)
	end

	setText = var_10
	findTF = var_13_9

	local var_13_11 = var_13_9(arg_13_1, "rank/count")

	tostring = var_13

	var_10(var_13_11, var_13(arg_13_3))

	setText = var_10
	findTF = var_13_11

	local var_13_12 = var_13_11(arg_13_1, "score")

	tostring = var_13

	var_10(var_13_12, var_13(var_13_3))

	setActive = var_10
	findTF = var_13_12

	var_10(var_13_12(arg_13_1, "imgMy"), var_13_6)

	return
end

function var_0_1.PopRankUI(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.rankUI, arg_14_1)

	return
end

function var_0_1.getRankData(arg_15_0, arg_15_1, arg_15_2)
	pg = var_1_10003

	local var_15_0 = var_1_10003.m02
	local var_15_1 = var_3.sendNotification

	GAME = var_1_10006

	var_15_1(var_15_0, var_1_10006.MINI_GAME_FRIEND_RANK, {
		id = arg_15_1,
		callback = function(arg_16_0)
			local var_16_0 = {}

			for iter_16_0 = 1, #arg_16_0 do
				local var_16_1 = {}

				pairs = var_2_10007

				for iter_16_1, iter_16_2 in var_2_10007(arg_16_0[iter_16_0]) do
					var_16_1[iter_16_1] = iter_16_2
				end

				table = var_2_10007

				var_2_10007.insert(var_16_0, var_16_1)
			end

			table = var_2

			var_2.sort(var_16_0, function(arg_17_0, arg_17_1)
				if arg_17_0.score ~= arg_17_1.score then
					return arg_17_0.score > arg_17_1.score
				elseif arg_17_0.time_data ~= arg_17_1.time_data then
					return arg_17_0.time_data > arg_17_1.time_data
				else
					return arg_17_0.player_id < arg_17_1.player_id
				end

				return
			end)

			if arg_15_2 then
				arg_15_2(var_16_0)
			end

			return
		end
	})

	return
end

function var_0_1.setChildVisible(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, arg_18_1.childCount do
		local var_18_0 = arg_18_1:GetChild(iter_18_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_18_0, arg_18_2)
	end

	return
end

function var_0_1.willExit(arg_19_0)
	return
end

return var_0_1
