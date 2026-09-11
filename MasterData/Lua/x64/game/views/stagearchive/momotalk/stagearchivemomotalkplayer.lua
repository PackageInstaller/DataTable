local StageArchiveMomoTalkPlayer = class("StageArchiveMomoTalkPlayer")

function StageArchiveMomoTalkPlayer:Ctor(arg_1_1, arg_1_2)
	self.updateCallback_ = arg_1_1
	self.updatePeriod_ = arg_1_2
	self.cdNum_ = 0
end

function StageArchiveMomoTalkPlayer:Play()
	self.isPlaying_ = true
	self.curUpdateIndex_ = 0

	self:StartCountDown()
	self:OnUpdate()
end

function StageArchiveMomoTalkPlayer:Stop()
	self.isPlaying_ = false

	self:StopCountDown()
end

function StageArchiveMomoTalkPlayer:Skip()
	if not self.isPlaying_ then
		return
	end

	self.cdNum_ = self.updatePeriod_

	self:OnUpdate()
end

function StageArchiveMomoTalkPlayer:StartCountDown()
	self:StopCountDown()

	self.cdNum_ = self.updatePeriod_
	self.countDownTimer_ = self.countDownTimer_ or FuncTimerManager.inst:CreateFuncFrameTimer(handler(self, self.OnCountDown), -1, true)
end

function StageArchiveMomoTalkPlayer:StopCountDown()
	if self.countDownTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.countDownTimer_)

		self.countDownTimer_ = nil
	end
end

function StageArchiveMomoTalkPlayer:OnCountDown()
	self.cdNum_ = self.cdNum_ - Time.deltaTime

	if self.cdNum_ <= 0 then
		self.cdNum_ = self.updatePeriod_

		self:OnUpdate()
	end
end

function StageArchiveMomoTalkPlayer:OnUpdate()
	self.curUpdateIndex_ = self.curUpdateIndex_ + 1

	if self.updateCallback_ then
		self.updateCallback_(self.curUpdateIndex_)
	end
end

return StageArchiveMomoTalkPlayer
