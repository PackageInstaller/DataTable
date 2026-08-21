NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleRogueTeamResultView", NewBattleSettlementView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.panelView_ = BattleRogueTeamResultDropPanel.New(arg_1_0.rogueTeamPanel_)

	SetActive(arg_1_0.contentContainer_.gameObject, false)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	arg_2_0.panelView_:OnEnter()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.panelView_:Dispose()

	arg_3_0.panelView_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
