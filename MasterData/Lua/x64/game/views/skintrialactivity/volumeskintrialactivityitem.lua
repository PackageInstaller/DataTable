SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")

local VolumeSkinTrialActivityItem = class("VolumeSkinTrialActivityItem", SkinTrialActivityItem)

function VolumeSkinTrialActivityItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.activityID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self:SetSkinTrialID(arg_1_2)
	SetActive(self.gameObject_, true)
end

function VolumeSkinTrialActivityItem:RefreshUI()
	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.stateController_:SetSelectedState("true")
	end
end

return VolumeSkinTrialActivityItem
