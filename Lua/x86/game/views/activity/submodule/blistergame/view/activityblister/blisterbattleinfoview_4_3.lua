BlisterBattleInfoView = import("game.views.activity.Submodule.BlisterGame.View.BlisterBattleInfoView")

local var_0_0 = class("BlisterBattleInfoView_4_3", BlisterBattleInfoView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGame02"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.resetBtn_, nil, function()
		if arg_2_0.isEnded then
			return
		end

		BlisterGameTool.ReStartGame()
	end)
end

return var_0_0
