NewBattleScoreResultView = import("game.views.battleResult.score.NewBattleScoreResultView")

local var_0_0 = class("BattleScoreWithMaxScoreResultView", NewBattleScoreResultView)

function var_0_0.PostRenderView(arg_1_0)
	arg_1_0.btnController:SetSelectedState("nobtn")
	SetActive(arg_1_0.statisticsBtn_.gameObject, false)
end

function var_0_0.OnAddListner(arg_2_0)
	SetActive(arg_2_0.emptyMaskBtn_.gameObject, true)
	arg_2_0:AddBtnListener(arg_2_0.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(arg_2_0.stageData)
	end)
end

return var_0_0
