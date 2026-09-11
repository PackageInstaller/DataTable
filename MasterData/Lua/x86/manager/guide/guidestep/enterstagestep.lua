local EnterStageStep = class("EnterStageStep", BaseStep)

function EnterStageStep:Init()
	self.missionID = GuideStepCfg[self._stepId].params[1]
	self.reenterStageCnt_ = 0
	self.restartBattle_ = 0
end

function EnterStageStep:Play()
	local var_2_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PLOT, nil, nil, {
		stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT,
		stageID = self.missionID
	})

	var_2_0.needDefaultTeam = true

	local var_2_1 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, self.missionID)

	var_2_1:SetReserveParams(var_2_0)
	var_2_1:Init()
	BattleController.GetInstance():LaunchBattle(var_2_1, nil, handler(self, self.OnLaunchBattle))
end

function EnterStageStep:OnLaunchBattle(arg_3_1)
	if isSuccess(arg_3_1.result) then
		if self.timer_ then
			self.timer_:Stop()
		end

		self.timer_ = Timer.New(function()
			if WaitStartBattle == false then
				self.timer_:Stop()

				self.timer_ = nil
				self.restartBattle_ = self.restartBattle_ + 1

				if self.restartBattle_ > 3 then
					self.restartBattle_ = 0

					GotoLoginView()
				else
					self:Play()
				end
			elseif WaitStartBattle == true then
				self:OnStepEnd()
			end
		end, 0.033, -1)

		self.timer_:Start()
	else
		ShowTips(arg_3_1.result)

		if self.reenterStageCnt_ > 3 then
			GotoLoginView()
		else
			self:Play()

			self.reenterStageCnt_ = self.reenterStageCnt_ + 1
		end
	end
end

function EnterStageStep:OnStepEnd()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	EnterStageStep.super.OnStepEnd(self)
end

return EnterStageStep
