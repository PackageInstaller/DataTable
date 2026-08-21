BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")

local var_0_0 = class("AbyssBattleResultView", BattleScoreResultView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	SetActive(arg_1_0.closePanel_, true)
	SetActive(arg_1_0.onceMoreGo_, false)
	SetActive(arg_1_0.closeBtnGo_, false)
end

return var_0_0
