local var_0_0 = class("ActivitySkinDrawMovieView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddBtnListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddBtnListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.itemID_ = ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][1]

	local var_6_0 = ItemCfg[arg_6_0.itemID_]

	if ActivitySkinDrawTools.GetIsSkinGift(arg_6_0.itemID_) then
		arg_6_0.itemID_ = var_6_0.param[1][1]
	end

	arg_6_0.backcall_ = arg_6_2
	arg_6_0.movieCfg_ = ObtainSkinMovieCfg[arg_6_0.itemID_]
	arg_6_0.moviePath_ = arg_6_0.movieCfg_.start_path
	arg_6_0.criMovie_ = arg_6_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_6_0.criplayer_ = arg_6_0.criMovie_.player
	arg_6_0.isPlayMovie_ = false
	arg_6_0.isPlayMovieEnd_ = false

	arg_6_0.criMovie_:Stop()

	arg_6_0.movieTrs_.localPosition = Vector2(9999, 9999)

	SetFile(arg_6_0.criplayer_, nil, arg_6_0.moviePath_, CriMana.Player.SetMode.New)

	local var_6_1 = manager.audio:GetMusicVolume()

	arg_6_0.criplayer_:SetVolume(var_6_1)
	arg_6_0:SetVideoTrack(arg_6_0.criplayer_, arg_6_0.moviePath_)
	arg_6_0:StopTimer()

	arg_6_0.timer_ = FrameTimer.New(handler(arg_6_0, arg_6_0.MovieProcess), 1, -1)

	arg_6_0:PlayMovie()
end

function var_0_0.SetVideoTrack(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = manager.video:GetVedioTrackIndex(arg_7_2)

	arg_7_1:SetAudioTrack(var_7_0)
	arg_7_1:SetSubtitleChannel(var_7_0)
end

function var_0_0.PlayMovie(arg_8_0, arg_8_1)
	if arg_8_0.isPlayMovie_ then
		if arg_8_1 then
			arg_8_0.isPlayMovieEnd_ = true

			arg_8_0.criMovie_:Stop()

			arg_8_0.movieTrs_.localPosition = Vector2(9999, 9999)

			arg_8_0:Hide()

			if arg_8_0.backcall_ then
				arg_8_0.backcall_()
			end
		end

		return
	end

	manager.audio:PlayVoice(string.format("vo_sys_%d", arg_8_0.itemID_), string.format("skin_v_getvideo_%d_%s", arg_8_0.itemID_, "get"), string.format("vo_sys_%d.awb", arg_8_0.itemID_))

	arg_8_0.isPlayMovie_ = true

	if arg_8_1 then
		arg_8_0:Hide()

		if arg_8_0.backcall_ then
			arg_8_0.backcall_()
		end
	else
		arg_8_0.criMovie_:Play()

		arg_8_0.movieTrs_.localPosition = Vector2(0, 0)
	end

	arg_8_0.timer_:Start()
end

function var_0_0.MovieProcess(arg_9_0)
	local var_9_0 = arg_9_0.criplayer_.status
	local var_9_1 = arg_9_0.criplayer_:GetDisplayedFrameNo()

	if tostring(var_9_0) == "Playing" and var_9_1 > arg_9_0.movieCfg_.end_movie_frames then
		arg_9_0.timer_:Stop()

		arg_9_0.isPlayMovieEnd_ = true

		arg_9_0:Hide()

		if arg_9_0.backcall_ then
			arg_9_0.backcall_()
		end
	end
end

function var_0_0.Hide(arg_10_0)
	SetActive(arg_10_0.gameObject_, false)
	manager.audio:StopVoice()
	arg_10_0:StopTimer()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.backcall_ = nil

	arg_12_0:StopTimer()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
