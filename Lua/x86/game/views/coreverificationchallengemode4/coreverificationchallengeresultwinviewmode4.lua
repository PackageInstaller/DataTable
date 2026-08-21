NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("CoreVerificationChallengeResultWinViewMode4", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ResultWinUI04"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.super.OnEnter(arg_3_0)
	arg_3_0:RenderScore()

	local var_3_0 = CoreVerificationClMode4Cfg[arg_3_0.stageId]

	arg_3_0.titleTxt_.text = GetI18NText(var_3_0.stage_name)
end

function var_0_0.RenderScore(arg_4_0)
	arg_4_0.scoreText_.text = CoreVerificationChallengeMode4Data:GetLastBattleScore()
end

function var_0_0.RenderTitleView(arg_5_0)
	arg_5_0.titleTxt_.text = GetI18NText(BattleStageTools.GetStageName(arg_5_0.stageType, arg_5_0.stageId)) or ""
end

function var_0_0.onRenderMissionContent(arg_6_0)
	return
end

function var_0_0.CloseFunc(arg_7_0)
	OperationRecorder.Record(arg_7_0.class.__cname, "closeCombat")
	arg_7_0:ShowVitalityBox(function()
		arg_7_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_7_0.params_.stageData, false)
		end)
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
