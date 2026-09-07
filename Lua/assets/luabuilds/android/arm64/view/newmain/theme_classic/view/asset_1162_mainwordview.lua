local MainWordView = class("MainWordView", import("...base.MainBaseView"))

MainWordView.START_ANIMATION = "MainWordView:ON_ANIMATION"
MainWordView.STOP_ANIMATION = "MainWordView:STOP_ANIMATION"
MainWordView.SET_CONTENT = "MainWordView:SET_CONTENT"

function MainWordView:Ctor(arg_1_1, arg_1_2)
	MainWordView.super.Ctor(self, arg_1_1, arg_1_2)

	self.chatTf = arg_1_1
	self.chatPos = self.chatTf.anchoredPosition
	self.chatTxt = self.chatTf:Find("Text"):GetComponent(typeof(Text))
	self.chatTextBg = self.chatTf:Find("chatbgtop")
	self.initChatBgH = self.chatTextBg.sizeDelta.y
	self.stopChatFlag = false

	self:Register()

	return
end

function MainWordView:Register()
	self:bind(MainWordView.START_ANIMATION, function(arg_3_0, arg_3_1, arg_3_2)
		self:StartAnimation(arg_3_1, arg_3_2)

		return
	end)
	self:bind(MainWordView.STOP_ANIMATION, function(arg_4_0, arg_4_1, arg_4_2)
		self:StopAnimation(arg_4_1, arg_4_2)

		return
	end)
	self:bind(MainWordView.SET_CONTENT, function(arg_5_0, arg_5_1, arg_5_2)
		self:AdjustChatPosition(arg_5_1, arg_5_2)

		return
	end)
	self:bind(GAME.LOAD_LAYERS, function(arg_6_0, arg_6_1)
		if arg_6_1.context.mediator == CommissionInfoMediator or arg_6_1.context.mediator == NotificationMediator then
			self:StopAnimation()

			self.stopChatFlag = true
		end

		return
	end)
	self:bind(GAME.WILL_LOGOUT, function()
		self.stopChatFlag = false

		return
	end)
	self:bind(GAME.REMOVE_LAYERS, function(arg_8_0, arg_8_1)
		if arg_8_1.context.mediator == CommissionInfoMediator or arg_8_1.context.mediator == NotificationMediator then
			self.stopChatFlag = false
		end

		return
	end)
	self:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		self:StopAnimation()

		self.stopChatFlag = true

		return
	end)
	self:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		self.stopChatFlag = false

		return
	end)

	return
end

function MainWordView:Fold(arg_11_1, arg_11_2)
	LeanTween.cancel(go(self.chatTf))

	if not arg_11_1 then
		self.chatTf.anchoredPosition = self.chatPos
	elseif arg_11_2 > 0 then
		LeanTween.value(go(self.chatTf), self.chatTf.anchoredPosition.x, 0, arg_11_2):setOnUpdate(System.Action_float(function(arg_12_0)
			setAnchoredPosition(self.chatTf, {
				x = arg_12_0
			})

			return
		end)):setEase(LeanTweenType.easeInOutExpo)
	end

	self.isFoldState = arg_11_1

	return
end

function MainWordView:Refresh()
	self.stopChatFlag = false

	setActive(self.chatTxt.gameObject, false)
	setActive(self.chatTxt.gameObject, true)

	return
end

function MainWordView:Disable()
	self.stopChatFlag = false

	self:StopAnimation()

	return
end

function MainWordView:StartAnimation(arg_15_1, arg_15_2)
	if self.stopChatFlag == true then
		return
	end

	if LeanTween.isTweening(self.chatTf.gameObject) then
		LeanTween.cancel(self.chatTf.gameObject)
	end

	local var_15_0 = getProxy(SettingsProxy):ShouldShipMainSceneWord() and 1 or 0

	LeanTween.scale(rtf(self.chatTf.gameObject), Vector3.New(var_15_0, var_15_0, 1), arg_15_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self.chatTf.gameObject), Vector3.New(0, 0, 1), arg_15_1):setEase(LeanTweenType.easeInBack):setDelay(arg_15_1 + arg_15_2)

		return
	end))

	return
end

function MainWordView:StopAnimation()
	if LeanTween.isTweening(self.chatTf.gameObject) then
		LeanTween.cancel(self.chatTf.gameObject)
	end

	self.chatTf.localScale = Vector3.zero

	return
end

function MainWordView:AdjustChatPosition(arg_18_1, arg_18_2)
	self.chatTxt.alignment = #arg_18_2 > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	self.chatTextBg.sizeDelta = self.chatTxt.preferredHeight + 26 > self.initChatBgH and Vector2.New(self.chatTextBg.sizeDelta.x, self.chatTxt.preferredHeight + 26) or Vector2.New(self.chatTextBg.sizeDelta.x, self.initChatBgH)

	if PLATFORM_CODE == PLATFORM_US then
		setTextEN(self.chatTxt, arg_18_2)
	else
		setText(self.chatTxt, SwitchSpecialChar(arg_18_2))
	end

	self:RegisterBtn(arg_18_1)

	return
end

function MainWordView:RegisterBtn(arg_19_1)
	removeOnButton(self.chatTf)
	onButton(self, self.chatTf, function()
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

function MainWordView:Dispose()
	MainWordView.super.Dispose(self)
	LeanTween.cancel(self.chatTf.gameObject)

	return
end

return MainWordView
