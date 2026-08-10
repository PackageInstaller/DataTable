local var_0_0 = class("BattleMatrixFailedView", BattleFailedView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleMatrixFailed"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stageData = arg_2_0.params_.stageData
	arg_2_0.stayTime = 20
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_backBtn, nil, function()
		if arg_3_0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - arg_3_0.startTime < 2 then
			return
		end

		arg_3_0:Quit()
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_againBtn, nil, function()
		if arg_3_0.isEnd then
			return
		end

		if arg_3_0.stageData then
			arg_3_0:OnceMoreBattle()
		else
			arg_3_0:Quit()
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnBattleCount_, nil, function()
		if arg_3_0.isEnd then
			return
		end

		arg_3_0:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_3_0.stageData,
			battleTime = arg_3_0:GetBattleTime()
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)
	TimeTools.StartAfterSeconds(0.033, function()
		arg_7_0.m_canvas.alpha = 1
	end, {})
end

function var_0_0.OnceMoreBattle(arg_9_0)
	arg_9_0.isEnd = true

	arg_9_0:RemoveTimer()

	arg_9_0.timer_ = Timer.New(function()
		BattleInstance.OnceMoreBattle(arg_9_0.stageData)
	end, 1, 1)

	arg_9_0.timer_:Start()
	arg_9_0.animator_:Play("battleFailed_out")
end

return var_0_0
