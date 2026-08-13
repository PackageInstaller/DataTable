class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	local var_1_0 = arg_1_0._gameVo

	arg_1_0.totalTimes = var_4.GetTotalTimes(var_1_0)
	arg_1_0.battleItems = {}

	local var_1_1 = arg_1_0

	arg_1_0.initUI(var_1_1)

	setText = var_4
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0.btnStart, "text")

	i18n = var_6

	var_4(var_1_2, var_6("pac_game_start_btn"))

	setText = var_4
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0.btnRule, "text")

	i18n = var_6

	var_4(var_1_3, var_6("pac_game_rule_btn"))

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0.menuUI = var_1_10001(arg_2_0._tf, "ui/menuUI")
	findTF = var_1
	arg_2_0.highScore = var_1(arg_2_0.menuUI, "highScore/text")
	GetComponent = var_1
	findTF = var_2

	local var_2_0 = var_2(arg_2_0.menuUI, "battList")

	typeof = var_3
	ScrollRect = var_4
	arg_2_0.battleScrollRect = var_1(var_2_0, var_3(var_4))
	onButton = var_1

	local var_2_1 = arg_2_0._event

	findTF = var_3

	local var_2_2 = var_3(arg_2_0.menuUI, "rightPanelBg/arrowUp")

	local function var_2_3()
		local var_3_0 = arg_2_0.battleScrollRect.normalizedPosition.y + 1 / (arg_2_0.totalTimes - 4)

		if 1 < var_3_0 then
			var_3_0 = 1
		end

		scrollTo = var_1

		var_1(arg_2_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_1, var_2_2, var_2_3, var_5)

	onButton = var_1

	local var_2_4 = arg_2_0._event

	findTF = var_2_2

	local var_2_5 = var_2_2(arg_2_0.menuUI, "rightPanelBg/arrowDown")

	local function var_2_6()
		local var_4_0

		if arg_2_0.battleScrollRect.normalizedPosition.y - 1 / (arg_2_0.totalTimes - 4) < 0 then
			var_4_0 = 0
		end

		scrollTo = var_1

		var_1(arg_2_0.battleScrollRect, 0, var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_4, var_2_5, var_2_6, var_5)

	onButton = var_1

	local var_2_7 = arg_2_0._event

	findTF = var_2_5

	local var_2_8 = var_2_5(arg_2_0.menuUI, "btnBack")

	local function var_2_9()
		local var_5_0 = arg_2_0._event
		local var_5_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_5_1(var_5_0, var_2_10002.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_7, var_2_8, var_2_9, var_5)

	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0.menuUI, "btnRule")
	onButton = var_1

	local var_2_10 = arg_2_0._event
	local var_2_11 = arg_2_0.btnRule

	local function var_2_12()
		local var_6_0 = arg_2_0._event
		local var_6_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_6_1(var_6_0, var_2_10002.SHOW_RULE, true)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_10, var_2_11, var_2_12, var_5)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0.menuUI, "btnStart")
	onButton = var_1

	local var_2_13 = arg_2_0._event
	local var_2_14 = arg_2_0.btnStart

	local function var_2_15()
		local var_7_0 = arg_2_0._event
		local var_7_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_7_1(var_7_0, var_2_10002.READY_START)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_13, var_2_14, var_2_15, var_5)

	findTF = var_1
	arg_2_0.btnRank = var_1(arg_2_0.menuUI, "btnRank")
	onButton = var_1

	local var_2_16 = arg_2_0._event
	local var_2_17 = arg_2_0.btnRank

	local function var_2_18()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_8_2 = var_2_10002.SEND_MINI_GAME_OP
		local var_8_3 = {}
		local var_8_4 = arg_2_0._gameVo

		var_8_3.hubid = var_4.GetHubId(var_8_4)
		MiniGameOPCommand = var_4
		var_8_3.cmd = var_4.CMD_SPECIAL_TRACK

		local var_8_5 = {
			nil,
			103
		}
		local var_8_6 = arg_2_0._gameVo

		var_8_5[1] = var_5.GetGameId(var_8_6)
		var_8_3.args1 = var_8_5

		var_8_1(var_8_0, var_8_2, var_8_3)

		local var_8_7 = arg_2_0._event
		local var_8_8 = var_0.emit

		SimpleMGEvent = var_8_2

		var_8_8(var_8_7, var_8_2.SHOW_RANK)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_16, var_2_17, var_2_18, var_5)

	findTF = var_1
	arg_2_0.btnHome = var_1(arg_2_0.menuUI, "btnHome")
	onButton = var_1

	local var_2_19 = arg_2_0._event
	local var_2_20 = arg_2_0.btnHome

	local function var_2_21()
		local var_9_0 = arg_2_0._event
		local var_9_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_HOME)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_19, var_2_20, var_2_21, var_5)

	findTF = var_1
	arg_2_0._tplBattleItem = var_1(arg_2_0.menuUI, "battList/Viewport/Content/tplBattleItem")
	setActive = var_1

	var_1(arg_2_0._tplBattleItem, false)

	local var_2_22 = arg_2_0._gameVo
	local var_2_23 = var_1.GetDrop(var_2_22)

	for iter_2_0 = 1, 7 do
		local var_2_24 = iter_2_0

		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(arg_2_0._tplBattleItem))
		var_1_10007.name = "battleItem_" .. iter_2_0
		setParent = var_1_10008

		local var_2_25 = var_1_10007

		findTF = var_1_10010

		var_1_10008(var_2_25, var_1_10010(arg_2_0.menuUI, "battList/Viewport/Content"))

		setText = var_1_10008
		findTF = var_2_25

		local var_2_26 = var_2_25(var_1_10007, "ad/desc")

		i18n = var_1_10010

		var_1_10008(var_2_26, var_1_10010("which_day_2", var_2_24))

		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_1_10007, "ad/iconMask/icon")

		local var_2_27 = {
			type = var_2_23[iter_2_0][1],
			id = var_2_23[iter_2_0][2],
			count = var_2_23[iter_2_0][3]
		}

		updateDrop = var_1_10010

		var_1_10010(var_1_10008, var_2_27)

		onButton = var_1_10010

		local var_2_28 = arg_2_0._event
		local var_2_29 = var_1_10008

		local function var_2_30()
			local var_10_0 = arg_2_0._event
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_DROP, var_2_27)

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10010(var_2_28, var_2_29, var_2_30, var_1_10014)

		setActive = var_1_10010

		var_1_10010(var_1_10007, true)

		table = var_1_10010

		var_1_10010.insert(arg_2_0.battleItems, var_1_10007)
	end

	return
end

function var_0_0.Show(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.menuUI, arg_11_1)

	return
end

function var_0_0.SetGameRoomUI(arg_12_0, arg_12_1)
	if arg_12_1 then
		setActive = var_1_10002
		findTF = var_1_10003

		var_1_10002(var_1_10003(arg_12_0.menuUI, "lastTimes"), false)

		setActive = var_1_10002
		findTF = var_3

		var_1_10002(var_3(arg_12_0.menuUI, "btnRank"), false)
	end

	return
end

function var_0_0.Update(arg_13_0)
	local var_13_0 = arg_13_0._gameVo
	local var_13_1 = var_1.GetGameUseTimes(var_13_0)
	local var_13_2 = arg_13_0._gameVo
	local var_13_3 = var_2.GetGameTimes(var_13_2)

	for iter_13_0 = 1, 7 do
		findTF = var_1_10007
		var_1_10007 = var_1_10007(arg_13_0.battleItems[iter_13_0], "ad/lock")
		findTF = var_8

		local var_13_4 = var_8(arg_13_0.battleItems[iter_13_0], "ad/got")

		setActive = var_1_10009

		var_1_10009(var_1_10007, false)

		setActive = var_1_10009

		var_1_10009(var_13_4, false)

		if iter_13_0 <= var_13_1 then
			setActive = var_1_10009

			var_1_10009(var_13_4, true)
		elseif iter_13_0 == var_13_1 + 1 and 1 <= var_13_3 then
			-- block empty
		elseif var_13_1 < iter_13_0 and iter_13_0 <= var_13_1 + var_13_3 then
			-- block empty
		else
			setActive = var_1_10009

			var_1_10009(var_1_10007, true)
		end
	end

	local var_13_5 = 1 - (var_13_1 - 3 < 0 and 0 or var_13_1 - 3) / (arg_13_0.totalTimes - 4)

	if 1 < var_13_5 then
		var_13_5 = 1
	end

	scrollTo = var_5

	var_5(arg_13_0.battleScrollRect, 0, var_13_5)

	getProxy = var_5
	MiniGameProxy = var_6

	local var_13_6 = var_5(var_6)
	local var_13_7 = var_5.GetHighScore
	local var_13_8 = arg_13_0._gameVo

	if var_13_7(var_13_6, var_7.GetGameId(var_13_8)) then
		local var_13_9 = #var_5
		local var_13_10

		if not (0 < var_13_9) or not var_5[1] then
			var_13_10 = 0
		end

		setText = var_7

		local var_13_11 = arg_13_0.highScore

		i18n = var_1_10009

		var_7(var_13_11, var_1_10009("pac_game_high_score_tip", var_13_10))

		return
	end
end

function var_0_0.CheckGet(arg_14_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_14_0.menuUI, "got"), false)

	local var_14_0 = arg_14_0._gameVo

	if var_1.GetUltimate(var_14_0) and var_1 ~= 0 then
		setActive = var_14_0
		findTF = var_3

		var_14_0(var_3(arg_14_0.menuUI, "got"), true)
	end

	if var_1 == 0 then
		local var_14_1 = arg_14_0._gameVo
		local var_14_2 = var_2.GetTotalTimes(var_14_1)
		local var_14_3 = arg_14_0

		if var_14_2 > arg_14_0.getGameUsedTimes(var_14_3) then
			return
		end

		pg = var_14_3

		local var_14_4 = var_14_3.m02
		local var_14_5 = var_4.sendNotification

		GAME = var_1_10006

		local var_14_6 = var_1_10006.SEND_MINI_GAME_OP
		local var_14_7 = {}
		local var_14_8 = arg_14_0._gameVo

		var_14_7.hubid = var_8.GetHubId(var_14_8)
		MiniGameOPCommand = var_8
		var_14_7.cmd = var_8.CMD_ULTIMATE
		var_14_7.args1 = {}

		var_14_5(var_14_4, var_14_6, var_14_7)

		setActive = var_14_5
		findTF = var_14_4

		var_14_5(var_14_4(arg_14_0.menuUI, "got"), true)
	end

	return
end

return var_0_0
