class = var_0_10000

local var_0_0 = "SpringFestival2026PacGamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 81

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
	arg_2_0.highScore = var_1_10001(arg_2_0._tf, "ad/title/text")
	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0._tf, "ad/rule")
	setText = var_1
	findTF = var_3

	local var_2_0 = var_3(arg_2_0.btnRule, "text")

	i18n = var_4

	var_1(var_2_0, var_4("pac_game_rule_btn"))

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.btnRule

	local function var_2_3()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.pac_minigame_help.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_1, var_2_2, var_2_3, var_6)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0._tf, "ad/start")
	setText = var_1
	findTF = var_3

	local var_2_4 = var_3(arg_2_0.btnStart, "text")

	i18n = var_4

	var_1(var_2_4, var_4("pac_game_start_btn"))

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.btnStart

	local function var_2_7()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_5, var_2_6, var_2_7, var_6)

	arg_2_0.battleItems = {}
	findTF = var_1
	arg_2_0._tplBattleItem = var_1(arg_2_0._tf, "ad/awards/Viewport/Content/item_tpl")
	setActive = var_1

	var_1(arg_2_0._tplBattleItem, false)

	local var_2_8 = arg_2_0.drops

	for iter_2_0 = 1, 7 do
		local var_2_9 = iter_2_0

		tf = var_1_10007
		instantiate = var_1_10009
		var_1_10007 = var_1_10007(var_1_10009(arg_2_0._tplBattleItem))
		var_1_10007.name = "award_" .. iter_2_0
		setParent = var_8

		local var_2_10 = var_1_10007

		findTF = var_11

		var_8(var_2_10, var_11(arg_2_0._tf, "ad/awards/Viewport/Content"))

		local var_2_11 = iter_2_0

		setText = var_1_10009
		findTF = var_11

		local var_2_12 = var_11(var_1_10007, "ad/desc")

		i18n = var_1_10012

		var_1_10009(var_2_12, var_1_10012("which_day_2", var_2_11))

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_1_10007, "ad/iconMask/icon")

		local var_2_13 = {
			type = var_2_8[iter_2_0][1],
			id = var_2_8[iter_2_0][2],
			count = var_2_8[iter_2_0][3]
		}

		updateDrop = var_11

		var_11(var_1_10009, var_2_13)

		onButton = var_11

		local var_2_14 = arg_2_0
		local var_2_15 = var_1_10009

		local function var_2_16()
			local var_5_0 = arg_2_0
			local var_5_1 = var_0.emit

			BaseUI = var_2_10003

			var_5_1(var_5_0, var_2_10003.ON_DROP, var_2_13)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_2_14, var_2_15, var_2_16, var_1_10016)

		setActive = var_11

		var_11(var_1_10007, true)

		table = var_11

		var_11.insert(arg_2_0.battleItems, var_1_10007)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	for iter_6_0 = 1, 7 do
		findTF = var_1_10005
		var_1_10005 = var_1_10005(arg_6_0.battleItems[iter_6_0], "ad/lock")
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_6_0.battleItems[iter_6_0], "ad/got")
		setActive = var_7

		var_7(var_1_10005, false)

		setActive = var_7

		var_7(var_1_10006, false)

		if iter_6_0 <= arg_6_0.useTimes then
			setActive = var_7

			var_7(var_1_10006, true)
		elseif iter_6_0 == arg_6_0.useTimes + 1 and arg_6_0.gameTimes >= 1 then
			-- block empty
		elseif arg_6_0.useTimes < iter_6_0 and iter_6_0 <= arg_6_0.useTimes + arg_6_0.gameTimes then
			-- block empty
		else
			setActive = var_7

			var_7(var_1_10005, true)
		end
	end

	getProxy = var_1
	MiniGameProxy = var_3

	local var_6_0 = var_1(var_3)

	if var_1.GetHighScore(var_6_0, var_0_2) then
		local var_6_1 = #var_1
		local var_6_2

		if not (0 < var_6_1) or not var_1[1] then
			var_6_2 = 0
		end

		setText = var_6_0

		local var_6_3 = arg_6_0.highScore

		i18n = var_1_10006

		var_6_0(var_6_3, var_1_10006("pac_game_high_score_tip", var_6_2))

		return
	end
end

function var_0_1.willExit(arg_7_0)
	return
end

return var_0_1
