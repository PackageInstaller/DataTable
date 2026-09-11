BlisterChapterSectionInfoView = import("game.views.activity.Submodule.BlisterGame.View.BlisterChapterSectionInfoView")

local BlisterChapterSectionInfoView_4_3 = class("BlisterChapterSectionInfoView_4_3", BlisterChapterSectionInfoView)

function BlisterChapterSectionInfoView_4_3:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:Back()
		self:OnClickBtn()
	end)
end

function BlisterChapterSectionInfoView_4_3:UIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_Summer2024_Bubble/Alone_SUBubbleInfoUI"
end

return BlisterChapterSectionInfoView_4_3
