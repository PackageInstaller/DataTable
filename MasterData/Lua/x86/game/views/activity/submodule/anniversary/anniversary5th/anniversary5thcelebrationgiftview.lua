local Anniversary5thCelebrationGiftView = class("Anniversary5thCelebrationGiftView", (require("game.views.activity.Submodule.anniversary.AnniversaryCelebrationGiftViewBase")))

function Anniversary5thCelebrationGiftView:GetUIName()
	return "Widget/Version/V5_0_WuChang/V5_0_WuChang_CelebrationGiftUI/V5_0_WuChang_CelebrationGiftUI"
end

function Anniversary5thCelebrationGiftView:AddListeners()
	Anniversary5thCelebrationGiftView.super.AddListeners(self)
	self:BindHelpBtn("ACTIVITY_ASSIGNMENT_DESC")
end

return Anniversary5thCelebrationGiftView
