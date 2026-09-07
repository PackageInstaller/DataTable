local CryptolaliaSoundPlayer = class("CryptolaliaSoundPlayer")

function CryptolaliaSoundPlayer:Ctor(arg_1_1)
	return
end

function CryptolaliaSoundPlayer:Load(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.preCvCueSheetName == arg_2_1 then
		self:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	else
		self:Unload()
		pg.CriMgr.GetInstance():LoadCueSheet(arg_2_1, function(arg_3_0)
			self.preCvCueSheetName = arg_2_1

			if arg_3_0 then
				self:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
			else
				arg_2_4(-1)
			end

			return
		end)
	end

	return
end

function CryptolaliaSoundPlayer:Play(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:Stop()

	local function var_4_0()
		pg.CriMgr.GetInstance():PlayCV_V3(arg_4_1, arg_4_2, function(arg_6_0)
			if arg_6_0 then
				self._currentVoice = arg_6_0.playback

				arg_4_4(arg_6_0:GetLength() * 0.001)
			else
				arg_4_4(-1)
			end

			return
		end)

		return
	end

	if (arg_4_3 or 0) <= 0 then
		var_4_0()
	else
		self.timer = Timer.New(var_4_0, arg_4_3, 1)

		self.timer:Start()
	end

	return
end

function CryptolaliaSoundPlayer:Stop()
	self:RemoveTimer()

	if self._currentVoice then
		self._currentVoice:Stop(true)
	end

	return
end

function CryptolaliaSoundPlayer:Unload()
	self:Stop()

	if self.preCvCueSheetName then
		pg.CriMgr.GetInstance():UnloadCueSheet(self.preCvCueSheetName)

		self.preCvCueSheetName = nil
	end

	return
end

function CryptolaliaSoundPlayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CryptolaliaSoundPlayer:Dispose()
	self:Unload()

	return
end

return CryptolaliaSoundPlayer
