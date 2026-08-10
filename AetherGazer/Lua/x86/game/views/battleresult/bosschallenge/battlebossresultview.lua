NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleBossResultView", NewBattleSettlementView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function()
				arg_1_0:CloseFunc()
			end,
			MaskCallback = function()
				arg_1_0:CloseFunc()
			end
		})
	end
end

return var_0_0
