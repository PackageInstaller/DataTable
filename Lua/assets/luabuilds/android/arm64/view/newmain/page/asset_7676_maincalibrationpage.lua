local MainCalibrationPage = class("MainCalibrationPage", import("view.base.BaseSubView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function MainCalibrationPage:getUIName()
	return "MainCalibrationUI"
end

function MainCalibrationPage:OnLoaded()
	self.moveBtn = self._tf:Find("move")
	self.setBtn = self._tf:Find("set")
	self.scaleSetBtn = self._tf:Find("scale_set")
	self.backBtn = self._tf:Find("back")
	self.scaleContent = self._tf:Find("scale_content")
	self.resetBtn = self._tf:Find("reset")
	self.saveBtn = self._tf:Find("save")
	self.bgImage = self._tf:Find("adapt/bg"):GetComponent(typeof(Image))
	self.paintingTF = self._parentTf:Find("paint")
	self._bgTf = self._parentTf:Find("paintBg")
	self.l2dContainer = self.paintingTF:Find("live2d")
	self.spineContainer = self.paintingTF:Find("spinePainting")
	self.setBtnX = self.setBtn.localPosition.x
	self.scaleSetBtnX = self.scaleSetBtn.localPosition.x
	self.btnSelectX = self.moveBtn.localPosition.x
	self.showing = false
	self.pageCG = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.pageCG.ignoreParentGroups = true
	self.pageCG.interactable = true
	self.pageCG.blocksRaycasts = true

	return
end

function MainCalibrationPage:OnInit()
	self.stateType = 0

	onButton(self, self._parentTf, function()
		if self.stateType > 0 then
			return
		end

		if self.showing then
			self:exitToggle()
			self:emit(NewMainScene.FOLD, false)
		end

		return
	end)
	onToggle(self, self.moveBtn, function(arg_5_0)
		if arg_5_0 then
			self.stateType = var_0_2 or var_0_1
		end

		self:updateState()

		return
	end, SFX_PANEL)
	onToggle(self, self.setBtn, function(arg_6_0)
		if arg_6_0 then
			self.stateType = var_0_3 or var_0_1
		end

		self:updateState()

		return
	end, SFX_PANEL)
	onToggle(self, self.scaleSetBtn, function(arg_7_0)
		if arg_7_0 then
			self.stateType = var_0_4 or var_0_1
		end

		self:updateState()

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:exitToggle()
		self:emit(NewMainScene.FOLD, false)

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		self:SavePostion()
		self:updateState()

		return
	end, SFX_PANEL)
	onButton(self, self.resetBtn, function()
		if self.stateType == var_0_3 then
			self:ResetPostion()
		elseif self.stateType == var_0_4 then
			self:emit(NewMainScene.RESET_PAITING_SCALE)
		end

		return
	end, SFX_PANEL)
	self:bind(NewMainScene.SET_SCALE_PART_CONTENT, function(arg_11_0, arg_11_1)
		setParent(arg_11_1, self.scaleContent, true)

		return
	end)

	return
end

function MainCalibrationPage:Move(arg_12_1)
	setToggleEnabled(self.setBtn, not arg_12_1)
	self:emit(NewMainScene.ENABLE_PAITING_MOVE, arg_12_1)

	return
end

function MainCalibrationPage:exitToggle()
	if self.stateType == var_0_2 then
		triggerToggle(self.moveBtn, false)
	elseif self.stateType == var_0_3 then
		triggerToggle(self.setBtn, false)
	elseif self.stateType == var_0_4 then
		triggerToggle(self.scaleSetBtn, false)
	end

	self.stateType = var_0_1

	return
end

function MainCalibrationPage:updateState()
	setActive(self.moveBtn, self.stateType == var_0_1)
	setActive(self.setBtn, self.stateType == var_0_1)
	setActive(self.scaleSetBtn, self.stateType == var_0_1 and not self.hideScaleSet)
	setActive(self.scaleContent, false)

	if self.stateType == var_0_2 then
		setActive(self.moveBtn, true)
	elseif self.stateType == var_0_3 then
		setActive(self.setBtn, true)
	elseif self.stateType == var_0_4 then
		setActive(self.scaleContent, true)
		setActive(self.scaleSetBtn, true)
	end

	setActive(self.backBtn, self.stateType == var_0_1)
	setActive(self.resetBtn, self.stateType > var_0_2)
	setActive(self.saveBtn, self.stateType > var_0_2)

	self.bgImage.enabled = self.stateType ~= var_0_1 and self.stateType ~= var_0_2

	if self.stateType > 0 then
		if self.stateType == var_0_2 then
			LeanTween.moveLocalX(self.moveBtn.gameObject, self.btnSelectX, 0.2)
		elseif self.stateType == var_0_3 then
			LeanTween.moveLocalX(self.setBtn.gameObject, self.btnSelectX, 0.2)
		elseif self.stateType == var_0_4 then
			LeanTween.moveLocalX(self.scaleSetBtn.gameObject, self.btnSelectX, 0.2)
		end
	else
		LeanTween.moveLocalX(self.moveBtn.gameObject, self.btnSelectX, 0.2)
		LeanTween.moveLocalX(self.setBtn.gameObject, self.setBtnX, 0.2)
		LeanTween.moveLocalX(self.scaleSetBtn.gameObject, self.scaleSetBtnX, 0.2)
	end

	if self.stateType == var_0_1 then
		self:emit(NewMainScene.ENABLE_PAITING_MOVE, false)
		self:emit(NewMainScene.ENABLE_PAITING_SCALE, false)
	elseif self.stateType == var_0_2 or self.stateType == var_0_3 then
		self:emit(NewMainScene.ENABLE_PAITING_MOVE, true)
	else
		local var_14_0

		if self.stateType == var_0_4 then
			self:emit(NewMainScene.ENABLE_PAITING_SCALE, true)

			var_14_0 = self.stateType > 1 and 0 or -150
		end
	end

	local var_14_1 = LeanTween.value(self.backBtn.gameObject, var_14_0, self.stateType > 1 and -150 or 0, 0.3):setOnUpdate(System.Action_float(function(arg_15_0)
		self.resetBtn.anchoredPosition = Vector2(arg_15_0, self.resetBtn.anchoredPosition.y)
		self.saveBtn.anchoredPosition = Vector2(arg_15_0, self.saveBtn.anchoredPosition.y)

		return
	end))

	return
end

function MainCalibrationPage:SetPostion(arg_16_1)
	local function var_16_0()
		setActive(self.moveBtn, not arg_16_1)
		setActive(self.backBtn, not arg_16_1)
		setActive(self.scaleSetBtn, not arg_16_1)

		return
	end

	self.bgImage.enabled = arg_16_1

	LeanTween.moveLocalX(self.setBtn.gameObject, (arg_16_1 or nil) and (self.moveBtn.localPosition.x or self.setBtnX), 0.2)

	if arg_16_1 then
		var_16_0()
	else
		LeanTween.value(self.backBtn.gameObject, arg_16_1 and 0 or -150, arg_16_1 and -150 or 0, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
			self.resetBtn.anchoredPosition = Vector2(arg_18_0, self.resetBtn.anchoredPosition.y)
			self.saveBtn.anchoredPosition = Vector2(arg_18_0, self.saveBtn.anchoredPosition.y)

			return
		end)):setOnComplete(System.Action(var_16_0))
	end

	self:emit(NewMainScene.ENABLE_PAITING_MOVE, arg_16_1)

	return
end

function MainCalibrationPage:SavePostion()
	if self.stateType == var_0_3 then
		local var_19_0 = self.paintingTF.anchoredPosition
		local var_19_1 = self.paintingTF.localScale.x
		local var_19_2 = self.flagShip:getSkinId()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("secretary_pos_save"),
			onYes = function()
				getProxy(SettingsProxy):setSkinPosSetting(self.flagShip, var_19_0.x, var_19_0.y, var_19_1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_pos_save_success"))
				self:exitToggle()
				self:emit(NewMainScene.FOLD, false)

				return
			end
		})
	elseif self.stateType == var_0_4 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("secretary_pos_save"),
			onYes = function()
				self:emit(NewMainScene.SAVE_PART_SCALE)
				pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_pos_save_success"))
				self:exitToggle()
				self:emit(NewMainScene.FOLD, false)

				return
			end
		})
	end

	return
end

function MainCalibrationPage:ResetPostion()
	getProxy(SettingsProxy):resetSkinPosSetting(self.flagShip)

	local var_22_0 = MainPaintingView.GetAssistantStatus(self.flagShip)
	local var_22_1, var_22_2 = self.shift:GetMeshImageShift()

	self.paintingTF.anchoredPosition = var_22_1
	self._bgTf.anchoredPosition = var_22_1

	local var_22_3, var_22_4 = self.shift:GetL2dShift()

	if MainPaintingShift.IsLimitYPos(self.flagShip:getPainting()) then
		var_22_3.y = MainPaintingShift.GetHalfBodyOffsetY(self.paintingTF.parent, self.l2dContainer)
	end

	self.l2dContainer.anchoredPosition = var_22_3

	local var_22_5, var_22_6 = self.shift:GetSpineShift()

	self.spineContainer.anchoredPosition = var_22_5

	if var_22_0 == MainPaintingView.STATE_L2D then
		self._bgTf.localScale = var_22_4
		self.paintingTF.localScale = var_22_4
	elseif var_22_0 == MainPaintingView.STATE_SPINE_PAINTING then
		self._bgTf.localScale = var_22_6
		self.paintingTF.localScale = var_22_6
	else
		self._bgTf.localScale = var_22_2
		self.paintingTF.localScale = var_22_2
	end

	return
end

function MainCalibrationPage:ShowOrHide(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self.flagShip = arg_23_2
	self.showing = arg_23_1

	local var_23_0 = MainPaintingView.GetAssistantStatus(self.flagShip)

	self.hideScaleSet = true

	local var_23_1 = pg.ship_skin_template[self.flagShip:getSkinId()].part_scale

	if var_23_0 == MainPaintingView.STATE_PAINTING and var_23_1.paint and #var_23_1.paint > 0 then
		self.hideScaleSet = false
	elseif var_23_0 == MainPaintingView.STATE_SPINE_PAINTING and var_23_1.spine and #var_23_1.spine > 0 then
		self.hideScaleSet = false
	end

	if arg_23_1 then
		self:Show(arg_23_3)
		self:UpdateBg(arg_23_4)
		self:updateState()
	else
		self:Hide()
	end

	return
end

function MainCalibrationPage:UpdateBg(arg_24_1)
	if arg_24_1 == self.bgName then
		return
	end

	LoadSpriteAsync("clutter/" .. arg_24_1, function(arg_25_0)
		if self.exited then
			return
		end

		self.bgImage.sprite = arg_25_0

		return
	end)

	self.bgName = arg_24_1

	return
end

function MainCalibrationPage:Show(arg_26_1)
	MainCalibrationPage.super.Show(self)

	self.shift = arg_26_1

	self:DoBottomAnimation(0, 100)
	self:DoLeftAnimation(0, -150, function()
		return
	end)

	return
end

function MainCalibrationPage:DoLeftAnimation(arg_28_1, arg_28_2, arg_28_3)
	LeanTween.value(self.backBtn.gameObject, arg_28_1, arg_28_2, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
		self.backBtn.anchoredPosition = Vector2(arg_29_0, self.backBtn.anchoredPosition.y)

		return
	end)):setOnComplete(System.Action(arg_28_3))

	return
end

function MainCalibrationPage:DoBottomAnimation(arg_30_1, arg_30_2)
	LeanTween.value(self.moveBtn.gameObject, arg_30_1, arg_30_2, 0.3):setOnUpdate(System.Action_float(function(arg_31_0)
		self.moveBtn.anchoredPosition = Vector2(self.moveBtn.anchoredPosition.x, arg_31_0)
		self.setBtn.anchoredPosition = Vector2(self.setBtn.anchoredPosition.x, arg_31_0)
		self.scaleSetBtn.anchoredPosition = Vector2(self.scaleSetBtn.anchoredPosition.x, arg_31_0)

		return
	end))

	return
end

function MainCalibrationPage:Hide()
	self:DoBottomAnimation(100, 0)
	self:DoLeftAnimation(-150, 0, function()
		MainCalibrationPage.super.Hide(self)

		return
	end)

	return
end

function MainCalibrationPage:Reset()
	MainCalibrationPage.super.Reset(self)

	self.exited = false

	return
end

function MainCalibrationPage:OnDestroy()
	self.exited = true
	self.bgName = nil

	return
end

return MainCalibrationPage
