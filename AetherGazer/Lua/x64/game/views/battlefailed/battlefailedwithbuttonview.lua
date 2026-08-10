local var_0_0 = class("BattleFailedWithButtonView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleFailed"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "failedType")

	arg_3_0.controller_:SetSelectedState("true")
end

function var_0_0.OnEnter(arg_4_0)
	BattleInstance.hideBattlePanel()

	arg_4_0.startTime_ = Time.realtimeSinceStartup
	arg_4_0.isEnd_ = false
	arg_4_0.battleTimeText_.text = arg_4_0:GetBattleTime()

	arg_4_0.animator_:Play("battleFailed")
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:RemoveTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.restartBtn_, nil, function()
		arg_7_0:OnClickRestart()
	end)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		arg_7_0:OnClickBack()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnBattleCount_, nil, function()
		if arg_7_0.isEnd then
			return
		end

		arg_7_0:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_7_0.stageData,
			battleTime = arg_7_0:GetBattleTime()
		})
	end)
end

function var_0_0.GetBattleTime(arg_11_0)
	local var_11_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_11_0)
end

function var_0_0.OnClickRestart(arg_12_0)
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(arg_12_0.params_.stageData)
end

function var_0_0.OnClickBack(arg_13_0)
	arg_13_0:Quit()
end

function var_0_0.Quit(arg_14_0)
	arg_14_0.isEnd_ = true

	arg_14_0:RemoveTimer()

	arg_14_0.timer_ = Timer.New(function()
		BattleInstance.QuitBattle(arg_14_0.params_.stageData, true, true)
	end, 1, 1)

	arg_14_0.timer_:Start()
	arg_14_0.animator_:Play("battleFailed_out")
end

function var_0_0.RemoveTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
