local MusicBeatBgmCtrl = class("MusicBeatBgmCtrl")

function MusicBeatBgmCtrl:Ctor(arg_1_1)
	self._event = arg_1_1

	return
end

function MusicBeatBgmCtrl:setGameVo(arg_2_1)
	self._gameVo = arg_2_1

	return
end

function MusicBeatBgmCtrl:readyStart()
	self:clear()

	self.nodeData = self._gameVo:getNodeData()

	self:loadAndPlayMusic(self.nodeData.music_name, 0)

	return
end

function MusicBeatBgmCtrl:start()
	return
end

function MusicBeatBgmCtrl:step(arg_5_1)
	if self.criInfo and self.criInfo:GetTime() >= self.criInfo:GetLength() then
		self._event:emit(MusicBeatGameEvent.GAME_OVER)
	end

	return
end

function MusicBeatBgmCtrl:clear()
	if self.criInfo then
		pg.CriMgr.GetInstance():UnloadCueSheet(self.nodeData.music_name)
		self.criInfo:PlaybackStop()
	end

	self.criInfo = nil

	self._gameVo:setBgmPlay(false)
	self._gameVo:setCriInfo(nil)

	return
end

function MusicBeatBgmCtrl:stop()
	self:stopMusic()

	return
end

function MusicBeatBgmCtrl:resume()
	self:loadAndPlayMusic(self.nodeData.music_name, self.pauseTime or 0)

	return
end

function MusicBeatBgmCtrl:loadAndPlayMusic(arg_9_1, arg_9_2)
	CriWareMgr.Inst:PlayBGM(arg_9_1, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_10_0)
		if arg_10_0 == nil then
			warning("Missing BGM :" .. (arg_9_1 or "NIL"))
		else
			print("加载完毕,开始播放音乐")

			if self.countingfive_flag then
				return
			end

			self.criInfo = arg_10_0
			self.cirInfoLength = arg_10_0:GetLength()

			self.criInfo:PlaybackStop()
			self.criInfo:SetStartTimeAndPlay(arg_9_2)
			self._gameVo:setCriInfo(arg_10_0)
			self._gameVo:setBgmPlay(true)
		end

		return
	end)

	return
end

function MusicBeatBgmCtrl:stopMusic()
	if self.criInfo then
		self.pauseTime = self.criInfo:GetTime()

		self.criInfo:PlaybackStop()
		self._gameVo:setBgmPlay(false)
	else
		print("cri info不存在")
	end

	return
end

function MusicBeatBgmCtrl:dispose()
	if self.criInfo then
		pg.CriMgr.GetInstance():UnloadCueSheet(self.nodeData.music_name)
	end

	return
end

return MusicBeatBgmCtrl
