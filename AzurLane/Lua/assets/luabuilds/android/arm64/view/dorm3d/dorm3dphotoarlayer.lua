local var_0_0 = class("Dorm3dPhotoARLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dARPhotoUI"
end

var_0_0.PANEL = {
	ACTION = 1,
	LIGHTING = 3,
	CAMERA = 2
}

function var_0_0.init(arg_2_0)
	arg_2_0.centerPanel = arg_2_0._tf:Find("Center")
	arg_2_0.normalPanel = arg_2_0._tf:Find("Center/Normal")

	setActive(arg_2_0.normalPanel, true)

	arg_2_0.settingPanel = arg_2_0._tf:Find("Center/Settings")
	arg_2_0.btnAction = arg_2_0.settingPanel:Find("Action")
	arg_2_0.btnCamera = arg_2_0.settingPanel:Find("Camera")
	arg_2_0.btnLighting = arg_2_0.settingPanel:Find("Lighting")
	arg_2_0.panelAction = arg_2_0.settingPanel:Find("ActionSelect")

	setActive(arg_2_0.panelAction, false)
	setActive(arg_2_0.panelAction:Find("Mask"), false)

	arg_2_0.panelCamera = arg_2_0.settingPanel:Find("CameraSettings")

	setActive(arg_2_0.panelCamera, false)

	arg_2_0.panelLightning = arg_2_0.settingPanel:Find("LightningSettings")

	setActive(arg_2_0.panelLightning, false)

	arg_2_0.listZones = arg_2_0._tf:Find("ZoneList")

	setActive(arg_2_0.listZones, false)

	arg_2_0.zoneMask = arg_2_0.listZones:Find("Mask")
	arg_2_0.btnHideUI = arg_2_0._tf:Find("Center/HideUI")
	arg_2_0.btnReset = arg_2_0._tf:Find("Center/Reset")
	arg_2_0.btnFreeze = arg_2_0._tf:Find("Center/Freeze")
	arg_2_0.btnZone = arg_2_0._tf:Find("Center/Zone")
	arg_2_0.btnAr = arg_2_0._tf:Find("Center/Ar")
	arg_2_0.btnAnimSpeed = arg_2_0._tf:Find("Center/AnimSpeed")
	arg_2_0.listAnimSpeed = arg_2_0.btnAnimSpeed:Find("Bar")

	setActive(arg_2_0.listAnimSpeed, false)

	arg_2_0.textAnimSpeed = arg_2_0.btnAnimSpeed:Find("Text")
	arg_2_0.hideuiMask = arg_2_0._tf:Find("RightTop/Mask")

	setActive(arg_2_0.hideuiMask, false)

	arg_2_0.btnFilm = arg_2_0._tf:Find("RightTop/Film/Film")
	arg_2_0.filmTime = arg_2_0._tf:Find("RightTop/FilmTime")

	setActive(arg_2_0.filmTime, false)

	arg_2_0.shareUI = arg_2_0._tf:Find("ShareUI")

	setActive(arg_2_0.shareUI, false)

	arg_2_0.ysScreenShoter = arg_2_0._tf:Find("Shoter"):GetComponent(typeof(YSTool.YSScreenShoter))

	setText(arg_2_0.panelCamera:Find("Layout/DepthOfField/Title/Text"), i18n("dorm3d_photo_len"))
	setText(arg_2_0.panelCamera:Find("Layout/DepthOfField/Switch/Title"), i18n("dorm3d_photo_depthoffield"))
	setText(arg_2_0.panelCamera:Find("Layout/DepthOfField/DepthOfField/FocusDistance/Title"), i18n("dorm3d_photo_focusdistance"))
	setText(arg_2_0.panelCamera:Find("Layout/DepthOfField/DepthOfField/BlurRadius/Title"), i18n("dorm3d_photo_focusstrength"))
	setText(arg_2_0.panelCamera:Find("Layout/Paramaters/Title/Text"), i18n("dorm3d_photo_paramaters"))
	setText(arg_2_0.panelCamera:Find("Layout/Paramaters/PostExposure/PostExposure/Title"), i18n("dorm3d_photo_postexposure"))
	setText(arg_2_0.panelCamera:Find("Layout/Paramaters/Saturation/Saturation/Title"), i18n("dorm3d_photo_saturation"))
	setText(arg_2_0.panelCamera:Find("Layout/Paramaters/Contrast/Contrast/Title"), i18n("dorm3d_photo_contrast"))
	setText(arg_2_0.panelCamera:Find("Layout/Other/Title/Text"), i18n("dorm3d_photo_Others"))
	setText(arg_2_0.panelCamera:Find("Layout/Other/HideCharacter/Title"), i18n("dorm3d_photo_hidecharacter"))
	setText(arg_2_0.panelCamera:Find("Layout/Other/FaceCamera/Title"), i18n("dorm3d_photo_facecamera"))
	setText(arg_2_0.panelLightning:Find("Layout/Title/Lighting/Name"), i18n("dorm3d_photo_lighting"))
	setText(arg_2_0.panelLightning:Find("Layout/Title/Lighting/Selected"), i18n("dorm3d_photo_lighting"))
	setText(arg_2_0.panelLightning:Find("Layout/Title/Filter/Name"), i18n("dorm3d_photo_filter"))
	setText(arg_2_0.panelLightning:Find("Layout/Title/Filter/Selected"), i18n("dorm3d_photo_filter"))
	setText(arg_2_0.panelLightning:Find("Layout/Lighting/Strength/Name"), i18n("dorm3d_photo_strength"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Regular/Name"), i18n("dorm3d_photo_regular_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Regular/Selected"), i18n("dorm3d_photo_regular_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Special/Name"), i18n("dorm3d_photo_special_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Special/Selected"), i18n("dorm3d_photo_special_anim"))

	arg_2_0.stopRecBtn = arg_2_0._tf:Find("stopRec")
	arg_2_0.videoTipPanel = arg_2_0._tf:Find("videoTipPanel")

	setActive(arg_2_0.videoTipPanel, false)

	return
end

function var_0_0.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_0.SetRoom(arg_4_0, arg_4_1)
	arg_4_0.room = getProxy(ApartmentProxy):getRoom(arg_4_1)

	return
end

function var_0_0.SetGroupId(arg_5_0, arg_5_1)
	arg_5_0.groupId = arg_5_1

	return
end

function var_0_0.SetARLite(arg_6_0, arg_6_1)
	arg_6_0.ARState = arg_6_1
	arg_6_0.ARCheck = table.contains({
		5,
		6,
		7
	}, arg_6_1)

	if GraphApiHelper.IsUsingVulkan() then
		arg_6_0.ARCheck = false
	end

	arg_6_0.mainCamera = arg_6_0.ARCheck and GameObject.Find("AR/XR Origin/Camera Offset/Main Camera"):GetComponent(typeof(Camera)) or GameObject.Find("FakeAR/Main Camera"):GetComponent(typeof(Camera))

	return
end

function var_0_0.onBackPressed(arg_7_0)
	if arg_7_0.recordState then
		triggerButton(arg_7_0.btnFilm)

		return
	end

	if arg_7_0.activeSetting then
		triggerButton(arg_7_0._tf:Find("Center/Settings/Back"))

		return
	end

	arg_7_0:closeView()

	return
end

function var_0_0.didEnter(arg_8_0)
	setActive(arg_8_0._tf:Find("Center/Normal/Back"), false)
	onButton(arg_8_0, arg_8_0._tf:Find("Center/Normal/Back"), function()
		arg_8_0:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_8_0 = arg_8_0.normalPanel:Find("Zoom/Slider")

	setSlider(var_8_0, 0, 1, 0)
	onSlider(arg_8_0, var_8_0, function(arg_10_0)
		arg_8_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "SetPinchValue", (1 - arg_10_0) * 0.5 + 0.5)

		return
	end)

	arg_8_0.activeSetting = false

	onButton(arg_8_0, arg_8_0._tf:Find("Center/Normal/Settings"), function()
		arg_8_0.activeSetting = true

		quickPlayAnimation(arg_8_0._tf:Find("Center"), "anim_dorm3d_photo_normal_out")
		arg_8_0:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, false)
		arg_8_0:UpdateActionPanel()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("Center/Settings/Back"), function()
		arg_8_0.activeSetting = false

		quickPlayAnimation(arg_8_0._tf:Find("Center"), "anim_dorm3d_photo_normal_in")
		arg_8_0:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, true)

		return
	end, SFX_CANCEL)

	arg_8_0.hideUI = false

	onButton(arg_8_0, arg_8_0.btnHideUI, function()
		if arg_8_0.hideUI then
			return
		end

		setActive(arg_8_0.hideuiMask, true)
		setActive(arg_8_0.centerPanel, false)

		arg_8_0.hideUI = true

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.hideuiMask, function()
		if not arg_8_0.hideUI then
			return
		end

		setActive(arg_8_0.centerPanel, true)
		setActive(arg_8_0.hideuiMask, false)

		arg_8_0.hideUI = false

		return
	end)
	onButton(arg_8_0, arg_8_0.btnReset, function()
		arg_8_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "ResetPhotoCameraPosition")

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.btnFilm, function()
		local function var_16_0(arg_17_0)
			setActive(arg_8_0.centerPanel, arg_17_0)

			local var_17_0 = arg_8_0._tf:Find("RightTop")

			var_17_0:GetComponent("CanvasGroup").alpha = arg_17_0 and 1 or 0

			arg_8_0:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, arg_17_0)

			return
		end

		if not arg_8_0.recordState then
			local function var_16_1(arg_18_0)
				if not arg_18_0 then
					var_16_0(true)

					arg_8_0.recordState = false

					LeanTween.moveX(arg_8_0.stopRecBtn, arg_8_0.stopRecBtn.rect.width, 0.15)
				else
					arg_8_0.recordState = true
				end

				return
			end

			local function var_16_2()
				setActive(arg_8_0.stopRecBtn, true)
				LeanTween.moveX(arg_8_0.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					var_0_0.SetMute(true)

					arg_8_0.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_16_1, arg_8_0.recordFilePath)

					return
				end))

				return
			end

			seriesAsync({
				function(arg_21_0)
					PermissionHelper.Request3DDorm(arg_21_0, nil)

					return
				end,
				function(arg_22_0)
					var_16_0(false)

					local var_22_0 = PlayerPrefs.GetInt("hadShowForVideoTipDorm", 0)

					if not var_22_0 or var_22_0 <= 0 then
						PlayerPrefs.SetInt("hadShowForVideoTipDorm", 1)

						arg_8_0.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

						onButton(arg_8_0, arg_8_0.videoTipPanel, function()
							setActive(arg_8_0.videoTipPanel, false)
							var_16_2()

							return
						end)
						setActive(arg_8_0.videoTipPanel, true)
					else
						var_16_2()
					end

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.stopRecBtn, function()
		local function var_24_0(arg_25_0)
			if arg_25_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(arg_8_0.recordFilePath) then
							System.IO.File.Delete(arg_8_0.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(arg_8_0.recordFilePath, function(arg_28_0, arg_28_1)
							if arg_28_0 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))

								if System.IO.File.Exists(arg_8_0.recordFilePath) then
									System.IO.File.Delete(arg_8_0.recordFilePath)
								end
							end

							return
						end)

						return
					end
				})
			end

			arg_8_0.recordState = false

			return
		end

		local function var_24_1(arg_29_0)
			setActive(arg_8_0.centerPanel, arg_29_0)

			local var_29_0 = arg_8_0._tf:Find("RightTop")

			var_29_0:GetComponent("CanvasGroup").alpha = arg_29_0 and 1 or 0

			arg_8_0:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, arg_29_0)

			return
		end

		if not LeanTween.isTweening(go(arg_8_0.stopRecBtn)) then
			LeanTween.moveX(arg_8_0.stopRecBtn, arg_8_0.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(arg_8_0.stopRecBtn, false)
				seriesAsync({
					function(arg_31_0)
						YSNormalTool.RecordTool.StopRecording(var_24_0)
						var_24_1(true)
						var_0_0.SetMute(false)

						return
					end
				})

				return
			end))
		end

		return
	end)
	setActive(arg_8_0.stopRecBtn, false)
	onButton(arg_8_0, arg_8_0._tf:Find("RightTop/Film/Switch"), function()
		GetOrAddComponent(arg_8_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

		quickPlayAnimation(arg_8_0._tf:Find("RightTop"), "anim_dorm3d_photo_FtoS")

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("RightTop/Shot/Shot"), function()
		local function var_33_1(arg_35_0)
			warning("截图结果：" .. tostring(arg_35_0))

			return
		end

		local function var_33_2(arg_36_0, arg_36_1)
			arg_8_0:emit(Dorm3dPhotoARMediator.SHARE_PANEL, arg_36_1, arg_36_0)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(arg_8_0.groupId, 3, arg_8_0.room:GetConfigID(), Dorm3dCameraAnim.New({
				configId = arg_8_0.animID
			}):GetStateName()))

			return
		end

		local var_33_3, var_33_4 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(arg_8_0.contextData.holyLightRoot)

		GraphicsInterface.Instance:TakePhotoWithPost(arg_8_0.mainCamera, var_33_3, var_33_4, function(arg_37_0)
			var_33_1(true)
			var_33_2(Tex2DExtension.EncodeToJPG(arg_37_0), arg_37_0)

			return
		end)

		return
	end, "ui-dorm_photograph")

	GetOrAddComponent(arg_8_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

	onButton(arg_8_0, arg_8_0._tf:Find("RightTop/Shot/Switch"), function()
		GetOrAddComponent(arg_8_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = true

		quickPlayAnimation(arg_8_0._tf:Find("RightTop"), "anim_dorm3d_photo_StoF")

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.btnAnimSpeed, function()
		setActive(arg_8_0.listAnimSpeed, not isActive(arg_8_0.listAnimSpeed))

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.btnZone, function()
		setActive(arg_8_0.listZones, not isActive(arg_8_0.listZones))

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.zoneMask, function()
		setActive(arg_8_0.listZones, false)

		return
	end)
	onButton(arg_8_0, arg_8_0.btnAr, function()
		arg_8_0:emit(Dorm3dPhotoMediator.GO_AR)

		return
	end)

	arg_8_0.activePanel = 1

	local var_8_1 = {
		{
			btn = arg_8_0.btnAction,
			On = function()
				arg_8_0:UpdateActionPanel()

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

	table.Ipairs({
		{
			btn = arg_8_0.btnAction,
			On = function()
				arg_8_0:UpdateActionPanel()

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
	}, function(arg_49_0, arg_49_1)
		onToggle(arg_8_0, arg_49_1.btn, function(arg_50_0)
			if not arg_50_0 then
				return
			end

			table.Ipairs(var_8_1, function(arg_51_0, arg_51_1)
				if arg_51_0 == arg_49_0 then
					return
				end

				arg_51_1.Off()

				return
			end)

			arg_8_0.activePanel = arg_49_0

			arg_49_1.On()

			return
		end, SFX_PANEL)

		return
	end)
	;(function()
		triggerToggle(({
			arg_8_0.panelAction:Find("Layout/Title/Regular")
		})[1], true)

		return
	end)()
	;(function()
		triggerToggle(({
			arg_8_0.panelLightning:Find("Layout/Title/Lighting")
		})[1], true)

		return
	end)()
	arg_8_0:InitData()
	triggerToggle(({
		{
			btn = arg_8_0.btnAction,
			On = function()
				arg_8_0:UpdateActionPanel()

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
	})[arg_8_0.activePanel].btn, true)
	arg_8_0:emit(Dorm3dPhotoARMediator.AR_PHOTO_INITED)

	return
end

function var_0_0.InitData(arg_54_0)
	arg_54_0:RefreshData()

	return
end

function var_0_0.RefreshData(arg_55_0)
	arg_55_0.animID = arg_55_0.room:getAllARAnimationListByShip(arg_55_0.groupId)[1]:GetConfigID()
	arg_55_0.animSpeed = 1

	return
end

local var_0_1 = 0.2

function var_0_0.UpdateActionPanel(arg_56_0)
	if not arg_56_0.activeSetting then
		return
	end

	local var_56_0, var_56_1, var_56_2

	if arg_56_0.activePanel ~= var_0_0.PANEL.ACTION then
		do return end

		var_56_0 = arg_56_0.panelAction:Find("Layout/Regular/Scroll/Viewport/Content")

		function var_56_1()
			UIItemList.StaticAlign(var_56_0, var_56_0:GetChild(0), #var_0, function(arg_58_0, arg_58_1, arg_58_2)
				if arg_58_0 ~= UIItemList.EventUpdate then
					return
				end

				arg_58_1 = arg_58_1 + 1

				setActive(arg_58_2:Find("Selected"), var_0[arg_58_1]:GetConfigID() == arg_56_0.animID)
				setActive(arg_58_2:Find("Slider"), var_58_0:GetConfigID() == arg_56_0.animID and tobool(arg_56_0.timerAnim))

				return
			end)

			return
		end

		function var_56_2(arg_59_0, arg_59_1)
			if arg_56_0.animPlaying then
				return
			end

			local var_59_0 = arg_59_0:GetConfigID()

			if arg_56_0.animID == var_59_0 then
				return
			end

			local var_59_1 = arg_56_0:GetAnimPlayList(var_59_0)
			local var_59_2 = Dorm3dCameraAnim.New({
				configId = arg_56_0.animID
			}):GetFinishAnimID()

			arg_56_0.animID = var_59_0

			var_56_1()
			arg_56_0:BlockActionPanel(true)

			arg_56_0.animPlaying = true

			local var_59_3 = (table.indexof(var_59_1, _.detect(var_59_1, function(arg_60_0)
				return arg_60_0:GetConfigID() == var_59_2
			end)) or 0) + 1
			local var_59_4 = _.rest(var_59_1, var_59_3)
			local var_59_5 = arg_59_1:Find("Slider"):GetComponent(typeof(Slider))

			setActive(arg_59_1:Find("Slider"), true)

			local function var_59_6()
				setActive(arg_59_1:Find("Selected"), true)
				setActive(arg_59_1:Find("Slider"), false)
				arg_56_0:BlockActionPanel(false)

				arg_56_0.animPlaying = nil

				return
			end

			if #var_59_4 == 0 then
				(function()
					setActive(arg_59_1:Find("Selected"), true)
					setActive(arg_59_1:Find("Slider"), false)
					arg_56_0:BlockActionPanel(false)

					arg_56_0.animPlaying = nil

					return
				end)()

				return
			end

			local var_59_7 = _.reduce(var_59_4, 0, function(arg_62_0, arg_62_1)
				return arg_62_0 + math.max(var_0_1, arg_62_1:GetAnimTime())
			end)

			if arg_56_0.timerAnim then
				arg_56_0.timerAnim:Stop()
			end

			arg_56_0.animInfo = {
				index = 1,
				passedTime = 0,
				ratio = 0,
				animPlayList = var_59_4,
				totalTime = var_59_7,
				startStamp = Time.time
			}
			arg_56_0.timerAnim = FrameTimer.New(function()
				local var_63_0 = math.max(var_0_1, arg_56_0.animInfo.animPlayList[arg_56_0.animInfo.index]:GetAnimTime())
				local var_63_1 = math.min(1, arg_56_0.animInfo.ratio + (Time.time - arg_56_0.animInfo.startStamp) * arg_56_0.animSpeed / var_63_0)

				var_59_5.value = (arg_56_0.animInfo.passedTime + var_63_0 * var_63_1) / var_59_7

				if var_63_1 < 1 then
					return
				end

				arg_56_0.animInfo.index = arg_56_0.animInfo.index + 1
				arg_56_0.animInfo.ratio = 0
				arg_56_0.animInfo.passedTime = arg_56_0.animInfo.passedTime + var_63_0
				arg_56_0.animInfo.startStamp = Time.time

				warning(arg_56_0.animInfo.startStamp)

				if arg_56_0.animInfo.index > #arg_56_0.animInfo.animPlayList then
					var_59_6()
					arg_56_0.timerAnim:Stop()

					arg_56_0.timerAnim = nil
					arg_56_0.animInfo = nil

					return
				end

				arg_56_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "PlaySingleAction", arg_56_0.animInfo.animPlayList[arg_56_0.animInfo.index]:GetStateName())

				return
			end, 1, -1)

			if var_59_3 == 1 then
				arg_56_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "SwitchAnim", arg_56_0.animInfo.animPlayList[1]:GetStateName())
				onNextTick(function()
					arg_56_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "ResetCharPos")

					return
				end)
			else
				arg_56_0:emit(Dorm3dPhotoARMediator.SCENE_CALL, "PlaySingleAction", arg_56_0.animInfo.animPlayList[1]:GetStateName())
			end

			arg_56_0.timerAnim:Start()

			return
		end
	end

	UIItemList.StaticAlign(var_56_0, var_56_0:GetChild(0), #arg_56_0.room:getAllARAnimationListByShip(arg_56_0.groupId), function(arg_65_0, arg_65_1, arg_65_2)
		if arg_65_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_65_1 = arg_65_1 + 1

		local var_65_0 = var_0[arg_65_1]

		setText(arg_65_2:Find("Name"), var_0[arg_65_1]:GetName())
		GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", var_0[arg_65_1]:GetZoneIcon()), "", arg_65_2:Find("Icon"))
		setActive(arg_65_2:Find("Slider"), false)
		setActive(arg_65_2:Find("Selected"), false)
		onButton(arg_56_0, arg_65_2, function()
			var_56_2(var_65_0, arg_65_2)

			return
		end)

		return
	end)
	;(function()
		UIItemList.StaticAlign(var_56_0, var_56_0:GetChild(0), #var_0, function(arg_58_0, arg_58_1, arg_58_2)
			if arg_58_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_58_1 = arg_58_1 + 1

			setActive(arg_58_2:Find("Selected"), var_0[arg_58_1]:GetConfigID() == arg_56_0.animID)
			setActive(arg_58_2:Find("Slider"), var_58_0:GetConfigID() == arg_56_0.animID and tobool(arg_56_0.timerAnim))

			return
		end)

		return
	end)()

	return
end

function var_0_0.BlockActionPanel(arg_67_0, arg_67_1)
	return
end

function var_0_0.SetPhotoUIActive(arg_68_0, arg_68_1)
	setActive(arg_68_0._tf:Find("RightTop"), arg_68_1)
	setActive(arg_68_0._tf:Find("Center"), arg_68_1)

	return
end

function var_0_0.GetAnimPlayList(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_1

	while true do
		local var_69_1 = Dorm3dCameraAnim.New({
			configId = var_69_0
		})

		if not var_69_1 then
			return {}
		end

		table.insert({}, 1, var_69_1)

		var_69_0 = var_69_1:GetPreAnimID()

		if var_69_0 == 0 then
			return {}
		end
	end

	return
end

function var_0_0.SetMute(arg_70_0)
	if arg_70_0 then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

function var_0_0.willExit(arg_71_0)
	if arg_71_0.timerAnim then
		arg_71_0.timerAnim:Stop()

		arg_71_0.timerAnim = nil
	end

	if arg_71_0.filmTimer then
		arg_71_0.filmTimer:Stop()

		arg_71_0.filmTimer = nil
	end

	return
end

function var_0_0.SetCamaraPinchSliderValue(arg_72_0, arg_72_1)
	setSlider(arg_72_0.normalPanel:Find("Zoom/Slider"), 0, 1, 1 - (arg_72_1 - 0.5) / 0.5)

	return
end

function var_0_0.ShowPhotoImage(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1 and 1 or 0

	arg_73_0.normalPanel:GetComponent("CanvasGroup").alpha = arg_73_1 and 1 or 0
	arg_73_0._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = var_73_0

	return
end

return var_0_0
