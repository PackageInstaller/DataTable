local var_0_0 = class("VideoPlayMgr", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load("UI/Stage/VideoPlayUI"), manager.ui.uiStory.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()

	arg_2_0.criManaMovieController_ = arg_2_0.goMovie_:GetComponent("CriManaMovieControllerForUI")
	arg_2_0.criplayer_ = arg_2_0.criManaMovieController_.player
	arg_2_0.criplayer_.statusChangeCallback = handler(arg_2_0, arg_2_0.StatusChangeCallback)

	arg_2_0:SetUIBtnActive(true)

	arg_2_0.soundStateController_ = arg_2_0.soundControllerEx_:GetController("sound")
	arg_2_0.showSoundSettingController_ = arg_2_0.controllerEx_:GetController("showSoundSetting")
	arg_2_0.showSoundFlag_ = false
end

function var_0_0.SetUIBtnActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0.buttonSkip_.gameObject, arg_3_1)
	SetActive(arg_3_0.text_.gameObject, arg_3_1)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonClose_, nil, function()
		if arg_4_0.showSoundFlag_ then
			arg_4_0.showSoundFlag_ = false

			arg_4_0:RefreshSoundPanel()

			return
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonSkip_, nil, function()
		if Time.realtimeSinceStartup == arg_4_0.lastTime then
			return
		end

		arg_4_0.lastTime = Time.realtimeSinceStartup

		arg_4_0.criManaMovieController_:Pause(true)

		if arg_4_0.onPauseCallback then
			arg_4_0.onPauseCallback(true)
		end

		arg_4_0:RemoveCaptionTimer()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function()
				if not isNil(arg_4_0.criManaMovieController_) then
					arg_4_0.criManaMovieController_:Pause(false)
					arg_4_0.criManaMovieController_:Stop()
				end

				if arg_4_0.onFinishCallback_ then
					arg_4_0.onFinishCallback_(StoryOperDefine.PASS)
				end
			end,
			CancelCallback = function()
				if not isNil(arg_4_0.criManaMovieController_) then
					arg_4_0.criManaMovieController_:Pause(false)
				end

				if arg_4_0.onPauseCallback then
					arg_4_0.onPauseCallback(false)
				end

				arg_4_0:StartCaptionTimer()
			end,
			MaskCallback = function()
				if not isNil(arg_4_0.criManaMovieController_) then
					arg_4_0.criManaMovieController_:Pause(false)
				end

				if arg_4_0.onPauseCallback then
					arg_4_0.onPauseCallback(false)
				end

				arg_4_0:StartCaptionTimer()
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.soundBtn_, nil, function()
		arg_4_0.showSoundFlag_ = not arg_4_0.showSoundFlag_

		arg_4_0:RefreshSoundPanel()
	end)
	arg_4_0:AddToggleListener(arg_4_0.slider_, function(arg_11_0)
		arg_4_0:SetSoundValue(arg_11_0)
	end)
	arg_4_0:AddPressingByTimeListener(arg_4_0.subtractBtn_.gameObject, 3, 0.2, 0.2, function()
		if arg_4_0.subtractBtn_.interactable and arg_4_0.slider_.value > 0 then
			local var_12_0 = arg_4_0.slider_.value - 1

			arg_4_0:SetSoundValue(var_12_0)

			return true
		end

		return false
	end)
	arg_4_0:AddPressingByTimeListener(arg_4_0.addBtn_.gameObject, 3, 0.2, 0.2, function()
		if arg_4_0.addBtn_.interactable and arg_4_0.slider_.value < 100 then
			local var_13_0 = arg_4_0.slider_.value + 1

			arg_4_0:SetSoundValue(var_13_0)

			return true
		end

		return false
	end)
end

function var_0_0.SetPlayer(arg_14_0)
	return
end

function var_0_0.Play(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	arg_15_1 = manager.video:GetI18NVideoPath(arg_15_1)

	if arg_15_0.gameObject_ == nil then
		arg_15_0:InitUI()
		arg_15_0:AddListeners()
	end

	arg_15_0.startStop_ = false

	if arg_15_3 == nil then
		arg_15_0.autoHide_ = true
	else
		arg_15_0.autoHide_ = arg_15_3
	end

	SetActive(arg_15_0.goSkip_, true)

	arg_15_0.musicVolume_ = manager.audio:GetMusicVolume() * 100

	arg_15_0:RefreshSoundUI()
	arg_15_0:SetAudioTrack(arg_15_0.criplayer_, arg_15_1)

	if arg_15_4 == nil then
		arg_15_0.criplayer_:Loop(false)
	else
		arg_15_0.criplayer_:Loop(arg_15_4)
	end

	SetFile(arg_15_0.criplayer_, nil, arg_15_1, arg_15_7)

	arg_15_0.onFinishCallback_ = arg_15_2
	arg_15_0.onPauseCallback = arg_15_5
	arg_15_0.videoId = arg_15_6

	SetActive(arg_15_0.gameObject_, true)

	if not isNil(arg_15_0.criManaMovieController_) then
		arg_15_0.criManaMovieController_:Play()
	end

	arg_15_0:CaptionPlay()
	manager.windowBar:HideBar()
	arg_15_0:AdaptScreen()
end

function var_0_0.CaptionPlay(arg_16_0)
	arg_16_0.time = 0
	arg_16_0.lastTime = 0
	arg_16_0.currentPlayId = 1

	arg_16_0:StartCaptionTimer()
end

function var_0_0.StartCaptionTimer(arg_17_0)
	if arg_17_0.videoId == nil or arg_17_0.videoId == 0 then
		arg_17_0.text_.text = ""

		return
	end

	local var_17_0 = SettingData:GetCurrentLanguage()
	local var_17_1 = import("game.subtitle.subtitle" .. arg_17_0.videoId)

	if var_17_1 == nil then
		arg_17_0:RemoveCaptionTimer()

		return
	else
		var_17_1 = var_17_1[var_17_0]
	end

	table.sort(var_17_1, function(arg_18_0, arg_18_1)
		return arg_18_0.start < arg_18_1.start
	end)

	if not arg_17_0.captionTimer then
		arg_17_0.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			arg_17_0.text_.text = ""
			arg_17_0.time = arg_17_0.time + Time.deltaTime

			if arg_17_0.lastTime + 3 < arg_17_0.time then
				local var_19_0 = tonumber(tostring(arg_17_0.criplayer_:GetTime()) / 1000000)

				arg_17_0.time = var_19_0
				arg_17_0.lastTime = arg_17_0.time
			end

			local var_19_1 = var_17_1[arg_17_0.currentPlayId]

			if var_19_1 == nil then
				arg_17_0:RemoveCaptionTimer()

				return
			end

			if arg_17_0.time < var_19_1.endTime and arg_17_0.time > var_19_1.start then
				arg_17_0.text_.text = GetI18NText(var_19_1.content)
			elseif arg_17_0.time > var_19_1.endTime then
				arg_17_0.currentPlayId = arg_17_0.currentPlayId + 1
			end
		end, -1, true)
	end
end

function var_0_0.PauseCaptionTimer(arg_20_0)
	if arg_20_0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_20_0.captionTimer)

		arg_20_0.captionTimer = nil
	end
end

function var_0_0.RemoveCaptionTimer(arg_21_0)
	if arg_21_0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_21_0.captionTimer)

		arg_21_0.captionTimer = nil
	end
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)

	if arg_22_0.gameObject_ then
		arg_22_0.criplayer_.statusChangeCallback = nil

		arg_22_0:RemoveCaptionTimer()
		Object.Destroy(arg_22_0.gameObject_)

		arg_22_0.gameObject_ = nil
		arg_22_0.transform_ = nil
		arg_22_0.onFinishCallback_ = nil
		arg_22_0.onPauseCallback = nil
	end
end

function var_0_0.StatusChangeCallback(arg_23_0, arg_23_1)
	local var_23_0 = tostring(arg_23_1)

	if var_23_0 == "PlayEnd" then
		if not isNil(arg_23_0.criManaMovieController_) then
			arg_23_0.criManaMovieController_:Stop()
		end

		arg_23_0:RemoveCaptionTimer()

		if arg_23_0.onFinishCallback_ then
			arg_23_0.onFinishCallback_(StoryOperDefine.NORMAL)
		end
	elseif var_23_0 == "StopProcessing" then
		arg_23_0.startStop_ = true

		return
	elseif var_23_0 == "Stop" and arg_23_0.startStop_ and arg_23_0.autoHide_ then
		SetActive(arg_23_0.gameObject_, false)
	end

	arg_23_0.startStop_ = false
end

function var_0_0.HidePlayer(arg_24_0)
	if arg_24_0.startStop_ then
		arg_24_0.autoHide_ = true

		return
	end

	if arg_24_0.gameObject_ then
		SetActive(arg_24_0.gameObject_, false)
	end

	arg_24_0.autoHide_ = true
end

function var_0_0.SetSoundValue(arg_25_0, arg_25_1)
	arg_25_0.musicVolume_ = arg_25_1

	arg_25_0:RefreshSoundUI()
end

function var_0_0.RefreshSoundUI(arg_26_0)
	arg_26_0.criplayer_:SetVolume(arg_26_0.musicVolume_ / 100)
	arg_26_0:RefreshSoundState()

	arg_26_0.slider_.value = arg_26_0.musicVolume_
	arg_26_0.soundText_.text = string.format("%d%%", arg_26_0.musicVolume_)
end

function var_0_0.RefreshSoundPanel(arg_27_0)
	if arg_27_0.showSoundFlag_ then
		arg_27_0.showSoundSettingController_:SetSelectedState("true")
	else
		arg_27_0.showSoundSettingController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshSoundState(arg_28_0)
	if arg_28_0.musicVolume_ <= 0 then
		arg_28_0.soundStateController_:SetSelectedState("off")
	else
		arg_28_0.soundStateController_:SetSelectedState("on")
	end
end

function var_0_0.SetAudioTrack(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:GetVedioTrackIndex(arg_29_2)

	arg_29_1:SetAudioTrack(var_29_0)
	arg_29_1:SetSubtitleChannel(var_29_0)
end

function var_0_0.GetVedioTrackIndex(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetVedioFileName(arg_30_1)
	local var_30_1 = 0
	local var_30_2 = manager.audio:GetLocalizationFlag()
	local var_30_3 = VideoTrackCfg[var_30_0]

	if var_30_3 and var_30_3.has_tracks == 1 then
		if var_30_2 == "zh" then
			var_30_1 = 0
		elseif var_30_2 == "ja" then
			var_30_1 = 1
		elseif var_30_2 == "en" then
			var_30_1 = 2
		elseif var_30_2 == "ko" then
			var_30_1 = 3
		end
	end

	return var_30_1
end

function var_0_0.GetVedioFileName(arg_31_0, arg_31_1)
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

function var_0_0.GetI18NVideoPath(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:GetVedioFileName(arg_32_1)

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

return var_0_0
