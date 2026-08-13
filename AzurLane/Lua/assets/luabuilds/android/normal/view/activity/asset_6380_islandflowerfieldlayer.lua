class = var_0_10000

local var_0_0 = "IslandFlowerFieldLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFlowerFieldUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "Text")

	setText = var_3_1

	local var_3_3 = var_3_2

	i18n = var_1_10004

	var_3_1(var_3_3, var_1_10004("islandnode_tips6"))

	local var_3_4 = var_3_2
	local var_3_5 = var_3_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5

	local var_3_6 = var_3_5(var_3_4, var_4(var_5))

	var_2.SetEndEvent(var_3_6, function()
		setActive = var_2_10000

		var_2_10000(var_3_2, false)

		return
	end)

	local var_3_7 = arg_3_0._tf

	arg_3_0.rtChars = var_2.Find(var_3_7, "chars")

	local var_3_8 = arg_3_0.rtChars
	local var_3_9 = var_2.GetChild

	math = var_4
	arg_3_0.rtShip = var_3_9(var_3_8, var_4.random(arg_3_0.rtChars.childCount) - 1)

	local var_3_10 = arg_3_0.contextData

	tonumber = var_3_8
	var_3_10.shipConfigId = var_3_8(arg_3_0.rtShip.name)
	eachChild = var_3_10

	var_3_10(arg_3_0.rtChars, function(arg_5_0)
		setActive = var_2_10001

		var_2_10001(arg_5_0, arg_5_0 == arg_3_0.rtShip)

		return
	end)

	arg_3_0.fieldList = {}
	arg_3_0.posList = {}
	eachChild = var_2

	local var_3_11 = arg_3_0._tf

	var_2(var_3.Find(var_3_11, "field"), function(arg_6_0)
		eachChild = var_2_10001

		var_2_10001(arg_6_0, function(arg_7_0)
			table = var_3_10001

			var_3_10001.insert(arg_3_0.fieldList, arg_7_0)

			table = var_1

			local var_7_0 = var_1.insert
			local var_7_1 = arg_3_0.posList
			local var_7_2 = arg_3_0.rtChars

			var_7_0(var_7_1, var_3.InverseTransformPoint(var_7_2, arg_7_0.position))

			return
		end)

		return
	end)

	local var_3_12 = arg_3_0._tf

	arg_3_0.rtField = var_2.Find(var_3_12, "field")

	local var_3_13 = arg_3_0._tf

	arg_3_0.rtBtnGet = var_2.Find(var_3_13, "btn_get")
	onButton = var_2

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0._tf
	local var_3_16 = var_4.Find(var_3_15, "btn_back")

	local function var_3_17()
		local var_8_0 = arg_3_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_3_14, var_3_16, var_3_17, var_6)

	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2({
		"click",
		"click_lock"
	}) do
		onButton = var_1_10007

		local var_3_18 = arg_3_0
		local var_3_19 = arg_3_0.rtBtnGet
		local var_3_20 = var_9.Find(var_3_19, iter_3_1)

		local function var_3_21()
			if arg_3_0.timer then
				setActive = var_0

				var_0(var_3_2, true)

				return
			end

			local var_9_0 = arg_3_0
			local var_9_1 = var_0.emit

			IslandFlowerFieldMediator = var_2_10002

			var_9_1(var_9_0, var_2_10002.GET_FLOWER_AWARD, false)

			return
		end

		SFX_CONFIRM = var_11

		var_1_10007(var_3_18, var_3_20, var_3_21, var_11)
	end

	return
end

function var_0_1.refreshDisplay(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()
	local var_10_1 = var_1.GetServerTime(var_10_0)
	local var_10_2 = var_1
	local var_10_3 = var_1.GetTimeToNextTime

	math = var_1_10005

	local var_10_4 = var_10_3(var_10_2, var_1_10005.max(arg_10_0.activity.data1, arg_10_0.activity.data2)) <= var_10_1

	setActive = var_3

	local var_10_5 = arg_10_0.rtBtnGet

	var_3(var_4.Find(var_10_5, "click"), var_10_4)

	setActive = var_3

	local var_10_6 = arg_10_0.rtBtnGet

	var_3(var_4.Find(var_10_6, "click_lock"), not var_10_4)

	ipairs = var_3

	for iter_10_0, iter_10_1 in var_3(arg_10_0.fieldList) do
		triggerToggle = var_1_10008

		var_1_10008(iter_10_1, var_10_4)
	end

	if var_10_4 then
		setText = var_3

		local var_10_7 = arg_10_0.rtBtnGet

		var_3(var_4.Find(var_10_7, "time/Text"), var_1:DescCDTime(0))
	else
		local var_10_8 = var_1:GetTimeToNextTime()
		local var_10_9 = var_1
		local var_10_10 = var_10_8 - var_1.GetServerTime(var_10_9)
		local var_10_11 = 0

		Timer = var_10_9
		arg_10_0.timer = var_10_9.New(function()
			if var_10_11 < var_10_10 then
				var_10_11 = var_10_11 + 1
				setText = var_0

				local var_11_0 = arg_10_0.rtBtnGet
				local var_11_1 = var_1.Find(var_11_0, "time/Text")
				local var_11_2 = var_0

				var_0(var_11_1, var_2.DescCDTime(var_11_2, var_10_10 - var_10_11))
			else
				local var_11_3 = arg_10_0.timer

				var_0.Stop(var_11_3)

				arg_10_0.timer = nil

				local var_11_4 = arg_10_0

				var_0.refreshDisplay(var_11_4)
			end

			return
		end, 1, var_10_10)

		arg_10_0.timer.func()

		local var_10_12 = arg_10_0.timer

		var_5.Start(var_10_12)
	end

	return
end

function var_0_1.didEnter(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()
	local var_12_1 = var_1.GetServerTime(var_12_0)
	local var_12_2 = var_1
	local var_12_3 = var_1.GetTimeToNextTime

	math = var_1_10005

	if var_12_1 - var_12_3(var_12_2, var_1_10005.max(arg_12_0.activity.data1, arg_12_0.activity.data2)) < 0 then
		arg_12_0:refreshDisplay()
	else
		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.emit

		IslandFlowerFieldMediator = var_12_2

		var_12_5(var_12_4, var_12_2.GET_FLOWER_AWARD, true)
	end

	arg_12_0:DoCharAction()

	return
end

local var_0_2 = 50

function var_0_1.DoCharAction(arg_13_0)
	local var_13_0 = arg_13_0.posList

	math = var_1_10002

	local var_13_1 = var_13_0[var_1_10002.random(#arg_13_0.posList)] - arg_13_0.rtShip.anchoredPosition3D

	if var_2.SqrMagnitude(var_13_1) <= 0 then
		return arg_13_0:DoCharAction()
	end

	var_2.x = var_2.x - (var_2.x < 0 and -1 or 1) * 100

	local var_13_2 = {}

	table = var_5

	var_5.insert(var_13_2, function(arg_14_0)
		SetAction = var_2_10001

		var_2_10001(arg_13_0.rtShip, "jiaoshui_walk")

		setLocalScale = var_2_10001

		local var_14_0 = arg_13_0.rtShip
		local var_14_1 = {}
		local var_14_2 = var_0.x < 0 and -1 or 1

		math = var_5
		var_14_1.x = var_14_2 * var_5.abs(arg_13_0.rtShip.localScale.x)

		var_2_10001(var_14_0, var_14_1)

		local var_14_3 = arg_13_0

		LeanTween = var_14_0

		local var_14_4 = var_14_0.move
		local var_14_5 = arg_13_0.rtShip
		local var_14_6 = arg_13_0.rtShip.anchoredPosition3D + var_0
		local var_14_7 = var_0
		local var_14_8 = var_14_4(var_14_5, var_14_6, var_5.Magnitude(var_14_7) / var_0_2)
		local var_14_9 = var_2.setOnComplete

		System = var_14_6
		var_14_3.charLT = var_14_9(var_14_8, var_14_6.Action(arg_14_0)).uniqueId

		return
	end)

	table = var_5

	var_5.insert(var_13_2, function(arg_15_0)
		var_0 = var_0 - arg_13_0.rtShip.anchoredPosition3D
		SetAction = var_1

		var_1(arg_13_0.rtShip, "jiaoshui", false)

		setLocalScale = var_1

		local var_15_0 = arg_13_0.rtShip
		local var_15_1 = {}
		local var_15_2 = var_0.x < 0 and -1 or 1

		math = var_5
		var_15_1.x = var_15_2 * var_5.abs(arg_13_0.rtShip.localScale.x)

		var_1(var_15_0, var_15_1)

		local var_15_3 = arg_13_0

		LeanTween = var_15_0

		local var_15_4 = var_15_0.delayedCall
		local var_15_5 = 3

		System = var_4
		var_15_3.charLT = var_15_4(var_15_5, var_4.Action(arg_15_0)).uniqueId

		return
	end)

	table = var_5

	var_5.insert(var_13_2, function(arg_16_0)
		SetAction = var_2_10001

		var_2_10001(arg_13_0.rtShip, "jiaoshui_stand")

		local var_16_0 = arg_13_0

		LeanTween = var_2

		local var_16_1 = var_2.delayedCall
		local var_16_2 = 4.666666666666667

		System = var_2_10004
		var_16_0.charLT = var_16_1(var_16_2, var_2_10004.Action(arg_16_0)).uniqueId

		return
	end)

	seriesAsync = var_5

	var_5(var_13_2, function()
		arg_13_0.charLT = nil

		local var_17_0 = arg_13_0

		var_0.DoCharAction(var_17_0)

		return
	end)

	return
end

function var_0_1.willExit(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_0, arg_18_0._tf)

	if arg_18_0.timer then
		local var_18_1 = arg_18_0.timer

		var_1.Stop(var_18_1)

		arg_18_0.timer = nil
	end

	if arg_18_0.charLT then
		LeanTween = var_1

		var_1.cancel(arg_18_0.charLT)

		arg_18_0.charLT = nil
	end

	return
end

return var_0_1
