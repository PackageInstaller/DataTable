class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeMenuUI")
local var_0_1
local var_0_2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	TouchCakeGameVo = var_1_10003
	var_0_1 = var_1_10003
	TouchCakeGameEvent = var_1_10003
	var_0_2 = var_1_10003
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.menuUI = var_1_10003(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_3
	findTF = var_4

	local var_1_0 = var_4(arg_1_0.menuUI, "battList")

	typeof = var_5
	ScrollRect = var_6
	arg_1_0.battleScrollRect = var_3(var_1_0, var_5(var_6))
	arg_1_0.totalTimes = var_0_1.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	findTF = var_3
	arg_1_0.textLastTimes = var_3(arg_1_0.menuUI, "lastTimes/desc")
	GetComponent = var_3
	findTF = var_4

	local var_1_1 = var_4(arg_1_0.menuUI, "lastTimes/img")

	typeof = var_5
	Image = var_6

	local var_1_2 = var_3(var_1_1, var_5(var_6))

	var_3.SetNativeSize(var_1_2)

	findTF = var_3
	arg_1_0.btnRank = var_3(arg_1_0.menuUI, "btnRank")
	findTF = var_3
	arg_1_0.btnHome = var_3(arg_1_0.menuUI, "btnHome")
	findTF = var_3
	arg_1_0.imgHelp = var_3(arg_1_0.menuUI, "imgHelp")
	setActive = var_3

	var_3(arg_1_0.imgHelp, false)

	onButton = var_3

	local var_1_3 = arg_1_0._event

	findTF = var_5

	local var_1_4 = var_5(arg_1_0.menuUI, "rightPanelBg/arrowUp")

	local function var_1_5()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if 1 < var_2_0 then
			var_2_0 = 1
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_3, var_1_4, var_1_5, var_7)

	onButton = var_3

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

	SFX_CANCEL = var_7

	var_3(var_1_6, var_1_7, var_1_8, var_7)

	onButton = var_3

	local var_1_9 = arg_1_0._event

	findTF = var_1_7

	local var_1_10 = var_1_7(arg_1_0.menuUI, "btnBack")

	local function var_1_11()
		local var_4_0 = arg_1_0._event

		var_0.emit(var_4_0, var_0_2.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_9, var_1_10, var_1_11, var_7)

	onButton = var_3

	local var_1_12 = arg_1_0._event

	findTF = var_1_10

	local var_1_13 = var_1_10(arg_1_0.menuUI, "btnRule")

	local function var_1_14()
		local var_5_0 = arg_1_0._event

		var_0.emit(var_5_0, var_0_2.SHOW_RULE, true)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_12, var_1_13, var_1_14, var_7)

	onButton = var_3

	local var_1_15 = arg_1_0._event
	local var_1_16 = arg_1_0.imgHelp

	local function var_1_17()
		local var_6_0 = arg_1_0._event

		var_0.emit(var_6_0, var_0_2.SHOW_RULE, false)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_15, var_1_16, var_1_17, var_7)

	findTF = var_3
	arg_1_0.btnStart = var_3(arg_1_0.menuUI, "btnStart")
	onButton = var_3

	local var_1_18 = arg_1_0._event
	local var_1_19 = arg_1_0.btnStart

	local function var_1_20()
		local var_7_0 = arg_1_0._event

		var_0.emit(var_7_0, var_0_2.READY_START)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_18, var_1_19, var_1_20, var_7)

	onButton = var_3

	local var_1_21 = arg_1_0._event
	local var_1_22 = arg_1_0.btnRank

	local function var_1_23()
		local var_8_0 = arg_1_0._event

		var_0.emit(var_8_0, var_0_2.SHOW_RANK)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_21, var_1_22, var_1_23, var_7)

	onButton = var_3

	local var_1_24 = arg_1_0._event
	local var_1_25 = arg_1_0.btnHome

	local function var_1_26()
		local var_9_0 = arg_1_0._event

		var_0.emit(var_9_0, var_0_2.ON_HOME)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_24, var_1_25, var_1_26, var_7)

	findTF = var_3

	local var_1_27 = var_3(arg_1_0.menuUI, "tplBattleItem")
	local var_1_28 = var_0_1.drop

	for iter_1_0 = 1, 7 do
		local var_1_29 = iter_1_0

		tf = var_1_10010
		instantiate = var_1_10011
		var_1_10010 = var_1_10010(var_1_10011(var_1_27))
		var_1_10010.name = "battleItem_" .. iter_1_0
		setParent = var_1_10011

		local var_1_30 = var_1_10010

		findTF = var_1_10013

		var_1_10011(var_1_30, var_1_10013(arg_1_0.menuUI, "battList/Viewport/Content"))

		var_1_10011 = iter_1_0
		findTF = var_1_30

		local var_1_31 = var_1_30(var_1_10010, "icon")

		var_1_10013 = {
			type = var_1_28[iter_1_0][1],
			id = var_1_28[iter_1_0][2],
			amount = var_1_28[iter_1_0][3]
		}
		updateDrop = var_14

		var_14(var_1_31, var_1_10013)

		onButton = var_14

		local var_1_32 = arg_1_0._event
		local var_1_33 = var_1_31

		local function var_1_34()
			local var_10_0 = arg_1_0._event
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_DROP, var_1_10013)

			return
		end

		SFX_PANEL = var_1_10018

		var_14(var_1_32, var_1_33, var_1_34, var_1_10018)

		table = var_14

		var_14.insert(arg_1_0.dropItems, var_1_31)

		setActive = var_14

		var_14(var_1_10010, true)

		table = var_14

		var_14.insert(arg_1_0.battleItems, var_1_10010)

		local var_1_35 = var_0_1.GetGameUseTimes()
		local var_1_36 = var_0_1.GetGameTimes()
	end

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
		findTF = var_1_10003

		var_1_10002(var_1_10003(arg_12_0.menuUI, "lastTimes"), false)

		setActive = var_1_10002
		findTF = var_3

		var_1_10002(var_3(arg_12_0.menuUI, "btnRank"), false)
	end

	return
end

function var_0_0.update(arg_13_0, arg_13_1)
	arg_13_0.mgHubData = arg_13_1

	local var_13_0 = arg_13_0:getGameUsedTimes(arg_13_1)
	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.getGameTimes(var_13_1, arg_13_1)

	setActive = var_13_1
	findTF = var_5

	var_13_1(var_5(arg_13_0.btnStart, "tip"), var_13_2 > 0)

	setText = var_13_1

	var_13_1(arg_13_0.textLastTimes, var_13_2)

	for iter_13_0 = 1, 7 do
		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_current"), false)

		if iter_13_0 <= var_13_0 then
			SetParent = var_1_10008
			var_1_10009 = arg_13_0.dropItems[iter_13_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_13_0.battleItems[iter_13_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_13_0.dropItems[iter_13_0], true)

			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_clear"), true)
		elseif iter_13_0 == var_13_0 + 1 and 1 <= var_13_2 then
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_13_0.dropItems[iter_13_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_13_0.battleItems[iter_13_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_13_0.dropItems[iter_13_0], true)
		elseif var_13_0 < iter_13_0 and iter_13_0 <= var_13_0 + var_13_2 then
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_13_0.dropItems[iter_13_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_13_0.battleItems[iter_13_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_13_0.dropItems[iter_13_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_13_0.battleItems[iter_13_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_13_0.dropItems[iter_13_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_13_0.battleItems[iter_13_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_13_0.dropItems[iter_13_0], true)
		end
	end

	local var_13_3 = 1 - (var_13_0 - 3 < 0 and 0 or var_13_0 - 3) / (arg_13_0.totalTimes - 4)

	if 1 < var_13_3 then
		var_13_3 = 1
	end

	scrollTo = var_6

	var_6(arg_13_0.battleScrollRect, 0, var_13_3)

	return
end

function var_0_0.CheckGet(arg_14_0)
	local var_14_0 = arg_14_0.mgHubData

	setActive = var_1_10002
	findTF = var_1_10003

	var_1_10002(var_1_10003(arg_14_0.menuUI, "got"), false)

	local var_14_1 = arg_14_0

	if arg_14_0.getUltimate(var_14_1, var_14_0) and var_2 ~= 0 then
		setActive = var_14_1
		findTF = var_4

		var_14_1(var_4(arg_14_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		local var_14_2 = var_0_1.total_times
		local var_14_3 = arg_14_0

		if var_14_2 > arg_14_0.getGameUsedTimes(var_14_3, var_14_0) then
			return
		end

		pg = var_14_3

		local var_14_4 = var_14_3.m02
		local var_14_5 = var_5.sendNotification

		GAME = var_1_10007

		local var_14_6 = var_1_10007.SEND_MINI_GAME_OP
		local var_14_7 = {
			hubid = var_14_0.id
		}

		MiniGameOPCommand = var_9
		var_14_7.cmd = var_9.CMD_ULTIMATE
		var_14_7.args1 = {}

		var_14_5(var_14_4, var_14_6, var_14_7)

		setActive = var_14_5
		findTF = var_14_4

		var_14_5(var_14_4(arg_14_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_15_0, arg_15_1)
	return arg_15_1.count
end

function var_0_0.getGameUsedTimes(arg_16_0, arg_16_1)
	return arg_16_1.usedtime
end

function var_0_0.getUltimate(arg_17_0, arg_17_1)
	return arg_17_1.ultimate
end

return var_0_0
