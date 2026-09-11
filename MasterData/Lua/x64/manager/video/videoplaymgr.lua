local VideoPlayMgr = class("VideoPlayMgr", import("game.extend.ReduxView"))

function VideoPlayMgr:Ctor()
	return
end

function VideoPlayMgr:InitUI()
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/Stage/VideoPlayUI"), manager.ui.uiStory.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.criManaMovieController_ = self.goMovie_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criManaMovieController_.player
	self.criplayer_.statusChangeCallback = handler(self, self.StatusChangeCallback)

	self:SetUIBtnActive(true)

	self.soundStateController_ = self.soundControllerEx_:GetController("sound")
	self.showSoundSettingController_ = self.controllerEx_:GetController("showSoundSetting")
	self.showSoundFlag_ = false
end

function VideoPlayMgr:SetUIBtnActive(arg_3_1)
	SetActive(self.buttonSkip_.gameObject, arg_3_1)
	SetActive(self.text_.gameObject, arg_3_1)
end

function VideoPlayMgr:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		if self.showSoundFlag_ then
			self.showSoundFlag_ = false

			self:RefreshSoundPanel()

			return
		end
	end)
	self:AddBtnListener(self.buttonSkip_, nil, function()
		if Time.realtimeSinceStartup == self.lastTime then
			return
		end

		self.lastTime = Time.realtimeSinceStartup

		self.criManaMovieController_:Pause(true)

		if self.onPauseCallback then
			self.onPauseCallback(true)
		end

		self:RemoveCaptionTimer()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function()
				if not isNil(self.criManaMovieController_) then
					self.criManaMovieController_:Pause(false)
					self.criManaMovieController_:Stop()
				end

				if self.onFinishCallback_ then
					self.onFinishCallback_(StoryOperDefine.PASS)
				end
			end,
			CancelCallback = function()
				if not isNil(self.criManaMovieController_) then
					self.criManaMovieController_:Pause(false)
				end

				if self.onPauseCallback then
					self.onPauseCallback(false)
				end

				self:StartCaptionTimer()
			end,
			MaskCallback = function()
				if not isNil(self.criManaMovieController_) then
					self.criManaMovieController_:Pause(false)
				end

				if self.onPauseCallback then
					self.onPauseCallback(false)
				end

				self:StartCaptionTimer()
			end
		})
	end)
	self:AddBtnListener(self.soundBtn_, nil, function()
		self.showSoundFlag_ = not self.showSoundFlag_

		self:RefreshSoundPanel()
	end)
	self:AddToggleListener(self.slider_, function(arg_11_0)
		self:SetSoundValue(arg_11_0)
	end)
	self:AddPressingByTimeListener(self.subtractBtn_.gameObject, 3, 0.2, 0.2, function()
		if self.subtractBtn_.interactable and self.slider_.value > 0 then
			self:SetSoundValue(self.slider_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.2, 0.2, function()
		if self.addBtn_.interactable and self.slider_.value < 100 then
			self:SetSoundValue(self.slider_.value + 1)

			return true
		end

		return false
	end)
end

function VideoPlayMgr:SetPlayer()
	return
end

function VideoPlayMgr:Play(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	arg_15_1 = manager.video:GetI18NVideoPath(arg_15_1)

	if self.gameObject_ == nil then
		self:InitUI()
		self:AddListeners()
	end

	self.startStop_ = false
	self.autoHide_ = arg_15_3 == nil and true or arg_15_3

	SetActive(self.goSkip_, true)

	self.musicVolume_ = manager.audio:GetMusicVolume() * 100

	self:RefreshSoundUI()
	self:SetAudioTrack(self.criplayer_, arg_15_1)

	if arg_15_4 == nil then
		self.criplayer_:Loop(false)
	else
		self.criplayer_:Loop(arg_15_4)
	end

	SetFile(self.criplayer_, nil, arg_15_1, arg_15_7)

	self.onFinishCallback_ = arg_15_2
	self.onPauseCallback = arg_15_5
	self.videoId = arg_15_6

	SetActive(self.gameObject_, true)

	if not isNil(self.criManaMovieController_) then
		self.criManaMovieController_:Play()
	end

	self:CaptionPlay()
	manager.windowBar:HideBar()
	self:AdaptScreen()
end

function VideoPlayMgr:CaptionPlay()
	self.time = 0
	self.lastTime = 0
	self.currentPlayId = 1

	self:StartCaptionTimer()
end

function VideoPlayMgr:StartCaptionTimer()
	if self.videoId == nil or self.videoId == 0 then
		self.text_.text = ""

		return
	end

	local var_17_0 = SettingData:GetCurrentLanguage()
	local var_17_1 = import("game.subtitle.subtitle" .. self.videoId)

	if var_17_1 == nil then
		self:RemoveCaptionTimer()

		return
	else
		var_17_1 = var_17_1[var_17_0]
	end

	table.sort(var_17_1, function(arg_18_0, arg_18_1)
		return arg_18_0.start < arg_18_1.start
	end)

	self.captionTimer = self.captionTimer or FuncTimerManager.inst:CreateFuncFrameTimer(function()
		self.text_.text = ""
		self.time = self.time + Time.deltaTime

		if self.lastTime + 3 < self.time then
			self.time = tonumber(tostring(self.criplayer_:GetTime()) / 1000000)
			self.lastTime = self.time
		end

		local var_19_0 = var_17_1[self.currentPlayId]

		if var_17_1[self.currentPlayId] == nil then
			self:RemoveCaptionTimer()

			return
		end

		if self.time < var_19_0.endTime and self.time > var_19_0.start then
			self.text_.text = GetI18NText(var_19_0.content)
		elseif self.time > var_19_0.endTime then
			self.currentPlayId = self.currentPlayId + 1
		end
	end, -1, true)
end

function VideoPlayMgr:PauseCaptionTimer()
	if self.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(self.captionTimer)

		self.captionTimer = nil
	end
end

function VideoPlayMgr:RemoveCaptionTimer()
	if self.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(self.captionTimer)

		self.captionTimer = nil
	end
end

function VideoPlayMgr:Dispose()
	VideoPlayMgr.super.Dispose(self)

	if self.gameObject_ then
		self.criplayer_.statusChangeCallback = nil

		self:RemoveCaptionTimer()
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
		self.onFinishCallback_ = nil
		self.onPauseCallback = nil
	end
end

function VideoPlayMgr:StatusChangeCallback(arg_23_1)
	local var_23_0 = tostring(arg_23_1)

	if var_23_0 == "PlayEnd" then
		if not isNil(self.criManaMovieController_) then
			self.criManaMovieController_:Stop()
		end

		self:RemoveCaptionTimer()

		if self.onFinishCallback_ then
			self.onFinishCallback_(StoryOperDefine.NORMAL)
		end
	elseif var_23_0 == "StopProcessing" then
		self.startStop_ = true

		return
	elseif var_23_0 == "Stop" and self.startStop_ and self.autoHide_ then
		SetActive(self.gameObject_, false)
	end

	self.startStop_ = false
end

function VideoPlayMgr:HidePlayer()
	if self.startStop_ then
		self.autoHide_ = true

		return
	end

	if self.gameObject_ then
		SetActive(self.gameObject_, false)
	end

	self.autoHide_ = true
end

function VideoPlayMgr:SetSoundValue(arg_25_1)
	self.musicVolume_ = arg_25_1

	self:RefreshSoundUI()
end

function VideoPlayMgr:RefreshSoundUI()
	self.criplayer_:SetVolume(self.musicVolume_ / 100)
	self:RefreshSoundState()

	self.slider_.value = self.musicVolume_
	self.soundText_.text = string.format("%d%%", self.musicVolume_)
end

function VideoPlayMgr:RefreshSoundPanel()
	if self.showSoundFlag_ then
		self.showSoundSettingController_:SetSelectedState("true")
	else
		self.showSoundSettingController_:SetSelectedState("false")
	end
end

function VideoPlayMgr:RefreshSoundState()
	if self.musicVolume_ <= 0 then
		self.soundStateController_:SetSelectedState("off")
	else
		self.soundStateController_:SetSelectedState("on")
	end
end

function VideoPlayMgr:SetAudioTrack(arg_29_1, arg_29_2)
	local var_29_0 = self:GetVedioTrackIndex(arg_29_2)

	arg_29_1:SetAudioTrack(var_29_0)
	arg_29_1:SetSubtitleChannel(var_29_0)
end

function VideoPlayMgr:GetVedioTrackIndex(arg_30_1)
	local var_30_0 = 0
	local var_30_1 = manager.audio:GetLocalizationFlag()
	local var_30_2 = VideoTrackCfg[self:GetVedioFileName(arg_30_1)]

	if var_30_2 and var_30_2.has_tracks == 1 then
		if var_30_1 == "zh" then
			var_30_0 = 0
		elseif var_30_1 == "ja" then
			var_30_0 = 1
		elseif var_30_1 == "en" then
			var_30_0 = 2
		elseif var_30_1 == "ko" then
			var_30_0 = 3
		end
	end

	return var_30_0
end

function VideoPlayMgr:GetVedioFileName(arg_31_1)
	local var_31_0 = arg_31_1

	for iter_31_0 in string.gmatch(arg_31_1, "[^/]+$") do
		var_31_0 = iter_31_0
	end

	return var_31_0
end

local var_0_1 = {
	"en",
	"ja",
	"ko",
	"tw"
}

function VideoPlayMgr:GetI18NVideoPath(arg_32_1)
	local var_32_0 = self:GetVedioFileName(arg_32_1)

	if not VideoTrackCfg[var_32_0] or type(VideoTrackCfg[var_32_0].i18n_video_list) ~= "table" or #VideoTrackCfg[var_32_0].i18n_video_list == 0 then
		return arg_32_1
	end

	local var_32_1 = VideoTrackCfg[var_32_0].i18n_video_list
	local var_32_2 = string.gsub(arg_32_1, ".usm", "")

	if SDKTools.GetIsEnglish() and table.indexof(var_32_1, 1) then
		var_32_2 = var_32_2 .. "_" .. var_0_1[1]
	elseif SDKTools.GetIsJapan() and table.indexof(var_32_1, 2) then
		var_32_2 = var_32_2 .. "_" .. var_0_1[2]
	elseif SDKTools.GetIsKorea() and table.indexof(var_32_1, 3) then
		var_32_2 = var_32_2 .. "_" .. var_0_1[3]
	elseif SDKTools.GetIsTw() and table.indexof(var_32_1, 4) then
		var_32_2 = var_32_2 .. "_" .. var_0_1[4]
	end

	return var_32_2 .. ".usm"
end

return VideoPlayMgr
