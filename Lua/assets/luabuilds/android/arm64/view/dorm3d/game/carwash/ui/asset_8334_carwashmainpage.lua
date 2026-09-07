local CarWashMainPage = class("CarWashMainPage", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

CarWashMainPage.SHOW_BLACK_SCREEN = "CarWashMainPage.SHOW_BLACK_SCREEN"
CarWashMainPage.SHOW_HELP_BOX = "CarWashMainPage.SHOW_HELP_BOX"
CarWashMainPage.SHOW_EXPRESSION_HUD = "CarWashMainPage.SHOW_EXPRESSION_HUD"
CarWashMainPage.ENABLE_BLOCK = "CarWashMainPage.ENABLE_BLOCK"
CarWashMainPage.EXPRESSION_TYPE = {
	LIKE = "LIKE",
	HATE = "HATE"
}

function CarWashMainPage:Init()
	self:InitUI()
	self:BindEvent()

	return
end

function CarWashMainPage:InitUI()
	onButton(self, self._tf:Find("btn_back"), function()
		self:emit(BaseUI.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("btn_help"), function()
		self:ShowHelpBox()

		return
	end)

	self.expressionRoot = self._tf:Find("expression_root")
	self.expressionLike = self.expressionRoot:Find("vfx_car_aixin01")
	self.expressionHate = self.expressionRoot:Find("vfx_car_xixian01")

	setActive(self.expressionLike, false)
	setActive(self.expressionHate, false)

	self.blockLayer = self._tf:Find("block")

	self:EnableBlock(false)

	self.blackLayer = self._tf:Find("BlackScreen")
	self.povLayer = self._tf:Find("POVControl")

	self:UpdatePOV()

	return
end

function CarWashMainPage:BindEvent()
	self:bind(CarWashMainPage.SHOW_BLACK_SCREEN, self.ShowBlackScreen)
	self:bind(CarWashMainPage.SHOW_HELP_BOX, function(arg_6_0, arg_6_1)
		self:ShowHelpBox(arg_6_1)

		return
	end)
	self:bind(CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION, function(arg_7_0, arg_7_1)
		self:UpdateExpressionHUDPosition(arg_7_1)

		return
	end)
	self:bind(CarWashMainPage.SHOW_EXPRESSION_HUD, function(arg_8_0, arg_8_1)
		local var_8_0 = switch(arg_8_1, {
			[CarWashMainPage.EXPRESSION_TYPE.LIKE] = function()
				return self.expressionLike
			end,
			[CarWashMainPage.EXPRESSION_TYPE.HATE] = function()
				return self.expressionHate
			end
		}, function()
			assert(false, "CarWashMainPage: unknown expression type: " .. tostring(arg_8_1))

			return nil
		end)

		setActive(var_8_0, false)
		setActive(var_8_0, true)

		return
	end)
	self:bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_12_0, arg_12_1)
		if arg_12_1 and arg_12_1.data and arg_12_1.data.hideUI == false then
			return
		end

		self:Hide()

		return
	end)
	self:bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_13_0, arg_13_1)
		if arg_13_1 and arg_13_1.data and arg_13_1.data.hideUI == false then
			return
		end

		self:Show()

		return
	end)
	self:bind(CarWashTimelineSystem.TRANSITION_BEGIN, function()
		self:EnableBlock(true)

		return
	end)
	self:bind(CarWashTimelineSystem.TRANSITION_END, function()
		self:EnableBlock(false)

		return
	end)

	return
end

function CarWashMainPage:UpdatePOV()
	local var_16_0 = self.povLayer:Find("Move"):GetComponent(typeof(SlideController))

	var_16_0:AddBeginDragFunc(function(arg_17_0, arg_17_1)
		self:emit(CarWashPovControlSystem.ON_STICK_MOVE_BEGIN, arg_17_1)

		return
	end)
	var_16_0:SetStickFunc(function(arg_18_0)
		self:emit(CarWashPovControlSystem.ON_STICK_MOVE, arg_18_0)

		return
	end)
	var_16_0:AddDragEndFunc(function(arg_19_0, arg_19_1)
		self:emit(CarWashPovControlSystem.ON_STICK_MOVE_END, arg_19_1)

		return
	end)
	self.povLayer:Find("View"):GetComponent(typeof(SlideController)):SetStickFunc(function(arg_20_0)
		self:emit(CarWashPovControlSystem.ON_STICK_VIEW, arg_20_0)

		return
	end)

	return
end

function CarWashMainPage:Flush()
	return
end

function CarWashMainPage:UpdateExpressionHUDPosition(arg_22_1)
	if not arg_22_1 then
		return
	end

	setActive(self.expressionRoot, arg_22_1.visible)

	if arg_22_1.visible then
		setLocalPosition(self.expressionRoot, LuaHelper.ScreenToLocal(self.expressionRoot.parent, arg_22_1.screenPosition, pg.UIMgr.GetInstance().uiCameraComp))
	end

	return
end

function CarWashMainPage:ShowHelpBox(arg_23_1)
	pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
		title = i18n("dorm3d_carwash_title"),
		contentText = i18n("dorm3d_carwash_tiiiiiip"),
		onConfirm = function()
			existCall(arg_23_1)

			return
		end,
		onClose = function()
			existCall(arg_23_1)

			return
		end
	})

	return
end

function CarWashMainPage:EnableBlock(arg_26_1)
	setActive(self.blockLayer, arg_26_1)

	return
end

function CarWashMainPage:ShowBlackScreen(arg_27_1, arg_27_2)
	local var_27_0 = {
		color = "#000000",
		time = 0.3,
		delay = arg_27_1 and 0 or 0.3
	}

	setImageColor(self.blackLayer, Color.NewHex(var_27_0.color))
	setActive(self.blackLayer, true)
	setCanvasGroupAlpha(self.blackLayer, arg_27_1 and 0 or 1)
	self:managedTween(LeanTween.alphaCanvas, function()
		if not arg_27_1 then
			setActive(self.blackLayer, false)
		end

		existCall(arg_27_2)

		return
	end, GetComponent(self.blackLayer, typeof(CanvasGroup)), arg_27_1 and 1 or 0, var_27_0.time):setDelay(var_27_0.delay)

	return
end

return CarWashMainPage
