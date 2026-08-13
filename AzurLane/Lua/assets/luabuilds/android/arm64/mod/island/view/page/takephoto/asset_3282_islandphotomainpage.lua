class = var_0_10000

local var_0_0 = "IslandPhotoMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandMainPhotoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.centerPanel = var_1.Find(var_2_0, "Center")

	local var_2_1 = arg_2_0._tf

	arg_2_0.normalPanel = var_1.Find(var_2_1, "Center/Normal")
	setActive = var_1

	var_1(arg_2_0.normalPanel, true)

	local var_2_2 = arg_2_0._tf

	arg_2_0.btnHideUI = var_1.Find(var_2_2, "Center/HideUI")

	local var_2_3 = arg_2_0._tf

	arg_2_0.btnReset = var_1.Find(var_2_3, "Center/Reset")

	local var_2_4 = arg_2_0._tf

	arg_2_0.btnFreeze = var_1.Find(var_2_4, "Center/Freeze")

	local var_2_5 = arg_2_0._tf

	arg_2_0.RightTopTf = var_1.Find(var_2_5, "RightTop")

	local var_2_6 = arg_2_0._tf

	arg_2_0.FilmTf = var_1.Find(var_2_6, "RightTop/Film")

	local var_2_7 = arg_2_0._tf

	arg_2_0.ShotTf = var_1.Find(var_2_7, "RightTop/Shot")

	local var_2_8 = arg_2_0._tf

	arg_2_0.btnFilm = var_1.Find(var_2_8, "RightTop/Film/Film")

	local var_2_9 = arg_2_0._tf

	arg_2_0.filmTime = var_1.Find(var_2_9, "RightTop/FilmTime")
	setActive = var_1

	var_1(arg_2_0.filmTime, false)

	local var_2_10 = arg_2_0._tf

	arg_2_0.btnShoot = var_1.Find(var_2_10, "RightTop/Shot/Shot")

	local var_2_11 = arg_2_0._tf

	arg_2_0.hideuiMask = var_1.Find(var_2_11, "Mask")
	setActive = var_1

	var_1(arg_2_0.hideuiMask, false)

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "Shoter")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	YSTool = var_1_10006
	arg_2_0.ysScreenShoter = var_2_14(var_2_13, var_4(var_1_10006.YSScreenShoter))

	local var_2_15 = arg_2_0._tf

	arg_2_0.stopRecBtn = var_1.Find(var_2_15, "stopRec")

	local var_2_16 = arg_2_0._tf

	arg_2_0.videoTipPanel = var_1.Find(var_2_16, "videoTipPanel")
	setActive = var_1

	var_1(arg_2_0.videoTipPanel, false)

	local var_2_17 = arg_2_0._tf

	arg_2_0.photoModel = var_1.Find(var_2_17, "Center/photoModel")

	local var_2_18 = arg_2_0.photoModel

	arg_2_0.unselectBgTF = var_1.Find(var_2_18, "un_select_bg")

	local var_2_19 = arg_2_0.photoModel

	arg_2_0.select_bgTF = var_1.Find(var_2_19, "select_bg")

	local var_2_20 = arg_2_0.photoModel

	arg_2_0.firstModelTF = var_1.Find(var_2_20, "first")

	local var_2_21 = arg_2_0.photoModel

	arg_2_0.thirdModelTF = var_1.Find(var_2_21, "third")
	IslandCameraMgr = var_1
	arg_2_0.mainCamera = var_1.instance._mainCamera

	local var_2_22 = {}

	IslandConst = var_1_10002
	var_2_22[var_1_10002.TakePhotoModel.First] = arg_2_0.firstModelTF
	IslandConst = var_2
	var_2_22[var_2.TakePhotoModel.Third] = arg_2_0.thirdModelTF
	arg_2_0.takeModelTFDic = var_2_22

	local var_2_23 = arg_2_0.normalPanel

	arg_2_0.sliderZoom = var_1.Find(var_2_23, "Zoom/Slider")
	IslandCameraMgr = var_1

	local var_2_24 = var_1.instance
	local var_2_25 = var_1.GetVirtualCamera

	IslandConst = var_4
	arg_2_0.fpsCamera = var_2_25(var_2_24, var_4.FIRST_PERSON_TAKE_PHOTO_CAMERA_NAME)
	IslandCameraMgr = var_1

	local var_2_26 = var_1.instance
	local var_2_27 = var_1.GetVirtualCamera

	IslandConst = var_4
	arg_2_0.tpsCamera = var_2_27(var_2_26, var_4.Third_PERSON_TAKE_PHOTO_CAMERA_NAME)
	pg = var_1
	arg_2_0.fpsHeight = var_1.island_set.island_photohight_FPS.key_value_varchar
	pg = var_1
	arg_2_0.tpsHeight = var_1.island_set.island_photohight_TPS.key_value_varchar

	return
end

function var_0_1.AddListeners(arg_3_0)
	return
end

function var_0_1.RemoveListeners(arg_4_0)
	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "Center/Normal/Back/help")

	local function var_5_3()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.island_help_photo.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "Center/Normal/Back")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_CANCEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	setActive = var_1_10001

	var_1_10001(arg_5_0.ShotTf, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.FilmTf, false)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_4.Find(var_5_9, "RightTop/Shot/Switch")

	local function var_5_11()
		setActive = var_2_10000

		var_2_10000(arg_5_0.ShotTf, false)

		setActive = var_2_10000

		var_2_10000(arg_5_0.FilmTf, true)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0._tf
	local var_5_14 = var_4.Find(var_5_13, "RightTop/Film/Switch")

	local function var_5_15()
		setActive = var_2_10000

		var_2_10000(arg_5_0.ShotTf, true)

		setActive = var_2_10000

		var_2_10000(arg_5_0.FilmTf, false)

		return
	end

	SFX_PANEL = var_5_13

	var_1_10001(var_5_12, var_5_14, var_5_15, var_5_13)

	onButton = var_1_10001

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.btnShoot

	local function var_5_18()
		local function var_10_0(arg_11_0)
			setActive = var_3_10001

			var_3_10001(arg_5_0.centerPanel, arg_11_0)

			setActive = var_3_10001

			local var_11_0 = arg_5_0._tf

			var_3_10001(var_3.Find(var_11_0, "RightTop"), arg_11_0)

			PlayerPrefs = var_3_10001

			local var_11_1 = var_3_10001.GetInt

			SHOW_TOUCH_EFFECT = var_3

			local var_11_2 = var_11_1(var_3, 1)

			if 0 < var_11_2 then
				setActive = var_2
				pg = var_4

				var_2(var_4.UIMgr.GetInstance().OverlayEffect, arg_11_0)
			end

			return
		end

		local function var_10_1(arg_12_0)
			warning = var_3_10001

			local var_12_0 = "截图结果："

			tostring = var_3_10004

			var_3_10001(var_12_0 .. var_3_10004(true))

			Tex2DExtension = var_3_10001

			local var_12_1 = var_3_10001.EncodeToJPG(arg_12_0)
			local var_12_2 = arg_5_0
			local var_12_3 = var_2.OpenPage

			IslandPhotoSharePage = var_3_10005

			var_12_3(var_12_2, var_3_10005, var_12_1, arg_12_0)

			IslandTaskHelper = var_12_3

			local var_12_4 = var_12_3.UpdateClientTaskProgress

			IslandTaskTargetType = var_12_2

			var_12_4(var_12_2.TAKE_PHOTO, 0)

			IslandAchievementHelper = var_12_4

			var_12_4.OnTakePhoto(0)

			return
		end

		pg = var_2_10002

		local var_10_2 = var_2_10002.GameTrackerMgr.GetInstance()
		local var_10_3 = var_2.Record

		GameTrackerBuilder = var_2_10005

		var_10_3(var_10_2, var_2_10005.BuildIslandTakeThoto(2))

		BLHX = var_10_3

		var_10_3.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(arg_5_0.mainCamera, var_10_1)

		return
	end

	SFX_PANEL = var_5_13

	var_1_10001(var_5_16, var_5_17, var_5_18, var_5_13)

	onButton = var_1_10001

	local var_5_19 = arg_5_0
	local var_5_20 = arg_5_0.photoModel
	local var_5_21 = var_4.Find(var_5_20, "left_btn")

	local function var_5_22()
		local var_13_0 = arg_5_0

		var_0.LeftSelectBtnHandle(var_13_0)

		return
	end

	SFX_PANEL = var_5_20

	var_1_10001(var_5_19, var_5_21, var_5_22, var_5_20)

	onButton = var_1_10001

	local var_5_23 = arg_5_0
	local var_5_24 = arg_5_0.select_bgTF
	local var_5_25 = var_4.Find(var_5_24, "left_btn")

	local function var_5_26()
		local var_14_0 = arg_5_0

		var_0.RightSelectBtnHandle(var_14_0)

		return
	end

	SFX_PANEL = var_5_24

	var_1_10001(var_5_23, var_5_25, var_5_26, var_5_24)

	onButton = var_1_10001

	local var_5_27 = arg_5_0
	local var_5_28 = arg_5_0.firstModelTF

	local function var_5_29()
		local var_15_0 = arg_5_0
		local var_15_1 = var_0.ChangeTakePhotoModel

		IslandConst = var_2_10003

		var_15_1(var_15_0, var_2_10003.TakePhotoModel.First)

		local var_15_2 = arg_5_0

		var_0.RightSelectBtnHandle(var_15_2)

		return
	end

	SFX_PANEL = var_5_24

	var_1_10001(var_5_27, var_5_28, var_5_29, var_5_24)

	onButton = var_1_10001

	local var_5_30 = arg_5_0
	local var_5_31 = arg_5_0.thirdModelTF

	local function var_5_32()
		local var_16_0 = arg_5_0
		local var_16_1 = var_0.ChangeTakePhotoModel

		IslandConst = var_2_10003

		var_16_1(var_16_0, var_2_10003.TakePhotoModel.Third)

		local var_16_2 = arg_5_0

		var_0.RightSelectBtnHandle(var_16_2)

		return
	end

	SFX_PANEL = var_5_24

	var_1_10001(var_5_30, var_5_31, var_5_32, var_5_24)

	onSlider = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.sliderZoom, function(arg_17_0)
		local var_17_0 = arg_5_0

		var_1.ChangeSliderValue(var_17_0, arg_17_0)

		return
	end)

	arg_5_0.hideUI = false
	onButton = var_1

	local var_5_33 = arg_5_0
	local var_5_34 = arg_5_0.btnHideUI

	local function var_5_35()
		if arg_5_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_5_0.hideuiMask, true)

		setActive = var_0

		var_0(arg_5_0.centerPanel, false)

		local var_18_0 = arg_5_0.RightTopTf

		var_0.GetComponent(var_18_0, "CanvasGroup").alpha = 0

		local var_18_1 = arg_5_0.RightTopTf

		var_0.GetComponent(var_18_1, "CanvasGroup").blocksRaycasts = false
		arg_5_0.hideUI = true

		local var_18_2 = arg_5_0
		local var_18_3 = var_0.emitCore

		ISLAND_EVT = var_3

		var_18_3(var_18_2, var_3.SetOpMoveBtnActve, false)

		return
	end

	SFX_PANEL = var_5_24

	var_1(var_5_33, var_5_34, var_5_35, var_5_24)

	onButton = var_1

	local var_5_36 = arg_5_0
	local var_5_37 = arg_5_0.btnReset

	local function var_5_38()
		local var_19_0
		local var_19_2

		if arg_5_0.takePhotoModel == 2 then
			var_19_0 = (arg_5_0.fpsHeight[1] - arg_5_0.fpsHeight[2]) / (arg_5_0.fpsHeight[3] - arg_5_0.fpsHeight[2])
		else
			var_19_0 = (arg_5_0.tpsHeight[1] - arg_5_0.tpsHeight[2]) / (arg_5_0.tpsHeight[3] - arg_5_0.tpsHeight[2])

			local var_19_1 = arg_5_0

			var_19_2 = var_19_2.emitCore
			ISLAND_EVT = var_2_10004

			var_19_2(var_19_1, var_2_10004.Change_TakePhoto_Model, arg_5_0.takePhotoModel)
		end

		setSlider = var_19_2

		var_19_2(arg_5_0.sliderZoom, 0, 1, var_19_0)

		return
	end

	SFX_PANEL = var_5_24

	var_1(var_5_36, var_5_37, var_5_38, var_5_24)

	onButton = var_1

	var_1(arg_5_0, arg_5_0.hideuiMask, function()
		if not arg_5_0.hideUI then
			return
		end

		setActive = var_0

		var_0(arg_5_0.centerPanel, true)

		setActive = var_0

		var_0(arg_5_0.hideuiMask, false)

		local var_20_0 = arg_5_0.RightTopTf

		var_0.GetComponent(var_20_0, "CanvasGroup").alpha = 1

		local var_20_1 = arg_5_0.RightTopTf

		var_0.GetComponent(var_20_1, "CanvasGroup").blocksRaycasts = true
		arg_5_0.hideUI = false

		local var_20_2 = arg_5_0
		local var_20_3 = var_0.emitCore

		ISLAND_EVT = var_3

		var_20_3(var_20_2, var_3.SetOpMoveBtnActve, true)

		return
	end)

	arg_5_0.recordState = false
	onButton = var_1

	local var_5_39 = arg_5_0
	local var_5_40 = arg_5_0.btnFilm

	local function var_5_41()
		pg = var_2_10000

		local var_21_0 = var_2_10000.GameTrackerMgr.GetInstance()
		local var_21_1 = var_0.Record

		GameTrackerBuilder = var_2_10003

		var_21_1(var_21_0, var_2_10003.BuildIslandTakeThoto(3))

		local function var_21_2(arg_22_0)
			setActive = var_3_10001

			var_3_10001(arg_5_0.centerPanel, arg_22_0)

			local var_22_0 = arg_5_0._tf
			local var_22_1 = var_1.Find(var_22_0, "RightTop")

			var_1.GetComponent(var_22_1, "CanvasGroup").alpha = arg_22_0 and 1 or 0

			local var_22_2 = arg_5_0
			local var_22_3 = var_1.emitCore

			ISLAND_EVT = var_4

			var_22_3(var_22_2, var_4.SetOpMoveBtnActve, arg_22_0, true)

			return
		end

		if not arg_5_0.recordState then
			local function var_21_3(arg_23_0)
				if not arg_23_0 then
					var_21_2(true)

					local var_23_0 = arg_5_0

					var_23_0.recordState = false
					LeanTween = var_23_0

					var_23_0.moveX(arg_5_0.stopRecBtn, arg_5_0.stopRecBtn.rect.width, 0.15)
				else
					arg_5_0.recordState = true
				end

				return
			end

			local function var_21_4()
				setActive = var_3_10000

				var_3_10000(arg_5_0.stopRecBtn, true)

				LeanTween = var_3_10000

				local var_24_0 = var_3_10000.moveX(arg_5_0.stopRecBtn, 0, 0.15)
				local var_24_1 = var_0.setOnComplete

				System = var_3

				var_24_1(var_24_0, var_3.Action(function()
					var_0_1.SetMute(true)

					local var_25_0 = arg_5_0

					YSNormalTool = var_4_10001
					var_25_0.recordFilePath = var_4_10001.RecordTool.GenRecordFilePath()
					YSNormalTool = var_25_0

					var_25_0.RecordTool.StartRecording(var_21_3, arg_5_0.recordFilePath)

					return
				end))

				return
			end

			seriesAsync = var_3

			var_3({
				function(arg_26_0)
					PermissionHelper = var_3_10001

					var_3_10001.Request3DDorm(arg_26_0, nil)

					return
				end,
				function(arg_27_0)
					var_21_2(false)

					PlayerPrefs = var_1

					if not var_1.GetInt("hadShowForVideoTipDorm", 0) or var_1 <= 0 then
						PlayerPrefs = var_3_10002

						var_3_10002.SetInt("hadShowForVideoTipDorm", 1)

						local var_27_0 = arg_5_0.videoTipPanel
						local var_27_1 = var_2.Find(var_27_0, "Text")
						local var_27_2 = var_2.GetComponent(var_27_1, "Text")

						i18n = var_3
						var_27_2.text = var_3("word_take_video_tip")
						onButton = var_27_2

						var_27_2(arg_5_0, arg_5_0.videoTipPanel, function()
							setActive = var_4_10000

							var_4_10000(arg_5_0.videoTipPanel, false)
							var_21_4()

							return
						end)

						setActive = var_27_2

						var_27_2(arg_5_0.videoTipPanel, true)
					else
						var_21_4()
					end

					return
				end
			})
		end

		return
	end

	SFX_PANEL = var_5_24

	var_1(var_5_39, var_5_40, var_5_41, var_5_24)

	onButton = var_1

	var_1(arg_5_0, arg_5_0.stopRecBtn, function()
		arg_5_0.recordState = false

		local function var_29_0(arg_30_0)
			if arg_30_0 then
				PLATFORM = var_3_10001
				PLATFORM_ANDROID = var_3_10002

				if var_3_10001 == var_3_10002 then
					pg = var_3_10001

					local var_30_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_30_1 = var_1.ShowMsgBox
					local var_30_2 = {}

					i18n = var_3_10005
					var_30_2.content = var_3_10005("word_save_video")

					function var_30_2.onNo()
						System = var_4_10000

						if var_4_10000.IO.File.Exists(arg_5_0.recordFilePath) then
							System = var_0

							var_0.IO.File.Delete(arg_5_0.recordFilePath)
						end

						return
					end

					function var_30_2.onYes()
						YSNormalTool = var_4_10000

						var_4_10000.MediaTool.SaveVideoToAlbum(arg_5_0.recordFilePath, function(arg_33_0, arg_33_1)
							if arg_33_0 then
								pg = var_5_10002

								local var_33_0 = var_5_10002.TipsMgr.GetInstance()
								local var_33_1 = var_2.ShowTips

								i18n = var_5_10005

								var_33_1(var_33_0, var_5_10005("word_save_ok"))

								System = var_33_1

								if var_33_1.IO.File.Exists(arg_5_0.recordFilePath) then
									System = var_2

									var_2.IO.File.Delete(arg_5_0.recordFilePath)
								end
							end

							return
						end)

						return
					end

					var_30_1(var_30_0, var_30_2)
				end
			end

			arg_5_0.recordState = false

			return
		end

		local function var_29_1(arg_34_0)
			setActive = var_3_10001

			var_3_10001(arg_5_0.centerPanel, arg_34_0)

			local var_34_0 = arg_5_0._tf
			local var_34_1 = var_1.Find(var_34_0, "RightTop")

			var_1.GetComponent(var_34_1, "CanvasGroup").alpha = arg_34_0 and 1 or 0

			return
		end

		LeanTween = var_2_10002

		local var_29_2 = var_2_10002.isTweening

		go = var_2_10004

		if not var_29_2(var_2_10004(arg_5_0.stopRecBtn)) then
			LeanTween = var_2

			local var_29_3 = var_2.moveX(arg_5_0.stopRecBtn, arg_5_0.stopRecBtn.rect.width, 0.15)
			local var_29_4 = var_2.setOnComplete

			System = var_5

			var_29_4(var_29_3, var_5.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_5_0.stopRecBtn, false)

				seriesAsync = var_3_10000

				var_3_10000({
					function(arg_36_0)
						YSNormalTool = var_4_10001

						var_4_10001.RecordTool.StopRecording(var_29_0)
						var_29_1(true)
						var_0_1.SetMute(false)

						return
					end
				})

				return
			end))
		end

		return
	end)

	setActive = var_1

	var_1(arg_5_0.stopRecBtn, false)

	return
end

function var_0_1.ChangeSliderValue(arg_37_0, arg_37_1)
	local var_37_0
	local var_37_1

	if arg_37_0.takePhotoModel == 2 then
		local var_37_2 = arg_37_0.fpsCamera.gameObject
		local var_37_3 = var_4.GetComponent

		typeof = var_1_10007
		CameraPovLook = var_1_10009
		var_37_0 = var_37_3(var_37_2, var_1_10007(var_1_10009))
		var_37_1 = arg_37_1 * (arg_37_0.fpsHeight[3] - arg_37_0.fpsHeight[2]) + arg_37_0.fpsHeight[2]
	else
		local var_37_4 = arg_37_0.tpsCamera.gameObject
		local var_37_5 = var_4.GetComponent

		typeof = var_1_10007
		CameraPovLook = var_1_10009
		var_37_0 = var_37_5(var_37_4, var_1_10007(var_1_10009))
		var_37_1 = arg_37_1 * (arg_37_0.tpsHeight[3] - arg_37_0.tpsHeight[2]) + arg_37_0.tpsHeight[2]

		local var_37_6 = arg_37_0
		local var_37_7 = arg_37_0.emitCore

		ISLAND_EVT = var_7

		var_37_7(var_37_6, var_7.Change_Photo_Height, arg_37_0.takePhotoModel, var_37_1)
	end

	var_37_0:SetTargetOffsetY(var_37_1)

	return
end

function var_0_1.RightSelectBtnHandle(arg_38_0)
	setActive = var_1_10001

	var_1_10001(arg_38_0.unselectBgTF, true)

	setActive = var_1_10001

	var_1_10001(arg_38_0.select_bgTF, false)

	setActive = var_1_10001

	local var_38_0 = arg_38_0.photoModel

	var_1_10001(var_3.Find(var_38_0, "left_btn"), true)

	pairs = var_1_10001

	for iter_38_0, iter_38_1 in var_1_10001(arg_38_0.takeModelTFDic) do
		if arg_38_0.takePhotoModel == iter_38_0 then
			setActive = var_6

			var_6(iter_38_1:Find("select"), true)

			setActive = var_6

			var_6(iter_38_1:Find("unSelect"), false)

			setActive = var_6

			var_6(iter_38_1, true)

			setAnchoredPosition = var_6

			var_6(iter_38_1, {
				x = 0
			})
		else
			setActive = var_6

			var_6(iter_38_1:Find("unSelect"), true)

			setActive = var_6

			var_6(iter_38_1:Find("select"), false)

			setActive = var_6

			var_6(iter_38_1, false)
		end
	end

	return
end

function var_0_1.LeftSelectBtnHandle(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.unselectBgTF, false)

	setActive = var_1_10001

	var_1_10001(arg_39_0.select_bgTF, true)

	setActive = var_1_10001

	local var_39_0 = arg_39_0.photoModel

	var_1_10001(var_3.Find(var_39_0, "left_btn"), false)

	local var_39_1 = 1

	pairs = var_1_10002

	for iter_39_0, iter_39_1 in var_1_10002(arg_39_0.takeModelTFDic) do
		setActive = var_1_10007

		var_1_10007(iter_39_1, true)

		if arg_39_0.takePhotoModel == iter_39_0 then
			setAnchoredPosition = var_1_10007

			var_1_10007(iter_39_1, {
				x = 0
			})
		else
			setAnchoredPosition = var_1_10007

			var_1_10007(iter_39_1, {
				x = -66 * var_39_1
			})

			var_39_1 = var_39_1 + 1
		end
	end

	return
end

function var_0_1.ChangeTakePhotoModel(arg_40_0, arg_40_1)
	if arg_40_0.takePhotoModel == arg_40_1 then
		return
	end

	if arg_40_0.takePhotoModel then
		local var_40_0 = arg_40_0.takeModelTFDic[arg_40_0.takePhotoModel]

		setActive = var_3

		var_3(var_40_0:Find("select"), false)

		setActive = var_3

		var_3(var_40_0:Find("unSelect"), true)
	end

	arg_40_0.takePhotoModel = arg_40_1

	local var_40_1 = arg_40_0.takeModelTFDic[arg_40_0.takePhotoModel]

	setActive = var_3

	var_3(var_40_1:Find("select"), true)

	setActive = var_3

	var_3(var_40_1:Find("unSelect"), false)

	local var_40_2
	local var_40_3
	local var_40_5

	if arg_40_0.takePhotoModel == 2 then
		local var_40_4 = arg_40_0.fpsCamera.gameObject

		var_40_5 = var_40_5.GetComponent
		typeof = var_8
		CameraPovZoom = var_1_10010
		var_40_2 = var_40_5(var_40_4, var_8(var_1_10010))
		var_40_3 = (arg_40_0.fpsHeight[1] - arg_40_0.fpsHeight[2]) / (arg_40_0.fpsHeight[3] - arg_40_0.fpsHeight[2])
	else
		local var_40_6 = arg_40_0.tpsCamera.gameObject

		var_40_5 = var_40_5.GetComponent
		typeof = var_8
		CameraPovZoom = var_1_10010
		var_40_2 = var_40_5(var_40_6, var_8(var_1_10010))
		var_40_3 = (arg_40_0.tpsHeight[1] - arg_40_0.tpsHeight[2]) / (arg_40_0.tpsHeight[3] - arg_40_0.tpsHeight[2])
	end

	setSlider = var_40_5

	var_40_5(arg_40_0.sliderZoom, 0, 1, var_40_3)
	var_40_2:SetCurrentZoom(50)

	local var_40_7 = arg_40_0
	local var_40_8 = arg_40_0.emitCore

	ISLAND_EVT = var_8

	var_40_8(var_40_7, var_8.Change_TakePhoto_Model, arg_40_0.takePhotoModel)

	return
end

function var_0_1.OnShow(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.GameTrackerMgr.GetInstance()
	local var_41_1 = var_1.Record

	GameTrackerBuilder = var_1_10004

	var_41_1(var_41_0, var_1_10004.BuildIslandTakeThoto(1))

	local var_41_2 = arg_41_0
	local var_41_3 = arg_41_0.ChangeTakePhotoModel

	IslandConst = var_4

	var_41_3(var_41_2, var_4.TakePhotoModel.First)
	arg_41_0:RightSelectBtnHandle()

	return
end

function var_0_1.OnDisable(arg_42_0)
	arg_42_0:OnHide()

	return
end

function var_0_1.OnHide(arg_43_0)
	if arg_43_0.recordState then
		triggerButton = var_1

		var_1(arg_43_0.btnFilm)

		return
	end

	return
end

function var_0_1.OnExit(arg_44_0)
	local var_44_0 = arg_44_0.islandScene.sceneMgr
	local var_44_1 = var_1.IsAllPageClose(var_44_0)

	arg_44_0.takePhotoModel = nil

	local var_44_2 = arg_44_0
	local var_44_3 = arg_44_0.emitCore

	ISLAND_EVT = var_1_10005

	local var_44_4 = var_1_10005.Change_TakePhoto_Model

	IslandConst = var_1_10006

	var_44_3(var_44_2, var_44_4, var_1_10006.TakePhotoModel.None, var_44_1)

	return
end

function var_0_1.SetMute(arg_45_0)
	if arg_45_0 then
		pg = var_1_10001

		local var_45_0 = var_1_10001.CriMgr.GetInstance()

		var_1_10001.MuteAllVolume(var_45_0)
	else
		pg = var_1_10001

		local var_45_1 = var_1_10001.CriMgr.GetInstance()

		var_1.ResetAllVolume(var_45_1)
	end

	return
end

function var_0_1.OnDestroy(arg_46_0)
	return
end

return var_0_1
