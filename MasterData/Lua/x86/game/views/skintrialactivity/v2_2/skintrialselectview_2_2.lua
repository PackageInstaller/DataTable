local SkinTrialSelectView_2_2 = class("SkinTrialSelectView_2_2", (import("game.views.skinTrialActivity.V2_0.SkinTrialSelectView_2_0")))

function SkinTrialSelectView_2_2:Init()
	SkinTrialSelectView_2_2.super.Init(self)

	self.styleController_ = ControllerUtil.GetController(self.transform_, "style")
end

function SkinTrialSelectView_2_2:RefreshUI()
	SkinTrialSelectView_2_2.super.RefreshUI(self)

	if self.styleController_ then
		self.styleController_:SetSelectedState("V2_2")
	end
end

function SkinTrialSelectView_2_2:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_2_2",
		activityID = self.activityID_,
		skinTrialID = self.skinTrialID_
	})
end

return SkinTrialSelectView_2_2
