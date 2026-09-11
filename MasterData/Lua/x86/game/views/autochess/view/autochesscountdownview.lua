local AutoChessCountDownView = class("AutoChessCountDownView", ReduxView)

function AutoChessCountDownView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessCountDownView:Init()
	self:InitUI()

	self.updateTimeHandler_ = handler(self, self.UpdateCountDownTime)
end

function AutoChessCountDownView:InitUI()
	self:BindCfgUI()

	self.colorController_ = self.controllerEx_:GetController("color")
end

function AutoChessCountDownView:RegisterEvent()
	manager.notify:RegistListener(AUTO_CHESS_UPDATE_COUNTDOWN, self.updateTimeHandler_)
end

function AutoChessCountDownView:UpdateCountDownTime()
	if self.countDownTimer_ then
		self.countDownTimer_:Stop()

		self.countDownTimer_ = nil
	end

	local var_5_0 = AutoChessData:GetEndTimeStamp(AutoChessConst.GAME_TYPE.ONLINE)
	local var_5_1 = var_5_0.endTime - var_5_0.startTime
	local var_5_2 = var_5_0.endTime - manager.time:GetServerTime()

	self.countDownText_.text = manager.time:DescCDTime4(var_5_2)
	self.timeSlider_.value = var_5_2 / (var_5_0.endTime - var_5_0.startTime)

	if var_5_2 > 0 then
		self.colorController_:SetSelectedState(var_5_2 <= 10 and "red" or "normal")

		self.countDownTimer_ = Timer.New(function()
			local var_6_0 = var_5_0.endTime - manager.time:GetServerTime()

			self.countDownText_.text = manager.time:DescCDTime4(var_6_0)

			self.colorController_:SetSelectedState(var_6_0 <= 10 and "red" or "normal")
			self:RemoveTween()

			self.tween_ = LeanTween.value(var_6_0, var_6_0 - 1, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				self.timeSlider_.value = arg_7_0 / var_5_1
			end)):setOnComplete(LuaHelper.VoidAction(function()
				self:RemoveTween()
			end))

			if var_6_0 <= 0 then
				self.countDownTimer_:Stop()
				self:OnTimeOver()
			end
		end, 1, -1)

		self.countDownTimer_:Start()
	else
		self:OnTimeOver()
	end
end

function AutoChessCountDownView:OnTimeOver()
	self.countDownText_.text = "00:00"

	self.colorController_:SetSelectedState("normal")
	manager.notify:Invoke(AUTO_CHESS_TIME_OVER)
end

function AutoChessCountDownView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function AutoChessCountDownView:ResetView()
	self:RemoveTween()

	if self.countDownTimer_ then
		self.countDownTimer_:Stop()

		self.countDownTimer_ = nil
	end

	manager.notify:RemoveListener(AUTO_CHESS_UPDATE_COUNTDOWN, self.updateTimeHandler_)
end

function AutoChessCountDownView:OnExit()
	self:ResetView()
	AutoChessCountDownView.super.OnExit(self)
end

function AutoChessCountDownView:Dispose()
	self:ResetView()
	AutoChessCountDownView.super.Dispose(self)
end

return AutoChessCountDownView
