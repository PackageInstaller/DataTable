class = var_0_10000

local var_0_0 = "Dorm3dPhotoARLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dARPhotoUI"
end

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

	var_1(var_2.Find(var_2_7, "Mask"), false)

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

	arg_2_0.btnZone = var_1.Find(var_2_15, "Center/Zone")

	local var_2_16 = arg_2_0._tf

	arg_2_0.btnAr = var_1.Find(var_2_16, "Center/Ar")

	local var_2_17 = arg_2_0._tf

	arg_2_0.btnAnimSpeed = var_1.Find(var_2_17, "Center/AnimSpeed")

	local var_2_18 = arg_2_0.btnAnimSpeed

	arg_2_0.listAnimSpeed = var_1.Find(var_2_18, "Bar")
	setActive = var_1

	var_1(arg_2_0.listAnimSpeed, false)

	local var_2_19 = arg_2_0.btnAnimSpeed

	arg_2_0.textAnimSpeed = var_1.Find(var_2_19, "Text")

	local var_2_20 = arg_2_0._tf

	arg_2_0.hideuiMask = var_1.Find(var_2_20, "RightTop/Mask")
	setActive = var_1

	var_1(arg_2_0.hideuiMask, false)

	local var_2_21 = arg_2_0._tf

	arg_2_0.btnFilm = var_1.Find(var_2_21, "RightTop/Film/Film")

	local var_2_22 = arg_2_0._tf

	arg_2_0.filmTime = var_1.Find(var_2_22, "RightTop/FilmTime")
	setActive = var_1

	var_1(arg_2_0.filmTime, false)

	local var_2_23 = arg_2_0._tf

	arg_2_0.shareUI = var_1.Find(var_2_23, "ShareUI")
	setActive = var_1

	var_1(arg_2_0.shareUI, false)

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_1.Find(var_2_24, "Shoter")
	local var_2_26 = var_1.GetComponent

	typeof = var_3
	YSTool = var_4
	arg_2_0.ysScreenShoter = var_2_26(var_2_25, var_3(var_4.YSScreenShoter))
	setText = var_1

	local var_2_27 = arg_2_0.panelCamera
	local var_2_28 = var_2.Find(var_2_27, "Layout/DepthOfField/Title/Text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("dorm3d_photo_len"))

	setText = var_1

	local var_2_29 = arg_2_0.panelCamera
	local var_2_30 = var_2.Find(var_2_29, "Layout/DepthOfField/Switch/Title")

	i18n = var_2_29

	var_1(var_2_30, var_2_29("dorm3d_photo_depthoffield"))

	setText = var_1

	local var_2_31 = arg_2_0.panelCamera
	local var_2_32 = var_2.Find(var_2_31, "Layout/DepthOfField/DepthOfField/FocusDistance/Title")

	i18n = var_2_31

	var_1(var_2_32, var_2_31("dorm3d_photo_focusdistance"))

	setText = var_1

	local var_2_33 = arg_2_0.panelCamera
	local var_2_34 = var_2.Find(var_2_33, "Layout/DepthOfField/DepthOfField/BlurRadius/Title")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("dorm3d_photo_focusstrength"))

	setText = var_1

	local var_2_35 = arg_2_0.panelCamera
	local var_2_36 = var_2.Find(var_2_35, "Layout/Paramaters/Title/Text")

	i18n = var_2_35

	var_1(var_2_36, var_2_35("dorm3d_photo_paramaters"))

	setText = var_1

	local var_2_37 = arg_2_0.panelCamera
	local var_2_38 = var_2.Find(var_2_37, "Layout/Paramaters/PostExposure/PostExposure/Title")

	i18n = var_2_37

	var_1(var_2_38, var_2_37("dorm3d_photo_postexposure"))

	setText = var_1

	local var_2_39 = arg_2_0.panelCamera
	local var_2_40 = var_2.Find(var_2_39, "Layout/Paramaters/Saturation/Saturation/Title")

	i18n = var_2_39

	var_1(var_2_40, var_2_39("dorm3d_photo_saturation"))

	setText = var_1

	local var_2_41 = arg_2_0.panelCamera
	local var_2_42 = var_2.Find(var_2_41, "Layout/Paramaters/Contrast/Contrast/Title")

	i18n = var_2_41

	var_1(var_2_42, var_2_41("dorm3d_photo_contrast"))

	setText = var_1

	local var_2_43 = arg_2_0.panelCamera
	local var_2_44 = var_2.Find(var_2_43, "Layout/Other/Title/Text")

	i18n = var_2_43

	var_1(var_2_44, var_2_43("dorm3d_photo_Others"))

	setText = var_1

	local var_2_45 = arg_2_0.panelCamera
	local var_2_46 = var_2.Find(var_2_45, "Layout/Other/HideCharacter/Title")

	i18n = var_2_45

	var_1(var_2_46, var_2_45("dorm3d_photo_hidecharacter"))

	setText = var_1

	local var_2_47 = arg_2_0.panelCamera
	local var_2_48 = var_2.Find(var_2_47, "Layout/Other/FaceCamera/Title")

	i18n = var_2_47

	var_1(var_2_48, var_2_47("dorm3d_photo_facecamera"))

	setText = var_1

	local var_2_49 = arg_2_0.panelLightning
	local var_2_50 = var_2.Find(var_2_49, "Layout/Title/Lighting/Name")

	i18n = var_2_49

	var_1(var_2_50, var_2_49("dorm3d_photo_lighting"))

	setText = var_1

	local var_2_51 = arg_2_0.panelLightning
	local var_2_52 = var_2.Find(var_2_51, "Layout/Title/Lighting/Selected")

	i18n = var_2_51

	var_1(var_2_52, var_2_51("dorm3d_photo_lighting"))

	setText = var_1

	local var_2_53 = arg_2_0.panelLightning
	local var_2_54 = var_2.Find(var_2_53, "Layout/Title/Filter/Name")

	i18n = var_2_53

	var_1(var_2_54, var_2_53("dorm3d_photo_filter"))

	setText = var_1

	local var_2_55 = arg_2_0.panelLightning
	local var_2_56 = var_2.Find(var_2_55, "Layout/Title/Filter/Selected")

	i18n = var_2_55

	var_1(var_2_56, var_2_55("dorm3d_photo_filter"))

	setText = var_1

	local var_2_57 = arg_2_0.panelLightning
	local var_2_58 = var_2.Find(var_2_57, "Layout/Lighting/Strength/Name")

	i18n = var_2_57

	var_1(var_2_58, var_2_57("dorm3d_photo_strength"))

	setText = var_1

	local var_2_59 = arg_2_0.panelAction
	local var_2_60 = var_2.Find(var_2_59, "Layout/Title/Regular/Name")

	i18n = var_2_59

	var_1(var_2_60, var_2_59("dorm3d_photo_regular_anim"))

	setText = var_1

	local var_2_61 = arg_2_0.panelAction
	local var_2_62 = var_2.Find(var_2_61, "Layout/Title/Regular/Selected")

	i18n = var_2_61

	var_1(var_2_62, var_2_61("dorm3d_photo_regular_anim"))

	setText = var_1

	local var_2_63 = arg_2_0.panelAction
	local var_2_64 = var_2.Find(var_2_63, "Layout/Title/Special/Name")

	i18n = var_2_63

	var_1(var_2_64, var_2_63("dorm3d_photo_special_anim"))

	setText = var_1

	local var_2_65 = arg_2_0.panelAction
	local var_2_66 = var_2.Find(var_2_65, "Layout/Title/Special/Selected")

	i18n = var_2_65

	var_1(var_2_66, var_2_65("dorm3d_photo_special_anim"))

	local var_2_67 = arg_2_0._tf

	arg_2_0.stopRecBtn = var_1.Find(var_2_67, "stopRec")

	local var_2_68 = arg_2_0._tf

	arg_2_0.videoTipPanel = var_1.Find(var_2_68, "videoTipPanel")
	setActive = var_1

	var_1(arg_2_0.videoTipPanel, false)

	return
end

function var_0_1.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_1.SetRoom(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ApartmentProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	arg_4_0.room = var_2.getRoom(var_4_0, arg_4_1)

	return
end

function var_0_1.SetGroupId(arg_5_0, arg_5_1)
	arg_5_0.groupId = arg_5_1

	return
end

function var_0_1.SetARLite(arg_6_0, arg_6_1)
	local var_6_0 = {
		5,
		6,
		7
	}

	arg_6_0.ARState = arg_6_1
	table = var_1_10003
	arg_6_0.ARCheck = var_1_10003.contains(var_6_0, arg_6_1)
	GraphApiHelper = var_3

	if var_3.IsUsingVulkan() then
		arg_6_0.ARCheck = false
	end

	local var_6_2

	if arg_6_0.ARCheck then
		GameObject = var_6_2

		local var_6_1 = var_6_2.Find("AR/XR Origin/Camera Offset/Main Camera")

		var_6_2 = var_6_2.GetComponent
		typeof = var_5
		Camera = var_1_10006
		arg_6_0.mainCamera = var_6_2(var_6_1, var_5(var_1_10006))
	else
		GameObject = var_6_2

		local var_6_3 = var_6_2.Find("FakeAR/Main Camera")
		local var_6_4 = var_3.GetComponent

		typeof = var_5
		Camera = var_1_10006
		arg_6_0.mainCamera = var_6_4(var_6_3, var_5(var_1_10006))
	end

	return
end

function var_0_1.onBackPressed(arg_7_0)
	if arg_7_0.recordState then
		triggerButton = var_1

		var_1(arg_7_0.btnFilm)

		return
	end

	if arg_7_0.activeSetting then
		triggerButton = var_1

		local var_7_0 = arg_7_0._tf

		var_1(var_2.Find(var_7_0, "Center/Settings/Back"))

		return
	end

	arg_7_0:closeView()

	return
end

function var_0_1.didEnter(arg_8_0)
	setActive = var_1_10001

	local var_8_0 = arg_8_0._tf

	var_1_10001(var_2.Find(var_8_0, "Center/Normal/Back"), false)

	onButton = var_1_10001

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0._tf
	local var_8_3 = var_3.Find(var_8_2, "Center/Normal/Back")

	local function var_8_4()
		local var_9_0 = arg_8_0

		var_0.onBackPressed(var_9_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_8_1, var_8_3, var_8_4, var_5)

	local var_8_5 = arg_8_0.normalPanel
	local var_8_6 = var_1.Find(var_8_5, "Zoom/Slider")

	setSlider = var_8_5

	var_8_5(var_8_6, 0, 1, 0)

	onSlider = var_8_5

	var_8_5(arg_8_0, var_8_6, function(arg_10_0)
		local var_10_0 = (1 - arg_10_0) * 0.5 + 0.5
		local var_10_1 = arg_8_0
		local var_10_2 = var_2.emit

		Dorm3dPhotoARMediator = var_2_10004

		var_10_2(var_10_1, var_2_10004.SCENE_CALL, "SetPinchValue", var_10_0)

		return
	end)

	arg_8_0.activeSetting = false
	onButton = var_2

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0._tf
	local var_8_9 = var_4.Find(var_8_8, "Center/Normal/Settings")

	local function var_8_10()
		local var_11_0 = arg_8_0

		var_11_0.activeSetting = true
		quickPlayAnimation = var_11_0

		local var_11_1 = arg_8_0._tf

		var_11_0(var_1.Find(var_11_1, "Center"), "anim_dorm3d_photo_normal_out")

		local var_11_2 = arg_8_0
		local var_11_3 = var_0.emit

		Dorm3dPhotoARMediator = var_2

		var_11_3(var_11_2, var_2.ACTIVE_AR_UI, false)

		local var_11_4 = arg_8_0

		var_0.UpdateActionPanel(var_11_4)

		return
	end

	SFX_PANEL = var_6

	var_2(var_8_7, var_8_9, var_8_10, var_6)

	onButton = var_2

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0._tf
	local var_8_13 = var_4.Find(var_8_12, "Center/Settings/Back")

	local function var_8_14()
		local var_12_0 = arg_8_0

		var_12_0.activeSetting = false
		quickPlayAnimation = var_12_0

		local var_12_1 = arg_8_0._tf

		var_12_0(var_1.Find(var_12_1, "Center"), "anim_dorm3d_photo_normal_in")

		local var_12_2 = arg_8_0
		local var_12_3 = var_0.emit

		Dorm3dPhotoARMediator = var_2

		var_12_3(var_12_2, var_2.ACTIVE_AR_UI, true)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_8_11, var_8_13, var_8_14, var_6)

	arg_8_0.hideUI = false
	onButton = var_2

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.btnHideUI

	local function var_8_17()
		if arg_8_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_8_0.hideuiMask, true)

		setActive = var_0

		var_0(arg_8_0.centerPanel, false)

		arg_8_0.hideUI = true

		return
	end

	SFX_PANEL = var_6

	var_2(var_8_15, var_8_16, var_8_17, var_6)

	onButton = var_2

	var_2(arg_8_0, arg_8_0.hideuiMask, function()
		if not arg_8_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_8_0.centerPanel, true)

		setActive = var_0

		var_0(arg_8_0.hideuiMask, false)

		arg_8_0.hideUI = false

		return
	end)

	onButton = var_2

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.btnReset

	local function var_8_20()
		local var_15_0 = arg_8_0
		local var_15_1 = var_0.emit

		Dorm3dPhotoARMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.SCENE_CALL, "ResetPhotoCameraPosition")

		return
	end

	SFX_PANEL = var_6

	var_2(var_8_18, var_8_19, var_8_20, var_6)

	onButton = var_2

	local var_8_21 = arg_8_0
	local var_8_22 = arg_8_0.btnFilm

	local function var_8_23()
		local function var_16_0(arg_17_0)
			setActive = var_3_10001

			var_3_10001(arg_8_0.centerPanel, arg_17_0)

			local var_17_0 = arg_8_0._tf
			local var_17_1 = var_1.Find(var_17_0, "RightTop")

			var_1.GetComponent(var_17_1, "CanvasGroup").alpha = arg_17_0 and 1 or 0

			local var_17_2 = arg_8_0
			local var_17_3 = var_1.emit

			Dorm3dPhotoARMediator = var_3

			var_17_3(var_17_2, var_3.ACTIVE_AR_UI, arg_17_0)

			return
		end

		if not arg_8_0.recordState then
			local function var_16_1(arg_18_0)
				if not arg_18_0 then
					var_16_0(true)

					local var_18_0 = arg_8_0

					var_18_0.recordState = false
					LeanTween = var_18_0

					var_18_0.moveX(arg_8_0.stopRecBtn, arg_8_0.stopRecBtn.rect.width, 0.15)
				else
					arg_8_0.recordState = true
				end

				return
			end

			local function var_16_2()
				setActive = var_3_10000

				var_3_10000(arg_8_0.stopRecBtn, true)

				LeanTween = var_3_10000

				local var_19_0 = var_3_10000.moveX(arg_8_0.stopRecBtn, 0, 0.15)
				local var_19_1 = var_0.setOnComplete

				System = var_2

				var_19_1(var_19_0, var_2.Action(function()
					var_0_1.SetMute(true)

					local var_20_0 = arg_8_0

					YSNormalTool = var_1
					var_20_0.recordFilePath = var_1.RecordTool.GenRecordFilePath()
					YSNormalTool = var_20_0

					var_20_0.RecordTool.StartRecording(var_16_1, arg_8_0.recordFilePath)

					return
				end))

				return
			end

			seriesAsync = var_2_10003

			var_2_10003({
				function(arg_21_0)
					PermissionHelper = var_3_10001

					var_3_10001.Request3DDorm(arg_21_0, nil)

					return
				end,
				function(arg_22_0)
					var_16_0(false)

					PlayerPrefs = var_1

					if not var_1.GetInt("hadShowForVideoTipDorm", 0) or var_1 <= 0 then
						PlayerPrefs = var_2

						var_2.SetInt("hadShowForVideoTipDorm", 1)

						local var_22_0 = arg_8_0.videoTipPanel
						local var_22_1 = var_2.Find(var_22_0, "Text")
						local var_22_2 = var_2.GetComponent(var_22_1, "Text")

						i18n = var_22_1
						var_22_2.text = var_22_1("word_take_video_tip")
						onButton = var_22_2

						var_22_2(arg_8_0, arg_8_0.videoTipPanel, function()
							setActive = var_4_10000

							var_4_10000(arg_8_0.videoTipPanel, false)
							var_16_2()

							return
						end)

						setActive = var_22_2

						var_22_2(arg_8_0.videoTipPanel, true)
					else
						var_16_2()
					end

					return
				end
			})
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_8_21, var_8_22, var_8_23, var_6)

	onButton = var_2

	var_2(arg_8_0, arg_8_0.stopRecBtn, function()
		local function var_24_0(arg_25_0)
			if arg_25_0 then
				PLATFORM = var_3_10001
				PLATFORM_ANDROID = var_3_10002

				if var_3_10001 == var_3_10002 then
					pg = var_3_10001

					local var_25_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_25_1 = var_1.ShowMsgBox
					local var_25_2 = {}

					i18n = var_3_10004
					var_25_2.content = var_3_10004("word_save_video")

					function var_25_2.onNo()
						System = var_4_10000

						if var_4_10000.IO.File.Exists(arg_8_0.recordFilePath) then
							System = var_0

							var_0.IO.File.Delete(arg_8_0.recordFilePath)
						end

						return
					end

					function var_25_2.onYes()
						YSNormalTool = var_4_10000

						var_4_10000.MediaTool.SaveVideoToAlbum(arg_8_0.recordFilePath, function(arg_28_0, arg_28_1)
							if arg_28_0 then
								pg = var_5_10002

								local var_28_0 = var_5_10002.TipsMgr.GetInstance()
								local var_28_1 = var_2.ShowTips

								i18n = var_5_10004

								var_28_1(var_28_0, var_5_10004("word_save_ok"))

								System = var_28_1

								if var_28_1.IO.File.Exists(arg_8_0.recordFilePath) then
									System = var_2

									var_2.IO.File.Delete(arg_8_0.recordFilePath)
								end
							end

							return
						end)

						return
					end

					var_25_1(var_25_0, var_25_2)
				end
			end

			arg_8_0.recordState = false

			return
		end

		local function var_24_1(arg_29_0)
			setActive = var_3_10001

			var_3_10001(arg_8_0.centerPanel, arg_29_0)

			local var_29_0 = arg_8_0._tf
			local var_29_1 = var_1.Find(var_29_0, "RightTop")

			var_1.GetComponent(var_29_1, "CanvasGroup").alpha = arg_29_0 and 1 or 0

			local var_29_2 = arg_8_0
			local var_29_3 = var_1.emit

			Dorm3dPhotoARMediator = var_3

			var_29_3(var_29_2, var_3.ACTIVE_AR_UI, arg_29_0)

			return
		end

		LeanTween = var_2_10002

		local var_24_2 = var_2_10002.isTweening

		go = var_2_10003

		if not var_24_2(var_2_10003(arg_8_0.stopRecBtn)) then
			LeanTween = var_2

			local var_24_3 = var_2.moveX(arg_8_0.stopRecBtn, arg_8_0.stopRecBtn.rect.width, 0.15)
			local var_24_4 = var_2.setOnComplete

			System = var_4

			var_24_4(var_24_3, var_4.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_8_0.stopRecBtn, false)

				seriesAsync = var_3_10000

				var_3_10000({
					function(arg_31_0)
						YSNormalTool = var_4_10001

						var_4_10001.RecordTool.StopRecording(var_24_0)
						var_24_1(true)
						var_0_1.SetMute(false)

						return
					end
				})

				return
			end))
		end

		return
	end)

	setActive = var_2

	var_2(arg_8_0.stopRecBtn, false)

	onButton = var_2

	local var_8_24 = arg_8_0
	local var_8_25 = arg_8_0._tf
	local var_8_26 = var_4.Find(var_8_25, "RightTop/Film/Switch")

	local function var_8_27()
		GetOrAddComponent = var_2_10000

		local var_32_0 = arg_8_0._tf
		local var_32_1 = var_1.Find(var_32_0, "RightTop/Film")

		typeof = var_32_0
		CanvasGroup = var_3
		var_2_10000(var_32_1, var_32_0(var_3)).blocksRaycasts = false
		quickPlayAnimation = var_1

		local var_32_2 = arg_8_0._tf

		var_1(var_2.Find(var_32_2, "RightTop"), "anim_dorm3d_photo_FtoS")

		return
	end

	SFX_PANEL = var_6

	var_2(var_8_24, var_8_26, var_8_27, var_6)

	onButton = var_2

	local var_8_28 = arg_8_0
	local var_8_29 = arg_8_0._tf

	var_2(var_8_28, var_4.Find(var_8_29, "RightTop/Shot/Shot"), function()
		local function var_33_0(arg_34_0)
			setActive = var_3_10001

			var_3_10001(arg_8_0.centerPanel, arg_34_0)

			setActive = var_3_10001

			local var_34_0 = arg_8_0._tf

			var_3_10001(var_2.Find(var_34_0, "RightTop"), arg_34_0)

			PlayerPrefs = var_3_10001

			local var_34_1 = var_3_10001.GetInt

			SHOW_TOUCH_EFFECT = var_2

			local var_34_2 = var_34_1(var_2, 1)

			if 0 < var_34_2 then
				setActive = var_2
				pg = var_3

				var_2(var_3.UIMgr.GetInstance().OverlayEffect, arg_34_0)
			end

			return
		end

		local function var_33_1(arg_35_0)
			warning = var_3_10001

			local var_35_0 = "截图结果："

			tostring = var_3_10003

			var_3_10001(var_35_0 .. var_3_10003(arg_35_0))

			return
		end

		local function var_33_2(arg_36_0, arg_36_1)
			local var_36_0 = arg_8_0
			local var_36_1 = var_2.emit

			Dorm3dPhotoARMediator = var_3_10004

			var_36_1(var_36_0, var_3_10004.SHARE_PANEL, arg_36_1, arg_36_0)

			pg = var_36_1

			local var_36_2 = var_36_1.m02
			local var_36_3 = var_2.sendNotification

			GAME = var_4

			local var_36_4 = var_4.APARTMENT_TRACK

			Dorm3dTrackCommand = var_5

			local var_36_5 = var_5.BuildDataCamera
			local var_36_6 = arg_8_0.groupId
			local var_36_7 = 3
			local var_36_8 = arg_8_0.room
			local var_36_9 = var_8.GetConfigID(var_36_8)

			Dorm3dCameraAnim = var_36_8

			local var_36_10 = var_36_8.New({
				configId = arg_8_0.animID
			})

			var_36_3(var_36_2, var_36_4, var_36_5(var_36_6, var_36_7, var_36_9, var_9.GetStateName(var_36_10)))

			return
		end

		local function var_33_3(arg_37_0)
			var_33_1(true)

			Tex2DExtension = var_1

			local var_37_0 = var_1.EncodeToJPG(arg_37_0)

			var_33_2(var_37_0, arg_37_0)

			return
		end

		Dorm3dHxHelper = var_2_10004

		local var_33_4, var_33_5 = var_2_10004.GetHolyLightScreenShotInfo(arg_8_0.contextData.holyLightRoot)

		GraphicsInterface = var_2_10006

		local var_33_6 = var_2_10006.Instance

		var_6.TakePhotoWithPost(var_33_6, arg_8_0.mainCamera, var_33_4, var_33_5, var_33_3)

		return
	end, "ui-dorm_photograph")

	GetOrAddComponent = var_2

	local var_8_30 = arg_8_0._tf
	local var_8_31 = var_3.Find(var_8_30, "RightTop/Film")

	typeof = var_8_30
	CanvasGroup = var_5
	var_2(var_8_31, var_8_30(var_5)).blocksRaycasts = false
	onButton = var_3

	local var_8_32 = arg_8_0
	local var_8_33 = arg_8_0._tf
	local var_8_34 = var_5.Find(var_8_33, "RightTop/Shot/Switch")

	local function var_8_35()
		GetOrAddComponent = var_2_10000

		local var_38_0 = arg_8_0._tf
		local var_38_1 = var_1.Find(var_38_0, "RightTop/Film")

		typeof = var_38_0
		CanvasGroup = var_3
		var_2_10000(var_38_1, var_38_0(var_3)).blocksRaycasts = true
		quickPlayAnimation = var_1

		local var_38_2 = arg_8_0._tf

		var_1(var_2.Find(var_38_2, "RightTop"), "anim_dorm3d_photo_StoF")

		return
	end

	SFX_PANEL = var_7

	var_3(var_8_32, var_8_34, var_8_35, var_7)

	onButton = var_3

	local var_8_36 = arg_8_0
	local var_8_37 = arg_8_0.btnAnimSpeed

	local function var_8_38()
		setActive = var_2_10000

		local var_39_0 = arg_8_0.listAnimSpeed

		isActive = var_2_10002

		var_2_10000(var_39_0, not var_2_10002(arg_8_0.listAnimSpeed))

		return
	end

	SFX_PANEL = var_7

	var_3(var_8_36, var_8_37, var_8_38, var_7)

	onButton = var_3

	local var_8_39 = arg_8_0
	local var_8_40 = arg_8_0.btnZone

	local function var_8_41()
		isActive = var_2_10000

		local var_40_0 = var_2_10000(arg_8_0.listZones)

		setActive = var_1

		var_1(arg_8_0.listZones, not var_40_0)

		return
	end

	SFX_PANEL = var_7

	var_3(var_8_39, var_8_40, var_8_41, var_7)

	onButton = var_3

	var_3(arg_8_0, arg_8_0.zoneMask, function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.listZones, false)

		return
	end)

	onButton = var_3

	var_3(arg_8_0, arg_8_0.btnAr, function()
		local var_42_0 = arg_8_0
		local var_42_1 = var_0.emit

		Dorm3dPhotoMediator = var_2_10002

		var_42_1(var_42_0, var_2_10002.GO_AR)

		return
	end)

	arg_8_0.activePanel = 1

	local var_8_42 = {
		{
			btn = arg_8_0.btnAction,
			On = function()
				local var_43_0 = arg_8_0

				var_0.UpdateActionPanel(var_43_0)

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_8_0.btnCamera,
			On = function()
				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_8_0.btnLighting,
			On = function()
				return
			end,
			Off = function()
				return
			end
		}
	}

	table = var_4

	var_4.Ipairs(var_8_42, function(arg_49_0, arg_49_1)
		onToggle = var_2_10002

		local var_49_0 = arg_8_0
		local var_49_1 = arg_49_1.btn

		local function var_49_2(arg_50_0)
			if not arg_50_0 then
				return
			end

			table = var_3_10001

			var_3_10001.Ipairs(var_8_42, function(arg_51_0, arg_51_1)
				if arg_51_0 == arg_49_0 then
					return
				end

				arg_51_1.Off()

				return
			end)

			arg_8_0.activePanel = arg_49_0

			arg_49_1.On()

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_49_0, var_49_1, var_49_2, var_2_10006)

		return
	end)
	;(function()
		local var_52_0 = {}
		local var_52_1 = arg_8_0.panelAction

		var_52_0[1] = var_1.Find(var_52_1, "Layout/Title/Regular")
		triggerToggle = var_1

		var_1(var_52_0[1], true)

		return
	end)()
	;(function()
		local var_53_0 = {}
		local var_53_1 = arg_8_0.panelLightning

		var_53_0[1] = var_1.Find(var_53_1, "Layout/Title/Lighting")
		triggerToggle = var_1

		var_1(var_53_0[1], true)

		return
	end)()
	arg_8_0:InitData()

	triggerToggle = var_6

	var_6(var_8_42[arg_8_0.activePanel].btn, true)

	local var_8_43 = arg_8_0
	local var_8_44 = arg_8_0.emit

	Dorm3dPhotoARMediator = var_8

	var_8_44(var_8_43, var_8.AR_PHOTO_INITED)

	return
end

function var_0_1.InitData(arg_54_0)
	arg_54_0:RefreshData()

	return
end

function var_0_1.RefreshData(arg_55_0)
	local var_55_0 = arg_55_0.room
	local var_55_1 = var_1.getAllARAnimationListByShip(var_55_0, arg_55_0.groupId)[1]

	arg_55_0.animID = var_2.GetConfigID(var_55_1)
	arg_55_0.animSpeed = 1

	return
end

local var_0_2 = 0.2

function var_0_1.UpdateActionPanel(arg_56_0)
	if not arg_56_0.activeSetting then
		return
	end

	if arg_56_0.activePanel ~= var_0_1.PANEL.ACTION then
		return
	end

	local var_56_0 = arg_56_0.room
	local var_56_1 = var_1.getAllARAnimationListByShip(var_56_0, arg_56_0.groupId)
	local var_56_2 = arg_56_0.panelAction
	local var_56_3 = var_2.Find(var_56_2, "Layout/Regular/Scroll/Viewport/Content")

	local function var_56_4()
		UIItemList = var_2_10000

		local var_57_0 = var_2_10000.StaticAlign
		local var_57_1 = var_56_3
		local var_57_2 = var_56_3

		var_57_0(var_57_1, var_2.GetChild(var_57_2, 0), #var_56_1, function(arg_58_0, arg_58_1, arg_58_2)
			UIItemList = var_3_10003

			if arg_58_0 ~= var_3_10003.EventUpdate then
				return
			end

			arg_58_1 = arg_58_1 + 1

			local var_58_0 = var_56_1[arg_58_1]

			setActive = var_3_10004

			var_3_10004(arg_58_2:Find("Selected"), var_58_0:GetConfigID() == arg_56_0.animID)

			setActive = var_3_10004

			local var_58_1 = arg_58_2:Find("Slider")
			local var_58_2

			if var_58_0:GetConfigID() == arg_56_0.animID then
				tobool = var_6
				var_58_2 = var_6(arg_56_0.timerAnim)
			else
				var_58_2 = false
			end

			if false then
				var_58_2 = true
			end

			var_3_10004(var_58_1, var_58_2)

			return
		end)

		return
	end

	local function var_56_5(arg_59_0, arg_59_1)
		if arg_56_0.animPlaying then
			return
		end

		local var_59_0 = arg_59_0:GetConfigID()

		if arg_56_0.animID == var_59_0 then
			return
		end

		local var_59_1 = arg_56_0
		local var_59_2 = var_3.GetAnimPlayList(var_59_1, var_59_0)

		Dorm3dCameraAnim = var_59_1

		local var_59_3 = var_59_1.New({
			configId = arg_56_0.animID
		})
		local var_59_4 = var_4.GetFinishAnimID(var_59_3)

		arg_56_0.animID = var_59_0

		var_56_4()

		local var_59_5 = arg_56_0

		var_5.BlockActionPanel(var_59_5, true)

		local var_59_6 = arg_56_0

		var_59_6.animPlaying = true
		table = var_59_6

		local var_59_7 = var_59_6.indexof
		local var_59_8 = var_59_2

		_ = var_7

		local var_59_9

		var_59_9 = var_59_7(var_59_8, var_7.detect(var_59_2, function(arg_60_0)
			return arg_60_0:GetConfigID() == var_59_4
		end)) or 0

		local var_59_10 = var_59_9 + 1

		_ = var_59_9

		local var_59_11 = var_59_9.rest(var_59_2, var_59_10)
		local var_59_12 = arg_59_1:Find("Slider")
		local var_59_13 = var_6.GetComponent

		typeof = var_8
		Slider = var_9

		local var_59_14 = var_59_13(var_59_12, var_8(var_9))

		setActive = var_59_12

		var_59_12(arg_59_1:Find("Slider"), true)

		local function var_59_15()
			setActive = var_3_10000

			local var_61_0 = arg_59_1

			var_3_10000(var_1.Find(var_61_0, "Selected"), true)

			setActive = var_3_10000

			local var_61_1 = arg_59_1

			var_3_10000(var_1.Find(var_61_1, "Slider"), false)

			local var_61_2 = arg_56_0

			var_0.BlockActionPanel(var_61_2, false)

			arg_56_0.animPlaying = nil

			return
		end

		if #var_59_11 == 0 then
			var_59_15()

			return
		end

		_ = var_8

		local var_59_16 = var_8.reduce(var_59_11, 0, function(arg_62_0, arg_62_1)
			math = var_3_10002

			return arg_62_0 + var_3_10002.max(var_0_2, arg_62_1:GetAnimTime())
		end)

		if arg_56_0.timerAnim then
			local var_59_17 = arg_56_0.timerAnim

			var_9.Stop(var_59_17)
		end

		local var_59_18 = arg_56_0
		local var_59_19 = {
			index = 1,
			passedTime = 0,
			ratio = 0,
			animPlayList = var_59_11,
			totalTime = var_59_16
		}

		Time = var_11
		var_59_19.startStamp = var_11.time
		var_59_18.animInfo = var_59_19

		local var_59_20 = arg_56_0

		FrameTimer = var_59_19
		var_59_20.timerAnim = var_59_19.New(function()
			local var_63_0 = arg_56_0.animInfo.animPlayList[var_0.index]

			math = var_2

			local var_63_1 = var_2.max
			local var_63_2 = var_0_2
			local var_63_3 = var_63_0
			local var_63_4 = var_63_1(var_63_2, var_63_0.GetAnimTime(var_63_3))
			local var_63_5 = var_0.startStamp

			Time = var_4

			local var_63_6 = var_4.time

			math = var_63_3

			local var_63_7 = var_63_3.min(1, var_0.ratio + (var_63_6 - var_63_5) * arg_56_0.animSpeed / var_63_4)
			local var_63_8 = var_0.passedTime + var_63_4 * var_63_7

			var_59_14.value = var_63_8 / var_59_16

			if var_63_7 < 1 then
				return
			end

			var_0.index = var_0.index + 1
			var_0.ratio = 0
			var_0.passedTime = var_0.passedTime + var_63_4
			var_0.startStamp = var_63_6
			warning = var_7

			var_7(var_0.startStamp)

			if var_0.index > #var_0.animPlayList then
				var_59_15()

				local var_63_9 = arg_56_0.timerAnim

				var_7.Stop(var_63_9)

				arg_56_0.timerAnim = nil
				arg_56_0.animInfo = nil

				return
			end

			local var_63_10 = var_0.animPlayList[var_0.index]
			local var_63_11 = arg_56_0
			local var_63_12 = var_8.emit

			Dorm3dPhotoARMediator = var_3_10010

			var_63_12(var_63_11, var_3_10010.SCENE_CALL, "PlaySingleAction", var_63_10:GetStateName())

			return
		end, 1, -1)

		local var_59_21 = arg_56_0.animInfo.animPlayList[1]

		if var_59_10 == 1 then
			local var_59_22 = arg_56_0
			local var_59_23 = var_10.emit

			Dorm3dPhotoARMediator = var_12

			var_59_23(var_59_22, var_12.SCENE_CALL, "SwitchAnim", var_59_21:GetStateName())

			onNextTick = var_59_23

			var_59_23(function()
				local var_64_0 = arg_56_0
				local var_64_1 = var_0.emit

				Dorm3dPhotoARMediator = var_3_10002

				var_64_1(var_64_0, var_3_10002.SCENE_CALL, "ResetCharPos")

				return
			end)
		else
			local var_59_24 = arg_56_0
			local var_59_25 = var_10.emit

			Dorm3dPhotoARMediator = var_12

			var_59_25(var_59_24, var_12.SCENE_CALL, "PlaySingleAction", var_59_21:GetStateName())
		end

		local var_59_26 = arg_56_0.timerAnim

		var_10.Start(var_59_26)

		return
	end

	UIItemList = var_1_10005

	var_1_10005.StaticAlign(var_56_3, var_56_3:GetChild(0), #var_56_1, function(arg_65_0, arg_65_1, arg_65_2)
		UIItemList = var_2_10003

		if arg_65_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_65_1 = arg_65_1 + 1

		local var_65_0 = var_56_1[arg_65_1]

		setText = var_2_10004

		var_2_10004(arg_65_2:Find("Name"), var_65_0:GetName())

		GetImageSpriteFromAtlasAsync = var_2_10004
		string = var_5

		var_2_10004(var_5.format("Dorm3DPhoto/%s", var_65_0:GetZoneIcon()), "", arg_65_2:Find("Icon"))

		setActive = var_2_10004

		var_2_10004(arg_65_2:Find("Slider"), false)

		setActive = var_2_10004

		var_2_10004(arg_65_2:Find("Selected"), false)

		onButton = var_2_10004

		var_2_10004(arg_56_0, arg_65_2, function()
			var_56_5(var_65_0, arg_65_2)

			return
		end)

		return
	end)
	var_56_4()

	return
end

function var_0_1.BlockActionPanel(arg_67_0, arg_67_1)
	return
end

function var_0_1.SetPhotoUIActive(arg_68_0, arg_68_1)
	setActive = var_1_10002

	local var_68_0 = arg_68_0._tf

	var_1_10002(var_3.Find(var_68_0, "RightTop"), arg_68_1)

	setActive = var_1_10002

	local var_68_1 = arg_68_0._tf

	var_1_10002(var_3.Find(var_68_1, "Center"), arg_68_1)

	return
end

function var_0_1.GetAnimPlayList(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_1
	local var_69_1 = {}

	while true do
		Dorm3dCameraAnim = var_1_10004

		if not var_1_10004.New({
			configId = var_69_0
		}) then
			return var_69_1
		end

		table = var_5

		var_5.insert(var_69_1, 1, var_1_10004)

		if var_1_10004:GetPreAnimID() == 0 then
			return var_69_1
		end
	end

	return
end

function var_0_1.SetMute(arg_70_0)
	if arg_70_0 then
		pg = var_1_10001

		local var_70_0 = var_1_10001.CriMgr.GetInstance()

		var_1_10001.MuteAllVolume(var_70_0)
	else
		pg = var_1_10001

		local var_70_1 = var_1_10001.CriMgr.GetInstance()

		var_1.ResetAllVolume(var_70_1)
	end

	return
end

function var_0_1.willExit(arg_71_0)
	if arg_71_0.timerAnim then
		local var_71_0 = arg_71_0.timerAnim

		var_1.Stop(var_71_0)

		arg_71_0.timerAnim = nil
	end

	if arg_71_0.filmTimer then
		local var_71_1 = arg_71_0.filmTimer

		var_1.Stop(var_71_1)

		arg_71_0.filmTimer = nil
	end

	return
end

function var_0_1.SetCamaraPinchSliderValue(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0.normalPanel
	local var_72_1 = var_2.Find(var_72_0, "Zoom/Slider")

	setSlider = var_72_0

	var_72_0(var_72_1, 0, 1, 1 - (arg_72_1 - 0.5) / 0.5)

	return
end

function var_0_1.ShowPhotoImage(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1 and 1 or 0
	local var_73_1 = arg_73_0.normalPanel

	var_3.GetComponent(var_73_1, "CanvasGroup").alpha = var_73_0

	local var_73_2 = arg_73_0._tf
	local var_73_3 = var_3.Find(var_73_2, "RightTop")

	var_3.GetComponent(var_73_3, "CanvasGroup").alpha = var_73_0

	return
end

return var_0_1
