BlisterBattleResultView = import("game.views.activity.Submodule.BlisterGame.View.BlisterBattleResultView")

local var_0_0 = class("BlisterBattleResultView_4_3", BlisterBattleResultView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_Summer2024_Bubble/Alone_BubbleresultPopUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0.super.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.suminibtn03Btn_, nil, function()
		arg_2_0:OnNextStage()
	end)
end

return var_0_0
