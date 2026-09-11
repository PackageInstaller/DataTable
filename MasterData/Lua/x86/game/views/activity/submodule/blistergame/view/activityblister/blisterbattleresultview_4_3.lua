BlisterBattleResultView = import("game.views.activity.Submodule.BlisterGame.View.BlisterBattleResultView")

local BlisterBattleResultView_4_3 = class("BlisterBattleResultView_4_3", BlisterBattleResultView)

function BlisterBattleResultView_4_3:UIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_Summer2024_Bubble/Alone_BubbleresultPopUI"
end

function BlisterBattleResultView_4_3:AddListeners()
	self.super.AddListeners(self)
	self:AddBtnListener(self.suminibtn03Btn_, nil, function()
		self:OnNextStage()
	end)
end

return BlisterBattleResultView_4_3
