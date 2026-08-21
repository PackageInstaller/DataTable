local var_0_0 = class("SnapshotScene", import("..base.BaseUI"))

var_0_0.SELECT_CHAR_PANEL = "SnapshotScene.SELECT_CHAR_PANEL"
var_0_0.SHARE_PANEL = "SnapshotScene.SHARE_PANEL"
var_0_0.SHOW_PAINT = 0
var_0_0.SHOW_LIVE2D = 1
var_0_0.SHOW_SPINE = 2
var_0_0.STATE_TAKE_PHOTO = 0
var_0_0.STATE_TAKE_VIDEO = 1

function var_0_0.getUIName(arg_1_0)
	return "snapshot"
end

function var_0_0.init(arg_2_0)
	setActive(pg.UIMgr.GetInstance().OverlayEffect, false)

	arg_2_0.dummy = arg_2_0._tf:Find("SnapshotInvisible")

	arg_2_0:SetDummyForIOS(true)

	arg_2_0.ui = arg_2_0._tf:Find("ui")
	arg_2_0.backBtn = arg_2_0._tf:Find("ui/back")
	arg_2_0.switchDirBtn = arg_2_0._tf:Find("ui/switchDir")
	arg_2_0.takeBtn = arg_2_0._tf:Find("ui/bg/take")
	arg_2_0.videoTakeImg = arg_2_0._tf:Find("ui/bg/take/videoTakeImg")

	SetActive(arg_2_0.videoTakeImg, false)

	arg_2_0.switchCamBtn = arg_2_0._tf:Find("ui/bg/switchCam")
	arg_2_0.selectCharBtn = arg_2_0._tf:Find("ui/bg/selectChar")
	arg_2_0.l2dCtrlPanl = arg_2_0._tf:Find("ui/bg/l2dBgImg")
	arg_2_0.l2dStopBtnGo = arg_2_0._tf:Find("ui/bg/l2dBgImg/stopBtn")
	arg_2_0.l2dPlayBtnGo = arg_2_0._tf:Find("ui/bg/l2dBgImg/playBtn")

	SetActive(arg_2_0.l2dPlayBtnGo, false)

	arg_2_0.l2dAnimationBtnGo = arg_2_0._tf:Find("ui/bg/l2dBgImg/animationsBtn").gameObject
	arg_2_0.l2dAnimations = arg_2_0._tf:Find("ui/bg/animationsBg")
	arg_2_0.l2dAnimationBackBtnTrans = arg_2_0.l2dAnimations:Find("animationsBackBtn")

	SetActive(arg_2_0.l2dAnimations, false)

	arg_2_0.selectedID = 1
	arg_2_0.scrollItems = {}
	arg_2_0.isPause = false
	arg_2_0.animTpl = arg_2_0.l2dAnimations:Find("animation_tpl")

	SetActive(arg_2_0.animTpl, false)

	arg_2_0.animLayout = arg_2_0.l2dAnimations:Find("animation_container/animations")
	arg_2_0.animContainer = arg_2_0.l2dAnimations:Find("animation_container"):GetComponent("LScrollRect")
	arg_2_0.animContainer.decelerationRate = 0.1

	function arg_2_0.animContainer.onInitItem(arg_3_0)
		arg_2_0:onInitItem(arg_3_0)

		return
	end

	function arg_2_0.animContainer.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:onUpdateItem(arg_4_0, arg_4_1)

		return
	end

	function arg_2_0.animContainer.onReturnItem(arg_5_0, arg_5_1)
		arg_2_0:onReturnItem(arg_5_0, arg_5_1)

		return
	end

	function arg_2_0.animContainer.onStart()
		arg_2_0:updateSelectedItem()

		return
	end

	arg_2_0.paintBtn = arg_2_0._tf:Find("ui/bg/paintBtn")
	arg_2_0.live2dBtn = arg_2_0._tf:Find("ui/bg/l2dBgImg/live2dBtn")
	arg_2_0.spineBtn = arg_2_0._tf:Find("ui/bg/spineBtn")
	arg_2_0.modePnlTF = arg_2_0._tf:Find("ui/bg/modePnl")
	arg_2_0.takePhotoBtn = arg_2_0._tf:Find("ui/bg/modePnl/takePhotoBtn")
	arg_2_0.takeVideoBtn = arg_2_0._tf:Find("ui/bg/modePnl/takeVideoBtn")
	arg_2_0.stopRecBtn = arg_2_0._tf:Find("stopRec")
	arg_2_0.snapshot = arg_2_0._tf:Find("snapshot")
	arg_2_0.webcam = arg_2_0.snapshot:GetComponent(typeof(WebCam))
	arg_2_0.ysScreenShoter = arg_2_0.snapshot:GetComponent(typeof(YSTool.YSScreenShoter))
	arg_2_0.paint = arg_2_0._tf:Find("container/paint")
	arg_2_0.live2d = arg_2_0.paint:Find("live2d")
	arg_2_0.spine = arg_2_0.paint:Find("spine")
	arg_2_0.paintSkin = nil
	arg_2_0.showLive2d = false
	arg_2_0.showType = var_0_0.SHOW_PAINT
	arg_2_0.state = var_0_0.STATE_TAKE_PHOTO

	arg_2_0:setSkinAndLive2d(arg_2_0.contextData.skinId, arg_2_0.contextData.live2d)

	arg_2_0.verticalEulerAngle = 90
	arg_2_0.horizontalEulerAngle = 0
	arg_2_0.rotateUseTime = 0.2
	arg_2_0.isVertical = false
	arg_2_0.backBtnImg = arg_2_0._tf:Find("ui/back/Image")
	arg_2_0.selectCharBtnImg = arg_2_0._tf:Find("ui/bg/selectChar/Image")
	arg_2_0.switchCamBtnImg = arg_2_0._tf:Find("ui/bg/switchCam/Image")
	arg_2_0.l2dBtnImg = arg_2_0._tf:Find("ui/bg/paintBtn/Image")
	arg_2_0.l2dStopBtnImg = arg_2_0._tf:Find("ui/bg/l2dBgImg/stopBtn/Image")
	arg_2_0.l2dPlayBtnImg = arg_2_0._tf:Find("ui/bg/l2dBgImg/playBtn/Image")
	arg_2_0.l2d2PaintBtnImg = arg_2_0._tf:Find("ui/bg/l2dBgImg/live2dBtn/Image")
	arg_2_0.takePhotoVerticalText = arg_2_0._tf:Find("ui/bg/modePnl/takePhotoBtn/verticalText")
	arg_2_0.takePhotoHorizontalText = arg_2_0._tf:Find("ui/bg/modePnl/takePhotoBtn/horizontalText")
	arg_2_0.takePhotoVerticalText:GetComponent("Text").text = i18n("word_photo_mode")
	arg_2_0.takePhotoHorizontalText:GetComponent("Text").text = i18n("word_photo_mode")

	SetActive(arg_2_0.takePhotoHorizontalText, false)

	arg_2_0.takeVideoVerticalText = arg_2_0._tf:Find("ui/bg/modePnl/takeVideoBtn/verticalText")
	arg_2_0.takeVideoHorizontalText = arg_2_0._tf:Find("ui/bg/modePnl/takeVideoBtn/horizontalText")
	arg_2_0.takeVideoVerticalText:GetComponent("Text").text = i18n("word_video_mode")
	arg_2_0.takeVideoHorizontalText:GetComponent("Text").text = i18n("word_video_mode")

	SetActive(arg_2_0.takeVideoHorizontalText, false)

	arg_2_0.isFlipping = false
	arg_2_0.videoTipPanel = arg_2_0._tf:Find("videoTipPanel")

	setActive(arg_2_0.videoTipPanel, false)

	return
end

function var_0_0.back(arg_7_0)
	if arg_7_0.exited then
		return
	end

	arg_7_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.saveVideo(arg_8_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("word_save_video"),
		onYes = function()
			YARecorder.Inst:DiscardVideo()

			return
		end
	})

	return
end

function var_0_0.didEnter(arg_10_0)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:back()

		return
	end)
	onButton(arg_10_0, arg_10_0.switchDirBtn, function()
		arg_10_0.isVertical = not arg_10_0.isVertical

		arg_10_0:updateUIDirection()
		arg_10_0:updateCameraCanvas()

		return
	end)
	onButton(arg_10_0, arg_10_0.takeBtn, function()
		if arg_10_0.state == var_0_0.STATE_TAKE_PHOTO then
			setActive(arg_10_0.ui, false)
			arg_10_0.ysScreenShoter:TakeScreenShotData(function(arg_14_0)
				warning("截图结果：" .. tostring(arg_14_0))
				setActive(arg_10_0.ui, true)

				return
			end, function(arg_15_0)
				local var_15_0 = UnityEngine.Texture2D.New(Screen.width, Screen.height)

				Tex2DExtension.LoadImage(var_15_0, arg_15_0)
				arg_10_0:emit(var_0_0.SHARE_PANEL, var_15_0, arg_15_0)

				return
			end)
		elseif arg_10_0.state == var_0_0.STATE_TAKE_VIDEO then
			setActive(arg_10_0.ui, false)

			local function var_13_0(arg_16_0)
				if not arg_16_0 then
					setActive(arg_10_0.ui, true)
					LeanTween.moveX(arg_10_0.stopRecBtn, arg_10_0.stopRecBtn.rect.width, 0.15)
				end

				return
			end

			local function var_13_1()
				setActive(arg_10_0.stopRecBtn, true)
				LeanTween.moveX(arg_10_0.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					arg_10_0:SetMute(true)

					arg_10_0.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_13_0, arg_10_0.recordFilePath)

					return
				end))

				return
			end

			local var_13_2 = PlayerPrefs.GetInt("hadShowForVideoTip")

			if not var_13_2 or var_13_2 <= 0 then
				PlayerPrefs.SetInt("hadShowForVideoTip", 1)

				arg_10_0.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

				onButton(arg_10_0, arg_10_0.videoTipPanel, function()
					setActive(arg_10_0.videoTipPanel, false)
					var_13_1()

					return
				end)
				setActive(arg_10_0.videoTipPanel, true)
			else
				(function()
					setActive(arg_10_0.stopRecBtn, true)
					LeanTween.moveX(arg_10_0.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
						arg_10_0:SetMute(true)

						arg_10_0.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

						YSNormalTool.RecordTool.StartRecording(var_13_0, arg_10_0.recordFilePath)

						return
					end))

					return
				end)()
			end
		end

		return
	end)
	onButton(arg_10_0, arg_10_0.paintBtn, function()
		if arg_10_0.showType == var_0_0.SHOW_PAINT then
			arg_10_0:clearSkin()

			arg_10_0.showType = var_0_0.SHOW_LIVE2D

			arg_10_0:updateShowType()
			arg_10_0:updateSkin()
			arg_10_0:ResetL2dPanel()
		end

		return
	end)
	onButton(arg_10_0, arg_10_0.live2dBtn, function()
		if arg_10_0.showType == var_0_0.SHOW_LIVE2D then
			arg_10_0:clearSkin()

			arg_10_0.showType = var_0_0.SHOW_PAINT

			arg_10_0:updateShowType()
			arg_10_0:updateSkin()
		end

		return
	end)
	onButton(arg_10_0, arg_10_0.spineBtn, function()
		if arg_10_0.showType == var_0_0.SHOW_SPINE then
			arg_10_0:clearSkin()

			arg_10_0.showType = var_0_0.SHOW_PAINT

			arg_10_0:updateShowType()
			arg_10_0:updateSkin()
		end

		return
	end)
	onButton(arg_10_0, arg_10_0.takePhotoBtn, function()
		if arg_10_0.state == var_0_0.STATE_TAKE_PHOTO then
			return
		end

		arg_10_0.state = var_0_0.STATE_TAKE_PHOTO

		LeanTween.moveY(rtf(arg_10_0.modePnlTF), 56, 0.1)
		SetActive(arg_10_0.videoTakeImg, false)

		return
	end)
	onButton(arg_10_0, arg_10_0.takeVideoBtn, function()
		if CheckPermissionGranted(ANDROID_RECORD_AUDIO_PERMISSION) and CheckPermissionGranted(ANDROID_WRITE_EXTERNAL_PERMISSION) then
			arg_10_0:changeToTakeVideo()
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
	;(function()
		if arg_10_0.state == var_0_0.STATE_TAKE_PHOTO then
			return
		end

		arg_10_0.state = var_0_0.STATE_TAKE_PHOTO

		LeanTween.moveY(rtf(arg_10_0.modePnlTF), 56, 0.1)
		SetActive(arg_10_0.videoTakeImg, false)

		return
	end)()
	onButton(arg_10_0, arg_10_0.stopRecBtn, function()
		local function var_26_0(arg_27_0)
			if arg_27_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(arg_10_0.recordFilePath) then
							System.IO.File.Delete(arg_10_0.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(arg_10_0.recordFilePath, function(arg_30_0, arg_30_1)
							if arg_30_0 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))

								if System.IO.File.Exists(arg_10_0.recordFilePath) then
									System.IO.File.Delete(arg_10_0.recordFilePath)
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

		if not LeanTween.isTweening(go(arg_10_0.stopRecBtn)) then
			LeanTween.moveX(arg_10_0.stopRecBtn, arg_10_0.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(arg_10_0.ui, true)
				setActive(arg_10_0.stopRecBtn, false)
				YSNormalTool.RecordTool.StopRecording(var_26_0)
				arg_10_0:SetMute(false)

				return
			end))
		end

		return
	end)
	setActive(arg_10_0.stopRecBtn, false)
	onButton(arg_10_0, arg_10_0.switchCamBtn, function()
		arg_10_0.isFlipping = not arg_10_0.isFlipping

		arg_10_0.webcam:SwitchCam()
		arg_10_0:updateCameraCanvas()

		return
	end)
	onButton(arg_10_0, arg_10_0.selectCharBtn, function()
		arg_10_0:emit(var_0_0.SELECT_CHAR_PANEL)

		return
	end)

	function arg_10_0.webcam.takeCallback(arg_34_0)
		setActive(arg_10_0.ui, true)

		return
	end

	onButton(arg_10_0, arg_10_0.l2dStopBtnGo, function()
		arg_10_0.isPause = true

		arg_10_0:UpdateL2dPlayState()

		return
	end)
	onButton(arg_10_0, arg_10_0.l2dPlayBtnGo, function()
		arg_10_0.isPause = false

		arg_10_0:UpdateL2dPlayState()

		return
	end)
	onButton(arg_10_0, arg_10_0.l2dAnimationBtnGo, function()
		arg_10_0:setLive2dAnimsPanelState(true)

		return
	end)
	onButton(arg_10_0, arg_10_0.l2dAnimationBackBtnTrans, function()
		arg_10_0:setLive2dAnimsPanelState(false)

		return
	end)
	cameraPaintViewAdjust(true)
	arg_10_0:updateCameraCanvas()
	arg_10_0:updateShowType()

	return
end

function var_0_0.changeToTakeVideo(arg_39_0)
	if arg_39_0.state == var_0_0.STATE_TAKE_VIDEO then
		return
	end

	arg_39_0.state = var_0_0.STATE_TAKE_VIDEO

	LeanTween.moveY(rtf(arg_39_0.modePnlTF), -56, 0.1)
	SetActive(arg_39_0.videoTakeImg, true)

	return
end

function var_0_0.willExit(arg_40_0)
	arg_40_0:SetDummyForIOS(false)
	cameraPaintViewAdjust(false)
	arg_40_0:clearSkin()
	setActive(pg.UIMgr.GetInstance().OverlayEffect, PlayerPrefs.GetInt(SHOW_TOUCH_EFFECT, 1) > 0)

	return
end

function var_0_0.clearSkin(arg_41_0)
	if arg_41_0.paintSkin and arg_41_0.showType == var_0_0.SHOW_PAINT then
		retPaintingPrefab(arg_41_0.paint, arg_41_0.paintSkin)
	end

	if arg_41_0.spineSkin and arg_41_0.showType == var_0_0.SHOW_SPINE and arg_41_0.spineChar then
		arg_41_0.spineChar:Dispose()

		arg_41_0.spineChar = nil
	end

	if arg_41_0.live2dCom then
		arg_41_0.live2dCom.FinishAction = nil
		arg_41_0.live2dCom.EventAction = nil
	end

	if arg_41_0.live2dCom and arg_41_0.showType == var_0_0.SHOW_LIVE2D then
		Destroy(arg_41_0.live2dCom.gameObject)

		arg_41_0.live2dCom = nil
	end

	if arg_41_0.live2dRequestId then
		pg.Live2DMgr.GetInstance():StopLoadingLive2d(arg_41_0.live2dRequestId)

		arg_41_0.live2dRequestId = nil
	end

	return
end

function var_0_0.checkSkin(arg_42_0, arg_42_1)
	local var_42_0 = pg.ship_skin_template[arg_42_1]

	assert(arg_42_1 == -1 or var_42_0, "invalid skin id " .. arg_42_1)

	arg_42_0.skin = var_42_0

	local var_42_1 = false

	if arg_42_0.contextData.tbId then
		arg_42_0.paintSkin = pg.secretary_special_ship[arg_42_0.contextData.tbId].prefab or "tbniang"
		var_42_1 = true
		arg_42_0.contextData.tbId = nil
	elseif arg_42_0.paintSkin ~= var_42_0.painting or var_42_0.spineSkin ~= var_42_0.prefab then
		arg_42_0:clearSkin()

		arg_42_0.paintSkin = var_42_0.painting
		arg_42_0.spineSkin = var_42_0.prefab
		arg_42_0.l2dAnims = var_42_0.l2d_animations

		if arg_42_0.l2dAnims == "" then
			arg_42_0.l2dAnims = {
				"idle"
			}
		end

		var_42_1 = true
	end

	return var_42_1
end

function var_0_0.setSkinAndLive2d(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:checkSkin(arg_43_1)

	if arg_43_0.showType ~= var_0_0.SHOW_LIVE2D and arg_43_2 then
		arg_43_0.showType = var_0_0.SHOW_LIVE2D

		arg_43_0:updateShowType()

		var_43_0 = true
	end

	if var_43_0 then
		arg_43_0:updateSkin()
	end

	return
end

function var_0_0.setSkin(arg_44_0, arg_44_1)
	if arg_44_0:checkSkin(arg_44_1) then
		arg_44_0:updateSkin()
	end

	return
end

function var_0_0.setLive2d(arg_45_0, arg_45_1)
	if arg_45_0.showType ~= var_0_0.SHOW_LIVE2D and arg_45_1 then
		arg_45_0:clearSkin()

		arg_45_0.showType = var_0_0.SHOW_LIVE2D

		arg_45_0:updateShowType()
		arg_45_0:updateSkin()
	end

	return
end

function var_0_0.updateShowType(arg_46_0)
	setActive(arg_46_0.paintBtn, false)
	arg_46_0:setLive2dAnimsPanelState(false)
	setActive(arg_46_0.live2dBtn, false)
	setActive(arg_46_0.l2dCtrlPanl, false)
	setActive(arg_46_0.spineBtn, false)

	if arg_46_0.showType == var_0_0.SHOW_PAINT then
		setActive(arg_46_0.paintBtn, true)
	elseif arg_46_0.showType == var_0_0.SHOW_LIVE2D then
		setActive(arg_46_0.live2dBtn, true)
		SetActive(arg_46_0.l2dCtrlPanl, true)
	elseif arg_46_0.showType == var_0_0.SHOW_SPINE then
		setActive(arg_46_0.spineBtn, true)
	end

	return
end

local function var_0_1(arg_47_0)
	if arg_47_0 == var_0_0.SHOW_PAINT then
		return 0.5, 2
	elseif arg_47_0 == var_0_0.SHOW_LIVE2D then
		return 0.5, 2
	elseif arg_47_0 == var_0_0.SHOW_SPINE then
		return 0.5, 4
	end

	return
end

function var_0_0.updateSkin(arg_48_0)
	if arg_48_0.showType == var_0_0.SHOW_LIVE2D and (not ResourceMgr.Inst:AssetExist("live2d/" .. arg_48_0.paintSkin) or not checkABExist("live2d/" .. arg_48_0.paintSkin)) then
		arg_48_0.showType = var_0_0.SHOW_PAINT

		arg_48_0:updateShowType()
	end

	local var_48_0 = arg_48_0.paint:GetComponent(typeof(Zoom))
	local var_48_3, var_48_4 = var_0_1(arg_48_0.showType)

	var_48_0.minZoom, var_48_0.maxZoom = var_48_3, var_48_4

	if var_48_4 < arg_48_0.paint.localScale.x then
		arg_48_0.paint.localScale = Vector3(var_48_4, var_48_4, var_48_4)
	elseif var_48_3 > arg_48_0.paint.localScale.x then
		arg_48_0.paint.localScale = Vector3(var_48_3, var_48_3, var_48_3)
	end

	if arg_48_0.showType == var_0_0.SHOW_LIVE2D then
		pg.UIMgr.GetInstance():LoadingOn()

		arg_48_0.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(arg_48_0.paintSkin, function(arg_49_0)
			HotfixHelper.SetLayerRecursively(arg_49_0, LayerMask.NameToLayer("UI"))

			local var_49_0 = arg_49_0.transform

			arg_49_0.transform:SetParent(arg_48_0.live2d, true)

			var_49_0.localScale = arg_48_0.skin.live2d_offset and #arg_48_0.skin.live2d_offset >= 4 and Vector3(arg_48_0.skin.live2d_offset[4], arg_48_0.skin.live2d_offset[4], arg_48_0.skin.live2d_offset[4]) or Vector3(52, 52, 52)
			var_49_0.localPosition = Vector3(arg_48_0.skin.live2d_offset[1] + 500, arg_48_0.skin.live2d_offset[2], arg_48_0.skin.live2d_offset[3])

			local var_49_1 = arg_49_0:GetComponent(typeof(Live2dChar))

			var_49_1:SetAction(pg.AssistantInfo.action2Id.idle)

			function var_49_1.FinishAction(arg_50_0)
				if arg_48_0.selectedID and arg_48_0.selectedID ~= pg.AssistantInfo.action2Id.idle then
					arg_48_0:setL2dAction(arg_48_0.selectedID)
				end

				return
			end

			Live2DPainting.SetL2dSortingLayer(arg_49_0, LayerWeightConst.L2D_DEFAULT_LAYER)

			arg_48_0.live2dCom = var_49_1
			arg_48_0.live2dCom.name = arg_48_0.paintSkin
			arg_48_0.playActionId = pg.AssistantInfo.action2Id.idle
			arg_48_0.selectedID = pg.AssistantInfo.action2Id.idle
			arg_48_0.live2dAnimator = arg_49_0:GetComponent(typeof(Animator))

			local var_49_2 = arg_48_0.live2dCom:GetCubismParameter("Paramring")

			if var_49_2 then
				if arg_48_0.contextData and arg_48_0.contextData.propose then
					arg_48_0.live2dCom:AddParameterValue(var_49_2, 1, CubismParameterBlendMode.Override)
				else
					arg_48_0.live2dCom:AddParameterValue(var_49_2, 0, CubismParameterBlendMode.Override)
				end
			end

			arg_48_0:ResetL2dPanel()
			arg_48_0:setLive2dAnimsPanelState(true)
			SetActive(arg_48_0.spine, false)
			SetActive(arg_48_0.live2d, true)
			pg.UIMgr.GetInstance():LoadingOff()

			if arg_48_0.skin.lip_sync_gain and arg_48_0.skin.lip_sync_gain ~= 0 then
				arg_48_0.live2d:GetChild(0):GetComponent("CubismCriSrcMouthInput").Gain = arg_48_0.skin.lip_sync_gain
			end

			if arg_48_0.skin.lip_smoothing and arg_48_0.skin.lip_smoothing ~= 0 then
				arg_48_0.live2d:GetChild(0):GetComponent("CubismCriSrcMouthInput").Smoothing = arg_48_0.skin.lip_smoothing
			end

			return
		end)
	elseif arg_48_0.showType == var_0_0.SHOW_PAINT then
		SetActive(arg_48_0.live2d, false)
		SetActive(arg_48_0.spine, false)
		setPaintingPrefabAsync(arg_48_0.paint, arg_48_0.paintSkin, "mainNormal")
	elseif arg_48_0.showType == var_0_0.SHOW_SPINE then
		SetActive(arg_48_0.live2d, false)
		SetActive(arg_48_0.spine, true)

		arg_48_0.spineChar = SpineAnimChar.New()

		arg_48_0.spineChar:SetPaint(arg_48_0.spineSkin)
		arg_48_0.spineChar:Load(true, function(arg_51_0)
			arg_51_0:SetName("model")
			arg_51_0:SetParent(arg_48_0.spine, true)
			arg_51_0:SetLocalScale(Vector3(0.5, 0.5, 0.5))
			arg_51_0:SetLocalPosition(Vector3.zero)
			arg_48_0:playAction("normal")

			return
		end)
	end

	return
end

function var_0_0.playAction(arg_52_0, arg_52_1)
	if arg_52_0.showType ~= var_0_0.SHOW_SPINE then
		return
	end

	if arg_52_0.spineChar then
		arg_52_0.spineChar:SetAction(arg_52_1, 0)
	end

	return
end

function var_0_0.ResetL2dPanel(arg_53_0)
	arg_53_0.selectedID = pg.AssistantInfo.action2Id.idle
	arg_53_0.isPause = false

	arg_53_0:UpdateL2dPlayState(true)
	arg_53_0:updateSelectedItem()

	return
end

function var_0_0.UpdateL2dPlayState(arg_54_0, arg_54_1)
	if arg_54_0.showType ~= var_0_0.SHOW_LIVE2D then
		return
	end

	if arg_54_0.isPause then
		SetActive(arg_54_0.l2dStopBtnGo, false)
		SetActive(arg_54_0.l2dPlayBtnGo, true)
	else
		SetActive(arg_54_0.l2dStopBtnGo, true)
		SetActive(arg_54_0.l2dPlayBtnGo, false)
	end

	if not arg_54_1 then
		arg_54_0:L2dAnimationState()
	end

	return
end

function var_0_0.L2dAnimationState(arg_55_0)
	if arg_55_0.showType ~= var_0_0.SHOW_LIVE2D then
		return
	end

	arg_55_0.live2dAnimator.speed = arg_55_0.isPause and 0 or 1

	return
end

function var_0_0.updateLive2dAnimationPanel(arg_56_0)
	SetActive(arg_56_0.l2dAnimations, arg_56_0.isShowL2dAnims)
	SetActive(arg_56_0.l2dAnimationBtnGo, not arg_56_0.isShowL2dAnims)

	if arg_56_0.isShowL2dAnims and #arg_56_0.l2dAnims > 1 then
		arg_56_0.animContainer:SetTotalCount(#arg_56_0.l2dAnims, 0)
	end

	return
end

function var_0_0.setLive2dAnimsPanelState(arg_57_0, arg_57_1)
	arg_57_0.isShowL2dAnims = arg_57_1

	arg_57_0:updateLive2dAnimationPanel()

	return
end

local var_0_2 = 3

function var_0_0.onInitItem(arg_58_0, arg_58_1)
	local var_58_0 = SnapshotItem.New(arg_58_1, false)

	onButton(arg_58_0, var_58_0.go, function()
		if arg_58_0.l2dClickCD and Time.fixedTime - arg_58_0.l2dClickCD < var_0_2 then
			return
		end

		if arg_58_0.selectedID == var_58_0:GetID() then
			return
		end

		if var_58_0:GetID() == 6 or var_58_0:GetID() == 7 then
			arg_58_0.l2dClickCD = Time.fixedTime
		end

		arg_58_0.selectedID = var_58_0:GetID()

		arg_58_0:updateSelectedItem()
		arg_58_0:setL2dAction(arg_58_0.selectedID)

		return
	end, SFX_CONFIRM)

	arg_58_0.scrollItems[arg_58_1] = var_58_0

	return
end

function var_0_0.setL2dAction(arg_60_0, arg_60_1)
	if arg_60_1 ~= pg.AssistantInfo.action2Id.idle then
		-- block empty
	end

	if arg_60_0.live2dCom and arg_60_1 then
		if arg_60_1 == pg.AssistantInfo.action2Id.idle then
			arg_60_0.live2dCom:SetAction(arg_60_1)
		elseif arg_60_0.playActionId == pg.AssistantInfo.action2Id.idle then
			arg_60_0.live2dCom:SetAction(arg_60_1)
		elseif arg_60_0.playActionId == arg_60_1 then
			arg_60_0.live2dCom:SetAction(arg_60_1)
		end

		arg_60_0.playActionId = arg_60_1
	end

	return
end

function var_0_0.onUpdateItem(arg_61_0, arg_61_1, arg_61_2)
	arg_61_1 = arg_61_1 + 1

	local var_61_0 = arg_61_0.scrollItems[arg_61_2]

	if not arg_61_0.scrollItems[arg_61_2] then
		arg_61_0:onInitItem(arg_61_2)

		var_61_0 = arg_61_0.scrollItems[arg_61_2]
	end

	;({
		id = pg.AssistantInfo.action2Id[arg_61_0.l2dAnims[arg_61_1]]
	}).name = i18n(arg_61_0.l2dAnims[arg_61_1])

	var_61_0:Update({
		id = pg.AssistantInfo.action2Id[arg_61_0.l2dAnims[arg_61_1]]
	})

	if arg_61_0.isVertical then
		var_61_0:SetEulerAngle(arg_61_0.verticalEulerAngle)
	else
		var_61_0:SetEulerAngle(arg_61_0.horizontalEulerAngle)
	end

	if var_61_0:GetID() == arg_61_0.selectedID then
		var_61_0:UpdateSelected(true)
	else
		var_61_0:UpdateSelected(false)
	end

	return
end

function var_0_0.onReturnItem(arg_62_0, arg_62_1, arg_62_2)
	return
end

function var_0_0.updateSelectedItem(arg_63_0)
	for iter_63_0, iter_63_1 in pairs(arg_63_0.scrollItems) do
		if iter_63_1:HasInfo() then
			if iter_63_1:GetID() == arg_63_0.selectedID then
				iter_63_1:UpdateSelected(true)
			else
				iter_63_1:UpdateSelected(false)
			end
		end
	end

	return
end

function var_0_0.updateUIDirection(arg_64_0)
	if arg_64_0.isVertical then
		LeanTween.rotateZ(go(arg_64_0.backBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.selectCharBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.switchCamBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dStopBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dPlayBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2d2PaintBtnImg), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		SetActive(arg_64_0.takePhotoVerticalText, false)
		SetActive(arg_64_0.takePhotoHorizontalText, true)
		SetActive(arg_64_0.takeVideoVerticalText, false)
		SetActive(arg_64_0.takeVideoHorizontalText, true)
		LeanTween.rotateZ(go(arg_64_0.paint), arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
		arg_64_0:updateListItemRotate(arg_64_0.verticalEulerAngle, arg_64_0.rotateUseTime)
	else
		local var_64_0 = arg_64_0.horizontalEulerAngle

		LeanTween.rotateZ(go(arg_64_0.backBtnImg), arg_64_0.horizontalEulerAngle, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.selectCharBtnImg), var_64_0, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.switchCamBtnImg), var_64_0, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dBtnImg), var_64_0, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dStopBtnImg), var_64_0, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2dPlayBtnImg), var_64_0, arg_64_0.rotateUseTime)
		LeanTween.rotateZ(go(arg_64_0.l2d2PaintBtnImg), var_64_0, arg_64_0.rotateUseTime)
		SetActive(arg_64_0.takePhotoVerticalText, true)
		SetActive(arg_64_0.takePhotoHorizontalText, false)
		SetActive(arg_64_0.takeVideoVerticalText, true)
		SetActive(arg_64_0.takeVideoHorizontalText, false)
		LeanTween.rotateZ(go(arg_64_0.paint), var_64_0, arg_64_0.rotateUseTime)
		arg_64_0:updateListItemRotate(var_64_0, arg_64_0.rotateUseTime)
	end

	return
end

function var_0_0.updateListItemRotate(arg_65_0, arg_65_1, arg_65_2)
	for iter_65_0, iter_65_1 in pairs(arg_65_0.scrollItems) do
		iter_65_1:RotateUI(arg_65_1, arg_65_2)
	end

	return
end

function var_0_0.updateCameraCanvas(arg_66_0)
	local var_66_0 = pg.CameraFixMgr.GetInstance().targetRatio
	local var_66_1 = 1

	if UnityEngine.Screen.width / UnityEngine.Screen.height < var_66_0 then
		var_66_1 = var_66_0 / (UnityEngine.Screen.width / UnityEngine.Screen.height)
	elseif var_66_0 < UnityEngine.Screen.width / UnityEngine.Screen.height then
		var_66_1 = UnityEngine.Screen.width / UnityEngine.Screen.height / var_66_0
	end

	arg_66_0.snapshot.localScale = arg_66_0.isFlipping and Vector3(-var_66_1, var_66_1, 1) or Vector3(var_66_1, var_66_1, 1)

	return
end

function var_0_0.SetDummyForIOS(arg_67_0, arg_67_1)
	if PLATFORM ~= PLATFORM_IPHONEPLAYER then
		setActive(arg_67_0.dummy, false)

		return
	end

	local var_67_0 = pg.UIMgr.GetInstance():GetMainCamera():GetComponent(typeof(Camera))

	if arg_67_1 then
		var_67_0.nearClipPlane = 0

		arg_67_0.dummy:SetParent(pg.UIMgr.GetInstance():GetMainCamera().transform)

		arg_67_0.dummy.localPosition = Vector3(0, 0, 3)
		arg_67_0.dummy.localRotation = Vector3(0, 0, 0)
		arg_67_0.dummy.localScale = Vector3(1, 1, 1)

		setActive(arg_67_0.dummy, true)
	else
		var_67_0.nearClipPlane = -100

		arg_67_0.dummy:SetParent(arg_67_0._tf)

		arg_67_0.dummy.localPosition = Vector3(0, 0, 0)
		arg_67_0.dummy.localRotation = Vector3(0, 0, 0)
		arg_67_0.dummy.localScale = Vector3(1, 1, 1)
	end

	return
end

function var_0_0.SetMute(arg_68_0, arg_68_1)
	if arg_68_1 then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

return var_0_0
