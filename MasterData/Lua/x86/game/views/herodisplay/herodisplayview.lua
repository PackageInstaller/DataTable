local HeroDisplayView = class("HeroDisplayView", ReduxView)

function HeroDisplayView:UIName()
	return "Widget/System/Hero/HeroDisplayUI"
end

function HeroDisplayView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroDisplayView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.weaponController_ = ControllerUtil.GetController(self.transformWeapon_, "weaponState")
	self.scaleController_ = ControllerUtil.GetController(self.buttonScale_.transform, "select")
	self.touchView_ = TouchView.New()
	self.settingView_ = HeroDisplaySettingView.New(self.goSettingPanel_)
	self.snapView_ = HeroDisplaySnapView.New(self.goSnapPanel_)
	self.shareView_ = HeroDisplayShareView.New(self.goSharePanel_)
	self.expressionView_ = HeroDisplayExpressionView.New(self.goHeroExpressionPanel_)
	self.heroPoseView_ = HeroDisplayPoseView.New(self.goSelectPose_)
	self.clickHandler_ = handler(self, self.ClickTrigger)
	self.heroPoseSelectHandler_ = handler(self, self.HeroPoseSelect)
	self.scaleTable_ = GameSetting.model_scale_rate.value
	self.camera_ = manager.ui.mainCameraCom_
	self.rotateHandler_ = handler(self, self.RotateModel)
	self.upDownHandler_ = handler(self, self.UpDownModel)
	self.scaleHandler_ = handler(self, self.ScaleModel)
end

function HeroDisplayView:OnEnter()
	self:ScreenAdapt()

	self.scaleIndex_ = 0
	self.scaleText_.text = GetI18NText(self.scaleTable_[self.scaleIndex_ + 1][1])

	self.scaleController_:SetSelectedState("false")
	manager.ui:SetMainCamera("heroDisplay")

	if not GameToSDK.IsEditorOrPcPlatform() then
		ScreenRotationAction.RotateToPortrait(function()
			return
		end)
	end

	self.isFirstShowTips_ = true
	self.heroID_ = self.params_.heroID
	self.skinID_ = HeroTools.HeroUsingSkinInfo(self.heroID_).id

	local var_4_0 = OperationData:IsOperationOpen(OperationConst.SHARE_FLAG)

	SetActive(self.buttonSnap_.gameObject, var_4_0)
	SetActive(self.buttonSetting_.gameObject, var_4_0)
	self:LoadModel()

	self.isShowPosePanel_ = false

	SetActive(self.goSelectPose_, self.isShowPosePanel_)
	SetActive(self.goSelect_, self.isShowPosePanel_)
	self.touchView_:OnEnter()
	self.expressionView_:OnEnter(self.heroID_)
	self.heroPoseView_:OnEnter(self.heroID_)
	self.shareView_:OnEnter()
	self:HeroPoseSelect(1)
	manager.notify:RegistListener(HERO_POSE_SELECT, self.heroPoseSelectHandler_)
	manager.notify:RegistListener(CLICK_TRIGGER, self.clickHandler_)
	manager.notify:RegistListener(TOUCH_HORIZONTAL, self.rotateHandler_)
	manager.notify:RegistListener(TOUCH_VERTICAL, self.upDownHandler_)
	manager.notify:RegistListener(MULTI_TOUCH_SCALE, self.scaleHandler_)
end

function HeroDisplayView:OnBehind()
	self.expressionView_:OnBehind()
end

function HeroDisplayView:OnTop()
	self.expressionView_:OnTop()
end

function HeroDisplayView:OnExit()
	manager.notify:RemoveListener(HERO_POSE_SELECT, self.heroPoseSelectHandler_)
	manager.notify:RemoveListener(CLICK_TRIGGER, self.clickHandler_)
	manager.notify:RemoveListener(TOUCH_HORIZONTAL, self.rotateHandler_)
	manager.notify:RemoveListener(TOUCH_VERTICAL, self.upDownHandler_)
	manager.notify:RemoveListener(MULTI_TOUCH_SCALE, self.scaleHandler_)

	if not GameToSDK.IsEditorOrPcPlatform() then
		ScreenRotationAction.RotateToLandscape(function()
			manager.notify:Invoke(HERO_DISPLAY_EXIT)
		end)
	end

	self:ClickTrigger()
	self.touchView_:OnExit()
	self.expressionView_:OnExit()
	self.heroPoseView_:OnExit()
	self.shareView_:OnExit()
	self:UnloadModel()

	if self.hideTimer_ then
		self.hideTimer_:Stop()

		self.hideTimer_ = nil
	end
end

function HeroDisplayView:AddListeners()
	self:AddBtnListener(self.buttonBack_, nil, function()
		self.expressionView_:TryExitSaveData()
	end)
	self:AddBtnListener(self.buttonHide_, nil, function()
		SetActive(self.goUIPanel_, false)
		self:HidePosePanel()

		if self.isFirstShowTips_ then
			SetActive(self.goClickTips_, true)

			self.hideTimer_ = Timer.New(function()
				self.hideTimer_ = nil

				SetActive(self.goClickTips_, false)
			end, 2, 1)

			self.hideTimer_:Start()

			self.isFirstShowTips_ = false
		end

		self.touchView_:HideUI()
	end)
	self:AddBtnListener(self.buttonWeapon_, nil, function()
		if HeroDisplayData:GetHeroPoseList(self.heroID_)[self.poseIndex_].weaponState ~= HeroDisplayConst.WEAPON_STATE.CAN_SWITCH_WEAPON then
			ShowTips("CANNOT_SWITCH_WEAPON_STATE")

			return
		end

		self.showWeapon_ = not self.showWeapon_

		if self.showWeapon_ then
			self.weaponController_:SetSelectedState("1")
		else
			self.weaponController_:SetSelectedState("0")
		end

		HeroTools.SetHeroModelWeaponActivity(self.uiTpose_, self.showWeapon_)
	end)
	self:AddBtnListener(self.buttonPose_, nil, function()
		self:ChangePosePanelState()
	end)
	self:AddBtnListener(self.buttonSnap_, nil, function()
		if self.isShowPosePanel_ then
			self:HidePosePanel()
		end

		self:HideScalePanel()
		SetActive(self.goUIPanel_, false)
		self.snapView_:Snap(function()
			SetActive(self.goUIPanel_, true)
			self.shareView_:SetData(self.heroID_, self.showWeapon_, self.poseIndex_)

			if GameToSDK.IsEditorOrPcPlatform() then
				self.shareView_:OnSnape(true)
			else
				self.shareView_:OnSnape()
			end

			SDKTools.SendMessageToSDK("screenshot", {
				screenshot_oper = 1,
				share_channel = 0,
				hero_id = self.heroID_,
				weapon_on = (self.showWeapon_ and HeroDisplayData:GetHeroPoseList(self.heroID_)[self.poseIndex_].weaponState ~= HeroDisplayConst.WEAPON_STATE.HIDE_WEAPON or nil) and 1,
				posture_id = self.poseIndex_,
				logo_location = HeroDisplayData.settingProfile_.logoPos == 0 and 2 or HeroDisplayData.settingProfile_.logoPos,
				card_show = HeroDisplayData.settingProfile_.cardShow and 1 or 0,
				card_location = HeroDisplayData.settingProfile_.cardPos == 0 and 1 or HeroDisplayData.settingProfile_.cardPos,
				lv_show = HeroDisplayData.settingProfile_.cardShowLv and 1 or 0,
				uid_show = HeroDisplayData.settingProfile_.cardShowUID and 1 or 0
			})
		end)
	end)
	self:AddBtnListener(self.buttonExpression_, nil, function()
		self.expressionView_:OnShow(self.uiTpose_)
	end)
	self:AddBtnListener(self.buttonSetting_, nil, function()
		SetActive(self.goSettingPanel_, true)
		self.settingView_:OnEnter()
		self:HideScalePanel()
	end)
	self:AddBtnListener(self.buttonScale_, nil, function()
		self.touchView_:HideUI()
		self:HidePosePanel()
		self.scaleController_:SetSelectedState("true")

		self.scaleIndex_ = (self.scaleIndex_ + 1) % #self.scaleTable_
		self.scaleText_.text = GetI18NText(self.scaleTable_[self.scaleIndex_ + 1][1])

		local var_20_0 = LeanTween.value(self.camera_.fieldOfView, self.scaleTable_[self.scaleIndex_ + 1][2], 0.35)

		var_20_0:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
			self.camera_.fieldOfView = arg_21_0
		end))
		var_20_0:setOnComplete(System.Action(function()
			var_20_0:setOnUpdate(nil):setOnComplete(nil)
		end))
	end)
end

function HeroDisplayView:Dispose()
	HeroDisplayView.super.Dispose(self)

	self.heroPoseSelectHandler_ = nil
	self.clickHandler_ = nil

	self.touchView_:Dispose()

	self.touchView_ = nil

	self.settingView_:Dispose()

	self.settingView_ = nil

	self.snapView_:Dispose()

	self.snapView_ = nil

	self.shareView_:Dispose()

	self.shareView_ = nil

	self.expressionView_:Dispose()

	self.expressionView_ = nil

	self.heroPoseView_:Dispose()

	self.heroPoseView_ = nil
	self.rotateHandler_ = nil
	self.upDownHandler_ = nil
	self.scaleHandler_ = nil
end

function HeroDisplayView:LoadModel()
	local var_24_0 = HeroTools.HeroUsingSkinInfo(self.heroID_)

	if self.heroModel_ then
		self:DestroyCurrentModel()

		self.heroModel_ = nil
	end

	self.modelPath_ = "Char/" .. var_24_0.display_model_id
	self.heroModel_ = Asset.Instantiate(self.modelPath_)

	local var_24_1 = HeroDisplayCfg[self.skinID_] or HeroDisplayCfg[self.heroID_]
	local var_24_2 = var_24_1.position

	self.heroTransform_ = self:FindTrs(string.format("%sui", var_24_0.id), self.heroModel_.transform)
	self.heroModel_.transform.localPosition = Vector3.New(var_24_2[1], var_24_2[2], var_24_2[3])
	self.heroModel_.transform.localEulerAngles = Vector3.New(var_24_1.rotation[1], var_24_1.rotation[2], var_24_1.rotation[3])
	self.heroModel_.transform.localScale = Vector3.New(var_24_1.scale[1], var_24_1.scale[2], var_24_1.scale[3])

	local var_24_3 = self:FindTrs(var_24_0.id .. "ui", self.heroModel_.transform)

	if var_24_3 then
		var_24_3.localEulerAngles = Vector3.zero
	end

	self.uiTpose_ = self:FindTrs(string.format("%dui/%dui_tpose", var_24_0.id, var_24_0.id), self.heroModel_.transform)

	if self.uiTpose_ then
		self.animator_ = self:FindCom(typeof(Animator), "", self.uiTpose_)
	end

	if OathTools.IsOath(self.heroID_) then
		self:AttachOathRing()
	end

	self:InitHeroExpressionParams()
end

function HeroDisplayView:DestroyCurrentModel()
	if self.heroModel_ and self.modelPath_ then
		Object.DestroyImmediate(self.heroModel_)
		manager.gc:Collect()
		Resources.UnloadUnusedAssets()

		self.heroModel_ = nil
		self.modelPath_ = nil
	end
end

function HeroDisplayView:UnloadModel()
	if self.heroModel_ then
		self:DisposeVfx()
		self:DestroyCurrentModel()

		self.posterGirlId_ = nil
		self.heroTransform_ = nil
	end
end

function HeroDisplayView:AddManagedVfx(arg_27_1)
	if self.managedVfx == nil then
		self.managedVfx = {}
	end

	table.insert(self.managedVfx, arg_27_1)
end

function HeroDisplayView:DisposeVfx()
	if self.managedVfx then
		for iter_28_0, iter_28_1 in ipairs(self.managedVfx) do
			LuaForUtil.StopEffect(iter_28_1)
		end

		self.managedVfx = nil
	end
end

function HeroDisplayView:AttachOathRing()
	self:AddManagedVfx((LuaForUtil.PlayAttachEffect(LuaForUtil.GetRoleAttachPoint(self.heroTransform_, OathTools.OathRingAttachPoint), OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)))
end

function HeroDisplayView:ResetHeroExpressionParams()
	for iter_30_0, iter_30_1 in ipairs(HeroDisplayData:GetHeroExpressionParams(self.heroID_)[1].values) do
		self.skinnedMeshRenderer_:SetBlendShapeWeight(iter_30_0 - 1, iter_30_1 / 100)
	end
end

function HeroDisplayView:InitHeroExpressionParams()
	local var_31_0 = self:FindTrs("Face", self.uiTpose_.transform) and self:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "Face", self.uiTpose_.transform) or self:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), "face", self.uiTpose_.transform)

	if HeroDisplayData:GetHeroExpressionParams(self.heroID_) == nil then
		local var_31_1 = {}

		for iter_31_0, iter_31_1 in ipairs(HeroDisplayCfg[self.heroID_].skinMeshIDList) do
			table.insert(var_31_1, var_31_0:GetBlendShapeWeight(iter_31_0 - 1) * 100)
		end

		HeroDisplayAction.SetDefaultHeroExpression(self.heroID_, var_31_1)
	end

	HeroDisplayData:InitCacheExpressionParams(self.heroID_)
	HeroDisplayData:InitHeroPose(self.heroID_, self.skinID_)

	self.skinnedMeshRenderer_ = var_31_0
end

function HeroDisplayView:RotateModel(arg_32_1)
	if self.heroTransform_ == nil then
		return
	end

	self.heroTransform_:Rotate(0, arg_32_1, 0, Space.World)
end

function HeroDisplayView:UpDownModel(arg_33_1)
	local var_33_0 = manager.ui.mainCamera.transform
	local var_33_1 = arg_33_1

	if manager.ui.mainCamera.transform.position.y + arg_33_1 < GameSetting.camera_y_range.value[1] then
		var_33_1 = GameSetting.camera_y_range.value[1] - var_33_0.position.y
	elseif GameSetting.camera_y_range.value[2] < manager.ui.mainCamera.transform.position.y + arg_33_1 then
		var_33_1 = GameSetting.camera_y_range.value[2] - var_33_0.position.y
	end

	var_33_0:Translate(0, var_33_1, 0)
end

function HeroDisplayView:ScaleModel(arg_34_1)
	manager.ui.mainCameraCom_.fieldOfView = manager.ui.mainCameraCom_.fieldOfView + arg_34_1 < GameSetting.camera_field_range.value[1] and GameSetting.camera_field_range.value[1] or GameSetting.camera_field_range.value[2] < manager.ui.mainCameraCom_.fieldOfView + arg_34_1 and GameSetting.camera_field_range.value[2] or manager.ui.mainCameraCom_.fieldOfView + arg_34_1
end

function HeroDisplayView:HeroPoseSelect(arg_35_1)
	if HeroDisplayData:GetHeroPoseList(self.heroID_) == nil then
		return
	end

	if self.heroModel_ == nil then
		return
	end

	local var_35_0 = HeroDisplayData:GetHeroPoseList(self.heroID_)[arg_35_1]

	if self.uiTpose_ then
		manager.resourcePool:ResetBlendShapes(self.heroModel_)
		self.animator_:Play(HeroDisplayPoseCfg[var_35_0.id].poseName)
	end

	self.heroPoseView_:SetData(arg_35_1)

	self.poseIndex_ = arg_35_1
	self.showWeapon_ = var_35_0.weaponState ~= HeroDisplayConst.WEAPON_STATE.HIDE_WEAPON

	HeroTools.SetHeroModelWeaponActivity(self.uiTpose_, self.showWeapon_)
	self:RefreshWeaponBtn()
end

function HeroDisplayView:ClickTrigger()
	SetActive(self.goUIPanel_, true)

	if self.hideTimer_ then
		self.hideTimer_:Stop()

		self.hideTimer_ = nil
	end

	SetActive(self.goClickTips_, false)
	self:HidePosePanel()
	self:HideScalePanel()
end

function HeroDisplayView:HidePosePanel()
	self.isShowPosePanel_ = false

	self.heroPoseView_:Show(false)
	SetActive(self.goSelect_, false)
end

function HeroDisplayView:HideScalePanel()
	self.scaleController_:SetSelectedState("false")
end

function HeroDisplayView:RefreshWeaponBtn()
	if self.showWeapon_ and HeroDisplayData:GetHeroPoseList(self.heroID_)[self.poseIndex_].weaponState == HeroDisplayConst.WEAPON_STATE.CAN_SWITCH_WEAPON then
		self.weaponController_:SetSelectedState("1")
	else
		self.weaponController_:SetSelectedState("0")
	end
end

function HeroDisplayView:ScreenAdapt()
	if _G.SCREEN_WIDTH / _G.SCREEN_HEIGHT > self.ADAPT_RAITO then
		self.goUIPanel_.transform.offsetMax = Vector2(0, -1 * self.VIEW_ADAPT_DISTANCE)
	end
end

function HeroDisplayView:ChangePosePanelState()
	self.isShowPosePanel_ = not self.isShowPosePanel_

	self.heroPoseView_:Show(self.isShowPosePanel_)
	SetActive(self.goSelect_, self.isShowPosePanel_)

	if self.isShowPosePanel_ then
		self.touchView_:HideUI()
	end

	self:HideScalePanel()
end

function HeroDisplayView:CheckNeedBackToPanel()
	local var_42_0 = false

	if self.goClickTips_.activeInHierarchy then
		self:ClickTrigger()

		var_42_0 = true
	end

	if self.goSettingPanel_.activeInHierarchy then
		SetActive(self.goSettingPanel_, false)

		var_42_0 = true
	end

	if self.goSharePanel_.activeInHierarchy then
		self.shareView_:ExitPanel()

		var_42_0 = true
	end

	if self.goSelectPose_.activeInHierarchy then
		self:ChangePosePanelState()

		var_42_0 = true
	end

	return var_42_0
end

function HeroDisplayView:OnExitInput()
	if not self:CheckNeedBackToPanel() then
		self.expressionView_:TryExitSaveData()
	end

	return true
end

function HeroDisplayView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
end

return HeroDisplayView
