class = var_0_10000

local var_0_0 = "MainWordView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))

var_0_1.START_ANIMATION = "MainWordView:ON_ANIMATION"
var_0_1.STOP_ANIMATION = "MainWordView:STOP_ANIMATION"
var_0_1.SET_CONTENT = "MainWordView:SET_CONTENT"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.chatTf = arg_1_1
	arg_1_0.chatPos = arg_1_0.chatTf.anchoredPosition

	local var_1_0 = arg_1_0.chatTf
	local var_1_1 = var_3.Find(var_1_0, "Text")
	local var_1_2 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.chatTxt = var_1_2(var_1_1, var_6(var_1_10008))

	local var_1_3 = arg_1_0.chatTf

	arg_1_0.chatTextBg = var_3.Find(var_1_3, "chatbgtop")
	arg_1_0.initChatBgH = arg_1_0.chatTextBg.sizeDelta.y
	arg_1_0.stopChatFlag = false

	arg_1_0:Register()

	return
end

function var_0_1.Register(arg_2_0)
	arg_2_0:bind(var_0_1.START_ANIMATION, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_2_0

		var_3.StartAnimation(var_3_0, arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:bind(var_0_1.STOP_ANIMATION, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0

		var_3.StopAnimation(var_4_0, arg_4_1, arg_4_2)

		return
	end)
	arg_2_0:bind(var_0_1.SET_CONTENT, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0

		var_3.AdjustChatPosition(var_5_0, arg_5_1, arg_5_2)

		return
	end)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	GAME = var_4

	var_2_1(var_2_0, var_4.LOAD_LAYERS, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1.context.mediator

		CommissionInfoMediator = var_2_10004

		if var_6_0 ~= var_2_10004 then
			local var_6_1 = var_2.mediator

			NotificationMediator = var_2_10004

			if var_6_1 == var_2_10004 then
				local var_6_2 = arg_2_0

				var_3.StopAnimation(var_6_2)

				arg_2_0.stopChatFlag = true
			end

			return
		end
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	GAME = var_4

	var_2_3(var_2_2, var_4.WILL_LOGOUT, function()
		arg_2_0.stopChatFlag = false

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.bind

	GAME = var_4

	var_2_5(var_2_4, var_4.REMOVE_LAYERS, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.context.mediator

		CommissionInfoMediator = var_2_10004

		if var_8_0 ~= var_2_10004 then
			local var_8_1 = var_2.mediator

			NotificationMediator = var_2_10004

			if var_8_1 == var_2_10004 then
				arg_2_0.stopChatFlag = false
			end

			return
		end
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.bind

	NewMainScene = var_4

	var_2_7(var_2_6, var_4.ENTER_SILENT_VIEW, function()
		local var_9_0 = arg_2_0

		var_0.StopAnimation(var_9_0)

		arg_2_0.stopChatFlag = true

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.bind

	NewMainScene = var_4

	var_2_9(var_2_8, var_4.EXIT_SILENT_VIEW, function()
		arg_2_0.stopChatFlag = false

		return
	end)

	return
end

function var_0_1.Fold(arg_11_0, arg_11_1, arg_11_2)
	LeanTween = var_1_10003

	local var_11_0 = var_1_10003.cancel

	go = var_1_10005

	var_11_0(var_1_10005(arg_11_0.chatTf))

	if not arg_11_1 then
		arg_11_0.chatTf.anchoredPosition = arg_11_0.chatPos
	elseif arg_11_2 > 0 then
		local var_11_1 = arg_11_0.chatTf.anchoredPosition.x

		LeanTween = var_1_10004

		local var_11_2 = var_1_10004.value

		go = var_1_10006

		local var_11_3 = var_11_2(var_1_10006(arg_11_0.chatTf), var_11_1, 0, arg_11_2)
		local var_11_4 = var_4.setOnUpdate

		System = var_7

		local var_11_5 = var_11_4(var_11_3, var_7.Action_float(function(arg_12_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_11_0.chatTf, {
				x = arg_12_0
			})

			return
		end))
		local var_11_6 = var_4.setEase

		LeanTweenType = var_7

		var_11_6(var_11_5, var_7.easeInOutExpo)
	end

	arg_11_0.isFoldState = arg_11_1

	return
end

function var_0_1.Refresh(arg_13_0)
	arg_13_0.stopChatFlag = false
	setActive = var_1

	var_1(arg_13_0.chatTxt.gameObject, false)

	setActive = var_1

	var_1(arg_13_0.chatTxt.gameObject, true)

	return
end

function var_0_1.Disable(arg_14_0)
	arg_14_0.stopChatFlag = false

	arg_14_0:StopAnimation()

	return
end

function var_0_1.StartAnimation(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.stopChatFlag == true then
		return
	end

	LeanTween = var_3

	if var_3.isTweening(arg_15_0.chatTf.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_15_0.chatTf.gameObject)
	end

	getProxy = var_3
	SettingsProxy = var_5

	local var_15_0 = var_3(var_5)
	local var_15_1 = var_3.ShouldShipMainSceneWord(var_15_0) and 1 or 0

	LeanTween = var_1_10004

	local var_15_2 = var_1_10004.scale

	rtf = var_1_10006

	local var_15_3 = var_1_10006(arg_15_0.chatTf.gameObject)

	Vector3 = var_1_10007

	local var_15_4 = var_15_2(var_15_3, var_1_10007.New(var_15_1, var_15_1, 1), arg_15_1)
	local var_15_5 = var_4.setEase

	LeanTweenType = var_7

	local var_15_6 = var_15_5(var_15_4, var_7.easeOutBack)
	local var_15_7 = var_4.setOnComplete

	System = var_7

	var_15_7(var_15_6, var_7.Action(function()
		LeanTween = var_2_10000

		local var_16_0 = var_2_10000.scale

		rtf = var_2_10002

		local var_16_1 = var_2_10002(arg_15_0.chatTf.gameObject)

		Vector3 = var_2_10003

		local var_16_2 = var_16_0(var_16_1, var_2_10003.New(0, 0, 1), arg_15_1)
		local var_16_3 = var_0.setEase

		LeanTweenType = var_3

		local var_16_4 = var_16_3(var_16_2, var_3.easeInBack)

		var_0.setDelay(var_16_4, arg_15_1 + arg_15_2)

		return
	end))

	return
end

function var_0_1.StopAnimation(arg_17_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_17_0.chatTf.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_17_0.chatTf.gameObject)
	end

	local var_17_0 = arg_17_0.chatTf

	Vector3 = var_1_10002
	var_17_0.localScale = var_1_10002.zero

	return
end

function var_0_1.AdjustChatPosition(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.chatTxt
	local var_18_1 = #arg_18_2

	CHAT_POP_STR_LEN = var_1_10005

	if var_1_10005 < var_18_1 then
		TextAnchor = var_18_1
		var_18_0.alignment = var_18_1.MiddleLeft
	else
		TextAnchor = var_18_1
		var_18_0.alignment = var_18_1.MiddleCenter
	end

	local var_18_2 = var_18_0.preferredHeight + 26
	local var_18_3

	if arg_18_0.initChatBgH < var_18_2 then
		var_18_3 = arg_18_0.chatTextBg
		Vector2 = var_1_10006
		var_18_3.sizeDelta = var_1_10006.New(arg_18_0.chatTextBg.sizeDelta.x, var_18_2)
	else
		var_18_3 = arg_18_0.chatTextBg
		Vector2 = var_1_10006
		var_18_3.sizeDelta = var_1_10006.New(arg_18_0.chatTextBg.sizeDelta.x, arg_18_0.initChatBgH)
	end

	PLATFORM_CODE = var_18_3
	PLATFORM_US = var_1_10006

	if var_18_3 == var_1_10006 then
		setTextEN = var_18_3

		var_18_3(arg_18_0.chatTxt, arg_18_2)
	else
		setText = var_18_3

		local var_18_4 = arg_18_0.chatTxt

		SwitchSpecialChar = var_1_10008

		var_18_3(var_18_4, var_1_10008(arg_18_2))
	end

	arg_18_0:RegisterBtn(arg_18_1)

	return
end

function var_0_1.RegisterBtn(arg_19_0, arg_19_1)
	removeOnButton = var_1_10002

	var_1_10002(arg_19_0.chatTf)

	onButton = var_1_10002

	var_1_10002(arg_19_0, arg_19_0.chatTf, function()
		if arg_19_1 == "mission_complete" or arg_19_1 == "mission" then
			pg = var_0

			local var_20_0 = var_0.m02
			local var_20_1 = var_0.sendNotification

			GAME = var_2_10003
			var_2_10003 = var_2_10003.GO_SCENE
			SCENE = var_2_10004

			var_20_1(var_20_0, var_2_10003, var_2_10004.TASK)
		elseif arg_19_1 == "collection" then
			pg = var_0

			local var_20_2 = var_0.m02
			local var_20_3 = var_0.sendNotification

			GAME = var_2_10003
			var_2_10003 = var_2_10003.GO_SCENE
			SCENE = var_2_10004

			var_20_3(var_20_2, var_2_10003, var_2_10004.EVENT)
		elseif arg_19_1 == "event_complete" then
			pg = var_0

			local var_20_4 = var_0.m02
			local var_20_5 = var_0.sendNotification

			GAME = var_2_10003

			local var_20_6 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_20_5(var_20_4, var_20_6, var_2_10004.EVENT)
		end

		return
	end)

	return
end

function var_0_1.Dispose(arg_21_0)
	var_0_1.super.Dispose(arg_21_0)

	LeanTween = var_1

	var_1.cancel(arg_21_0.chatTf.gameObject)

	return
end

return var_0_1
