local MainPaintingView = class("MainPaintingView", import("..base.MainBaseView"))

MainPaintingView.STATE_PAINTING = 1
MainPaintingView.STATE_L2D = 2
MainPaintingView.STATE_SPINE_PAINTING = 3
MainPaintingView.STATE_EDUCATE_CHAR = 4
MainPaintingView.STATE_EDUCATE_SPINE = 5
MainPaintingView.STATE_EDUCATE_L2D = 6
MainPaintingView.MESH_POSITION_X_OFFSET = 145

function MainPaintingView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainPaintingView.super.Ctor(self, arg_1_1, arg_1_3)

	self._bgTf = arg_1_2
	self._bgGo = arg_1_2.gameObject
	self.l2dContainer = arg_1_1:Find("live2d")
	self.spineContainer = arg_1_1:Find("spinePainting")
	self.bgOffset = self._bgTf.localPosition - self._tf.localPosition
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.paintings = {
		MainMeshImagePainting.New(self._tf, self.event),
		MainLive2dPainting.New(self._tf, self.event),
		MainSpinePainting.New(self._tf, self.event, self._bgGo),
		MainEducateCharPainting.New(self._tf, self.event),
		MainEducateSpinePainting.New(self._tf, self.event, self._bgGo)
	}

	self:Register()

	return
end

function MainPaintingView:Register()
	self:bind(TaskProxy.TASK_ADDED, function(arg_3_0)
		self:OnStopVoice()

		return
	end)
	self:bind(NewMainScene.CHAT_STATE_CHANGE, function(arg_4_0, arg_4_1)
		self:OnChatStateChange(arg_4_1)

		return
	end)
	self:bind(NewMainScene.ENABLE_PAITING_MOVE, function(arg_5_0, arg_5_1)
		self:EnableOrDisableMove(arg_5_1)

		return
	end)
	self:bind(NewMainScene.SAVE_PART_SCALE, function(arg_6_0, arg_6_1)
		self.painting:SavePartScaleData()

		return
	end)
	self:bind(NewMainScene.ENABLE_PAITING_SCALE, function(arg_7_0, arg_7_1)
		self:EnableOrDisableScale(arg_7_1)

		return
	end)
	self:bind(NewMainScene.RESET_PAITING_SCALE, function(arg_8_0, arg_8_1)
		self.painting:ResetPartScale()

		return
	end)
	self:bind(NewMainScene.ON_ENTER_DONE, function(arg_9_0)
		if self.painting then
			self.painting:TriggerEventAtFirstTime()
		end

		return
	end)
	self:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		self.cg.blocksRaycasts = false
		self.silentFlag = true

		for iter_10_0, iter_10_1 in ipairs(self.paintings) do
			iter_10_1:PauseForSilent()
		end

		return
	end)
	self:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		self.cg.blocksRaycasts = true
		self.silentFlag = false

		for iter_11_0, iter_11_1 in ipairs(self.paintings) do
			iter_11_1:ResumeForSilent()
		end

		return
	end)
	self:bind(NewMainScene.RESET_L2D, function()
		if not self.painting then
			return
		end

		if not isa(self.painting, MainLive2dPainting) then
			return
		end

		self.painting:ResetState()

		return
	end)

	function Live2dConst.UnLoadL2dPating()
		if not self.reloadOnResume and self.painting and isa(self.painting, MainLive2dPainting) then
			self.painting:SetContainerVisible(false)

			self.reloadOnResume = true
		end

		return
	end

	return
end

function MainPaintingView:OnChatStateChange(arg_14_1)
	if not arg_14_1 then
		self.painting:StopChatAnimtion()
	end

	return
end

function MainPaintingView:OnStopVoice()
	if self.painting then
		self.painting:OnStopVoice()
	end

	return
end

function MainPaintingView:IsLive2DState()
	return MainPaintingView.STATE_L2D == self.state
end

function MainPaintingView:IsLoading()
	if self.painting and self.painting:IsLoading() then
		return true
	end

	return false
end

function MainPaintingView:Init(arg_18_1, arg_18_2, arg_18_3)
	if self:ShouldReLoad(arg_18_1) then
		self:Reload(arg_18_1)
	else
		self.painting:Resume()
	end

	self.shift = arg_18_2 or self.shift

	assert(self.shift)

	if arg_18_3 then
		self:AdjustPositionWithAnim(arg_18_1)
	else
		self:AdjustPosition(arg_18_1)
	end

	self.painting:SetShift(self.shift)

	return
end

function MainPaintingView:Reload(arg_19_1)
	self.ship = arg_19_1

	local var_19_0, var_19_1 = MainPaintingView.GetAssistantStatus(arg_19_1)

	if self.painting then
		self.painting:Unload()
	end

	self.paintings[var_19_0]:Load(arg_19_1)

	self.painting = self.paintings[var_19_0]
	self.state = var_19_0
	self.bgToggle = PlayerPrefs.GetInt("paint_hide_other_obj_" .. self.painting.paintingName, 0)
	self.skinId = arg_19_1:getSkinId()

	return
end

function MainPaintingView:Refresh(arg_20_1, arg_20_2)
	self:Init(arg_20_1, arg_20_2)

	return
end

function MainPaintingView:ShouldReLoad(arg_21_1)
	if not self.painting or not self.ship or not self.state or not self.bgToggle then
		return true
	end

	if self.skinId == self.ship:getSkinId() and arg_21_1.id == self.ship.id and self.state == MainPaintingView.GetAssistantStatus(arg_21_1) and self.bgToggle == PlayerPrefs.GetInt("paint_hide_other_obj_" .. self.painting.paintingName, 0) and arg_21_1:GetRecordPosKey() == self.ship:GetRecordPosKey() and not self.reloadOnResume then
		return false
	else
		if self.reloadOnResume then
			self.reloadOnResume = false
		end

		return true
	end

	return
end

function MainPaintingView:SetOnceLoadedCall(arg_22_1)
	self.painting:SetOnceLoadedCall(arg_22_1)

	return
end

function MainPaintingView:PlayChangeSkinActionIn(arg_23_1)
	self.painting:PlayChangeSkinActionIn(arg_23_1)

	return
end

function MainPaintingView:PlayChangeSkinActionOut(arg_24_1)
	self.painting:PlayChangeSkinActionOut(arg_24_1)

	return
end

function MainPaintingView:Disable()
	if self.painting then
		self.painting:Pause()
	end

	return
end

function MainPaintingView:AdjustPositionWithAnim(arg_26_1)
	LeanTween.cancel(go(self._tf))
	LeanTween.cancel(go(self._bgTf))

	local var_26_0 = self:GetPositionAndScale(arg_26_1)

	LeanTween.moveLocal(go(self._tf), var_26_0, 0.3):setEase(LeanTweenType.easeInOutExpo)
	LeanTween.moveLocal(go(self._bgTf), var_26_0, 0.3):setEase(LeanTweenType.easeInOutExpo)

	local var_26_1, var_26_2 = self.shift:GetSpineShift()

	LeanTween.moveLocal(go(self.spineContainer), var_26_1, 0.3):setEase(LeanTweenType.easeInOutExpo)

	local var_26_3, var_26_4 = self.shift:GetL2dShift()

	if self.painting:IslimitYPos() then
		var_26_3.y = self.painting:GetHalfBodyOffsetY()
	end

	LeanTween.moveLocal(go(self.l2dContainer), var_26_3, 0.3):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
		self:AdjustPosition(arg_26_1)

		return
	end))

	return
end

function MainPaintingView:AdjustPosition(arg_28_1)
	local var_28_0, var_28_1 = self:GetPositionAndScale(arg_28_1)

	self._tf.anchoredPosition = var_28_0
	self._bgTf.anchoredPosition = var_28_0

	local var_28_2, var_28_3 = self.shift:GetL2dShift()

	if self.painting:IslimitYPos() then
		var_28_2.y = self.painting:GetHalfBodyOffsetY()
	end

	self.l2dContainer.anchoredPosition = var_28_2

	local var_28_4, var_28_5 = self.shift:GetSpineShift()

	self.spineContainer.anchoredPosition = var_28_4

	local var_28_6, var_28_7, var_28_8 = getProxy(SettingsProxy):getSkinPosSetting(arg_28_1)

	if var_28_8 then
		self._bgTf.localScale = Vector3(var_28_8, var_28_8, 1)
		self._tf.localScale = Vector3(var_28_8, var_28_8, 1)
	elseif self.state == MainPaintingView.STATE_L2D then
		self._bgTf.localScale = var_28_3
		self._tf.localScale = var_28_3
	elseif self.state == MainPaintingView.STATE_SPINE_PAINTING then
		self._bgTf.localScale = var_28_5
		self._tf.localScale = var_28_5
	else
		self._bgTf.localScale = var_28_1
		self._tf.localScale = var_28_1
	end

	return
end

function MainPaintingView:GetPositionAndScale(arg_29_1)
	local var_29_0, var_29_1, var_29_2 = getProxy(SettingsProxy):getSkinPosSetting(arg_29_1)
	local var_29_3 = Vector3(0, 0, 0)
	local var_29_4 = Vector3(1, 1, 1)

	if var_29_0 then
		var_29_3 = Vector3(var_29_0, var_29_1, 0)
		var_29_4 = Vector3(var_29_2, var_29_2, 1)
	else
		local var_29_5, var_29_6 = self.shift:GetMeshImageShift()

		var_29_3 = var_29_5
		var_29_4 = var_29_6
	end

	return var_29_3, var_29_4
end

function MainPaintingView:GetAssistantStatus()
	local var_30_0 = self:getPainting()
	local var_30_1 = getProxy(SettingsProxy)
	local var_30_2 = HXSet.autoHxShiftPath("live2d/" .. var_30_0)
	local var_30_3 = MainPaintingView.Live2dIsDownload(var_30_2) and checkABExist(var_30_2)
	local var_30_4 = var_30_1:getCharacterSetting(self.id, SHIP_FLAG_BG)

	if var_30_1:getCharacterSetting(self.id, SHIP_FLAG_L2D) and var_30_3 then
		return (isa(self, VirtualEducateCharShip) or nil) and (MainPaintingView.STATE_EDUCATE_L2D or MainPaintingView.STATE_L2D), var_30_4
	elseif var_30_1:getCharacterSetting(self.id, SHIP_FLAG_SP) and checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. var_30_0))) then
		return (isa(self, VirtualEducateCharShip) or nil) and (MainPaintingView.STATE_EDUCATE_SPINE or MainPaintingView.STATE_SPINE_PAINTING), var_30_4
	else
		return (isa(self, VirtualEducateCharShip) or nil) and (MainPaintingView.STATE_EDUCATE_CHAR or MainPaintingView.STATE_PAINTING), var_30_4
	end

	return
end

function MainPaintingView:OnBoundChange()
	if self.painting then
		self.painting:UpdateBound()
	end

	return
end

function MainPaintingView:Live2dIsDownload()
	local var_32_0 = GroupHelper.GetGroupMgrByName("L2D"):CheckF(self)

	return var_32_0 == DownloadState.None or var_32_0 == DownloadState.UpdateSuccess
end

function MainPaintingView:Fold(arg_33_1, arg_33_2)
	LeanTween.cancel(self._tf.gameObject)
	LeanTween.cancel(self._bgTf.gameObject)

	if arg_33_1 and not self.silentFlag then
		local var_33_0 = Vector3(0 - self.painting:GetOffset(), self.shift:GetMeshImageShift().y, 0)

		LeanTween.moveLocal(self._tf.gameObject, var_33_0, arg_33_2):setEase(LeanTweenType.easeInOutExpo)
		LeanTween.moveLocal(self._bgTf.gameObject, var_33_0 - (self._tf.localPosition - self._bgTf.localPosition), arg_33_2):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
			self.painting:Fold(arg_33_1, arg_33_2)

			return
		end))
	elseif self.ship then
		local var_33_1 = self:GetPositionAndScale(self.ship)

		LeanTween.moveLocal(self._tf.gameObject, var_33_1, arg_33_2):setEase(LeanTweenType.easeInOutExpo)
		LeanTween.moveLocal(self._bgTf.gameObject, var_33_1, arg_33_2):setEase(LeanTweenType.easeInOutExpo):setOnComplete(System.Action(function()
			if self.exited then
				return
			end

			self.painting:Fold(arg_33_1, arg_33_2)

			return
		end))
	end

	return
end

function MainPaintingView:EnableOrDisableScale(arg_36_1)
	self.painting:EnableOrDisableMove(arg_36_1)
	self.painting:OnEnablePartScale(arg_36_1)

	return
end

function MainPaintingView:EnableOrDisableMove(arg_37_1)
	self.painting:EnableOrDisableMove(arg_37_1)

	if arg_37_1 then
		self:EnableDragAndZoom()
	else
		self:DisableDragAndZoom()
	end

	return
end

function MainPaintingView:OnAsmrTurnning(arg_38_1)
	self.painting:OnAsmrTurnning(arg_38_1)

	return
end

function MainPaintingView:EnableDragAndZoom()
	self.isEnableDrag = true

	local var_39_0 = self._tf.parent.gameObject
	local var_39_1 = GetOrAddComponent(self._tf.parent.gameObject, typeof(PinchZoom))
	local var_39_2 = GetOrAddComponent(self._tf.parent.gameObject, typeof(EventTriggerListener))
	local var_39_3 = Vector3(0, 0, 0)

	var_39_2:AddBeginDragFunc(function(arg_40_0, arg_40_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_39_1.processing then
			return
		end

		setButtonEnabled(var_39_0, false)

		if Input.touchCount > 1 then
			return
		end

		var_39_3 = self._tf.localPosition - MainPaintingView.Screen2Local(var_39_0.transform.parent, arg_40_1.position)

		return
	end)
	var_39_2:AddDragFunc(function(arg_41_0, arg_41_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_39_1.processing then
			return
		end

		if Input.touchCount > 1 then
			return
		end

		local var_41_0 = MainPaintingView.Screen2Local(var_39_0.transform.parent, arg_41_1.position)

		self._tf.localPosition = self.painting:IslimitYPos() and Vector3(var_41_0.x, self._tf.localPosition.y, 0) + Vector3(var_39_3.x, 0, 0) or Vector3(var_41_0.x, var_41_0.y, 0) + var_39_3
		self._bgTf.localPosition = self.bgOffset + self._tf.localPosition

		return
	end)
	var_39_2:AddDragEndFunc(function()
		setButtonEnabled(var_39_0, true)

		return
	end)

	if not self.painting:IslimitYPos() then
		var_39_1.enabled = true
	end

	var_39_2.enabled = true
	Input.multiTouchEnabled = true
	self.cg.blocksRaycasts = false

	self:AdjustPosition(self.ship)

	return
end

function MainPaintingView:DisableDragAndZoom()
	if self.isEnableDrag then
		local var_43_0 = self._tf.parent:GetComponent(typeof(EventTriggerListener))

		ClearEventTrigger(var_43_0)

		var_43_0.enabled = false
		self._tf.parent:GetComponent(typeof(PinchZoom)).enabled = false
		self.cg.blocksRaycasts = true
		self.isEnableDrag = false
	end

	self:AdjustPosition(self.ship)

	return
end

function MainPaintingView:Dispose()
	MainPaintingView.super.Dispose(self)
	self:DisableDragAndZoom()

	if self.painting then
		self.painting:Unload()
	end

	self.painting = nil

	for iter_44_0, iter_44_1 in ipairs(self.paintings) do
		iter_44_1:Dispose()
	end

	self.paintings = nil

	return
end

function MainPaintingView:Screen2Local(arg_45_1)
	local var_45_0 = GameObject.Find("UICamera")

	return Vector3(var_45_0.x, LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_45_1, (var_45_0:GetComponent("Camera"))).y, 0)
end

return MainPaintingView
