class = var_0_10000

local var_0_0 = var_0_10000("SailBoatGameMenuUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.menuUI = var_1_10003(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_3
	findTF = var_5

	local var_1_0 = var_5(arg_1_0.menuUI, "battList")

	typeof = var_6
	ScrollRect = var_8
	arg_1_0.battleScrollRect = var_3(var_1_0, var_6(var_8))
	arg_1_0.totalTimes = var_0_1.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	onButton = var_3

	local var_1_1 = arg_1_0._event

	findTF = var_6

	local var_1_2 = var_6(arg_1_0.menuUI, "rightPanelBg/arrowUp")

	local function var_1_3()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if 1 < var_2_0 then
			var_2_0 = 1
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_1, var_1_2, var_1_3, var_8)

	onButton = var_3

	local var_1_4 = arg_1_0._event

	findTF = var_1_2

	local var_1_5 = var_1_2(arg_1_0.menuUI, "rightPanelBg/arrowDown")

	local function var_1_6()
		local var_3_0

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_4, var_1_5, var_1_6, var_8)

	onButton = var_3

	local var_1_7 = arg_1_0._event

	findTF = var_1_5

	local var_1_8 = var_1_5(arg_1_0.menuUI, "btnBack")

	local function var_1_9()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		SailBoatGameView = var_2_10003

		var_4_1(var_4_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_7, var_1_8, var_1_9, var_8)

	onButton = var_3

	local var_1_10 = arg_1_0._event

	findTF = var_1_8

	local var_1_11 = var_1_8(arg_1_0.menuUI, "btnRule")

	local function var_1_12()
		local var_5_0 = arg_1_0._event
		local var_5_1 = var_0.emit

		SailBoatGameView = var_2_10003

		var_5_1(var_5_0, var_2_10003.SHOW_RULE)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_10, var_1_11, var_1_12, var_8)

	findTF = var_3
	arg_1_0.btnStart = var_3(arg_1_0.menuUI, "btnStart")
	onButton = var_3

	local var_1_13 = arg_1_0._event

	findTF = var_6

	local var_1_14 = var_6(arg_1_0.menuUI, "btnStart")

	local function var_1_15()
		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		SailBoatGameView = var_2_10003

		var_6_1(var_6_0, var_2_10003.OPEN_EQUIP_UI)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_13, var_1_14, var_1_15, var_8)

	findTF = var_3

	local var_1_16 = var_3(arg_1_0.menuUI, "tplBattleItem")
	local var_1_17 = var_0_1.drop

	arg_1_0._chapters = {}

	for iter_1_0 = 1, 7 do
		local var_1_18 = iter_1_0

		tf = var_1_10010
		instantiate = var_1_10012
		var_1_10010 = var_1_10010(var_1_10012(var_1_16))
		var_1_10010.name = "battleItem_" .. iter_1_0
		setParent = var_11

		local var_1_19 = var_1_10010

		findTF = var_14

		var_11(var_1_19, var_14(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_20 = iter_1_0

		findTF = var_1_10012
		var_1_10012 = var_1_10012(var_1_10010, "icon")

		local var_1_21 = {
			type = var_1_17[iter_1_0][1],
			id = var_1_17[iter_1_0][2],
			amount = var_1_17[iter_1_0][3]
		}

		updateDrop = var_14

		var_14(var_1_10012, var_1_21)

		onButton = var_14

		local var_1_22 = arg_1_0._event
		local var_1_23 = var_1_10012

		local function var_1_24()
			local var_7_0 = arg_1_0._event
			local var_7_1 = var_0.emit

			BaseUI = var_2_10003

			var_7_1(var_7_0, var_2_10003.ON_DROP, var_1_21)

			return
		end

		SFX_PANEL = var_1_10019

		var_14(var_1_22, var_1_23, var_1_24, var_1_10019)

		table = var_14

		var_14.insert(arg_1_0.dropItems, var_1_10012)

		setActive = var_14

		var_14(var_1_10010, true)

		table = var_14

		var_14.insert(arg_1_0.battleItems, var_1_10010)

		local var_1_25 = var_0_1.GetGameUseTimes()
		local var_1_26 = var_0_1.GetGameTimes()

		findTF = var_16

		local var_1_27 = var_16(arg_1_0.menuUI, "chapter/" .. iter_1_0 .. "/icon_bg/icon")
		local var_1_28 = {
			type = var_1_17[iter_1_0][1],
			id = var_1_17[iter_1_0][2],
			amount = var_1_17[iter_1_0][3]
		}

		updateDrop = var_18

		var_18(var_1_27, var_1_28)

		onButton = var_18

		local var_1_29 = arg_1_0._event
		local var_1_30 = var_1_27

		local function var_1_31()
			local var_8_0 = arg_1_0._event
			local var_8_1 = var_0.emit

			BaseUI = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_DROP, var_1_28)

			return
		end

		SFX_PANEL = var_1_10023

		var_18(var_1_29, var_1_30, var_1_31, var_1_10023)

		findTF = var_18

		local var_1_32 = var_18(arg_1_0.menuUI, "chapter/" .. iter_1_0)

		onButton = var_1_10019

		local var_1_33 = arg_1_0._event
		local var_1_34 = var_1_32

		function var_1_10023()
			if var_1_25 == 7 and var_1_26 == 0 then
				var_0_1.selectRound = var_1_20

				local var_9_0 = arg_1_0

				var_0.update(var_9_0, arg_1_0.mgHubData)
			end

			return
		end

		SFX_CONFIRM = var_1_10024

		var_1_10019(var_1_33, var_1_34, var_1_10023, var_1_10024)

		table = var_1_10019

		var_1_10019.insert(arg_1_0._chapters, var_1_32)
	end

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.menuUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0, arg_11_1)
	arg_11_0.mgHubData = arg_11_1

	local var_11_0 = arg_11_0:getGameUsedTimes(arg_11_1)
	local var_11_1 = arg_11_0:getGameTimes(arg_11_1)

	for iter_11_0 = 1, 7 do
		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_current"), false)

		if iter_11_0 <= var_11_0 then
			SetParent = var_1_10008
			var_1_10010 = arg_11_0.dropItems[iter_11_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_11_0.battleItems[iter_11_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_clear"), true)
		elseif iter_11_0 == var_11_0 + 1 and 1 <= var_11_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_11_0.dropItems[iter_11_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_11_0.battleItems[iter_11_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_11_0.dropItems[iter_11_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_11_0.battleItems[iter_11_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0.battleItems[iter_11_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_11_0.dropItems[iter_11_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_11_0.battleItems[iter_11_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
		end

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "close"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "got"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "active"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "icon_bg"), false)

		if iter_11_0 <= var_11_0 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "got"), true)
		elseif iter_11_0 == var_11_0 + 1 and 1 <= var_11_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "active"), true)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "icon_bg"), true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			-- block empty
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "close"), true)
		end

		if var_0_1.selectRound == iter_11_0 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_11_0._chapters[iter_11_0], "active"), true)
		end
	end

	local var_11_2 = 1 - (var_11_0 - 3 < 0 and 0 or var_11_0 - 3) / (arg_11_0.totalTimes - 4)

	if 1 < var_11_2 then
		var_11_2 = 1
	end

	scrollTo = var_6

	var_6(arg_11_0.battleScrollRect, 0, var_11_2)

	return
end

function var_0_0.CheckGet(arg_12_0)
	local var_12_0 = arg_12_0.mgHubData

	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_12_0.menuUI, "got"), false)

	if arg_12_0:getUltimate(var_12_0) and var_2 ~= 0 then
		setActive = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_12_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		if var_0_1.total_times > arg_12_0:getGameUsedTimes(var_12_0) then
			return
		end

		pg = var_5

		local var_12_1 = var_5.m02
		local var_12_2 = var_5.sendNotification

		GAME = var_1_10008

		local var_12_3 = var_1_10008.SEND_MINI_GAME_OP
		local var_12_4 = {
			hubid = var_12_0.id
		}

		MiniGameOPCommand = var_10
		var_12_4.cmd = var_10.CMD_ULTIMATE
		var_12_4.args1 = {}

		var_12_2(var_12_1, var_12_3, var_12_4)

		setActive = var_12_2
		findTF = var_12_1

		var_12_2(var_12_1(arg_12_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_13_0, arg_13_1)
	return arg_13_1.count
end

function var_0_0.getGameUsedTimes(arg_14_0, arg_14_1)
	return arg_14_1.usedtime
end

function var_0_0.getUltimate(arg_15_0, arg_15_1)
	return arg_15_1.ultimate
end

return var_0_0
