NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("CoreVerificationChallengeResultWinView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_ResultWinUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, CoreVerificationChallengeResultWinItem)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.super.OnEnter(arg_3_0)
	arg_3_0:RederAffix()

	local var_3_0 = CoreVerificationChallengeTools.GetModeCfg()[arg_3_0.stageId]

	arg_3_0.titleTxt_.text = GetI18NText(var_3_0.stage_name)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.affixList[arg_4_1])
end

function var_0_0.RederAffix(arg_5_0)
	arg_5_0.affixList = {}

	local var_5_0 = CoreVerificationChallengeTools.GetModeCfg()[arg_5_0.stageId]

	for iter_5_0, iter_5_1 in ipairs(var_5_0.stage_buff) do
		local var_5_1 = {
			type = 1,
			buff_id = iter_5_1[1]
		}

		table.insert(arg_5_0.affixList, var_5_1)
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0.stage_debuff) do
		local var_5_2 = {
			type = 2,
			buff_id = iter_5_3[1]
		}

		table.insert(arg_5_0.affixList, var_5_2)
	end

	arg_5_0.scrollHelper_:StartScroll(#arg_5_0.affixList)
end

function var_0_0.RenderTitleView(arg_6_0)
	return
end

function var_0_0.onRenderMissionContent(arg_7_0)
	return
end

function var_0_0.CloseFunc(arg_8_0)
	OperationRecorder.Record(arg_8_0.class.__cname, "closeCombat")
	arg_8_0:ShowVitalityBox(function()
		arg_8_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_8_0.params_.stageData, false)
		end)
	end)
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.scrollHelper_ then
		arg_11_0.scrollHelper_:Dispose()

		arg_11_0.scrollHelper_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
