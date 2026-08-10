NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("OsirisPlayGameSettlementWinView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/Common/BattleResultWinUI_Osiris"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.lookCon_ = arg_2_0.controllerEx_:GetController("look")
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.super.OnEnter(arg_3_0)
	arg_3_0:RefreshLook()
end

function var_0_0.RefreshLook(arg_4_0)
	local var_4_0 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_4_0.stageId][1]

	if ActivityGeneralityStageCfg[var_4_0].rank_activity > 0 then
		arg_4_0.lookCon_:SetSelectedIndex(1)
		arg_4_0.btnController:SetSelectedIndex(0)

		local var_4_1 = OsirisPlayGameData:GetCurStageInfo()

		if var_4_1.stage_id == arg_4_0.stageId then
			arg_4_0.numText_.text = var_4_1.point
		end
	else
		arg_4_0.lookCon_:SetSelectedIndex(0)
		arg_4_0.btnController:SetSelectedIndex(2)
	end
end

function var_0_0.onRenderMissionContent(arg_5_0)
	return
end

function var_0_0.CloseFunc(arg_6_0)
	OperationRecorder.Record(arg_6_0.class.__cname, "closeCombat")
	arg_6_0:ShowVitalityBox(function()
		arg_6_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_6_0.params_.stageData, false)
		end)
	end)
end

return var_0_0
