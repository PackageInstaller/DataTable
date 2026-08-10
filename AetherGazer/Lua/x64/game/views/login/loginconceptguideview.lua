local var_0_0 = class("LoginConceptGuideView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginConceptGuild"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.criManaExMultipleVideo_ = arg_3_0.movieGo_:GetComponent("CriManaExMultipleVedio")
	arg_3_0.criManaMovieController_ = arg_3_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer_ = arg_3_0.criManaMovieController_.player
	arg_3_0.criplayer_.statusChangeCallback = handler(arg_3_0, arg_3_0.StatusChangeCallback)

	arg_3_0.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	arg_3_0.criplayer_:SetMaxPictureDataSize(600000)
	arg_3_0.criplayer_:SetBufferingTime(0.05)
	arg_3_0:InitMovieData()

	arg_3_0._timer = FrameTimer.New(handler(arg_3_0, arg_3_0.MovieProcess), 1, -1)
end

function var_0_0.InitMovieData(arg_4_0)
	arg_4_0.moviePath_ = {}
	arg_4_0.movieTotalFrames_ = {}

	local var_4_0 = GameDisplayCfg.login_concept_guild_movie_path.value
	local var_4_1 = GameDisplayCfg.login_concept_guild_movie_frames.value

	for iter_4_0 = 1, 4 do
		local var_4_2 = var_4_0[iter_4_0]

		table.insert(arg_4_0.moviePath_, var_4_2)

		arg_4_0.movieTotalFrames_[iter_4_0] = var_4_1[iter_4_0]
	end

	arg_4_0.movieEndFrames_ = {}

	arg_4_0:CalcNextMovieData(0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_1, nil, function()
		arg_5_0:CalcNextMovieData(1)
		arg_5_0:StepPlayLoopMovie(2)
		SetActive(arg_5_0.nextGo_1, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_2, nil, function()
		arg_5_0:CalcNextMovieData(3)
		SetActive(arg_5_0.nextGo_2, false)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	GameLocalData:SaveToCommonModule("LoginConceptGuideData", "watched", true)
	gameContext:SetSystemLayer("login")

	_G.isLogining = false

	LoadingUIManager.inst:CloseLoadUI()
	SetActive(arg_8_0.nextGo_1, false)
	SetActive(arg_8_0.nextGo_2, false)

	arg_8_0.curMovieIdx_ = 1

	arg_8_0:StepPlayLoopMovie(1)
	arg_8_0._timer:Start()
	manager.audio:PlayVoice("vo_login_vocal", "vo_login_vocal_1", "vo_login_vocal.awb")
	manager.audio:PlayBGM("bgm_login_4_0", "bgm_login_4_0_part1", "bgm_login_4_0")

	arg_8_0.movieExited_ = {}
end

function var_0_0.OnExit(arg_9_0)
	GameLocalData:SaveToCommonModule("LoginConceptGuideData", "watched", true)
	arg_9_0._timer:Stop()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.StatusChangeCallback(arg_11_0, arg_11_1)
	local var_11_0 = tostring(arg_11_1)

	if var_11_0 == "PlayEnd" then
		arg_11_0:OnMovieEnd(arg_11_0.curMovieIdx_)
	elseif var_11_0 == "Playing" then
		arg_11_0:FetchMovieTotalFrames()
	end
end

function var_0_0.OnMovieEnd(arg_12_0, arg_12_1)
	if arg_12_0.movieExited_[arg_12_1] then
		return
	end

	arg_12_0.movieExited_[arg_12_1] = true

	if arg_12_1 == 1 then
		SetActive(arg_12_0.nextGo_1, true)
	elseif arg_12_1 == 2 then
		arg_12_0:CalcNextMovieData(arg_12_1)
		manager.audio:PlayBGM("bgm_login_4_0", "bgm_login_4_0_part3", "bgm_login_4_0")
	elseif arg_12_1 == 3 then
		arg_12_0:CalcNextMovieData(arg_12_1)
	elseif arg_12_1 == 4 then
		arg_12_0:JumpToLoginPage()
	elseif arg_12_1 == 5 then
		arg_12_0:JumpToLoginPage()
	end

	arg_12_0.curMovieIdx_ = arg_12_0.curMovieIdx_ + 1
end

function var_0_0.StepPlayLoopMovie(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 * 2 - 1

	SetFile(arg_13_0.criplayer_, nil, arg_13_0.moviePath_[var_13_0], CriMana.Player.SetMode.Append)
	SetFile(arg_13_0.criplayer_, nil, arg_13_0.moviePath_[var_13_0 + 1], CriMana.Player.SetMode.AppendRepeatedly)
	arg_13_0.criManaMovieController_:Play()
end

function var_0_0.StepPlayExitMovie(arg_14_0)
	SetFile(arg_14_0.criplayer_, nil, arg_14_0.moviePath_[5], CriMana.Player.SetMode.New)
	arg_14_0.criManaMovieController_:Play()
end

function var_0_0.FetchMovieTotalFrames(arg_15_0)
	return
end

function var_0_0.MovieProcess(arg_16_0)
	local var_16_0 = arg_16_0.criplayer_.status
	local var_16_1 = arg_16_0.criplayer_:GetDisplayedFrameNo()
	local var_16_2 = arg_16_0.curMovieIdx_

	if var_16_2 == 2 then
		if not arg_16_0.lastAudioPlayTime_ then
			arg_16_0.lastAudioPlayTime_ = Time.time
		elseif Time.time - arg_16_0.lastAudioPlayTime_ > 6 then
			arg_16_0.lastAudioPlayTime_ = Time.time

			manager.audio:PlayVoice("vo_login_vocal", "vo_login_vocal_2", "vo_login_vocal.awb")
		end
	end

	if arg_16_0.movieEndFrames_[var_16_2] == nil then
		return
	end

	if var_16_1 >= arg_16_0.movieEndFrames_[var_16_2] then
		arg_16_0:OnMovieEnd(var_16_2)
	end
end

function var_0_0.JumpToLoginPage(arg_17_0)
	manager.transition:OnlyShowEffect(true, function()
		if arg_17_0.OnlyShowEffectExiting_ then
			return
		end

		arg_17_0.OnlyShowEffectExiting_ = true

		manager.transition:OnlyShowEffect(false)

		arg_17_0.OnlyShowEffectExiting_ = false

		local var_18_0 = arg_17_0.params_.isAutoLogin

		arg_17_0:Back()
		gameContext:Go("/login", {
			isAutoLogin = var_18_0
		})
	end)
end

function var_0_0.CalcNextMovieData(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 + 1

	if arg_19_1 == 0 then
		arg_19_0.movieEndFrames_[var_19_0] = arg_19_0.movieTotalFrames_[var_19_0]

		return
	end

	if arg_19_2 == nil then
		arg_19_2 = 0
	end

	local var_19_1 = arg_19_0.criplayer_:GetDisplayedFrameNo()
	local var_19_2 = arg_19_0.movieTotalFrames_[var_19_0]
	local var_19_3 = arg_19_0.movieEndFrames_[arg_19_1]

	arg_19_0.movieEndFrames_[var_19_0] = var_19_3 + var_19_2 * math.max(math.ceil((var_19_1 - var_19_3) / var_19_2) + arg_19_2, 1)
end

return var_0_0
