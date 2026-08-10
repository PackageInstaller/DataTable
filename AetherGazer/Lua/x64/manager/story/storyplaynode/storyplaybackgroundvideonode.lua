local var_0_0 = class("StoryPlayBackgroundVideoNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.isPlay_ = true
	arg_1_0.playMode_ = StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE
	arg_1_0.videoPath_ = ""
	arg_1_0.partLoopVideoPath_ = ""
	arg_1_0.videoStopMode_ = StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MANUAL
end

function var_0_0.SetConfig(arg_2_0, arg_2_1)
	var_0_0.super.SetConfig(arg_2_0, arg_2_1)

	arg_2_0.isPlay_ = arg_2_1.isPlay
	arg_2_0.playMode_ = arg_2_1.playMode
	arg_2_0.videoPath_ = arg_2_1.videoPath
	arg_2_0.partLoopVideoPath_ = arg_2_1.partLoopVideoPath
	arg_2_0.videoStopMode_ = arg_2_1.videoStopMode
end

function var_0_0.OnPlay(arg_3_0)
	arg_3_0.criManaMovieController_, arg_3_0.needReplaceShader_ = arg_3_0.storyPlayer_:GetBackgroundVideoController()
	arg_3_0.criplayer_ = arg_3_0.criManaMovieController_.player

	if arg_3_0.isPlay_ then
		if arg_3_0.needReplaceShader_ then
			arg_3_0:PlayVideoDelayFrame()

			arg_3_0.hasDelayPlay_ = true
		else
			arg_3_0:PlayVideo()
		end
	else
		arg_3_0:StopVideo()
	end
end

function var_0_0.PlayVideoDelayFrame(arg_4_0)
	FrameTimer.New(function()
		arg_4_0:PlayVideo()
	end, 1, 1):Start()
end

function var_0_0.PlayVideo(arg_6_0)
	if not arg_6_0.videoPath_ or arg_6_0.videoPath_ == "" then
		if not arg_6_0.hasDelayPlay_ then
			arg_6_0.hasDelayPlay_ = false

			Debug.LogError("videoPath is nil")
		end

		return
	end

	if arg_6_0.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE then
		arg_6_0:SetupVideo(arg_6_0.videoPath_, false, CriMana.Player.SetMode.New)
	elseif arg_6_0.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.LOOP then
		arg_6_0:SetupVideo(arg_6_0.videoPath_, true, CriMana.Player.SetMode.New)
	elseif arg_6_0.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.PART_LOOP then
		arg_6_0.criplayer_:SetMaxPictureDataSize(300000)
		arg_6_0:SetupVideo(arg_6_0.videoPath_, true, CriMana.Player.SetMode.New)
		arg_6_0:SetupVideo(arg_6_0.partLoopVideoPath_, false, CriMana.Player.SetMode.AppendRepeatedly)
	end

	arg_6_0.musicVolume_ = manager.audio:GetMusicVolume()

	arg_6_0.criplayer_:SetVolume(arg_6_0.musicVolume_)
	arg_6_0.criManaMovieController_:Play()
end

function var_0_0.SetupVideo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	manager.video:SetAudioTrack(arg_7_0.criplayer_, arg_7_1)
	arg_7_0.criplayer_:Loop(arg_7_2)
	SetFile(arg_7_0.criplayer_, nil, manager.video:GetI18NVideoPath(arg_7_1), arg_7_3)
end

function var_0_0.StopVideo(arg_8_0)
	local var_8_0 = arg_8_0.criManaMovieController_

	if var_8_0 and var_8_0.player then
		arg_8_0.criManaMovieController_:Stop()
	end

	arg_8_0.storyPlayer_:RetureBackgroundVideoController()
end

function var_0_0.OnPause(arg_9_0)
	arg_9_0.criManaMovieController_:Pause(true)
end

function var_0_0.OnResume(arg_10_0)
	arg_10_0.criManaMovieController_:Pause(false)
end

function var_0_0.OnFinish(arg_11_0)
	if arg_11_0.playMode_ == StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.ONCE and arg_11_0.videoStopMode_ == StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MOVIE_END then
		arg_11_0:StopVideo()
	end
end

function var_0_0.OnDispose(arg_12_0)
	arg_12_0:StopVideo()
end

return var_0_0
