class = var_0_10000

local var_0_0 = var_0_10000("BoatAdGameMenuUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
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
	arg_1_0.lastText = var_3(arg_1_0.menuUI, "last/text")
	GetComponent = var_3
	findTF = var_4

	local var_1_1 = var_4(arg_1_0.menuUI, "desc")

	typeof = var_5
	Image = var_6

	local var_1_2 = var_3(var_1_1, var_5(var_6))

	var_3.SetNativeSize(var_1_2)

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
		local var_4_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_4_1(var_4_0, var_2_10002.CLOSE_GAME)

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
		local var_5_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_5_1(var_5_0, var_2_10002.SHOW_RULE)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_12, var_1_13, var_1_14, var_7)

	findTF = var_3
	arg_1_0.btnStart = var_3(arg_1_0.menuUI, "btnStart")
	onButton = var_3

	local var_1_15 = arg_1_0._event

	findTF = var_5

	local var_1_16 = var_5(arg_1_0.menuUI, "btnStart")

	local function var_1_17()
		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_6_1(var_6_0, var_2_10002.READY_START)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_15, var_1_16, var_1_17, var_7)

	onButton = var_3

	local var_1_18 = arg_1_0._event

	findTF = var_1_16

	local var_1_19 = var_1_16(arg_1_0.menuUI, "btnHome")

	local function var_1_20()
		local var_7_0 = arg_1_0._event
		local var_7_1 = var_0.emit

		SimpleMGEvent = var_2_10002

		var_7_1(var_7_0, var_2_10002.BACK_HOME)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_18, var_1_19, var_1_20, var_7)

	findTF = var_3

	local var_1_21 = var_3(arg_1_0.menuUI, "tplBattleItem")

	if var_0_1.drop and #var_4 > 0 then
		for iter_1_0 = 1, 7 do
			local var_1_22 = iter_1_0

			tf = var_1_10010
			instantiate = var_1_10011
			var_1_10010 = var_1_10010(var_1_10011(var_1_21))
			var_1_10010.name = "battleItem_" .. iter_1_0
			setParent = var_1_10011

			local var_1_23 = var_1_10010

			findTF = var_1_10013

			var_1_10011(var_1_23, var_1_10013(arg_1_0.menuUI, "battList/Viewport/Content"))

			var_1_10011 = iter_1_0
			GetSpriteFromAtlasAsync = var_1_23

			var_1_23(var_0_1.ui_atlas, "battleDesc" .. var_1_10011, function(arg_8_0)
				if arg_8_0 then
					setImageSprite = var_2_10001
					findTF = var_2_10002

					var_2_10001(var_2_10002(var_1_10010, "state_open/desc"), arg_8_0, true)

					setImageSprite = var_2_10001
					findTF = var_2

					var_2_10001(var_2(var_1_10010, "state_clear/desc"), arg_8_0, true)

					setImageSprite = var_2_10001
					findTF = var_2

					var_2_10001(var_2(var_1_10010, "state_current/desc"), arg_8_0, true)

					setImageSprite = var_2_10001
					findTF = var_2

					var_2_10001(var_2(var_1_10010, "state_closed/desc"), arg_8_0, true)
				end

				return
			end)

			findTF = var_1_23

			local var_1_24 = var_1_23(var_1_10010, "icon")

			var_1_10013 = {
				type = var_4[iter_1_0][1],
				id = var_4[iter_1_0][2],
				amount = var_4[iter_1_0][3]
			}
			updateDrop = var_14

			var_14(var_1_24, var_1_10013)

			onButton = var_14

			local var_1_25 = arg_1_0._event
			local var_1_26 = var_1_24

			local function var_1_27()
				local var_9_0 = arg_1_0._event
				local var_9_1 = var_0.emit

				BaseUI = var_2_10002

				var_9_1(var_9_0, var_2_10002.ON_DROP, var_1_10013)

				return
			end

			SFX_PANEL = var_1_10018

			var_14(var_1_25, var_1_26, var_1_27, var_1_10018)

			table = var_14

			var_14.insert(arg_1_0.dropItems, var_1_24)

			setActive = var_14

			var_14(var_1_10010, true)

			table = var_14

			var_14.insert(arg_1_0.battleItems, var_1_10010)
		end
	end

	return
end

function var_0_0.show(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.menuUI, arg_10_1)

	return
end

function var_0_0.update(arg_11_0, arg_11_1)
	setText = var_1_10002

	var_1_10002(arg_11_0.lastText, var_0_1.GetGameTimes())

	arg_11_0.mgHubData = arg_11_1

	if #arg_11_0.battleItems <= 0 then
		return
	end

	local var_11_0 = arg_11_0:getGameUsedTimes(arg_11_1)
	local var_11_1 = arg_11_0:getGameTimes(arg_11_1)

	for iter_11_0 = 1, #arg_11_0.battleItems do
		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10009

		var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_current"), false)

		if iter_11_0 <= var_11_0 then
			SetParent = var_1_10008
			var_1_10009 = arg_11_0.dropItems[iter_11_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_11_0.battleItems[iter_11_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)

			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_clear"), true)
		elseif iter_11_0 == var_11_0 + 1 and 1 <= var_11_1 then
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_11_0.dropItems[iter_11_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_11_0.battleItems[iter_11_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
		elseif var_11_0 < iter_11_0 and iter_11_0 <= var_11_0 + var_11_1 then
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_11_0.dropItems[iter_11_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_11_0.battleItems[iter_11_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(arg_11_0.battleItems[iter_11_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10009 = arg_11_0.dropItems[iter_11_0]
			findTF = var_10

			var_1_10008(var_1_10009, var_10(arg_11_0.battleItems[iter_11_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_11_0.dropItems[iter_11_0], true)
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
	findTF = var_1_10003

	var_1_10002(var_1_10003(arg_12_0.menuUI, "got"), false)

	local var_12_1 = arg_12_0

	if arg_12_0.getUltimate(var_12_1, var_12_0) and var_2 ~= 0 then
		setActive = var_12_1
		findTF = var_4

		var_12_1(var_4(arg_12_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		local var_12_2 = var_0_1.total_times
		local var_12_3 = arg_12_0

		if var_12_2 > arg_12_0.getGameUsedTimes(var_12_3, var_12_0) then
			return
		end

		pg = var_12_3

		local var_12_4 = var_12_3.m02
		local var_12_5 = var_5.sendNotification

		GAME = var_1_10007

		local var_12_6 = var_1_10007.SEND_MINI_GAME_OP
		local var_12_7 = {
			hubid = var_12_0.id
		}

		MiniGameOPCommand = var_9
		var_12_7.cmd = var_9.CMD_ULTIMATE
		var_12_7.args1 = {}

		var_12_5(var_12_4, var_12_6, var_12_7)

		setActive = var_12_5
		findTF = var_12_4

		var_12_5(var_12_4(arg_12_0.menuUI, "got"), true)
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
