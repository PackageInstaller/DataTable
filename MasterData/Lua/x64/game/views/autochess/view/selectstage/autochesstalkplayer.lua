local AutoChessTalkPlayer = class("AutoChessTalkPlayer")

function AutoChessTalkPlayer:Ctor(arg_1_1, arg_1_2)
	self.updateCallback_ = arg_1_1
	self.updatePeriod_ = arg_1_2
	self.cdNum_ = 0
end

function AutoChessTalkPlayer:Play()
	self.isPlaying_ = true
	self.curUpdateIndex_ = 0

	self:StartCountDown()
	self:OnUpdate()
end

function AutoChessTalkPlayer:Stop()
	self.isPlaying_ = false

	self:StopCountDown()
end

function AutoChessTalkPlayer:Skip()
	if not self.isPlaying_ then
		return
	end

	self.cdNum_ = self.updatePeriod_

	self:OnUpdate()
end

function AutoChessTalkPlayer:StartCountDown()
	self:StopCountDown()

	self.cdNum_ = self.updatePeriod_
	self.countDownTimer_ = self.countDownTimer_ or FuncTimerManager.inst:CreateFuncFrameTimer(handler(self, self.OnCountDown), -1, true)
end

function AutoChessTalkPlayer:StopCountDown()
	if self.countDownTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.countDownTimer_)

		self.countDownTimer_ = nil
	end
end

function AutoChessTalkPlayer:OnCountDown()
	self.cdNum_ = self.cdNum_ - Time.deltaTime

	if self.cdNum_ <= 0 then
		self.cdNum_ = self.updatePeriod_

		self:OnUpdate()
	end
end

function AutoChessTalkPlayer:OnUpdate()
	self.curUpdateIndex_ = self.curUpdateIndex_ + 1

	if self.updateCallback_ then
		self.updateCallback_(self.curUpdateIndex_)
	end
end

return AutoChessTalkPlayer
