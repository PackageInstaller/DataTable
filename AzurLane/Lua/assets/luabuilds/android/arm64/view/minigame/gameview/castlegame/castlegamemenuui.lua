class = var_0_10000

local var_0_0 = var_0_10000("CastleGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.menuUI = var_1_10003(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_3
	findTF = var_5

	local var_1_0 = var_5(arg_1_0.menuUI, "battList")

	typeof = var_6
	ScrollRect = var_8
	arg_1_0.battleScrollRect = var_3(var_1_0, var_6(var_8))
	CastleGameVo = var_3
	arg_1_0.totalTimes = var_3.total_times
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

		BeachGuardGameView = var_2_10003

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

		BeachGuardGameView = var_2_10003

		var_5_1(var_5_0, var_2_10003.SHOW_RULE)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_10, var_1_11, var_1_12, var_8)

	onButton = var_3

	local var_1_13 = arg_1_0._event

	findTF = var_1_11

	local var_1_14 = var_1_11(arg_1_0.menuUI, "btnStart")

	local function var_1_15()
		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_6_1(var_6_0, var_2_10003.READY_START)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_13, var_1_14, var_1_15, var_8)

	findTF = var_3

	local var_1_16 = var_3(arg_1_0.menuUI, "tplBattleItem")

	CastleGameVo = var_1_10004

	local var_1_17 = var_1_10004.drop

	for iter_1_0 = 1, 7 do
		tf = var_1_18
		instantiate = var_1_10011

		local var_1_18 = var_1_18(var_1_10011(var_1_16))

		var_1_18.name = "battleItem_" .. iter_1_0
		setParent = var_10

		local var_1_19 = var_1_18

		findTF = var_13

		var_10(var_1_19, var_13(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_20 = iter_1_0

		GetSpriteFromAtlasAsync = var_1_10011
		CastleGameVo = var_13

		var_1_10011(var_13.ui_atlas, "battleDesc" .. var_1_20, function(arg_7_0)
			if arg_7_0 then
				setImageSprite = var_2_10001
				findTF = var_2_10003

				var_2_10001(var_2_10003(var_1_18, "state_open/desc"), arg_7_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_18, "state_clear/desc"), arg_7_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_18, "state_current/desc"), arg_7_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_18, "state_closed/desc"), arg_7_0, true)
			end

			return
		end)

		findTF = var_1_10011
		var_1_10011 = var_1_10011(var_1_18, "icon")

		local var_1_21 = {
			type = var_1_17[iter_1_0][1],
			id = var_1_17[iter_1_0][2],
			amount = var_1_17[iter_1_0][3]
		}

		updateDrop = var_13

		var_13(var_1_10011, var_1_21)

		onButton = var_13

		local var_1_22 = arg_1_0._event
		local var_1_23 = var_1_10011

		local function var_1_24()
			local var_8_0 = arg_1_0._event
			local var_8_1 = var_0.emit

			BaseUI = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_DROP, var_1_21)

			return
		end

		SFX_PANEL = var_1_10018

		var_13(var_1_22, var_1_23, var_1_24, var_1_10018)

		table = var_13

		var_13.insert(arg_1_0.dropItems, var_1_10011)

		setActive = var_13

		var_13(var_1_18, true)

		table = var_13

		var_13.insert(arg_1_0.battleItems, var_1_18)
	end

	return
end

function var_0_0.show(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.menuUI, arg_9_1)

	return
end

function var_0_0.update(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getGameUsedTimes(arg_10_1)
	local var_10_1 = arg_10_0:getGameTimes(arg_10_1)

	for iter_10_0 = 1, #arg_10_0.battleItems do
		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_current"), false)

		if iter_10_0 <= var_10_0 then
			SetParent = var_1_10008
			var_1_10010 = arg_10_0.dropItems[iter_10_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_10_0.battleItems[iter_10_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_10_0.dropItems[iter_10_0], true)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_clear"), true)
		elseif iter_10_0 == var_10_0 + 1 and 1 <= var_10_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_10_0.dropItems[iter_10_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_10_0.battleItems[iter_10_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_10_0.dropItems[iter_10_0], true)
		elseif var_10_0 < iter_10_0 and iter_10_0 <= var_10_0 + var_10_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_10_0.dropItems[iter_10_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_10_0.battleItems[iter_10_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_10_0.dropItems[iter_10_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_10_0.battleItems[iter_10_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_10_0.dropItems[iter_10_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_10_0.battleItems[iter_10_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_10_0.dropItems[iter_10_0], true)
		end
	end

	local var_10_2 = 1 - (var_10_0 - 3 < 0 and 0 or var_10_0 - 3) / (arg_10_0.totalTimes - 4)

	if 1 < var_10_2 then
		var_10_2 = 1
	end

	scrollTo = var_6

	var_6(arg_10_0.battleScrollRect, 0, var_10_2)

	setActive = var_6
	findTF = var_8

	var_6(var_8(arg_10_0.menuUI, "btnStart/tip"), var_10_1 > 0)
	arg_10_0:CheckGet(arg_10_1)

	return
end

function var_0_0.CheckGet(arg_11_0, arg_11_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_11_0.menuUI, "got"), false)

	if arg_11_0:getUltimate(arg_11_1) and var_2 ~= 0 then
		setActive = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_11_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		CastleGameVo = var_1_10003

		if var_1_10003.total_times > arg_11_0:getGameUsedTimes(arg_11_1) then
			return
		end

		pg = var_5

		local var_11_0 = var_5.m02
		local var_11_1 = var_5.sendNotification

		GAME = var_1_10008

		local var_11_2 = var_1_10008.SEND_MINI_GAME_OP
		local var_11_3 = {
			hubid = arg_11_1.id
		}

		MiniGameOPCommand = var_10
		var_11_3.cmd = var_10.CMD_ULTIMATE
		var_11_3.args1 = {}

		var_11_1(var_11_0, var_11_2, var_11_3)

		setActive = var_11_1
		findTF = var_11_0

		var_11_1(var_11_0(arg_11_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_12_0, arg_12_1)
	return arg_12_1.count
end

function var_0_0.getGameUsedTimes(arg_13_0, arg_13_1)
	return arg_13_1.usedtime
end

function var_0_0.getUltimate(arg_14_0, arg_14_1)
	return arg_14_1.ultimate
end

return var_0_0
