local ShipProfileCVLoader = class("ShipProfileCVLoader")

function ShipProfileCVLoader:Ctor()
	self.loadedCVBankName = nil
	self.loadedCVBattleBankName = nil
	self.playbackInfo = nil
	self.timers = {}

	return
end

function ShipProfileCVLoader:Load(arg_2_1)
	self:ClearSound()

	if ShipWordHelper.ExistVoiceKey(arg_2_1) then
		self:SetUp((ShipWordHelper.RawGetCVKey(arg_2_1)))
	end

	return
end

function ShipProfileCVLoader:SetUp(arg_3_1)
	seriesAsync({
		function(arg_5_0)
			pg.CriMgr.GetInstance():LoadCV(arg_3_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			pg.CriMgr.GetInstance():LoadBattleCV(arg_3_1, arg_6_0)

			return
		end
	}, function()
		local var_4_0 = pg.CriMgr.GetCVBankName(arg_3_1)
		local var_4_1 = pg.CriMgr.GetBattleCVBankName(arg_3_1)

		if self.exited then
			pg.CriMgr.UnloadCVBank(var_4_0)
			pg.CriMgr.UnloadCVBank(var_4_1)
		else
			self.loadedCVBankName = var_4_0
			self.loadedCVBattleBankName = var_4_1
		end

		return
	end)

	return
end

function ShipProfileCVLoader:PlaySound(arg_7_1, arg_7_2)
	if not self.playbackInfo or arg_7_1 ~= self.prevCvPath or self.playbackInfo.channelPlayer == nil then
		self:StopSound()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_7_1, function(arg_8_0)
			if arg_8_0 then
				self.playbackInfo = arg_8_0

				self.playbackInfo:SetIgnoreAutoUnload(true)

				if arg_7_2 then
					arg_7_2(self.playbackInfo.cueInfo)
				end
			elseif arg_7_2 then
				arg_7_2()
			end

			return
		end)

		self.prevCvPath = arg_7_1

		if self.playbackInfo == nil then
			return nil
		end

		return self.playbackInfo.cueInfo
	elseif self.playbackInfo then
		self.playbackInfo:PlaybackStop()
		self.playbackInfo:SetStartTimeAndPlay()

		if arg_7_2 then
			arg_7_2(self.playbackInfo.cueInfo)
		end

		return self.playbackInfo.cueInfo
	elseif arg_7_2 then
		arg_7_2()
	end

	return nil
end

function ShipProfileCVLoader:DelayPlaySound(arg_9_1, arg_9_2, arg_9_3)
	self:RemoveTimer(arg_9_1)

	if arg_9_2 > 0 then
		self.timers[arg_9_1] = Timer.New(function()
			local var_10_0 = self:PlaySound(arg_9_1, function(arg_11_0)
				if arg_9_3 then
					arg_9_3(arg_11_0)
				end

				return
			end)

			return
		end, arg_9_2, 1)

		self.timers[arg_9_1]:Start()
	else
		local var_9_0 = self:PlaySound(arg_9_1, function(arg_12_0)
			if arg_9_3 then
				arg_9_3(arg_12_0)
			end

			return
		end)
	end

	return
end

function ShipProfileCVLoader:RawPlaySound(arg_13_1, arg_13_2)
	self:RemoveTimer(arg_13_1)

	if arg_13_2 > 0 then
		self.timers[arg_13_1] = Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_13_1)

			return
		end, arg_13_2, 1)

		self.timers[arg_13_1]:Start()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_13_1)
	end

	return
end

function ShipProfileCVLoader:RemoveTimer(arg_15_1)
	if self.timers[arg_15_1] then
		self.timers[arg_15_1]:Stop()

		self.timers[arg_15_1] = nil
	end

	return
end

function ShipProfileCVLoader:StopSound()
	if self.playbackInfo then
		pg.CriMgr.GetInstance():StopPlaybackInfoForce(self.playbackInfo)
		self.playbackInfo:SetIgnoreAutoUnload(false)
	end

	return
end

function ShipProfileCVLoader:Unload()
	if self.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBankName)

		self.loadedCVBankName = nil
	end

	if self.loadedCVBattleBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBattleBankName)

		self.loadedCVBattleBankName = nil
	end

	return
end

function ShipProfileCVLoader:ClearSound()
	self:StopSound()
	self:Unload()

	if self.playbackInfo then
		self.playbackInfo:Dispose()

		self.playbackInfo = nil
	end

	return
end

function ShipProfileCVLoader:Dispose()
	self:ClearSound()

	self.exited = true

	for iter_19_0, iter_19_1 in pairs(self.timers) do
		iter_19_1:Stop()
	end

	self.timers = nil

	return
end

return ShipProfileCVLoader
