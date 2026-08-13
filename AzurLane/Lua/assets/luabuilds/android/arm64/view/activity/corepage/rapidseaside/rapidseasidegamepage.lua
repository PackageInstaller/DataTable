class = var_0_10000

local var_0_0 = "RapidSeasideGamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 89

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
	arg_2_0.btnRule = var_1_10001(arg_2_0._tf, "ad/rule")
	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnRule

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.crossroad_minigame_help.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0._tf, "ad/start")
	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btnStart

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	arg_2_0.battleItems = {}
	findTF = var_1
	arg_2_0._tplBattleItem = var_1(arg_2_0._tf, "ad/awards/Viewport/Content/item_tpl")
	setActive = var_1

	var_1(arg_2_0._tplBattleItem, false)

	local var_2_6 = arg_2_0.drops

	for iter_2_0 = 1, 7 do
		local var_2_7 = iter_2_0

		tf = var_1_10007
		instantiate = var_1_10009
		var_1_10007 = var_1_10007(var_1_10009(arg_2_0._tplBattleItem))
		var_1_10007.name = "award_" .. iter_2_0
		setParent = var_8

		local var_2_8 = var_1_10007

		findTF = var_11

		var_8(var_2_8, var_11(arg_2_0._tf, "ad/awards/Viewport/Content"))

		local var_2_9 = iter_2_0

		setText = var_1_10009
		findTF = var_11

		var_1_10009(var_11(var_1_10007, "ad/desc"), "DAY" .. var_2_9)

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_1_10007, "ad/iconMask/icon")

		local var_2_10 = {
			type = var_2_6[iter_2_0][1],
			id = var_2_6[iter_2_0][2],
			count = var_2_6[iter_2_0][3]
		}

		updateDrop = var_11

		var_11(var_1_10009, var_2_10)

		onButton = var_11

		local var_2_11 = arg_2_0
		local var_2_12 = var_1_10009

		local function var_2_13()
			local var_5_0 = arg_2_0
			local var_5_1 = var_0.emit

			BaseUI = var_2_10003

			var_5_1(var_5_0, var_2_10003.ON_DROP, var_2_10)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_2_11, var_2_12, var_2_13, var_1_10016)

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

	return
end

function var_0_1.setChildVisible(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = 1, arg_7_1.childCount do
		local var_7_0 = arg_7_1:GetChild(iter_7_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_7_0, arg_7_2)
	end

	return
end

function var_0_1.willExit(arg_8_0)
	return
end

return var_0_1
