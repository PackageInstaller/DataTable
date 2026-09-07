local Dorm3dPhotoLayer = class("Dorm3dPhotoLayer", import("view.base.BaseUI"))

function Dorm3dPhotoLayer:getUIName()
	return "Dorm3dPhotoUI"
end

Dorm3dPhotoLayer.PANEL = {
	ACTION = 1,
	LIGHTING = 3,
	CAMERA = 2
}

function Dorm3dPhotoLayer:init()
	self.centerPanel = self._tf:Find("Center")
	self.normalPanel = self._tf:Find("Center/Normal")

	setActive(self.normalPanel, true)

	self.settingPanel = self._tf:Find("Center/Settings")
	self.btnAction = self.settingPanel:Find("Action")
	self.btnCamera = self.settingPanel:Find("Camera")
	self.btnLighting = self.settingPanel:Find("Lighting")
	self.panelAction = self.settingPanel:Find("ActionSelect")

	setActive(self.panelAction, false)
	setActive(self.panelAction:Find("Mask"), false)

	self.panelCamera = self.settingPanel:Find("CameraSettings")

	setActive(self.panelCamera, false)

	self.panelLightning = self.settingPanel:Find("LightningSettings")

	setActive(self.panelLightning, false)

	self.listZones = self._tf:Find("ZoneList")

	setActive(self.listZones, false)

	self.zoneMask = self.listZones:Find("Mask")
	self.btnHideUI = self._tf:Find("Center/HideUI")
	self.btnReset = self._tf:Find("Center/Reset")
	self.btnFreeze = self._tf:Find("Center/Freeze")
	self.btnMove = self._tf:Find("Center/Move")
	self.btnZone = self._tf:Find("Center/Zone")
	self.btnAr = self._tf:Find("Center/Ar")
	self.ARchecker = GetComponent(self.btnAr.gameObject, "ARChecker")
	self.btnAnimSpeed = self._tf:Find("Center/AnimSpeed")
	self.listAnimSpeed = self.btnAnimSpeed:Find("Bar")

	setActive(self.listAnimSpeed, false)

	self.textAnimSpeed = self.btnAnimSpeed:Find("Text")
	self.hideuiMask = self._tf:Find("RightTop/Mask")

	setActive(self.hideuiMask, false)

	self.btnFilm = self._tf:Find("RightTop/Film/Film")
	self.filmTime = self._tf:Find("RightTop/FilmTime")

	setActive(self.filmTime, false)

	self.shareUI = self._tf:Find("ShareUI")

	setActive(self.shareUI, false)

	self.ysScreenShoter = self._tf:Find("Shoter"):GetComponent(typeof(YSTool.YSScreenShoter))
	self.btnMenuSmall = self._tf:Find("Center/MenuSmall")
	self.btnMenu = self._tf:Find("Center/Menu")

	setActive(self.panelAction:Find("Layout/Regular/Index"), false)
	setText(self.panelCamera:Find("Layout/DepthOfField/Title/Text"), i18n("dorm3d_photo_len"))
	setText(self.panelCamera:Find("Layout/DepthOfField/Switch/Title"), i18n("dorm3d_photo_depthoffield"))
	setText(self.panelCamera:Find("Layout/DepthOfField/DepthOfField/FocusDistance/Title"), i18n("dorm3d_photo_focusdistance"))
	setText(self.panelCamera:Find("Layout/DepthOfField/DepthOfField/BlurRadius/Title"), i18n("dorm3d_photo_focusstrength"))
	setText(self.panelCamera:Find("Layout/Paramaters/Title/Text"), i18n("dorm3d_photo_paramaters"))
	setText(self.panelCamera:Find("Layout/Paramaters/PostExposure/PostExposure/Title"), i18n("dorm3d_photo_postexposure"))
	setText(self.panelCamera:Find("Layout/Paramaters/Saturation/Saturation/Title"), i18n("dorm3d_photo_saturation"))
	setText(self.panelCamera:Find("Layout/Paramaters/Contrast/Contrast/Title"), i18n("dorm3d_photo_contrast"))
	setText(self.panelCamera:Find("Layout/Other/Title/Text"), i18n("dorm3d_photo_Others"))
	setText(self.panelCamera:Find("Layout/Other/HideCharacter/Title"), i18n("dorm3d_photo_hidecharacter"))
	setText(self.panelCamera:Find("Layout/Other/FaceCamera/Title"), i18n("dorm3d_photo_facecamera"))
	setText(self.panelLightning:Find("Layout/Title/Filter/Name"), i18n("dorm3d_photo_filter"))
	setText(self.panelLightning:Find("Layout/Title/Filter/Selected"), i18n("dorm3d_photo_filter"))
	setText(self.panelAction:Find("Layout/Title/Regular/Name"), i18n("dorm3d_photo_regular_anim"))
	setText(self.panelAction:Find("Layout/Title/Regular/Selected"), i18n("dorm3d_photo_regular_anim"))
	setText(self.panelAction:Find("Layout/Title/Special/Name"), i18n("dorm3d_photo_special_anim"))
	setText(self.panelAction:Find("Layout/Title/Special/Selected"), i18n("dorm3d_photo_special_anim"))

	self.mainCamera = GameObject.Find("BackYardMainCamera"):GetComponent(typeof(Camera))
	self.stopRecBtn = self._tf:Find("stopRec")
	self.videoTipPanel = self._tf:Find("videoTipPanel")

	setActive(self.videoTipPanel, false)

	self.loader = AutoLoader.New()

	return
end

function Dorm3dPhotoLayer:SetSceneRoot(arg_3_1)
	self.scene = arg_3_1

	return
end

function Dorm3dPhotoLayer:SetRoom(arg_4_1)
	self.room = arg_4_1

	return
end

function Dorm3dPhotoLayer:SetGroupId(arg_5_1)
	self.groupId = arg_5_1

	return
end

function Dorm3dPhotoLayer:onBackPressed()
	if self.recordState then
		triggerButton(self.btnFilm)

		return
	end

	if self.activeSetting then
		triggerButton(self._tf:Find("Center/Settings/Back"))

		return
	end

	self:closeView()

	return
end

function Dorm3dPhotoLayer:didEnter()
	onButton(self, self._tf:Find("Center/Normal/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_7_0 = self.normalPanel:Find("Zoom/Slider")

	setSlider(var_7_0, 0, 1, 0)
	onSlider(self, var_7_0, function(arg_9_0)
		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetPhotoCameraHeight", arg_9_0)

		return
	end)
	setActive(var_7_0, false)

	local var_7_1 = self._tf:Find("Center/Stick")

	setActive(var_7_1, false)

	self.activeSetting = false

	onButton(self, self._tf:Find("Center/Normal/Settings"), function()
		self.activeSetting = true

		quickPlayAnimation(self._tf:Find("Center"), "anim_dorm3d_photo_normal_out")
		self:UpdateActionPanel()
		self:UpdateCameraPanel()
		self:UpdateLightingPanel()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Center/Settings/Back"), function()
		self.activeSetting = false

		quickPlayAnimation(self._tf:Find("Center"), "anim_dorm3d_photo_normal_in")

		return
	end, SFX_CANCEL)

	self.hideUI = false

	onButton(self, self.btnHideUI, function()
		if self.hideUI then
			return
		end

		setActive(self.hideuiMask, true)
		setActive(self.centerPanel, false)

		self.hideUI = true

		return
	end, SFX_PANEL)
	onButton(self, self.hideuiMask, function()
		if not self.hideUI then
			return
		end

		setActive(self.centerPanel, true)
		setActive(self.hideuiMask, false)

		self.hideUI = false

		return
	end)
	onButton(self, self.btnReset, function()
		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetPhotoCameraPosition")

		return
	end, SFX_PANEL)

	self.recordState = false

	onButton(self, self.btnFilm, function()
		local function var_15_0(arg_16_0)
			setActive(self.centerPanel, arg_16_0)

			self._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = arg_16_0 and 1 or 0

			return
		end

		if not self.recordState then
			local function var_15_1(arg_17_0)
				if not arg_17_0 then
					var_15_0(true)

					self.recordState = false

					LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15)
				else
					self.recordState = true
				end

				return
			end

			local function var_15_2()
				setActive(self.stopRecBtn, true)
				LeanTween.moveX(self.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					Dorm3dPhotoLayer.SetMute(true)

					self.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_15_1, self.recordFilePath)

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

						self.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

						onButton(self, self.videoTipPanel, function()
							setActive(self.videoTipPanel, false)
							var_15_2()

							return
						end)
						setActive(self.videoTipPanel, true)
					else
						var_15_2()
					end

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.stopRecBtn, function()
		self.recordState = false

		local function var_23_0(arg_24_0)
			if arg_24_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(self.recordFilePath) then
							System.IO.File.Delete(self.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(self.recordFilePath, function(arg_27_0, arg_27_1)
							if arg_27_0 then
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

			self.recordState = false

			return
		end

		local function var_23_1(arg_28_0)
			setActive(self.centerPanel, arg_28_0)

			self._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = arg_28_0 and 1 or 0

			return
		end

		if not LeanTween.isTweening(go(self.stopRecBtn)) then
			LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(self.stopRecBtn, false)
				seriesAsync({
					function(arg_30_0)
						YSNormalTool.RecordTool.StopRecording(var_23_0)
						var_23_1(true)
						Dorm3dPhotoLayer.SetMute(false)
						pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(self.scene.apartment:GetConfigID(), 2, self.room:GetConfigID(), Dorm3dTrackCommand.BuildCameraMsg(self.room:GetCameraZones()[self.zoneIndex]:GetName(), Dorm3dCameraAnim.New({
							configId = self.animID
						}):GetStateName(), self.cameraSettings.depthOfField.focusDistance.value, self.cameraSettings.depthOfField.blurRadius.value, self.cameraSettings.postExposure.value, self.cameraSettings.contrast.value, self.cameraSettings.saturate.value)))

						return
					end
				})

				return
			end))
		end

		return
	end)
	setActive(self.stopRecBtn, false)
	onButton(self, self._tf:Find("RightTop/Film/Switch"), function()
		GetOrAddComponent(self._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

		quickPlayAnimation(self._tf:Find("RightTop"), "anim_dorm3d_photo_FtoS")

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("RightTop/Shot/Shot"), function()
		local function var_32_1(arg_34_0)
			warning("截图结果：" .. tostring(arg_34_0))

			return
		end

		local function var_32_2(arg_35_0, arg_35_1)
			self:emit(Dorm3dPhotoMediator.SHARE_PANEL, arg_35_1, arg_35_0)
			getProxy(Dorm3dChatProxy):TriggerEvent({
				{
					value = 1,
					event_type = 160,
					ship_id = self.scene.apartment:GetConfigID()
				}
			})
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(self.scene.apartment:GetConfigID(), 1, self.room:GetConfigID(), Dorm3dTrackCommand.BuildCameraMsg(self.room:GetCameraZones()[self.zoneIndex]:GetName(), Dorm3dCameraAnim.New({
				configId = self.animID
			}):GetStateName(), self.cameraSettings.depthOfField.focusDistance.value, self.cameraSettings.depthOfField.blurRadius.value, self.cameraSettings.postExposure.value, self.cameraSettings.contrast.value, self.cameraSettings.saturate.value)))

			return
		end

		local var_32_3, var_32_4 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(self.scene.holyLightRoot)

		GraphicsInterface.Instance:TakePhotoWithPost(self.mainCamera, var_32_3, var_32_4, function(arg_36_0)
			var_32_1(true)
			var_32_2(Tex2DExtension.EncodeToJPG(arg_36_0), arg_36_0)

			return
		end)

		return
	end, "ui-dorm_photograph")

	GetOrAddComponent(self._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = false

	onButton(self, self._tf:Find("RightTop/Shot/Switch"), function()
		GetOrAddComponent(self._tf:Find("RightTop/Film"), typeof(CanvasGroup)).blocksRaycasts = true

		quickPlayAnimation(self._tf:Find("RightTop"), "anim_dorm3d_photo_StoF")

		return
	end, SFX_PANEL)
	onButton(self, self.btnAnimSpeed, function()
		setActive(self.listAnimSpeed, not isActive(self.listAnimSpeed))

		return
	end, SFX_PANEL)
	onButton(self, self.btnZone, function()
		setActive(self.listZones, not isActive(self.listZones))

		return
	end, SFX_PANEL)
	onButton(self, self.zoneMask, function()
		setActive(self.listZones, false)

		return
	end)
	onButton(self, self.btnAr, function()
		self.ARchecker:StartCheck(function(arg_42_0)
			if PLATFORM == PLATFORM_WINDOWSEDITOR then
				arg_42_0 = -1
			end

			originalPrint("AR CODE: " .. arg_42_0)
			self:emit(Dorm3dPhotoMediator.GO_AR, arg_42_0)

			return
		end)

		return
	end)
	onButton(self, self.btnMove, function()
		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchPhotoCamera")

		self.freeMode = not self.freeMode

		setActive(var_7_0, self.freeMode)
		setActive(var_7_1, self.freeMode)
		setActive(self.btnMove:Find("Selected"), self.freeMode)

		return
	end)
	onButton(self, self.btnMenuSmall, function()
		setActive(self.btnMenuSmall, false)
		setActive(self.btnMenu, true)

		return
	end, SFX_PANEL)
	onButton(self, self.btnMenu:Find("Collapse"), function()
		setActive(self.btnMenu, false)
		setActive(self.btnMenuSmall, true)

		return
	end, SFX_PANEL)
	onButton(self, self.btnMenu, function()
		self:emit(Dorm3dPhotoMediator.OPEN_SKIN_SELECT_LAYER, self.groupId, self.scene.ladyDict[self.groupId], function(arg_47_0, arg_47_1, arg_47_2)
			self:OnSwitchSkin(arg_47_0, arg_47_1, arg_47_2)

			return
		end, not self.scene.room:isPersonalRoom())

		return
	end, SFX_PANEL)

	self.activePanel = 1

	local var_7_2 = {
		{
			btn = self.btnAction,
			On = function()
				self:UpdateActionPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = self.btnCamera,
			On = function()
				self:UpdateCameraPanel()

				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = self.btnLighting,
			On = function()
				self:UpdateLightingPanel()

				return
			end,
			Off = function()
				return
			end
		}
	}

	table.Ipairs(var_7_2, function(arg_54_0, arg_54_1)
		onToggle(self, arg_54_1.btn, function(arg_55_0)
			if not arg_55_0 then
				return
			end

			table.Ipairs(var_7_2, function(arg_56_0, arg_56_1)
				if arg_56_0 == arg_54_0 then
					return
				end

				arg_56_1.Off()

				return
			end)

			self.activePanel = arg_54_0

			arg_54_1.On()

			return
		end, SFX_PANEL)

		return
	end)
	;(function()
		triggerToggle(({
			self.panelAction:Find("Layout/Title/Regular"),
			self.panelAction:Find("Layout/Title/Special")
		})[1], true)

		return
	end)()
	;(function()
		triggerToggle(({
			self.panelLightning:Find("Layout/Title/Filter")
		})[1], true)

		return
	end)()

	self.zoneIndex = 1

	self:InitData()
	self:FirstEnterZone()
	triggerToggle(var_7_2[self.activePanel].btn, true)
	self:UpdateZoneList()

	return
end

function Dorm3dPhotoLayer:InitData()
	self.cameraSettings = Clone(self.scene:GetCameraSettings())
	self.settingHideCharacter = false
	self.settingFaceCamera = true
	self.settingFilterIndex = nil
	self.settingFilterStrength = 1

	self:RefreshData()

	return
end

function Dorm3dPhotoLayer:RefreshData()
	local var_60_0 = self.room:GetCameraZones()[self.zoneIndex]

	self.animID = var_60_0:GetRegularAnimsByShipId(self.groupId)[1]:GetConfigID()

	local function var_60_1(arg_61_0, arg_61_1)
		arg_61_0.min = arg_61_1[1]
		arg_61_0.max = arg_61_1[2]
		arg_61_0.value = math.clamp(arg_61_0.value, arg_61_1[1], arg_61_1[2])

		return
	end

	var_60_1(self.cameraSettings.depthOfField.focusDistance, var_60_0:GetFocusDistanceRange())
	var_60_1(self.cameraSettings.depthOfField.blurRadius, var_60_0:GetDepthOfFieldBlurRange())
	var_60_1(self.cameraSettings.postExposure, var_60_0:GetExposureRange())
	var_60_1(self.cameraSettings.contrast, var_60_0:GetContrastRange())
	var_60_1(self.cameraSettings.saturate, var_60_0:GetSaturationRange())

	self.animSpeeds = var_60_0:GetAnimSpeeds()
	self.animSpeed = 1

	return
end

function Dorm3dPhotoLayer:FirstEnterZone()
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnterPhotoMode", self.room:GetCameraZones()[self.zoneIndex], Dorm3dCameraAnim.New({
		configId = self.animID
	}):GetStateName())
	self:UpdateAnimSpeedPanel()

	return
end

function Dorm3dPhotoLayer:SwitchZone()
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchCameraZone", self.room:GetCameraZones()[self.zoneIndex], Dorm3dCameraAnim.New({
		configId = self.animID
	}):GetStateName())

	if self.timerAnim then
		self.timerAnim:Stop()

		self.timerAnim = nil
	end

	self.animPlaying = nil

	self:UpdateActionPanel()
	self:UpdateCameraPanel()
	self:UpdateLightingPanel()
	self:UpdateAnimSpeedPanel()
	self:SetAllAnimSpeed(self.animSpeed)

	return
end

function Dorm3dPhotoLayer:UpdateZoneList()
	local var_64_0 = self.room:GetCameraZones()

	local function var_64_1()
		setText(self.btnZone:Find("Text"), var_64_0[self.zoneIndex]:GetName())
		UIItemList.StaticAlign(self.listZones:Find("List"), self.listZones:Find("List"):GetChild(0), #var_64_0, function(arg_66_0, arg_66_1, arg_66_2)
			if arg_66_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_66_1 = arg_66_1 + 1

			setText(arg_66_2:Find("Name"), var_64_0[arg_66_1]:GetName())
			setTextColor(arg_66_2:Find("Name"), self.zoneIndex == arg_66_1 and Color.NewHex("5CCAFF") or Color.NewHex("FFFFFF99"))
			setActive(arg_66_2:Find("Line"), arg_66_1 < #var_64_0)

			return
		end)

		return
	end

	var_64_1()
	UIItemList.StaticAlign(self.listZones:Find("List"), self.listZones:Find("List"):GetChild(0), #var_64_0, function(arg_67_0, arg_67_1, arg_67_2)
		if arg_67_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_67_1 = arg_67_1 + 1

		onButton(self, arg_67_2, function()
			if self.zoneIndex == arg_67_1 then
				return
			end

			self.zoneIndex = arg_67_1

			self:RefreshData()
			self:SwitchZone()
			setActive(self.listZones, false)
			var_64_1()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

local var_0_2 = 0.2

function Dorm3dPhotoLayer:UpdateActionPanel()
	if not self.activeSetting then
		return
	end

	if self.activePanel ~= Dorm3dPhotoLayer.PANEL.ACTION then
		return
	end

	local var_69_0 = self.room:GetCameraZones()[self.zoneIndex]
	local var_69_1 = var_69_0:GetRegularAnimsByShipId(self.groupId)
	local var_69_2 = self.panelAction:Find("Layout/Regular/Scroll/Viewport/Content")
	local var_69_3 = var_69_0:GetAllSpecialList(self.room.id)
	local var_69_4 = self.panelAction:Find("Layout/Special/Scroll/Viewport/Content")

	setActive(self.panelAction:Find("Layout/Title/Special"), #var_69_3 > 0)

	local function var_69_5()
		UIItemList.StaticAlign(var_69_2, var_69_2:GetChild(0), #var_69_1, function(arg_71_0, arg_71_1, arg_71_2)
			if arg_71_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_71_1 = arg_71_1 + 1

			local var_71_0 = var_69_1[arg_71_1]

			setActive(arg_71_2:Find("Selected"), var_69_1[arg_71_1]:GetConfigID() == self.animID)
			setActive(arg_71_2:Find("Slider"), var_71_0:GetConfigID() == self.animID and tobool(self.timerAnim))

			return
		end)
		UIItemList.StaticAlign(var_69_4, var_69_4:GetChild(0), #var_69_3, function(arg_72_0, arg_72_1, arg_72_2)
			if arg_72_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_72_1 = arg_72_1 + 1

			local var_72_0 = var_69_3[arg_72_1].anims
			local var_72_1 = arg_72_2:Find("Actions")

			UIItemList.StaticAlign(var_72_1, var_72_1:GetChild(0), #var_69_3[arg_72_1].anims, function(arg_73_0, arg_73_1, arg_73_2)
				if arg_73_0 ~= UIItemList.EventUpdate then
					return
				end

				arg_73_1 = arg_73_1 + 1

				local var_73_0 = var_72_0[arg_73_1]

				setActive(arg_73_2:Find("Selected"), var_72_0[arg_73_1]:GetConfigID() == self.animID)
				setActive(arg_73_2:Find("Slider"), var_73_0:GetConfigID() == self.animID and tobool(self.timerAnim))

				return
			end)

			return
		end)

		return
	end

	local function var_69_6(arg_74_0, arg_74_1)
		if self.animPlaying then
			return
		end

		local var_74_0 = arg_74_0:GetConfigID()

		if self.animID == var_74_0 then
			return
		end

		local var_74_1 = self:GetAnimPlayList(var_74_0)
		local var_74_2 = Dorm3dCameraAnim.New({
			configId = self.animID
		}):GetFinishAnimID()

		self.animID = var_74_0

		var_69_5()
		self:BlockActionPanel(true)

		self.animPlaying = true

		local var_74_3 = (table.indexof(var_74_1, _.detect(var_74_1, function(arg_75_0)
			return arg_75_0:GetConfigID() == var_74_2
		end)) or 0) + 1
		local var_74_4 = _.rest(var_74_1, var_74_3)
		local var_74_5 = arg_74_1:Find("Slider"):GetComponent(typeof(Slider))

		setActive(arg_74_1:Find("Slider"), true)

		local function var_74_6()
			setActive(arg_74_1:Find("Selected"), true)
			setActive(arg_74_1:Find("Slider"), false)
			self:BlockActionPanel(false)

			self.animPlaying = nil

			return
		end

		if #var_74_4 == 0 then
			var_74_6()

			return
		end

		local function var_74_7(arg_77_0, arg_77_1, arg_77_2)
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayEnterSceneAnim", arg_77_0:GetEnterSceneAnim(), arg_77_2 ~= arg_77_1, self.animSpeed)
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayEnterExtraItem", arg_77_0:GetEnterExtraItem(), self.animSpeed)
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideSceneItem", arg_77_0:GetHideSceneItem())

			self.cacheSceneAnim = arg_77_0:GetEnterSceneAnim()
			self.cacheExtraItem = arg_77_0:GetEnterExtraItem()

			return
		end

		local var_74_8 = _.reduce(var_74_4, 0, function(arg_78_0, arg_78_1)
			return arg_78_0 + math.max(var_0_2, arg_78_1:GetAnimTime())
		end)

		if self.timerAnim then
			self.timerAnim:Stop()
		end

		self.animInfo = {
			index = 1,
			passedTime = 0,
			ratio = 0,
			animPlayList = var_74_4,
			totalTime = var_74_8,
			startStamp = Time.time
		}
		self.timerAnim = FrameTimer.New(function()
			local var_79_0 = self.animInfo.animPlayList[self.animInfo.index]
			local var_79_1 = math.max(var_0_2, var_79_0:GetAnimTime())
			local var_79_2 = math.min(1, self.animInfo.ratio + (Time.time - self.animInfo.startStamp) * self.animSpeed / var_79_1)

			var_74_5.value = (self.animInfo.passedTime + var_79_1 * var_79_2) / var_74_8

			if var_79_2 < 1 then
				return
			end

			self.animInfo.index = self.animInfo.index + 1
			self.animInfo.ratio = 0
			self.animInfo.passedTime = self.animInfo.passedTime + var_79_1
			self.animInfo.startStamp = Time.time

			local var_79_3 = var_79_0:GetStartPoint()

			if #var_79_3 > 0 then
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_79_3)
			end

			if self.animInfo.index > #self.animInfo.animPlayList then
				var_74_6()
				self.timerAnim:Stop()

				self.timerAnim = nil
				self.animInfo = nil

				return
			end

			local var_79_4 = self.animInfo.animPlayList[self.animInfo.index]

			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", self.animInfo.animPlayList[self.animInfo.index]:GetStateName(), nil, 0)
			var_74_7(var_79_4, var_74_0, var_74_2)

			return
		end, 1, -1)

		local var_74_9 = self.animInfo.animPlayList[1]

		if var_74_3 == 1 then
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SwitchCurrentAnim", self.animInfo.animPlayList[1]:GetStateName())
			onNextTick(function()
				local var_80_0 = var_74_9:GetStartPoint()

				if #var_80_0 == 0 then
					var_80_0 = var_69_0:GetWatchCameraName()
				end

				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_80_0)
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SyncCurrentInterestTransform")
				var_74_7(var_74_9, var_74_0, var_74_2)

				if self.freeMode then
					local var_80_1 = self.scene.cameras[self.scene.CAMERA.PHOTO_FREE]:GetComponent(typeof(UnityEngine.CharacterController))

					self.scene.cameras[self.scene.CAMERA.PHOTO_FREE].transform.forward.y = 0

					self.scene.cameras[self.scene.CAMERA.PHOTO_FREE].transform.forward:Normalize()
					var_80_1:Move(self.scene.cameras[self.scene.CAMERA.PHOTO_FREE].transform.forward * -0.01)
					var_80_1:Move(-(self.scene.cameras[self.scene.CAMERA.PHOTO_FREE].transform.forward * -0.01))
				end

				return
			end)
		else
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", self.animInfo.animPlayList[1]:GetStateName(), nil, 0)
			var_74_7(self.animInfo.animPlayList[1], var_74_0, var_74_2)
		end

		self.timerAnim:Start()

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
		onButton(self, arg_81_2, function()
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

			local var_84_0 = var_69_3[arg_84_1].anims
			local var_84_1 = arg_84_2:Find("Actions")

			UIItemList.StaticAlign(var_84_1, var_84_1:GetChild(0), #var_69_3[arg_84_1].anims, function(arg_85_0, arg_85_1, arg_85_2)
				if arg_85_0 ~= UIItemList.EventUpdate then
					return
				end

				arg_85_1 = arg_85_1 + 1

				local var_85_0 = var_84_0[arg_85_1]

				setActive(arg_85_2:Find("Selected"), var_84_0[arg_85_1]:GetConfigID() == self.animID)
				setActive(arg_85_2:Find("Slider"), var_85_0:GetConfigID() == self.animID and tobool(self.timerAnim))

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

			setActive(arg_87_2:Find("Button/Active"), self.settingSpecialFurnitureIndex == arg_87_1)
			setActive(arg_87_2:Find("Actions"), self.settingSpecialFurnitureIndex == arg_87_1)

			return
		end)
		var_69_7()

		return
	end

	local function var_69_9(arg_88_0, arg_88_1)
		local var_88_0 = arg_88_1:Find("Actions")
		local var_88_1 = arg_88_0.anims

		UIItemList.StaticAlign(var_88_0, var_88_0:GetChild(0), #arg_88_0.anims, function(arg_89_0, arg_89_1, arg_89_2)
			if arg_89_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_89_1 = arg_89_1 + 1

			local var_89_0 = var_88_1[arg_89_1]
			local var_89_1 = var_69_0:CheckFurnitureIdInZone(arg_88_0.furnitureId)
			local var_89_2 = var_89_1 and self.room:IsFurnitureSetIn(arg_88_0.furnitureId)

			SetActive(arg_89_2:Find("Other"), not (var_89_1 and self.room:IsFurnitureSetIn(arg_88_0.furnitureId)))
			SetActive(arg_89_2:Find("Name"), var_89_2)

			if var_89_2 then
				onButton(self, arg_89_2, function()
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
		local var_91_2 = tobool(_.detect(self.room:GetFurnitures(), function(arg_92_0)
			return arg_92_0:GetConfigID() == var_91_0.furnitureId
		end))

		setText(arg_91_2:Find("Button/Name"), var_91_1:GetName())
		GetImageSpriteFromAtlasAsync(var_91_1:GetIcon(), "", arg_91_2:Find("Button/Icon"))
		setActive(arg_91_2:Find("Button/Lock"), not var_91_2)
		setActive(arg_91_2:Find("Button/BG"), var_91_2)
		setImageColor(arg_91_2:Find("Button/BG"), var_69_0:CheckFurnitureIdInZone(var_91_0.furnitureId) and Color.New(1, 1, 1, 0.8509803921568627) or Color.New(0.788235294117647, 0.788235294117647, 0.788235294117647, 0.8509803921568627))
		onButton(self, arg_91_2:Find("Button"), function()
			if not var_91_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_furniture_locked"))

				return
			end

			if self.settingSpecialFurnitureIndex == arg_91_1 then
				self.settingSpecialFurnitureIndex = nil
			else
				self.settingSpecialFurnitureIndex = arg_91_1
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

function Dorm3dPhotoLayer:BlockActionPanel(arg_94_1)
	return
end

function Dorm3dPhotoLayer:GetAnimPlayList(arg_95_1)
	local var_95_0 = arg_95_1
	local var_95_1 = {}
	local var_95_2 = 100

	while true do
		local var_95_3 = Dorm3dCameraAnim.New({
			configId = var_95_0
		})

		if not var_95_3 then
			return var_95_1
		end

		table.insert(var_95_1, 1, var_95_3)

		var_95_0 = var_95_3:GetPreAnimID()

		if var_95_0 == 0 then
			return var_95_1
		end

		var_95_2 = var_95_2 - 1

		assert(var_95_2 > 0)
	end

	return
end

function Dorm3dPhotoLayer:UpdateCameraPanel()
	if not self.activeSetting then
		return
	end

	if self.activePanel ~= Dorm3dPhotoLayer.PANEL.CAMERA then
		return
	end

	;(function()
		local var_97_0 = self.panelCamera:Find("Layout/DepthOfField/Switch/Toggle")

		triggerToggle(var_97_0, self.cameraSettings.depthOfField.enabled)
		onToggle(self, var_97_0, function(arg_98_0)
			self.cameraSettings.depthOfField.enabled = arg_98_0

			setActive(self.panelCamera:Find("Layout/DepthOfField/DepthOfField"), self.cameraSettings.depthOfField.enabled)
			self:RefreshCamera()

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()
	setActive(self.panelCamera:Find("Layout/DepthOfField/DepthOfField"), self.cameraSettings.depthOfField.enabled)
	;(function()
		local var_99_0 = self.cameraSettings.depthOfField.focusDistance
		local var_99_1 = self.panelCamera:Find("Layout/DepthOfField/DepthOfField/FocusDistance/Slider")

		setSlider(var_99_1, self.cameraSettings.depthOfField.focusDistance.min, self.cameraSettings.depthOfField.focusDistance.max, self.cameraSettings.depthOfField.focusDistance.value)
		onSlider(self, var_99_1, function(arg_100_0)
			var_99_0.value = arg_100_0

			self:RefreshCamera()

			return
		end)

		return
	end)()
	;(function()
		local var_101_0 = self.cameraSettings.depthOfField.blurRadius
		local var_101_1 = self.panelCamera:Find("Layout/DepthOfField/DepthOfField/BlurRadius/Slider")

		setSlider(var_101_1, self.cameraSettings.depthOfField.blurRadius.min, self.cameraSettings.depthOfField.blurRadius.max, self.cameraSettings.depthOfField.blurRadius.value)
		onSlider(self, var_101_1, function(arg_102_0)
			var_101_0.value = arg_102_0

			self:RefreshCamera()

			return
		end)

		return
	end)()

	local var_96_0 = {
		"PostExposure",
		"Saturation",
		"Contrast"
	}

	self.paramIndex = self.paramIndex or 1

	local function var_96_1()
		table.Ipairs(var_96_0, function(arg_104_0, arg_104_1)
			setActive(self.panelCamera:Find("Layout/Paramaters/Icons"):GetChild(arg_104_0 - 1):Find("Selected"), arg_104_0 == self.paramIndex)
			setActive(self.panelCamera:Find("Layout/Paramaters/" .. arg_104_1), arg_104_0 == self.paramIndex)

			return
		end)

		return
	end

	table.Ipairs(var_96_0, function(arg_105_0, arg_105_1)
		onButton(self, self.panelCamera:Find("Layout/Paramaters/Icons"):GetChild(arg_105_0 - 1), function()
			self.paramIndex = arg_105_0

			var_96_1()

			return
		end, SFX_PANEL)

		return
	end)
	var_96_1()
	;(function()
		local var_107_0 = self.cameraSettings.postExposure
		local var_107_1 = self.panelCamera:Find("Layout/Paramaters/PostExposure/PostExposure/Slider")
		local var_107_2 = var_107_1:Find("Background/Fill")

		onSlider(self, var_107_1, function(arg_108_0)
			var_107_0.value = arg_108_0
			var_107_2.anchorMin = Vector2.New(math.min((arg_108_0 - var_107_0.min) / (var_107_0.max - var_107_0.min), 0.5), 0)
			var_107_2.anchorMax = Vector2.New(math.max((arg_108_0 - var_107_0.min) / (var_107_0.max - var_107_0.min), 0.5), 1)
			var_107_2.offsetMin = Vector2.zero
			var_107_2.offsetMax = Vector2.zero

			self:RefreshCamera()

			return
		end)
		setSlider(var_107_1, self.cameraSettings.postExposure.min, self.cameraSettings.postExposure.max, self.cameraSettings.postExposure.value)

		return
	end)()
	;(function()
		local var_109_0 = self.cameraSettings.contrast
		local var_109_1 = self.panelCamera:Find("Layout/Paramaters/Contrast/Contrast/Slider")
		local var_109_2 = var_109_1:Find("Background/Fill")

		onSlider(self, var_109_1, function(arg_110_0)
			var_109_0.value = arg_110_0
			var_109_2.anchorMin = Vector2.New(math.min((arg_110_0 - var_109_0.min) / (var_109_0.max - var_109_0.min), 0.5), 0)
			var_109_2.anchorMax = Vector2.New(math.max((arg_110_0 - var_109_0.min) / (var_109_0.max - var_109_0.min), 0.5), 1)
			var_109_2.offsetMin = Vector2.zero
			var_109_2.offsetMax = Vector2.zero

			self:RefreshCamera()

			return
		end)
		setSlider(var_109_1, self.cameraSettings.contrast.min, self.cameraSettings.contrast.max, self.cameraSettings.contrast.value)

		return
	end)()
	;(function()
		local var_111_0 = self.cameraSettings.saturate
		local var_111_1 = self.panelCamera:Find("Layout/Paramaters/Saturation/Saturation/Slider")
		local var_111_2 = var_111_1:Find("Background/Fill")

		onSlider(self, var_111_1, function(arg_112_0)
			var_111_0.value = arg_112_0
			var_111_2.anchorMin = Vector2.New(math.min((arg_112_0 - var_111_0.min) / (var_111_0.max - var_111_0.min), 0.5), 0)
			var_111_2.anchorMax = Vector2.New(math.max((arg_112_0 - var_111_0.min) / (var_111_0.max - var_111_0.min), 0.5), 1)
			var_111_2.offsetMin = Vector2.zero
			var_111_2.offsetMax = Vector2.zero

			self:RefreshCamera()

			return
		end)
		setSlider(var_111_1, self.cameraSettings.saturate.min, self.cameraSettings.saturate.max, self.cameraSettings.saturate.value)

		return
	end)()
	;(function()
		local var_113_0 = self.panelCamera:Find("Layout/Other/FaceCamera/Toggle")

		triggerToggle(var_113_0, self.settingFaceCamera)
		onToggle(self, var_113_0, function(arg_114_0)
			self.settingFaceCamera = arg_114_0

			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnableCurrentHeadIK", arg_114_0)

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()
	;(function()
		local var_115_0 = self.panelCamera:Find("Layout/Other/HideCharacter/Toggle")

		triggerToggle(var_115_0, self.settingHideCharacter)
		onToggle(self, var_115_0, function(arg_116_0)
			self.settingHideCharacter = arg_116_0

			if arg_116_0 then
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideCharacterBylayer")
			else
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
			end

			return
		end, SFX_UI_TAG, SFX_UI_CANCEL)

		return
	end)()

	return
end

function Dorm3dPhotoLayer:RefreshCamera()
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SettingCamera", self.cameraSettings)

	return
end

function Dorm3dPhotoLayer:SetAllAnimSpeed(arg_118_1)
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetCharacterAnimSpeed", arg_118_1)
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetSceneAnimSpeed", self.cacheSceneAnim, arg_118_1)
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetExtraAnimSpeed", self.cacheExtraItem, arg_118_1)

	return
end

function Dorm3dPhotoLayer:UpdateAnimSpeedPanel()
	local function var_119_0()
		if not self.timerAnim then
			return
		end

		local var_120_0 = self.animInfo

		var_120_0.ratio = math.min(1, self.animInfo.ratio + (Time.time - self.animInfo.startStamp) * self.animSpeed / math.max(var_0_2, self.animInfo.animPlayList[self.animInfo.index]:GetAnimTime()))
		var_120_0.startStamp = Time.time

		return
	end

	local var_119_1 = self.animSpeeds

	UIItemList.StaticAlign(self.listAnimSpeed, self.listAnimSpeed:GetChild(0), #self.animSpeeds, function(arg_121_0, arg_121_1, arg_121_2)
		if arg_121_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_121_1 = #var_119_1 - arg_121_1

		local var_121_0 = var_119_1[arg_121_1]

		setText(arg_121_2:Find("Name"), var_119_1[arg_121_1])
		setText(arg_121_2:Find("Selected"), var_119_1[arg_121_1])
		setActive(arg_121_2:Find("Line"), arg_121_1 ~= #var_119_1)
		onButton(self, arg_121_2, function()
			if self.animSpeed == var_121_0 then
				return
			end

			var_119_0()

			self.animSpeed = var_121_0

			self:SetAllAnimSpeed(var_121_0)
			self:UpdateAnimSpeedPanel()

			return
		end, SFX_PANEL)

		return
	end)
	onButton(self, self.btnFreeze, function()
		local var_123_0 = 0

		if self.animSpeed ~= 0 then
			self.lastAnimSpeed = self.animSpeed
		else
			var_123_0 = self.lastAnimSpeed or 1
			self.lastAnimSpeed = nil
		end

		var_119_0()

		self.animSpeed = var_123_0

		self:SetAllAnimSpeed(var_123_0)
		self:UpdateAnimSpeedPanel()

		return
	end, SFX_PANEL)
	UIItemList.StaticAlign(self.listAnimSpeed, self.listAnimSpeed:GetChild(0), #self.animSpeeds, function(arg_124_0, arg_124_1, arg_124_2)
		if arg_124_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_124_1 = #var_119_1 - arg_124_1

		local var_124_0 = var_119_1[arg_124_1]

		setActive(arg_124_2:Find("Name"), self.animSpeed ~= var_119_1[arg_124_1])
		setActive(arg_124_2:Find("Selected"), self.animSpeed == var_124_0)

		return
	end)
	setActive(self.btnFreeze:Find("Icon"), self.animSpeed ~= 0)
	setActive(self.btnFreeze:Find("Selected"), self.animSpeed == 0)
	setText(self.textAnimSpeed, i18n("dorm3d_photo_animspeed", string.format("%.1f", self.animSpeed)))

	return
end

function Dorm3dPhotoLayer:UpdateLightingPanel()
	if not self.activeSetting then
		return
	end

	if self.activePanel ~= Dorm3dPhotoLayer.PANEL.LIGHTING then
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
		if not self.settingFilterIndex then
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertVolumeProfile")

			return
		end

		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SetVolumeProfile", pg.dorm3d_camera_volume_template[var_125_0[self.settingFilterIndex]].volume, self.settingFilterStrength)

		return
	end

	UIItemList.StaticAlign(self.panelLightning:Find("Layout/Filter/List"), self.panelLightning:Find("Layout/Filter/List"):GetChild(0), #var_125_0, function(arg_128_0, arg_128_1, arg_128_2)
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

		if self.settingFilterIndex == arg_128_1 then
			setActive(arg_128_2:Find("Selected"), true)
		else
			setActive(arg_128_2:Find("Selected"), false)
		end

		local var_128_1, var_128_2 = ApartmentProxy.CheckUnlockConfig(var_128_0.unlock)

		setActive(arg_128_2:Find("lock"), not var_128_1)

		if not var_128_1 then
			setText(arg_128_2:Find("lock/Image/Text"), var_128_0.unlock_text)
		end

		onButton(self, arg_128_2, function()
			if not var_128_1 then
				pg.TipsMgr.GetInstance():ShowTips(var_128_2)

				return
			end

			local var_129_0 = self.settingFilterIndex

			self.settingFilterIndex = self.settingFilterIndex ~= arg_128_1 and arg_128_1 or nil

			var_125_1()

			if var_129_0 then
				setActive(self.panelLightning:Find("Layout/Filter/List"):GetChild(var_129_0 - 1):Find("Selected"), false)
			end

			if self.settingFilterIndex == arg_128_1 then
				setActive(arg_128_2:Find("Selected"), true)
			end

			return
		end, SFX_PANEL)

		return
	end)
	setActive(self.panelLightning:Find("Layout/Filter/Slider"), false)

	return
end

function Dorm3dPhotoLayer:OnSwitchSkin(arg_130_1, arg_130_2, arg_130_3)
	seriesAsync({
		function(arg_131_0)
			if self.settingHideCharacter then
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
			end

			arg_130_1:SwitchCharacterSkin(arg_130_2, arg_130_3, arg_131_0)

			return
		end,
		function(arg_132_0)
			setActive(arg_130_1.ladySafeCollider, true)

			if not self.animInfo then
				return arg_132_0()
			end

			local var_132_0 = self.animInfo

			for iter_132_0 = #self.animInfo.animPlayList, 1, -1 do
				local var_132_1 = var_132_0.animPlayList[iter_132_0]:GetStartPoint()

				if #var_132_1 > 0 then
					self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", var_132_1)

					break
				end

				if iter_132_0 == 1 then
					self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCurrentCharPoint", self.room:GetCameraZones()[self.zoneIndex]:GetWatchCameraName())
				end
			end

			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "SyncCurrentInterestTransform")
			self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "PlayCurrentSingleAction", var_132_0.animPlayList[#var_132_0.animPlayList]:GetStateName())
			self.scene.ladyDict[arg_130_2].ladyAnimator:Update((var_132_0.animPlayList[#var_132_0.animPlayList]:GetAnimTime()))
			self.timerAnim:Stop()

			self.timerAnim = nil
			self.animInfo = nil
			self.animPlaying = nil

			arg_132_0()

			return
		end,
		function()
			self:UpdateActionPanel()

			if self.settingHideCharacter then
				self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "HideCharacterBylayer")
			end

			return
		end
	})

	return
end

function Dorm3dPhotoLayer:SetMute()
	if self then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

function Dorm3dPhotoLayer:willExit()
	self.loader:Clear()

	if self.timerAnim then
		self.timerAnim:Stop()

		self.timerAnim = nil
	end

	if self.animSpeed ~= 1 then
		self:SetAllAnimSpeed(1)
	end

	if self.settingHideCharacter then
		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterBylayer")
	end

	if not self.settingFaceCamera then
		self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "EnableCurrentHeadIK", true)
	end

	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetSceneItemAnimators")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetCharacterExtraItem")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ResetTempHideSceneItems")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCharacterLight")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertVolumeProfile")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "RevertCameraSettings")
	self.scene:emit(Dorm3dRoomTemplateScene.PHOTO_CALL, "ExitPhotoMode")

	return
end

function Dorm3dPhotoLayer:SetPhotoCameraSliderValue(arg_136_1)
	setSlider(self.normalPanel:Find("Zoom/Slider"), 0, 1, arg_136_1)

	return
end

function Dorm3dPhotoLayer:SetPhotoStickDelta(arg_137_1)
	arg_137_1 = arg_137_1 * 0.5

	local var_137_0 = self._tf:Find("Center/Stick")

	setAnchoredPosition(var_137_0:Find("Handler"), Vector2.New(var_137_0.rect.height * arg_137_1.x, var_137_0.rect.width * arg_137_1.y))

	return
end

return Dorm3dPhotoLayer
