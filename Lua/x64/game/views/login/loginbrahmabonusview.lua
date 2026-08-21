local var_0_0 = class("LoginBrahmaBonusView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginBrahmaBonus"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.criManaMovieController_ = arg_3_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer_ = arg_3_0.criManaMovieController_.player

	arg_3_0.criplayer_:SetMaxPictureDataSize(300000)

	arg_3_0.criManaMovieController2_ = arg_3_0.movie2Go_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer2_ = arg_3_0.criManaMovieController2_.player

	arg_3_0.criplayer2_:SetMaxPictureDataSize(300000)
	arg_3_0:InitMovieData()

	arg_3_0.chooseTimer_ = nil
end

function var_0_0.InitMovieData(arg_4_0)
	arg_4_0.moviePath_ = {}
	arg_4_0.movieTotalFrames_ = {}

	local var_4_0 = GameDisplayCfg.login_bonus_movie_path.value
	local var_4_1 = GameDisplayCfg.login_bonus_movie_frames.value

	for iter_4_0 = 1, 5 do
		local var_4_2 = var_4_0[iter_4_0]

		table.insert(arg_4_0.moviePath_, var_4_2)

		arg_4_0.movieTotalFrames_[iter_4_0] = var_4_1[iter_4_0]
	end

	arg_4_0.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	arg_4_0:SetVideoTrack(arg_4_0.criplayer_, var_4_0[1])
	arg_4_0.criplayer_:SetBufferingTime(0.033)
	arg_4_0.criplayer2_:SetVolume(manager.audio:GetEffectVolume())
	arg_4_0:SetVideoTrack(arg_4_0.criplayer2_, var_4_0[3])
	arg_4_0.criplayer2_:SetBufferingTime(0.033)
	SetFile(arg_4_0.criplayer_, nil, arg_4_0.moviePath_[1], CriMana.Player.SetMode.New)
	SetFile(arg_4_0.criplayer_, nil, arg_4_0.moviePath_[2], CriMana.Player.SetMode.AppendRepeatedly)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_1_yes, nil, function()
		arg_5_0:Choose1(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_1_no, nil, function()
		arg_5_0:Choose1(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_2, nil, function()
		arg_5_0:Choose2(1)
	end)
end

function var_0_0.Choose1(arg_9_0, arg_9_1)
	arg_9_0:StopChooseTimer()
	LoginBonusAction.DoChoose(1, arg_9_1)
	arg_9_0:StepPlayLoopMovie(2)
	SetActive(arg_9_0.nextGo_1_yes, false)
	SetActive(arg_9_0.nextGo_1_no, false)
end

function var_0_0.Choose2(arg_10_0, arg_10_1)
	arg_10_0:StopChooseTimer()
	LoginBonusAction.DoChoose(2, arg_10_1)
	arg_10_0:StepPlayExitMovie()
	SetActive(arg_10_0.nextGo_2, false)
end

function var_0_0.OnEnter(arg_11_0)
	manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
	SetActive(arg_11_0.nextGo_1_yes, false)
	SetActive(arg_11_0.nextGo_1_no, false)
	SetActive(arg_11_0.nextGo_2, false)
	arg_11_0:StepPlayLoopMovie(1)
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0._timer then
		arg_12_0._timer:Stop()

		arg_12_0._timer = nil
	end

	if arg_12_0._timer2 then
		arg_12_0._timer2:Stop()

		arg_12_0._timer2 = nil
	end

	if arg_12_0._startTimer2 then
		arg_12_0._startTimer2:Stop()

		arg_12_0._startTimer2 = nil
	end

	if arg_12_0._startTimer3 then
		arg_12_0._startTimer3:Stop()

		arg_12_0._startTimer3 = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.StatusChangeCallback(arg_14_0, arg_14_1)
	local var_14_0 = tostring(arg_14_1)

	if var_14_0 == "PlayEnd" then
		arg_14_0:OnMovieEnd(3)
	elseif var_14_0 == "Playing" then
		-- block empty
	end
end

function var_0_0.OnMovieEnd(arg_15_0, arg_15_1)
	if arg_15_1 == 1 then
		SetActive(arg_15_0.nextGo_1_yes, true)
		SetActive(arg_15_0.nextGo_1_no, true)
		arg_15_0:CreateChooseTimer(function()
			arg_15_0:Choose1(0)
		end, 10)
	elseif arg_15_1 == 2 then
		SetActive(arg_15_0.nextGo_2, true)
		arg_15_0:CreateChooseTimer(function()
			arg_15_0:Choose2(0)
		end, 10)
	elseif arg_15_1 == 3 then
		arg_15_0:JumpToLoginPage()
	end
end

function var_0_0.StepPlayLoopMovie(arg_18_0, arg_18_1)
	LoginBonusAction.EnterState(arg_18_1)

	if arg_18_1 == 1 then
		arg_18_0.criManaMovieController_:Play()

		arg_18_0._timer = FrameTimer.New(function()
			if arg_18_0.criplayer_:GetDisplayedFrameNo() >= arg_18_0.movieTotalFrames_[1] then
				arg_18_0:OnMovieEnd(1)
				arg_18_0._timer:Stop()

				arg_18_0._timer = nil
			end
		end, 1, -1)

		arg_18_0._timer:Start()
	elseif arg_18_1 == 2 then
		SetFile(arg_18_0.criplayer2_, nil, arg_18_0.moviePath_[3], CriMana.Player.SetMode.New)
		SetFile(arg_18_0.criplayer2_, nil, arg_18_0.moviePath_[4], CriMana.Player.SetMode.AppendRepeatedly)
		arg_18_0.criManaMovieController2_:Play()

		arg_18_0._startTimer2 = FrameTimer.New(function()
			if arg_18_0.criplayer2_:GetDisplayedFrameNo() >= 1 then
				arg_18_0.movie2Go_.transform.localPosition = Vector2(0, 0)
				arg_18_0.movieGo_.transform.localPosition = Vector2(9999, 9999)

				arg_18_0.criManaMovieController_:Stop()
				arg_18_0._startTimer2:Stop()

				arg_18_0._startTimer2 = nil
			end
		end, 1, -1)

		arg_18_0._startTimer2:Start()

		arg_18_0._timer2 = FrameTimer.New(function()
			if arg_18_0.criplayer2_:GetDisplayedFrameNo() >= arg_18_0.movieTotalFrames_[3] then
				arg_18_0:OnMovieEnd(2)
				arg_18_0._timer2:Stop()

				arg_18_0._timer2 = nil
			end
		end, 1, -1)

		arg_18_0._timer2:Start()
	end
end

function var_0_0.StepPlayExitMovie(arg_22_0)
	LoginBonusAction.EnterState(3)
	SetFile(arg_22_0.criplayer_, nil, arg_22_0.moviePath_[5], CriMana.Player.SetMode.New)

	arg_22_0.criplayer_.statusChangeCallback = handler(arg_22_0, arg_22_0.StatusChangeCallback)

	arg_22_0.criManaMovieController_:Play()

	arg_22_0._startTimer3 = FrameTimer.New(function()
		if arg_22_0.criplayer_:GetDisplayedFrameNo() >= 1 then
			arg_22_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_22_0.movie2Go_.transform.localPosition = Vector2(9999, 9999)

			arg_22_0.criManaMovieController2_:Stop()
			arg_22_0._startTimer3:Stop()

			arg_22_0._startTimer3 = nil
		end
	end, 1, -1)

	arg_22_0._startTimer3:Start()
end

function var_0_0.JumpToLoginPage(arg_24_0)
	gameContext:ClearHistory()
	PreLoadAssetByPlayer()
end

function var_0_0.CreateChooseTimer(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:StopChooseTimer()

	arg_25_0.chooseTimer_ = Timer.New(arg_25_1, arg_25_2, 1)

	arg_25_0.chooseTimer_:Start()
end

function var_0_0.StopChooseTimer(arg_26_0)
	if arg_26_0.chooseTimer_ then
		arg_26_0.chooseTimer_:Stop()

		arg_26_0.chooseTimer_ = nil
	end
end

function var_0_0.Cacheable(arg_27_0)
	return false
end

function var_0_0.SetVideoTrack(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = manager.video:GetVedioTrackIndex(arg_28_2)

	arg_28_1:SetAudioTrack(var_28_0)
	arg_28_1:SetSubtitleChannel(var_28_0)
end

return var_0_0
