local var_0_0 = class("MusicBeatBgmCtrl")

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

	arg_3_0.nodeData = arg_3_0._gameVo:getNodeData()

	arg_3_0:loadAndPlayMusic(arg_3_0.nodeData.music_name, 0)

	return
end

function var_0_0.start(arg_4_0)
	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	if arg_5_0.criInfo and arg_5_0.criInfo:GetTime() >= arg_5_0.criInfo:GetLength() then
		arg_5_0._event:emit(MusicBeatGameEvent.GAME_OVER)
	end

	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.criInfo then
		pg.CriMgr.GetInstance():UnloadCueSheet(arg_6_0.nodeData.music_name)
		arg_6_0.criInfo:PlaybackStop()
	end

	arg_6_0.criInfo = nil

	arg_6_0._gameVo:setBgmPlay(false)
	arg_6_0._gameVo:setCriInfo(nil)

	return
end

function var_0_0.stop(arg_7_0)
	arg_7_0:stopMusic()

	return
end

function var_0_0.resume(arg_8_0)
	local var_8_0 = arg_8_0.pauseTime or 0

	arg_8_0:loadAndPlayMusic(arg_8_0.nodeData.music_name, var_8_0)

	return
end

function var_0_0.loadAndPlayMusic(arg_9_0, arg_9_1, arg_9_2)
	CriWareMgr.Inst:PlayBGM(arg_9_1, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_10_0)
		if arg_10_0 == nil then
			local var_10_0 = arg_9_1 or "NIL"

			warning("Missing BGM :" .. var_10_0)
		else
			print("加载完毕,开始播放音乐")

			if arg_9_0.countingfive_flag then
				return
			end

			arg_9_0.criInfo = arg_10_0
			arg_9_0.cirInfoLength = arg_10_0:GetLength()

			arg_9_0.criInfo:PlaybackStop()
			arg_9_0.criInfo:SetStartTimeAndPlay(arg_9_2)
			arg_9_0._gameVo:setCriInfo(arg_10_0)
			arg_9_0._gameVo:setBgmPlay(true)
		end

		return
	end)

	return
end

function var_0_0.stopMusic(arg_11_0)
	if arg_11_0.criInfo then
		arg_11_0.pauseTime = arg_11_0.criInfo:GetTime()

		arg_11_0.criInfo:PlaybackStop()
		arg_11_0._gameVo:setBgmPlay(false)
	else
		print("cri info不存在")
	end

	return
end

function var_0_0.dispose(arg_12_0)
	if arg_12_0.criInfo then
		pg.CriMgr.GetInstance():UnloadCueSheet(arg_12_0.nodeData.music_name)
	end

	return
end

return var_0_0
