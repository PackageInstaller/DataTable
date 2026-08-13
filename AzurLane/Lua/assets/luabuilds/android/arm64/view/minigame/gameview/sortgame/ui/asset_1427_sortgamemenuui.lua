class = var_0_10000

local var_0_0 = var_0_10000("SortGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	local var_1_0 = arg_1_0._gameVo

	arg_1_0.totalTimes = var_4.GetTotalTimes(var_1_0)
	arg_1_0.battleItems = {}

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0.menuUI = var_1_10001(arg_2_0._tf, "ui/menuUI")
	findTF = var_1
	arg_2_0.highScore = var_1(arg_2_0.menuUI, "highScore/text")
	GetComponent = var_1
	findTF = var_3

	local var_2_0 = var_3(arg_2_0.menuUI, "battList")

	typeof = var_4
	ScrollRect = var_6
	arg_2_0.battleScrollRect = var_1(var_2_0, var_4(var_6))
	onButton = var_1

	local var_2_1 = arg_2_0._event

	findTF = var_4

	local var_2_2 = var_4(arg_2_0.menuUI, "rightPanelBg/arrowUp")

	local function var_2_3()
		local var_3_0 = arg_2_0.battleScrollRect.normalizedPosition.y + 1 / (arg_2_0.totalTimes - 4)

		if 1 < var_3_0 then
			var_3_0 = 1
		end

		scrollTo = var_1

		var_1(arg_2_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_1, var_2_2, var_2_3, var_6)

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

	SFX_CANCEL = var_6

	var_1(var_2_4, var_2_5, var_2_6, var_6)

	onButton = var_1

	local var_2_7 = arg_2_0._event

	findTF = var_2_5

	local var_2_8 = var_2_5(arg_2_0.menuUI, "btnBack")

	local function var_2_9()
		local var_5_0 = arg_2_0._event
		local var_5_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_5_1(var_5_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_7, var_2_8, var_2_9, var_6)

	findTF = var_1
	arg_2_0.btnRule = var_1(arg_2_0.menuUI, "btnRule")
	onButton = var_1

	local var_2_10 = arg_2_0._event
	local var_2_11 = arg_2_0.btnRule

	local function var_2_12()
		local var_6_0 = arg_2_0._event
		local var_6_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_6_1(var_6_0, var_2_10003.SHOW_RULE, true)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_10, var_2_11, var_2_12, var_6)

	findTF = var_1
	arg_2_0.btnStart = var_1(arg_2_0.menuUI, "btnStart")
	onButton = var_1

	local var_2_13 = arg_2_0._event
	local var_2_14 = arg_2_0.btnStart

	local function var_2_15()
		local var_7_0 = arg_2_0._event
		local var_7_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_7_1(var_7_0, var_2_10003.READY_START)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_13, var_2_14, var_2_15, var_6)

	findTF = var_1
	arg_2_0.btnRank = var_1(arg_2_0.menuUI, "btnRank")
	onButton = var_1

	local var_2_16 = arg_2_0._event
	local var_2_17 = arg_2_0.btnRank

	local function var_2_18()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_8_2 = var_2_10003.SEND_MINI_GAME_OP
		local var_8_3 = {}
		local var_8_4 = arg_2_0._gameVo

		var_8_3.hubid = var_5.GetHubId(var_8_4)
		MiniGameOPCommand = var_5
		var_8_3.cmd = var_5.CMD_SPECIAL_TRACK

		local var_8_5 = {
			nil,
			103
		}
		local var_8_6 = arg_2_0._gameVo

		var_8_5[1] = var_6.GetGameId(var_8_6)
		var_8_3.args1 = var_8_5

		var_8_1(var_8_0, var_8_2, var_8_3)

		local var_8_7 = arg_2_0._event
		local var_8_8 = var_0.emit

		SimpleMGEvent = var_8_2

		var_8_8(var_8_7, var_8_2.SHOW_RANK)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_16, var_2_17, var_2_18, var_6)

	findTF = var_1
	arg_2_0.btnHome = var_1(arg_2_0.menuUI, "btnHome")
	onButton = var_1

	local var_2_19 = arg_2_0._event
	local var_2_20 = arg_2_0.btnHome

	local function var_2_21()
		local var_9_0 = arg_2_0._event
		local var_9_1 = var_0.emit

		SimpleMGEvent = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_19, var_2_20, var_2_21, var_6)

	findTF = var_1
	arg_2_0._tplBattleItem = var_1(arg_2_0.menuUI, "battList/Viewport/Content/tplBattleItem")
	setActive = var_1

	var_1(arg_2_0._tplBattleItem, false)

	local var_2_22 = arg_2_0._gameVo
	local var_2_23 = var_1.GetDrop(var_2_22)

	for iter_2_0 = 1, 7 do
		local var_2_24 = iter_2_0

		tf = var_2_25
		instantiate = var_1_10009

		local var_2_25 = var_2_25(var_1_10009(arg_2_0._tplBattleItem))

		var_2_25.name = "battleItem_" .. iter_2_0
		setParent = var_8

		local var_2_26 = var_2_25

		findTF = var_11

		var_8(var_2_26, var_11(arg_2_0.menuUI, "battList/Viewport/Content"))

		findTF = var_8

		local var_2_27 = var_8(var_2_25, "ad/iconMask/icon")

		var_1_10009 = {
			type = var_2_23[iter_2_0][1],
			id = var_2_23[iter_2_0][2],
			count = var_2_23[iter_2_0][3]
		}
		updateDrop = var_10

		var_10(var_2_27, var_1_10009)

		onButton = var_10

		local var_2_28 = arg_2_0._event
		local var_2_29 = var_2_27

		local function var_2_30()
			local var_10_0 = arg_2_0._event
			local var_10_1 = var_0.emit

			BaseUI = var_2_10003

			var_10_1(var_10_0, var_2_10003.ON_DROP, var_1_10009)

			return
		end

		SFX_PANEL = var_1_10015

		var_10(var_2_28, var_2_29, var_2_30, var_1_10015)

		setActive = var_10

		var_10(var_2_25, true)

		table = var_10

		var_10.insert(arg_2_0.battleItems, var_2_25)
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
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_12_0.menuUI, "lastTimes"), false)

		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(arg_12_0.menuUI, "btnRank"), false)
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
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_13_0.battleItems[iter_13_0], "ad/got")
		setActive = var_9

		var_9(var_1_10007, false)

		setActive = var_9

		var_9(var_1_10008, false)

		if iter_13_0 <= var_13_1 then
			setActive = var_9

			var_9(var_1_10008, true)
		elseif iter_13_0 == var_13_1 + 1 and 1 <= var_13_3 then
			-- block empty
		elseif var_13_1 < iter_13_0 and iter_13_0 <= var_13_1 + var_13_3 then
			-- block empty
		else
			setActive = var_9

			var_9(var_1_10007, true)
		end
	end

	local var_13_4 = 1 - (var_13_1 - 3 < 0 and 0 or var_13_1 - 3) / (arg_13_0.totalTimes - 4)

	if 1 < var_13_4 then
		var_13_4 = 1
	end

	scrollTo = var_5

	var_5(arg_13_0.battleScrollRect, 0, var_13_4)

	getProxy = var_5
	MiniGameProxy = var_7

	local var_13_5 = var_5(var_7)
	local var_13_6 = var_5.GetHighScore
	local var_13_7 = arg_13_0._gameVo

	if not var_13_6(var_13_5, var_8.GetGameId(var_13_7)) or not (#var_5 > 0) or not var_5[1] then
		local var_13_8 = 0
	end

	return
end

function var_0_0.CheckGet(arg_14_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_14_0.menuUI, "got"), false)

	local var_14_0 = arg_14_0._gameVo

	if var_1.GetUltimate(var_14_0) and var_1 ~= 0 then
		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(arg_14_0.menuUI, "got"), true)
	end

	if var_1 == 0 then
		local var_14_1 = arg_14_0._gameVo

		if var_2.GetTotalTimes(var_14_1) > arg_14_0:getGameUsedTimes() then
			return
		end

		pg = var_14_1

		local var_14_2 = var_14_1.m02
		local var_14_3 = var_4.sendNotification

		GAME = var_1_10007

		local var_14_4 = var_1_10007.SEND_MINI_GAME_OP
		local var_14_5 = {}
		local var_14_6 = arg_14_0._gameVo

		var_14_5.hubid = var_9.GetHubId(var_14_6)
		MiniGameOPCommand = var_9
		var_14_5.cmd = var_9.CMD_ULTIMATE
		var_14_5.args1 = {}

		var_14_3(var_14_2, var_14_4, var_14_5)

		setActive = var_14_3
		findTF = var_14_2

		var_14_3(var_14_2(arg_14_0.menuUI, "got"), true)
	end

	return
end

return var_0_0
