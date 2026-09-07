local MusicPlayer = class("MusicPlayer")

MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION = "MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION"
MusicPlayer.CALLBACK_DIC = {
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

function MusicPlayer:Ctor(arg_4_1, arg_4_2)
	self:ChangeData(arg_4_1)

	self.callbackDic = arg_4_2

	self:Reflush(arg_4_1.index)

	return
end

function MusicPlayer:ChangeData(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		self[iter_5_0] = iter_5_1
	end

	return
end

function MusicPlayer:Reflush(arg_6_1)
	self.finishDic = {}
	self.list = self.list or getProxy(AppreciateProxy):getAlbumMusicList(self.albumName)
	self.count = #self.list

	if self.count == 0 then
		pg.TipsMgr.GetInstance():ShowTips("this album without any song")
		existCall(self.callbackDic.noPlayCall)
		pg.m02:sendNotification(MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION)

		return
	end

	if not arg_6_1 then
		switch(self.loopType, {
			one = function()
				self.index = 1

				return
			end,
			list = function()
				self.index = 1

				return
			end,
			random = function()
				self.index = math.random(self.count)

				return
			end
		})
	end

	self:Play()

	return
end

function MusicPlayer:Play()
	local var_10_0 = pg.music_collect_config[self.list[self.index]].music

	self.cacheMusicName = pg.music_collect_config[self.list[self.index]].music

	onNextTick(function()
		local var_11_0 = CueData.GetCueData()

		var_11_0.channelName = pg.CriMgr.C_GALLERY_MUSIC
		var_11_0.cueSheetName = var_10_0
		var_11_0.cueName = ""

		CriWareMgr.Inst:PlaySound(var_11_0, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_12_0)
			self.playbackInfo = arg_12_0

			self.playbackInfo:SetIgnoreAutoUnload(true)

			self.finishDic[self.index] = true

			existCall(self.callbackDic.startCall, self.playbackInfo:GetLength())

			if not self.timer then
				self.timer = Timer.New(function()
					if not self.playbackInfo then
						return
					end

					existCall(self.callbackDic.progressCall, self.playbackInfo:GetTime())

					if self.playbackInfo.playback:GetStatus():ToInt() == 3 then
						self:Finish()
					end

					return
				end, 0.033, -1)

				self.timer:Start()
			end

			return
		end)

		return
	end)

	return
end

function MusicPlayer:Stop()
	if not self.playbackInfo then
		return
	end

	self.playbackInfo:SetStartTime(0)
	self.playbackInfo:SetIgnoreAutoUnload(false)

	local var_14_0 = CueData.GetCueData()

	var_14_0.channelName = pg.CriMgr.C_GALLERY_MUSIC
	var_14_0.cueSheetName = self.cacheMusicName
	var_14_0.cueName = ""

	CriWareMgr.Inst:StopSound(var_14_0, CriWareMgr.CRI_FADE_TYPE.NONE)

	self.playbackInfo = nil

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MusicPlayer:Finish(arg_15_1)
	self:Stop()

	if table.getCount(self.finishDic) < self.count then
		switch(self.loopType, {
			one = function()
				self.index = self.index

				return
			end,
			list = function()
				arg_15_1 = arg_15_1 or 1
				self.index = (self.index + arg_15_1 - 1) % self.count + 1

				return
			end,
			random = function()
				local var_18_0 = underscore.filter(underscore.keys(self.list), function(arg_19_0)
					return not self.finishDic[arg_19_0]
				end)

				self.index = var_18_0[math.random(#var_18_0)]

				return
			end
		})
		self:Play()
	else
		self.list = nil

		self:Reflush()
	end

	return
end

function MusicPlayer:Next()
	self:Finish(1)

	return
end

function MusicPlayer:Last()
	self:Finish(-1)

	return
end

function MusicPlayer:SetProgress(arg_22_1)
	if not self.playbackInfo then
		return
	end

	self.progress = arg_22_1

	if not self.playbackInfo.playback:IsPaused() then
		self:Resume()
	end

	return
end

function MusicPlayer:Resume()
	if not self.playbackInfo then
		return
	end

	if self.progress then
		self.playbackInfo:SetStartTimeAndPlay(self.progress)
	else
		self.playbackInfo.playback:Resume(CriWare.CriAtomEx.ResumeMode.PausedPlayback)
	end

	self.progress = nil

	self.timer:Resume()

	return
end

function MusicPlayer:Pause()
	if not self.playbackInfo then
		return
	end

	self.playbackInfo.playback:Pause()
	self.timer:Pause()

	return
end

function MusicPlayer:IsPaused()
	if not self.playbackInfo then
		return
	end

	return self.playbackInfo.playback:IsPaused()
end

function MusicPlayer:GetCurrentMusicId()
	return self.list[self.index]
end

function MusicPlayer:Dispose()
	self:Stop()

	return
end

return MusicPlayer
