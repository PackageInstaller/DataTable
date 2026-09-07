local MainCVLoader = class("MainCVLoader")

function MainCVLoader:Ctor(arg_1_1)
	return
end

function MainCVLoader:Load(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.preCvCueSheetName == arg_2_1 then
		self:Play(arg_2_2, arg_2_3, arg_2_4)
	else
		self:Unload()
		pg.CriMgr.GetInstance():LoadCueSheet(arg_2_1, function(arg_3_0)
			self.preCvCueSheetName = arg_2_1

			if arg_3_0 then
				self:Play(arg_2_2, arg_2_3, arg_2_4)
			else
				arg_2_4(-1)
			end

			return
		end)
	end

	return
end

function MainCVLoader:preloadCv(arg_4_1, arg_4_2)
	pg.CriMgr.GetInstance():LoadCueSheet(arg_4_1, function(arg_5_0)
		if arg_4_2 then
			arg_4_2()
		end

		return
	end)

	return
end

function MainCVLoader:Play(arg_6_1, arg_6_2, arg_6_3)
	self:Stop()

	local function var_6_0()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_6_1, function(arg_8_0)
			if arg_8_0 then
				self._currentVoice = arg_8_0.playback

				arg_6_3(arg_8_0:GetLength() * 0.001)
			else
				arg_6_3(-1)
			end

			return
		end)

		return
	end

	if (arg_6_2 or 0) <= 0 then
		var_6_0()
	else
		self.timer = Timer.New(var_6_0, arg_6_2, 1)

		self.timer:Start()
	end

	return
end

function MainCVLoader:Stop()
	self:RemoveTimer()

	if self._currentVoice then
		self._currentVoice:Stop(true)
	end

	return
end

function MainCVLoader:Unload()
	self:Stop()

	if self.preCvCueSheetName then
		pg.CriMgr.GetInstance():UnloadCueSheet(self.preCvCueSheetName)

		self.preCvCueSheetName = nil
	end

	return
end

function MainCVLoader:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainCVLoader:Dispose()
	self:Unload()

	return
end

return MainCVLoader
