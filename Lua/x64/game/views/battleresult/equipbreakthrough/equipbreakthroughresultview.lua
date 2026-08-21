local var_0_0 = class("EquipBreakThroughResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSettlementUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroView_ = EquipBreakThroughResultHeroView.New(arg_3_0.heroPanel_)
	arg_3_0.resultInfoView_ = EquipBreakThroughResultInfoView.New(arg_3_0.infoPanel_)

	LeanTween.alphaCanvas(arg_3_0.maskCanvas_, 0, 0.1)
	arg_3_0:AddTimer()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData_ = arg_4_0.params_.stageData

	BattleInstance.hideBattlePanel()

	if arg_4_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_4_0:CloseFunc()
			end
		})
	end

	arg_4_0.heroView_:SetData(arg_4_0.stageData_)
	arg_4_0.resultInfoView_:SetData(arg_4_0.stageData_)
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.heroView_:OnExit()
	arg_6_0.resultInfoView_:OnExit()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	arg_7_0.heroView_:Dispose()

	arg_7_0.heroView_ = nil

	arg_7_0.resultInfoView_:Dispose()

	arg_7_0.resultInfoView_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.stasticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_8_0.stageData,
			battleTime = arg_8_0:GetBattleTime()
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:EndAnimator()
	end)
end

function var_0_0.CloseFunc(arg_12_0)
	BattleInstance.QuitBattle(arg_12_0.stageData_)
end

function var_0_0.GetBattleTime(arg_13_0)
	local var_13_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_13_0)
end

function var_0_0.EndAnimator(arg_14_0)
	arg_14_0:StopTimer()

	arg_14_0.maskCanvas_.blocksRaycasts = false
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	arg_15_0.timer_ = Timer.New(function()
		arg_15_0:EndAnimator()
	end, 1, 1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()
	end
end

return var_0_0
