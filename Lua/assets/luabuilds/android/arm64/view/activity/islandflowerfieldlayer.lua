local var_0_0 = class("IslandFlowerFieldLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFlowerFieldUI"
end

function var_0_0.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_0.init(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	local var_3_0 = arg_3_0._tf:Find("Text")

	setText(var_3_0, i18n("islandnode_tips6"))
	var_3_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(var_3_0, false)

		return
	end)

	arg_3_0.rtChars = arg_3_0._tf:Find("chars")
	arg_3_0.rtShip = arg_3_0.rtChars:GetChild(math.random(arg_3_0.rtChars.childCount) - 1)
	arg_3_0.contextData.shipConfigId = tonumber(arg_3_0.rtShip.name)

	eachChild(arg_3_0.rtChars, function(arg_5_0)
		setActive(arg_5_0, arg_5_0 == arg_3_0.rtShip)

		return
	end)

	arg_3_0.fieldList = {}
	arg_3_0.posList = {}

	eachChild(arg_3_0._tf:Find("field"), function(arg_6_0)
		eachChild(arg_6_0, function(arg_7_0)
			table.insert(arg_3_0.fieldList, arg_7_0)
			table.insert(arg_3_0.posList, arg_3_0.rtChars:InverseTransformPoint(arg_7_0.position))

			return
		end)

		return
	end)

	arg_3_0.rtField = arg_3_0._tf:Find("field")
	arg_3_0.rtBtnGet = arg_3_0._tf:Find("btn_get")

	onButton(arg_3_0, arg_3_0._tf:Find("btn_back"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)

	for iter_3_0, iter_3_1 in ipairs({
		"click",
		"click_lock"
	}) do
		onButton(arg_3_0, arg_3_0.rtBtnGet:Find(iter_3_1), function()
			if arg_3_0.timer then
				setActive(var_3_0, true)

				return
			end

			arg_3_0:emit(IslandFlowerFieldMediator.GET_FLOWER_AWARD, false)

			return
		end, SFX_CONFIRM)
	end

	return
end

function var_0_0.refreshDisplay(arg_10_0)
	local var_10_0 = pg.TimeMgr.GetInstance()
	local var_10_1 = var_10_0:GetServerTime() >= var_10_0:GetTimeToNextTime(math.max(arg_10_0.activity.data1, arg_10_0.activity.data2))

	setActive(arg_10_0.rtBtnGet:Find("click"), var_10_1)
	setActive(arg_10_0.rtBtnGet:Find("click_lock"), not var_10_1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.fieldList) do
		triggerToggle(iter_10_1, var_10_1)
	end

	local var_10_2

	if var_10_1 then
		setText(arg_10_0.rtBtnGet:Find("time/Text"), var_10_0:DescCDTime(0))

		goto label_10_0

		var_10_2 = 0
	end

	arg_10_0.timer = Timer.New(function()
		if var_10_2 < var_0 then
			var_10_2 = var_10_2 + 1

			setText(arg_10_0.rtBtnGet:Find("time/Text"), var_10_0:DescCDTime(var_0 - var_10_2))
		else
			arg_10_0.timer:Stop()

			arg_10_0.timer = nil

			arg_10_0:refreshDisplay()
		end

		return
	end, 1, var_10_0:GetTimeToNextTime() - var_10_0:GetServerTime())

	arg_10_0.timer.func()
	arg_10_0.timer:Start()

	::label_10_0::

	return
end

function var_0_0.didEnter(arg_12_0)
	local var_12_0 = pg.TimeMgr.GetInstance()

	if var_12_0:GetServerTime() - var_12_0:GetTimeToNextTime(math.max(arg_12_0.activity.data1, arg_12_0.activity.data2)) < 0 then
		arg_12_0:refreshDisplay()
	else
		arg_12_0:emit(IslandFlowerFieldMediator.GET_FLOWER_AWARD, true)
	end

	arg_12_0:DoCharAction()

	return
end

local var_0_1 = 50

function var_0_0.DoCharAction(arg_13_0)
	local var_13_0 = arg_13_0.posList[math.random(#arg_13_0.posList)] - arg_13_0.rtShip.anchoredPosition3D

	if var_13_0:SqrMagnitude() <= 0 then
		return arg_13_0:DoCharAction()
	end

	var_13_0.x = var_13_0.x - (var_13_0.x < 0 and -1 or 1) * 100

	table.insert({}, function(arg_14_0)
		SetAction(arg_13_0.rtShip, "jiaoshui_walk")
		setLocalScale(arg_13_0.rtShip, {
			x = (var_13_0.x < 0 and -1 or 1) * math.abs(arg_13_0.rtShip.localScale.x)
		})

		arg_13_0.charLT = LeanTween.move(arg_13_0.rtShip, arg_13_0.rtShip.anchoredPosition3D + var_13_0, var_13_0:Magnitude() / var_0_1):setOnComplete(System.Action(arg_14_0)).uniqueId

		return
	end)
	table.insert({}, function(arg_15_0)
		var_13_0 = var_0 - arg_13_0.rtShip.anchoredPosition3D

		SetAction(arg_13_0.rtShip, "jiaoshui", false)
		setLocalScale(arg_13_0.rtShip, {
			x = (var_13_0.x < 0 and -1 or 1) * math.abs(arg_13_0.rtShip.localScale.x)
		})

		arg_13_0.charLT = LeanTween.delayedCall(3, System.Action(arg_15_0)).uniqueId

		return
	end)
	table.insert({}, function(arg_16_0)
		SetAction(arg_13_0.rtShip, "jiaoshui_stand")

		arg_13_0.charLT = LeanTween.delayedCall(4.666666666666667, System.Action(arg_16_0)).uniqueId

		return
	end)
	seriesAsync({}, function()
		arg_13_0.charLT = nil

		arg_13_0:DoCharAction()

		return
	end)

	return
end

function var_0_0.willExit(arg_18_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_18_0._tf)

	if arg_18_0.timer then
		arg_18_0.timer:Stop()

		arg_18_0.timer = nil
	end

	if arg_18_0.charLT then
		LeanTween.cancel(arg_18_0.charLT)

		arg_18_0.charLT = nil
	end

	return
end

return var_0_0
