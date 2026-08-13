class = var_0_10000

local var_0_0 = "LinkLinkScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.MAX_ROW = 6
var_0_1.MAX_COLUMN = 11
var_0_1.COUNT_DOWN = 3
var_0_1.RESET_CD = 5
var_0_1.GAME_STATE_BEGIN = 0
var_0_1.GAME_STATE_GAMING = 1
var_0_1.GAME_STATE_END = 2
var_0_1.CARD_STATE_NORMAL = 0
var_0_1.CARD_STATE_LINKED = 1
var_0_1.CARD_STATE_BLANK = 2

function var_0_1.getUIName(arg_1_0)
	return "LinkLinkUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "BackBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_1, "top/help_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.resetBtn = var_1.Find(var_2_2, "info/reset_button")

	local var_2_3 = arg_2_0._tf

	arg_2_0.awardTxt = var_1.Find(var_2_3, "info/award_txt")

	local var_2_4 = arg_2_0._tf

	arg_2_0.timeTxt = var_1.Find(var_2_4, "info/time_txt")

	local var_2_5 = arg_2_0._tf

	arg_2_0.bestTxt = var_1.Find(var_2_5, "info/best_txt")

	local var_2_6 = arg_2_0._tf

	arg_2_0.layout = var_1.Find(var_2_6, "card_con/layout")

	local var_2_7 = arg_2_0.layout

	arg_2_0.item = var_1.Find(var_2_7, "card")

	local var_2_8 = arg_2_0._tf

	arg_2_0.bottom = var_1.Find(var_2_8, "card_con/bottom")

	local var_2_9 = arg_2_0.bottom

	arg_2_0.line = var_1.Find(var_2_9, "card")

	local var_2_10 = arg_2_0._tf

	arg_2_0.result = var_1.Find(var_2_10, "result")

	local var_2_11 = arg_2_0._tf

	arg_2_0.countDown = var_1.Find(var_2_11, "count_down")

	local var_2_12 = arg_2_0._tf

	arg_2_0.resource = var_1.Find(var_2_12, "resource")

	local var_2_13 = arg_2_0._tf

	arg_2_0.bestTitleText = var_1.Find(var_2_13, "info/BestTitle")

	local var_2_14 = arg_2_0._tf

	arg_2_0.curTitleText = var_1.Find(var_2_14, "info/CurTitle")
	setText = var_1

	local var_2_15 = arg_2_0.bestTitleText

	i18n = var_4

	var_1(var_2_15, var_4("LinkLinkGame_BestTime"))

	setText = var_1

	local var_2_16 = arg_2_0.curTitleText

	i18n = var_4

	var_1(var_2_16, var_4("LinkLinkGame_CurTime"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:SetState(var_0_1.GAME_STATE_BEGIN)

	return
end

function var_0_1.willExit(arg_5_0)
	local var_5_0 = arg_5_0

	arg_5_0.HideResult(var_5_0)

	LeanTween = var_1

	local var_5_1 = var_1.cancel

	go = var_5_0

	var_5_1(var_5_0(arg_5_0.countDown))

	for iter_5_0 = 0, arg_5_0.layout.childCount - 1 do
		LeanTween = var_5_2

		local var_5_2 = var_5_2.cancel

		go = var_1_10007

		local var_5_3 = arg_5_0.layout

		var_5_2(var_1_10007(var_9.GetChild(var_5_3, iter_5_0)))
	end

	if arg_5_0.countTimer then
		local var_5_4 = arg_5_0.countTimer

		var_1.Stop(var_5_4)

		arg_5_0.countTimer = nil
	end

	return
end

function var_0_1.SetPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_1.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1
	arg_7_0.activityAchieved = arg_7_1.data1
	arg_7_0.activityProgress = arg_7_1.data2
	arg_7_0.activityStartTime = arg_7_1.data3
	arg_7_0.activityBestRecord = arg_7_1.data4

	local var_7_0 = arg_7_0.activity
	local var_7_1 = var_2.getConfig(var_7_0, "config_client")[3]

	pg = var_1_10003

	local var_7_2 = var_1_10003.TimeMgr.GetInstance()

	arg_7_0.activityRestTimes = var_3.DiffDay(var_7_2, arg_7_0.activityStartTime, var_3:GetServerTime()) + 1 - arg_7_0.activityProgress
	math = var_4
	arg_7_0.activityRestTimes = var_4.clamp(arg_7_0.activityRestTimes, 0, #var_7_1 - arg_7_0.activityProgress)
	setText = var_4

	local var_7_3 = arg_7_0.awardTxt
	local var_7_4

	if not (arg_7_0.activityRestTimes > 0) or not var_7_1[arg_7_0.activityProgress + 1] then
		var_7_4 = 0
	end

	var_4(var_7_3, var_7_4)

	setText = var_4

	var_4(arg_7_0.bestTxt, arg_7_0:FormatRecordTime(arg_7_0.activityBestRecord))

	return
end

function var_0_1.SetState(arg_8_0, arg_8_1)
	if arg_8_0.state ~= arg_8_1 then
		arg_8_0.state = arg_8_1

		if arg_8_1 == var_0_1.GAME_STATE_BEGIN then
			arg_8_0:GameBegin()
		elseif arg_8_1 == var_0_1.GAME_STATE_GAMING then
			arg_8_0:GameLoop()
		elseif arg_8_1 == var_0_1.GAME_STATE_END then
			arg_8_0:GameEnd()
		end
	end

	return
end

function var_0_1.GameBegin(arg_9_0)
	arg_9_0.cards = {}

	local var_9_0 = {}

	for iter_9_0 = 0, 17 do
		table = var_1_10006

		var_1_10006.insert(var_9_0, iter_9_0)

		table = var_1_10006

		var_1_10006.insert(var_9_0, iter_9_0)
	end

	local var_9_1 = 0

	::label_9_0::

	local var_9_2 = #var_9_0

	if 0 < var_9_2 then
		repeat
			math = var_9_2
			var_9_2 = var_9_2.clamp
			math = iter_9_0
			iter_9_0 = iter_9_0.floor
			math = var_1_10007
			var_9_2 = var_9_2(iter_9_0(var_1_10007.random() * #var_9_0 + 1), 1, #var_9_0)
			math = var_9_3

			local var_9_3 = var_9_3.floor(var_9_1 / (var_0_1.MAX_COLUMN - 2)) + 1

			iter_9_0 = var_9_1 % (var_0_1.MAX_COLUMN - 2) + 1

			local var_9_4 = arg_9_0.cards

			if not arg_9_0.cards[var_9_3] then
				var_1_10007 = {}
			end

			var_9_4[var_9_3] = var_1_10007

			local var_9_5 = arg_9_0.cards[var_9_3]

			var_9_5[iter_9_0] = {
				row = var_9_3,
				column = iter_9_0,
				id = var_9_0[var_9_2],
				state = var_0_1.CARD_STATE_NORMAL
			}
			table = var_9_5

			var_9_5.remove(var_9_0, var_9_2)

			var_9_1 = var_9_1 + 1

			goto label_9_0
		until true
	end

	for iter_9_1 = 0, var_0_1.MAX_ROW - 1 do
		for iter_9_2 = 0, var_0_1.MAX_COLUMN - 1 do
			local var_9_6 = arg_9_0.cards
			local var_9_7

			if not arg_9_0.cards[iter_9_1] then
				var_9_7 = {}
			end

			var_9_6[iter_9_1] = var_9_7

			local var_9_8 = arg_9_0.cards[iter_9_1]
			local var_9_9

			if not arg_9_0.cards[iter_9_1][iter_9_2] then
				var_9_9 = {
					row = iter_9_1,
					column = iter_9_2,
					state = var_0_1.CARD_STATE_BLANK
				}
			end

			var_9_8[iter_9_2] = var_9_9
		end
	end

	UIItemList = var_3
	arg_9_0.list = var_3.New(arg_9_0.layout, arg_9_0.item)

	local var_9_10 = arg_9_0.list

	var_3.make(var_9_10, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			math = var_3

			local var_10_0 = var_3.floor(arg_10_1 / var_0_1.MAX_COLUMN)
			local var_10_1 = arg_10_1 % var_0_1.MAX_COLUMN
			local var_10_2 = arg_9_0.cards[var_10_0][var_10_1]

			arg_10_2.name = var_10_0 .. "_" .. var_10_1
			Vector3 = var_6
			arg_10_2.localScale = var_6.one
			setActive = var_6

			var_6(arg_10_2:Find("display"), var_10_2.state == var_0_1.CARD_STATE_NORMAL)

			if var_10_2.state == var_0_1.CARD_STATE_NORMAL then
				getImageSprite = var_6

				local var_10_3 = arg_9_0.resource
				local var_10_4 = var_6(var_8.GetChild(var_10_3, var_10_2.id))

				setImageSprite = var_7

				var_7(arg_10_2:Find("display/icon"), var_10_4)

				setActive = var_7

				var_7(arg_10_2:Find("display/selected"), false)
			end
		end

		return
	end)

	local var_9_11 = arg_9_0.list

	var_3.align(var_9_11, var_0_1.MAX_ROW * var_0_1.MAX_COLUMN)

	UIItemList = var_3
	arg_9_0.llist = var_3.New(arg_9_0.bottom, arg_9_0.line)

	local var_9_12 = arg_9_0.llist

	var_3.make(var_9_12, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_11_2:Find("lines")

			for iter_11_0 = 0, var_11_0.childCount - 1 do
				setActive = var_2_10008

				var_2_10008(var_11_0:GetChild(iter_11_0), false)
			end
		end

		return
	end)

	local var_9_13 = arg_9_0.llist

	var_3.align(var_9_13, var_0_1.MAX_ROW * var_0_1.MAX_COLUMN)

	setActive = var_3

	var_3(arg_9_0.countDown, true)

	for iter_9_3 = 0, arg_9_0.countDown.childCount - 1 do
		setActive = var_7

		local var_9_14 = arg_9_0.countDown

		var_7(var_9.GetChild(var_9_14, iter_9_3), false)
	end

	local var_9_15 = 0
	local var_9_16 = arg_9_0.countDown
	local var_9_17 = var_4.GetChild(var_9_16, var_9_15)

	setActive = var_5

	var_5(var_9_17, true)

	setImageAlpha = var_5

	var_5(var_9_17, 0)

	LeanTween = var_5

	local var_9_18 = var_5.value

	go = var_7

	local var_9_19 = var_9_18(var_7(arg_9_0.countDown), 0, 1, 1)
	local var_9_20 = var_5.setOnUpdate

	System = var_8

	local var_9_21 = var_9_20(var_9_19, var_8.Action_float(function(arg_12_0)
		math = var_2_10001
		arg_12_0 = var_2_10001.min(arg_12_0 / 0.3, 1)
		setImageAlpha = var_1

		var_1(var_9_17, arg_12_0)

		setLocalScale = var_1

		var_1(var_9_17, {
			x = (1 - arg_12_0) * 2 + 1,
			y = (1 - arg_12_0) * 2 + 1
		})

		return
	end))
	local var_9_22 = var_5.setOnComplete

	System = var_8

	local var_9_23 = var_9_22(var_9_21, var_8.Action(function()
		setActive = var_2_10000

		var_2_10000(var_9_17, false)

		var_9_15 = var_9_15 + 1

		if var_9_15 < arg_9_0.countDown.childCount then
			local var_13_0 = arg_9_0.countDown

			var_9_17 = var_0.GetChild(var_13_0, var_9_15)
			setActive = var_0

			var_0(var_9_17, true)

			setImageAlpha = var_0

			var_0(var_9_17, 0)
		else
			setActive = var_0

			var_0(arg_9_0.countDown, false)

			local var_13_1 = arg_9_0

			var_0.SetState(var_13_1, var_0_1.GAME_STATE_GAMING)
		end

		return
	end))
	local var_9_24 = var_5.setRepeat(var_9_23, 4)
	local var_9_25 = var_5.setLoopType

	LeanTweenType = var_8

	local var_9_26 = var_9_25(var_9_24, var_8.punch)
	local var_9_27 = var_5.setOnCompleteOnRepeat(var_9_26, true)
	local var_9_28 = var_5.setEase

	LeanTweenType = var_8

	var_9_28(var_9_27, var_8.easeOutSine)

	return
end

function var_0_1.GameLoop(arg_14_0)
	local function var_14_0(arg_15_0)
		local var_15_0 = 0
		local var_15_1 = 0

		for iter_15_0 = 1, #arg_15_0 - 1 do
			local var_15_2 = arg_15_0[iter_15_0]
			local var_15_3 = arg_15_0[iter_15_0 + 1].row - var_15_2.row
			local var_15_4 = var_8.column - var_15_2.column
			local var_15_5 = arg_14_0.bottom
			local var_15_6 = var_11.GetChild(var_15_5, var_15_2.row * var_0_1.MAX_COLUMN + var_15_2.column)
			local var_15_7 = var_11.Find(var_15_6, "lines")

			for iter_15_1 = 0, var_15_7.childCount - 1 do
				setActive = var_2_10016

				var_2_10016(var_15_7:GetChild(iter_15_1), false)
			end

			if var_15_3 ~= 0 then
				setActive = var_12
				var_2_10016 = var_15_7

				var_12(var_15_7.Find(var_2_10016, "y" .. var_15_3), true)
			elseif var_15_4 ~= 0 then
				setActive = var_12
				var_2_10016 = var_15_7

				var_12(var_15_7.Find(var_2_10016, "x" .. var_15_4), true)
			end

			local var_15_10

			if var_15_3 ~= var_15_0 and var_15_4 ~= var_15_1 then
				local var_15_8 = 0
				local var_15_9 = (var_15_3 == -1 and var_15_1 == 1 or var_15_0 == 1 and var_15_4 == -1) and 0 or (var_15_4 == -1 and var_15_0 == -1 or var_15_3 == 1 and var_15_1 == 1) and 90 or (var_15_3 == 1 and var_15_1 == -1 or var_15_0 == -1 and var_15_4 == 1) and 180 or 270

				var_15_10 = var_15_7:Find("joint")
				setActive = var_14

				var_14(var_15_10, true)

				Vector3 = var_14
				var_15_10.localEulerAngles = var_14(0, 0, var_15_9)
			elseif var_15_0 == 0 and var_15_3 ~= 0 or var_15_0 ~= 0 and var_15_3 == var_15_0 then
				local var_15_11 = var_15_7:Find("cross")

				setActive = var_15_10

				var_15_10(var_15_11, true)

				Vector3 = var_15_10
				var_15_11.localEulerAngles = var_15_10(0, 0, 90)
			elseif var_15_1 == 0 and var_15_4 ~= 0 or var_15_1 ~= 0 and var_15_4 == var_15_1 then
				local var_15_12 = var_15_7:Find("cross")

				setActive = var_15_10

				var_15_10(var_15_12, true)

				Vector3 = var_15_10
				var_15_12.localEulerAngles = var_15_10(0, 0, 0)
			end

			var_15_0, var_15_1 = var_15_3, var_15_4
		end

		return
	end

	local function var_14_1(arg_16_0)
		for iter_16_0 = 1, #arg_16_0 - 1 do
			local var_16_0 = arg_16_0[iter_16_0].row * var_0_1.MAX_COLUMN + var_5.column
			local var_16_1 = arg_14_0.bottom
			local var_16_2 = var_7.GetChild(var_16_1, var_16_0)
			local var_16_3 = var_7.Find(var_16_2, "lines")

			for iter_16_1 = 0, var_16_3.childCount - 1 do
				setActive = var_2_10012

				var_2_10012(var_16_3:GetChild(iter_16_1), false)
			end
		end

		return
	end

	local var_14_2
	local var_14_3
	local var_14_4
	local var_14_5 = arg_14_0.list

	var_6.each(var_14_5, function(arg_17_0, arg_17_1)
		onButton = var_2_10002

		local var_17_0 = arg_14_0
		local var_17_1 = arg_17_1
		local var_17_2 = arg_17_1.Find(var_17_1, "display/icon")

		local function var_17_3()
			math = var_3_10000

			local var_18_0 = var_3_10000.floor(arg_17_0 / var_0_1.MAX_COLUMN)
			local var_18_1 = arg_17_0 % var_0_1.MAX_COLUMN

			if arg_14_0.cards[var_18_0][var_18_1].state ~= var_0_1.CARD_STATE_NORMAL then
				return
			elseif not var_14_2 then
				var_14_2 = var_2
				var_14_3 = arg_17_1
				setActive = var_3

				local var_18_2 = arg_17_1

				var_3(var_5.Find(var_18_2, "display/selected"), true)
			elseif var_14_4 then
				return
			elseif var_14_2 == var_2 then
				setActive = var_3

				local var_18_3 = arg_17_1

				var_3(var_5.Find(var_18_3, "display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			elseif var_14_2.id ~= var_2.id then
				setActive = var_3

				local var_18_4 = var_14_3

				var_3(var_5.Find(var_18_4, "display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			else
				local var_18_5 = arg_14_0

				if not var_3.LinkLink(var_18_5, var_14_2, var_2) then
					setActive = var_4

					local var_18_6 = var_14_3

					var_4(var_6.Find(var_18_6, "display/selected"), false)

					var_14_3 = nil
					var_14_2 = nil
				else
					var_2.state = var_0_1.CARD_STATE_LINKED

					local var_18_7 = var_14_2

					var_18_7.state = var_0_1.CARD_STATE_LINKED
					setActive = var_18_7

					local var_18_8 = arg_17_1

					var_18_7(var_6.Find(var_18_8, "display/selected"), true)
					var_14_0(var_3)

					var_14_4 = true

					local var_18_9 = arg_17_1
					local var_18_10 = var_14_3

					LeanTween = var_6

					local var_18_11 = var_6.value

					go = var_18_8

					local var_18_12 = var_18_11(var_18_8(var_18_9), 1, 0.15, 0.3)
					local var_18_13 = var_6.setEase

					LeanTweenType = var_9

					local var_18_14 = var_18_13(var_18_12, var_9.easeInBack)
					local var_18_15 = var_6.setOnUpdate

					System = var_9

					local var_18_16 = var_18_15(var_18_14, var_9.Action_float(function(arg_19_0)
						local var_19_0 = var_18_9

						Vector3 = var_4_10002
						var_19_0.localScale = var_4_10002(arg_19_0, arg_19_0, 1)

						local var_19_1 = var_18_10

						Vector3 = var_2
						var_19_1.localScale = var_2(arg_19_0, arg_19_0, 1)

						return
					end))
					local var_18_17 = var_6.setOnComplete

					System = var_9

					var_18_17(var_18_16, var_9.Action(function()
						var_14_1(var_0)

						setActive = var_0

						local var_20_0 = var_18_9

						var_0(var_2.Find(var_20_0, "display"), false)

						setActive = var_0

						local var_20_1 = var_18_10

						var_0(var_2.Find(var_20_1, "display"), false)

						var_14_4 = false

						return
					end))

					var_14_3 = nil
					var_14_2 = nil

					local var_18_18 = true

					for iter_18_0 = 0, var_0_1.MAX_ROW - 1 do
						for iter_18_1 = 0, var_0_1.MAX_COLUMN - 1 do
							if arg_14_0.cards[iter_18_0][iter_18_1].state == var_0_1.CARD_STATE_NORMAL then
								var_18_18 = false

								break
							end
						end
					end

					if var_18_18 then
						local var_18_19 = arg_14_0

						var_7.SetState(var_18_19, var_0_1.GAME_STATE_END)
					end
				end
			end

			return
		end

		SFX_PANEL = var_17_1

		var_2_10002(var_17_0, var_17_2, var_17_3, var_17_1)

		return
	end)

	IsUnityEditor = var_6

	if var_6 then
		AUTO_LINKLINK = var_6

		if var_6 then
			setActive = var_6

			var_6(arg_14_0.helpBtn, true)

			onButton = var_6

			var_6(arg_14_0, arg_14_0.helpBtn, function()
				var_14_2 = nil
				var_14_3 = nil

				for iter_21_0 = 0, var_0_1.MAX_ROW - 1 do
					for iter_21_1 = 0, var_0_1.MAX_COLUMN - 1 do
						local var_21_0 = arg_14_0.cards[iter_21_0][iter_21_1].row * var_0_1.MAX_COLUMN + var_8.column
						local var_21_1 = arg_14_0.layout
						local var_21_2 = var_10.GetChild(var_21_1, var_21_0)

						if var_8.state == var_0_1.CARD_STATE_NORMAL then
							for iter_21_2 = 0, var_0_1.MAX_ROW - 1 do
								for iter_21_3 = 0, var_0_1.MAX_COLUMN - 1 do
									if iter_21_0 ~= iter_21_2 or iter_21_1 ~= iter_21_3 then
										local var_21_3 = arg_14_0.cards[iter_21_2][iter_21_3].row * var_0_1.MAX_COLUMN + var_19.column
										local var_21_4 = arg_14_0.layout
										local var_21_5 = var_21.GetChild(var_21_4, var_21_3)

										if var_8.id == var_19.id then
											triggerButton = var_22

											var_22(var_21_2:Find("display/icon"))

											triggerButton = var_22

											var_22(var_21_5:Find("display/icon"))

											if var_14_4 then
												Timer = var_22

												local var_21_6 = var_22.New(function()
													triggerButton = var_3_10000

													var_3_10000(arg_14_0.helpBtn)

													return
												end, 0.4, 1)

												var_22.Start(var_21_6)

												return
											end
										end
									end
								end
							end
						end
					end
				end

				return
			end)
		end
	end

	local var_14_6 = 0

	onButton = var_1_10007

	local var_14_7 = arg_14_0
	local var_14_8 = arg_14_0.resetBtn

	local function var_14_9()
		if arg_14_0.state ~= var_0_1.GAME_STATE_GAMING then
			return
		else
			Time = var_0

			if var_0.realtimeSinceStartup - var_14_6 < var_0_1.RESET_CD then
				pg = var_0

				local var_23_0 = var_0.TipsMgr.GetInstance()
				local var_23_1 = var_0.ShowTips

				i18n = var_2_10003

				var_23_1(var_23_0, var_2_10003("common_wait"))
			else
				if var_14_2 then
					setActive = var_0

					local var_23_2 = var_14_3

					var_0(var_2.Find(var_23_2, "display/selected"), false)

					var_14_3 = nil
					var_14_2 = nil
				end

				local var_23_3 = {}
				local var_23_4 = {}

				for iter_23_0 = 0, var_0_1.MAX_ROW - 1 do
					for iter_23_1 = 0, var_0_1.MAX_COLUMN - 1 do
						if arg_14_0.cards[iter_23_0][iter_23_1].state == var_0_1.CARD_STATE_NORMAL then
							table = var_11

							var_11.insert(var_23_3, {
								row = iter_23_0,
								column = iter_23_1
							})

							table = var_11

							var_11.insert(var_23_4, var_10.id)
						end
					end
				end

				local var_23_5 = 1

				while #var_23_4 > 0 do
					math = var_23_6

					local var_23_6 = var_23_6.clamp

					math = iter_23_0
					iter_23_0 = iter_23_0.floor
					math = var_2_10007
					var_23_6 = var_23_6(iter_23_0(var_2_10007.random() * #var_23_4 + 1), 1, #var_23_4)

					local var_23_7 = arg_14_0.cards[var_23_3[var_23_5].row][var_23_3[var_23_5].column]

					var_23_7.id = var_23_4[var_23_6]
					table = var_23_7

					var_23_7.remove(var_23_4, var_23_6)

					var_23_5 = var_23_5 + 1
				end

				local var_23_8 = arg_14_0.list

				var_3.each(var_23_8, function(arg_24_0, arg_24_1)
					math = var_3_10002

					local var_24_0 = var_3_10002.floor(arg_24_0 / var_0_1.MAX_COLUMN)
					local var_24_1 = arg_24_0 % var_0_1.MAX_COLUMN

					if arg_14_0.cards[var_24_0][var_24_1].state == var_0_1.CARD_STATE_NORMAL then
						getImageSprite = var_5

						local var_24_2 = arg_14_0.resource
						local var_24_3 = var_5(var_7.GetChild(var_24_2, var_4.id))

						setImageSprite = var_6

						var_6(arg_24_1:Find("display/icon"), var_24_3)
					end

					return
				end)

				Time = var_3
				var_14_6 = var_3.realtimeSinceStartup
			end
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_1_10007(var_14_7, var_14_8, var_14_9, var_1_10012)

	Time = var_1_10007
	arg_14_0.startTime = var_1_10007.realtimeSinceStartup
	Timer = var_7
	arg_14_0.countTimer = var_7.New(function()
		math = var_2_10000

		local var_25_0 = var_2_10000.floor

		Time = var_2_10002

		local var_25_1 = var_25_0((var_2_10002.realtimeSinceStartup - arg_14_0.startTime) * 1000)

		setText = var_2_10001

		local var_25_2 = arg_14_0.timeTxt
		local var_25_3 = arg_14_0

		var_2_10001(var_25_2, var_4.FormatRecordTime(var_25_3, var_25_1))

		return
	end, 0.033, -1)

	local var_14_10 = arg_14_0.countTimer

	var_7.Start(var_14_10)
	arg_14_0.countTimer.func()

	return
end

function var_0_1.GameEnd(arg_26_0)
	local var_26_0 = arg_26_0.countTimer

	var_1.Stop(var_26_0)

	arg_26_0.countTimer = nil
	math = var_1

	local var_26_1 = var_1.floor

	Time = var_26_0
	arg_26_0.lastRecord = var_26_1((var_26_0.realtimeSinceStartup - arg_26_0.startTime) * 1000)

	if arg_26_0.activityRestTimes > 0 or arg_26_0.lastRecord < arg_26_0.activityBestRecord then
		local var_26_2 = arg_26_0.activityProgress + (arg_26_0.activityRestTimes > 0 and 1 or 0)
		local var_26_3 = arg_26_0
		local var_26_4 = arg_26_0.emit

		LinkLinkMediator = var_1_10005

		var_26_4(var_26_3, var_1_10005.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_26_0.activity.id,
			arg1 = var_26_2,
			arg2 = arg_26_0.lastRecord
		})
	else
		arg_26_0:DisplayResult(arg_26_0.activity)
	end

	return
end

function var_0_1.DisplayResult(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.result, true)

	local var_27_0 = arg_27_0.result
	local var_27_1 = var_2.Find(var_27_0, "bg")

	setActive = var_1_10003

	var_1_10003(var_27_1:Find("pic_new_record"), arg_27_1.data4 < arg_27_0.activityBestRecord)

	setActive = var_1_10003

	var_1_10003(var_27_1:Find("pic_win"), arg_27_1.data4 >= arg_27_0.activityBestRecord)

	setText = var_1_10003

	var_1_10003(var_27_1:Find("time_txt"), arg_27_0:FormatRecordTime(arg_27_0.lastRecord))

	local var_27_2 = arg_27_1:getConfig("config_client")[3]

	setText = var_27_0

	local var_27_3 = var_27_1:Find("award_txt")
	local var_27_4

	if not (arg_27_1.data2 > arg_27_0.activityProgress) or not var_27_2[arg_27_1.data2] then
		var_27_4 = 0
	end

	var_27_0(var_27_3, var_27_4)

	onButton = var_27_0

	local var_27_5 = arg_27_0
	local var_27_6 = var_27_1
	local var_27_7 = var_27_1.Find(var_27_6, "button")

	local function var_27_8()
		local var_28_0 = arg_27_0

		var_0.HideResult(var_28_0)

		local var_28_1 = arg_27_0

		var_0.SetActivity(var_28_1, arg_27_1)

		local var_28_2 = arg_27_0

		var_0.SetState(var_28_2, var_0_1.GAME_STATE_BEGIN)

		return
	end

	SFX_PANEL = var_27_6

	var_27_0(var_27_5, var_27_7, var_27_8, var_27_6)

	onButton = var_27_0

	local var_27_9 = arg_27_0
	local var_27_10 = arg_27_0.result

	local function var_27_11()
		triggerButton = var_2_10000

		var_2_10000(arg_27_0.backBtn)

		return
	end

	SFX_CANCEL = var_27_6

	var_27_0(var_27_9, var_27_10, var_27_11, var_27_6)

	pg = var_27_0

	local var_27_12 = var_27_0.UIMgr.GetInstance()

	var_4.BlurPanel(var_27_12, arg_27_0.result)

	return
end

function var_0_1.HideResult(arg_30_0)
	isActive = var_1_10001

	if var_1_10001(arg_30_0.result) then
		setActive = var_1

		var_1(arg_30_0.result, false)

		pg = var_1

		local var_30_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_30_0, arg_30_0.result, arg_30_0._tf)
	end

	return
end

function var_0_1.FormatRecordTime(arg_31_0, arg_31_1)
	math = var_1_10002

	local var_31_0 = var_1_10002.floor(arg_31_1 / 60000)

	var_31_0 = 10 <= var_31_0 and var_31_0 or "0" .. var_31_0
	math = var_3

	local var_31_1 = var_3.floor(arg_31_1 % 60000 / 1000)

	var_31_1 = 10 <= var_31_1 and var_31_1 or "0" .. var_31_1
	math = var_4

	local var_31_2 = var_4.floor(arg_31_1 % 1000 / 10) >= 10 and var_31_2 or "0" .. var_31_2

	return var_31_0 .. "'" .. var_31_1 .. "'" .. var_31_2
end

function var_0_1.LinkLink(arg_32_0, arg_32_1, arg_32_2)
	assert = var_1_10003

	var_1_10003(arg_32_1.row ~= arg_32_2.row or arg_32_1.column ~= arg_32_2.column)

	assert = var_1_10003

	var_1_10003(arg_32_1.id == arg_32_2.id)

	local var_32_0 = {
		row = arg_32_1.row,
		column = arg_32_1.column
	}
	local var_32_1 = {
		row = arg_32_2.row,
		column = arg_32_2.column
	}
	local var_32_2 = {}
	local var_32_3 = {}

	table = var_1_10007

	var_1_10007.insert(var_32_2, var_32_0)

	table = var_7

	var_7.insert(var_32_3, var_32_0)

	for iter_32_0 = 1, 3 do
		if arg_32_0:IterateByOneSnap(var_32_1, arg_32_1.id, var_32_2, var_32_3) then
			local var_32_4 = {
				var_32_7
			}

			while var_32_7 and var_32_7.from do
				if var_32_7.row ~= var_32_7.from.row then
					local var_32_5 = var_32_7.row > var_32_7.from.row and -1 or 1

					for iter_32_1 = var_32_7.row + var_32_5, var_32_7.from.row, var_32_5 do
						table = var_1_10018

						var_1_10018.insert(var_32_4, {
							row = iter_32_1,
							column = var_32_7.column
						})
					end
				else
					local var_32_6

					if var_32_7.from.column ~= var_32_7.column then
						var_32_6 = var_32_7.column > var_32_7.from.column and -1 or 1

						for iter_32_2 = var_32_7.column + var_32_6, var_32_7.from.column, var_32_6 do
							table = var_1_10018

							var_1_10018.insert(var_32_4, {
								row = var_32_7.row,
								column = iter_32_2
							})
						end
					else
						assert = var_32_6

						var_32_6(false)
					end
				end

				local var_32_7 = var_32_7.from
			end

			return var_32_4
		end
	end

	return
end

function var_0_1.IterateByOneSnap(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	for iter_33_0 = 1, #arg_33_3 do
		local var_33_0 = arg_33_0:FindDirectLinkPoint(arg_33_2, arg_33_3[iter_33_0], arg_33_4)

		ipairs = var_1_10010

		for iter_33_1, iter_33_2 in var_1_10010(var_33_0) do
			if iter_33_2.row == arg_33_1.row and iter_33_2.column == arg_33_1.column then
				return iter_33_2
			end

			table = var_15

			var_15.insert(arg_33_3, iter_33_2)
		end
	end

	_ = var_5

	var_5.each(arg_33_3, function(arg_34_0)
		arg_33_4[arg_34_0.row .. "_" .. arg_34_0.column] = true

		return
	end)

	return
end

function var_0_1.FindDirectLinkPoint(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {}

	for iter_35_0 = arg_35_2.row - 1, 0, -1 do
		local var_35_1 = iter_35_0 .. "_" .. arg_35_2.column

		if arg_35_0.cards[iter_35_0][arg_35_2.column].state == var_0_1.CARD_STATE_NORMAL and var_10.id ~= arg_35_1 or arg_35_3[var_35_1] then
			break
		end

		table = var_11

		var_11.insert(var_35_0, {
			row = iter_35_0,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_1 = arg_35_2.row + 1, var_0_1.MAX_ROW - 1 do
		local var_35_2 = iter_35_1 .. "_" .. arg_35_2.column

		if arg_35_0.cards[iter_35_1][arg_35_2.column].state == var_0_1.CARD_STATE_NORMAL and var_10.id ~= arg_35_1 or arg_35_3[var_35_2] then
			break
		end

		table = var_11

		var_11.insert(var_35_0, {
			row = iter_35_1,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_2 = arg_35_2.column - 1, 0, -1 do
		local var_35_3 = arg_35_2.row .. "_" .. iter_35_2

		if arg_35_0.cards[arg_35_2.row][iter_35_2].state == var_0_1.CARD_STATE_NORMAL and var_10.id ~= arg_35_1 or arg_35_3[var_35_3] then
			break
		end

		table = var_11

		var_11.insert(var_35_0, {
			row = arg_35_2.row,
			column = iter_35_2,
			from = arg_35_2
		})
	end

	for iter_35_3 = arg_35_2.column + 1, var_0_1.MAX_COLUMN - 1 do
		local var_35_4 = arg_35_2.row .. "_" .. iter_35_3

		if arg_35_0.cards[arg_35_2.row][iter_35_3].state == var_0_1.CARD_STATE_NORMAL and var_10.id ~= arg_35_1 or arg_35_3[var_35_4] then
			break
		end

		table = var_11

		var_11.insert(var_35_0, {
			row = arg_35_2.row,
			column = iter_35_3,
			from = arg_35_2
		})
	end

	return var_35_0
end

function var_0_1.LinkLink1(arg_36_0, arg_36_1, arg_36_2)
	assert = var_1_10003

	var_1_10003(arg_36_1.row ~= arg_36_2.row or arg_36_1.column ~= arg_36_2.column)

	assert = var_1_10003

	var_1_10003(arg_36_1.id == arg_36_2.id)

	local var_36_0
	local var_36_1 = {
		[arg_36_1.row .. "_" .. arg_36_1.column] = {
			rdir = 0,
			cdir = 0,
			snap = 0,
			row = arg_36_1.row,
			column = arg_36_1.column,
			path = {}
		}
	}
	local var_36_2 = {
		row = arg_36_1.row,
		column = arg_36_1.column
	}
	local var_36_3 = {
		row = arg_36_2.row,
		column = arg_36_2.column
	}
	local var_36_4 = {
		var_36_2
	}
	local var_36_5 = {}

	while #var_36_4 > 0 do
		table = var_9

		if var_9.remove(var_36_4, 1).row == var_36_3.row and var_9.column == var_36_3.column then
			var_36_0 = var_36_1[var_9.row .. "_" .. var_9.column].path

			break
		end

		table = var_10

		var_10.insert(var_36_5, var_9)

		local var_36_6 = {
			{
				row = 1,
				column = 0
			},
			{
				row = -1,
				column = 0
			},
			{
				row = 0,
				column = 1
			},
			{
				row = 0,
				column = -1
			}
		}

		_ = var_11

		var_11.each(var_36_6, function(arg_37_0)
			arg_37_0.row = var_0.row + arg_37_0.row
			arg_37_0.column = var_0.column + arg_37_0.column
			_ = var_1

			local var_37_0

			if not var_1.any(var_36_4, function(arg_38_0)
				return arg_38_0.row == arg_37_0.row and arg_38_0.column == arg_37_0.column
			end) then
				_ = var_37_0
				var_37_0 = var_37_0.any(var_36_5, function(arg_39_0)
					return arg_39_0.row == arg_37_0.row and arg_39_0.column == arg_37_0.column
				end)
			end

			local var_37_1

			if not arg_36_0.cards[arg_37_0.row] or not arg_36_0.cards[arg_37_0.row][arg_37_0.column] then
				var_37_1 = nil
			end

			if not var_37_0 and (not var_37_1 or var_37_1.state == var_0_1.CARD_STATE_LINKED or var_37_1.state == var_0_1.CARD_STATE_BLANK or var_37_1.id == arg_36_1.id) and arg_37_0.row >= 0 and arg_37_0.row < var_0_1.MAX_ROW and arg_37_0.column >= 0 and arg_37_0.column < var_0_1.MAX_COLUMN then
				local var_37_2 = var_36_1[var_0.row .. "_" .. var_0.column].snap
				local var_37_3 = arg_37_0.row - var_0.row
				local var_37_4 = arg_37_0.column - var_0.column

				if var_3.rdir ~= 0 and var_3.rdir ~= var_37_3 or var_3.cdir ~= 0 and var_3.cdir ~= var_37_4 then
					var_37_2 = var_37_2 + 1
				end

				if var_37_2 <= 2 then
					Clone = var_7

					local var_37_5 = var_7(var_3.path)

					table = var_2_10008

					var_2_10008.insert(var_37_5, arg_37_0)

					var_36_1[arg_37_0.row .. "_" .. arg_37_0.column] = {
						row = arg_37_0.row,
						column = arg_37_0.column,
						snap = var_37_2,
						rdir = var_37_3,
						cdir = var_37_4,
						path = var_37_5
					}

					local var_37_6 = 0

					for iter_37_0 = #var_36_4, 1, -1 do
						local var_37_7 = var_36_4[iter_37_0]

						if var_37_2 > var_36_1[var_37_7.row .. "_" .. var_37_7.column].snap or var_37_2 == var_14.snap and #var_37_5 > #var_14.path then
							var_37_6 = iter_37_0

							break
						end
					end

					table = var_9

					var_9.insert(var_36_4, var_37_6 + 1, arg_37_0)
				end
			end

			return
		end)
	end

	return var_36_0
end

return var_0_1
