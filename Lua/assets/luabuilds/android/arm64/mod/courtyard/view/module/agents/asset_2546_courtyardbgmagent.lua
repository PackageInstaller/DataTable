local CourtYardBGMAgent = class("CourtYardBGMAgent", import(".CourtYardAgent"))
local var_0_1 = 0
local var_0_2 = 1

function CourtYardBGMAgent:Ctor(arg_1_1)
	CourtYardBGMAgent.super.Ctor(self, arg_1_1)

	self.recoders = {}
	self.playName = nil
	self.waitForStop = false
	self.defaultBgm = self:GetDefaultBgm()

	self:PlayVoice(self.defaultBgm)

	return
end

function CourtYardBGMAgent:Play(arg_2_1, arg_2_2)
	if not arg_2_1 or arg_2_1 == "" then
		return
	end

	arg_2_2 = arg_2_2 or var_0_1

	if not self.recoders[arg_2_1] then
		self.recoders = {}

		self:PlayVoice(arg_2_1, function(arg_3_0)
			if arg_2_2 == var_0_2 then
				self:HandlePlayOnce(arg_3_0)
			end

			return
		end)
	end

	self.recoders[arg_2_1] = (self.recoders[arg_2_1] or 0) + 1

	return
end

function CourtYardBGMAgent:HandlePlayOnce(arg_4_1)
	self:AddTimerToStopBgm(long2int(arg_4_1.length) * 0.001)

	return
end

function CourtYardBGMAgent:AddTimerToStopBgm(arg_5_1)
	self.waitForStop = true
	self.timer = Timer.New(function()
		self:Reset()

		self.waitForStop = false

		return
	end, arg_5_1, 1)

	self.timer:Start()

	return
end

function CourtYardBGMAgent:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CourtYardBGMAgent:Stop(arg_8_1)
	if self.waitForStop then
		return
	end

	if not self.recoders[arg_8_1] then
		return
	end

	self.recoders[arg_8_1] = self.recoders[arg_8_1] - 1

	if self.recoders[arg_8_1] == 0 then
		self:Reset()
	end

	return
end

function CourtYardBGMAgent:Reset()
	self.recoders = {}

	self:PlayVoice(self.defaultBgm)

	return
end

function CourtYardBGMAgent:PlayVoice(arg_10_1, arg_10_2)
	if self.playName == arg_10_1 then
		return
	end

	CriWareMgr.Inst:PlayBGM("bgm-" .. arg_10_1, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_11_0)
		if arg_11_0 == nil then
			warning("Missing BGM :" .. (arg_10_1 or "NIL"))
		elseif arg_10_2 then
			arg_10_2(arg_11_0.cueInfo)
		end

		return
	end)

	self.playName = arg_10_1

	return
end

function CourtYardBGMAgent:Clear()
	self:RemoveTimer()

	self.recoders = {}
	self.playName = nil
	self.waitForStop = false

	pg.CriMgr.GetInstance():StopBGM()

	return
end

function CourtYardBGMAgent:Dispose()
	self:Clear()

	self.recoders = nil

	self:RemoveTimer()

	return
end

return CourtYardBGMAgent
