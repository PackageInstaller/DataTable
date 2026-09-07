pg = pg or {}

local var_0_0 = pg

pg.BgmMgr = singletonClass("BgmMgr")

function pg.BgmMgr.Ctor(arg_1_0)
	return
end

function pg.BgmMgr:Init(arg_2_1)
	print("initializing bgm manager...")
	self:Clear()
	arg_2_1()

	return
end

function pg.BgmMgr.Clear(arg_3_0)
	arg_3_0._stack = {}
	arg_3_0._dictionary = {}
	arg_3_0._musicData = {}
	arg_3_0._musicCallbackDic = {}

	return
end

function pg.BgmMgr:Push(arg_4_1, arg_4_2, arg_4_3)
	if not self._dictionary[arg_4_1] then
		table.insert(self._stack, arg_4_1)
	end

	self._dictionary[arg_4_1] = arg_4_2
	self._musicData[arg_4_1] = arg_4_3

	self:CheckPlay()

	return
end

function pg.BgmMgr:Pop(arg_5_1)
	if self._dictionary[arg_5_1] then
		table.removebyvalue(self._stack, arg_5_1)

		self._dictionary[arg_5_1] = nil
		self._musicData[arg_5_1] = nil

		self:CheckPlay()
	end

	return
end

function pg.BgmMgr:CheckPlay()
	if #self._stack == 0 then
		return
	end

	if self.isDirty or self._now ~= self._dictionary[self._stack[#self._stack]] then
		self._now = self._dictionary[self._stack[#self._stack]]
		self._nowData = self._musicData[self._stack[#self._stack]]

		self:ContinuePlay()
	end

	return
end

function pg.BgmMgr:TempPlay(arg_7_1, arg_7_2)
	self.isDirty = true

	self:FinalPlay(arg_7_1, arg_7_2)

	return
end

function pg.BgmMgr:StopPlay()
	self.isDirty = true

	self:FinalPause()

	return
end

function pg.BgmMgr:ContinuePlay()
	self.isDirty = false

	self:FinalPlay(self._now, self._nowData)

	return
end

function pg.BgmMgr:RegisterMusicCallback(arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in pairs(arg_10_3) do
		self._musicCallbackDic[iter_10_0] = self._musicCallbackDic[iter_10_0] or {}
		self._musicCallbackDic[iter_10_0][arg_10_2] = self._musicCallbackDic[iter_10_0][arg_10_2] or {}

		table.insert(self._musicCallbackDic[iter_10_0][arg_10_2], {
			iter_10_1,
			arg_10_1
		})
	end

	return
end

function pg.BgmMgr:UnregisterMusicCallback(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self._musicCallbackDic) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			for iter_11_4 = #iter_11_3, 1, -1 do
				if iter_11_3[iter_11_4][2] == arg_11_1 then
					table.remove(iter_11_3, iter_11_4)
				end
			end
		end
	end

	return
end

function pg.BgmMgr:GetNow()
	return self._now, self._nowData
end

function pg.BgmMgr.GetPlayType(arg_13_0, arg_13_1)
	return switch(arg_13_1, {
		MainMusicPlayer = function()
			return "music"
		end,
		TempMusicPlayer = function()
			return "music"
		end
	}, function()
		return "bgm"
	end)
end

function pg.BgmMgr:FinalPlay(arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = self:GetPlayType(arg_17_1)

	if self.playType and self.playType ~= var_17_0 then
		self:FinalPause()
	end

	self.playType = var_17_0

	if self.playType == "music" then
		switch(arg_17_1, {
			MainMusicPlayer = function()
				self:PlayMainMusicPlayer(arg_17_2, arg_17_1)

				return
			end,
			TempMusicPlayer = function()
				self:NewMusicPlayer(arg_17_2, arg_17_1)

				return
			end
		})
	elseif self.playType == "bgm" then
		var_0_0.CriMgr.GetInstance():PlayBGM(arg_17_1)
	end

	return
end

function pg.BgmMgr:FinalPause()
	if self.playType == "music" then
		self.musicPlayer:Pause()
	elseif self.playType == "bgm" then
		var_0_0.CriMgr.GetInstance():StopBGM()
	end

	return
end

function pg.BgmMgr:GetMusicPlayer()
	return self.musicPlayer
end

function pg.BgmMgr:PlayMainMusicPlayer(arg_22_1, arg_22_2)
	if self.musicPlayer and self.musicPlayer.music == arg_22_2 then
		self.musicPlayer:ChangeData(arg_22_1)

		self.musicPlayer.music = arg_22_2

		if self.musicPlayer:IsPaused() then
			self.musicPlayer:Resume()
		else
			self.musicPlayer:Reflush(self.musicPlayer.index)
		end

		return self.musicPlayer
	else
		return self:NewMusicPlayer(arg_22_1, arg_22_2)
	end

	return
end

function pg.BgmMgr:NewMusicPlayer(arg_23_1, arg_23_2)
	self:RemoveMusicPlayer()

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(MusicPlayer.CALLBACK_DIC) do
		var_23_0[iter_23_0] = function(...)
			for iter_24_0, iter_24_1 in ipairs(checkExist(self._musicCallbackDic, {
				iter_23_0
			}, {
				arg_23_2
			}) or {}) do
				iter_24_1[1](...)
			end

			return
		end
	end

	self.musicPlayer = MusicPlayer.New(arg_23_1, var_23_0)
	self.musicPlayer.music = arg_23_2

	return self.musicPlayer
end

function pg.BgmMgr:RemoveMusicPlayer()
	if not self.musicPlayer then
		return
	end

	self.musicPlayer:Dispose()

	self.musicPlayer = nil

	return
end

return
