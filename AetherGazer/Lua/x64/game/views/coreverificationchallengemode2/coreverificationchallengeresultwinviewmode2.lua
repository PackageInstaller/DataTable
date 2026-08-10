NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("CoreVerificationChallengeResultWinViewMode2", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode2/Core_verification_ResultWinUI02"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.super.OnEnter(arg_3_0)
	arg_3_0:RederAffix()

	local var_3_0 = CoreVerificationClMode2Cfg[arg_3_0.stageId]

	arg_3_0.titleTxt_.text = GetI18NText(var_3_0.stage_name)
end

function var_0_0.RederAffix(arg_4_0)
	local var_4_0 = CoreVerificationClMode2Cfg[arg_4_0.stageId]

	arg_4_0.limitText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_3"), "+" .. var_4_0.cost_limit_up)

	local var_4_1 = CoreVerificationChallengeMode2Data:GetPostLimitNum()

	arg_4_0.useText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_1"), var_4_1)
end

function var_0_0.RenderTitleView(arg_5_0)
	return
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
	if arg_10_0.scrollHelper_ then
		arg_10_0.scrollHelper_:Dispose()

		arg_10_0.scrollHelper_ = nil
	end

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
