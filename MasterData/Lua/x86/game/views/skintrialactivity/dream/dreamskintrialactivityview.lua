local DreamSkinTrialActivityView = class("DreamSkinTrialActivityView", (import("game.views.skinTrialActivity.FactorySkinTrialActivityView")))

function DreamSkinTrialActivityView:UIName()
	if self.params_.activityID == ActivityConst.THOR_SKIN_TRIAL then
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_1"
	else
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_2"
	end
end

function DreamSkinTrialActivityView:GetItemClass()
	return DreamSkinTrialActivityItem
end

return DreamSkinTrialActivityView
