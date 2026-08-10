local var_0_0 = class("BattleAshFailedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BattleLoseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:OnCancelClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBrn_, nil, function()
		arg_5_0:OnRestartClick()
	end)
end

function var_0_0.GetBattleTime(arg_8_0)
	local var_8_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_8_0)
end

function var_0_0.OnEnter(arg_9_0)
	BattleInstance.hideBattlePanel()

	local var_9_0 = AshSystemAction:GetLastBattleData().stageId

	arg_9_0.timeTxt_.text = arg_9_0:GetBattleTime()
	arg_9_0.stageTxt_.text = BattleAshShootStageCfg[AshShootStageCfg[var_9_0].stage_id].name
end

function var_0_0.OnRestartClick(arg_10_0)
	LuaExchangeHelper.GameOver(2, CustomLoadingConst.ASHGAME_Loading)
	BattleController.GetInstance():LaunchBattle(arg_10_0.params_.stageData, nil, nil, true)
	LuaForCursor.SwitchCursor(false)
end

function var_0_0.OnCancelClick(arg_11_0)
	BattleInstance.QuitBattle(arg_11_0.params_.stageData, true, true)
end

return var_0_0
