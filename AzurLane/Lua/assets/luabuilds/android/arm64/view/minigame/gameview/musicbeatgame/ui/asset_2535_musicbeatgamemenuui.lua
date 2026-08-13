class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	findTF = var_1_10004
	arg_1_0.menuUI = var_1_10004(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_4
	findTF = var_6

	local var_1_0 = var_6(arg_1_0.menuUI, "battList")

	typeof = var_7
	ScrollRect = var_9
	arg_1_0.battleScrollRect = var_4(var_1_0, var_7(var_9))
	arg_1_0.totalTimes = arg_1_0._gameVo.totalTimes
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	findTF = var_4
	arg_1_0.textLastTimes = var_4(arg_1_0.menuUI, "lastTimes/desc")
	findTF = var_4
	arg_1_0.btnRank = var_4(arg_1_0.menuUI, "btnRank")
	findTF = var_4
	arg_1_0.btnHome = var_4(arg_1_0.menuUI, "btnHome")
	GetComponent = var_4

	local var_1_1 = arg_1_0.btnRank

	typeof = var_7
	Image = var_9

	local var_1_2 = var_4(var_1_1, var_7(var_9))

	var_4.SetNativeSize(var_1_2)

	findTF = var_4
	arg_1_0.imgHelp = var_4(arg_1_0.menuUI, "imgHelp")
	findTF = var_4
	arg_1_0.highScore = var_4(arg_1_0.menuUI, "highScore/text")
	setActive = var_4

	var_4(arg_1_0.imgHelp, false)

	onButton = var_4

	local var_1_3 = arg_1_0._event

	findTF = var_7

	local var_1_4 = var_7(arg_1_0.menuUI, "rightPanelBg/arrowUp")

	local function var_1_5()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if 1 < var_2_0 then
			var_2_0 = 1
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_3, var_1_4, var_1_5, var_9)

	onButton = var_4

	local var_1_6 = arg_1_0._event

	findTF = var_1_4

	local var_1_7 = var_1_4(arg_1_0.menuUI, "rightPanelBg/arrowDown")

	local function var_1_8()
		local var_3_0

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_6, var_1_7, var_1_8, var_9)

	onButton = var_4

	local var_1_9 = arg_1_0._event

	findTF = var_1_7

	local var_1_10 = var_1_7(arg_1_0.menuUI, "btnBack")

	local function var_1_11()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_4_1(var_4_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_9, var_1_10, var_1_11, var_9)

	onButton = var_4

	local var_1_12 = arg_1_0._event

	findTF = var_1_10

	local var_1_13 = var_1_10(arg_1_0.menuUI, "btnRule")

	local function var_1_14()
		local var_5_0 = arg_1_0._event
		local var_5_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_5_1(var_5_0, var_2_10003.SHOW_RULE, true)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_12, var_1_13, var_1_14, var_9)

	onButton = var_4

	local var_1_15 = arg_1_0._event
	local var_1_16 = arg_1_0.imgHelp

	local function var_1_17()
		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_6_1(var_6_0, var_2_10003.SHOW_RULE, false)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_15, var_1_16, var_1_17, var_9)

	findTF = var_4
	arg_1_0.btnStart = var_4(arg_1_0.menuUI, "btnStart")
	onButton = var_4

	local var_1_18 = arg_1_0._event
	local var_1_19 = arg_1_0.btnStart

	local function var_1_20()
		local var_7_0 = arg_1_0._event
		local var_7_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_7_1(var_7_0, var_2_10003.READY_START)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_18, var_1_19, var_1_20, var_9)

	onButton = var_4

	local var_1_21 = arg_1_0._event
	local var_1_22 = arg_1_0.btnRank

	local function var_1_23()
		local var_8_0 = arg_1_0._event
		local var_8_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_8_1(var_8_0, var_2_10003.SHOW_RANK)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_21, var_1_22, var_1_23, var_9)

	onButton = var_4

	local var_1_24 = arg_1_0._event
	local var_1_25 = arg_1_0.btnHome

	local function var_1_26()
		local var_9_0 = arg_1_0._event
		local var_9_1 = var_0.emit

		MusicBeatGameEvent = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_24, var_1_25, var_1_26, var_9)

	findTF = var_4

	local var_1_27 = var_4(arg_1_0.menuUI, "tplBattleItem")
	local var_1_28 = arg_1_0._gameVo.drop

	for iter_1_0 = 1, 7 do
		local var_1_29 = iter_1_0

		tf = var_1_10011
		instantiate = var_1_10013
		var_1_10011 = var_1_10011(var_1_10013(var_1_27))
		var_1_10011.name = "battleItem_" .. iter_1_0
		setParent = var_12

		local var_1_30 = var_1_10011

		findTF = var_15

		var_12(var_1_30, var_15(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_31 = iter_1_0

		findTF = var_1_10013
		var_1_10013 = var_1_10013(var_1_10011, "icon")

		local var_1_32 = {
			type = var_1_28[iter_1_0][1],
			id = var_1_28[iter_1_0][2],
			count = var_1_28[iter_1_0][3]
		}

		updateDrop = var_15

		var_15(var_1_10013, var_1_32)

		onButton = var_15

		local var_1_33 = arg_1_0._event
		local var_1_34 = var_1_10013

		local function var_1_35()
			local var_10_0 = arg_1_0._event
			local var_10_1 = var_0.emit

			BaseUI = var_2_10003

			var_10_1(var_10_0, var_2_10003.ON_DROP, var_1_32)

			return
		end

		SFX_PANEL = var_1_10020

		var_15(var_1_33, var_1_34, var_1_35, var_1_10020)

		table = var_15

		var_15.insert(arg_1_0.dropItems, var_1_10013)

		setActive = var_15

		var_15(var_1_10011, true)

		table = var_15

		var_15.insert(arg_1_0.battleItems, var_1_10011)

		local var_1_36 = arg_1_0._gameVo
		local var_1_37 = var_15.getGameUseTimes(var_1_36)
		local var_1_38 = arg_1_0._gameVo
		local var_1_39 = var_16.getGameTimes(var_1_38)
	end

	setText = var_6
	findTF = var_8

	local var_1_40 = var_8(arg_1_0.menuUI, "btnRule/text")

	i18n = iter_1_0

	var_6(var_1_40, iter_1_0("beat_game_rule"))

	setText = var_6
	findTF = var_1_40

	local var_1_41 = var_1_40(arg_1_0.menuUI, "btnStart/text")

	i18n = var_9

	var_6(var_1_41, var_9("beat_game_start"))

	setText = var_6
	findTF = var_1_41

	local var_1_42 = var_1_41(arg_1_0.menuUI, "btnRank/text")

	i18n = var_9

	var_6(var_1_42, var_9("beat_game_rank"))

	return
end

function var_0_0.show(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.menuUI, arg_11_1)

	return
end

function var_0_0.setGameRoomUI(arg_12_0, arg_12_1)
	if arg_12_1 then
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_12_0.menuUI, "lastTimes"), false)

		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(arg_12_0.menuUI, "btnRank"), false)
	end

	return
end

function var_0_0.update(arg_13_0, arg_13_1)
	arg_13_0.mgHubData = arg_13_1

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.getGameUsedTimes(var_13_0, arg_13_1)
	local var_13_2 = arg_13_0:getGameTimes(arg_13_1)

	setText = var_13_0

	var_13_0(arg_13_0.textLastTimes, var_13_2)

	for iter_13_0 = 1, 7 do
		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_13_0.battleItems[iter_13_0], "lock"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_13_0.battleItems[iter_13_0], "clear"), false)

		if iter_13_0 <= var_13_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_13_0.battleItems[iter_13_0], "clear"), true)
		elseif iter_13_0 == var_13_1 + 1 and 1 <= var_13_2 then
			-- block empty
		elseif var_13_1 < iter_13_0 and iter_13_0 <= var_13_1 + var_13_2 then
			-- block empty
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_13_0.battleItems[iter_13_0], "lock"), true)
		end
	end

	local var_13_3 = 1 - (var_13_1 - 3 < 0 and 0 or var_13_1 - 3) / (arg_13_0.totalTimes - 4)

	if 1 < var_13_3 then
		var_13_3 = 1
	end

	scrollTo = var_6

	var_6(arg_13_0.battleScrollRect, 0, var_13_3)

	getProxy = var_6
	MiniGameProxy = var_8

	local var_13_4 = var_6(var_8)

	if var_6.GetHighScore(var_13_4, arg_13_0._gameVo.gameId) then
		local var_13_5 = #var_6
		local var_13_6

		if not (0 < var_13_5) or not var_6[1] then
			var_13_6 = 0
		end

		setText = var_13_4

		var_13_4(arg_13_0.highScore, var_13_6)

		return
	end
end

function var_0_0.CheckGet(arg_14_0)
	local var_14_0 = arg_14_0.mgHubData
	local var_14_1 = arg_14_0:getUltimate(var_14_0)

	setActive = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_14_0.menuUI, "got"), false)

	if not var_14_1 then
		return
	end

	if var_14_1 ~= 0 then
		setActive = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_14_0.menuUI, "got"), true)
	elseif var_14_1 == 0 and arg_14_0._gameVo.totalTimes <= arg_14_0:getGameUsedTimes(var_14_0) then
		pg = var_5

		local var_14_2 = var_5.m02
		local var_14_3 = var_5.sendNotification

		GAME = var_8

		local var_14_4 = var_8.SEND_MINI_GAME_OP
		local var_14_5 = {
			hubid = var_14_0.id
		}

		MiniGameOPCommand = var_10
		var_14_5.cmd = var_10.CMD_ULTIMATE
		var_14_5.args1 = {}

		var_14_3(var_14_2, var_14_4, var_14_5)

		setActive = var_14_3
		findTF = var_14_2

		var_14_3(var_14_2(arg_14_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.showRankUI(arg_15_0)
	triggerButton = var_1_10001

	var_1_10001(arg_15_0.btnRank)

	return
end

function var_0_0.getGameTimes(arg_16_0, arg_16_1)
	return arg_16_1.count
end

function var_0_0.getGameUsedTimes(arg_17_0, arg_17_1)
	return arg_17_1.usedtime
end

function var_0_0.getUltimate(arg_18_0, arg_18_1)
	return arg_18_1.ultimate
end

return var_0_0
