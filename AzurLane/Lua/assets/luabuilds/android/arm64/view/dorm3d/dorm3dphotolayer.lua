class = var_0_10000

local var_0_0 = "Dorm3dPhotoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dPhotoUI"
end

local var_0_2 = {
	"/OverlayCamera/Overlay/UIOverlay/TipPanel(Clone)"
}

var_0_1.PANEL = {
	ACTION = 1,
	LIGHTING = 3,
	CAMERA = 2
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.centerPanel = var_1.Find(var_2_0, "Center")

	local var_2_1 = arg_2_0._tf

	arg_2_0.normalPanel = var_1.Find(var_2_1, "Center/Normal")
	setActive = var_1

	var_1(arg_2_0.normalPanel, true)

	local var_2_2 = arg_2_0._tf

	arg_2_0.settingPanel = var_1.Find(var_2_2, "Center/Settings")

	local var_2_3 = arg_2_0.settingPanel

	arg_2_0.btnAction = var_1.Find(var_2_3, "Action")

	local var_2_4 = arg_2_0.settingPanel

	arg_2_0.btnCamera = var_1.Find(var_2_4, "Camera")

	local var_2_5 = arg_2_0.settingPanel

	arg_2_0.btnLighting = var_1.Find(var_2_5, "Lighting")

	local var_2_6 = arg_2_0.settingPanel

	arg_2_0.panelAction = var_1.Find(var_2_6, "ActionSelect")
	setActive = var_1

	var_1(arg_2_0.panelAction, false)

	setActive = var_1

	local var_2_7 = arg_2_0.panelAction

	var_1(var_3.Find(var_2_7, "Mask"), false)

	local var_2_8 = arg_2_0.settingPanel

	arg_2_0.panelCamera = var_1.Find(var_2_8, "CameraSettings")
	setActive = var_1

	var_1(arg_2_0.panelCamera, false)

	local var_2_9 = arg_2_0.settingPanel

	arg_2_0.panelLightning = var_1.Find(var_2_9, "LightningSettings")
	setActive = var_1

	var_1(arg_2_0.panelLightning, false)

	local var_2_10 = arg_2_0._tf

	arg_2_0.listZones = var_1.Find(var_2_10, "ZoneList")
	setActive = var_1

	var_1(arg_2_0.listZones, false)

	local var_2_11 = arg_2_0.listZones

	arg_2_0.zoneMask = var_1.Find(var_2_11, "Mask")

	local var_2_12 = arg_2_0._tf

	arg_2_0.btnHideUI = var_1.Find(var_2_12, "Center/HideUI")

	local var_2_13 = arg_2_0._tf

	arg_2_0.btnReset = var_1.Find(var_2_13, "Center/Reset")

	local var_2_14 = arg_2_0._tf

	arg_2_0.btnFreeze = var_1.Find(var_2_14, "Center/Freeze")

	local var_2_15 = arg_2_0._tf

	arg_2_0.btnMove = var_1.Find(var_2_15, "Center/Move")

	local var_2_16 = arg_2_0._tf

	arg_2_0.btnZone = var_1.Find(var_2_16, "Center/Zone")

	local var_2_17 = arg_2_0._tf

	arg_2_0.btnAr = var_1.Find(var_2_17, "Center/Ar")
	GetComponent = var_1
	arg_2_0.ARchecker = var_1(arg_2_0.btnAr.gameObject, "ARChecker")

	local var_2_18 = arg_2_0._tf

	arg_2_0.btnAnimSpeed = var_1.Find(var_2_18, "Center/AnimSpeed")

	local var_2_19 = arg_2_0.btnAnimSpeed

	arg_2_0.listAnimSpeed = var_1.Find(var_2_19, "Bar")
	setActive = var_1

	var_1(arg_2_0.listAnimSpeed, false)

	local var_2_20 = arg_2_0.btnAnimSpeed

	arg_2_0.textAnimSpeed = var_1.Find(var_2_20, "Text")

	local var_2_21 = arg_2_0._tf

	arg_2_0.hideuiMask = var_1.Find(var_2_21, "RightTop/Mask")
	setActive = var_1

	var_1(arg_2_0.hideuiMask, false)

	local var_2_22 = arg_2_0._tf

	arg_2_0.btnFilm = var_1.Find(var_2_22, "RightTop/Film/Film")

	local var_2_23 = arg_2_0._tf

	arg_2_0.filmTime = var_1.Find(var_2_23, "RightTop/FilmTime")
	setActive = var_1

	var_1(arg_2_0.filmTime, false)

	local var_2_24 = arg_2_0._tf

	arg_2_0.shareUI = var_1.Find(var_2_24, "ShareUI")
	setActive = var_1

	var_1(arg_2_0.shareUI, false)

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_1.Find(var_2_25, "Shoter")
	local var_2_27 = var_1.GetComponent

	typeof = var_4
	YSTool = var_6
	arg_2_0.ysScreenShoter = var_2_27(var_2_26, var_4(var_6.YSScreenShoter))

	local var_2_28 = arg_2_0._tf

	arg_2_0.btnMenuSmall = var_1.Find(var_2_28, "Center/MenuSmall")

	local var_2_29 = arg_2_0._tf

	arg_2_0.btnMenu = var_1.Find(var_2_29, "Center/Menu")

	local var_2_30 = arg_2_0.panelAction
	local var_2_31 = var_1.Find(var_2_30, "Layout/Regular/Index")

	setActive = var_1_10002

	var_1_10002(var_2_31, false)

	setText = var_1_10002

	local var_2_32 = arg_2_0.panelCamera
	local var_2_33 = var_4.Find(var_2_32, "Layout/DepthOfField/Title/Text")

	i18n = var_5

	var_1_10002(var_2_33, var_5("dorm3d_photo_len"))

	setText = var_1_10002

	local var_2_34 = arg_2_0.panelCamera
	local var_2_35 = var_4.Find(var_2_34, "Layout/DepthOfField/Switch/Title")

	i18n = var_5

	var_1_10002(var_2_35, var_5("dorm3d_photo_depthoffield"))

	setText = var_1_10002

	local var_2_36 = arg_2_0.panelCamera
	local var_2_37 = var_4.Find(var_2_36, "Layout/DepthOfField/DepthOfField/FocusDistance/Title")

	i18n = var_5

	var_1_10002(var_2_37, var_5("dorm3d_photo_focusdistance"))

	setText = var_1_10002

	local var_2_38 = arg_2_0.panelCamera
	local var_2_39 = var_4.Find(var_2_38, "Layout/DepthOfField/DepthOfField/BlurRadius/Title")

	i18n = var_5

	var_1_10002(var_2_39, var_5("dorm3d_photo_focusstrength"))

	setText = var_1_10002

	local var_2_40 = arg_2_0.panelCamera
	local var_2_41 = var_4.Find(var_2_40, "Layout/Paramaters/Title/Text")

	i18n = var_5

	var_1_10002(var_2_41, var_5("dorm3d_photo_paramaters"))

	setText = var_1_10002

	local var_2_42 = arg_2_0.panelCamera
	local var_2_43 = var_4.Find(var_2_42, "Layout/Paramaters/PostExposure/PostExposure/Title")

	i18n = var_5

	var_1_10002(var_2_43, var_5("dorm3d_photo_postexposure"))

	setText = var_1_10002

	local var_2_44 = arg_2_0.panelCamera
	local var_2_45 = var_4.Find(var_2_44, "Layout/Paramaters/Saturation/Saturation/Title")

	i18n = var_5

	var_1_10002(var_2_45, var_5("dorm3d_photo_saturation"))

	setText = var_1_10002

	local var_2_46 = arg_2_0.panelCamera
	local var_2_47 = var_4.Find(var_2_46, "Layout/Paramaters/Contrast/Contrast/Title")

	i18n = var_5

	var_1_10002(var_2_47, var_5("dorm3d_photo_contrast"))

	setText = var_1_10002

	local var_2_48 = arg_2_0.panelCamera
	local var_2_49 = var_4.Find(var_2_48, "Layout/Other/Title/Text")

	i18n = var_5

	var_1_10002(var_2_49, var_5("dorm3d_photo_Others"))

	setText = var_1_10002

	local var_2_50 = arg_2_0.panelCamera
	local var_2_51 = var_4.Find(var_2_50, "Layout/Other/HideCharacter/Title")

	i18n = var_5

	var_1_10002(var_2_51, var_5("dorm3d_photo_hidecharacter"))

	setText = var_1_10002

	local var_2_52 = arg_2_0.panelCamera
	local var_2_53 = var_4.Find(var_2_52, "Layout/Other/FaceCamera/Title")

	i18n = var_5

	var_1_10002(var_2_53, var_5("dorm3d_photo_facecamera"))

	setText = var_1_10002

	local var_2_54 = arg_2_0.panelLightning
	local var_2_55 = var_4.Find(var_2_54, "Layout/Title/Filter/Name")

	i18n = var_5

	var_1_10002(var_2_55, var_5("dorm3d_photo_filter"))

	setText = var_1_10002

	local var_2_56 = arg_2_0.panelLightning
	local var_2_57 = var_4.Find(var_2_56, "Layout/Title/Filter/Selected")

	i18n = var_5

	var_1_10002(var_2_57, var_5("dorm3d_photo_filter"))

	setText = var_1_10002

	local var_2_58 = arg_2_0.panelAction
	local var_2_59 = var_4.Find(var_2_58, "Layout/Title/Regular/Name")

	i18n = var_5

	var_1_10002(var_2_59, var_5("dorm3d_photo_regular_anim"))

	setText = var_1_10002

	local var_2_60 = arg_2_0.panelAction
	local var_2_61 = var_4.Find(var_2_60, "Layout/Title/Regular/Selected")

	i18n = var_5

	var_1_10002(var_2_61, var_5("dorm3d_photo_regular_anim"))

	setText = var_1_10002

	local var_2_62 = arg_2_0.panelAction
	local var_2_63 = var_4.Find(var_2_62, "Layout/Title/Special/Name")

	i18n = var_5

	var_1_10002(var_2_63, var_5("dorm3d_photo_special_anim"))

	setText = var_1_10002

	local var_2_64 = arg_2_0.panelAction
	local var_2_65 = var_4.Find(var_2_64, "Layout/Title/Special/Selected")

	i18n = var_5

	var_1_10002(var_2_65, var_5("dorm3d_photo_special_anim"))

	GameObject = var_1_10002

	local var_2_66 = var_1_10002.Find("BackYardMainCamera")
	local var_2_67 = var_2.GetComponent

	typeof = var_5
	Camera = var_7
	arg_2_0.mainCamera = var_2_67(var_2_66, var_5(var_7))

	local var_2_68 = arg_2_0._tf

	arg_2_0.stopRecBtn = var_2.Find(var_2_68, "stopRec")

	local var_2_69 = arg_2_0._tf

	arg_2_0.videoTipPanel = var_2.Find(var_2_69, "videoTipPanel")
	setActive = var_2

	var_2(arg_2_0.videoTipPanel, false)

	AutoLoader = var_2
	arg_2_0.loader = var_2.New()

	return
end

function var_0_1.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_1.SetRoom(arg_4_0, arg_4_1)
	arg_4_0.room = arg_4_1

	return
end

function var_0_1.SetGroupId(arg_5_0, arg_5_1)
	arg_5_0.groupId = arg_5_1

	return
end

function var_0_1.onBackPressed(arg_6_0)
	if arg_6_0.recordState then
		triggerButton = var_1

		var_1(arg_6_0.btnFilm)

		return
	end

	if arg_6_0.activeSetting then
		triggerButton = var_1

		local var_6_0 = arg_6_0._tf

		var_1(var_3.Find(var_6_0, "Center/Settings/Back"))

		return
	end

	arg_6_0:closeView()

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_4.Find(var_7_1, "Center/Normal/Back")

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.onBackPressed(var_8_0)

		return
	end

	SFX_CANCEL = var_7_1

	var_1_10001(var_7_0, var_7_2, var_7_3, var_7_1)

	local var_7_4 = arg_7_0.normalPanel
	local var_7_5 = var_1.Find(var_7_4, "Zoom/Slider")

	setSlider = var_1_10002

	var_1_10002(var_7_5, 0, 1, 0)

	onSlider = var_1_10002

	var_1_10002(arg_7_0, var_7_5, function(arg_9_0)
		local var_9_0 = arg_7_0.scene
		local var_9_1 = var_1.emit

		Dorm3dRoomTemplateScene = var_2_10004

		var_9_1(var_9_0, var_2_10004.PHOTO_CALL, "SetPhotoCameraHeight", arg_9_0)

		return
	end)

	setActive = var_1_10002

	var_1_10002(var_7_5, false)

	local var_7_6 = arg_7_0._tf
	local var_7_7 = var_2.Find(var_7_6, "Center/Stick")

	setActive = var_7_4

	var_7_4(var_7_7, false)

	arg_7_0.activeSetting = false
	onButton = var_3

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0._tf
	local var_7_10 = var_6.Find(var_7_9, "Center/Normal/Settings")

	local function var_7_11()
		local var_10_0 = arg_7_0

		var_10_0.activeSetting = true
		quickPlayAnimation = var_10_0

		local var_10_1 = arg_7_0._tf

		var_10_0(var_2.Find(var_10_1, "Center"), "anim_dorm3d_photo_normal_out")

		local var_10_2 = arg_7_0

		var_0.UpdateActionPanel(var_10_2)

		local var_10_3 = arg_7_0

		var_0.UpdateCameraPanel(var_10_3)

		local var_10_4 = arg_7_0

		var_0.UpdateLightingPanel(var_10_4)

		return
	end

	SFX_PANEL = var_7_9

	var_3(var_7_8, var_7_10, var_7_11, var_7_9)

	onButton = var_3

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0._tf
	local var_7_14 = var_6.Find(var_7_13, "Center/Settings/Back")

	local function var_7_15()
		local var_11_0 = arg_7_0

		var_11_0.activeSetting = false
		quickPlayAnimation = var_11_0

		local var_11_1 = arg_7_0._tf

		var_11_0(var_2.Find(var_11_1, "Center"), "anim_dorm3d_photo_normal_in")

		return
	end

	SFX_CANCEL = var_7_13

	var_3(var_7_12, var_7_14, var_7_15, var_7_13)

	arg_7_0.hideUI = false
	onButton = var_3

	local var_7_16 = arg_7_0
	local var_7_17 = arg_7_0.btnHideUI

	local function var_7_18()
		if arg_7_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_7_0.hideuiMask, true)

		setActive = var_0

		var_0(arg_7_0.centerPanel, false)

		arg_7_0.hideUI = true

		return
	end

	SFX_PANEL = var_7_13

	var_3(var_7_16, var_7_17, var_7_18, var_7_13)

	onButton = var_3

	var_3(arg_7_0, arg_7_0.hideuiMask, function()
		if not arg_7_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_7_0.centerPanel, true)

		setActive = var_0

		var_0(arg_7_0.hideuiMask, false)

		arg_7_0.hideUI = false

		return
	end)

	onButton = var_3

	local var_7_19 = arg_7_0
	local var_7_20 = arg_7_0.btnReset

	local function var_7_21()
		local var_14_0 = arg_7_0.scene
		local var_14_1 = var_0.emit

		Dorm3dRoomTemplateScene = var_2_10003

		var_14_1(var_14_0, var_2_10003.PHOTO_CALL, "ResetPhotoCameraPosition")

		return
	end

	SFX_PANEL = var_7_13

	var_3(var_7_19, var_7_20, var_7_21, var_7_13)

	arg_7_0.recordState = false
	onButton = var_3

	local var_7_22 = arg_7_0
	local var_7_23 = arg_7_0.btnFilm

	local function var_7_24()
		local function var_15_0(arg_16_0)
			setActive = var_3_10001

			var_3_10001(arg_7_0.centerPanel, arg_16_0)

			local var_16_0 = arg_7_0._tf
			local var_16_1 = var_1.Find(var_16_0, "RightTop")

			var_1.GetComponent(var_16_1, "CanvasGroup").alpha = arg_16_0 and 1 or 0

			return
		end

		if not arg_7_0.recordState then
			local function var_15_1(arg_17_0)
				if not arg_17_0 then
					var_15_0(true)

					local var_17_0 = arg_7_0

					var_17_0.recordState = false
					LeanTween = var_17_0

					var_17_0.moveX(arg_7_0.stopRecBtn, arg_7_0.stopRecBtn.rect.width, 0.15)
				else
					arg_7_0.recordState = true
				end

				return
			end

			local function var_15_2()
				setActive = var_3_10000

				var_3_10000(arg_7_0.stopRecBtn, true)

				LeanTween = var_3_10000

				local var_18_0 = var_3_10000.moveX(arg_7_0.stopRecBtn, 0, 0.15)
				local var_18_1 = var_0.setOnComplete

				System = var_3

				var_18_1(var_18_0, var_3.Action(function()
					var_0_1.SetMute(true)

					local var_19_0 = arg_7_0

					YSNormalTool = var_4_10001
					var_19_0.recordFilePath = var_4_10001.RecordTool.GenRecordFilePath()
					YSNormalTool = var_19_0

					var_19_0.RecordTool.StartRecording(var_15_1, arg_7_0.recordFilePath)

					return
				end))

				return
			end

			seriesAsync = var_2_10003

			var_2_10003({
				function(arg_20_0)
					PermissionHelper = var_3_10001

					var_3_10001.Request3DDorm(arg_20_0, nil)

					return
				end,
				function(arg_21_0)
					var_15_0(false)

					PlayerPrefs = var_1

					if not var_1.GetInt("hadShowForVideoTipDorm", 0) or var_1 <= 0 then
						PlayerPrefs = var_3_10002

						var_3_10002.SetInt("hadShowForVideoTipDorm", 1)

						local var_21_0 = arg_7_0.videoTipPanel
						local var_21_1 = var_2.Find(var_21_0, "Text")
						local var_21_2 = var_2.GetComponent(var_21_1, "Text")

						i18n = var_3
						var_21_2.text = var_3("word_take_video_tip")
						onButton = var_21_2

						var_21_2(arg_7_0, arg_7_0.videoTipPanel, function()
							setActive = var_4_10000

							var_4_10000(arg_7_0.videoTipPanel, false)
							var_15_2()

							return
						end)

						setActive = var_21_2

						var_21_2(arg_7_0.videoTipPanel, true)
					else
						var_15_2()
					end

					return
				end
			})
		end

		return
	end

	SFX_PANEL = var_7_13

	var_3(var_7_22, var_7_23, var_7_24, var_7_13)

	onButton = var_3

	var_3(arg_7_0, arg_7_0.stopRecBtn, function()
		arg_7_0.recordState = false

		local function var_23_0(arg_24_0)
			if arg_24_0 then
				PLATFORM = var_3_10001
				PLATFORM_ANDROID = var_3_10002

				if var_3_10001 == var_3_10002 then
					pg = var_3_10001

					local var_24_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_24_1 = var_1.ShowMsgBox
					local var_24_2 = {}

					i18n = var_3_10005
					var_24_2.content = var_3_10005("word_save_video")

					function var_24_2.onNo()
						System = var_4_10000

						if var_4_10000.IO.File.Exists(arg_7_0.recordFilePath) then
							System = var_0

							var_0.IO.File.Delete(arg_7_0.recordFilePath)
						end

						return
					end

					function var_24_2.onYes()
						YSNormalTool = var_4_10000

						var_4_10000.MediaTool.SaveVideoToAlbum(arg_7_0.recordFilePath, function(arg_27_0, arg_27_1)
							if arg_27_0 then
								pg = var_5_10002

								local var_27_0 = var_5_10002.TipsMgr.GetInstance()
								local var_27_1 = var_2.ShowTips

								i18n = var_5_10005

								var_27_1(var_27_0, var_5_10005("word_save_ok"))

								System = var_27_1

								if var_27_1.IO.File.Exists(arg_7_0.recordFilePath) then
									System = var_2

									var_2.IO.File.Delete(arg_7_0.recordFilePath)
								end
							end

							return
						end)

						return
					end

					var_24_1(var_24_0, var_24_2)
				end
			end

			arg_7_0.recordState = false

			return
		end

		local function var_23_1(arg_28_0)
			setActive = var_3_10001

			var_3_10001(arg_7_0.centerPanel, arg_28_0)

			local var_28_0 = arg_7_0._tf
			local var_28_1 = var_1.Find(var_28_0, "RightTop")

			var_1.GetComponent(var_28_1, "CanvasGroup").alpha = arg_28_0 and 1 or 0

			return
		end

		LeanTween = var_2_10002

		local var_23_2 = var_2_10002.isTweening

		go = var_2_10004

		if not var_23_2(var_2_10004(arg_7_0.stopRecBtn)) then
			LeanTween = var_2

			local var_23_3 = var_2.moveX(arg_7_0.stopRecBtn, arg_7_0.stopRecBtn.rect.width, 0.15)
			local var_23_4 = var_2.setOnComplete

			System = var_5

			var_23_4(var_23_3, var_5.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_7_0.stopRecBtn, false)

				seriesAsync = var_3_10000

				var_3_10000({
					function(arg_30_0)
						YSNormalTool = var_4_10001

						var_4_10001.RecordTool.StopRecording(var_23_0)
						var_23_1(true)
						var_0_1.SetMute(false)

						local var_30_0 = arg_7_0.room
						local var_30_1 = var_1.GetCameraZones(var_30_0)[arg_7_0.zoneIndex]

						Dorm3dCameraAnim = var_30_0

						local var_30_2 = var_30_0.New({
							configId = arg_7_0.animID
						})

						pg = var_4_10004

						local var_30_3 = var_4_10004.m02
						local var_30_4 = var_4.sendNotification

						GAME = var_4_10007

						local var_30_5 = var_4_10007.APARTMENT_TRACK

						Dorm3dTrackCommand = var_4_10008

						local var_30_6 = var_4_10008.BuildDataCamera
						local var_30_7 = arg_7_0.scene.apartment
						local var_30_8 = var_10.GetConfigID(var_30_7)
						local var_30_9 = 2
						local var_30_10 = arg_7_0.room
						local var_30_11 = var_12.GetConfigID(var_30_10)

						Dorm3dTrackCommand = var_4_10013

						var_30_4(var_30_3, var_30_5, var_30_6(var_30_8, var_30_9, var_30_11, var_4_10013.BuildCameraMsg(var_30_1:GetName(), var_30_2:GetStateName(), arg_7_0.cameraSettings.depthOfField.focusDistance.value, arg_7_0.cameraSettings.depthOfField.blurRadius.value, arg_7_0.cameraSettings.postExposure.value, arg_7_0.cameraSettings.contrast.value, arg_7_0.cameraSettings.saturate.value)))

						return
					end
				})

				return
			end))
		end

		return
	end)

	setActive = var_3

	var_3(arg_7_0.stopRecBtn, false)

	onButton = var_3

	local var_7_25 = arg_7_0
	local var_7_26 = arg_7_0._tf
	local var_7_27 = var_6.Find(var_7_26, "RightTop/Film/Switch")

	local function var_7_28()
		GetOrAddComponent = var_2_10000

		local var_31_0 = arg_7_0._tf
		local var_31_1 = var_2.Find(var_31_0, "RightTop/Film")

		typeof = var_2_10003
		CanvasGroup = var_5
		var_2_10000(var_31_1, var_2_10003(var_5)).blocksRaycasts = false
		quickPlayAnimation = var_1

		local var_31_2 = arg_7_0._tf

		var_1(var_3.Find(var_31_2, "RightTop"), "anim_dorm3d_photo_FtoS")

		return
	end

	SFX_PANEL = var_7_26

	var_3(var_7_25, var_7_27, var_7_28, var_7_26)

	onButton = var_3

	local var_7_29 = arg_7_0
	local var_7_30 = arg_7_0._tf

	var_3(var_7_29, var_6.Find(var_7_30, "RightTop/Shot/Shot"), function()
		local function var_32_0(arg_33_0)
			setActive = var_3_10001

			var_3_10001(arg_7_0.centerPanel, arg_33_0)

			setActive = var_3_10001

			local var_33_0 = arg_7_0._tf

			var_3_10001(var_3.Find(var_33_0, "RightTop"), arg_33_0)

			PlayerPrefs = var_3_10001

			local var_33_1 = var_3_10001.GetInt

			SHOW_TOUCH_EFFECT = var_3

			local var_33_2 = var_33_1(var_3, 1)

			if 0 < var_33_2 then
				setActive = var_2
				pg = var_4

				var_2(var_4.UIMgr.GetInstance().OverlayEffect, arg_33_0)
			end

			return
		end

		local function var_32_1(arg_34_0)
			warning = var_3_10001

			local var_34_0 = "截图结果："

			tostring = var_3_10004

			var_3_10001(var_34_0 .. var_3_10004(arg_34_0))

			return
		end

		local function var_32_2(arg_35_0, arg_35_1)
			local var_35_0 = arg_7_0
			local var_35_1 = var_2.emit

			Dorm3dPhotoMediator = var_3_10005

			var_35_1(var_35_0, var_3_10005.SHARE_PANEL, arg_35_1, arg_35_0)

			getProxy = var_35_1
			Dorm3dChatProxy = var_35_0

			local var_35_2 = var_35_1(var_35_0)
			local var_35_3 = var_2.TriggerEvent
			local var_35_4 = {}
			local var_35_5 = {
				value = 1,
				event_type = 160
			}
			local var_35_6 = arg_7_0.scene.apartment

			var_35_5.ship_id = var_7.GetConfigID(var_35_6)
			var_35_4[1] = var_35_5

			var_35_3(var_35_2, var_35_4)

			local var_35_7 = arg_7_0.room
			local var_35_8 = var_2.GetCameraZones(var_35_7)[arg_7_0.zoneIndex]

			Dorm3dCameraAnim = var_35_7

			local var_35_9 = var_35_7.New({
				configId = arg_7_0.animID
			})

			pg = var_35_4

			local var_35_10 = var_35_4.m02
			local var_35_11 = var_5.sendNotification

			GAME = var_3_10008

			local var_35_12 = var_3_10008.APARTMENT_TRACK

			Dorm3dTrackCommand = var_35_6

			local var_35_13 = var_35_6.BuildDataCamera
			local var_35_14 = arg_7_0.scene.apartment
			local var_35_15 = var_11.GetConfigID(var_35_14)
			local var_35_16 = 1
			local var_35_17 = arg_7_0.room
			local var_35_18 = var_13.GetConfigID(var_35_17)

			Dorm3dTrackCommand = var_3_10014

			var_35_11(var_35_10, var_35_12, var_35_13(var_35_15, var_35_16, var_35_18, var_3_10014.BuildCameraMsg(var_35_8:GetName(), var_35_9:GetStateName(), arg_7_0.cameraSettings.depthOfField.focusDistance.value, arg_7_0.cameraSettings.depthOfField.blurRadius.value, arg_7_0.cameraSettings.postExposure.value, arg_7_0.cameraSettings.contrast.value, arg_7_0.cameraSettings.saturate.value)))

			return
		end

		local function var_32_3(arg_36_0)
			var_32_1(true)

			Tex2DExtension = var_1

			local var_36_0 = var_1.EncodeToJPG(arg_36_0)

			var_32_2(var_36_0, arg_36_0)

			return
		end

		Dorm3dHxHelper = var_2_10004

		local var_32_4, var_32_5 = var_2_10004.GetHolyLightScreenShotInfo(arg_7_0.scene.holyLightRoot)

		GraphicsInterface = var_6

		local var_32_6 = var_6.Instance

		var_6.TakePhotoWithPost(var_32_6, arg_7_0.mainCamera, var_32_4, var_32_5, var_32_3)

		return
	end, "ui-dorm_photograph")

	GetOrAddComponent = var_3

	local var_7_31 = arg_7_0._tf
	local var_7_32 = var_5.Find(var_7_31, "RightTop/Film")

	typeof = var_6
	CanvasGroup = var_8
	var_3(var_7_32, var_6(var_8)).blocksRaycasts = false
	onButton = var_4

	local var_7_33 = arg_7_0
	local var_7_34 = arg_7_0._tf
	local var_7_35 = var_7.Find(var_7_34, "RightTop/Shot/Switch")

	local function var_7_36()
		GetOrAddComponent = var_2_10000

		local var_37_0 = arg_7_0._tf
		local var_37_1 = var_2.Find(var_37_0, "RightTop/Film")

		typeof = var_2_10003
		CanvasGroup = var_5
		var_2_10000(var_37_1, var_2_10003(var_5)).blocksRaycasts = true
		quickPlayAnimation = var_1

		local var_37_2 = arg_7_0._tf

		var_1(var_3.Find(var_37_2, "RightTop"), "anim_dorm3d_photo_StoF")

		return
	end

	SFX_PANEL = var_7_34

	var_4(var_7_33, var_7_35, var_7_36, var_7_34)

	onButton = var_4

	local var_7_37 = arg_7_0
	local var_7_38 = arg_7_0.btnAnimSpeed

	local function var_7_39()
		setActive = var_2_10000

		local var_38_0 = arg_7_0.listAnimSpeed

		isActive = var_2_10003

		var_2_10000(var_38_0, not var_2_10003(arg_7_0.listAnimSpeed))

		return
	end

	SFX_PANEL = var_7_34

	var_4(var_7_37, var_7_38, var_7_39, var_7_34)

	onButton = var_4

	local var_7_40 = arg_7_0
	local var_7_41 = arg_7_0.btnZone

	local function var_7_42()
		isActive = var_2_10000

		local var_39_0 = var_2_10000(arg_7_0.listZones)

		setActive = var_2_10001

		var_2_10001(arg_7_0.listZones, not var_39_0)

		return
	end

	SFX_PANEL = var_7_34

	var_4(var_7_40, var_7_41, var_7_42, var_7_34)

	onButton = var_4

	var_4(arg_7_0, arg_7_0.zoneMask, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.listZones, false)

		return
	end)

	onButton = var_4

	var_4(arg_7_0, arg_7_0.btnAr, function()
		local var_41_0 = arg_7_0.ARchecker

		var_0.StartCheck(var_41_0, function(arg_42_0)
			PLATFORM = var_3_10001
			PLATFORM_WINDOWSEDITOR = var_3_10002

			if var_3_10001 == var_3_10002 then
				arg_42_0 = -1
			end

			originalPrint = var_3_10001

			var_3_10001("AR CODE: " .. arg_42_0)

			local var_42_0 = arg_7_0
			local var_42_1 = var_1.emit

			Dorm3dPhotoMediator = var_4

			var_42_1(var_42_0, var_4.GO_AR, arg_42_0)

			return
		end)

		return
	end)

	onButton = var_4

	var_4(arg_7_0, arg_7_0.btnMove, function()
		local var_43_0 = arg_7_0.scene
		local var_43_1 = var_0.emit

		Dorm3dRoomTemplateScene = var_2_10003

		var_43_1(var_43_0, var_2_10003.PHOTO_CALL, "SwitchPhotoCamera")

		local var_43_2 = arg_7_0

		var_43_2.freeMode = not arg_7_0.freeMode
		setActive = var_43_2

		var_43_2(var_7_5, arg_7_0.freeMode)

		setActive = var_43_2

		var_43_2(var_7_7, arg_7_0.freeMode)

		setActive = var_43_2

		local var_43_3 = arg_7_0.btnMove

		var_43_2(var_2.Find(var_43_3, "Selected"), arg_7_0.freeMode)

		return
	end)

	onButton = var_4

	local var_7_43 = arg_7_0
	local var_7_44 = arg_7_0.btnMenuSmall

	local function var_7_45()
		setActive = var_2_10000

		var_2_10000(arg_7_0.btnMenuSmall, false)

		setActive = var_2_10000

		var_2_10000(arg_7_0.btnMenu, true)

		return
	end

	SFX_PANEL = var_7_34

	var_4(var_7_43, var_7_44, var_7_45, var_7_34)

	onButton = var_4

	local var_7_46 = arg_7_0
	local var_7_47 = arg_7_0.btnMenu
	local var_7_48 = var_7.Find(var_7_47, "Collapse")

	local function var_7_49()
		setActive = var_2_10000

		var_2_10000(arg_7_0.btnMenu, false)

		setActive = var_2_10000

		var_2_10000(arg_7_0.btnMenuSmall, true)

		return
	end

	SFX_PANEL = var_7_47

	var_4(var_7_46, var_7_48, var_7_49, var_7_47)

	onButton = var_4

	local var_7_50 = arg_7_0
	local var_7_51 = arg_7_0.btnMenu

	local function var_7_52()
		local var_46_0 = arg_7_0
		local var_46_1 = var_0.emit

		Dorm3dPhotoMediator = var_2_10003

		local var_46_2 = var_2_10003.OPEN_SKIN_SELECT_LAYER
		local var_46_3 = arg_7_0.groupId
		local var_46_4 = arg_7_0.scene.ladyDict[arg_7_0.groupId]

		local function var_46_5(arg_47_0, arg_47_1, arg_47_2)
			local var_47_0 = arg_7_0

			var_3.OnSwitchSkin(var_47_0, arg_47_0, arg_47_1, arg_47_2)

			return
		end

		local var_46_6 = arg_7_0.scene.room

		var_46_1(var_46_0, var_46_2, var_46_3, var_46_4, var_46_5, not var_7.isPersonalRoom(var_46_6))

		return
	end

	SFX_PANEL = var_7_47

	var_4(var_7_50, var_7_51, var_7_52, var_7_47)

	arg_7_0.activePanel = 1

	local var_7_53 = {
		{
			btn = arg_7_0.btnAction,
			On = function()
				local var_48_0 = arg_7_0

				var_0.UpdateActionPanel(var_48_0)

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnCamera,
			On = function()
				local var_50_0 = arg_7_0

				var_0.UpdateCameraPanel(var_50_0)

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnLighting,
			On = function()
				local var_52_0 = arg_7_0

				var_0.UpdateLightingPanel(var_52_0)

				return
			end,
			Off = function()
				return
			end
		}
	}

	table = var_5

	var_5.Ipairs(var_7_53, function(arg_54_0, arg_54_1)
		onToggle = var_2_10002

		local var_54_0 = arg_7_0
		local var_54_1 = arg_54_1.btn

		local function var_54_2(arg_55_0)
			if not arg_55_0 then
				return
			end

			table = var_3_10001

			var_3_10001.Ipairs(var_7_53, function(arg_56_0, arg_56_1)
				if arg_56_0 == arg_54_0 then
					return
				end

				arg_56_1.Off()

				return
			end)

			arg_7_0.activePanel = arg_54_0

			arg_54_1.On()

			return
		end

		SFX_PANEL = var_2_10007

		var_2_10002(var_54_0, var_54_1, var_54_2, var_2_10007)

		return
	end)
	;(function()
		local var_57_0 = {}
		local var_57_1 = arg_7_0.panelAction

		var_57_0[1] = var_1.Find(var_57_1, "Layout/Title/Regular")

		local var_57_2 = arg_7_0.panelAction

		var_57_0[2] = var_1.Find(var_57_2, "Layout/Title/Special")
		triggerToggle = var_1

		var_1(var_57_0[1], true)

		return
	end)()
	;(function()
		local var_58_0 = {}
		local var_58_1 = arg_7_0.panelLightning

		var_58_0[1] = var_1.Find(var_58_1, "Layout/Title/Filter")
		triggerToggle = var_1

		var_1(var_58_0[1], true)

		return
	end)()

	arg_7_0.zoneIndex = 1

	arg_7_0:InitData()
	arg_7_0:FirstEnterZone()

	triggerToggle = var_7

	var_7(var_7_53[arg_7_0.activePanel].btn, true)
	arg_7_0:UpdateZoneList()

	return
end

function var_0_1.InitData(arg_59_0)
	Clone = var_1_10001

	local var_59_0 = arg_59_0.scene

	arg_59_0.cameraSettings = var_1_10001(var_3.GetCameraSettings(var_59_0))
	arg_59_0.settingHideCharacter = false
	arg_59_0.settingFaceCamera = true
	arg_59_0.settingFilterIndex = nil
	arg_59_0.settingFilterStrength = 1

	arg_59_0:RefreshData()

	return
end

function var_0_1.RefreshData(arg_60_0)
	local var_60_0 = arg_60_0.room
	local var_60_1 = var_1.GetCameraZones(var_60_0)[arg_60_0.zoneIndex]
	local var_60_2 = var_2.GetRegularAnimsByShipId(var_60_1, arg_60_0.groupId)[1]

	arg_60_0.animID = var_4.GetConfigID(var_60_2)

	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		math = var_2
		arg_61_0.value = var_2.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.depthOfField.focusDistance, var_2:GetFocusDistanceRange())
	var_4(arg_60_0.cameraSettings.depthOfField.blurRadius, var_2:GetDepthOfFieldBlurRange())
	var_4(arg_60_0.cameraSettings.postExposure, var_2:GetExposureRange())
	var_4(arg_60_0.cameraSettings.contrast, var_2:GetContrastRange())
	var_4(arg_60_0.cameraSettings.saturate, var_2:GetSaturationRange())

	arg_60_0.animSpeeds = var_2:GetAnimSpeeds()
	arg_60_0.animSpeed = 1

	return
end

function var_0_1.FirstEnterZone(arg_62_0)
	local var_62_0 = arg_62_0.room
	local var_62_1 = var_1.GetCameraZones(var_62_0)[arg_62_0.zoneIndex]

	Dorm3dCameraAnim = var_62_0

	local var_62_2 = var_62_0.New({
		configId = arg_62_0.animID
	})
	local var_62_3 = arg_62_0.scene
	local var_62_4 = var_4.emit

	Dorm3dRoomTemplateScene = var_1_10007

	var_62_4(var_62_3, var_1_10007.PHOTO_CALL, "EnterPhotoMode", var_62_1, var_62_2:GetStateName())
	arg_62_0:UpdateAnimSpeedPanel()

	return
end

function var_0_1.SwitchZone(arg_63_0)
	local var_63_0 = arg_63_0.room
	local var_63_1 = var_1.GetCameraZones(var_63_0)[arg_63_0.zoneIndex]

	Dorm3dCameraAnim = var_63_0

	local var_63_2 = var_63_0.New({
		configId = arg_63_0.animID
	})
	local var_63_3 = arg_63_0.scene
	local var_63_4 = var_4.emit

	Dorm3dRoomTemplateScene = var_1_10007

	var_63_4(var_63_3, var_1_10007.PHOTO_CALL, "SwitchCameraZone", var_63_1, var_63_2:GetStateName())

	if arg_63_0.timerAnim then
		local var_63_5 = arg_63_0.timerAnim

		var_4.Stop(var_63_5)

		arg_63_0.timerAnim = nil
	end

	arg_63_0.animPlaying = nil

	arg_63_0:UpdateActionPanel()
	arg_63_0:UpdateCameraPanel()
	arg_63_0:UpdateLightingPanel()
	arg_63_0:UpdateAnimSpeedPanel()
	arg_63_0:SetAllAnimSpeed(arg_63_0.animSpeed)

	return
end

function var_0_1.UpdateZoneList(arg_64_0)
	local var_64_0 = arg_64_0.room
	local var_64_1 = var_1.GetCameraZones(var_64_0)

	;(function()
		setText = var_2_10000

		local var_65_0 = arg_64_0.btnZone
		local var_65_1 = var_2.Find(var_65_0, "Text")
		local var_65_2 = var_64_1[arg_64_0.zoneIndex]

		var_2_10000(var_65_1, var_3.GetName(var_65_2))

		UIItemList = var_2_10000

		local var_65_3 = var_2_10000.StaticAlign
		local var_65_4 = arg_64_0.listZones
		local var_65_5 = var_2.Find(var_65_4, "List")
		local var_65_6 = arg_64_0.listZones
		local var_65_7 = var_3.Find(var_65_6, "List")

		var_65_3(var_65_5, var_3.GetChild(var_65_7, 0), #var_64_1, function(arg_66_0, arg_66_1, arg_66_2)
			UIItemList = var_3_10003

			if arg_66_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_66_1 = arg_66_1 + 1

			local var_66_0 = var_64_1[arg_66_1]

			setText = var_3_10004

			var_3_10004(arg_66_2:Find("Name"), var_66_0:GetName())

			if arg_64_0.zoneIndex == arg_66_1 then
				Color = var_66_1

				local var_66_1

				if not var_66_1.NewHex("5CCAFF") then
					Color = var_66_1
					var_66_1 = var_66_1.NewHex("FFFFFF99")
				end

				setTextColor = var_3_10005

				var_3_10005(arg_66_2:Find("Name"), var_66_1)

				setActive = var_3_10005

				var_3_10005(arg_66_2:Find("Line"), arg_66_1 < #var_64_1)

				return
			end
		end)

		return
	end)()

	UIItemList = var_3

	local var_64_2 = var_3.StaticAlign
	local var_64_3 = arg_64_0.listZones
	local var_64_4 = var_5.Find(var_64_3, "List")
	local var_64_5 = arg_64_0.listZones
	local var_64_6 = var_6.Find(var_64_5, "List")

	var_64_2(var_64_4, var_6.GetChild(var_64_6, 0), #var_64_1, function(arg_67_0, arg_67_1, arg_67_2)
		UIItemList = var_2_10003

		if arg_67_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_67_1 = arg_67_1 + 1
		onButton = var_3

		local var_67_0 = arg_64_0
		local var_67_1 = arg_67_2

		local function var_67_2()
			if arg_64_0.zoneIndex == arg_67_1 then
				return
			end

			arg_64_0.zoneIndex = arg_67_1

			local var_68_0 = arg_64_0

			var_0.RefreshData(var_68_0)

			local var_68_1 = arg_64_0

			var_0.SwitchZone(var_68_1)

			setActive = var_0

			var_0(arg_64_0.listZones, false)
			var_0()

			return
		end

		SFX_PANEL = var_2_10008

		var_3(var_67_0, var_67_1, var_67_2, var_2_10008)

		return
	end)

	return
end

local var_0_3 = 0.2

function var_0_1.UpdateActionPanel(arg_69_0)
	if not arg_69_0.activeSetting then
		return
	end

	if arg_69_0.activePanel ~= var_0_1.PANEL.ACTION then
		return
	end

	local var_69_0 = arg_69_0.room
	local var_69_1 = var_1.GetCameraZones(var_69_0)[arg_69_0.zoneIndex]
	local var_69_2 = var_1.GetRegularAnimsByShipId(var_69_1, arg_69_0.groupId)
	local var_69_3 = arg_69_0.panelAction
	local var_69_4 = var_3.Find(var_69_3, "Layout/Regular/Scroll/Viewport/Content")
	local var_69_5 = var_1:GetAllSpecialList(arg_69_0.room.id)
	local var_69_6 = arg_69_0.panelAction
	local var_69_7 = var_5.Find(var_69_6, "Layout/Special/Scroll/Viewport/Content")
	local var_69_8 = #var_69_5
	local var_69_9 = 0 < var_69_8

	setActive = var_7

	local var_69_10 = arg_69_0.panelAction

	var_7(var_9.Find(var_69_10, "Layout/Title/Special"), var_69_9)

	local function var_69_11()
		UIItemList = var_2_10000

		local var_70_0 = var_2_10000.StaticAlign
		local var_70_1 = var_69_4
		local var_70_2 = var_69_4

		var_70_0(var_70_1, var_3.GetChild(var_70_2, 0), #var_69_2, function(arg_71_0, arg_71_1, arg_71_2)
			UIItemList = var_3_10003

			if arg_71_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_71_1 = arg_71_1 + 1

			local var_71_0 = var_69_2[arg_71_1]

			setActive = var_3_10004

			var_3_10004(arg_71_2:Find("Selected"), var_71_0:GetConfigID() == arg_69_0.animID)

			setActive = var_3_10004

			local var_71_1 = arg_71_2:Find("Slider")
			local var_71_2

			if var_71_0:GetConfigID() == arg_69_0.animID then
				tobool = var_7
				var_71_2 = var_7(arg_69_0.timerAnim)
			else
				var_71_2 = false
			end

			if false then
				var_71_2 = true
			end

			var_3_10004(var_71_1, var_71_2)

			return
		end)

		UIItemList = var_70_0

		local var_70_3 = var_70_0.StaticAlign
		local var_70_4 = var_69_7
		local var_70_5 = var_69_7

		var_70_3(var_70_4, var_3.GetChild(var_70_5, 0), #var_69_5, function(arg_72_0, arg_72_1, arg_72_2)
			UIItemList = var_3_10003

			if arg_72_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_72_1 = arg_72_1 + 1

			local var_72_0 = var_69_5[arg_72_1].anims
			local var_72_1 = arg_72_2:Find("Actions")

			UIItemList = var_3_10006

			var_3_10006.StaticAlign(var_72_1, var_72_1:GetChild(0), #var_72_0, function(arg_73_0, arg_73_1, arg_73_2)
				UIItemList = var_4_10003

				if arg_73_0 ~= var_4_10003.EventUpdate then
					return
				end

				arg_73_1 = arg_73_1 + 1

				local var_73_0 = var_72_0[arg_73_1]

				setActive = var_4_10004

				var_4_10004(arg_73_2:Find("Selected"), var_73_0:GetConfigID() == arg_69_0.animID)

				setActive = var_4_10004

				local var_73_1 = arg_73_2:Find("Slider")
				local var_73_2

				if var_73_0:GetConfigID() == arg_69_0.animID then
					tobool = var_7
					var_73_2 = var_7(arg_69_0.timerAnim)
				else
					var_73_2 = false
				end

				if false then
					var_73_2 = true
				end

				var_4_10004(var_73_1, var_73_2)

				return
			end)

			return
		end)

		return
	end

	local function var_69_12(arg_74_0, arg_74_1)
		if arg_69_0.animPlaying then
			return
		end

		local var_74_0 = arg_74_0
		local var_74_1 = arg_74_0.GetConfigID(var_74_0)

		if arg_69_0.animID == var_74_1 then
			return
		end

		local var_74_2 = arg_69_0
		local var_74_3 = var_3.GetAnimPlayList(var_74_2, var_74_1)

		Dorm3dCameraAnim = var_74_0

		local var_74_4 = var_74_0.New({
			configId = arg_69_0.animID
		})
		local var_74_5 = var_4.GetFinishAnimID(var_74_4)

		arg_69_0.animID = var_74_1

		var_69_11()

		local var_74_6 = arg_69_0

		var_5.BlockActionPanel(var_74_6, true)

		local var_74_7 = arg_69_0

		var_74_7.animPlaying = true
		table = var_74_7

		local var_74_8 = var_74_7.indexof
		local var_74_9 = var_74_3

		_ = var_8

		local var_74_10 = (var_74_8(var_74_9, var_8.detect(var_74_3, function(arg_75_0)
			return arg_75_0:GetConfigID() == var_74_5
		end)) or 0) + 1

		_ = var_6

		local var_74_11 = var_6.rest(var_74_3, var_74_10)
		local var_74_12 = arg_74_1:Find("Slider")
		local var_74_13 = var_6.GetComponent

		typeof = var_9
		Slider = var_11

		local var_74_14 = var_74_13(var_74_12, var_9(var_11))

		setActive = var_74_9

		var_74_9(arg_74_1:Find("Slider"), true)

		local function var_74_15()
			setActive = var_3_10000

			local var_76_0 = arg_74_1

			var_3_10000(var_2.Find(var_76_0, "Selected"), true)

			setActive = var_3_10000

			local var_76_1 = arg_74_1

			var_3_10000(var_2.Find(var_76_1, "Slider"), false)

			local var_76_2 = arg_69_0

			var_0.BlockActionPanel(var_76_2, false)

			arg_69_0.animPlaying = nil

			return
		end

		if #var_74_11 == 0 then
			var_74_15()

			return
		end

		local function var_74_16(arg_77_0, arg_77_1, arg_77_2)
			local var_77_0 = arg_69_0.scene
			local var_77_1 = var_3.emit

			Dorm3dRoomTemplateScene = var_3_10006

			var_77_1(var_77_0, var_3_10006.PHOTO_CALL, "PlayEnterSceneAnim", arg_77_0:GetEnterSceneAnim(), arg_77_2 ~= arg_77_1, arg_69_0.animSpeed)

			local var_77_2 = arg_69_0.scene
			local var_77_3 = var_3.emit

			Dorm3dRoomTemplateScene = var_6

			var_77_3(var_77_2, var_6.PHOTO_CALL, "PlayEnterExtraItem", arg_77_0:GetEnterExtraItem(), arg_69_0.animSpeed)

			local var_77_4 = arg_69_0.scene
			local var_77_5 = var_3.emit

			Dorm3dRoomTemplateScene = var_6

			var_77_5(var_77_4, var_6.PHOTO_CALL, "HideSceneItem", arg_77_0:GetHideSceneItem())

			arg_69_0.cacheSceneAnim = arg_77_0:GetEnterSceneAnim()
			arg_69_0.cacheExtraItem = arg_77_0:GetEnterExtraItem()

			return
		end

		_ = var_9

		local var_74_17 = var_9.reduce(var_74_11, 0, function(arg_78_0, arg_78_1)
			math = var_3_10002

			return arg_78_0 + var_3_10002.max(var_0_3, arg_78_1:GetAnimTime())
		end)
		local var_74_18

		if arg_69_0.timerAnim then
			var_74_18 = arg_69_0.timerAnim

			var_10.Stop(var_74_18)
		end

		local var_74_19 = arg_69_0
		local var_74_20 = {
			index = 1,
			passedTime = 0,
			ratio = 0,
			animPlayList = var_74_11,
			totalTime = var_74_17
		}

		Time = var_74_18
		var_74_20.startStamp = var_74_18.time
		var_74_19.animInfo = var_74_20

		local var_74_21 = arg_69_0

		FrameTimer = var_74_20
		var_74_21.timerAnim = var_74_20.New(function()
			local var_79_0 = arg_69_0.animInfo.animPlayList[var_0.index]

			math = var_2

			local var_79_1 = var_2.max(var_0_3, var_79_0:GetAnimTime())
			local var_79_2 = var_0.startStamp

			Time = var_4

			local var_79_3 = var_4.time

			math = var_5

			local var_79_4 = var_5.min(1, var_0.ratio + (var_79_3 - var_79_2) * arg_69_0.animSpeed / var_79_1)
			local var_79_5 = var_0.passedTime + var_79_1 * var_79_4

			var_74_14.value = var_79_5 / var_74_17

			if var_79_4 < 1 then
				return
			end

			var_0.index = var_0.index + 1
			var_0.ratio = 0
			var_0.passedTime = var_0.passedTime + var_79_1
			var_0.startStamp = var_79_3

			if #var_79_0:GetStartPoint() > 0 then
				local var_79_6 = arg_69_0.scene
				local var_79_7 = var_8.emit

				Dorm3dRoomTemplateScene = var_3_10011

				var_79_7(var_79_6, var_3_10011.PHOTO_CALL, "ResetCurrentCharPoint", var_7)
			end

			if var_0.index > #var_0.animPlayList then
				var_74_15()

				local var_79_8 = arg_69_0.timerAnim

				var_8.Stop(var_79_8)

				arg_69_0.timerAnim = nil
				arg_69_0.animInfo = nil

				return
			end

			local var_79_9 = var_0.animPlayList[var_0.index]
			local var_79_10 = arg_69_0.scene
			local var_79_11 = var_9.emit

			Dorm3dRoomTemplateScene = var_3_10012

			var_79_11(var_79_10, var_3_10012.PHOTO_CALL, "PlayCurrentSingleAction", var_79_9:GetStateName(), nil, 0)
			var_74_16(var_79_9, var_74_1, var_74_5)

			return
		end, 1, -1)

		local var_74_22 = arg_69_0.animInfo.animPlayList[1]

		if var_74_10 == 1 then
			local var_74_23 = arg_69_0.scene
			local var_74_24 = var_11.emit

			Dorm3dRoomTemplateScene = var_14

			var_74_24(var_74_23, var_14.PHOTO_CALL, "SwitchCurrentAnim", var_74_22:GetStateName())

			onNextTick = var_74_24

			var_74_24(function()
				local var_80_0 = var_74_22
				local var_80_2

				if #var_0.GetStartPoint(var_80_0) == 0 then
					local var_80_1 = var_0

					var_80_2 = var_1.GetWatchCameraName(var_80_1)
				end

				local var_80_3 = arg_69_0.scene
				local var_80_4 = var_1.emit

				Dorm3dRoomTemplateScene = var_3_10004

				var_80_4(var_80_3, var_3_10004.PHOTO_CALL, "ResetCurrentCharPoint", var_80_2)

				local var_80_5 = arg_69_0.scene
				local var_80_6 = var_1.emit

				Dorm3dRoomTemplateScene = var_4

				var_80_6(var_80_5, var_4.PHOTO_CALL, "SyncCurrentInterestTransform")
				var_74_16(var_74_22, var_74_1, var_74_5)

				if arg_69_0.freeMode then
					local var_80_7 = arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE]
					local var_80_8 = var_1.GetComponent

					typeof = var_5
					UnityEngine = var_3_10007

					local var_80_9 = var_80_8(var_80_7, var_5(var_3_10007.CharacterController))
					local var_80_10 = var_1.transform.forward

					var_80_10.y = 0

					var_80_10:Normalize()

					local var_80_11 = var_80_10 * -0.01

					var_80_9:Move(var_80_11)
					var_80_9:Move(-var_80_11)
				end

				return
			end)
		else
			local var_74_25 = arg_69_0.scene
			local var_74_26 = var_11.emit

			Dorm3dRoomTemplateScene = var_14

			var_74_26(var_74_25, var_14.PHOTO_CALL, "PlayCurrentSingleAction", var_74_22:GetStateName(), nil, 0)
			var_74_16(var_74_22, var_74_1, var_74_5)
		end

		local var_74_27 = arg_69_0.timerAnim

		var_11.Start(var_74_27)

		return
	end

	UIItemList = var_9

	var_9.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_2, function(arg_81_0, arg_81_1, arg_81_2)
		UIItemList = var_2_10003

		if arg_81_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_81_1 = arg_81_1 + 1

		local var_81_0 = var_69_2[arg_81_1]

		setText = var_2_10004

		var_2_10004(arg_81_2:Find("Name"), var_81_0:GetName())

		GetImageSpriteFromAtlasAsync = var_2_10004
		string = var_6

		var_2_10004(var_6.format("Dorm3DPhoto/%s", var_81_0:GetZoneIcon()), "", arg_81_2:Find("Icon"))

		setActive = var_2_10004

		var_2_10004(arg_81_2:Find("Slider"), false)

		setActive = var_2_10004

		var_2_10004(arg_81_2:Find("Selected"), false)

		onButton = var_2_10004

		var_2_10004(arg_69_0, arg_81_2, function()
			var_69_12(var_81_0, arg_81_2)

			return
		end)

		return
	end)

	local function var_69_13()
		UIItemList = var_2_10000

		local var_83_0 = var_2_10000.StaticAlign
		local var_83_1 = var_69_7
		local var_83_2 = var_69_7

		var_83_0(var_83_1, var_3.GetChild(var_83_2, 0), #var_69_5, function(arg_84_0, arg_84_1, arg_84_2)
			UIItemList = var_3_10003

			if arg_84_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_84_1 = arg_84_1 + 1

			local var_84_0 = var_69_5[arg_84_1].anims
			local var_84_1 = arg_84_2:Find("Actions")

			UIItemList = var_3_10006

			var_3_10006.StaticAlign(var_84_1, var_84_1:GetChild(0), #var_84_0, function(arg_85_0, arg_85_1, arg_85_2)
				UIItemList = var_4_10003

				if arg_85_0 ~= var_4_10003.EventUpdate then
					return
				end

				arg_85_1 = arg_85_1 + 1

				local var_85_0 = var_84_0[arg_85_1]

				setActive = var_4_10004

				var_4_10004(arg_85_2:Find("Selected"), var_85_0:GetConfigID() == arg_69_0.animID)

				setActive = var_4_10004

				local var_85_1 = arg_85_2:Find("Slider")
				local var_85_2

				if var_85_0:GetConfigID() == arg_69_0.animID then
					tobool = var_7
					var_85_2 = var_7(arg_69_0.timerAnim)
				else
					var_85_2 = false
				end

				if false then
					var_85_2 = true
				end

				var_4_10004(var_85_1, var_85_2)

				return
			end)

			return
		end)

		return
	end

	local function var_69_14()
		UIItemList = var_2_10000

		local var_86_0 = var_2_10000.StaticAlign
		local var_86_1 = var_69_7
		local var_86_2 = var_69_7

		var_86_0(var_86_1, var_3.GetChild(var_86_2, 0), #var_69_5, function(arg_87_0, arg_87_1, arg_87_2)
			UIItemList = var_3_10003

			if arg_87_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_87_1 = arg_87_1 + 1
			setActive = var_3

			var_3(arg_87_2:Find("Button/Active"), arg_69_0.settingSpecialFurnitureIndex == arg_87_1)

			setActive = var_3

			var_3(arg_87_2:Find("Actions"), arg_69_0.settingSpecialFurnitureIndex == arg_87_1)

			return
		end)
		var_69_13()

		return
	end

	local function var_69_15(arg_88_0, arg_88_1)
		local var_88_0 = arg_88_1
		local var_88_1 = arg_88_1.Find(var_88_0, "Actions")
		local var_88_2 = arg_88_0.anims

		UIItemList = var_88_0

		var_88_0.StaticAlign(var_88_1, var_88_1:GetChild(0), #var_88_2, function(arg_89_0, arg_89_1, arg_89_2)
			UIItemList = var_3_10003

			if arg_89_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_89_1 = arg_89_1 + 1

			local var_89_0 = var_88_2[arg_89_1]
			local var_89_1 = var_0
			local var_89_2 = var_4.CheckFurnitureIdInZone(var_89_1, arg_88_0.furnitureId)
			local var_89_3 = arg_69_0.room
			local var_89_4 = var_5.IsFurnitureSetIn(var_89_3, arg_88_0.furnitureId)
			local var_89_5 = var_89_2 and var_89_4

			SetActive = var_89_3

			var_89_3(arg_89_2:Find("Other"), not var_89_5)

			SetActive = var_89_3

			var_89_3(arg_89_2:Find("Name"), var_89_5)

			local var_89_6

			if var_89_5 then
				onButton = var_89_3

				var_89_3(arg_69_0, arg_89_2, function()
					var_69_12(var_89_0, arg_89_2)

					return
				end)

				setText = var_89_3

				var_89_3(arg_89_2:Find("Name"), var_89_0:GetName())
			else
				removeOnButton = var_89_3

				var_89_3(arg_89_2)

				if not var_89_2 then
					var_89_6 = var_89_0
					var_89_3 = var_89_0.GetZoneName(var_89_6)
					i18n = var_8

					local var_89_7 = var_8("dorm3d_photo_active_zone", var_89_3)
					local var_89_8 = warnText
				else
					i18n = var_89_3
					var_89_3 = var_89_3("dorm3d_furniture_replace_tip")
					var_89_3 = warnText
				end

				setText = var_89_3
				var_89_6 = arg_89_2:Find("Other/Content")
				warnText = var_10

				var_89_3(var_89_6, var_10)
			end

			GetImageSpriteFromAtlasAsync = var_89_3
			string = var_89_6

			var_89_3(var_89_6.format("Dorm3DPhoto/%s", var_89_0:GetZoneIcon()), "", arg_89_2:Find("Icon"))

			setActive = var_89_3

			var_89_3(arg_89_2:Find("Slider"), false)

			setActive = var_89_3

			var_89_3(arg_89_2:Find("Selected"), false)

			return
		end)

		return
	end

	setActive = var_12

	var_12(var_69_7, #var_69_5 > 0)

	UIItemList = var_12

	var_12.StaticAlign(var_69_7, var_69_7:GetChild(0), #var_69_5, function(arg_91_0, arg_91_1, arg_91_2)
		UIItemList = var_2_10003

		if arg_91_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_91_1 = arg_91_1 + 1

		local var_91_0 = var_69_5[arg_91_1]

		Dorm3dFurniture = var_2_10004

		local var_91_1 = var_2_10004.New({
			configId = var_91_0.furnitureId
		})

		tobool = var_2_10005
		_ = var_7

		local var_91_2 = var_7.detect
		local var_91_3 = arg_69_0.room
		local var_91_4 = var_2_10005(var_91_2(var_9.GetFurnitures(var_91_3), function(arg_92_0)
			return arg_92_0:GetConfigID() == var_91_0.furnitureId
		end))

		setText = var_6

		var_6(arg_91_2:Find("Button/Name"), var_91_1:GetName())

		GetImageSpriteFromAtlasAsync = var_6

		var_6(var_91_1:GetIcon(), "", arg_91_2:Find("Button/Icon"))

		setActive = var_6

		var_6(arg_91_2:Find("Button/Lock"), not var_91_4)

		setActive = var_6

		var_6(arg_91_2:Find("Button/BG"), var_91_4)

		local var_91_5 = var_0
		local var_91_6 = var_6.CheckFurnitureIdInZone(var_91_5, var_91_0.furnitureId)
		local var_91_7

		if var_91_6 then
			Color = var_91_5
			var_91_7 = var_91_5.New(1, 1, 1, 0.8509803921568627)
		else
			Color = var_91_5
			var_91_7 = var_91_5.New(0.788235294117647, 0.788235294117647, 0.788235294117647, 0.8509803921568627)
		end

		setImageColor = var_91_5

		var_91_5(arg_91_2:Find("Button/BG"), var_91_7)

		onButton = var_91_5

		var_91_5(arg_69_0, arg_91_2:Find("Button"), function()
			if not var_91_4 then
				pg = var_0

				local var_93_0 = var_0.TipsMgr.GetInstance()
				local var_93_1 = var_0.ShowTips

				i18n = var_3_10003

				var_93_1(var_93_0, var_3_10003("dorm3d_furniture_locked"))

				return
			end

			if arg_69_0.settingSpecialFurnitureIndex == arg_91_1 then
				arg_69_0.settingSpecialFurnitureIndex = nil
			else
				arg_69_0.settingSpecialFurnitureIndex = arg_91_1
			end

			var_69_14()

			return
		end)
		var_69_15(var_91_0, arg_91_2)

		return
	end)
	var_69_14()
	var_69_11()

	return
end

function var_0_1.BlockActionPanel(arg_94_0, arg_94_1)
	return
end

function var_0_1.GetAnimPlayList(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1
	local var_95_1 = {}
	local var_95_2 = 100

	while true do
		Dorm3dCameraAnim = var_1_10005

		if not var_1_10005.New({
			configId = var_95_0
		}) then
			return var_95_1
		end

		table = var_1_10006

		var_1_10006.insert(var_95_1, 1, var_1_10005)

		if var_1_10005:GetPreAnimID() == 0 then
			return var_95_1
		end

		var_95_2 = var_95_2 - 1
		assert = var_1_10006

		var_1_10006(var_95_2 > 0)
	end

	return
end

function var_0_1.UpdateCameraPanel(arg_96_0)
	if not arg_96_0.activeSetting then
		return
	end

	if arg_96_0.activePanel ~= var_0_1.PANEL.CAMERA then
		return
	end

	;(function()
		local var_97_0 = arg_96_0.panelCamera
		local var_97_1 = var_0.Find(var_97_0, "Layout/DepthOfField/Switch/Toggle")

		triggerToggle = var_2_10001

		var_2_10001(var_97_1, arg_96_0.cameraSettings.depthOfField.enabled)

		onToggle = var_2_10001

		local var_97_2 = arg_96_0
		local var_97_3 = var_97_1

		local function var_97_4(arg_98_0)
			local var_98_0 = arg_96_0.cameraSettings.depthOfField

			var_98_0.enabled = arg_98_0
			setActive = var_98_0

			local var_98_1 = arg_96_0.panelCamera

			var_98_0(var_3.Find(var_98_1, "Layout/DepthOfField/DepthOfField"), arg_96_0.cameraSettings.depthOfField.enabled)

			local var_98_2 = arg_96_0

			var_1.RefreshCamera(var_98_2)

			return
		end

		SFX_UI_TAG = var_2_10006
		SFX_UI_CANCEL = var_2_10007

		var_2_10001(var_97_2, var_97_3, var_97_4, var_2_10006, var_2_10007)

		return
	end)()

	setActive = var_2

	local var_96_0 = arg_96_0.panelCamera

	var_2(var_4.Find(var_96_0, "Layout/DepthOfField/DepthOfField"), arg_96_0.cameraSettings.depthOfField.enabled)
	;(function()
		local var_99_0 = arg_96_0.cameraSettings.depthOfField.focusDistance
		local var_99_1 = arg_96_0.panelCamera
		local var_99_2 = var_1.Find(var_99_1, "Layout/DepthOfField/DepthOfField/FocusDistance/Slider")

		setSlider = var_2_10002

		var_2_10002(var_99_2, var_99_0.min, var_99_0.max, var_99_0.value)

		onSlider = var_2_10002

		var_2_10002(arg_96_0, var_99_2, function(arg_100_0)
			var_99_0.value = arg_100_0

			local var_100_0 = arg_96_0

			var_1.RefreshCamera(var_100_0)

			return
		end)

		return
	end)()
	;(function()
		local var_101_0 = arg_96_0.cameraSettings.depthOfField.blurRadius
		local var_101_1 = arg_96_0.panelCamera
		local var_101_2 = var_1.Find(var_101_1, "Layout/DepthOfField/DepthOfField/BlurRadius/Slider")

		setSlider = var_2_10002

		var_2_10002(var_101_2, var_101_0.min, var_101_0.max, var_101_0.value)

		onSlider = var_2_10002

		var_2_10002(arg_96_0, var_101_2, function(arg_102_0)
			var_101_0.value = arg_102_0

			local var_102_0 = arg_96_0

			var_1.RefreshCamera(var_102_0)

			return
		end)

		return
	end)()

	local var_96_1 = {
		"PostExposure",
		"Saturation",
		"Contrast"
	}
	local var_96_2

	if not arg_96_0.paramIndex then
		var_96_2 = 1
	end

	arg_96_0.paramIndex = var_96_2

	local function var_96_3()
		table = var_2_10000

		var_2_10000.Ipairs(var_96_1, function(arg_104_0, arg_104_1)
			local var_104_0 = arg_96_0.panelCamera
			local var_104_1 = var_2.Find(var_104_0, "Layout/Paramaters/Icons")
			local var_104_2 = var_2.GetChild(var_104_1, arg_104_0 - 1)

			setActive = var_3_10003

			var_3_10003(var_104_2:Find("Selected"), arg_104_0 == arg_96_0.paramIndex)

			setActive = var_3_10003

			local var_104_3 = arg_96_0.panelCamera

			var_3_10003(var_5.Find(var_104_3, "Layout/Paramaters/" .. arg_104_1), arg_104_0 == arg_96_0.paramIndex)

			return
		end)

		return
	end

	table = var_96_0

	var_96_0.Ipairs(var_96_1, function(arg_105_0, arg_105_1)
		local var_105_0 = arg_96_0.panelCamera
		local var_105_1 = var_2.Find(var_105_0, "Layout/Paramaters/Icons")
		local var_105_2 = var_2.GetChild(var_105_1, arg_105_0 - 1)

		onButton = var_2_10003

		local var_105_3 = arg_96_0
		local var_105_4 = var_105_2

		local function var_105_5()
			arg_96_0.paramIndex = arg_105_0

			var_96_3()

			return
		end

		SFX_PANEL = var_2_10008

		var_2_10003(var_105_3, var_105_4, var_105_5, var_2_10008)

		return
	end)
	var_96_3()
	;(function()
		local var_107_0 = arg_96_0.cameraSettings.postExposure
		local var_107_1 = arg_96_0.panelCamera
		local var_107_2 = var_1.Find(var_107_1, "Layout/Paramaters/PostExposure/PostExposure/Slider")
		local var_107_3 = var_1.Find(var_107_2, "Background/Fill")

		onSlider = var_107_1

		var_107_1(arg_96_0, var_1, function(arg_108_0)
			var_107_0.value = arg_108_0

			local var_108_0 = (arg_108_0 - var_107_0.min) / (var_107_0.max - var_107_0.min)

			math = var_2

			local var_108_1 = var_2.min(var_108_0, 0.5)

			math = var_3

			local var_108_2 = var_3.max(var_108_0, 0.5)
			local var_108_3 = var_107_3

			Vector2 = var_5
			var_108_3.anchorMin = var_5.New(var_108_1, 0)

			local var_108_4 = var_107_3

			Vector2 = var_5
			var_108_4.anchorMax = var_5.New(var_108_2, 1)

			local var_108_5 = var_107_3

			Vector2 = var_5
			var_108_5.offsetMin = var_5.zero

			local var_108_6 = var_107_3

			Vector2 = var_5
			var_108_6.offsetMax = var_5.zero

			local var_108_7 = arg_96_0

			var_4.RefreshCamera(var_108_7)

			return
		end)

		setSlider = var_107_1

		var_107_1(var_1, var_107_0.min, var_107_0.max, var_107_0.value)

		return
	end)()
	;(function()
		local var_109_0 = arg_96_0.cameraSettings.contrast
		local var_109_1 = arg_96_0.panelCamera
		local var_109_2 = var_1.Find(var_109_1, "Layout/Paramaters/Contrast/Contrast/Slider")
		local var_109_3 = var_1.Find(var_109_2, "Background/Fill")

		onSlider = var_109_1

		var_109_1(arg_96_0, var_1, function(arg_110_0)
			var_109_0.value = arg_110_0

			local var_110_0 = (arg_110_0 - var_109_0.min) / (var_109_0.max - var_109_0.min)

			math = var_2

			local var_110_1 = var_2.min(var_110_0, 0.5)

			math = var_3

			local var_110_2 = var_3.max(var_110_0, 0.5)
			local var_110_3 = var_109_3

			Vector2 = var_5
			var_110_3.anchorMin = var_5.New(var_110_1, 0)

			local var_110_4 = var_109_3

			Vector2 = var_5
			var_110_4.anchorMax = var_5.New(var_110_2, 1)

			local var_110_5 = var_109_3

			Vector2 = var_5
			var_110_5.offsetMin = var_5.zero

			local var_110_6 = var_109_3

			Vector2 = var_5
			var_110_6.offsetMax = var_5.zero

			local var_110_7 = arg_96_0

			var_4.RefreshCamera(var_110_7)

			return
		end)

		setSlider = var_109_1

		var_109_1(var_1, var_109_0.min, var_109_0.max, var_109_0.value)

		return
	end)()
	;(function()
		local var_111_0 = arg_96_0.cameraSettings.saturate
		local var_111_1 = arg_96_0.panelCamera
		local var_111_2 = var_1.Find(var_111_1, "Layout/Paramaters/Saturation/Saturation/Slider")
		local var_111_3 = var_1.Find(var_111_2, "Background/Fill")

		onSlider = var_111_1

		var_111_1(arg_96_0, var_1, function(arg_112_0)
			var_111_0.value = arg_112_0

			local var_112_0 = (arg_112_0 - var_111_0.min) / (var_111_0.max - var_111_0.min)

			math = var_2

			local var_112_1 = var_2.min(var_112_0, 0.5)

			math = var_3

			local var_112_2 = var_3.max(var_112_0, 0.5)
			local var_112_3 = var_111_3

			Vector2 = var_5
			var_112_3.anchorMin = var_5.New(var_112_1, 0)

			local var_112_4 = var_111_3

			Vector2 = var_5
			var_112_4.anchorMax = var_5.New(var_112_2, 1)

			local var_112_5 = var_111_3

			Vector2 = var_5
			var_112_5.offsetMin = var_5.zero

			local var_112_6 = var_111_3

			Vector2 = var_5
			var_112_6.offsetMax = var_5.zero

			local var_112_7 = arg_96_0

			var_4.RefreshCamera(var_112_7)

			return
		end)

		setSlider = var_111_1

		var_111_1(var_1, var_111_0.min, var_111_0.max, var_111_0.value)

		return
	end)()
	;(function()
		local var_113_0 = arg_96_0.panelCamera
		local var_113_1 = var_0.Find(var_113_0, "Layout/Other/FaceCamera/Toggle")

		triggerToggle = var_2_10001

		var_2_10001(var_113_1, arg_96_0.settingFaceCamera)

		onToggle = var_2_10001

		local var_113_2 = arg_96_0
		local var_113_3 = var_113_1

		local function var_113_4(arg_114_0)
			arg_96_0.settingFaceCamera = arg_114_0

			local var_114_0 = arg_96_0.scene
			local var_114_1 = var_1.emit

			Dorm3dRoomTemplateScene = var_3_10004

			var_114_1(var_114_0, var_3_10004.PHOTO_CALL, "EnableCurrentHeadIK", arg_114_0)

			return
		end

		SFX_UI_TAG = var_2_10006
		SFX_UI_CANCEL = var_2_10007

		var_2_10001(var_113_2, var_113_3, var_113_4, var_2_10006, var_2_10007)

		return
	end)()
	;(function()
		local var_115_0 = arg_96_0.panelCamera
		local var_115_1 = var_0.Find(var_115_0, "Layout/Other/HideCharacter/Toggle")

		triggerToggle = var_2_10001

		var_2_10001(var_115_1, arg_96_0.settingHideCharacter)

		onToggle = var_2_10001

		local var_115_2 = arg_96_0
		local var_115_3 = var_115_1

		local function var_115_4(arg_116_0)
			arg_96_0.settingHideCharacter = arg_116_0

			if arg_116_0 then
				local var_116_0 = arg_96_0.scene
				local var_116_1 = var_1.emit

				Dorm3dRoomTemplateScene = var_3_10004

				var_116_1(var_116_0, var_3_10004.PHOTO_CALL, "HideCharacterBylayer")
			else
				local var_116_2 = arg_96_0.scene
				local var_116_3 = var_1.emit

				Dorm3dRoomTemplateScene = var_3_10004

				var_116_3(var_116_2, var_3_10004.PHOTO_CALL, "RevertCharacterBylayer")
			end

			return
		end

		SFX_UI_TAG = var_2_10006
		SFX_UI_CANCEL = var_2_10007

		var_2_10001(var_115_2, var_115_3, var_115_4, var_2_10006, var_2_10007)

		return
	end)()

	return
end

function var_0_1.RefreshCamera(arg_117_0)
	local var_117_0 = arg_117_0.scene
	local var_117_1 = var_1.emit

	Dorm3dRoomTemplateScene = var_1_10004

	var_117_1(var_117_0, var_1_10004.PHOTO_CALL, "SettingCamera", arg_117_0.cameraSettings)

	return
end

function var_0_1.SetAllAnimSpeed(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0.scene
	local var_118_1 = var_2.emit

	Dorm3dRoomTemplateScene = var_1_10005

	var_118_1(var_118_0, var_1_10005.PHOTO_CALL, "SetCharacterAnimSpeed", arg_118_1)

	local var_118_2 = arg_118_0.scene
	local var_118_3 = var_2.emit

	Dorm3dRoomTemplateScene = var_5

	var_118_3(var_118_2, var_5.PHOTO_CALL, "SetSceneAnimSpeed", arg_118_0.cacheSceneAnim, arg_118_1)

	local var_118_4 = arg_118_0.scene
	local var_118_5 = var_2.emit

	Dorm3dRoomTemplateScene = var_5

	var_118_5(var_118_4, var_5.PHOTO_CALL, "SetExtraAnimSpeed", arg_118_0.cacheExtraItem, arg_118_1)

	return
end

function var_0_1.UpdateAnimSpeedPanel(arg_119_0)
	local function var_119_0()
		if not arg_119_0.timerAnim then
			return
		end

		local var_120_0 = arg_119_0.animInfo.animPlayList[var_0.index]

		math = var_2

		local var_120_1 = var_2.max(var_0_3, var_120_0:GetAnimTime())
		local var_120_2 = var_0.startStamp

		Time = var_4

		local var_120_3 = var_4.time

		math = var_5
		var_0.ratio = var_5.min(1, var_0.ratio + (var_120_3 - var_120_2) * arg_119_0.animSpeed / var_120_1)
		var_0.startStamp = var_120_3

		return
	end

	local var_119_1 = arg_119_0.animSpeeds

	UIItemList = var_1_10003

	local var_119_2 = var_1_10003.StaticAlign
	local var_119_3 = arg_119_0.listAnimSpeed
	local var_119_4 = arg_119_0.listAnimSpeed

	var_119_2(var_119_3, var_6.GetChild(var_119_4, 0), #var_119_1, function(arg_121_0, arg_121_1, arg_121_2)
		UIItemList = var_2_10003

		if arg_121_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_121_1 = #var_119_1 - arg_121_1

		local var_121_0 = var_119_1[arg_121_1]

		setText = var_2_10004

		var_2_10004(arg_121_2:Find("Name"), var_121_0)

		setText = var_2_10004

		var_2_10004(arg_121_2:Find("Selected"), var_121_0)

		setActive = var_2_10004

		var_2_10004(arg_121_2:Find("Line"), arg_121_1 ~= #var_119_1)

		onButton = var_2_10004

		local var_121_1 = arg_119_0
		local var_121_2 = arg_121_2

		local function var_121_3()
			if arg_119_0.animSpeed == var_121_0 then
				return
			end

			var_119_0()

			arg_119_0.animSpeed = var_121_0

			local var_122_0 = arg_119_0

			var_0.SetAllAnimSpeed(var_122_0, var_121_0)

			local var_122_1 = arg_119_0

			var_0.UpdateAnimSpeedPanel(var_122_1)

			return
		end

		SFX_PANEL = var_9

		var_2_10004(var_121_1, var_121_2, var_121_3, var_9)

		return
	end)

	onButton = var_119_2

	local var_119_5 = arg_119_0
	local var_119_6 = arg_119_0.btnFreeze

	local function var_119_7()
		local var_123_0 = 0

		if arg_119_0.animSpeed ~= 0 then
			arg_119_0.lastAnimSpeed = arg_119_0.animSpeed
		else
			var_123_0 = arg_119_0.lastAnimSpeed or 1
			arg_119_0.lastAnimSpeed = nil
		end

		var_119_0()

		arg_119_0.animSpeed = var_123_0

		local var_123_1 = arg_119_0

		var_1.SetAllAnimSpeed(var_123_1, var_123_0)

		local var_123_2 = arg_119_0

		var_1.UpdateAnimSpeedPanel(var_123_2)

		return
	end

	SFX_PANEL = var_8

	var_119_2(var_119_5, var_119_6, var_119_7, var_8)

	UIItemList = var_119_2

	local var_119_8 = var_119_2.StaticAlign
	local var_119_9 = arg_119_0.listAnimSpeed
	local var_119_10 = arg_119_0.listAnimSpeed

	var_119_8(var_119_9, var_6.GetChild(var_119_10, 0), #var_119_1, function(arg_124_0, arg_124_1, arg_124_2)
		UIItemList = var_2_10003

		if arg_124_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_124_1 = #var_119_1 - arg_124_1

		local var_124_0 = var_119_1[arg_124_1]

		setActive = var_2_10004

		var_2_10004(arg_124_2:Find("Name"), arg_119_0.animSpeed ~= var_124_0)

		setActive = var_2_10004

		var_2_10004(arg_124_2:Find("Selected"), arg_119_0.animSpeed == var_124_0)

		return
	end)

	setActive = var_119_8

	local var_119_11 = arg_119_0.btnFreeze

	var_119_8(var_5.Find(var_119_11, "Icon"), arg_119_0.animSpeed ~= 0)

	setActive = var_119_8

	local var_119_12 = arg_119_0.btnFreeze

	var_119_8(var_5.Find(var_119_12, "Selected"), arg_119_0.animSpeed == 0)

	setText = var_119_8

	local var_119_13 = arg_119_0.textAnimSpeed

	i18n = var_6

	local var_119_14 = "dorm3d_photo_animspeed"

	string = var_9

	var_119_8(var_119_13, var_6(var_119_14, var_9.format("%.1f", arg_119_0.animSpeed)))

	return
end

function var_0_1.UpdateLightingPanel(arg_125_0)
	if not arg_125_0.activeSetting then
		return
	end

	if arg_125_0.activePanel ~= var_0_1.PANEL.LIGHTING then
		return
	end

	local var_125_0 = {}

	ipairs = var_2
	pg = var_1_10004

	for iter_125_0, iter_125_1 in var_2(var_1_10004.dorm3d_camera_volume_template.all) do
		table = var_1_10007

		var_1_10007.insert(var_125_0, iter_125_1)
	end

	table = var_2

	var_2.sort(var_125_0, function(arg_126_0, arg_126_1)
		return arg_126_0 < arg_126_1
	end)

	local function var_125_1()
		local var_127_1

		if not arg_125_0.settingFilterIndex then
			local var_127_0 = arg_125_0.scene

			var_127_1 = var_127_1.emit
			Dorm3dRoomTemplateScene = var_2_10003

			var_127_1(var_127_0, var_2_10003.PHOTO_CALL, "RevertVolumeProfile")

			return
		end

		pg = var_127_1

		local var_127_2 = var_127_1.dorm3d_camera_volume_template[var_125_0[arg_125_0.settingFilterIndex]]
		local var_127_3 = arg_125_0.scene
		local var_127_4 = var_1.emit

		Dorm3dRoomTemplateScene = var_2_10004

		var_127_4(var_127_3, var_2_10004.PHOTO_CALL, "SetVolumeProfile", var_127_2.volume, arg_125_0.settingFilterStrength)

		return
	end

	UIItemList = var_3

	local var_125_2 = var_3.StaticAlign
	local var_125_3 = arg_125_0.panelLightning
	local var_125_4 = var_5.Find(var_125_3, "Layout/Filter/List")
	local var_125_5 = arg_125_0.panelLightning
	local var_125_6 = var_6.Find(var_125_5, "Layout/Filter/List")

	var_125_2(var_125_4, var_6.GetChild(var_125_6, 0), #var_125_0, function(arg_128_0, arg_128_1, arg_128_2)
		UIItemList = var_2_10003

		if arg_128_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_128_1 = arg_128_1 + 1
		pg = var_3

		local var_128_0 = var_3.dorm3d_camera_volume_template[var_125_0[arg_128_1]]

		setText = var_4

		var_4(arg_128_2:Find("Name"), var_128_0.name)

		var_128_0.icon = ""

		if var_128_0.icon ~= "" then
			GetImageSpriteFromAtlasAsync = var_4
			string = var_6

			var_4(var_6.format("Dorm3DPhoto/%s", var_128_0.icon), "", arg_128_2:Find("BG"))
		end

		if arg_125_0.settingFilterIndex == arg_128_1 then
			setActive = var_4

			var_4(arg_128_2:Find("Selected"), true)
		else
			setActive = var_4

			var_4(arg_128_2:Find("Selected"), false)
		end

		ApartmentProxy = var_4

		local var_128_1, var_128_2 = var_4.CheckUnlockConfig(var_128_0.unlock)

		setActive = var_6

		var_6(arg_128_2:Find("lock"), not var_128_1)

		if not var_128_1 then
			setText = var_6

			var_6(arg_128_2:Find("lock/Image/Text"), var_128_0.unlock_text)
		end

		onButton = var_6

		local var_128_3 = arg_125_0
		local var_128_4 = arg_128_2

		local function var_128_5()
			if not var_128_1 then
				pg = var_0

				local var_129_0 = var_0.TipsMgr.GetInstance()

				var_0.ShowTips(var_129_0, var_128_2)

				return
			end

			local var_129_1 = arg_125_0.settingFilterIndex

			if arg_125_0.settingFilterIndex ~= arg_128_1 then
				arg_125_0.settingFilterIndex = arg_128_1
			else
				arg_125_0.settingFilterIndex = nil
			end

			var_125_1()

			if var_129_1 then
				local var_129_2 = arg_125_0.panelLightning
				local var_129_3 = var_1.Find(var_129_2, "Layout/Filter/List")
				local var_129_4 = var_1.GetChild(var_129_3, var_129_1 - 1)

				setActive = var_2

				var_2(var_129_4:Find("Selected"), false)
			end

			if arg_125_0.settingFilterIndex == arg_128_1 then
				setActive = var_1

				local var_129_5 = arg_128_2

				var_1(var_3.Find(var_129_5, "Selected"), true)
			end

			return
		end

		SFX_PANEL = var_11

		var_6(var_128_3, var_128_4, var_128_5, var_11)

		return
	end)

	setActive = var_125_2

	local var_125_7 = arg_125_0.panelLightning

	var_125_2(var_5.Find(var_125_7, "Layout/Filter/Slider"), false)

	return
end

function var_0_1.OnSwitchSkin(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_131_0)
			if arg_130_0.settingHideCharacter then
				local var_131_0 = arg_130_0.scene
				local var_131_1 = var_1.emit

				Dorm3dRoomTemplateScene = var_2_10004

				var_131_1(var_131_0, var_2_10004.PHOTO_CALL, "RevertCharacterBylayer")
			end

			local var_131_2 = arg_130_1

			var_1.SwitchCharacterSkin(var_131_2, arg_130_2, arg_130_3, arg_131_0)

			return
		end,
		function(arg_132_0)
			setActive = var_2_10001

			var_2_10001(arg_130_1.ladySafeCollider, true)

			if not arg_130_0.animInfo then
				return arg_132_0()
			end

			for iter_132_0 = #arg_130_0.animInfo.animPlayList, 1, -1 do
				local var_132_0 = var_1.animPlayList[iter_132_0]

				if #var_6.GetStartPoint(var_132_0) > 0 then
					local var_132_1 = arg_130_0.scene
					local var_132_2 = var_8.emit

					Dorm3dRoomTemplateScene = var_2_10011

					var_132_2(var_132_1, var_2_10011.PHOTO_CALL, "ResetCurrentCharPoint", var_2_10007)

					break
				end

				if iter_132_0 == 1 then
					local var_132_3 = arg_130_0.room
					local var_132_4 = var_8.GetCameraZones(var_132_3)[arg_130_0.zoneIndex]
					local var_132_5 = arg_130_0.scene
					local var_132_6 = var_10.emit

					Dorm3dRoomTemplateScene = var_2_10013

					var_132_6(var_132_5, var_2_10013.PHOTO_CALL, "ResetCurrentCharPoint", var_132_4:GetWatchCameraName())
				end
			end

			local var_132_7 = arg_130_0.scene
			local var_132_8 = var_2.emit

			Dorm3dRoomTemplateScene = iter_132_0

			var_132_8(var_132_7, iter_132_0.PHOTO_CALL, "SyncCurrentInterestTransform")

			local var_132_9 = var_1.animPlayList[#var_1.animPlayList]
			local var_132_10 = var_2.GetAnimTime(var_132_9)
			local var_132_11 = arg_130_0.scene
			local var_132_12 = var_4.emit

			Dorm3dRoomTemplateScene = var_2_10007

			var_132_12(var_132_11, var_2_10007.PHOTO_CALL, "PlayCurrentSingleAction", var_2:GetStateName())

			local var_132_13 = arg_130_0.scene.ladyDict[arg_130_2].ladyAnimator

			var_5.Update(var_132_13, var_132_10)

			local var_132_14 = arg_130_0.timerAnim

			var_5.Stop(var_132_14)

			arg_130_0.timerAnim = nil
			arg_130_0.animInfo = nil
			arg_130_0.animPlaying = nil

			arg_132_0()

			return
		end,
		function()
			local var_133_0 = arg_130_0

			var_0.UpdateActionPanel(var_133_0)

			if arg_130_0.settingHideCharacter then
				local var_133_1 = arg_130_0.scene
				local var_133_2 = var_0.emit

				Dorm3dRoomTemplateScene = var_2_10003

				var_133_2(var_133_1, var_2_10003.PHOTO_CALL, "HideCharacterBylayer")
			end

			return
		end
	})

	return
end

function var_0_1.SetMute(arg_134_0)
	if arg_134_0 then
		pg = var_1_10001

		local var_134_0 = var_1_10001.CriMgr.GetInstance()

		var_1_10001.MuteAllVolume(var_134_0)
	else
		pg = var_1_10001

		local var_134_1 = var_1_10001.CriMgr.GetInstance()

		var_1.ResetAllVolume(var_134_1)
	end

	return
end

function var_0_1.willExit(arg_135_0)
	local var_135_0 = arg_135_0.loader

	var_1.Clear(var_135_0)

	if arg_135_0.timerAnim then
		local var_135_1 = arg_135_0.timerAnim

		var_1.Stop(var_135_1)

		arg_135_0.timerAnim = nil
	end

	if arg_135_0.animSpeed ~= 1 then
		arg_135_0:SetAllAnimSpeed(1)
	end

	if arg_135_0.settingHideCharacter then
		local var_135_2 = arg_135_0.scene
		local var_135_3 = var_1.emit

		Dorm3dRoomTemplateScene = var_1_10004

		var_135_3(var_135_2, var_1_10004.PHOTO_CALL, "RevertCharacterBylayer")
	end

	if not arg_135_0.settingFaceCamera then
		local var_135_4 = arg_135_0.scene
		local var_135_5 = var_1.emit

		Dorm3dRoomTemplateScene = var_1_10004

		var_135_5(var_135_4, var_1_10004.PHOTO_CALL, "EnableCurrentHeadIK", true)
	end

	local var_135_6 = arg_135_0.scene
	local var_135_7 = var_1.emit

	Dorm3dRoomTemplateScene = var_1_10004

	var_135_7(var_135_6, var_1_10004.PHOTO_CALL, "ResetSceneItemAnimators")

	local var_135_8 = arg_135_0.scene
	local var_135_9 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_9(var_135_8, var_4.PHOTO_CALL, "ResetCharacterExtraItem")

	local var_135_10 = arg_135_0.scene
	local var_135_11 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_11(var_135_10, var_4.PHOTO_CALL, "ResetTempHideSceneItems")

	local var_135_12 = arg_135_0.scene
	local var_135_13 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_13(var_135_12, var_4.PHOTO_CALL, "RevertCharacterLight")

	local var_135_14 = arg_135_0.scene
	local var_135_15 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_15(var_135_14, var_4.PHOTO_CALL, "RevertVolumeProfile")

	local var_135_16 = arg_135_0.scene
	local var_135_17 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_17(var_135_16, var_4.PHOTO_CALL, "RevertCameraSettings")

	local var_135_18 = arg_135_0.scene
	local var_135_19 = var_1.emit

	Dorm3dRoomTemplateScene = var_4

	var_135_19(var_135_18, var_4.PHOTO_CALL, "ExitPhotoMode")

	return
end

function var_0_1.SetPhotoCameraSliderValue(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0.normalPanel
	local var_136_1 = var_2.Find(var_136_0, "Zoom/Slider")

	setSlider = var_1_10003

	var_1_10003(var_136_1, 0, 1, arg_136_1)

	return
end

function var_0_1.SetPhotoStickDelta(arg_137_0, arg_137_1)
	arg_137_1 = arg_137_1 * 0.5

	local var_137_0 = arg_137_0._tf
	local var_137_1 = var_2.Find(var_137_0, "Center/Stick").rect.height
	local var_137_2 = var_2.rect.width
	local var_137_3

	var_137_3, setAnchoredPosition = var_2:Find("Handler"), var_1_10006
	Vector2 = var_1_10009

	var_1_10006(var_137_3, var_1_10009.New(var_137_1 * arg_137_1.x, var_137_2 * arg_137_1.y))

	return
end

return var_0_1
