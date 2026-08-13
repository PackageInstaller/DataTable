class = var_0_10000

local var_0_0 = var_0_10000("MusicPlayer")

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
	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		arg_5_0[iter_5_0] = iter_5_1
	end

	return
end

function var_0_0.Reflush(arg_6_0, arg_6_1)
	arg_6_0.finishDic = {}

	if not arg_6_0.list then
		getProxy = var_2
		AppreciateProxy = var_1_10003

		local var_6_0 = var_2(var_1_10003)

		arg_6_0.list = var_2.getAlbumMusicList(var_6_0, arg_6_0.albumName)
	end

	arg_6_0.count = #arg_6_0.list

	local var_6_3

	if arg_6_0.count == 0 then
		pg = var_6_3

		local var_6_1 = var_6_3.TipsMgr.GetInstance()

		var_6_3.ShowTips(var_6_1, "this album without any song")

		existCall = var_6_3

		var_6_3(arg_6_0.callbackDic.noPlayCall)

		pg = var_6_3

		local var_6_2 = var_6_3.m02

		var_6_3 = var_6_3.sendNotification
		MusicPlayer = var_4

		var_6_3(var_6_2, var_4.NO_PLAY_MUSIC_NOTIFICATION)

		return
	end

	if not arg_6_1 then
		switch = var_6_3

		var_6_3(arg_6_0.loopType, {
			one = function()
				arg_6_0.index = 1

				return
			end,
			list = function()
				arg_6_0.index = 1

				return
			end,
			random = function()
				local var_9_0 = arg_6_0

				math = var_2_10001
				var_9_0.index = var_2_10001.random(arg_6_0.count)

				return
			end
		})
	end

	arg_6_0:Play()

	return
end

function var_0_0.Play(arg_10_0)
	pg = var_1_10001
	arg_10_0.cacheMusicName = var_1_10001.music_collect_config[arg_10_0.list[arg_10_0.index]].music
	onNextTick = var_2

	var_2(function()
		CueData = var_2_10000

		local var_11_0 = var_2_10000.GetCueData()

		pg = var_2_10001
		var_11_0.channelName = var_2_10001.CriMgr.C_GALLERY_MUSIC
		var_11_0.cueSheetName = var_0
		var_11_0.cueName = ""
		CriWareMgr = var_1

		local var_11_1 = var_1.Inst
		local var_11_2 = var_1.PlaySound
		local var_11_3 = var_11_0

		CriWareMgr = var_2_10004

		var_11_2(var_11_1, var_11_3, var_2_10004.CRI_FADE_TYPE.FADE_INOUT, function(arg_12_0)
			arg_10_0.playbackInfo = arg_12_0

			local var_12_0 = arg_10_0.playbackInfo

			var_1.SetIgnoreAutoUnload(var_12_0, true)

			local var_12_1 = arg_10_0.finishDic

			var_12_1[arg_10_0.index] = true
			existCall = var_12_1

			local var_12_2 = arg_10_0.callbackDic.startCall
			local var_12_3 = arg_10_0.playbackInfo

			var_12_1(var_12_2, var_3.GetLength(var_12_3))

			if not arg_10_0.timer then
				local var_12_4 = arg_10_0

				Timer = var_12_2
				var_12_4.timer = var_12_2.New(function()
					if not arg_10_0.playbackInfo then
						return
					end

					existCall = var_0

					local var_13_0 = arg_10_0.callbackDic.progressCall
					local var_13_1 = arg_10_0.playbackInfo

					var_0(var_13_0, var_2.GetTime(var_13_1))

					local var_13_2 = arg_10_0.playbackInfo.playback
					local var_13_3 = var_0.GetStatus(var_13_2)

					if var_0.ToInt(var_13_3) == 3 then
						local var_13_4 = arg_10_0

						var_0.Finish(var_13_4)
					end

					return
				end, 0.033, -1)

				local var_12_5 = arg_10_0.timer

				var_1.Start(var_12_5)
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

	local var_14_0 = arg_14_0.playbackInfo

	var_1.SetStartTime(var_14_0, 0)

	local var_14_1 = arg_14_0.playbackInfo

	var_1.SetIgnoreAutoUnload(var_14_1, false)

	CueData = var_1

	local var_14_2 = var_1.GetCueData()

	pg = var_14_1
	var_14_2.channelName = var_14_1.CriMgr.C_GALLERY_MUSIC
	var_14_2.cueSheetName = arg_14_0.cacheMusicName
	var_14_2.cueName = ""
	CriWareMgr = var_2

	local var_14_3 = var_2.Inst
	local var_14_4 = var_2.StopSound
	local var_14_5 = var_14_2

	CriWareMgr = var_1_10005

	var_14_4(var_14_3, var_14_5, var_1_10005.CRI_FADE_TYPE.NONE)

	arg_14_0.playbackInfo = nil

	if arg_14_0.timer then
		local var_14_6 = arg_14_0.timer

		var_2.Stop(var_14_6)

		arg_14_0.timer = nil
	end

	return
end

function var_0_0.Finish(arg_15_0, arg_15_1)
	arg_15_0:Stop()

	table = var_2

	if var_2.getCount(arg_15_0.finishDic) < arg_15_0.count then
		switch = var_2

		var_2(arg_15_0.loopType, {
			one = function()
				arg_15_0.index = arg_15_0.index

				return
			end,
			list = function()
				local var_17_0

				if not arg_15_1 then
					var_17_0 = 1
				end

				arg_15_1 = var_17_0
				arg_15_0.index = (arg_15_0.index + arg_15_1 - 1) % arg_15_0.count + 1

				return
			end,
			random = function()
				underscore = var_2_10000

				local var_18_0 = var_2_10000.filter

				underscore = var_2_10001

				local var_18_1 = var_18_0(var_2_10001.keys(arg_15_0.list), function(arg_19_0)
					return not arg_15_0.finishDic[arg_19_0]
				end)
				local var_18_2 = arg_15_0

				math = var_2
				var_18_2.index = var_18_1[var_2.random(#var_18_1)]

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

	local var_22_0 = arg_22_0.playbackInfo.playback

	if not var_2.IsPaused(var_22_0) then
		arg_22_0:Resume()
	end

	return
end

function var_0_0.Resume(arg_23_0)
	if not arg_23_0.playbackInfo then
		return
	end

	if arg_23_0.progress then
		local var_23_0 = arg_23_0.playbackInfo

		var_1.SetStartTimeAndPlay(var_23_0, arg_23_0.progress)
	else
		local var_23_1 = arg_23_0.playbackInfo.playback
		local var_23_2 = var_1.Resume

		CriWare = var_1_10003

		var_23_2(var_23_1, var_1_10003.CriAtomEx.ResumeMode.PausedPlayback)
	end

	arg_23_0.progress = nil

	local var_23_3 = arg_23_0.timer

	var_1.Resume(var_23_3)

	return
end

function var_0_0.Pause(arg_24_0)
	if not arg_24_0.playbackInfo then
		return
	end

	local var_24_0 = arg_24_0.playbackInfo.playback

	var_1.Pause(var_24_0)

	local var_24_1 = arg_24_0.timer

	var_1.Pause(var_24_1)

	return
end

function var_0_0.IsPaused(arg_25_0)
	if not arg_25_0.playbackInfo then
		return
	end

	local var_25_0 = arg_25_0.playbackInfo.playback

	return var_1.IsPaused(var_25_0)
end

function var_0_0.GetCurrentMusicId(arg_26_0)
	return arg_26_0.list[arg_26_0.index]
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:Stop()

	return
end

return var_0_0
