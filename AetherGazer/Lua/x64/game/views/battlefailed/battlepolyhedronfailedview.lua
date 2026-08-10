local var_0_0 = class("BattleMythicFinalFailedView", BattleFailedView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattlePolyhedronFailed"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stageData = arg_2_0.params_.stageData
	arg_2_0.stayTime = 30
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnBattleCount_, nil, function()
		if arg_3_0.isEnd then
			return
		end

		arg_3_0:RemoveTimer()
		JumpTools.OpenPageByJump("/battleStatisticsPolyhdronOver")
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_polyhedronSettlementBtn, nil, function()
		if arg_3_0.isEnd then
			return
		end

		arg_3_0:OnceMoreBattle()
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_polyhedronReturnBtn, nil, function()
		if arg_3_0.isEnd then
			return
		end

		arg_3_0:Quit()
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_polyhedronRestartBtn, nil, function()
		if arg_3_0.isEnd then
			return
		end

		PolyhedronAction.QueryPolyhedronGiveUp(function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				arg_3_0:Quit()
			else
				arg_3_0:Quit()
				ShowTips(arg_8_0.result)
			end
		end)
	end)
	arg_3_0:AddBtnListener(arg_3_0.mask_, nil, function()
		if arg_3_0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - arg_3_0.startTime < 2 then
			return
		end

		arg_3_0:Quit()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	BattleInstance.hideBattlePanel()
	arg_10_0:RecordThreeStar()

	arg_10_0.startTime = Time.realtimeSinceStartup
	arg_10_0.isEnd = false

	arg_10_0:RemoveTimer()

	arg_10_0.battleTimeText_.text = arg_10_0:GetBattleTime()

	arg_10_0.animator_:Play("battleFailed")
end

function var_0_0.OnceMoreBattle(arg_11_0)
	arg_11_0.isEnd = true

	arg_11_0:RemoveTimer()

	arg_11_0.timer_ = Timer.New(function()
		BattleInstance.OnceMoreBattle(arg_11_0.stageData)
	end, 1, 1)

	arg_11_0.timer_:Start()
	arg_11_0.animator_:Play("battleFailed_out")
end

return var_0_0
