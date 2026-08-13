class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatBgmCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._event = arg_1_1

	return
end

function var_0_0.setGameVo(arg_2_0, arg_2_1)
	arg_2_0._gameVo = arg_2_1

	return
end

function var_0_0.readyStart(arg_3_0)
	arg_3_0:clear()

	local var_3_0 = arg_3_0._gameVo

	arg_3_0.nodeData = var_1.getNodeData(var_3_0)

	arg_3_0:loadAndPlayMusic(arg_3_0.nodeData.music_name, 0)

	return
end

function var_0_0.start(arg_4_0)
	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	if arg_5_0.criInfo then
		local var_5_0 = arg_5_0.criInfo
		local var_5_1 = var_2.GetTime(var_5_0)
		local var_5_2 = arg_5_0.criInfo

		if var_5_1 >= var_3.GetLength(var_5_2) then
			local var_5_3 = arg_5_0._event
			local var_5_4 = var_4.emit

			MusicBeatGameEvent = var_1_10006

			var_5_4(var_5_3, var_1_10006.GAME_OVER)
		end
	end

	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.criInfo then
		pg = var_1

		local var_6_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadCueSheet(var_6_0, arg_6_0.nodeData.music_name)

		local var_6_1 = arg_6_0.criInfo

		var_1.PlaybackStop(var_6_1)
	end

	arg_6_0.criInfo = nil

	local var_6_2 = arg_6_0._gameVo

	var_1.setBgmPlay(var_6_2, false)

	local var_6_3 = arg_6_0._gameVo

	var_1.setCriInfo(var_6_3, nil)

	return
end

function var_0_0.stop(arg_7_0)
	arg_7_0:stopMusic()

	return
end

function var_0_0.resume(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.loadAndPlayMusic
	local var_8_2 = arg_8_0.nodeData.music_name
	local var_8_3

	if not arg_8_0.pauseTime then
		var_8_3 = 0
	end

	var_8_1(var_8_0, var_8_2, var_8_3)

	return
end

function var_0_0.loadAndPlayMusic(arg_9_0, arg_9_1, arg_9_2)
	CriWareMgr = var_1_10003

	local var_9_0 = var_1_10003.Inst
	local var_9_1 = var_3.PlayBGM
	local var_9_2 = arg_9_1

	CriWareMgr = var_1_10006

	var_9_1(var_9_0, var_9_2, var_1_10006.CRI_FADE_TYPE.FADE_INOUT, function(arg_10_0)
		if arg_10_0 == nil then
			warning = var_2_10001

			local var_10_0 = "Missing BGM :"
			local var_10_1

			if not arg_9_1 then
				var_10_1 = "NIL"
			end

			var_2_10001(var_10_0 .. var_10_1)
		else
			print = var_2_10001

			var_2_10001("加载完毕,开始播放音乐")

			if arg_9_0.countingfive_flag then
				return
			end

			arg_9_0.criInfo = arg_10_0
			arg_9_0.cirInfoLength = arg_10_0:GetLength()

			local var_10_2 = arg_9_0.criInfo

			var_1.PlaybackStop(var_10_2)

			local var_10_3 = arg_9_0.criInfo

			var_1.SetStartTimeAndPlay(var_10_3, arg_9_2)

			local var_10_4 = arg_9_0._gameVo

			var_1.setCriInfo(var_10_4, arg_10_0)

			local var_10_5 = arg_9_0._gameVo

			var_1.setBgmPlay(var_10_5, true)
		end

		return
	end)

	return
end

function var_0_0.stopMusic(arg_11_0)
	if arg_11_0.criInfo then
		local var_11_0 = arg_11_0.criInfo

		arg_11_0.pauseTime = var_1.GetTime(var_11_0)

		local var_11_1 = arg_11_0.criInfo

		var_1.PlaybackStop(var_11_1)

		local var_11_2 = arg_11_0._gameVo

		var_1.setBgmPlay(var_11_2, false)
	else
		print = var_1

		var_1("cri info不存在")
	end

	return
end

function var_0_0.dispose(arg_12_0)
	if arg_12_0.criInfo then
		pg = var_1

		local var_12_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadCueSheet(var_12_0, arg_12_0.nodeData.music_name)
	end

	return
end

return var_0_0
