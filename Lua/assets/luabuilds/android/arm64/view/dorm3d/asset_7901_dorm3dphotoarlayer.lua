local Dorm3dPhotoARLayer = class("Dorm3dPhotoARLayer", import("view.base.BaseUI"))

function Dorm3dPhotoARLayer:getUIName()
	return "Dorm3dARPhotoUI"
end

Dorm3dPhotoARLayer.PANEL = {
	ACTION = 1,
	LIGHTING = 3,
	CAMERA = 2
}

function Dorm3dPhotoARLayer:init()
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
	self.btnZone = self._tf:Find("Center/Zone")
	self.btnAr = self._tf:Find("Center/Ar")
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
	setText(self.panelLightning:Find("Layout/Title/Lighting/Name"), i18n("dorm3d_photo_lighting"))
	setText(self.panelLightning:Find("Layout/Title/Lighting/Selected"), i18n("dorm3d_photo_lighting"))
	setText(self.panelLightning:Find("Layout/Title/Filter/Name"), i18n("dorm3d_photo_filter"))
	setText(self.panelLightning:Find("Layout/Title/Filter/Selected"), i18n("dorm3d_photo_filter"))
	setText(self.panelLightning:Find("Layout/Lighting/Strength/Name"), i18n("dorm3d_photo_strength"))
	setText(self.panelAction:Find("Layout/Title/Regular/Name"), i18n("dorm3d_photo_regular_anim"))
	setText(self.panelAction:Find("Layout/Title/Regular/Selected"), i18n("dorm3d_photo_regular_anim"))
	setText(self.panelAction:Find("Layout/Title/Special/Name"), i18n("dorm3d_photo_special_anim"))
	setText(self.panelAction:Find("Layout/Title/Special/Selected"), i18n("dorm3d_photo_special_anim"))

	self.stopRecBtn = self._tf:Find("stopRec")
	self.videoTipPanel = self._tf:Find("videoTipPanel")

	setActive(self.videoTipPanel, false)

	return
end

function Dorm3dPhotoARLayer:SetSceneRoot(arg_3_1)
	self.scene = arg_3_1

	return
end

function Dorm3dPhotoARLayer:SetRoom(arg_4_1)
	self.room = getProxy(ApartmentProxy):getRoom(arg_4_1)

	return
end

function Dorm3dPhotoARLayer:SetGroupId(arg_5_1)
	self.groupId = arg_5_1

	return
end

function Dorm3dPhotoARLayer:SetARLite(arg_6_1)
	self.ARState = arg_6_1
	self.ARCheck = table.contains({
		5,
		6,
		7
	}, arg_6_1)

	if GraphApiHelper.IsUsingVulkan() then
		self.ARCheck = false
	end

	self.mainCamera = self.ARCheck and GameObject.Find("AR/XR Origin/Camera Offset/Main Camera"):GetComponent(typeof(Camera)) or GameObject.Find("FakeAR/Main Camera"):GetComponent(typeof(Camera))

	return
end

function Dorm3dPhotoARLayer:onBackPressed()
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

function Dorm3dPhotoARLayer:didEnter()
	setActive(self._tf:Find("Center/Normal/Back"), false)
	onButton(self, self._tf:Find("Center/Normal/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_8_0 = self.normalPanel:Find("Zoom/Slider")

	setSlider(var_8_0, 0, 1, 0)
	onSlider(self, var_8_0, function(arg_10_0)
		self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "SetPinchValue", (1 - arg_10_0) * 0.5 + 0.5)

		return
	end)

	self.activeSetting = false

	onButton(self, self._tf:Find("Center/Normal/Settings"), function()
		self.activeSetting = true

		quickPlayAnimation(self._tf:Find("Center"), "anim_dorm3d_photo_normal_out")
		self:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, false)
		self:UpdateActionPanel()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Center/Settings/Back"), function()
		self.activeSetting = false

		quickPlayAnimation(self._tf:Find("Center"), "anim_dorm3d_photo_normal_in")
		self:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, true)

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
		self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "ResetPhotoCameraPosition")

		return
	end, SFX_PANEL)
	onButton(self, self.btnFilm, function()
		local function var_16_0(arg_17_0)
			setActive(self.centerPanel, arg_17_0)

			self._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = arg_17_0 and 1 or 0

			self:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, arg_17_0)

			return
		end

		if not self.recordState then
			local function var_16_1(arg_18_0)
				if not arg_18_0 then
					var_16_0(true)

					self.recordState = false

					LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15)
				else
					self.recordState = true
				end

				return
			end

			local function var_16_2()
				setActive(self.stopRecBtn, true)
				LeanTween.moveX(self.stopRecBtn, 0, 0.15):setOnComplete(System.Action(function()
					Dorm3dPhotoARLayer.SetMute(true)

					self.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

					YSNormalTool.RecordTool.StartRecording(var_16_1, self.recordFilePath)

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

						self.videoTipPanel:Find("Text"):GetComponent("Text").text = i18n("word_take_video_tip")

						onButton(self, self.videoTipPanel, function()
							setActive(self.videoTipPanel, false)
							var_16_2()

							return
						end)
						setActive(self.videoTipPanel, true)
					else
						var_16_2()
					end

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.stopRecBtn, function()
		local function var_24_0(arg_25_0)
			if arg_25_0 and PLATFORM == PLATFORM_ANDROID then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("word_save_video"),
					onNo = function()
						if System.IO.File.Exists(self.recordFilePath) then
							System.IO.File.Delete(self.recordFilePath)
						end

						return
					end,
					onYes = function()
						YSNormalTool.MediaTool.SaveVideoToAlbum(self.recordFilePath, function(arg_28_0, arg_28_1)
							if arg_28_0 then
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

		local function var_24_1(arg_29_0)
			setActive(self.centerPanel, arg_29_0)

			self._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = arg_29_0 and 1 or 0

			self:emit(Dorm3dPhotoARMediator.ACTIVE_AR_UI, arg_29_0)

			return
		end

		if not LeanTween.isTweening(go(self.stopRecBtn)) then
			LeanTween.moveX(self.stopRecBtn, self.stopRecBtn.rect.width, 0.15):setOnComplete(System.Action(function()
				setActive(self.stopRecBtn, false)
				seriesAsync({
					function(arg_31_0)
						YSNormalTool.RecordTool.StopRecording(var_24_0)
						var_24_1(true)
						Dorm3dPhotoARLayer.SetMute(false)

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
		local function var_33_1(arg_35_0)
			warning("截图结果：" .. tostring(arg_35_0))

			return
		end

		local function var_33_2(arg_36_0, arg_36_1)
			self:emit(Dorm3dPhotoARMediator.SHARE_PANEL, arg_36_1, arg_36_0)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCamera(self.groupId, 3, self.room:GetConfigID(), Dorm3dCameraAnim.New({
				configId = self.animID
			}):GetStateName()))

			return
		end

		local var_33_3, var_33_4 = Dorm3dHxHelper.GetHolyLightScreenShotInfo(self.contextData.holyLightRoot)

		GraphicsInterface.Instance:TakePhotoWithPost(self.mainCamera, var_33_3, var_33_4, function(arg_37_0)
			var_33_1(true)
			var_33_2(Tex2DExtension.EncodeToJPG(arg_37_0), arg_37_0)

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
		self:emit(Dorm3dPhotoMediator.GO_AR)

		return
	end)

	self.activePanel = 1

	local var_8_1 = {
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
				return
			end,
			Off = function()
				return
			end
		},
		{
			btn = self.btnLighting,
			On = function()
				return
			end,
			Off = function()
				return
			end
		}
	}

	table.Ipairs(var_8_1, function(arg_49_0, arg_49_1)
		onToggle(self, arg_49_1.btn, function(arg_50_0)
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

			self.activePanel = arg_49_0

			arg_49_1.On()

			return
		end, SFX_PANEL)

		return
	end)
	;(function()
		triggerToggle(({
			self.panelAction:Find("Layout/Title/Regular")
		})[1], true)

		return
	end)()
	;(function()
		triggerToggle(({
			self.panelLightning:Find("Layout/Title/Lighting")
		})[1], true)

		return
	end)()
	self:InitData()
	triggerToggle(var_8_1[self.activePanel].btn, true)
	self:emit(Dorm3dPhotoARMediator.AR_PHOTO_INITED)

	return
end

function Dorm3dPhotoARLayer:InitData()
	self:RefreshData()

	return
end

function Dorm3dPhotoARLayer:RefreshData()
	self.animID = self.room:getAllARAnimationListByShip(self.groupId)[1]:GetConfigID()
	self.animSpeed = 1

	return
end

local var_0_1 = 0.2

function Dorm3dPhotoARLayer:UpdateActionPanel()
	if not self.activeSetting then
		return
	end

	if self.activePanel ~= Dorm3dPhotoARLayer.PANEL.ACTION then
		return
	end

	local var_56_0 = self.room:getAllARAnimationListByShip(self.groupId)
	local var_56_1 = self.panelAction:Find("Layout/Regular/Scroll/Viewport/Content")

	local function var_56_2()
		UIItemList.StaticAlign(var_56_1, var_56_1:GetChild(0), #var_56_0, function(arg_58_0, arg_58_1, arg_58_2)
			if arg_58_0 ~= UIItemList.EventUpdate then
				return
			end

			arg_58_1 = arg_58_1 + 1

			local var_58_0 = var_56_0[arg_58_1]

			setActive(arg_58_2:Find("Selected"), var_56_0[arg_58_1]:GetConfigID() == self.animID)
			setActive(arg_58_2:Find("Slider"), var_58_0:GetConfigID() == self.animID and tobool(self.timerAnim))

			return
		end)

		return
	end

	local function var_56_3(arg_59_0, arg_59_1)
		if self.animPlaying then
			return
		end

		local var_59_0 = arg_59_0:GetConfigID()

		if self.animID == var_59_0 then
			return
		end

		local var_59_1 = self:GetAnimPlayList(var_59_0)
		local var_59_2 = Dorm3dCameraAnim.New({
			configId = self.animID
		}):GetFinishAnimID()

		self.animID = var_59_0

		var_56_2()
		self:BlockActionPanel(true)

		self.animPlaying = true

		local var_59_3 = (table.indexof(var_59_1, _.detect(var_59_1, function(arg_60_0)
			return arg_60_0:GetConfigID() == var_59_2
		end)) or 0) + 1
		local var_59_4 = _.rest(var_59_1, var_59_3)
		local var_59_5 = arg_59_1:Find("Slider"):GetComponent(typeof(Slider))

		setActive(arg_59_1:Find("Slider"), true)

		local function var_59_6()
			setActive(arg_59_1:Find("Selected"), true)
			setActive(arg_59_1:Find("Slider"), false)
			self:BlockActionPanel(false)

			self.animPlaying = nil

			return
		end

		if #var_59_4 == 0 then
			var_59_6()

			return
		end

		local var_59_7 = _.reduce(var_59_4, 0, function(arg_62_0, arg_62_1)
			return arg_62_0 + math.max(var_0_1, arg_62_1:GetAnimTime())
		end)

		if self.timerAnim then
			self.timerAnim:Stop()
		end

		self.animInfo = {
			index = 1,
			passedTime = 0,
			ratio = 0,
			animPlayList = var_59_4,
			totalTime = var_59_7,
			startStamp = Time.time
		}
		self.timerAnim = FrameTimer.New(function()
			local var_63_0 = math.max(var_0_1, self.animInfo.animPlayList[self.animInfo.index]:GetAnimTime())
			local var_63_1 = math.min(1, self.animInfo.ratio + (Time.time - self.animInfo.startStamp) * self.animSpeed / var_63_0)

			var_59_5.value = (self.animInfo.passedTime + var_63_0 * var_63_1) / var_59_7

			if var_63_1 < 1 then
				return
			end

			self.animInfo.index = self.animInfo.index + 1
			self.animInfo.ratio = 0
			self.animInfo.passedTime = self.animInfo.passedTime + var_63_0
			self.animInfo.startStamp = Time.time

			warning(self.animInfo.startStamp)

			if self.animInfo.index > #self.animInfo.animPlayList then
				var_59_6()
				self.timerAnim:Stop()

				self.timerAnim = nil
				self.animInfo = nil

				return
			end

			self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "PlaySingleAction", self.animInfo.animPlayList[self.animInfo.index]:GetStateName())

			return
		end, 1, -1)

		if var_59_3 == 1 then
			self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "SwitchAnim", self.animInfo.animPlayList[1]:GetStateName())
			onNextTick(function()
				self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "ResetCharPos")

				return
			end)
		else
			self:emit(Dorm3dPhotoARMediator.SCENE_CALL, "PlaySingleAction", self.animInfo.animPlayList[1]:GetStateName())
		end

		self.timerAnim:Start()

		return
	end

	UIItemList.StaticAlign(var_56_1, var_56_1:GetChild(0), #var_56_0, function(arg_65_0, arg_65_1, arg_65_2)
		if arg_65_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_65_1 = arg_65_1 + 1

		local var_65_0 = var_56_0[arg_65_1]

		setText(arg_65_2:Find("Name"), var_56_0[arg_65_1]:GetName())
		GetImageSpriteFromAtlasAsync(string.format("Dorm3DPhoto/%s", var_56_0[arg_65_1]:GetZoneIcon()), "", arg_65_2:Find("Icon"))
		setActive(arg_65_2:Find("Slider"), false)
		setActive(arg_65_2:Find("Selected"), false)
		onButton(self, arg_65_2, function()
			var_56_3(var_65_0, arg_65_2)

			return
		end)

		return
	end)
	var_56_2()

	return
end

function Dorm3dPhotoARLayer:BlockActionPanel(arg_67_1)
	return
end

function Dorm3dPhotoARLayer:SetPhotoUIActive(arg_68_1)
	setActive(self._tf:Find("RightTop"), arg_68_1)
	setActive(self._tf:Find("Center"), arg_68_1)

	return
end

function Dorm3dPhotoARLayer:GetAnimPlayList(arg_69_1)
	local var_69_0 = arg_69_1
	local var_69_1 = {}

	while true do
		local var_69_2 = Dorm3dCameraAnim.New({
			configId = var_69_0
		})

		if not var_69_2 then
			return var_69_1
		end

		table.insert(var_69_1, 1, var_69_2)

		var_69_0 = var_69_2:GetPreAnimID()

		if var_69_0 == 0 then
			return var_69_1
		end
	end

	return
end

function Dorm3dPhotoARLayer:SetMute()
	if self then
		pg.CriMgr.GetInstance():MuteAllVolume()
	else
		pg.CriMgr.GetInstance():ResetAllVolume()
	end

	return
end

function Dorm3dPhotoARLayer:willExit()
	if self.timerAnim then
		self.timerAnim:Stop()

		self.timerAnim = nil
	end

	if self.filmTimer then
		self.filmTimer:Stop()

		self.filmTimer = nil
	end

	return
end

function Dorm3dPhotoARLayer:SetCamaraPinchSliderValue(arg_72_1)
	setSlider(self.normalPanel:Find("Zoom/Slider"), 0, 1, 1 - (arg_72_1 - 0.5) / 0.5)

	return
end

function Dorm3dPhotoARLayer:ShowPhotoImage(arg_73_1)
	local var_73_0 = arg_73_1 and 1 or 0

	self.normalPanel:GetComponent("CanvasGroup").alpha = arg_73_1 and 1 or 0
	self._tf:Find("RightTop"):GetComponent("CanvasGroup").alpha = var_73_0

	return
end

return Dorm3dPhotoARLayer
