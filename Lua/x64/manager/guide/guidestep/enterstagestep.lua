local var_0_0 = class("EnterStageStep", BaseStep)

function var_0_0.Init(arg_1_0)
	arg_1_0.missionID = GuideStepCfg[arg_1_0._stepId].params[1]
	arg_1_0.reenterStageCnt_ = 0
	arg_1_0.restartBattle_ = 0
end

function var_0_0.Play(arg_2_0)
	local var_2_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PLOT, nil, nil, {
		stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT,
		stageID = arg_2_0.missionID
	})

	var_2_0.needDefaultTeam = true

	local var_2_1 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_2_0.missionID)

	var_2_1:SetReserveParams(var_2_0)
	var_2_1:Init()
	BattleController.GetInstance():LaunchBattle(var_2_1, nil, handler(arg_2_0, arg_2_0.OnLaunchBattle))
end

function var_0_0.OnLaunchBattle(arg_3_0, arg_3_1)
	if isSuccess(arg_3_1.result) then
		if arg_3_0.timer_ then
			arg_3_0.timer_:Stop()
		end

		arg_3_0.timer_ = Timer.New(function()
			if WaitStartBattle == false then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil
				arg_3_0.restartBattle_ = arg_3_0.restartBattle_ + 1

				if arg_3_0.restartBattle_ > 3 then
					arg_3_0.restartBattle_ = 0

					GotoLoginView()
				else
					arg_3_0:Play()
				end
			elseif WaitStartBattle == true then
				arg_3_0:OnStepEnd()
			end
		end, 0.033, -1)

		arg_3_0.timer_:Start()
	else
		ShowTips(arg_3_1.result)

		if arg_3_0.reenterStageCnt_ > 3 then
			GotoLoginView()
		else
			arg_3_0:Play()

			arg_3_0.reenterStageCnt_ = arg_3_0.reenterStageCnt_ + 1
		end
	end
end

function var_0_0.OnStepEnd(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end

	var_0_0.super.OnStepEnd(arg_5_0)
end

return var_0_0
