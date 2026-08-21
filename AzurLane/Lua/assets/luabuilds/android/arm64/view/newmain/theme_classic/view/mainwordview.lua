local var_0_0 = class("MainWordView", import("...base.MainBaseView"))

var_0_0.START_ANIMATION = "MainWordView:ON_ANIMATION"
var_0_0.STOP_ANIMATION = "MainWordView:STOP_ANIMATION"
var_0_0.SET_CONTENT = "MainWordView:SET_CONTENT"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.chatTf = arg_1_1
	arg_1_0.chatPos = arg_1_0.chatTf.anchoredPosition
	arg_1_0.chatTxt = arg_1_0.chatTf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.chatTextBg = arg_1_0.chatTf:Find("chatbgtop")
	arg_1_0.initChatBgH = arg_1_0.chatTextBg.sizeDelta.y
	arg_1_0.stopChatFlag = false

	arg_1_0:Register()

	return
end

function var_0_0.Register(arg_2_0)
	arg_2_0:bind(var_0_0.START_ANIMATION, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:StartAnimation(arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:bind(var_0_0.STOP_ANIMATION, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:StopAnimation(arg_4_1, arg_4_2)

		return
	end)
	arg_2_0:bind(var_0_0.SET_CONTENT, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:AdjustChatPosition(arg_5_1, arg_5_2)

		return
	end)
	arg_2_0:bind(GAME.LOAD_LAYERS, function(arg_6_0, arg_6_1)
		if arg_6_1.context.mediator == CommissionInfoMediator or arg_6_1.context.mediator == NotificationMediator then
			arg_2_0:StopAnimation()

			arg_2_0.stopChatFlag = true
		end

		return
	end)
	arg_2_0:bind(GAME.WILL_LOGOUT, function()
		arg_2_0.stopChatFlag = false

		return
	end)
	arg_2_0:bind(GAME.REMOVE_LAYERS, function(arg_8_0, arg_8_1)
		if arg_8_1.context.mediator == CommissionInfoMediator or arg_8_1.context.mediator == NotificationMediator then
			arg_2_0.stopChatFlag = false
		end

		return
	end)
	arg_2_0:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		arg_2_0:StopAnimation()

		arg_2_0.stopChatFlag = true

		return
	end)
	arg_2_0:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		arg_2_0.stopChatFlag = false

		return
	end)

	return
end

function var_0_0.Fold(arg_11_0, arg_11_1, arg_11_2)
	LeanTween.cancel(go(arg_11_0.chatTf))

	if not arg_11_1 then
		arg_11_0.chatTf.anchoredPosition = arg_11_0.chatPos
	elseif arg_11_2 > 0 then
		LeanTween.value(go(arg_11_0.chatTf), arg_11_0.chatTf.anchoredPosition.x, 0, arg_11_2):setOnUpdate(System.Action_float(function(arg_12_0)
			setAnchoredPosition(arg_11_0.chatTf, {
				x = arg_12_0
			})

			return
		end)):setEase(LeanTweenType.easeInOutExpo)
	end

	arg_11_0.isFoldState = arg_11_1

	return
end

function var_0_0.Refresh(arg_13_0)
	arg_13_0.stopChatFlag = false

	setActive(arg_13_0.chatTxt.gameObject, false)
	setActive(arg_13_0.chatTxt.gameObject, true)

	return
end

function var_0_0.Disable(arg_14_0)
	arg_14_0.stopChatFlag = false

	arg_14_0:StopAnimation()

	return
end

function var_0_0.StartAnimation(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.stopChatFlag == true then
		return
	end

	if LeanTween.isTweening(arg_15_0.chatTf.gameObject) then
		LeanTween.cancel(arg_15_0.chatTf.gameObject)
	end

	local var_15_0 = getProxy(SettingsProxy)
	local var_15_1 = var_15_0:ShouldShipMainSceneWord() and 1 or 0

	LeanTween.scale(rtf(arg_15_0.chatTf.gameObject), Vector3.New(var_15_1, var_15_1, 1), arg_15_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_15_0.chatTf.gameObject), Vector3.New(0, 0, 1), arg_15_1):setEase(LeanTweenType.easeInBack):setDelay(arg_15_1 + arg_15_2)

		return
	end))

	return
end

function var_0_0.StopAnimation(arg_17_0)
	if LeanTween.isTweening(arg_17_0.chatTf.gameObject) then
		LeanTween.cancel(arg_17_0.chatTf.gameObject)
	end

	arg_17_0.chatTf.localScale = Vector3.zero

	return
end

function var_0_0.AdjustChatPosition(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.chatTxt.alignment = #arg_18_2 > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	local var_18_0 = arg_18_0.chatTxt.preferredHeight + 26

	arg_18_0.chatTextBg.sizeDelta = arg_18_0.chatTxt.preferredHeight + 26 > arg_18_0.initChatBgH and Vector2.New(arg_18_0.chatTextBg.sizeDelta.x, var_18_0) or Vector2.New(arg_18_0.chatTextBg.sizeDelta.x, arg_18_0.initChatBgH)

	if PLATFORM_CODE == PLATFORM_US then
		setTextEN(arg_18_0.chatTxt, arg_18_2)
	else
		setText(arg_18_0.chatTxt, SwitchSpecialChar(arg_18_2))
	end

	arg_18_0:RegisterBtn(arg_18_1)

	return
end

function var_0_0.RegisterBtn(arg_19_0, arg_19_1)
	removeOnButton(arg_19_0.chatTf)
	onButton(arg_19_0, arg_19_0.chatTf, function()
		if arg_19_1 == "mission_complete" or arg_19_1 == "mission" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TASK)
		elseif arg_19_1 == "collection" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		elseif arg_19_1 == "event_complete" then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end

		return
	end)

	return
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
	LeanTween.cancel(arg_21_0.chatTf.gameObject)

	return
end

return var_0_0
