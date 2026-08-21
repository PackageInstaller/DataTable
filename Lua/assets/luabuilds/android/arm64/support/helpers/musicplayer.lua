local var_0_0 = class("MusicPlayer")

var_0_0.NO_PLAY_MUSIC_NOTIFICATION = "MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION"
var_0_0.CALLBACK_DIC = {
	startCall = function(arg_1_0)
		return
	end,
	progressCall = function(arg_2_0)
		return
	end,
	noPlayCall = function()
		return
	end
}

function var_0_0.Ctor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:ChangeData(arg_4_1)

	arg_4_0.callbackDic = arg_4_2

	arg_4_0:Reflush(arg_4_1.index)

	return
end

function var_0_0.ChangeData(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		arg_5_0[iter_5_0] = iter_5_1
	end

	return
end

function var_0_0.Reflush(arg_6_0, arg_6_1)
	arg_6_0.finishDic = {}
	arg_6_0.list = arg_6_0.list or getProxy(AppreciateProxy):getAlbumMusicList(arg_6_0.albumName)
	arg_6_0.count = #arg_6_0.list

	if arg_6_0.count == 0 then
		pg.TipsMgr.GetInstance():ShowTips("this album without any song")
		existCall(arg_6_0.callbackDic.noPlayCall)
		pg.m02:sendNotification(MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION)

		return
	end

	if not arg_6_1 then
		switch(arg_6_0.loopType, {
			one = function()
				arg_6_0.index = 1

				return
			end,
			list = function()
				arg_6_0.index = 1

				return
			end,
			random = function()
				arg_6_0.index = math.random(arg_6_0.count)

				return
			end
		})
	end

	arg_6_0:Play()

	return
end

function var_0_0.Play(arg_10_0)
	arg_10_0.cacheMusicName = pg.music_collect_config[arg_10_0.list[arg_10_0.index]].music

	onNextTick(function()
		local var_11_0 = CueData.GetCueData()

		var_11_0.channelName = pg.CriMgr.C_GALLERY_MUSIC
		var_11_0.cueSheetName = var_0
		var_11_0.cueName = ""

		CriWareMgr.Inst:PlaySound(var_11_0, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_12_0)
			arg_10_0.playbackInfo = arg_12_0

			arg_10_0.playbackInfo:SetIgnoreAutoUnload(true)

			arg_10_0.finishDic[arg_10_0.index] = true

			existCall(arg_10_0.callbackDic.startCall, arg_10_0.playbackInfo:GetLength())

			if not arg_10_0.timer then
				arg_10_0.timer = Timer.New(function()
					if not arg_10_0.playbackInfo then
						return
					end

					existCall(arg_10_0.callbackDic.progressCall, arg_10_0.playbackInfo:GetTime())

					if arg_10_0.playbackInfo.playback:GetStatus():ToInt() == 3 then
						arg_10_0:Finish()
					end

					return
				end, 0.033, -1)

				arg_10_0.timer:Start()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.Stop(arg_14_0)
	if not arg_14_0.playbackInfo then
		return
	end

	arg_14_0.playbackInfo:SetStartTime(0)
	arg_14_0.playbackInfo:SetIgnoreAutoUnload(false)

	local var_14_0 = CueData.GetCueData()

	var_14_0.channelName = pg.CriMgr.C_GALLERY_MUSIC
	var_14_0.cueSheetName = arg_14_0.cacheMusicName
	var_14_0.cueName = ""

	CriWareMgr.Inst:StopSound(var_14_0, CriWareMgr.CRI_FADE_TYPE.NONE)

	arg_14_0.playbackInfo = nil

	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end

	return
end

function var_0_0.Finish(arg_15_0, arg_15_1)
	arg_15_0:Stop()

	if table.getCount(arg_15_0.finishDic) < arg_15_0.count then
		switch(arg_15_0.loopType, {
			one = function()
				arg_15_0.index = arg_15_0.index

				return
			end,
			list = function()
				arg_15_1 = arg_15_1 or 1
				arg_15_0.index = (arg_15_0.index + arg_15_1 - 1) % arg_15_0.count + 1

				return
			end,
			random = function()
				local var_18_0 = underscore.filter(underscore.keys(arg_15_0.list), function(arg_19_0)
					return not arg_15_0.finishDic[arg_19_0]
				end)

				arg_15_0.index = var_18_0[math.random(#var_18_0)]

				return
			end
		})
		arg_15_0:Play()
	else
		arg_15_0.list = nil

		arg_15_0:Reflush()
	end

	return
end

function var_0_0.Next(arg_20_0)
	arg_20_0:Finish(1)

	return
end

function var_0_0.Last(arg_21_0)
	arg_21_0:Finish(-1)

	return
end

function var_0_0.SetProgress(arg_22_0, arg_22_1)
	if not arg_22_0.playbackInfo then
		return
	end

	arg_22_0.progress = arg_22_1

	if not arg_22_0.playbackInfo.playback:IsPaused() then
		arg_22_0:Resume()
	end

	return
end

function var_0_0.Resume(arg_23_0)
	if not arg_23_0.playbackInfo then
		return
	end

	if arg_23_0.progress then
		arg_23_0.playbackInfo:SetStartTimeAndPlay(arg_23_0.progress)
	else
		arg_23_0.playbackInfo.playback:Resume(CriWare.CriAtomEx.ResumeMode.PausedPlayback)
	end

	arg_23_0.progress = nil

	arg_23_0.timer:Resume()

	return
end

function var_0_0.Pause(arg_24_0)
	if not arg_24_0.playbackInfo then
		return
	end

	arg_24_0.playbackInfo.playback:Pause()
	arg_24_0.timer:Pause()

	return
end

function var_0_0.IsPaused(arg_25_0)
	if not arg_25_0.playbackInfo then
		return
	end

	return arg_25_0.playbackInfo.playback:IsPaused()
end

function var_0_0.GetCurrentMusicId(arg_26_0)
	return arg_26_0.list[arg_26_0.index]
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:Stop()

	return
end

return var_0_0
