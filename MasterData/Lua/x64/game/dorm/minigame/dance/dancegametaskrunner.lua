local DanceGameTaskRunner = class("DanceGameTaskRunner", DormTaskRunner)

function DanceGameTaskRunner:Ctor()
	DanceGameTaskRunner.super.Ctor(self)

	self.offset = 0
end

function DanceGameTaskRunner:SetPlayback(arg_2_1)
	self.playSrc = arg_2_1
	self.offset = 0
end

function DanceGameTaskRunner:Time()
	if self.playSrc == nil then
		return 0
	end

	local var_3_2, var_3_3 = int64.tonum2(self.playSrc:GetTimeSyncedWithAudio())
	local var_3_4 = var_3_2 + self.offset

	if self.lastUpdate and var_3_4 < self.lastUpdate then
		local var_3_5, var_3_6 = int64.tonum2(self.playSrc:GetTime())

		var_3_4 = var_3_5
		self.offset = var_3_5 - var_3_4
	end

	return var_3_4 / 1000
end

function DanceGameTaskRunner:Reset()
	self.playSrc = nil
	self.offset = 0

	DanceGameTaskRunner.super.Reset(self)
end

return DanceGameTaskRunner
