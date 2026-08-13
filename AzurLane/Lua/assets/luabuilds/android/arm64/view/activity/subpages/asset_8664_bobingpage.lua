class = var_0_10000

local var_0_0 = "BobingPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_CH = var_1_10002

		if var_1_10001 == var_1_10002 then
			setActive = var_1_10001
			findTF = var_1_10003

			var_1_10001(var_1_10003(arg_1_0._tf, "bobing"), true)

			setActive = var_1_10001
			findTF = var_1_10003

			var_1_10001(var_1_10003(arg_1_0._tf, "lottery"), false)
		else
			setActive = var_1_10001
			findTF = var_1_10003

			var_1_10001(var_1_10003(arg_1_0._tf, "bobing"), false)

			setActive = var_1_10001
			findTF = var_3

			var_1_10001(var_3(arg_1_0._tf, "lottery"), true)
		end

		local var_1_0 = arg_1_0
		local var_1_1 = arg_1_0.bind

		ActivityMediator = var_1_10004

		var_1_1(var_1_0, var_1_10004.ON_BOBING_RESULT, function(arg_2_0, arg_2_1, arg_2_2)
			PLATFORM_CODE = var_2_10003
			PLATFORM_CHT = var_2_10004

			if var_2_10003 ~= var_2_10004 then
				PLATFORM_CODE = var_2_10003
				PLATFORM_CH = var_2_10004

				if var_2_10003 == var_2_10004 then
					local var_2_0 = arg_1_0

					var_3.displayBBResult(var_2_0, arg_2_1.awards, arg_2_1.numbers, function()
						arg_2_1.callback()

						return
					end)
				else
					local var_2_1 = arg_1_0

					var_3.displayLotteryAni(var_2_1, arg_2_1.awards, arg_2_1.numbers, function()
						arg_2_1.callback()

						return
					end)
				end

				return
			end
		end)

		return
	end
end

function var_0_1.OnUpdateFlush(arg_5_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_CH = var_1_10002

		if var_1_10001 == var_1_10002 then
			arg_5_0:bobingUpdate()
		else
			arg_5_0:lotteryUpdate()
		end

		return
	end
end

function var_0_1.lotteryUpdate(arg_6_0)
	local var_6_0 = arg_6_0.activity

	findTF = var_1_10002

	local var_6_1 = var_1_10002(arg_6_0._tf, "lottery/layer")
	local var_6_2

	if not arg_6_0.lotteryWrap then
		var_6_2 = {}
		findTF = var_4
		var_6_2.btnLotteryBtn = var_4(var_6_1, "lottery_btn")
		findTF = var_4
		var_6_2.phase = var_4(var_6_1, "phase")
		findTF = var_4
		var_6_2.nums = var_4(var_6_1, "nums")
		arg_6_0.lotteryWrap = var_6_2
	end

	if var_6_0:getConfig("config_id") <= var_6_0.data1 then
		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.phase, "bg"), false)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.phase, "Text"), false)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.phase, "finish"), true)
	else
		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.phase, "bg"), true)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.phase, "Text"), true)

		setText = var_5
		findTF = var_7

		local var_6_3 = var_7(var_6_2.phase, "Text")

		setColorStr = var_1_10008

		var_5(var_6_3, var_1_10008(var_6_0.data1, "FFD43F") .. "/" .. var_4)

		setActive = var_5
		findTF = var_6_3

		var_5(var_6_3(var_6_2.phase, "finish"), false)
	end

	if var_6_0.data2 < 1 then
		LeanTween = var_5

		local var_6_4 = var_5.alpha(var_6_2.btnLotteryBtn, 1, 1)

		var_5.setLoopPingPong(var_6_4)

		setActive = var_5
		findTF = var_6_4

		var_5(var_6_4(var_6_2.btnLotteryBtn, "mask"), false)

		onButton = var_5

		local var_6_5 = arg_6_0

		var_1_10008 = var_6_2.btnLotteryBtn

		function var_1_10009()
			if arg_6_0.activity.data2 < 1 then
				local var_7_0 = arg_6_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_7_1(var_7_0, var_2_10003.EVENT_OPERATION, {
					cmd = 1,
					activity_id = arg_6_0.activity.id
				})

				local var_7_2 = arg_6_0
				local var_7_3 = var_0.emit

				ActivityMainScene = var_3

				var_7_3(var_7_2, var_3.LOCK_ACT_MAIN, true)
			end

			return
		end

		SFX_PANEL = var_10

		var_5(var_6_5, var_1_10008, var_1_10009, var_10)
	else
		LeanTween = var_5

		var_5.cancel(var_6_2.btnLotteryBtn.gameObject)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_6_2.btnLotteryBtn, "mask"), true)

		local var_6_6 = arg_6_0:getIndexByNumbers(var_6_0.data1_list)

		setActive = var_6
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_6_2.btnLotteryBtn, "mask/1")
		var_1_10009 = var_6_6 == 1

		var_6(var_1_10008, var_1_10009)

		setActive = var_6
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_6_2.btnLotteryBtn, "mask/2")
		var_1_10009 = var_6_6 == 2

		var_6(var_1_10008, var_1_10009)

		setActive = var_6
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_6_2.btnLotteryBtn, "mask/3")
		var_1_10009 = var_6_6 == 3

		var_6(var_1_10008, var_1_10009)

		onButton = var_6
		var_1_10008 = arg_6_0
		var_1_10009 = var_6_2.btnLotteryBtn

		local function var_6_7()
			if arg_6_0.activity.data2 < 1 then
				local var_8_0 = arg_6_0
				local var_8_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_8_1(var_8_0, var_2_10003.EVENT_OPERATION, {
					cmd = 1,
					activity_id = arg_6_0.activity.id
				})

				local var_8_2 = arg_6_0
				local var_8_3 = var_0.emit

				ActivityMainScene = var_3

				var_8_3(var_8_2, var_3.LOCK_ACT_MAIN, true)
			end

			return
		end

		SFX_PANEL = var_11

		var_6(var_1_10008, var_1_10009, var_6_7, var_11)
	end

	local var_6_8 = var_6_0.data2 == 0 and "FFD43F" or "d2d4db"

	setText = var_6
	findTF = var_1_10008

	local var_6_9 = var_1_10008(var_6_2.nums, "text")

	string = var_1_10009

	var_6(var_6_9, var_1_10009.format("<color=#%s>%s</color> / %s", var_6_8, 1 - var_6_0.data2, 1))

	return
end

function var_0_1.getIndexByNumbers(arg_9_0, arg_9_1)
	ActivityConst = var_1_10002

	local var_9_0 = var_1_10002.BBRule(arg_9_1)
	local var_9_1 = 3

	if var_9_0 and var_9_0 >= 1 and var_9_0 <= 2 then
		var_9_1 = 1
	end

	if var_9_0 and var_9_0 >= 3 and var_9_0 <= 4 then
		var_9_1 = 2
	end

	return var_9_1
end

function var_0_1.displayLotteryAni(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getIndexByNumbers(arg_10_2)

	findTF = var_1_10005

	local var_10_1 = var_1_10005(arg_10_0._tf, "lottery")
	local var_10_2 = var_5.Find(var_10_1, "omikuji_anim")
	local var_10_3 = var_6.GetComponent

	typeof = var_9
	DftAniEvent = var_1_10011

	local var_10_4 = var_10_3(var_10_2, var_9(var_1_10011))

	var_6.SetEndEvent(var_10_4, function(arg_11_0)
		setActive = var_2_10001

		var_2_10001(var_0.gameObject, false)

		local var_11_0 = var_0
		local var_11_1 = var_1.Find(var_11_0, "omikuji_result")

		setActive = var_2_10002

		var_2_10002(var_11_1, true)

		local var_11_2 = var_11_1:Find("title")

		for iter_11_0 = 1, var_11_2.childCount do
			setActive = var_2_10007

			local var_11_3 = var_11_2:GetChild(iter_11_0 - 1)

			var_2_10010 = iter_11_0 == var_10_0

			var_2_10007(var_11_3, var_2_10010)
		end

		local var_11_4 = var_11_1
		local var_11_5 = var_11_1.Find(var_11_4, "desc")
		local var_11_6 = {
			"big",
			"medium",
			"little"
		}

		i18n = var_11_4

		local var_11_7 = "draw_"
		local var_11_8 = var_11_6[var_10_0]
		local var_11_9 = "_luck_"

		math = var_2_10010

		local var_11_10 = var_11_4(var_11_7 .. var_11_8 .. var_11_9 .. var_2_10010.random(1, 3))

		setText = var_6

		var_6(var_11_5, var_11_10)

		local var_11_11 = var_11_1
		local var_11_12 = var_11_1.Find(var_11_11, "award")
		local var_11_13 = var_11_1:Find("award_list")

		setActive = var_11_11

		var_11_11(var_11_12, false)

		removeAllChildren = var_11_11

		var_11_11(var_11_13)

		if arg_10_1 then
			ipairs = var_8

			for iter_11_1, iter_11_2 in var_8(arg_10_1) do
				cloneTplTo = var_11_14

				local var_11_14 = var_11_14(var_11_12, var_11_13)
				local var_11_15 = {
					type = iter_11_2.type,
					id = iter_11_2.id,
					count = iter_11_2.count
				}

				updateDrop = var_15

				var_15(var_11_14, var_11_15)

				onButton = var_15

				local var_11_16 = arg_10_0
				local var_11_17 = var_11_14

				local function var_11_18()
					local var_12_0 = arg_10_0
					local var_12_1 = var_0.emit

					BaseUI = var_3_10003

					var_12_1(var_12_0, var_3_10003.ON_DROP, var_11_15)

					return
				end

				SFX_PANEL = var_2_10020

				var_15(var_11_16, var_11_17, var_11_18, var_2_10020)
			end
		end

		local var_11_19 = arg_10_0
		local var_11_20 = var_8.emit

		ActivityMainScene = iter_11_1

		var_11_20(var_11_19, iter_11_1.LOCK_ACT_MAIN, false)

		onButton = var_11_20

		var_11_20(arg_10_0, var_11_1, function()
			setActive = var_3_10000

			var_3_10000(var_11_1, false)
			arg_10_3()

			return
		end)

		return
	end)

	setActive = var_7

	var_7(var_6.gameObject, true)

	return
end

function var_0_1.bobingUpdate(arg_14_0)
	local var_14_0 = arg_14_0.activity

	findTF = var_1_10002

	local var_14_1 = var_1_10002(arg_14_0._tf, "bobing")
	local var_14_2, var_14_10

	if not arg_14_0.bobingWrap then
		var_14_2 = {}

		local var_14_3 = arg_14_0._tf

		var_14_2.bg = var_4.Find(var_14_3, "AD")
		var_14_2.progress = var_14_1:Find("award/nums")
		var_14_2.get = var_14_1:Find("award/get")
		var_14_2.nums = var_14_1:Find("nums/text")
		var_14_2.bowlDisable = var_14_1:Find("bowl_disable")
		var_14_2.bowlEnable = var_14_1:Find("bowl_enable")

		local var_14_4 = var_14_2.bowlEnable

		var_14_2.bowlShine = var_4.Find(var_14_4, "bowl_shine")
		var_14_2.btnRule = var_14_1:Find("btnRule")
		var_14_2.layerRule = var_14_1:Find("rule")

		local var_14_5 = var_14_2.layerRule

		var_14_2.btnReturn = var_4.Find(var_14_5, "btnReturn")

		local var_14_6 = var_14_2.layerRule

		var_14_2.item = var_4.Find(var_14_6, "item")

		local var_14_7 = var_14_2.layerRule

		var_14_2.top = var_4.Find(var_14_7, "top")

		local var_14_8 = var_14_2.layerRule

		var_14_2.itemRow = var_4.Find(var_14_8, "row")

		local var_14_9 = var_14_2.layerRule

		var_14_2.itemColumn = var_4.Find(var_14_9, "column")
		setActive = var_4

		var_4(var_14_2.layerRule, false)

		setActive = var_4

		var_4(var_14_2.item, false)

		setActive = var_4

		var_4(var_14_2.itemRow, false)

		setActive = var_4

		var_4(var_14_2.itemColumn, true)

		pg = var_4
		var_14_10 = var_4.gameset.bb_front_awards.description[1]
		_ = var_6

		local var_14_11 = var_6.slice(var_4, 2, #var_4 - 1)

		UIItemList = var_7

		local var_14_12 = var_7.New(var_14_2.top, var_14_2.item)

		var_7.make(var_14_12, function(arg_15_0, arg_15_1, arg_15_2)
			UIItemList = var_2_10003

			if arg_15_0 == var_2_10003.EventUpdate then
				local var_15_0 = {
					type = var_14_10[arg_15_1 + 1][1],
					id = var_14_10[arg_15_1 + 1][2],
					count = var_14_10[arg_15_1 + 1][3]
				}

				updateDrop = var_4

				var_4(arg_15_2, var_15_0)

				onButton = var_4

				local var_15_1 = arg_14_0
				local var_15_2 = arg_15_2

				local function var_15_3()
					local var_16_0 = arg_14_0
					local var_16_1 = var_0.emit

					BaseUI = var_3_10003

					var_16_1(var_16_0, var_3_10003.ON_DROP, var_15_0)

					return
				end

				SFX_PANEL = var_2_10009

				var_4(var_15_1, var_15_2, var_15_3, var_2_10009)
			end

			return
		end)
		var_7:align(#var_14_10)

		UIItemList = var_8

		local var_14_13 = var_8.New(var_14_2.itemColumn, var_14_2.itemRow)

		var_8.make(var_14_13, function(arg_17_0, arg_17_1, arg_17_2)
			UIItemList = var_2_10003

			if arg_17_0 == var_2_10003.EventUpdate then
				local var_17_0 = var_14_11[arg_17_1 + 1]

				UIItemList = var_4

				local var_17_1 = var_4.New(arg_17_2, var_14_2.item)

				var_4.make(var_17_1, function(arg_18_0, arg_18_1, arg_18_2)
					UIItemList = var_3_10003

					if arg_18_0 == var_3_10003.EventUpdate then
						local var_18_0 = {
							type = var_17_0[arg_18_1 + 1][1],
							id = var_17_0[arg_18_1 + 1][2],
							count = var_17_0[arg_18_1 + 1][3]
						}

						updateDrop = var_4

						var_4(arg_18_2, var_18_0)

						onButton = var_4

						local var_18_1 = arg_14_0
						local var_18_2 = arg_18_2

						local function var_18_3()
							local var_19_0 = arg_14_0
							local var_19_1 = var_0.emit

							BaseUI = var_4_10003

							var_19_1(var_19_0, var_4_10003.ON_DROP, var_18_0)

							return
						end

						SFX_PANEL = var_3_10009

						var_4(var_18_1, var_18_2, var_18_3, var_3_10009)
					end

					return
				end)
				var_4:align(#var_17_0)
			end

			return
		end)
		var_8:align(#var_14_11)

		onButton = var_9

		local var_14_14 = arg_14_0

		var_1_10012 = var_14_2.btnRule

		local function var_14_15()
			setActive = var_2_10000

			var_2_10000(var_14_2.layerRule, true)

			return
		end

		SFX_PANEL = var_1_10014

		var_9(var_14_14, var_1_10012, var_14_15, var_1_10014)

		onButton = var_9

		local var_14_16 = arg_14_0

		var_1_10012 = var_14_2.btnReturn

		local function var_14_17()
			setActive = var_2_10000

			var_2_10000(var_14_2.layerRule, false)

			return
		end

		SFX_CANCEL = var_1_10014

		var_9(var_14_16, var_1_10012, var_14_17, var_1_10014)

		onButton = var_9

		local var_14_18 = arg_14_0

		var_1_10012 = var_14_2.bowlEnable

		local function var_14_19()
			local var_22_0 = arg_14_0
			local var_22_1 = var_0.emit

			ActivityMainScene = var_2_10003

			var_22_1(var_22_0, var_2_10003.LOCK_ACT_MAIN, true)

			local var_22_2 = arg_14_0

			var_0.displayBBAnim(var_22_2, function()
				local var_23_0 = arg_14_0
				local var_23_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_23_1(var_23_0, var_3_10003.EVENT_OPERATION, {
					cmd = 1,
					activity_id = var_14_0.id
				})

				return
			end)

			return
		end

		SFX_PANEL = var_1_10014

		var_9(var_14_18, var_1_10012, var_14_19, var_1_10014)

		arg_14_0.bobingWrap = var_14_2
	end

	local var_14_20 = var_14_0:getConfig("config_id")

	setActive = var_14_10

	var_14_10(var_14_2.layerRule, false)

	setActive = var_14_10

	var_14_10(var_14_2.get, var_14_20 <= var_14_0.data1)

	setActive = var_14_10

	var_14_10(var_14_2.bowlDisable, var_14_0.data2 == 0)

	setActive = var_14_10

	var_14_10(var_14_2.bowlEnable, var_14_0.data2 > 0)

	if var_14_0.data2 < 1 then
		LeanTween = var_5

		local var_14_21 = var_5.alpha(var_14_2.bowlShine, 1, 1)

		var_5.setLoopPingPong(var_14_21)
	else
		LeanTween = var_5

		var_5.cancel(var_14_2.bowlShine.gameObject)
	end

	setText = var_5

	local var_14_22 = var_14_2.progress

	string = var_8

	local var_14_23 = var_8.format
	local var_14_24 = "<color=#%s>%s</color> %s"
	local var_14_25 = "FFD43F"

	math = var_1_10012

	var_5(var_14_22, var_14_23(var_14_24, var_14_25, var_1_10012.min(var_14_0.data1, var_14_20) .. "/", var_14_20))

	local var_14_26 = var_14_0.data2 == 0 and "FFD43F" or "d2d4db"

	setActive = var_6

	var_6(var_14_2.progress, var_14_20 > var_14_0.data1)

	setText = var_6

	local var_14_27 = var_14_2.nums

	string = var_9

	var_6(var_14_27, var_9.format("<color=#%s>%s</color>", var_14_26, var_14_0.data2))

	return
end

function var_0_1.displayBBAnim(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._tf
	local var_24_1 = var_2.Find(var_24_0, "bobing/bb_anim")
	local var_24_2 = var_2.Find(var_24_1, "ship")
	local var_24_3 = var_2:Find("bowl")

	if not arg_24_0.animBowl then
		local var_24_4 = var_24_3
		local var_24_5 = var_24_3.GetComponent

		typeof = var_1_10008
		SpineAnimUI = var_1_10010
		arg_24_0.animBowl = var_24_5(var_24_4, var_1_10008(var_1_10010))

		local var_24_6 = arg_24_0.animBowl

		var_5.SetAction(var_24_6, "bobing", 0)

		local var_24_7 = arg_24_0.animBowl

		var_5.SetActionCallBack(var_24_7, function(arg_25_0)
			if arg_25_0 == "finsih" then
				setActive = var_2_10001

				var_2_10001(var_24_2, false)

				setActive = var_2_10001

				var_2_10001(var_24_3, false)
				arg_24_1()
			end

			return
		end)
	end

	local function var_24_8()
		setActive = var_2_10000

		var_2_10000(var_24_2, true)

		setActive = var_2_10000

		var_2_10000(var_24_3, true)

		local var_26_0 = arg_24_0.model
		local var_26_1 = var_0.GetComponent

		typeof = var_3
		SpineAnimUI = var_2_10005

		local var_26_2 = var_26_1(var_26_0, var_3(var_2_10005))

		var_0.SetAction(var_26_2, "victory", 0)

		return
	end

	if not arg_24_0.model then
		getProxy = var_6
		PlayerProxy = var_1_10008

		local var_24_9 = var_6(var_1_10008)
		local var_24_10 = var_6.getRawData(var_24_9)

		getProxy = var_1_10008
		BayProxy = var_1_10010

		local var_24_11 = var_1_10008(var_1_10010)
		local var_24_12 = var_8.getShipById(var_24_11, var_24_10.character)

		PoolMgr = var_1_10010

		local var_24_13 = var_1_10010.GetInstance()

		var_10.GetSpineChar(var_24_13, var_24_12:getPrefab(), false, function(arg_27_0)
			arg_24_0.model = arg_27_0

			local var_27_0 = arg_24_0.model.transform

			Vector3 = var_2_10002
			var_27_0.localScale = var_2_10002(0.5, 0.5, 1)

			local var_27_1 = arg_24_0.model.transform

			var_1.SetParent(var_27_1, var_24_2, false)
			var_24_8()

			return
		end)
	else
		var_24_8()
	end

	setActive = var_6

	var_6(var_2, true)

	return
end

function var_0_1.displayBBResult(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	findTF = var_1_10004
	arg_28_0.animation = var_1_10004(arg_28_0._tf, "bobing")
	setActive = var_4

	local var_28_0 = arg_28_0.animation

	var_4(var_6.Find(var_28_0, "bb_anim"), false)

	local var_28_1 = arg_28_0.animation
	local var_28_2 = var_4.Find(var_28_1, "bb_result")
	local var_28_3 = var_4.Find(var_28_2, "numbers")
	local var_28_4 = var_4:Find("number")
	local var_28_5 = var_4
	local var_28_6 = var_4.Find(var_28_5, "rank")
	local var_28_7 = var_4:Find("bgRank")

	setActive = var_28_5

	var_28_5(var_28_4, false)

	local var_28_8 = var_4
	local var_28_9 = var_4.Find(var_28_8, "award")
	local var_28_10 = var_4:Find("award_list")

	setActive = var_28_8

	var_28_8(var_28_9, false)

	removeAllChildren = var_28_8

	var_28_8(var_28_10)

	if arg_28_1 then
		ipairs = var_28_8

		for iter_28_0, iter_28_1 in var_28_8(arg_28_1) do
			cloneTplTo = var_1_10016
			var_1_10016 = var_1_10016(var_28_9, var_28_10)

			local var_28_11 = {
				type = iter_28_1.type,
				id = iter_28_1.id,
				count = iter_28_1.count
			}

			updateDrop = var_18

			var_18(var_1_10016, var_28_11)

			onButton = var_18

			local var_28_12 = arg_28_0
			local var_28_13 = var_1_10016

			local function var_28_14()
				local var_29_0 = arg_28_0
				local var_29_1 = var_0.emit

				BaseUI = var_2_10003

				var_29_1(var_29_0, var_2_10003.ON_DROP, var_28_11)

				return
			end

			SFX_PANEL = var_1_10023

			var_18(var_28_12, var_28_13, var_28_14, var_1_10023)
		end
	end

	UIItemList = var_28_8

	local var_28_15 = var_28_8.New(var_28_3, var_28_4)

	var_11.make(var_28_15, function(arg_30_0, arg_30_1, arg_30_2)
		UIItemList = var_2_10003

		if arg_30_0 == var_2_10003.EventUpdate then
			local var_30_0 = arg_28_0

			var_3.setSpriteTo(var_30_0, "bobing/bb_icon/dice" .. arg_28_2[arg_30_1 + 1], arg_30_2)

			setImageAlpha = var_3

			var_3(arg_30_2, 0)
		end

		return
	end)
	var_11:align(#arg_28_2)

	ActivityConst = var_12

	local var_28_16 = var_12.BBRule(arg_28_2)

	setActive = var_13

	var_13(var_28_6, var_28_16 < 7)

	setActive = var_13

	var_13(var_28_7, var_28_16 < 7)

	local var_28_17

	if var_28_16 < 7 then
		var_28_17 = arg_28_0

		arg_28_0.setSpriteTo(var_28_17, "bobing/bb_icon/rank" .. var_28_16, var_28_6)

		setImageAlpha = var_13

		var_13(var_28_6, 0)
	end

	local var_28_18 = false

	LeanTween = var_14

	local var_28_19 = var_14.value

	go = var_16

	local var_28_20 = var_28_19(var_16(var_28_3), 0, 1, 1)
	local var_28_21 = var_14.setOnUpdate

	System = var_17

	local var_28_22 = var_28_21(var_28_20, var_17.Action_float(function(arg_31_0)
		local var_31_0 = var_0

		var_1.each(var_31_0, function(arg_32_0, arg_32_1)
			setImageAlpha = var_3_10002

			var_3_10002(arg_32_1, arg_31_0)

			return
		end)

		return
	end))
	local var_28_23

	if var_28_16 == 7 then
		var_28_23 = var_28_22
		var_28_17 = var_28_22.setOnComplete
		System = var_18

		var_28_17(var_28_23, var_18.Action(function()
			local var_33_0 = arg_28_0
			local var_33_1 = var_0.emit

			ActivityMainScene = var_2_10003

			var_33_1(var_33_0, var_2_10003.LOCK_ACT_MAIN, false)

			var_28_18 = true

			return
		end))
	else
		LeanTween = var_28_17
		var_28_17 = var_28_17.value
		go = var_28_23

		local var_28_24 = var_28_17(var_28_23(var_28_6), 0, 1, 0.2)
		local var_28_25 = var_28_17.setDelay(var_28_24, 1)

		var_28_17 = var_28_17.setOnUpdate
		System = var_18

		var_28_17(var_28_25, var_18.Action_float(function(arg_34_0)
			setImageAlpha = var_2_10001

			var_2_10001(var_28_6, arg_34_0)

			local var_34_0 = var_28_6

			Vector3 = var_2_10002

			local var_34_1 = var_2_10002.Lerp

			Vector3 = var_4

			local var_34_2 = var_4(2, 2, 2)

			Vector3 = var_2_10005
			var_34_0.localScale = var_34_1(var_34_2, var_2_10005.one, arg_34_0)

			return
		end))

		if not var_4:Find("rank_p") then
			cloneTplTo = var_28_20
			var_28_17 = var_28_20(var_28_6, var_4, "rank_p")
		end

		arg_28_0:setSpriteTo("bobing/bb_icon/rank" .. var_28_16, var_28_17)

		local var_28_26 = arg_28_0

		arg_28_0.setSpriteTo(var_28_26, "bobing/bb_icon/rank" .. var_28_16, var_28_6)

		LeanTween = var_16

		local var_28_27 = var_16.value

		go = var_28_26

		local var_28_28 = var_28_27(var_28_26(var_28_17), 1, 0, 0.3)
		local var_28_29 = var_16.setDelay(var_28_28, 1.5)
		local var_28_30 = var_16.setOnUpdate

		System = var_19

		local var_28_31 = var_28_30(var_28_29, var_19.Action_float(function(arg_35_0)
			setImageAlpha = var_2_10001

			var_2_10001(var_28_17, arg_35_0)

			local var_35_0 = var_28_17

			Vector3 = var_2_10002

			local var_35_1 = var_2_10002.Lerp

			Vector3 = var_4

			local var_35_2 = var_4(2, 2, 2)

			Vector3 = var_2_10005
			var_35_0.localScale = var_35_1(var_35_2, var_2_10005.one, arg_35_0)

			return
		end))
		local var_28_32 = var_16.setOnComplete

		System = var_19

		var_28_32(var_28_31, var_19.Action(function()
			local var_36_0 = arg_28_0
			local var_36_1 = var_0.emit

			ActivityMainScene = var_2_10003

			var_36_1(var_36_0, var_2_10003.LOCK_ACT_MAIN, false)

			var_28_18 = true

			return
		end))
	end

	setActive = var_28_17

	var_28_17(var_4, true)

	onButton = var_28_17

	var_28_17(arg_28_0, var_4, function()
		if var_28_18 then
			setActive = var_0

			var_0(var_0, false)
			arg_28_3()
		end

		return
	end)

	return
end

function var_0_1.setSpriteTo(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2
	local var_38_1 = arg_38_2.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_38_2 = var_38_1(var_38_0, var_1_10007(var_1_10009))
	local var_38_3 = arg_38_0._tf
	local var_38_4 = var_5.Find(var_38_3, arg_38_1)
	local var_38_5 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010
	var_38_2.sprite = var_38_5(var_38_4, var_8(var_1_10010)).sprite

	if arg_38_3 then
		var_38_2:SetNativeSize()
	end

	return
end

function var_0_1.OnDestroy(arg_39_0)
	if arg_39_0.bobingWrap then
		clearImageSprite = var_1

		var_1(arg_39_0.bobingWrap.bg)

		LeanTween = var_1

		var_1.cancel(arg_39_0.bobingWrap.bowlShine.gameObject)
	end

	return
end

return var_0_1
