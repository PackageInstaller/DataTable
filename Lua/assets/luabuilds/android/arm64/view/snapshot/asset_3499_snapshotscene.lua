local SnapshotScene = class("SnapshotScene", import("..base.BaseUI"))

SnapshotScene.SELECT_CHAR_PANEL = "SnapshotScene.SELECT_CHAR_PANEL"
SnapshotScene.SHARE_PANEL = "SnapshotScene.SHARE_PANEL"
SnapshotScene.SHOW_PAINT = 0
SnapshotScene.SHOW_LIVE2D = 1
SnapshotScene.SHOW_SPINE = 2
SnapshotScene.STATE_TAKE_PHOTO = 0
SnapshotScene.STATE_TAKE_VIDEO = 1

function SnapshotScene:getUIName()
	return "snapshot"
end

function SnapshotScene:init()
	setActive(pg.UIMgr.GetInstance().OverlayEffect, false)

	self.dummy = self._tf:Find("SnapshotInvisible")

	self:SetDummyForIOS(true)

	self.ui = self._tf:Find("ui")
	self.backBtn = self._tf:Find("ui/back")
	self.switchDirBtn = self._tf:Find("ui/switchDir")
	self.takeBtn = self._tf:Find("ui/bg/take")
	self.videoTakeImg = self._tf:Find("ui/bg/take/videoTakeImg")

	SetActive(self.videoTakeImg, false)

	self.switchCamBtn = self._tf:Find("ui/bg/switchCam")
	self.selectCharBtn = self._tf:Find("ui/bg/selectChar")
	self.l2dCtrlPanl = self._tf:Find("ui/bg/l2dBgImg")
	self.l2dStopBtnGo = self._tf:Find("ui/bg/l2dBgImg/stopBtn")
	self.l2dPlayBtnGo = self._tf:Find("ui/bg/l2dBgImg/playBtn")

	SetActive(self.l2dPlayBtnGo, false)

	self.l2dAnimationBtnGo = self._tf:Find("ui/bg/l2dBgImg/animationsBtn").gameObject
	self.l2dAnimations = self._tf:Find("ui/bg/animationsBg")
	self.l2dAnimationBackBtnTrans = self.l2dAnimations:Find("animationsBackBtn")

	SetActive(self.l2dAnimations, false)

	self.selectedID = 1
	self.scrollItems = {}
	self.isPause = false
	self.animTpl = self.l2dAnimations:Find("animation_tpl")

	SetActive(self.animTpl, false)

	self.animLayout = self.l2dAnimations:Find("animation_container/animations")
	self.animContainer = self.l2dAnimations:Find("animation_container"):GetComponent("LScrollRect")
	self.animContainer.decelerationRate = 0.1

	function self.animContainer.onInitItem(arg_3_0)
		self:onInitItem(arg_3_0)

		return
	end

	function self.animContainer.onUpdateItem(arg_4_0, arg_4_1)
		self:onUpdateItem(arg_4_0, arg_4_1)

		return
	end

	function self.animContainer.onReturnItem(arg_5_0, arg_5_1)
		self:onReturnItem(arg_5_0, arg_5_1)

		return
	end

	function self.animContainer.onStart()
		self:updateSelectedItem()

		return
	end

	self.paintBtn = self._tf:Find("ui/bg/paintBtn")
	self.live2dBtn = self._tf:Find("ui/bg/l2dBgImg/live2dBtn")
	self.spineBtn = self._tf:Find("ui/bg/spineBtn")
	self.modePnlTF = self._tf:Find("ui/bg/modePnl")
	self.takePhotoBtn = self._tf:Find("ui/bg/modePnl/takePhotoBtn")
	self.takeVideoBtn = self._tf:Find("ui/bg/modePnl/takeVideoBtn")
	self.stopRecBtn = self._tf:Find("stopRec")
	self.snapshot = self._tf:Find("snapshot")
	self.webcam = self.snapshot:GetComponent(typeof(WebCam))
	self.ysScreenShoter = self.snapshot:GetComponent(typeof(YSTool.YSScreenShoter))
	self.paint = self._tf:Find("container/paint")
	self.live2d = self.paint:Find("live2d")
	self.spine = self.paint:Find("spine")
	self.paintSkin = nil
	self.showLive2d = false
	self.showType = SnapshotScene.SHOW_PAINT
	self.state = SnapshotScene.STATE_TAKE_PHOTO

	self:setSkinAndLive2d(self.contextData.skinId, self.contextData.live2d)

	self.verticalEulerAngle = 90
	self.horizontalEulerAngle = 0
	self.rotateUseTime = 0.2
	self.isVertical = false
	self.backBtnImg = self._tf:Find("ui/back/Image")
	self.selectCharBtnImg = self._tf:Find("ui/bg/selectChar/Image")
	self.switchCamBtnImg = self._tf:Find("ui/bg/switchCam/Image")
	self.l2dBtnImg = self._tf:Find("ui/bg/paintBtn/Image")
	self.l2dStopBtnImg = self._tf:Find("ui/bg/l2dBgImg/stopBtn/Image")
	self.l2dPlayBtnImg = self._tf:Find("ui/bg/l2dBgImg/playBtn/Image")
	self.l2d2PaintBtnImg = self._tf:Find("ui/bg/l2dBgImg/live2dBtn/Image")
	self.takePhotoVerticalText = self._tf:Find("ui/bg/modePnl/takePhotoBtn/verticalText")
	self.takePhotoHorizontalText = self._tf:Find("ui/bg/modePnl/takePhotoBtn/horizontalText")
	self.takePhotoVerticalText:GetComponent("Text").text = i18n("word_photo_mode")
	self.takePhotoHorizontalText:GetComponent("Text").text = i18n("word_photo_mode")

	SetActive(self.takePhotoHorizontalText, false)

	self.takeVideoVerticalText = self._tf:Find("ui/bg/modePnl/takeVideoBtn/verticalText")
	self.takeVideoHorizontalText = self._tf:Find("ui/bg/modePnl/takeVideoBtn/horizontalText")
	self.takeVideoVerticalText:GetComponent("Text").text = i18n("word_video_mode")
	self.takeVideoHorizontalText:GetComponent("Text").text = i18n("word_video_mode")

	SetActive(self.takeVideoHorizontalText, false)

	self.isFlipping = false
	self.videoTipPanel = self._tf:Find("videoTipPanel")

	setActive(self.videoTipPanel, false)

	return
end

function SnapshotScene:back()
	if self.exited then
		return
	end

	self:emit(SnapshotScene.ON_BACK)

	return
end

function SnapshotScene:saveVideo()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("word_save_video"),
		onYes = function()
			YARecorder.Inst:DiscardVideo()

			return
		end
	})

	return
end

function SnapshotScene:didEnter()
	onButton(self, self.backBtn, function()
		self:back()

		return
	end)
	onButton(self, self.switchDirBtn, function()
		self.isVertical = not self.isVertical

		self:updateUIDirection()
		self:updateCameraCanvas()

		return
	end)
	onButton(self, self.takeBtn, function()
		if self.state == SnapshotScene.STATE_TAKE_PHOTO then
			setActive(self.ui, false)
			self.ysScreenShoter:TakeScreenShotData(function(arg_14_0)
				warning("截图结果：" .. tostring(arg_14_0))
				setActive(self.ui, true)

				return
			end, function(arg_15_0)
				local var_15_0 = UnityEngine.Texture2D.New(Screen.width, Screen.height)

				Tex2DExtension.LoadImage(var_15_0, arg_15_0)
				self:emit(SnapshotScene.SHARE_PANEL, var_15_0, arg_15_0)

				return
			end)
		elseif self.state == SnapshotScene.STATE_TAKE_VIDEO then
			setActive(self.ui, false)

			local function var_13_0(arg_16_0)
				if not arg_16_0 then
					setActive(self.ui, true)
					LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15)
				end

				return
			end

			local function var_13_1()
				setActive(self.stopRecBtn, true)
				LeanTween.moveX(self.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					self:SetMute(true)

					self.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_13_0, self.recordFilePath)

					return
				end))

				return
			end

			local var_13_2 = PlayerPrefs.GetInt("hadShowForVideoTip")

			if not var_13_2 or var_13_2 <= 0 then
				PlayerPrefs.SetInt("hadShowForVideoTip", 1)

				self.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

				onButton(self, self.videoTipPanel, function()
					setActive(self.videoTipPanel, false)
					var_13_1()

					return
				end)
				setActive(self.videoTipPanel, true)
			else
				var_13_1()
			end
		end

		return
	end)
	onButton(self, self.paintBtn, function()
		if self.showType == SnapshotScene.SHOW_PAINT then
			self:clearSkin()

			self.showType = SnapshotScene.SHOW_LIVE2D

			self:updateShowType()
			self:updateSkin()
			self:ResetL2dPanel()
		end

		return
	end)
	onButton(self, self.live2dBtn, function()
		if self.showType == SnapshotScene.SHOW_LIVE2D then
			self:clearSkin()

			self.showType = SnapshotScene.SHOW_PAINT

			self:updateShowType()
			self:updateSkin()
		end

		return
	end)
	onButton(self, self.spineBtn, function()
		if self.showType == SnapshotScene.SHOW_SPINE then
			self:clearSkin()

			self.showType = SnapshotScene.SHOW_PAINT

			self:updateShowType()
			self:updateSkin()
		end

		return
	end)

	local function var_10_0()
		if self.state == SnapshotScene.STATE_TAKE_PHOTO then
			return
		end

		self.state = SnapshotScene.STATE_TAKE_PHOTO

		LeanTween.moveY(rtf(self.modePnlTF), 56, 0.1)
		SetActive(self.videoTakeImg, false)

		return
	end

	onButton(self, self.takePhotoBtn, var_10_0)
	onButton(self, self.takeVideoBtn, function()
		if CheckPermissionGranted(ANDROID_RECORD_AUDIO_PERMISSION) and CheckPermissionGranted(ANDROID_WRITE_EXTERNAL_PERMISSION) then
			self:changeToTakeVideo()
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("apply_permission_record_audio_tip1"),
				onYes = function()
					ApplyPermission({
						ANDROID_RECORD_AUDIO_PERMISSION,
						ANDROID_WRITE_EXTERNAL_PERMISSION
					})

					return
				end
			})
		end

		return
	end)
	var_10_0()
	onButton(self, self.stopRecBtn, function()
		local function var_26_0(arg_27_0)
			if arg_27_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(self.recordFilePath) then
							System.IO.File.Delete(self.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(self.recordFilePath, function(arg_30_0, arg_30_1)
							if arg_30_0 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))

								if System.IO.File.Exists(self.recordFilePath) then
									System.IO.File.Delete(self.recordFilePath)
								end
							end

							return
						end)

						return
					end
				})
			end

			return
		end

		if not LeanTween.isTweening(go(self.stopRecBtn)) then
			LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(self.ui, true)
				setActive(self.stopRecBtn, false)
				YSNormalTool.RecordTool.StopRecording(var_26_0)
				self:SetMute(false)

				return
			end))
		end

		return
	end)
	setActive(self.stopRecBtn, false)
	onButton(self, self.switchCamBtn, function()
		self.isFlipping = not self.isFlipping

		self.webcam:SwitchCam()
		self:updateCameraCanvas()

		return
	end)
	onButton(self, self.selectCharBtn, function()
		self:emit(SnapshotScene.SELECT_CHAR_PANEL)

		return
	end)

	function self.webcam.takeCallback(arg_34_0)
		setActive(self.ui, true)

		return
	end

	onButton(self, self.l2dStopBtnGo, function()
		self.isPause = true

		self:UpdateL2dPlayState()

		return
	end)
	onButton(self, self.l2dPlayBtnGo, function()
		self.isPause = false

		self:UpdateL2dPlayState()

		return
	end)
	onButton(self, self.l2dAnimationBtnGo, function()
		self:setLive2dAnimsPanelState(true)

		return
	end)
	onButton(self, self.l2dAnimationBackBtnTrans, function()
		self:setLive2dAnimsPanelState(false)

		return
	end)
	cameraPaintViewAdjust(true)
	self:updateCameraCanvas()
	self:updateShowType()

	return
end

function SnapshotScene:changeToTakeVideo()
	if self.state == SnapshotScene.STATE_TAKE_VIDEO then
		return
	end

	self.state = SnapshotScene.STATE_TAKE_VIDEO

	LeanTween.moveY(rtf(self.modePnlTF), -56, 0.1)
	SetActive(self.videoTakeImg, true)

	return
end

function SnapshotScene:willExit()
	self:SetDummyForIOS(false)
	cameraPaintViewAdjust(false)
	self:clearSkin()
	setActive(pg.UIMgr.GetInstance().OverlayEffect, PlayerPrefs.GetInt(SHOW_TOUCH_EFFECT, 1) > 0)

	return
end

function SnapshotScene:clearSkin()
	if self.paintSkin and self.showType == SnapshotScene.SHOW_PAINT then
		retPaintingPrefab(self.paint, self.paintSkin)
	end

	if self.spineSkin and self.showType == SnapshotScene.SHOW_SPINE and self.spineChar then
		self.spineChar:Dispose()

		self.spineChar = nil
	end

	if self.live2dCom then
		self.live2dCom.FinishAction = nil
		self.live2dCom.EventAction = nil
	end

	if self.live2dCom and self.showType == SnapshotScene.SHOW_LIVE2D then
		Destroy(self.live2dCom.gameObject)

		self.live2dCom = nil
	end

	if self.live2dRequestId then
		pg.Live2DMgr.GetInstance():StopLoadingLive2d(self.live2dRequestId)

		self.live2dRequestId = nil
	end

	return
end

function SnapshotScene:checkSkin(arg_42_1)
	local var_42_0 = pg.ship_skin_template[arg_42_1]

	assert(arg_42_1 == -1 or var_42_0, "invalid skin id " .. arg_42_1)

	self.skin = var_42_0

	local var_42_1 = false

	if self.contextData.tbId then
		self.paintSkin = pg.secretary_special_ship[self.contextData.tbId].prefab or "tbniang"
		var_42_1 = true
		self.contextData.tbId = nil
	elseif self.paintSkin ~= var_42_0.painting or var_42_0.spineSkin ~= var_42_0.prefab then
		self:clearSkin()

		self.paintSkin = var_42_0.painting
		self.spineSkin = var_42_0.prefab
		self.l2dAnims = var_42_0.l2d_animations

		if self.l2dAnims == "" then
			self.l2dAnims = {
				"idle"
			}
		end

		var_42_1 = true
	end

	return var_42_1
end

function SnapshotScene:setSkinAndLive2d(arg_43_1, arg_43_2)
	local var_43_0 = self:checkSkin(arg_43_1)

	if self.showType ~= SnapshotScene.SHOW_LIVE2D and arg_43_2 then
		self.showType = SnapshotScene.SHOW_LIVE2D

		self:updateShowType()

		var_43_0 = true
	end

	if var_43_0 then
		self:updateSkin()
	end

	return
end

function SnapshotScene:setSkin(arg_44_1)
	if self:checkSkin(arg_44_1) then
		self:updateSkin()
	end

	return
end

function SnapshotScene:setLive2d(arg_45_1)
	if self.showType ~= SnapshotScene.SHOW_LIVE2D and arg_45_1 then
		self:clearSkin()

		self.showType = SnapshotScene.SHOW_LIVE2D

		self:updateShowType()
		self:updateSkin()
	end

	return
end

function SnapshotScene:updateShowType()
	setActive(self.paintBtn, false)
	self:setLive2dAnimsPanelState(false)
	setActive(self.live2dBtn, false)
	setActive(self.l2dCtrlPanl, false)
	setActive(self.spineBtn, false)

	if self.showType == SnapshotScene.SHOW_PAINT then
		setActive(self.paintBtn, true)
	elseif self.showType == SnapshotScene.SHOW_LIVE2D then
		setActive(self.live2dBtn, true)
		SetActive(self.l2dCtrlPanl, true)
	elseif self.showType == SnapshotScene.SHOW_SPINE then
		setActive(self.spineBtn, true)
	end

	return
end

local function var_0_1(arg_47_0)
	if arg_47_0 == SnapshotScene.SHOW_PAINT then
		return 0.5, 2
	elseif arg_47_0 == SnapshotScene.SHOW_LIVE2D then
		return 0.5, 2
	elseif arg_47_0 == SnapshotScene.SHOW_SPINE then
		return 0.5, 4
	end

	return
end

function SnapshotScene:updateSkin()
	if self.showType == SnapshotScene.SHOW_LIVE2D and (not ResourceMgr.Inst:AssetExist("live2d/" .. self.paintSkin) or not checkABExist("live2d/" .. self.paintSkin)) then
		self.showType = SnapshotScene.SHOW_PAINT

		self:updateShowType()
	end

	local var_48_0 = self.paint:GetComponent(typeof(Zoom))
	local var_48_3, var_48_4 = var_0_1(self.showType)

	var_48_0.minZoom, var_48_0.maxZoom = var_48_3, var_48_4

	if var_48_4 < self.paint.localScale.x then
		self.paint.localScale = Vector3(var_48_4, var_48_4, var_48_4)
	elseif var_48_3 > self.paint.localScale.x then
		self.paint.localScale = Vector3(var_48_3, var_48_3, var_48_3)
	end

	if self.showType == SnapshotScene.SHOW_LIVE2D then
		pg.UIMgr.GetInstance():LoadingOn()

		self.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(self.paintSkin, function(arg_49_0)
			HotfixHelper.SetLayerRecursively(arg_49_0, LayerMask.NameToLayer("UI"))

			local var_49_0 = arg_49_0.transform

			arg_49_0.transform:SetParent(self.live2d, true)

			var_49_0.localScale = self.skin.live2d_offset and #self.skin.live2d_offset >= 4 and Vector3(self.skin.live2d_offset[4], self.skin.live2d_offset[4], self.skin.live2d_offset[4]) or Vector3(52, 52, 52)
			var_49_0.localPosition = Vector3(self.skin.live2d_offset[1] + 500, self.skin.live2d_offset[2], self.skin.live2d_offset[3])

			local var_49_1 = arg_49_0:GetComponent(typeof(Live2dChar))

			var_49_1:SetAction(pg.AssistantInfo.action2Id.idle)

			function var_49_1.FinishAction(arg_50_0)
				if self.selectedID and self.selectedID ~= pg.AssistantInfo.action2Id.idle then
					self:setL2dAction(self.selectedID)
				end

				return
			end

			Live2DPainting.SetL2dSortingLayer(arg_49_0, LayerWeightConst.L2D_DEFAULT_LAYER)

			self.live2dCom = var_49_1
			self.live2dCom.name = self.paintSkin
			self.playActionId = pg.AssistantInfo.action2Id.idle
			self.selectedID = pg.AssistantInfo.action2Id.idle
			self.live2dAnimator = arg_49_0:GetComponent(typeof(Animator))

			local var_49_2 = self.live2dCom:GetCubismParameter("Paramring")

			if var_49_2 then
				if self.contextData and self.contextData.propose then
					self.live2dCom:AddParameterValue(var_49_2, 1, CubismParameterBlendMode.Override)
				else
					self.live2dCom:AddParameterValue(var_49_2, 0, CubismParameterBlendMode.Override)
				end
			end

			self:ResetL2dPanel()
			self:setLive2dAnimsPanelState(true)
			SetActive(self.spine, false)
			SetActive(self.live2d, true)
			pg.UIMgr.GetInstance():LoadingOff()

			if self.skin.lip_sync_gain and self.skin.lip_sync_gain ~= 0 then
				self.live2d:GetChild(0):GetComponent("CubismCriSrcMouthInput").Gain = self.skin.lip_sync_gain
			end

			if self.skin.lip_smoothing and self.skin.lip_smoothing ~= 0 then
				self.live2d:GetChild(0):GetComponent("CubismCriSrcMouthInput").Smoothing = self.skin.lip_smoothing
			end

			return
		end)
	elseif self.showType == SnapshotScene.SHOW_PAINT then
		SetActive(self.live2d, false)
		SetActive(self.spine, false)
		setPaintingPrefabAsync(self.paint, self.paintSkin, "mainNormal")
	elseif self.showType == SnapshotScene.SHOW_SPINE then
		SetActive(self.live2d, false)
		SetActive(self.spine, true)

		self.spineChar = SpineAnimChar.New()

		self.spineChar:SetPaint(self.spineSkin)
		self.spineChar:Load(true, function(arg_51_0)
			arg_51_0:SetName("model")
			arg_51_0:SetParent(self.spine, true)
			arg_51_0:SetLocalScale(Vector3(0.5, 0.5, 0.5))
			arg_51_0:SetLocalPosition(Vector3.zero)
			self:playAction("normal")

			return
		end)
	end

	return
end

function SnapshotScene:playAction(arg_52_1)
	if self.showType ~= SnapshotScene.SHOW_SPINE then
		return
	end

	if self.spineChar then
		self.spineChar:SetAction(arg_52_1, 0)
	end

	return
end

function SnapshotScene:ResetL2dPanel()
	self.selectedID = pg.AssistantInfo.action2Id.idle
	self.isPause = false

	self:UpdateL2dPlayState(true)
	self:updateSelectedItem()

	return
end

function SnapshotScene:UpdateL2dPlayState(arg_54_1)
	if self.showType ~= SnapshotScene.SHOW_LIVE2D then
		return
	end

	if self.isPause then
		SetActive(self.l2dStopBtnGo, false)
		SetActive(self.l2dPlayBtnGo, true)
	else
		SetActive(self.l2dStopBtnGo, true)
		SetActive(self.l2dPlayBtnGo, false)
	end

	if not arg_54_1 then
		self:L2dAnimationState()
	end

	return
end

function SnapshotScene:L2dAnimationState()
	if self.showType ~= SnapshotScene.SHOW_LIVE2D then
		return
	end

	self.live2dAnimator.speed = self.isPause and 0 or 1

	return
end

function SnapshotScene:updateLive2dAnimationPanel()
	SetActive(self.l2dAnimations, self.isShowL2dAnims)
	SetActive(self.l2dAnimationBtnGo, not self.isShowL2dAnims)

	if self.isShowL2dAnims and #self.l2dAnims > 1 then
		self.animContainer:SetTotalCount(#self.l2dAnims, 0)
	end

	return
end

function SnapshotScene:setLive2dAnimsPanelState(arg_57_1)
	self.isShowL2dAnims = arg_57_1

	self:updateLive2dAnimationPanel()

	return
end

local var_0_2 = 3

function SnapshotScene:onInitItem(arg_58_1)
	local var_58_0 = SnapshotItem.New(arg_58_1, false)

	onButton(self, var_58_0.go, function()
		if self.l2dClickCD and Time.fixedTime - self.l2dClickCD < var_0_2 then
			return
		end

		if self.selectedID == var_58_0:GetID() then
			return
		end

		if var_58_0:GetID() == 6 or var_58_0:GetID() == 7 then
			self.l2dClickCD = Time.fixedTime
		end

		self.selectedID = var_58_0:GetID()

		self:updateSelectedItem()
		self:setL2dAction(self.selectedID)

		return
	end, SFX_CONFIRM)

	self.scrollItems[arg_58_1] = var_58_0

	return
end

function SnapshotScene:setL2dAction(arg_60_1)
	if arg_60_1 ~= pg.AssistantInfo.action2Id.idle then
		-- block empty
	end

	if self.live2dCom and arg_60_1 then
		if arg_60_1 == pg.AssistantInfo.action2Id.idle then
			self.live2dCom:SetAction(arg_60_1)
		elseif self.playActionId == pg.AssistantInfo.action2Id.idle then
			self.live2dCom:SetAction(arg_60_1)
		elseif self.playActionId == arg_60_1 then
			self.live2dCom:SetAction(arg_60_1)
		end

		self.playActionId = arg_60_1
	end

	return
end

function SnapshotScene:onUpdateItem(arg_61_1, arg_61_2)
	arg_61_1 = arg_61_1 + 1

	local var_61_0 = self.scrollItems[arg_61_2]
	local var_61_1

	if not self.scrollItems[arg_61_2] then
		self:onInitItem(arg_61_2)

		var_61_0 = self.scrollItems[arg_61_2]
		var_61_1 = {
			id = pg.AssistantInfo.action2Id[self.l2dAnims[arg_61_1]]
		}
	end

	var_61_1.name = i18n(self.l2dAnims[arg_61_1])

	var_61_0:Update(var_61_1)

	if self.isVertical then
		var_61_0:SetEulerAngle(self.verticalEulerAngle)
	else
		var_61_0:SetEulerAngle(self.horizontalEulerAngle)
	end

	if var_61_0:GetID() == self.selectedID then
		var_61_0:UpdateSelected(true)
	else
		var_61_0:UpdateSelected(false)
	end

	return
end

function SnapshotScene:onReturnItem(arg_62_1, arg_62_2)
	return
end

function SnapshotScene:updateSelectedItem()
	for iter_63_0, iter_63_1 in pairs(self.scrollItems) do
		if iter_63_1:HasInfo() then
			if iter_63_1:GetID() == self.selectedID then
				iter_63_1:UpdateSelected(true)
			else
				iter_63_1:UpdateSelected(false)
			end
		end
	end

	return
end

function SnapshotScene:updateUIDirection()
	if self.isVertical then
		LeanTween.rotateZ(go(self.backBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.selectCharBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.switchCamBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dStopBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dPlayBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2d2PaintBtnImg), self.verticalEulerAngle, self.rotateUseTime)
		SetActive(self.takePhotoVerticalText, false)
		SetActive(self.takePhotoHorizontalText, true)
		SetActive(self.takeVideoVerticalText, false)
		SetActive(self.takeVideoHorizontalText, true)
		LeanTween.rotateZ(go(self.paint), self.verticalEulerAngle, self.rotateUseTime)
		self:updateListItemRotate(self.verticalEulerAngle, self.rotateUseTime)
	else
		local var_64_0 = self.horizontalEulerAngle

		LeanTween.rotateZ(go(self.backBtnImg), self.horizontalEulerAngle, self.rotateUseTime)
		LeanTween.rotateZ(go(self.selectCharBtnImg), var_64_0, self.rotateUseTime)
		LeanTween.rotateZ(go(self.switchCamBtnImg), var_64_0, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dBtnImg), var_64_0, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dStopBtnImg), var_64_0, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2dPlayBtnImg), var_64_0, self.rotateUseTime)
		LeanTween.rotateZ(go(self.l2d2PaintBtnImg), var_64_0, self.rotateUseTime)
		SetActive(self.takePhotoVerticalText, true)
		SetActive(self.takePhotoHorizontalText, false)
		SetActive(self.takeVideoVerticalText, true)
		SetActive(self.takeVideoHorizontalText, false)
		LeanTween.rotateZ(go(self.paint), var_64_0, self.rotateUseTime)
		self:updateListItemRotate(var_64_0, self.rotateUseTime)
	end

	return
end

function SnapshotScene:updateListItemRotate(arg_65_1, arg_65_2)
	for iter_65_0, iter_65_1 in pairs(self.scrollItems) do
		iter_65_1:RotateUI(arg_65_1, arg_65_2)
	end

	return
end

function SnapshotScene:updateCameraCanvas()
	local var_66_0 = pg.CameraFixMgr.GetInstance().targetRatio
	local var_66_1 = 1

	if UnityEngine.Screen.width / UnityEngine.Screen.height < var_66_0 then
		var_66_1 = var_66_0 / (UnityEngine.Screen.width / UnityEngine.Screen.height)
	elseif var_66_0 < UnityEngine.Screen.width / UnityEngine.Screen.height then
		var_66_1 = UnityEngine.Screen.width / UnityEngine.Screen.height / var_66_0
	end

	self.snapshot.localScale = self.isFlipping and Vector3(-var_66_1, var_66_1, 1) or Vector3(var_66_1, var_66_1, 1)

	return
end

function SnapshotScene:SetDummyForIOS(arg_67_1)
	if PLATFORM ~= PLATFORM_IPHONEPLAYER then
		setActive(self.dummy, false)

		return
	end

	local var_67_0 = pg.UIMgr.GetInstance():GetMainCamera():GetComponent(typeof(Camera))

	if arg_67_1 then
		var_67_0.nearClipPlane = 0

		self.dummy:SetParent(pg.UIMgr.GetInstance():GetMainCamera().transform)

		self.dummy.localPosition = Vector3(0, 0, 3)
		self.dummy.localRotation = Vector3(0, 0, 0)
		self.dummy.localScale = Vector3(1, 1, 1)

		setActive(self.dummy, true)
	else
		var_67_0.nearClipPlane = -100

		self.dummy:SetParent(self._tf)

		self.dummy.localPosition = Vector3(0, 0, 0)
		self.dummy.localRotation = Vector3(0, 0, 0)
		self.dummy.localScale = Vector3(1, 1, 1)
	end

	return
end

function SnapshotScene:SetMute(arg_68_1)
	if arg_68_1 then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

return SnapshotScene
