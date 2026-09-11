BlisterBattleInfoView = import("game.views.activity.Submodule.BlisterGame.View.BlisterBattleInfoView")

local BlisterBattleInfoView_4_3 = class("BlisterBattleInfoView_4_3", BlisterBattleInfoView)

function BlisterBattleInfoView_4_3:UIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGame02"
end

function BlisterBattleInfoView_4_3:AddListeners()
	self:AddBtnListener(self.resetBtn_, nil, function()
		if self.isEnded then
			return
		end

		BlisterGameTool.ReStartGame()
	end)
end

return BlisterBattleInfoView_4_3
