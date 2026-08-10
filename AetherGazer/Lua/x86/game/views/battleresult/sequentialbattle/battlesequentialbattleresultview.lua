NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleSequentialBattleResultView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0.params_.stageData:GetActivityID()
	local var_1_1 = SequentialBattleChapterCfg[var_1_0].main_id
	local var_1_2 = SequentialBattleUICfg.get_id_list_by_main_activity_id[var_1_1][1]

	return SequentialBattleUICfg[var_1_2].battle_result_prefab
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)

	arg_2_0.finishAllController_ = arg_2_0.controllerEx_:GetController("finishAll")
	arg_2_0.buffView_ = BattleSequentialBattleResultBuffPanel.New(arg_2_0.buffPanel_)
	arg_2_0.finishView_ = BattleSequentialBattleResultFinishPanel.New(arg_2_0.finishPanel_)
end

function var_0_0.RenderView(arg_3_0)
	var_0_0.super.RenderView(arg_3_0)
	arg_3_0.buffView_:SetData(arg_3_0.params_.stageData:GetStageAffix())

	local var_3_0 = SequentialBattleData:GetCurrentFinishStageIndex(arg_3_0.params_.stageData:GetActivityID())

	if var_3_0 >= 4 then
		arg_3_0.finishAllController_:SetSelectedState("true")
	else
		arg_3_0.finishAllController_:SetSelectedState("false")
	end

	arg_3_0.finishView_:SetData(var_3_0)
end

function var_0_0.ShowContent(arg_4_0)
	return
end

function var_0_0.AddListener(arg_5_0)
	var_0_0.super.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:CloseFunc()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirm2Btn_, nil, function()
		arg_5_0:OnClickNextStage()
	end)
end

function var_0_0.OnClickNextStage(arg_8_0)
	local var_8_0 = arg_8_0.params_.stageData:GetActivityID()
	local var_8_1 = SequentialBattleData:GetCurrentFinishStageIndex(var_8_0) + 1
	local var_8_2 = var_8_0
	local var_8_3 = var_8_1
	local var_8_4 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, var_8_2, var_8_3, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[var_8_0].stage_id[var_8_1],
		activityID = var_8_0
	})
	local var_8_5 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_8_0].stage_id[var_8_1], var_8_0, var_8_4)

	BattleController.GetInstance():LaunchBattle(var_8_5)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.buffView_:Dispose()

	arg_9_0.buffView_ = nil

	arg_9_0.finishView_:Dispose()

	arg_9_0.finishView_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
