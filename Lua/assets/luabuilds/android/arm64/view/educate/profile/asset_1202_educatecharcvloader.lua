local EducateCharCvLoader = class("EducateCharCvLoader")

function EducateCharCvLoader:Play(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self:Stop()

	local function var_1_0()
		pg.CriMgr.GetInstance():PlayCV_V3(arg_1_2, arg_1_1, function(arg_3_0)
			if arg_3_0 then
				self._currentVoice = arg_3_0.playback

				arg_1_4(arg_3_0:GetLength() * 0.001)
			else
				arg_1_4(-1)
			end

			return
		end)

		return
	end

	if (arg_1_3 or 0) <= 0 then
		var_1_0()
	else
		self.timer = Timer.New(var_1_0, arg_1_3, 1)

		self.timer:Start()
	end

	return
end

function EducateCharCvLoader:Stop()
	self:RemoveTimer()

	if self._currentVoice then
		self._currentVoice:Stop(true)
	end

	return
end

function EducateCharCvLoader:Unload()
	self:Stop()

	return
end

function EducateCharCvLoader:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function EducateCharCvLoader:Dispose()
	self:Unload()

	return
end

return EducateCharCvLoader
