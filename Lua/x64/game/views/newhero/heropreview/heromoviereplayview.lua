local var_0_0 = class("HeroMovieReplayView", ReduxView)
local var_0_1 = require("game.views.obtain.ObtainHeroMovieView")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ObtainUI/HeroMovie/ObtainHeroMovieUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	var_0_0.super.Init(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.starController_ = ControllerUtil.GetController(arg_4_0.transform_, "star")
	arg_4_0.criMovie_ = arg_4_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
	arg_4_0.cirMovieLoop_ = arg_4_0.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayerLoop_ = arg_4_0.cirMovieLoop_.player
	arg_4_0.SimplePlayer_ = arg_4_0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	arg_4_0.startDirectorStopCallBack = handler(arg_4_0, arg_4_0.StartDirectorStopCallBack)
	arg_4_0.playableDirectorStart_.stopped = arg_4_0.playableDirectorStart_.stopped + arg_4_0.startDirectorStopCallBack

	arg_4_0.criplayer_:SetMaxPictureDataSize(300000)

	arg_4_0._timer = FrameTimer.New(handler(arg_4_0, arg_4_0.MovieProcess), 1, -1)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.item = {
		id = arg_7_0.params_.heroID
	}

	arg_7_0:Show(arg_7_0.item)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0._timer:Stop()
	manager.audio:StopVoice()
	arg_8_0.criMovie_:Stop()
	arg_8_0.cirMovieLoop_:Stop()
end

function var_0_0.Hide(arg_9_0)
	var_0_0.super.Hide(arg_9_0)
end

var_0_0.SetupCriPlayer = var_0_1.SetupCriPlayer

function var_0_0.Show(arg_10_0, arg_10_1)
	arg_10_0.item = arg_10_1

	if arg_10_0.gameObject_ then
		SetActive(arg_10_0.gameObject_, true)
	end

	local var_10_0 = ObtainHeroMovieCfg[arg_10_1.id]

	arg_10_0:SetupCriPlayer(var_10_0)
	arg_10_0:SetInfo(arg_10_1)
	arg_10_0.playableDirectorStart_:Evaluate()
	arg_10_0.playableDirectorStart_:Play()
	SetActive(arg_10_0.rebateGo_, false)
	SetActive(arg_10_0.convertGo_, false)
	SetActive(arg_10_0.m_endGo, false)

	arg_10_0.SkipStart = true

	if arg_10_0.SkipStart then
		arg_10_0.playableDirectorStart_.time = arg_10_0.playableDirectorStart_.duration
	end
end

function var_0_0.PlayGetHeroVoice(arg_11_0)
	local var_11_0 = arg_11_0:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", var_11_0), string.format("v_s_%d_%s", var_11_0, "get_cg"), string.format("vo_sys_%d.awb", var_11_0))
end

function var_0_0.GetPlayable(arg_12_0)
	return arg_12_0.playableDirector_
end

function var_0_0.GetHeroID(arg_13_0)
	return arg_13_0.item.id
end

var_0_0.SetVideoTrack = var_0_1.SetVideoTrack

function var_0_0.PlayMovie(arg_14_0, arg_14_1)
	if arg_14_0.isPlayMovie then
		if arg_14_1 then
			arg_14_0.isPlayMovieEnd = true

			arg_14_0.criMovie_:Stop()

			arg_14_0.movieTrs_.localPosition = Vector2(9999, 9999)

			arg_14_0.cirMovieLoop_:Play()

			arg_14_0.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	local var_14_0 = arg_14_0.item.id

	if arg_14_0.start_voice_frames == 0 then
		manager.audio:PlayVoice(string.format("vo_sys_%d", var_14_0), string.format("v_s_%d_%s", var_14_0, "get_cg"), string.format("vo_sys_%d.awb", var_14_0))
	end

	arg_14_0.isPlayMovie = true

	if arg_14_1 then
		arg_14_0.cirMovieLoop_:Play()

		arg_14_0.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		arg_14_0.criMovie_:Play()

		arg_14_0.movieTrs_.localPosition = Vector2(0, 0)
	end

	arg_14_0._timer:Start()
end

function var_0_0.MovieProcess(arg_15_0)
	local var_15_0 = arg_15_0.criplayer_.status
	local var_15_1 = arg_15_0.criplayer_:GetDisplayedFrameNo()

	if arg_15_0.start_voice_frames ~= 0 and tostring(var_15_0) == "Playing" and var_15_1 >= arg_15_0.start_voice_frames then
		arg_15_0.start_voice_frames = 0

		arg_15_0:PlayGetHeroVoice()
	end

	if tostring(var_15_0) == "Playing" and var_15_1 > arg_15_0.start_movie_frames then
		SetActive(arg_15_0.m_endGo, true)

		local var_15_2 = arg_15_0:GetPlayable()

		var_15_2:Evaluate()
		var_15_2:Play()
		arg_15_0._timer:Stop()

		arg_15_0.isPlayMovieEnd = true

		if arg_15_0.showSkipHandler then
			arg_15_0.showSkipHandler()
		end

		if arg_15_0.refreshShareHandler_ then
			arg_15_0.refreshShareHandler_()
		end
	end
end

function var_0_0.OnClick(arg_16_0)
	local var_16_0 = arg_16_0:GetPlayable()

	if arg_16_0.isPlayMovieEnd and (var_16_0.time == 0 or var_16_0.time >= arg_16_0:GetTimeLineEndTime()) then
		return true
	end

	if not arg_16_0.isPlayMovieEnd then
		arg_16_0:PlayMovie(true)
	end

	arg_16_0.isPlayMovieEnd = true

	arg_16_0._timer:Stop()
	SetActive(arg_16_0.m_endGo, true)

	arg_16_0.playableDirectorStart_.time = arg_16_0.playableDirectorStart_.duration
	var_16_0.time = arg_16_0:GetTimeLineEndTime()

	var_16_0:Play()

	if arg_16_0.showSkipHandler then
		arg_16_0.showSkipHandler()
	end

	return false
end

var_0_0.Skip2End = var_0_1.Skip2End
var_0_0.GetTimeLineEndTime = var_0_1.GetTimeLineEndTime
var_0_0.RefreshContent = var_0_1.RefreshContent

function var_0_0.SetInfo(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.id
	local var_17_1 = HeroCfg[var_17_0]

	if not var_17_1 then
		return
	end

	arg_17_0:RefreshContent(var_17_0, var_17_1)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.playableDirectorStart_.stopped = arg_18_0.playableDirectorStart_.stopped - arg_18_0.startDirectorStopCallBack

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnObtainHeroMovieAnimtionEvent(arg_19_0)
	arg_19_0:PlayMovie()
end

function var_0_0.StartDirectorStopCallBack(arg_20_0)
	arg_20_0:PlayMovie()
end

return var_0_0
