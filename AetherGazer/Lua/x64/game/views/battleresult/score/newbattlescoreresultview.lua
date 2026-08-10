NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("NewBattleScoreResultView", NewBattleSettlementView)

function var_0_0.OnAddListner(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.nextStageBtn_, nil, function()
		arg_1_0:ConfirmFunc()
	end)
	SetActive(arg_1_0.costImage_.gameObject, false)

	arg_1_0.confirmBtnTxt_.text = GetTips("CHALLENGE_ONCE_MORE")
end

function var_0_0.ShowContent(arg_3_0)
	arg_3_0:onRenderChallengeContent()
end

function var_0_0.onRenderChallengeContent(arg_4_0)
	if not arg_4_0.chanllengeView then
		arg_4_0.chanllengeView = BattleSettlementChallengeModule.New(arg_4_0.contentContainer_)
	end

	local var_4_0

	if arg_4_0.params_.title and arg_4_0.params_.title ~= "" then
		var_4_0 = GetI18NText(arg_4_0.params_.title)
	end

	arg_4_0.chanllengeView:RenderView({
		score = arg_4_0.params_.score,
		stageType = arg_4_0.stageType,
		stageData = arg_4_0.stageData,
		scoreTitle = var_4_0
	})
end

function var_0_0.ConfirmFunc(arg_5_0)
	if arg_5_0.params_.condition then
		local var_5_0, var_5_1 = arg_5_0.params_.condition()

		if var_5_0 then
			BattleController.GetInstance():LaunchBattle(arg_5_0.params_.stageData)
		else
			ShowTips(var_5_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(arg_5_0.params_.stageData)
	end
end

function var_0_0.OnTop(arg_6_0)
	var_0_0.super.OnTop(arg_6_0)

	if arg_6_0.chanllengeView then
		arg_6_0.chanllengeView:OnTop()
	end
end

function var_0_0.NeedOnceMore(arg_7_0)
	if arg_7_0.params_.notOnceMore or arg_7_0.params_.noOnceMore then
		return false
	end

	return true
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.chanllengeView:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
