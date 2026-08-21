local var_0_0 = class("ObtainHeroMovieView", require("game.views.obtain.ObtainHeroView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.showSkipHandler = arg_1_3.obtainView.showSkipHandler
	arg_1_0.refreshShareHandler_ = arg_1_3.obtainView.refreshShareHandler
	arg_1_0.skipStart = arg_1_3.obtainView.skipStart
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.starController_ = ControllerUtil.GetController(arg_2_0.transform_, "star")
	arg_2_0.criMovie_ = arg_2_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_2_0.criplayer_ = arg_2_0.criMovie_.player
	arg_2_0.cirMovieLoop_ = arg_2_0.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	arg_2_0.criplayerLoop_ = arg_2_0.cirMovieLoop_.player
	arg_2_0.SimplePlayer_ = arg_2_0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	arg_2_0.commonItem_ = CommonItem.New(arg_2_0.itemGo_)
	arg_2_0.startDirectorStopCallBack = handler(arg_2_0, arg_2_0.StartDirectorStopCallBack)
	arg_2_0.playableDirectorStart_.stopped = arg_2_0.playableDirectorStart_.stopped + arg_2_0.startDirectorStopCallBack

	arg_2_0.criplayer_:SetMaxPictureDataSize(300000)

	arg_2_0._timer = FrameTimer.New(handler(arg_2_0, arg_2_0.MovieProcess), 1, -1)
end

function var_0_0.OnClick(arg_3_0)
	local var_3_0 = arg_3_0:GetPlayable()

	if arg_3_0.isPlayMovieEnd and (var_3_0.time == 0 or var_3_0.time >= arg_3_0:GetTimeLineEndTime()) then
		return true
	end

	if not (getData(DrawConst.WATCH_TAG, tostring(arg_3_0:GetHeroID())) or false) then
		return false
	end

	if not arg_3_0.isPlayMovieEnd then
		arg_3_0:PlayMovie(true)
	end

	arg_3_0.isPlayMovieEnd = true

	arg_3_0._timer:Stop()
	SetActive(arg_3_0.m_endGo, true)

	arg_3_0.playableDirectorStart_.time = arg_3_0.playableDirectorStart_.duration
	var_3_0.time = arg_3_0:GetTimeLineEndTime()

	var_3_0:Play()

	if arg_3_0.showSkipHandler then
		arg_3_0.showSkipHandler()
	end

	return false
end

function var_0_0.SetupCriPlayer(arg_4_0, arg_4_1)
	arg_4_0.start_path = arg_4_1.start_path
	arg_4_0.loop_path = arg_4_1.loop_path
	arg_4_0.start_movie_frames = arg_4_1.start_movie_frames
	arg_4_0.start_voice_frames = arg_4_1.start_voice_frames
	arg_4_0.isPlayMovie = false
	arg_4_0.isPlayMovieEnd = false

	arg_4_0.criMovie_:Stop()

	arg_4_0.movieTrs_.localPosition = Vector2(9999, 9999)

	arg_4_0.cirMovieLoop_:Stop()

	arg_4_0.movieLoopTrs_.localPosition = Vector2(9999, 9999)

	SetFile(arg_4_0.criplayer_, nil, arg_4_0.start_path, CriMana.Player.SetMode.New)
	SetFile(arg_4_0.criplayer_, nil, arg_4_0.loop_path, CriMana.Player.SetMode.AppendRepeatedly)
	SetFile(arg_4_0.criplayerLoop_, nil, arg_4_0.loop_path)

	local var_4_0 = manager.audio:GetMusicVolume()

	arg_4_0.criplayer_:SetVolume(var_4_0)
	arg_4_0.criplayerLoop_:SetVolume(var_4_0)
	arg_4_0:SetVideoTrack(arg_4_0.criplayer_, arg_4_0.start_path)
	arg_4_0:SetVideoTrack(arg_4_0.criplayerLoop_, arg_4_0.loop_path)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0.item = arg_5_1
	arg_5_0.convert = ItemWillConvert(arg_5_1)

	if arg_5_0.gameObject_ then
		SetActive(arg_5_0.gameObject_, true)
	end

	local var_5_0 = ObtainHeroMovieCfg[arg_5_0:GetHeroID()]

	arg_5_0:SetupCriPlayer(var_5_0)
	arg_5_0:SetInfo(arg_5_1)
	arg_5_0.playableDirectorStart_:Evaluate()
	arg_5_0.playableDirectorStart_:Play()
	SetActive(arg_5_0.m_endGo, false)

	if arg_5_0.skipStart then
		arg_5_0.playableDirectorStart_.time = arg_5_0.playableDirectorStart_.duration
	end
end

function var_0_0.SetVideoTrack(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = manager.video:GetVedioTrackIndex(arg_6_2)

	arg_6_1:SetAudioTrack(var_6_0)
	arg_6_1:SetSubtitleChannel(var_6_0)
end

function var_0_0.PlayMovie(arg_7_0, arg_7_1)
	if arg_7_0.isPlayMovie then
		if arg_7_1 then
			arg_7_0.isPlayMovieEnd = true

			arg_7_0.criMovie_:Stop()

			arg_7_0.movieTrs_.localPosition = Vector2(9999, 9999)

			arg_7_0.cirMovieLoop_:Play()

			arg_7_0.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	if arg_7_0.start_voice_frames == 0 then
		arg_7_0:PlayGetHeroVoice()
	end

	arg_7_0.isPlayMovie = true

	if arg_7_1 then
		arg_7_0.cirMovieLoop_:Play()

		arg_7_0.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		arg_7_0.criMovie_:Play()

		arg_7_0.movieTrs_.localPosition = Vector2(0, 0)
	end

	arg_7_0._timer:Start()
end

function var_0_0.MovieProcess(arg_8_0)
	local var_8_0 = arg_8_0.criplayer_.status
	local var_8_1 = arg_8_0.criplayer_:GetDisplayedFrameNo()

	if arg_8_0.start_voice_frames ~= 0 and tostring(var_8_0) == "Playing" and var_8_1 >= arg_8_0.start_voice_frames then
		arg_8_0.start_voice_frames = 0

		arg_8_0:PlayGetHeroVoice()
	end

	if tostring(var_8_0) == "Playing" and var_8_1 > arg_8_0.start_movie_frames then
		SetActive(arg_8_0.m_endGo, true)

		local var_8_2 = arg_8_0:GetPlayable()

		var_8_2:Evaluate()
		var_8_2:Play()
		arg_8_0._timer:Stop()

		arg_8_0.isPlayMovieEnd = true

		saveData(DrawConst.WATCH_TAG, tostring(arg_8_0:GetHeroID()), true)

		if arg_8_0.showSkipHandler then
			arg_8_0.showSkipHandler()
		end

		if arg_8_0.refreshShareHandler_ then
			arg_8_0.refreshShareHandler_()
		end
	end
end

function var_0_0.RefreshContent(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.name_.text = HeroTools.GetHeroFullName(arg_9_1)

	local var_9_0 = RaceEffectCfg[arg_9_2.race]

	arg_9_0.camp_.sprite = getSprite("Atlas/CampItemAtlas", var_9_0.icon)

	local var_9_1 = ItemCfg[arg_9_1]
	local var_9_2 = math.min(var_9_1.display_rare, 5)

	arg_9_0.starController_:SetSelectedIndex(var_9_2)

	if var_9_2 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_9_2 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end
end

function var_0_0.GetTimeLineEndTime(arg_10_0)
	return 1.5
end

function var_0_0.Skip2End(arg_11_0)
	local var_11_0 = arg_11_0:GetPlayable()

	if not arg_11_0.isPlayMovieEnd then
		arg_11_0:PlayMovie(true)
	end

	arg_11_0.isPlayMovieEnd = true

	arg_11_0._timer:Stop()
	SetActive(arg_11_0.m_endGo, true)

	arg_11_0.playableDirectorStart_.time = arg_11_0.playableDirectorStart_.duration
	var_11_0.time = 1.5

	var_11_0:Play()

	if arg_11_0.showSkipHandler then
		arg_11_0.showSkipHandler()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.playableDirectorStart_.stopped = arg_12_0.playableDirectorStart_.stopped - arg_12_0.startDirectorStopCallBack

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.Hide(arg_13_0)
	arg_13_0._timer:Stop()
	manager.audio:StopVoice()
	ObtainBaseView.Hide(arg_13_0)
end

function var_0_0.OnObtainHeroMovieAnimtionEvent(arg_14_0)
	arg_14_0:PlayMovie()
end

function var_0_0.StartDirectorStopCallBack(arg_15_0)
	arg_15_0:PlayMovie()
end

return var_0_0
