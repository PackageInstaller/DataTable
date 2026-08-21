local var_0_0 = class("Dorm3dPhotoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dPhotoUI"
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
	arg_2_0.btnMove = arg_2_0._tf:Find("Center/Move")
	arg_2_0.btnZone = arg_2_0._tf:Find("Center/Zone")
	arg_2_0.btnAr = arg_2_0._tf:Find("Center/Ar")
	arg_2_0.ARchecker = GetComponent(arg_2_0.btnAr.gameObject, "ARChecker")
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
	arg_2_0.btnMenuSmall = arg_2_0._tf:Find("Center/MenuSmall")
	arg_2_0.btnMenu = arg_2_0._tf:Find("Center/Menu")

	setActive(arg_2_0.panelAction:Find("Layout/Regular/Index"), false)
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
	setText(arg_2_0.panelLightning:Find("Layout/Title/Filter/Name"), i18n("dorm3d_photo_filter"))
	setText(arg_2_0.panelLightning:Find("Layout/Title/Filter/Selected"), i18n("dorm3d_photo_filter"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Regular/Name"), i18n("dorm3d_photo_regular_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Regular/Selected"), i18n("dorm3d_photo_regular_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Special/Name"), i18n("dorm3d_photo_special_anim"))
	setText(arg_2_0.panelAction:Find("Layout/Title/Special/Selected"), i18n("dorm3d_photo_special_anim"))

	arg_2_0.mainCamera = GameObject.Find("BackYardMainCamera"):GetComponent(typeof(Camera))
	arg_2_0.stopRecBtn = arg_2_0._tf:Find("stopRec")
	arg_2_0.videoTipPanel = arg_2_0._tf:Find("videoTipPanel")

	setActive(arg_2_0.videoTipPanel, false)

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_0.SetRoom(arg_4_0, arg_4_1)
	arg_4_0.room = arg_4_1

	return
end

function var_0_0.SetGroupId(arg_5_0, arg_5_1)
	arg_5_0.groupId = arg_5_1

	return
end

function var_0_0.onBackPressed(arg_6_0)
	if arg_6_0.recordState then
		triggerButton(arg_6_0.btnFilm)

		return
	end

	if arg_6_0.activeSetting then
		triggerButton(arg_6_0._tf:Find("Center/Settings/Back"))

		return
	end

	arg_6_0:closeView()

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._tf:Find("Center/Normal/Back"), function()
		arg_7_0:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_7_0 = arg_7_0.normalPanel:Find("Zoom/Slider")

	setSlider(var_7_0, 0, 1, 0)
	onSlider(arg_7_0, var_7_0, function(arg_9_0)
		arg_7_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetPhotoCameraHeight", arg_9_0)

		return
	end)
	setActive(var_7_0, false)
	setActive(arg_7_0._tf:Find("Center/Stick"), false)

	arg_7_0.activeSetting = false

	onButton(arg_7_0, arg_7_0._tf:Find("Center/Normal/Settings"), function()
		arg_7_0.activeSetting = true

		quickPlayAnimation(arg_7_0._tf:Find("Center"), "anim_dorm3d_photo_normal_out")
		arg_7_0:UpdateActionPanel()
		arg_7_0:UpdateCameraPanel()
		arg_7_0:UpdateLightingPanel()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._tf:Find("Center/Settings/Back"), function()
		arg_7_0.activeSetting = false

		quickPlayAnimation(arg_7_0._tf:Find("Center"), "anim_dorm3d_photo_normal_in")

		return
	end, SFX_CANCEL)

	arg_7_0.hideUI = false

	onButton(arg_7_0, arg_7_0.btnHideUI, function()
		if arg_7_0.hideUI then
			return
		end

		setActive(arg_7_0.hideuiMask, true)
		setActive(arg_7_0.centerPanel, false)

		arg_7_0.hideUI = true

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.hideuiMask, function()
		if not arg_7_0.hideUI then
			return
		end

		setActive(arg_7_0.centerPanel, true)
		setActive(arg_7_0.hideuiMask, false)

		arg_7_0.hideUI = false

		return
	end)
	onButton(arg_7_0, arg_7_0.btnReset, function()
		arg_7_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetPhotoCameraPosition")

		return
	end, SFX_PANEL)

	arg_7_0.recordState = false

	onButton(arg_7_0, arg_7_0.btnFilm, function()
		local function var_15_0(arg_16_0)
			setActive(arg_7_0.centerPanel, arg_16_0)

			local var_16_0 = arg_7_0._tf:Find("RightTop")

			var_16_0:GetComponent("CanvasGroup").alpha = arg_16_0 and 1 or 0

			return
		end

		if not arg_7_0.recordState then
			local function var_15_1(arg_17_0)
				if not arg_17_0 then
					var_15_0(true)

					arg_7_0.recordState = false

					LeanTween.moveX(arg_7_0.stopRecBtn, arg_7_0.stopRecBtn.rect.width, 0.15)
				else
					arg_7_0.recordState = true
				end

				return
			end

			local function var_15_2()
				setActive(arg_7_0.stopRecBtn, true)
				LeanTween.moveX(arg_7_0.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					var_0_0.SetMute(true)

					arg_7_0.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_15_1, arg_7_0.recordFilePath)

					return
				end))

				return
			end

			seriesAsync({
				function(arg_20_0)
					PermissionHelper.Request3DDorm(arg_20_0, nil)

					return
				end,
				function(arg_21_0)
					var_15_0(false)

					local var_21_0 = PlayerPrefs.GetInt("hadShowForVideoTipDorm", 0)

					if not var_21_0 or var_21_0 <= 0 then
						PlayerPrefs.SetInt("hadShowForVideoTipDorm", 1)

						arg_7_0.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

						onButton(arg_7_0, arg_7_0.videoTipPanel, function()
							setActive(arg_7_0.videoTipPanel, false)
							var_15_2()

							return
						end)
						setActive(arg_7_0.videoTipPanel, true)
					else
						var_15_2()
					end

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.stopRecBtn, function()
		arg_7_0.recordState = false

		local function var_23_0(arg_24_0)
			if arg_24_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(arg_7_0.recordFilePath) then
							System.IO.File.Delete(arg_7_0.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(arg_7_0.recordFilePath, function(arg_27_0, arg_27_1)
							if arg_27_0 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))

								if System.IO.File.Exists(arg_7_0.recordFilePath) then
									System.IO.File.Delete(arg_7_0.recordFilePath)
								end
							end

							return
						end)

						return
					end
				})
			end

			arg_7_0.recordState = false

			return
		end

		local function var_23_1(arg_28_0)
			setActive(arg_7_0.centerPanel, arg_28_0)

			local var_28_0 = arg_7_0._tf:Find("RightTop")

			var_28_0:GetComponent("CanvasGroup").alpha = arg_28_0 and 1 or 0

			return
		end

		if not LeanTween.isTweening(go(arg_7_0.stopRecBtn)) then
			LeanTween.moveX(arg_7_0.stopRecBtn, arg_7_0.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(arg_7_0.stopRecBtn, false)
				seriesAsync({
					function(arg_30_0)
						YSNormalTool.RecordTool.StopRecording(var_23_0)
						var_23_1(true)
						var_0_0.SetMute(false)
						pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(arg_7_0.scene.apartment:GetConfigID(), 2, arg_7_0.room:GetConfigID(), Dorm3dTrackCommand.BuildCameraMsg(arg_7_0.room:GetCameraZones()[arg_7_0.zoneIndex]:GetName(), Dorm3dCameraAnim.New({
							configId = arg_7_0.animID
						}):GetStateName(), arg_7_0.cameraSettings.depthOfField.focusDistance.value, arg_7_0.cameraSettings.depthOfField.blurRadius.value, arg_7_0.cameraSettings.postExposure.value, arg_7_0.cameraSettings.contrast.value, arg_7_0.cameraSettings.saturate.value)))

						return
					end
				})

				return
			end))
		end

		return
	end)
	setActive(arg_7_0.stopRecBtn, false)
	onButton(arg_7_0, arg_7_0._tf:Find("RightTop/Film/Switch"), function()
		GetOrAddComponent(arg_7_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

		quickPlayAnimation(arg_7_0._tf:Find("RightTop"), "anim_dorm3d_photo_FtoS")

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._tf:Find("RightTop/Shot/Shot"), function()
		local function var_32_1(arg_34_0)
			warning("截图结果：" .. tostring(arg_34_0))

			return
		end

		local function var_32_2(arg_35_0, arg_35_1)
			arg_7_0:emit(Dorm3dPhotoMediator.SHARE_PANEL, arg_35_1, arg_35_0)
			getProxy(Dorm3dChatProxy):TriggerEvent({
				{
					value = 1,
					event_type = 160,
					ship_id = arg_7_0.scene.apartment:GetConfigID()
				}
			})
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(arg_7_0.scene.apartment:GetConfigID(), 1, arg_7_0.room:GetConfigID(), Dorm3dTrackCommand.BuildCameraMsg(arg_7_0.room:GetCameraZones()[arg_7_0.zoneIndex]:GetName(), Dorm3dCameraAnim.New({
				configId = arg_7_0.animID
			}):GetStateName(), arg_7_0.cameraSettings.depthOfField.focusDistance.value, arg_7_0.cameraSettings.depthOfField.blurRadius.value, arg_7_0.cameraSettings.postExposure.value, arg_7_0.cameraSettings.contrast.value, arg_7_0.cameraSettings.saturate.value)))

			return
		end

		local var_32_3, var_32_4 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(arg_7_0.scene.holyLightRoot)

		GraphicsInterface.Instance:TakePhotoWithPost(arg_7_0.mainCamera, var_32_3, var_32_4, function(arg_36_0)
			var_32_1(true)
			var_32_2(Tex2DExtension.EncodeToJPG(arg_36_0), arg_36_0)

			return
		end)

		return
	end, "ui-dorm_photograph")

	GetOrAddComponent(arg_7_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

	onButton(arg_7_0, arg_7_0._tf:Find("RightTop/Shot/Switch"), function()
		GetOrAddComponent(arg_7_0._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = true

		quickPlayAnimation(arg_7_0._tf:Find("RightTop"), "anim_dorm3d_photo_StoF")

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.btnAnimSpeed, function()
		setActive(arg_7_0.listAnimSpeed, not isActive(arg_7_0.listAnimSpeed))

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.btnZone, function()
		setActive(arg_7_0.listZones, not isActive(arg_7_0.listZones))

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.zoneMask, function()
		setActive(arg_7_0.listZones, false)

		return
	end)
	onButton(arg_7_0, arg_7_0.btnAr, function()
		arg_7_0.ARchecker:StartCheck(function(arg_42_0)
			if PLATFORM == PLATFORM_WINDOWSEDITOR then
				arg_42_0 = -1
			end

			originalPrint("AR CODE: " .. arg_42_0)
			arg_7_0:emit(Dorm3dPhotoMediator.GO_AR, arg_42_0)

			return
		end)

		return
	end)
	onButton(arg_7_0, arg_7_0.btnMove, function()
		arg_7_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchPhotoCamera")

		arg_7_0.freeMode = not arg_7_0.freeMode

		setActive(var_7_0, arg_7_0.freeMode)
		setActive(var_0, arg_7_0.freeMode)
		setActive(arg_7_0.btnMove:Find("Selected"), arg_7_0.freeMode)

		return
	end)
	onButton(arg_7_0, arg_7_0.btnMenuSmall, function()
		setActive(arg_7_0.btnMenuSmall, false)
		setActive(arg_7_0.btnMenu, true)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.btnMenu:Find("Collapse"), function()
		setActive(arg_7_0.btnMenu, false)
		setActive(arg_7_0.btnMenuSmall, true)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.btnMenu, function()
		arg_7_0:emit(Dorm3dPhotoMediator.OPEN_SKIN_SELECT_LAYER, arg_7_0.groupId, arg_7_0.scene.ladyDict[arg_7_0.groupId], function(arg_47_0, arg_47_1, arg_47_2)
			arg_7_0:OnSwitchSkin(arg_47_0, arg_47_1, arg_47_2)

			return
		end, not arg_7_0.scene.room:isPersonalRoom())

		return
	end, SFX_PANEL)

	arg_7_0.activePanel = 1

	local var_7_1 = {
		{
			btn = arg_7_0.btnAction,
			On = function()
				arg_7_0:UpdateActionPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnCamera,
			On = function()
				arg_7_0:UpdateCameraPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnLighting,
			On = function()
				arg_7_0:UpdateLightingPanel()

				return
			end,
			Off = function()
				return
			end
		}
	}

	table.Ipairs({
		{
			btn = arg_7_0.btnAction,
			On = function()
				arg_7_0:UpdateActionPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnCamera,
			On = function()
				arg_7_0:UpdateCameraPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnLighting,
			On = function()
				arg_7_0:UpdateLightingPanel()

				return
			end,
			Off = function()
				return
			end
		}
	}, function(arg_54_0, arg_54_1)
		onToggle(arg_7_0, arg_54_1.btn, function(arg_55_0)
			if not arg_55_0 then
				return
			end

			table.Ipairs(var_7_1, function(arg_56_0, arg_56_1)
				if arg_56_0 == arg_54_0 then
					return
				end

				arg_56_1.Off()

				return
			end)

			arg_7_0.activePanel = arg_54_0

			arg_54_1.On()

			return
		end, SFX_PANEL)

		return
	end)
	;(function()
		triggerToggle(({
			arg_7_0.panelAction:Find("Layout/Title/Regular"),
			arg_7_0.panelAction:Find("Layout/Title/Special")
		})[1], true)

		return
	end)()
	;(function()
		triggerToggle(({
			arg_7_0.panelLightning:Find("Layout/Title/Filter")
		})[1], true)

		return
	end)()

	arg_7_0.zoneIndex = 1

	arg_7_0:InitData()
	arg_7_0:FirstEnterZone()
	triggerToggle(({
		{
			btn = arg_7_0.btnAction,
			On = function()
				arg_7_0:UpdateActionPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnCamera,
			On = function()
				arg_7_0:UpdateCameraPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = arg_7_0.btnLighting,
			On = function()
				arg_7_0:UpdateLightingPanel()

				return
			end,
			Off = function()
				return
			end
		}
	})[arg_7_0.activePanel].btn, true)
	arg_7_0:UpdateZoneList()

	return
end

function var_0_0.InitData(arg_59_0)
	arg_59_0.cameraSettings = Clone(arg_59_0.scene:GetCameraSettings())
	arg_59_0.settingHideCharacter = false
	arg_59_0.settingFaceCamera = true
	arg_59_0.settingFilterIndex = nil
	arg_59_0.settingFilterStrength = 1

	arg_59_0:RefreshData()

	return
end

function var_0_0.RefreshData(arg_60_0)
	local var_60_0 = arg_60_0.room:GetCameraZones()[arg_60_0.zoneIndex]

	arg_60_0.animID = var_60_0:GetRegularAnimsByShipId(arg_60_0.groupId)[1]:GetConfigID()

	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.depthOfField.focusDistance, var_60_0:GetFocusDistanceRange())
	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.depthOfField.blurRadius, var_60_0:GetDepthOfFieldBlurRange())
	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.postExposure, var_60_0:GetExposureRange())
	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.contrast, var_60_0:GetContrastRange())
	;(function(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end)(arg_60_0.cameraSettings.saturate, var_60_0:GetSaturationRange())

	arg_60_0.animSpeeds = var_60_0:GetAnimSpeeds()
	arg_60_0.animSpeed = 1

	return
end

function var_0_0.FirstEnterZone(arg_62_0)
	arg_62_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnterPhotoMode", arg_62_0.room:GetCameraZones()[arg_62_0.zoneIndex], Dorm3dCameraAnim.New({
		configId = arg_62_0.animID
	}):GetStateName())
	arg_62_0:UpdateAnimSpeedPanel()

	return
end

function var_0_0.SwitchZone(arg_63_0)
	arg_63_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchCameraZone", arg_63_0.room:GetCameraZones()[arg_63_0.zoneIndex], Dorm3dCameraAnim.New({
		configId = arg_63_0.animID
	}):GetStateName())

	if arg_63_0.timerAnim then
		arg_63_0.timerAnim:Stop()

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

function var_0_0.UpdateZoneList(arg_64_0)
	local var_64_0 = arg_64_0.room:GetCameraZones()

	;(function()
		setText(arg_64_0.btnZone:Find("Text"), var_64_0[arg_64_0.zoneIndex]:GetName())
		UIItemList.StaticAlign(arg_64_0.listZones:Find("List"), arg_64_0.listZones:Find("List"):GetChild(0), #var_64_0, function(arg_66_0, arg_66_1, arg_66_2)
			if arg_66_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_66_1 = arg_66_1 + 1

			setText(arg_66_2:Find("Name"), var_64_0[arg_66_1]:GetName())

			local var_66_0 = arg_64_0.zoneIndex == arg_66_1 and Color.NewHex("5CCAFF") or Color.NewHex("FFFFFF99")

			setTextColor(arg_66_2:Find("Name"), var_66_0)
			setActive(arg_66_2:Find("Line"), arg_66_1 < #var_64_0)

			return
		end)

		return
	end)()
	UIItemList.StaticAlign(arg_64_0.listZones:Find("List"), arg_64_0.listZones:Find("List"):GetChild(0), #arg_64_0.room:GetCameraZones(), function(arg_67_0, arg_67_1, arg_67_2)
		if arg_67_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_67_1 = arg_67_1 + 1

		onButton(arg_64_0, arg_67_2, function()
			if arg_64_0.zoneIndex == arg_67_1 then
				return
			end

			arg_64_0.zoneIndex = arg_67_1

			arg_64_0:RefreshData()
			arg_64_0:SwitchZone()
			setActive(arg_64_0.listZones, false)
			var_0()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

local var_0_2 = 0.2

function var_0_0.UpdateActionPanel(arg_69_0)
	if not arg_69_0.activeSetting then
		return
	end

	if arg_69_0.activePanel ~= var_0_0.PANEL.ACTION then
		return
	end

	local var_69_0 = arg_69_0.room:GetCameraZones()[arg_69_0.zoneIndex]
	local var_69_1 = var_69_0:GetRegularAnimsByShipId(arg_69_0.groupId)
	local var_69_2 = arg_69_0.panelAction:Find("Layout/Regular/Scroll/Viewport/Content")
	local var_69_3 = var_69_0:GetAllSpecialList(arg_69_0.room.id)
	local var_69_4 = arg_69_0.panelAction:Find("Layout/Special/Scroll/Viewport/Content")

	setActive(arg_69_0.panelAction:Find("Layout/Title/Special"), #var_69_3 > 0)

	local function var_69_5()
		UIItemList.StaticAlign(var_69_2, var_69_2:GetChild(0), #var_69_1, function(arg_71_0, arg_71_1, arg_71_2)
			if arg_71_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_71_1 = arg_71_1 + 1

			setActive(arg_71_2:Find("Selected"), var_69_1[arg_71_1]:GetConfigID() == arg_69_0.animID)
			setActive(arg_71_2:Find("Slider"), var_71_0:GetConfigID() == arg_69_0.animID and tobool(arg_69_0.timerAnim))

			return
		end)
		UIItemList.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_3, function(arg_72_0, arg_72_1, arg_72_2)
			if arg_72_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_72_1 = arg_72_1 + 1

			local var_72_0 = arg_72_2:Find("Actions")

			UIItemList.StaticAlign(var_72_0, var_72_0:GetChild(0), #var_69_3[arg_72_1].anims, function(arg_73_0, arg_73_1, arg_73_2)
				if arg_73_0 ~= UIItemList.EventUpdate then
					return
				end

				arg_73_1 = arg_73_1 + 1

				setActive(arg_73_2:Find("Selected"), var_0[arg_73_1]:GetConfigID() == arg_69_0.animID)
				setActive(arg_73_2:Find("Slider"), var_73_0:GetConfigID() == arg_69_0.animID and tobool(arg_69_0.timerAnim))

				return
			end)

			return
		end)

		return
	end

	local function var_69_6(arg_74_0, arg_74_1)
		if arg_69_0.animPlaying then
			return
		end

		local var_74_0 = arg_74_0:GetConfigID()

		if arg_69_0.animID == var_74_0 then
			return
		end

		local var_74_1 = arg_69_0:GetAnimPlayList(var_74_0)
		local var_74_2 = Dorm3dCameraAnim.New({
			configId = arg_69_0.animID
		}):GetFinishAnimID()

		arg_69_0.animID = var_74_0

		var_69_5()
		arg_69_0:BlockActionPanel(true)

		arg_69_0.animPlaying = true

		local var_74_3 = (table.indexof(var_74_1, _.detect(var_74_1, function(arg_75_0)
			return arg_75_0:GetConfigID() == var_74_2
		end)) or 0) + 1
		local var_74_4 = _.rest(var_74_1, var_74_3)
		local var_74_5 = arg_74_1:Find("Slider"):GetComponent(typeof(Slider))

		setActive(arg_74_1:Find("Slider"), true)

		local function var_74_6()
			setActive(arg_74_1:Find("Selected"), true)
			setActive(arg_74_1:Find("Slider"), false)
			arg_69_0:BlockActionPanel(false)

			arg_69_0.animPlaying = nil

			return
		end

		if #var_74_4 == 0 then
			(function()
				setActive(arg_74_1:Find("Selected"), true)
				setActive(arg_74_1:Find("Slider"), false)
				arg_69_0:BlockActionPanel(false)

				arg_69_0.animPlaying = nil

				return
			end)()

			return
		end

		local function var_74_7(arg_77_0, arg_77_1, arg_77_2)
			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayEnterSceneAnim", arg_77_0:GetEnterSceneAnim(), arg_77_2 ~= arg_77_1, arg_69_0.animSpeed)
			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayEnterExtraItem", arg_77_0:GetEnterExtraItem(), arg_69_0.animSpeed)
			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideSceneItem", arg_77_0:GetHideSceneItem())

			arg_69_0.cacheSceneAnim = arg_77_0:GetEnterSceneAnim()
			arg_69_0.cacheExtraItem = arg_77_0:GetEnterExtraItem()

			return
		end

		local var_74_8 = _.reduce(var_74_4, 0, function(arg_78_0, arg_78_1)
			return arg_78_0 + math.max(var_0_2, arg_78_1:GetAnimTime())
		end)

		if arg_69_0.timerAnim then
			arg_69_0.timerAnim:Stop()
		end

		arg_69_0.animInfo = {
			index = 1,
			passedTime = 0,
			ratio = 0,
			animPlayList = var_74_4,
			totalTime = _.reduce(var_74_4, 0, function(arg_78_0, arg_78_1)
				return arg_78_0 + math.max(var_0_2, arg_78_1:GetAnimTime())
			end),
			startStamp = Time.time
		}
		arg_69_0.timerAnim = FrameTimer.New(function()
			local var_79_0 = math.max(var_0_2, arg_69_0.animInfo.animPlayList[arg_69_0.animInfo.index]:GetAnimTime())
			local var_79_1 = math.min(1, arg_69_0.animInfo.ratio + (Time.time - arg_69_0.animInfo.startStamp) * arg_69_0.animSpeed / var_79_0)

			var_74_5.value = (arg_69_0.animInfo.passedTime + var_79_0 * var_79_1) / var_74_8

			if var_79_1 < 1 then
				return
			end

			arg_69_0.animInfo.index = arg_69_0.animInfo.index + 1
			arg_69_0.animInfo.ratio = 0
			arg_69_0.animInfo.passedTime = arg_69_0.animInfo.passedTime + var_79_0
			arg_69_0.animInfo.startStamp = Time.time

			local var_79_2 = arg_69_0.animInfo.animPlayList[arg_69_0.animInfo.index]:GetStartPoint()

			if #var_79_2 > 0 then
				arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_79_2)
			end

			if arg_69_0.animInfo.index > #arg_69_0.animInfo.animPlayList then
				var_74_6()
				arg_69_0.timerAnim:Stop()

				arg_69_0.timerAnim = nil
				arg_69_0.animInfo = nil

				return
			end

			local var_79_3 = arg_69_0.animInfo.animPlayList[arg_69_0.animInfo.index]

			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", arg_69_0.animInfo.animPlayList[arg_69_0.animInfo.index]:GetStateName(), nil, 0)
			var_74_7(var_79_3, var_74_0, var_74_2)

			return
		end, 1, -1)

		local var_74_9 = arg_69_0.animInfo.animPlayList[1]

		if var_74_3 == 1 then
			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchCurrentAnim", arg_69_0.animInfo.animPlayList[1]:GetStateName())
			onNextTick(function()
				local var_80_0 = var_74_9:GetStartPoint()

				if #var_80_0 == 0 then
					var_80_0 = var_69_0:GetWatchCameraName()
				end

				arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_80_0)
				arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SyncCurrentInterestTransform")
				var_74_7(var_74_9, var_74_0, var_74_2)

				if arg_69_0.freeMode then
					local var_80_1 = arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController))

					arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE].transform.forward.y = 0

					arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE].transform.forward:Normalize()
					var_80_1:Move(arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE].transform.forward * -0.01)
					var_80_1:Move(-(arg_69_0.scene.cameras[arg_69_0.scene.CAMERA.PHOTO_FREE].transform.forward * -0.01))
				end

				return
			end)
		else
			arg_69_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", arg_69_0.animInfo.animPlayList[1]:GetStateName(), nil, 0)
			var_74_7(arg_69_0.animInfo.animPlayList[1], var_74_0, (Dorm3dCameraAnim.New({
				configId = arg_69_0.animID
			}):GetFinishAnimID()))
		end

		arg_69_0.timerAnim:Start()

		return
	end

	UIItemList.StaticAlign(var_69_2, var_69_2:GetChild(0), #var_69_1, function(arg_81_0, arg_81_1, arg_81_2)
		if arg_81_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_81_1 = arg_81_1 + 1

		local var_81_0 = var_69_1[arg_81_1]

		setText(arg_81_2:Find("Name"), var_69_1[arg_81_1]:GetName())
		GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", var_69_1[arg_81_1]:GetZoneIcon()), "", arg_81_2:Find("Icon"))
		setActive(arg_81_2:Find("Slider"), false)
		setActive(arg_81_2:Find("Selected"), false)
		onButton(arg_69_0, arg_81_2, function()
			var_69_6(var_81_0, arg_81_2)

			return
		end)

		return
	end)

	local function var_69_7()
		UIItemList.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_3, function(arg_84_0, arg_84_1, arg_84_2)
			if arg_84_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_84_1 = arg_84_1 + 1

			local var_84_0 = arg_84_2:Find("Actions")

			UIItemList.StaticAlign(var_84_0, var_84_0:GetChild(0), #var_69_3[arg_84_1].anims, function(arg_85_0, arg_85_1, arg_85_2)
				if arg_85_0 ~= UIItemList.EventUpdate then
					return
				end

				arg_85_1 = arg_85_1 + 1

				setActive(arg_85_2:Find("Selected"), var_0[arg_85_1]:GetConfigID() == arg_69_0.animID)
				setActive(arg_85_2:Find("Slider"), var_85_0:GetConfigID() == arg_69_0.animID and tobool(arg_69_0.timerAnim))

				return
			end)

			return
		end)

		return
	end

	local function var_69_8()
		UIItemList.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_3, function(arg_87_0, arg_87_1, arg_87_2)
			if arg_87_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_87_1 = arg_87_1 + 1

			setActive(arg_87_2:Find("Button/Active"), arg_69_0.settingSpecialFurnitureIndex == arg_87_1)
			setActive(arg_87_2:Find("Actions"), arg_69_0.settingSpecialFurnitureIndex == arg_87_1)

			return
		end)
		var_69_7()

		return
	end

	local function var_69_9(arg_88_0, arg_88_1)
		local var_88_0 = arg_88_1:Find("Actions")

		UIItemList.StaticAlign(var_88_0, var_88_0:GetChild(0), #arg_88_0.anims, function(arg_89_0, arg_89_1, arg_89_2)
			if arg_89_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_89_1 = arg_89_1 + 1

			local var_89_0 = var_0[arg_89_1]
			local var_89_1 = var_69_0:CheckFurnitureIdInZone(arg_88_0.furnitureId)
			local var_89_2 = arg_69_0.room:IsFurnitureSetIn(arg_88_0.furnitureId)
			local var_89_3 = var_89_1 and var_89_2

			SetActive(arg_89_2:Find("Other"), not (var_89_1 and var_89_2))
			SetActive(arg_89_2:Find("Name"), var_89_3)

			if var_89_3 then
				onButton(arg_69_0, arg_89_2, function()
					var_69_6(var_89_0, arg_89_2)

					return
				end)
				setText(arg_89_2:Find("Name"), var_89_0:GetName())
			else
				removeOnButton(arg_89_2)

				warnText = not var_89_1 and i18n("dorm3d_photo_active_zone", (var_89_0:GetZoneName())) or i18n("dorm3d_furniture_replace_tip")

				setText(arg_89_2:Find("Other/Content"), warnText)
			end

			GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", var_89_0:GetZoneIcon()), "", arg_89_2:Find("Icon"))
			setActive(arg_89_2:Find("Slider"), false)
			setActive(arg_89_2:Find("Selected"), false)

			return
		end)

		return
	end

	setActive(var_69_4, #var_69_3 > 0)
	UIItemList.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_3, function(arg_91_0, arg_91_1, arg_91_2)
		if arg_91_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_91_1 = arg_91_1 + 1

		local var_91_0 = var_69_3[arg_91_1]
		local var_91_1 = Dorm3dFurniture.New({
			configId = var_69_3[arg_91_1].furnitureId
		})
		local var_91_2 = tobool(_.detect(arg_69_0.room:GetFurnitures(), function(arg_92_0)
			return arg_92_0:GetConfigID() == var_91_0.furnitureId
		end))

		setText(arg_91_2:Find("Button/Name"), var_91_1:GetName())
		GetImageSpriteFromAtlasAsync(var_91_1:GetIcon(), "", arg_91_2:Find("Button/Icon"))
		setActive(arg_91_2:Find("Button/Lock"), not var_91_2)
		setActive(arg_91_2:Find("Button/BG"), var_91_2)

		local var_91_3 = var_69_0:CheckFurnitureIdInZone(var_91_0.furnitureId) and Color.New(1, 1, 1, 0.8509803921568627) or Color.New(0.788235294117647, 0.788235294117647, 0.788235294117647, 0.8509803921568627)

		setImageColor(arg_91_2:Find("Button/BG"), var_91_3)
		onButton(arg_69_0, arg_91_2:Find("Button"), function()
			if not var_91_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_furniture_locked"))

				return
			end

			if arg_69_0.settingSpecialFurnitureIndex == arg_91_1 then
				arg_69_0.settingSpecialFurnitureIndex = nil
			else
				arg_69_0.settingSpecialFurnitureIndex = arg_91_1
			end

			var_69_8()

			return
		end)
		var_69_9(var_91_0, arg_91_2)

		return
	end)
	var_69_8()
	var_69_5()

	return
end

function var_0_0.BlockActionPanel(arg_94_0, arg_94_1)
	return
end

function var_0_0.GetAnimPlayList(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1
	local var_95_1 = 100

	while true do
		local var_95_2 = Dorm3dCameraAnim.New({
			configId = var_95_0
		})

		if not var_95_2 then
			return {}
		end

		table.insert({}, 1, var_95_2)

		var_95_0 = var_95_2:GetPreAnimID()

		if var_95_0 == 0 then
			return {}
		end

		var_95_1 = var_95_1 - 1

		assert(var_95_1 > 0)
	end

	return
end

function var_0_0.UpdateCameraPanel(arg_96_0)
	if not arg_96_0.activeSetting then
		return
	end

	if arg_96_0.activePanel ~= var_0_0.PANEL.CAMERA then
		return
	end

	;(function()
		local var_97_0 = arg_96_0.panelCamera:Find("Layout/DepthOfField/Switch/Toggle")

		triggerToggle(var_97_0, arg_96_0.cameraSettings.depthOfField.enabled)
		onToggle(arg_96_0, var_97_0, function(arg_98_0)
			arg_96_0.cameraSettings.depthOfField.enabled = arg_98_0

			setActive(arg_96_0.panelCamera:Find("Layout/DepthOfField/DepthOfField"), arg_96_0.cameraSettings.depthOfField.enabled)
			arg_96_0:RefreshCamera()

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()
	setActive(arg_96_0.panelCamera:Find("Layout/DepthOfField/DepthOfField"), arg_96_0.cameraSettings.depthOfField.enabled)
	;(function()
		local var_99_0 = arg_96_0.panelCamera:Find("Layout/DepthOfField/DepthOfField/FocusDistance/Slider")

		setSlider(var_99_0, arg_96_0.cameraSettings.depthOfField.focusDistance.min, arg_96_0.cameraSettings.depthOfField.focusDistance.max, arg_96_0.cameraSettings.depthOfField.focusDistance.value)
		onSlider(arg_96_0, var_99_0, function(arg_100_0)
			var_0.value = arg_100_0

			arg_96_0:RefreshCamera()

			return
		end)

		return
	end)()
	;(function()
		local var_101_0 = arg_96_0.panelCamera:Find("Layout/DepthOfField/DepthOfField/BlurRadius/Slider")

		setSlider(var_101_0, arg_96_0.cameraSettings.depthOfField.blurRadius.min, arg_96_0.cameraSettings.depthOfField.blurRadius.max, arg_96_0.cameraSettings.depthOfField.blurRadius.value)
		onSlider(arg_96_0, var_101_0, function(arg_102_0)
			var_0.value = arg_102_0

			arg_96_0:RefreshCamera()

			return
		end)

		return
	end)()

	local var_96_0 = {
		"PostExposure",
		"Saturation",
		"Contrast"
	}

	arg_96_0.paramIndex = arg_96_0.paramIndex or 1

	local function var_96_1()
		table.Ipairs(var_96_0, function(arg_104_0, arg_104_1)
			local var_104_0 = arg_96_0.panelCamera:Find("Layout/Paramaters/Icons"):GetChild(arg_104_0 - 1)

			setActive(var_104_0:Find("Selected"), arg_104_0 == arg_96_0.paramIndex)
			setActive(arg_96_0.panelCamera:Find("Layout/Paramaters/" .. arg_104_1), arg_104_0 == arg_96_0.paramIndex)

			return
		end)

		return
	end

	table.Ipairs({
		"PostExposure",
		"Saturation",
		"Contrast"
	}, function(arg_105_0, arg_105_1)
		onButton(arg_96_0, arg_96_0.panelCamera:Find("Layout/Paramaters/Icons"):GetChild(arg_105_0 - 1), function()
			arg_96_0.paramIndex = arg_105_0

			var_96_1()

			return
		end, SFX_PANEL)

		return
	end)
	;(function()
		table.Ipairs(var_96_0, function(arg_104_0, arg_104_1)
			local var_104_0 = arg_96_0.panelCamera:Find("Layout/Paramaters/Icons"):GetChild(arg_104_0 - 1)

			setActive(var_104_0:Find("Selected"), arg_104_0 == arg_96_0.paramIndex)
			setActive(arg_96_0.panelCamera:Find("Layout/Paramaters/" .. arg_104_1), arg_104_0 == arg_96_0.paramIndex)

			return
		end)

		return
	end)()
	;(function()
		local var_107_0 = arg_96_0.cameraSettings.postExposure
		local var_107_1 = arg_96_0.panelCamera:Find("Layout/Paramaters/PostExposure/PostExposure/Slider")
		local var_107_2 = var_107_1:Find("Background/Fill")

		onSlider(arg_96_0, var_107_1, function(arg_108_0)
			var_107_0.value = arg_108_0
			var_107_2.anchorMin = Vector2.New(math.min((arg_108_0 - var_107_0.min) / (var_107_0.max - var_107_0.min), 0.5), 0)
			var_107_2.anchorMax = Vector2.New(math.max((arg_108_0 - var_107_0.min) / (var_107_0.max - var_107_0.min), 0.5), 1)
			var_107_2.offsetMin = Vector2.zero
			var_107_2.offsetMax = Vector2.zero

			arg_96_0:RefreshCamera()

			return
		end)
		setSlider(var_107_1, arg_96_0.cameraSettings.postExposure.min, arg_96_0.cameraSettings.postExposure.max, arg_96_0.cameraSettings.postExposure.value)

		return
	end)()
	;(function()
		local var_109_0 = arg_96_0.cameraSettings.contrast
		local var_109_1 = arg_96_0.panelCamera:Find("Layout/Paramaters/Contrast/Contrast/Slider")
		local var_109_2 = var_109_1:Find("Background/Fill")

		onSlider(arg_96_0, var_109_1, function(arg_110_0)
			var_109_0.value = arg_110_0
			var_109_2.anchorMin = Vector2.New(math.min((arg_110_0 - var_109_0.min) / (var_109_0.max - var_109_0.min), 0.5), 0)
			var_109_2.anchorMax = Vector2.New(math.max((arg_110_0 - var_109_0.min) / (var_109_0.max - var_109_0.min), 0.5), 1)
			var_109_2.offsetMin = Vector2.zero
			var_109_2.offsetMax = Vector2.zero

			arg_96_0:RefreshCamera()

			return
		end)
		setSlider(var_109_1, arg_96_0.cameraSettings.contrast.min, arg_96_0.cameraSettings.contrast.max, arg_96_0.cameraSettings.contrast.value)

		return
	end)()
	;(function()
		local var_111_0 = arg_96_0.cameraSettings.saturate
		local var_111_1 = arg_96_0.panelCamera:Find("Layout/Paramaters/Saturation/Saturation/Slider")
		local var_111_2 = var_111_1:Find("Background/Fill")

		onSlider(arg_96_0, var_111_1, function(arg_112_0)
			var_111_0.value = arg_112_0
			var_111_2.anchorMin = Vector2.New(math.min((arg_112_0 - var_111_0.min) / (var_111_0.max - var_111_0.min), 0.5), 0)
			var_111_2.anchorMax = Vector2.New(math.max((arg_112_0 - var_111_0.min) / (var_111_0.max - var_111_0.min), 0.5), 1)
			var_111_2.offsetMin = Vector2.zero
			var_111_2.offsetMax = Vector2.zero

			arg_96_0:RefreshCamera()

			return
		end)
		setSlider(var_111_1, arg_96_0.cameraSettings.saturate.min, arg_96_0.cameraSettings.saturate.max, arg_96_0.cameraSettings.saturate.value)

		return
	end)()
	;(function()
		local var_113_0 = arg_96_0.panelCamera:Find("Layout/Other/FaceCamera/Toggle")

		triggerToggle(var_113_0, arg_96_0.settingFaceCamera)
		onToggle(arg_96_0, var_113_0, function(arg_114_0)
			arg_96_0.settingFaceCamera = arg_114_0

			arg_96_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnableCurrentHeadIK", arg_114_0)

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()
	;(function()
		local var_115_0 = arg_96_0.panelCamera:Find("Layout/Other/HideCharacter/Toggle")

		triggerToggle(var_115_0, arg_96_0.settingHideCharacter)
		onToggle(arg_96_0, var_115_0, function(arg_116_0)
			arg_96_0.settingHideCharacter = arg_116_0

			if arg_116_0 then
				arg_96_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideCharacterBylayer")
			else
				arg_96_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
			end

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()

	return
end

function var_0_0.RefreshCamera(arg_117_0)
	arg_117_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SettingCamera", arg_117_0.cameraSettings)

	return
end

function var_0_0.SetAllAnimSpeed(arg_118_0, arg_118_1)
	arg_118_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetCharacterAnimSpeed", arg_118_1)
	arg_118_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetSceneAnimSpeed", arg_118_0.cacheSceneAnim, arg_118_1)
	arg_118_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetExtraAnimSpeed", arg_118_0.cacheExtraItem, arg_118_1)

	return
end

function var_0_0.UpdateAnimSpeedPanel(arg_119_0)
	local function var_119_0()
		if not arg_119_0.timerAnim then
			return
		end

		local var_120_0 = arg_119_0.animInfo

		var_120_0.ratio = math.min(1, arg_119_0.animInfo.ratio + (Time.time - arg_119_0.animInfo.startStamp) * arg_119_0.animSpeed / math.max(var_0_2, arg_119_0.animInfo.animPlayList[arg_119_0.animInfo.index]:GetAnimTime()))
		var_120_0.startStamp = Time.time

		return
	end

	local var_119_1 = arg_119_0.animSpeeds

	UIItemList.StaticAlign(arg_119_0.listAnimSpeed, arg_119_0.listAnimSpeed:GetChild(0), #arg_119_0.animSpeeds, function(arg_121_0, arg_121_1, arg_121_2)
		if arg_121_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_121_1 = #var_119_1 - arg_121_1

		local var_121_0 = var_119_1[arg_121_1]

		setText(arg_121_2:Find("Name"), var_119_1[arg_121_1])
		setText(arg_121_2:Find("Selected"), var_119_1[arg_121_1])
		setActive(arg_121_2:Find("Line"), arg_121_1 ~= #var_119_1)
		onButton(arg_119_0, arg_121_2, function()
			if arg_119_0.animSpeed == var_121_0 then
				return
			end

			var_119_0()

			arg_119_0.animSpeed = var_121_0

			arg_119_0:SetAllAnimSpeed(var_121_0)
			arg_119_0:UpdateAnimSpeedPanel()

			return
		end, SFX_PANEL)

		return
	end)
	onButton(arg_119_0, arg_119_0.btnFreeze, function()
		local var_123_0 = 0

		if arg_119_0.animSpeed ~= 0 then
			arg_119_0.lastAnimSpeed = arg_119_0.animSpeed
		else
			var_123_0 = arg_119_0.lastAnimSpeed or 1
			arg_119_0.lastAnimSpeed = nil
		end

		var_119_0()

		arg_119_0.animSpeed = var_123_0

		arg_119_0:SetAllAnimSpeed(var_123_0)
		arg_119_0:UpdateAnimSpeedPanel()

		return
	end, SFX_PANEL)
	UIItemList.StaticAlign(arg_119_0.listAnimSpeed, arg_119_0.listAnimSpeed:GetChild(0), #arg_119_0.animSpeeds, function(arg_124_0, arg_124_1, arg_124_2)
		if arg_124_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_124_1 = #var_119_1 - arg_124_1

		local var_124_0 = var_119_1[arg_124_1]

		setActive(arg_124_2:Find("Name"), arg_119_0.animSpeed ~= var_119_1[arg_124_1])
		setActive(arg_124_2:Find("Selected"), arg_119_0.animSpeed == var_124_0)

		return
	end)
	setActive(arg_119_0.btnFreeze:Find("Icon"), arg_119_0.animSpeed ~= 0)
	setActive(arg_119_0.btnFreeze:Find("Selected"), arg_119_0.animSpeed == 0)
	setText(arg_119_0.textAnimSpeed, i18n("dorm3d_photo_animspeed", string.format("%.1f", arg_119_0.animSpeed)))

	return
end

function var_0_0.UpdateLightingPanel(arg_125_0)
	if not arg_125_0.activeSetting then
		return
	end

	if arg_125_0.activePanel ~= var_0_0.PANEL.LIGHTING then
		return
	end

	local var_125_0 = {}

	for iter_125_0, iter_125_1 in ipairs(pg.dorm3d_camera_volume_template.all) do
		table.insert(var_125_0, iter_125_1)
	end

	table.sort(var_125_0, function(arg_126_0, arg_126_1)
		return arg_126_0 < arg_126_1
	end)

	local function var_125_1()
		if not arg_125_0.settingFilterIndex then
			arg_125_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertVolumeProfile")

			return
		end

		arg_125_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetVolumeProfile", pg.dorm3d_camera_volume_template[var_125_0[arg_125_0.settingFilterIndex]].volume, arg_125_0.settingFilterStrength)

		return
	end

	UIItemList.StaticAlign(arg_125_0.panelLightning:Find("Layout/Filter/List"), arg_125_0.panelLightning:Find("Layout/Filter/List"):GetChild(0), #var_125_0, function(arg_128_0, arg_128_1, arg_128_2)
		if arg_128_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_128_1 = arg_128_1 + 1

		local var_128_0 = pg.dorm3d_camera_volume_template[var_125_0[arg_128_1]]

		setText(arg_128_2:Find("Name"), pg.dorm3d_camera_volume_template[var_125_0[arg_128_1]].name)

		var_128_0.icon = ""

		if var_128_0.icon ~= "" then
			GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", var_128_0.icon), "", arg_128_2:Find("BG"))
		end

		if arg_125_0.settingFilterIndex == arg_128_1 then
			setActive(arg_128_2:Find("Selected"), true)
		else
			setActive(arg_128_2:Find("Selected"), false)
		end

		local var_128_1, var_128_2 = ApartmentProxy.CheckUnlockConfig(var_128_0.unlock)

		setActive(arg_128_2:Find("lock"), not var_128_1)

		if not var_128_1 then
			setText(arg_128_2:Find("lock/Image/Text"), var_128_0.unlock_text)
		end

		onButton(arg_125_0, arg_128_2, function()
			if not var_128_1 then
				pg.TipsMgr.GetInstance():ShowTips(var_128_2)

				return
			end

			local var_129_0 = arg_125_0.settingFilterIndex

			arg_125_0.settingFilterIndex = arg_125_0.settingFilterIndex ~= arg_128_1 and arg_128_1 or nil

			var_125_1()

			if var_129_0 then
				setActive(arg_125_0.panelLightning:Find("Layout/Filter/List"):GetChild(var_129_0 - 1):Find("Selected"), false)
			end

			if arg_125_0.settingFilterIndex == arg_128_1 then
				setActive(arg_128_2:Find("Selected"), true)
			end

			return
		end, SFX_PANEL)

		return
	end)
	setActive(arg_125_0.panelLightning:Find("Layout/Filter/Slider"), false)

	return
end

function var_0_0.OnSwitchSkin(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
	seriesAsync({
		function(arg_131_0)
			if arg_130_0.settingHideCharacter then
				arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
			end

			arg_130_1:SwitchCharacterSkin(arg_130_2, arg_130_3, arg_131_0)

			return
		end,
		function(arg_132_0)
			setActive(arg_130_1.ladySafeCollider, true)

			if not arg_130_0.animInfo then
				return arg_132_0()
			end

			for iter_132_0 = #arg_130_0.animInfo.animPlayList, 1, -1 do
				local var_132_1 = var_132_0.animPlayList[iter_132_0]:GetStartPoint()

				if #var_132_1 > 0 then
					arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_132_1)

					break
				end

				if iter_132_0 == 1 then
					local var_132_2 = arg_130_0.room:GetCameraZones()[arg_130_0.zoneIndex]

					arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_132_2:GetWatchCameraName())
				end
			end

			arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SyncCurrentInterestTransform")
			arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", var_132_0.animPlayList[#var_132_0.animPlayList]:GetStateName())
			arg_130_0.scene.ladyDict[arg_130_2].ladyAnimator:Update((var_132_0.animPlayList[#var_132_0.animPlayList]:GetAnimTime()))
			arg_130_0.timerAnim:Stop()

			arg_130_0.timerAnim = nil
			arg_130_0.animInfo = nil
			arg_130_0.animPlaying = nil

			arg_132_0()

			return
		end,
		function()
			arg_130_0:UpdateActionPanel()

			if arg_130_0.settingHideCharacter then
				arg_130_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideCharacterBylayer")
			end

			return
		end
	})

	return
end

function var_0_0.SetMute(arg_134_0)
	if arg_134_0 then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

function var_0_0.willExit(arg_135_0)
	arg_135_0.loader:Clear()

	if arg_135_0.timerAnim then
		arg_135_0.timerAnim:Stop()

		arg_135_0.timerAnim = nil
	end

	if arg_135_0.animSpeed ~= 1 then
		arg_135_0:SetAllAnimSpeed(1)
	end

	if arg_135_0.settingHideCharacter then
		arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
	end

	if not arg_135_0.settingFaceCamera then
		arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnableCurrentHeadIK", true)
	end

	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetSceneItemAnimators")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCharacterExtraItem")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetTempHideSceneItems")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterLight")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertVolumeProfile")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCameraSettings")
	arg_135_0.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ExitPhotoMode")

	return
end

function var_0_0.SetPhotoCameraSliderValue(arg_136_0, arg_136_1)
	setSlider(arg_136_0.normalPanel:Find("Zoom/Slider"), 0, 1, arg_136_1)

	return
end

function var_0_0.SetPhotoStickDelta(arg_137_0, arg_137_1)
	arg_137_1 = arg_137_1 * 0.5

	local var_137_0 = arg_137_0._tf:Find("Center/Stick")

	setAnchoredPosition(var_137_0:Find("Handler"), Vector2.New(var_137_0.rect.height * arg_137_1.x, var_137_0.rect.width * arg_137_1.y))

	return
end

return var_0_0
