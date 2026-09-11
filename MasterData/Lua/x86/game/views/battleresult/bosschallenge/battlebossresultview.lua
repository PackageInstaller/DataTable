NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleBossResultView = class("BattleBossResultView", NewBattleSettlementView)

function BattleBossResultView:OnEnter()
	BattleBossResultView.super.OnEnter(self)

	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function()
				self:CloseFunc()
			end,
			MaskCallback = function()
				self:CloseFunc()
			end
		})
	end
end

return BattleBossResultView
