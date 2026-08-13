class = var_0_10000

local var_0_0 = "SnapshotScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.SELECT_CHAR_PANEL = "SnapshotScene.SELECT_CHAR_PANEL"
var_0_1.SHARE_PANEL = "SnapshotScene.SHARE_PANEL"
var_0_1.SHOW_PAINT = 0
var_0_1.SHOW_LIVE2D = 1
var_0_1.SHOW_SPINE = 2
var_0_1.STATE_TAKE_PHOTO = 0
var_0_1.STATE_TAKE_VIDEO = 1

function var_0_1.getUIName(arg_1_0)
	return "snapshot"
end

function var_0_1.init(arg_2_0)
	setActive = var_1_10001
	pg = var_1_10002

	var_1_10001(var_1_10002.UIMgr.GetInstance().OverlayEffect, false)

	local var_2_0 = arg_2_0._tf

	arg_2_0.dummy = var_1.Find(var_2_0, "SnapshotInvisible")

	arg_2_0:SetDummyForIOS(true)

	local var_2_1 = arg_2_0._tf

	arg_2_0.ui = var_1.Find(var_2_1, "ui")

	local var_2_2 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_2, "ui/back")

	local var_2_3 = arg_2_0._tf

	arg_2_0.switchDirBtn = var_1.Find(var_2_3, "ui/switchDir")

	local var_2_4 = arg_2_0._tf

	arg_2_0.takeBtn = var_1.Find(var_2_4, "ui/bg/take")

	local var_2_5 = arg_2_0._tf

	arg_2_0.videoTakeImg = var_1.Find(var_2_5, "ui/bg/take/videoTakeImg")
	SetActive = var_1

	var_1(arg_2_0.videoTakeImg, false)

	local var_2_6 = arg_2_0._tf

	arg_2_0.switchCamBtn = var_1.Find(var_2_6, "ui/bg/switchCam")

	local var_2_7 = arg_2_0._tf

	arg_2_0.selectCharBtn = var_1.Find(var_2_7, "ui/bg/selectChar")

	local var_2_8 = arg_2_0._tf

	arg_2_0.l2dCtrlPanl = var_1.Find(var_2_8, "ui/bg/l2dBgImg")

	local var_2_9 = arg_2_0._tf

	arg_2_0.l2dStopBtnGo = var_1.Find(var_2_9, "ui/bg/l2dBgImg/stopBtn")

	local var_2_10 = arg_2_0._tf

	arg_2_0.l2dPlayBtnGo = var_1.Find(var_2_10, "ui/bg/l2dBgImg/playBtn")
	SetActive = var_1

	var_1(arg_2_0.l2dPlayBtnGo, false)

	local var_2_11 = arg_2_0._tf

	arg_2_0.l2dAnimationBtnGo = var_1.Find(var_2_11, "ui/bg/l2dBgImg/animationsBtn").gameObject

	local var_2_12 = arg_2_0._tf

	arg_2_0.l2dAnimations = var_1.Find(var_2_12, "ui/bg/animationsBg")

	local var_2_13 = arg_2_0.l2dAnimations

	arg_2_0.l2dAnimationBackBtnTrans = var_1.Find(var_2_13, "animationsBackBtn")
	SetActive = var_1

	var_1(arg_2_0.l2dAnimations, false)

	arg_2_0.selectedID = 1
	arg_2_0.scrollItems = {}
	arg_2_0.isPause = false

	local var_2_14 = arg_2_0.l2dAnimations

	arg_2_0.animTpl = var_1.Find(var_2_14, "animation_tpl")
	SetActive = var_1

	var_1(arg_2_0.animTpl, false)

	local var_2_15 = arg_2_0.l2dAnimations

	arg_2_0.animLayout = var_1.Find(var_2_15, "animation_container/animations")

	local var_2_16 = arg_2_0.l2dAnimations
	local var_2_17 = var_1.Find(var_2_16, "animation_container")

	arg_2_0.animContainer = var_1.GetComponent(var_2_17, "LScrollRect")
	arg_2_0.animContainer.decelerationRate = 0.1

	function arg_2_0.animContainer.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.onInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.animContainer.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	function arg_2_0.animContainer.onReturnItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onReturnItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	function arg_2_0.animContainer.onStart()
		local var_6_0 = arg_2_0

		var_0.updateSelectedItem(var_6_0)

		return
	end

	local var_2_18 = arg_2_0._tf

	arg_2_0.paintBtn = var_1.Find(var_2_18, "ui/bg/paintBtn")

	local var_2_19 = arg_2_0._tf

	arg_2_0.live2dBtn = var_1.Find(var_2_19, "ui/bg/l2dBgImg/live2dBtn")

	local var_2_20 = arg_2_0._tf

	arg_2_0.spineBtn = var_1.Find(var_2_20, "ui/bg/spineBtn")

	local var_2_21 = arg_2_0._tf

	arg_2_0.modePnlTF = var_1.Find(var_2_21, "ui/bg/modePnl")

	local var_2_22 = arg_2_0._tf

	arg_2_0.takePhotoBtn = var_1.Find(var_2_22, "ui/bg/modePnl/takePhotoBtn")

	local var_2_23 = arg_2_0._tf

	arg_2_0.takeVideoBtn = var_1.Find(var_2_23, "ui/bg/modePnl/takeVideoBtn")

	local var_2_24 = arg_2_0._tf

	arg_2_0.stopRecBtn = var_1.Find(var_2_24, "stopRec")

	local var_2_25 = arg_2_0._tf

	arg_2_0.snapshot = var_1.Find(var_2_25, "snapshot")

	local var_2_26 = arg_2_0.snapshot
	local var_2_27 = var_1.GetComponent

	typeof = var_3
	WebCam = var_1_10004
	arg_2_0.webcam = var_2_27(var_2_26, var_3(var_1_10004))

	local var_2_28 = arg_2_0.snapshot
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	YSTool = var_1_10004
	arg_2_0.ysScreenShoter = var_2_29(var_2_28, var_3(var_1_10004.YSScreenShoter))

	local var_2_30 = arg_2_0._tf

	arg_2_0.paint = var_1.Find(var_2_30, "container/paint")

	local var_2_31 = arg_2_0.paint

	arg_2_0.live2d = var_1.Find(var_2_31, "live2d")

	local var_2_32 = arg_2_0.paint

	arg_2_0.spine = var_1.Find(var_2_32, "spine")
	arg_2_0.paintSkin = nil
	arg_2_0.showLive2d = false
	arg_2_0.showType = var_0_1.SHOW_PAINT
	arg_2_0.state = var_0_1.STATE_TAKE_PHOTO

	arg_2_0:setSkinAndLive2d(arg_2_0.contextData.skinId, arg_2_0.contextData.live2d)

	arg_2_0.verticalEulerAngle = 90
	arg_2_0.horizontalEulerAngle = 0
	arg_2_0.rotateUseTime = 0.2
	arg_2_0.isVertical = false

	local var_2_33 = arg_2_0._tf

	arg_2_0.backBtnImg = var_1.Find(var_2_33, "ui/back/Image")

	local var_2_34 = arg_2_0._tf

	arg_2_0.selectCharBtnImg = var_1.Find(var_2_34, "ui/bg/selectChar/Image")

	local var_2_35 = arg_2_0._tf

	arg_2_0.switchCamBtnImg = var_1.Find(var_2_35, "ui/bg/switchCam/Image")

	local var_2_36 = arg_2_0._tf

	arg_2_0.l2dBtnImg = var_1.Find(var_2_36, "ui/bg/paintBtn/Image")

	local var_2_37 = arg_2_0._tf

	arg_2_0.l2dStopBtnImg = var_1.Find(var_2_37, "ui/bg/l2dBgImg/stopBtn/Image")

	local var_2_38 = arg_2_0._tf

	arg_2_0.l2dPlayBtnImg = var_1.Find(var_2_38, "ui/bg/l2dBgImg/playBtn/Image")

	local var_2_39 = arg_2_0._tf

	arg_2_0.l2d2PaintBtnImg = var_1.Find(var_2_39, "ui/bg/l2dBgImg/live2dBtn/Image")

	local var_2_40 = arg_2_0._tf

	arg_2_0.takePhotoVerticalText = var_1.Find(var_2_40, "ui/bg/modePnl/takePhotoBtn/verticalText")

	local var_2_41 = arg_2_0._tf

	arg_2_0.takePhotoHorizontalText = var_1.Find(var_2_41, "ui/bg/modePnl/takePhotoBtn/horizontalText")

	local var_2_42 = arg_2_0.takePhotoVerticalText
	local var_2_43 = var_1.GetComponent(var_2_42, "Text")

	i18n = var_2_42
	var_2_43.text = var_2_42("word_photo_mode")

	local var_2_44 = arg_2_0.takePhotoHorizontalText
	local var_2_45 = var_1.GetComponent(var_2_44, "Text")

	i18n = var_2_44
	var_2_45.text = var_2_44("word_photo_mode")
	SetActive = var_2_45

	var_2_45(arg_2_0.takePhotoHorizontalText, false)

	local var_2_46 = arg_2_0._tf

	arg_2_0.takeVideoVerticalText = var_1.Find(var_2_46, "ui/bg/modePnl/takeVideoBtn/verticalText")

	local var_2_47 = arg_2_0._tf

	arg_2_0.takeVideoHorizontalText = var_1.Find(var_2_47, "ui/bg/modePnl/takeVideoBtn/horizontalText")

	local var_2_48 = arg_2_0.takeVideoVerticalText
	local var_2_49 = var_1.GetComponent(var_2_48, "Text")

	i18n = var_2_48
	var_2_49.text = var_2_48("word_video_mode")

	local var_2_50 = arg_2_0.takeVideoHorizontalText
	local var_2_51 = var_1.GetComponent(var_2_50, "Text")

	i18n = var_2_50
	var_2_51.text = var_2_50("word_video_mode")
	SetActive = var_2_51

	var_2_51(arg_2_0.takeVideoHorizontalText, false)

	arg_2_0.isFlipping = false

	local var_2_52 = arg_2_0._tf

	arg_2_0.videoTipPanel = var_1.Find(var_2_52, "videoTipPanel")
	setActive = var_1

	var_1(arg_2_0.videoTipPanel, false)

	return
end

function var_0_1.back(arg_7_0)
	if arg_7_0.exited then
		return
	end

	arg_7_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.saveVideo(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_8_1 = var_1.ShowMsgBox
	local var_8_2 = {}

	i18n = var_1_10004
	var_8_2.content = var_1_10004("word_save_video")

	function var_8_2.onYes()
		YARecorder = var_2_10000

		local var_9_0 = var_2_10000.Inst

		var_0.DiscardVideo(var_9_0)

		return
	end

	var_8_1(var_8_0, var_8_2)

	return
end

function var_0_1.didEnter(arg_10_0)
	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.backBtn, function()
		local var_11_0 = arg_10_0

		var_0.back(var_11_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.switchDirBtn, function()
		arg_10_0.isVertical = not arg_10_0.isVertical

		local var_12_0 = arg_10_0

		var_0.updateUIDirection(var_12_0)

		local var_12_1 = arg_10_0

		var_0.updateCameraCanvas(var_12_1)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.takeBtn, function()
		if arg_10_0.state == var_0_1.STATE_TAKE_PHOTO then
			setActive = var_0

			var_0(arg_10_0.ui, false)

			local function var_13_0(arg_14_0)
				warning = var_3_10001

				local var_14_0 = "截图结果："

				tostring = var_3_10003

				var_3_10001(var_14_0 .. var_3_10003(arg_14_0))

				setActive = var_3_10001

				var_3_10001(arg_10_0.ui, true)

				return
			end

			local function var_13_1(arg_15_0)
				UnityEngine = var_3_10001

				local var_15_0 = var_3_10001.Texture2D.New

				Screen = var_3_10002

				local var_15_1 = var_3_10002.width

				Screen = var_3_10003

				local var_15_2 = var_15_0(var_15_1, var_3_10003.height)

				Tex2DExtension = var_15_1

				var_15_1.LoadImage(var_15_2, arg_15_0)

				local var_15_3 = arg_10_0

				var_2.emit(var_15_3, var_0_1.SHARE_PANEL, var_15_2, arg_15_0)

				return
			end

			local var_13_2 = arg_10_0.ysScreenShoter

			var_2.TakeScreenShotData(var_13_2, var_13_0, var_13_1)
		elseif arg_10_0.state == var_0_1.STATE_TAKE_VIDEO then
			setActive = var_0

			var_0(arg_10_0.ui, false)

			local function var_13_3(arg_16_0)
				if not arg_16_0 then
					setActive = var_3_10001

					var_3_10001(arg_10_0.ui, true)

					LeanTween = var_3_10001

					var_3_10001.moveX(arg_10_0.stopRecBtn, arg_10_0.stopRecBtn.rect.width, 0.15)
				end

				return
			end

			local function var_13_4()
				setActive = var_3_10000

				var_3_10000(arg_10_0.stopRecBtn, true)

				LeanTween = var_3_10000

				local var_17_0 = var_3_10000.moveX(arg_10_0.stopRecBtn, 0, 0.15)
				local var_17_1 = var_0.setOnComplete

				System = var_2

				var_17_1(var_17_0, var_2.Action(function()
					local var_18_0 = arg_10_0

					var_0.SetMute(var_18_0, true)

					local var_18_1 = arg_10_0

					YSNormalTool = var_18_0
					var_18_1.recordFilePath = var_18_0.RecordTool.GenRecordFilePath()
					YSNormalTool = var_18_1

					var_18_1.RecordTool.StartRecording(var_13_3, arg_10_0.recordFilePath)

					return
				end))

				return
			end

			PlayerPrefs = var_2

			if not var_2.GetInt("hadShowForVideoTip") or var_2 <= 0 then
				PlayerPrefs = var_3

				var_3.SetInt("hadShowForVideoTip", 1)

				local var_13_5 = arg_10_0.videoTipPanel
				local var_13_6 = var_3.Find(var_13_5, "Text")
				local var_13_7 = var_3.GetComponent(var_13_6, "Text")

				i18n = var_13_6
				var_13_7.text = var_13_6("word_take_video_tip")
				onButton = var_13_7

				var_13_7(arg_10_0, arg_10_0.videoTipPanel, function()
					setActive = var_3_10000

					var_3_10000(arg_10_0.videoTipPanel, false)
					var_13_4()

					return
				end)

				setActive = var_13_7

				var_13_7(arg_10_0.videoTipPanel, true)
			else
				var_13_4()
			end
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.paintBtn, function()
		if arg_10_0.showType == var_0_1.SHOW_PAINT then
			local var_20_0 = arg_10_0

			var_0.clearSkin(var_20_0)

			arg_10_0.showType = var_0_1.SHOW_LIVE2D

			local var_20_1 = arg_10_0

			var_0.updateShowType(var_20_1)

			local var_20_2 = arg_10_0

			var_0.updateSkin(var_20_2)

			local var_20_3 = arg_10_0

			var_0.ResetL2dPanel(var_20_3)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.live2dBtn, function()
		if arg_10_0.showType == var_0_1.SHOW_LIVE2D then
			local var_21_0 = arg_10_0

			var_0.clearSkin(var_21_0)

			arg_10_0.showType = var_0_1.SHOW_PAINT

			local var_21_1 = arg_10_0

			var_0.updateShowType(var_21_1)

			local var_21_2 = arg_10_0

			var_0.updateSkin(var_21_2)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.spineBtn, function()
		if arg_10_0.showType == var_0_1.SHOW_SPINE then
			local var_22_0 = arg_10_0

			var_0.clearSkin(var_22_0)

			arg_10_0.showType = var_0_1.SHOW_PAINT

			local var_22_1 = arg_10_0

			var_0.updateShowType(var_22_1)

			local var_22_2 = arg_10_0

			var_0.updateSkin(var_22_2)
		end

		return
	end)

	local function var_10_0()
		if arg_10_0.state == var_0_1.STATE_TAKE_PHOTO then
			return
		end

		local var_23_0 = arg_10_0

		var_23_0.state = var_0_1.STATE_TAKE_PHOTO
		LeanTween = var_23_0

		local var_23_1 = var_23_0.moveY

		rtf = var_1

		var_23_1(var_1(arg_10_0.modePnlTF), 56, 0.1)

		SetActive = var_23_1

		var_23_1(arg_10_0.videoTakeImg, false)

		return
	end

	onButton = var_2

	var_2(arg_10_0, arg_10_0.takePhotoBtn, var_10_0)

	onButton = var_2

	var_2(arg_10_0, arg_10_0.takeVideoBtn, function()
		CheckPermissionGranted = var_2_10000
		ANDROID_RECORD_AUDIO_PERMISSION = var_2_10001

		if var_2_10000(var_2_10001) then
			CheckPermissionGranted = var_0
			ANDROID_WRITE_EXTERNAL_PERMISSION = var_2_10001

			if var_0(var_2_10001) then
				local var_24_0 = arg_10_0

				var_0.changeToTakeVideo(var_24_0)

				goto label_24_0
			end
		end

		pg = var_0

		do
			local var_24_1 = var_0.MsgboxMgr.GetInstance()
			local var_24_2 = var_0.ShowMsgBox
			local var_24_3 = {}

			i18n = var_2_10003
			var_24_3.content = var_2_10003("apply_permission_record_audio_tip1")

			function var_24_3.onYes()
				ApplyPermission = var_3_10000

				local var_25_0 = {}

				ANDROID_RECORD_AUDIO_PERMISSION = var_3_10002
				var_25_0[1] = var_3_10002
				ANDROID_WRITE_EXTERNAL_PERMISSION = var_3_10002
				var_25_0[2] = var_3_10002

				var_3_10000(var_25_0)

				return
			end

			var_24_2(var_24_1, var_24_3)
		end

		::label_24_0::

		return
	end)
	var_10_0()

	onButton = var_2

	var_2(arg_10_0, arg_10_0.stopRecBtn, function()
		local function var_26_0(arg_27_0)
			if arg_27_0 then
				PLATFORM = var_3_10001
				PLATFORM_ANDROID = var_3_10002

				if var_3_10001 == var_3_10002 then
					pg = var_3_10001

					local var_27_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_27_1 = var_1.ShowMsgBox
					local var_27_2 = {}

					i18n = var_3_10004
					var_27_2.content = var_3_10004("word_save_video")

					function var_27_2.onNo()
						System = var_4_10000

						if var_4_10000.IO.File.Exists(arg_10_0.recordFilePath) then
							System = var_0

							var_0.IO.File.Delete(arg_10_0.recordFilePath)
						end

						return
					end

					function var_27_2.onYes()
						YSNormalTool = var_4_10000

						var_4_10000.MediaTool.SaveVideoToAlbum(arg_10_0.recordFilePath, function(arg_30_0, arg_30_1)
							if arg_30_0 then
								pg = var_5_10002

								local var_30_0 = var_5_10002.TipsMgr.GetInstance()
								local var_30_1 = var_2.ShowTips

								i18n = var_5_10004

								var_30_1(var_30_0, var_5_10004("word_save_ok"))

								System = var_30_1

								if var_30_1.IO.File.Exists(arg_10_0.recordFilePath) then
									System = var_2

									var_2.IO.File.Delete(arg_10_0.recordFilePath)
								end
							end

							return
						end)

						return
					end

					var_27_1(var_27_0, var_27_2)
				end
			end

			return
		end

		LeanTween = var_2_10001

		local var_26_1 = var_2_10001.isTweening

		go = var_2_10002

		if not var_26_1(var_2_10002(arg_10_0.stopRecBtn)) then
			LeanTween = var_1

			local var_26_2 = var_1.moveX(arg_10_0.stopRecBtn, arg_10_0.stopRecBtn.rect.width, 0.15)
			local var_26_3 = var_1.setOnComplete

			System = var_3

			var_26_3(var_26_2, var_3.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_10_0.ui, true)

				setActive = var_3_10000

				var_3_10000(arg_10_0.stopRecBtn, false)

				YSNormalTool = var_3_10000

				var_3_10000.RecordTool.StopRecording(var_26_0)

				local var_31_0 = arg_10_0

				var_0.SetMute(var_31_0, false)

				return
			end))
		end

		return
	end)

	setActive = var_2

	var_2(arg_10_0.stopRecBtn, false)

	onButton = var_2

	var_2(arg_10_0, arg_10_0.switchCamBtn, function()
		arg_10_0.isFlipping = not arg_10_0.isFlipping

		local var_32_0 = arg_10_0.webcam

		var_0.SwitchCam(var_32_0)

		local var_32_1 = arg_10_0

		var_0.updateCameraCanvas(var_32_1)

		return
	end)

	onButton = var_2

	var_2(arg_10_0, arg_10_0.selectCharBtn, function()
		local var_33_0 = arg_10_0

		var_0.emit(var_33_0, var_0_1.SELECT_CHAR_PANEL)

		return
	end)

	local var_10_1 = arg_10_0.webcam

	function var_10_1.takeCallback(arg_34_0)
		setActive = var_2_10001

		var_2_10001(arg_10_0.ui, true)

		return
	end

	onButton = var_10_1

	var_10_1(arg_10_0, arg_10_0.l2dStopBtnGo, function()
		arg_10_0.isPause = true

		local var_35_0 = arg_10_0

		var_0.UpdateL2dPlayState(var_35_0)

		return
	end)

	onButton = var_10_1

	var_10_1(arg_10_0, arg_10_0.l2dPlayBtnGo, function()
		arg_10_0.isPause = false

		local var_36_0 = arg_10_0

		var_0.UpdateL2dPlayState(var_36_0)

		return
	end)

	onButton = var_10_1

	var_10_1(arg_10_0, arg_10_0.l2dAnimationBtnGo, function()
		local var_37_0 = arg_10_0

		var_0.setLive2dAnimsPanelState(var_37_0, true)

		return
	end)

	onButton = var_10_1

	var_10_1(arg_10_0, arg_10_0.l2dAnimationBackBtnTrans, function()
		local var_38_0 = arg_10_0

		var_0.setLive2dAnimsPanelState(var_38_0, false)

		return
	end)

	cameraPaintViewAdjust = var_10_1

	var_10_1(true)
	arg_10_0:updateCameraCanvas()
	arg_10_0:updateShowType()

	return
end

function var_0_1.changeToTakeVideo(arg_39_0)
	if arg_39_0.state == var_0_1.STATE_TAKE_VIDEO then
		return
	end

	arg_39_0.state = var_0_1.STATE_TAKE_VIDEO
	LeanTween = var_1

	local var_39_0 = var_1.moveY

	rtf = var_2

	var_39_0(var_2(arg_39_0.modePnlTF), -56, 0.1)

	SetActive = var_39_0

	var_39_0(arg_39_0.videoTakeImg, true)

	return
end

function var_0_1.willExit(arg_40_0)
	arg_40_0:SetDummyForIOS(false)

	cameraPaintViewAdjust = var_1

	var_1(false)

	local var_40_0 = arg_40_0

	arg_40_0.clearSkin(var_40_0)

	PlayerPrefs = var_1

	local var_40_1 = var_1.GetInt

	SHOW_TOUCH_EFFECT = var_40_0

	local var_40_2 = var_40_1(var_40_0, 1)
	local var_40_3 = 0 < var_40_2

	setActive = var_2
	pg = var_3

	var_2(var_3.UIMgr.GetInstance().OverlayEffect, var_40_3)

	return
end

function var_0_1.clearSkin(arg_41_0)
	if arg_41_0.paintSkin and arg_41_0.showType == var_0_1.SHOW_PAINT then
		retPaintingPrefab = var_1

		var_1(arg_41_0.paint, arg_41_0.paintSkin)
	end

	if arg_41_0.spineSkin and arg_41_0.showType == var_0_1.SHOW_SPINE and arg_41_0.spineChar then
		local var_41_0 = arg_41_0.spineChar

		var_1.Dispose(var_41_0)

		arg_41_0.spineChar = nil
	end

	if arg_41_0.live2dCom then
		arg_41_0.live2dCom.FinishAction = nil
		arg_41_0.live2dCom.EventAction = nil
	end

	if arg_41_0.live2dCom and arg_41_0.showType == var_0_1.SHOW_LIVE2D then
		Destroy = var_1

		var_1(arg_41_0.live2dCom.gameObject)

		arg_41_0.live2dCom = nil
	end

	if arg_41_0.live2dRequestId then
		pg = var_1

		local var_41_1 = var_1.Live2DMgr.GetInstance()

		var_1.StopLoadingLive2d(var_41_1, arg_41_0.live2dRequestId)

		arg_41_0.live2dRequestId = nil
	end

	return
end

function var_0_1.checkSkin(arg_42_0, arg_42_1)
	pg = var_1_10002

	local var_42_0 = var_1_10002.ship_skin_template[arg_42_1]

	assert = var_1_10003

	var_1_10003(arg_42_1 == -1 or var_42_0, "invalid skin id " .. arg_42_1)

	arg_42_0.skin = var_42_0

	local var_42_1 = false

	if arg_42_0.contextData.tbId then
		pg = var_4

		local var_42_2

		if not var_4.secretary_special_ship[arg_42_0.contextData.tbId].prefab then
			var_42_2 = "tbniang"
		end

		arg_42_0.paintSkin = var_42_2
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

function var_0_1.setSkinAndLive2d(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:checkSkin(arg_43_1)

	if arg_43_0.showType ~= var_0_1.SHOW_LIVE2D and arg_43_2 then
		arg_43_0.showType = var_0_1.SHOW_LIVE2D

		arg_43_0:updateShowType()

		var_43_0 = true
	end

	if var_43_0 then
		arg_43_0:updateSkin()
	end

	return
end

function var_0_1.setSkin(arg_44_0, arg_44_1)
	if arg_44_0:checkSkin(arg_44_1) then
		arg_44_0:updateSkin()
	end

	return
end

function var_0_1.setLive2d(arg_45_0, arg_45_1)
	if arg_45_0.showType ~= var_0_1.SHOW_LIVE2D and arg_45_1 then
		arg_45_0:clearSkin()

		arg_45_0.showType = var_0_1.SHOW_LIVE2D

		arg_45_0:updateShowType()
		arg_45_0:updateSkin()
	end

	return
end

function var_0_1.updateShowType(arg_46_0)
	setActive = var_1_10001

	var_1_10001(arg_46_0.paintBtn, false)
	arg_46_0:setLive2dAnimsPanelState(false)

	setActive = var_1

	var_1(arg_46_0.live2dBtn, false)

	setActive = var_1

	var_1(arg_46_0.l2dCtrlPanl, false)

	setActive = var_1

	var_1(arg_46_0.spineBtn, false)

	if arg_46_0.showType == var_0_1.SHOW_PAINT then
		setActive = var_1

		var_1(arg_46_0.paintBtn, true)
	elseif arg_46_0.showType == var_0_1.SHOW_LIVE2D then
		setActive = var_1

		var_1(arg_46_0.live2dBtn, true)

		SetActive = var_1

		var_1(arg_46_0.l2dCtrlPanl, true)
	elseif arg_46_0.showType == var_0_1.SHOW_SPINE then
		setActive = var_1

		var_1(arg_46_0.spineBtn, true)
	end

	return
end

local function var_0_2(arg_47_0)
	if arg_47_0 == var_0_1.SHOW_PAINT then
		return 0.5, 2
	elseif arg_47_0 == var_0_1.SHOW_LIVE2D then
		return 0.5, 2
	elseif arg_47_0 == var_0_1.SHOW_SPINE then
		return 0.5, 4
	end

	return
end

function var_0_1.updateSkin(arg_48_0)
	if arg_48_0.showType == var_0_1.SHOW_LIVE2D then
		ResourceMgr = var_1

		local var_48_0 = var_1.Inst

		if var_1.AssetExist(var_48_0, "live2d/" .. arg_48_0.paintSkin) then
			checkABExist = var_1

			if not var_1("live2d/" .. arg_48_0.paintSkin) then
				arg_48_0.showType = var_0_1.SHOW_PAINT

				arg_48_0:updateShowType()
			end

			local var_48_1 = arg_48_0.paint
			local var_48_2 = var_1.GetComponent

			typeof = var_1_10003
			Zoom = var_1_10004

			local var_48_3 = var_48_2(var_48_1, var_1_10003(var_1_10004))
			local var_48_4 = 0
			local var_48_5 = 0
			local var_48_6, var_48_7 = var_0_2(arg_48_0.showType)
			local var_48_8 = var_48_7

			var_48_3.minZoom, var_48_3.maxZoom = var_48_6, var_48_8

			if var_48_8 < arg_48_0.paint.localScale.x then
				local var_48_9 = arg_48_0.paint

				Vector3 = var_48_7
				var_48_9.localScale = var_48_7(var_48_8, var_48_8, var_48_8)
			elseif var_2 > arg_48_0.paint.localScale.x then
				local var_48_10 = arg_48_0.paint

				Vector3 = var_48_7
				var_48_10.localScale = var_48_7(var_2, var_2, var_2)
			end

			if arg_48_0.showType == var_0_1.SHOW_LIVE2D then
				pg = var_4

				local var_48_11 = var_4.UIMgr.GetInstance()

				var_4.LoadingOn(var_48_11)

				pg = var_4

				local var_48_12 = var_4.Live2DMgr.GetInstance()

				arg_48_0.live2dRequestId = var_4.GetLive2DModelAsync(var_48_12, arg_48_0.paintSkin, function(arg_49_0)
					HotfixHelper = var_2_10001

					local var_49_0 = var_2_10001.SetLayerRecursively
					local var_49_1 = arg_49_0

					LayerMask = var_2_10003

					var_49_0(var_49_1, var_2_10003.NameToLayer("UI"))

					local var_49_2 = arg_49_0.transform

					var_1.SetParent(var_49_2, arg_48_0.live2d, true)

					if arg_48_0.skin.live2d_offset and #arg_48_0.skin.live2d_offset >= 4 then
						Vector3 = var_2
						var_1.localScale = var_2(arg_48_0.skin.live2d_offset[4], arg_48_0.skin.live2d_offset[4], arg_48_0.skin.live2d_offset[4])
					else
						Vector3 = var_2
						var_1.localScale = var_2(52, 52, 52)
					end

					Vector3 = var_2
					var_1.localPosition = var_2(arg_48_0.skin.live2d_offset[1] + 500, arg_48_0.skin.live2d_offset[2], arg_48_0.skin.live2d_offset[3])

					local var_49_3 = arg_49_0
					local var_49_4 = arg_49_0.GetComponent

					typeof = var_4
					Live2dChar = var_5

					local var_49_5 = var_49_4(var_49_3, var_4(var_5))

					pg = var_49_3

					local var_49_6 = var_49_3.AssistantInfo.action2Id.idle

					var_49_5:SetAction(var_49_6)

					function var_49_5.FinishAction(arg_50_0)
						if arg_48_0.selectedID then
							local var_50_0 = arg_48_0.selectedID

							pg = var_3_10002

							if var_50_0 ~= var_3_10002.AssistantInfo.action2Id.idle then
								local var_50_1 = arg_48_0

								var_1.setL2dAction(var_50_1, arg_48_0.selectedID)
							end
						end

						return
					end

					Live2DPainting = var_4

					local var_49_7 = var_4.SetL2dSortingLayer
					local var_49_8 = arg_49_0

					LayerWeightConst = var_6

					var_49_7(var_49_8, var_6.L2D_DEFAULT_LAYER)

					arg_48_0.live2dCom = var_49_5
					arg_48_0.live2dCom.name = arg_48_0.paintSkin

					local var_49_9 = arg_48_0

					pg = var_5
					var_49_9.playActionId = var_5.AssistantInfo.action2Id.idle

					local var_49_10 = arg_48_0

					pg = var_5
					var_49_10.selectedID = var_5.AssistantInfo.action2Id.idle

					local var_49_11 = arg_48_0
					local var_49_12 = arg_49_0
					local var_49_13 = arg_49_0.GetComponent

					typeof = var_2_10007
					Animator = var_2_10008
					var_49_11.live2dAnimator = var_49_13(var_49_12, var_2_10007(var_2_10008))

					local var_49_14 = arg_48_0.live2dCom

					if var_4.GetCubismParameter(var_49_14, "Paramring") then
						if arg_48_0.contextData and arg_48_0.contextData.propose then
							local var_49_15 = arg_48_0.live2dCom
							local var_49_16 = var_5.AddParameterValue
							local var_49_17 = var_4
							local var_49_18 = 1

							CubismParameterBlendMode = var_2_10009

							var_49_16(var_49_15, var_49_17, var_49_18, var_2_10009.Override)
						else
							local var_49_19 = arg_48_0.live2dCom
							local var_49_20 = var_5.AddParameterValue
							local var_49_21 = var_4
							local var_49_22 = 0

							CubismParameterBlendMode = var_2_10009

							var_49_20(var_49_19, var_49_21, var_49_22, var_2_10009.Override)
						end
					end

					local var_49_23 = arg_48_0

					var_5.ResetL2dPanel(var_49_23)

					local var_49_24 = arg_48_0

					var_5.setLive2dAnimsPanelState(var_49_24, true)

					SetActive = var_5

					var_5(arg_48_0.spine, false)

					SetActive = var_5

					var_5(arg_48_0.live2d, true)

					pg = var_5

					local var_49_25 = var_5.UIMgr.GetInstance()

					var_5.LoadingOff(var_49_25)

					local var_49_26 = arg_48_0.skin.lip_sync_gain
					local var_49_27 = arg_48_0.skin.lip_smoothing

					if var_49_26 and var_49_26 ~= 0 then
						local var_49_28 = arg_48_0.live2d
						local var_49_29 = var_7.GetChild(var_49_28, 0)

						var_7.GetComponent(var_49_29, "CubismCriSrcMouthInput").Gain = var_49_26
					end

					if var_49_27 and var_49_27 ~= 0 then
						local var_49_30 = arg_48_0.live2d
						local var_49_31 = var_7.GetChild(var_49_30, 0)

						var_7.GetComponent(var_49_31, "CubismCriSrcMouthInput").Smoothing = var_49_27
					end

					return
				end)
			elseif arg_48_0.showType == var_0_1.SHOW_PAINT then
				SetActive = var_4

				var_4(arg_48_0.live2d, false)

				SetActive = var_4

				var_4(arg_48_0.spine, false)

				setPaintingPrefabAsync = var_4

				var_4(arg_48_0.paint, arg_48_0.paintSkin, "mainNormal")
			elseif arg_48_0.showType == var_0_1.SHOW_SPINE then
				SetActive = var_4

				var_4(arg_48_0.live2d, false)

				SetActive = var_4

				var_4(arg_48_0.spine, true)

				SpineAnimChar = var_4
				arg_48_0.spineChar = var_4.New()

				local var_48_13 = arg_48_0.spineChar

				var_4.SetPaint(var_48_13, arg_48_0.spineSkin)

				local var_48_14 = arg_48_0.spineChar

				var_4.Load(var_48_14, true, function(arg_51_0)
					arg_51_0:SetName("model")
					arg_51_0:SetParent(arg_48_0.spine, true)

					local var_51_0 = arg_51_0
					local var_51_1 = arg_51_0.SetLocalScale

					Vector3 = var_3

					var_51_1(var_51_0, var_3(0.5, 0.5, 0.5))

					local var_51_2 = arg_51_0
					local var_51_3 = arg_51_0.SetLocalPosition

					Vector3 = var_3

					var_51_3(var_51_2, var_3.zero)

					local var_51_4 = arg_48_0

					var_1.playAction(var_51_4, "normal")

					return
				end)
			end

			return
		end
	end
end

function var_0_1.playAction(arg_52_0, arg_52_1)
	if arg_52_0.showType ~= var_0_1.SHOW_SPINE then
		return
	end

	if arg_52_0.spineChar then
		local var_52_0 = arg_52_0.spineChar

		var_2.SetAction(var_52_0, arg_52_1, 0)
	end

	return
end

function var_0_1.ResetL2dPanel(arg_53_0)
	pg = var_1_10001
	arg_53_0.selectedID = var_1_10001.AssistantInfo.action2Id.idle
	arg_53_0.isPause = false

	arg_53_0:UpdateL2dPlayState(true)
	arg_53_0:updateSelectedItem()

	return
end

function var_0_1.UpdateL2dPlayState(arg_54_0, arg_54_1)
	if arg_54_0.showType ~= var_0_1.SHOW_LIVE2D then
		return
	end

	if arg_54_0.isPause then
		SetActive = var_2

		var_2(arg_54_0.l2dStopBtnGo, false)

		SetActive = var_2

		var_2(arg_54_0.l2dPlayBtnGo, true)
	else
		SetActive = var_2

		var_2(arg_54_0.l2dStopBtnGo, true)

		SetActive = var_2

		var_2(arg_54_0.l2dPlayBtnGo, false)
	end

	if not arg_54_1 then
		arg_54_0:L2dAnimationState()
	end

	return
end

function var_0_1.L2dAnimationState(arg_55_0)
	if arg_55_0.showType ~= var_0_1.SHOW_LIVE2D then
		return
	end

	if arg_55_0.isPause then
		arg_55_0.live2dAnimator.speed = 0
	else
		arg_55_0.live2dAnimator.speed = 1
	end

	return
end

function var_0_1.updateLive2dAnimationPanel(arg_56_0)
	SetActive = var_1_10001

	var_1_10001(arg_56_0.l2dAnimations, arg_56_0.isShowL2dAnims)

	SetActive = var_1_10001

	var_1_10001(arg_56_0.l2dAnimationBtnGo, not arg_56_0.isShowL2dAnims)

	if arg_56_0.isShowL2dAnims and #arg_56_0.l2dAnims > 1 then
		local var_56_0 = arg_56_0.animContainer

		var_1.SetTotalCount(var_56_0, #arg_56_0.l2dAnims, 0)
	end

	return
end

function var_0_1.setLive2dAnimsPanelState(arg_57_0, arg_57_1)
	arg_57_0.isShowL2dAnims = arg_57_1

	arg_57_0:updateLive2dAnimationPanel()

	return
end

local var_0_3 = 3

function var_0_1.onInitItem(arg_58_0, arg_58_1)
	SnapshotItem = var_1_10002

	local var_58_0 = var_1_10002.New(arg_58_1, false)

	onButton = var_3

	local var_58_1 = arg_58_0
	local var_58_2 = var_58_0.go

	local function var_58_3()
		if arg_58_0.l2dClickCD then
			Time = var_0

			if var_0.fixedTime - arg_58_0.l2dClickCD < var_0_3 then
				return
			end
		end

		local var_59_0 = arg_58_0.selectedID
		local var_59_1 = var_58_0

		if var_59_0 == var_1.GetID(var_59_1) then
			return
		end

		local var_59_2 = var_58_0

		if var_0.GetID(var_59_2) ~= 6 then
			var_59_2 = var_58_0

			if var_0.GetID(var_59_2) == 7 then
				local var_59_3 = arg_58_0

				Time = var_59_2
				var_59_3.l2dClickCD = var_59_2.fixedTime
			end

			local var_59_4 = arg_58_0
			local var_59_5 = var_58_0

			var_59_4.selectedID = var_1.GetID(var_59_5)

			local var_59_6 = arg_58_0

			var_0.updateSelectedItem(var_59_6)

			local var_59_7 = arg_58_0

			var_0.setL2dAction(var_59_7, arg_58_0.selectedID)

			return
		end
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_58_1, var_58_2, var_58_3, var_1_10007)

	arg_58_0.scrollItems[arg_58_1] = var_58_0

	return
end

function var_0_1.setL2dAction(arg_60_0, arg_60_1)
	pg = var_1_10002

	if arg_60_1 ~= var_1_10002.AssistantInfo.action2Id.idle then
		-- block empty
	end

	if arg_60_0.live2dCom and arg_60_1 then
		pg = var_2

		if arg_60_1 == var_2.AssistantInfo.action2Id.idle then
			var_1_10003 = arg_60_0.live2dCom

			var_2.SetAction(var_1_10003, arg_60_1)
		else
			local var_60_0 = arg_60_0.playActionId

			pg = var_1_10003

			if var_60_0 == var_1_10003.AssistantInfo.action2Id.idle then
				local var_60_1 = arg_60_0.live2dCom

				var_2.SetAction(var_60_1, arg_60_1)
			elseif arg_60_0.playActionId == arg_60_1 then
				local var_60_2 = arg_60_0.live2dCom

				var_2.SetAction(var_60_2, arg_60_1)
			end
		end

		arg_60_0.playActionId = arg_60_1
	end

	return
end

function var_0_1.onUpdateItem(arg_61_0, arg_61_1, arg_61_2)
	arg_61_1 = arg_61_1 + 1

	local var_61_0

	if not arg_61_0.scrollItems[arg_61_2] then
		var_1_10005 = arg_61_0

		arg_61_0.onInitItem(var_1_10005, arg_61_2)

		var_61_0 = arg_61_0.scrollItems[arg_61_2]
	end

	local var_61_1 = arg_61_0.l2dAnims[arg_61_1]

	pg = var_1_10005

	local var_61_2 = var_1_10005.AssistantInfo.action2Id[var_61_1]
	local var_61_3 = {
		id = var_61_2
	}

	i18n = var_1_10007
	var_61_3.name = var_1_10007(var_61_1)

	var_61_0:Update(var_61_3)

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

function var_0_1.onReturnItem(arg_62_0, arg_62_1, arg_62_2)
	return
end

function var_0_1.updateSelectedItem(arg_63_0)
	pairs = var_1_10001

	for iter_63_0, iter_63_1 in var_1_10001(arg_63_0.scrollItems) do
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

function var_0_1.updateUIDirection(arg_64_0)
	if arg_64_0.isVertical then
		local var_64_0 = arg_64_0.verticalEulerAngle
		local var_64_1 = arg_64_0.rotateUseTime

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.backBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.selectCharBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.switchCamBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.l2dBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.l2dStopBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.l2dPlayBtnImg), var_64_0, var_64_1)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.l2d2PaintBtnImg), var_64_0, var_64_1)

		SetActive = var_1_10003

		var_1_10003(arg_64_0.takePhotoVerticalText, false)

		SetActive = var_1_10003

		var_1_10003(arg_64_0.takePhotoHorizontalText, true)

		SetActive = var_1_10003

		var_1_10003(arg_64_0.takeVideoVerticalText, false)

		SetActive = var_1_10003

		var_1_10003(arg_64_0.takeVideoHorizontalText, true)

		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.rotateZ
		go = var_1_10004

		var_1_10003(var_1_10004(arg_64_0.paint), var_64_0, var_64_1)

		var_1_10004 = arg_64_0

		arg_64_0.updateListItemRotate(var_1_10004, var_64_0, var_64_1)
	else
		local var_64_2 = arg_64_0.horizontalEulerAngle
		local var_64_3 = arg_64_0.rotateUseTime

		LeanTween = var_1_10003

		local var_64_4 = var_1_10003.rotateZ

		go = var_1_10004

		var_64_4(var_1_10004(arg_64_0.backBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_4

		local var_64_5 = var_64_4.rotateZ

		go = var_4

		var_64_5(var_4(arg_64_0.selectCharBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_5

		local var_64_6 = var_64_5.rotateZ

		go = var_4

		var_64_6(var_4(arg_64_0.switchCamBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_6

		local var_64_7 = var_64_6.rotateZ

		go = var_4

		var_64_7(var_4(arg_64_0.l2dBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_7

		local var_64_8 = var_64_7.rotateZ

		go = var_4

		var_64_8(var_4(arg_64_0.l2dStopBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_8

		local var_64_9 = var_64_8.rotateZ

		go = var_4

		var_64_9(var_4(arg_64_0.l2dPlayBtnImg), var_64_2, var_64_3)

		LeanTween = var_64_9

		local var_64_10 = var_64_9.rotateZ

		go = var_4

		var_64_10(var_4(arg_64_0.l2d2PaintBtnImg), var_64_2, var_64_3)

		SetActive = var_64_10

		var_64_10(arg_64_0.takePhotoVerticalText, true)

		SetActive = var_64_10

		var_64_10(arg_64_0.takePhotoHorizontalText, false)

		SetActive = var_64_10

		var_64_10(arg_64_0.takeVideoVerticalText, true)

		SetActive = var_64_10

		var_64_10(arg_64_0.takeVideoHorizontalText, false)

		LeanTween = var_64_10

		local var_64_11 = var_64_10.rotateZ

		go = var_4

		var_64_11(var_4(arg_64_0.paint), var_64_2, var_64_3)
		arg_64_0:updateListItemRotate(var_64_2, var_64_3)
	end

	return
end

function var_0_1.updateListItemRotate(arg_65_0, arg_65_1, arg_65_2)
	pairs = var_1_10003

	for iter_65_0, iter_65_1 in var_1_10003(arg_65_0.scrollItems) do
		iter_65_1:RotateUI(arg_65_1, arg_65_2)
	end

	return
end

function var_0_1.updateCameraCanvas(arg_66_0)
	pg = var_1_10001

	local var_66_0 = var_1_10001.CameraFixMgr.GetInstance().targetRatio

	UnityEngine = var_1_10002

	local var_66_1 = var_1_10002.Screen.width

	UnityEngine = var_1_10003

	local var_66_2 = var_1_10003.Screen.height
	local var_66_3 = 1

	if var_66_1 / var_66_2 < var_66_0 then
		var_66_3 = var_66_0 / var_5
	elseif var_66_0 < var_5 then
		var_66_3 = var_5 / var_66_0
	end

	if arg_66_0.isFlipping then
		local var_66_4 = arg_66_0.snapshot

		Vector3 = var_1_10007
		var_66_4.localScale = var_1_10007(-var_66_3, var_66_3, 1)
	else
		local var_66_5 = arg_66_0.snapshot

		Vector3 = var_1_10007
		var_66_5.localScale = var_1_10007(var_66_3, var_66_3, 1)
	end

	return
end

function var_0_1.SetDummyForIOS(arg_67_0, arg_67_1)
	PLATFORM = var_1_10002
	PLATFORM_IPHONEPLAYER = var_1_10003

	if var_1_10002 ~= var_1_10003 then
		setActive = var_1_10002

		var_1_10002(arg_67_0.dummy, false)

		return
	end

	pg = var_1_10002

	local var_67_0 = var_1_10002.UIMgr.GetInstance()
	local var_67_1 = var_2.GetMainCamera(var_67_0)
	local var_67_2 = var_2.GetComponent

	typeof = var_1_10004
	Camera = var_1_10005

	local var_67_3 = var_67_2(var_67_1, var_1_10004(var_1_10005))

	if arg_67_1 then
		var_67_3.nearClipPlane = 0

		local var_67_4 = arg_67_0.dummy
		local var_67_5 = var_3.SetParent

		pg = var_1_10005

		local var_67_6 = var_1_10005.UIMgr.GetInstance()

		var_67_5(var_67_4, var_5.GetMainCamera(var_67_6).transform)

		local var_67_7 = arg_67_0.dummy

		Vector3 = var_67_4
		var_67_7.localPosition = var_67_4(0, 0, 3)

		local var_67_8 = arg_67_0.dummy

		Vector3 = var_4
		var_67_8.localRotation = var_4(0, 0, 0)

		local var_67_9 = arg_67_0.dummy

		Vector3 = var_4
		var_67_9.localScale = var_4(1, 1, 1)
		setActive = var_67_9

		var_67_9(arg_67_0.dummy, true)
	else
		var_67_3.nearClipPlane = -100

		local var_67_10 = arg_67_0.dummy

		var_3.SetParent(var_67_10, arg_67_0._tf)

		local var_67_11 = arg_67_0.dummy

		Vector3 = var_67_10
		var_67_11.localPosition = var_67_10(0, 0, 0)

		local var_67_12 = arg_67_0.dummy

		Vector3 = var_4
		var_67_12.localRotation = var_4(0, 0, 0)

		local var_67_13 = arg_67_0.dummy

		Vector3 = var_4
		var_67_13.localScale = var_4(1, 1, 1)
	end

	return
end

function var_0_1.SetMute(arg_68_0, arg_68_1)
	if arg_68_1 then
		pg = var_1_10002

		local var_68_0 = var_1_10002.CriMgr.GetInstance()

		var_1_10002.MuteAllVolume(var_68_0)
	else
		pg = var_1_10002

		local var_68_1 = var_1_10002.CriMgr.GetInstance()

		var_2.ResetAllVolume(var_68_1)
	end

	return
end

return var_0_1
