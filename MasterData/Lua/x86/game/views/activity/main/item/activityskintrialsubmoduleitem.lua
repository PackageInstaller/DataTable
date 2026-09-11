ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivitySkinTrialSubmoduleItem = class("ActivitySkinTrialSubmoduleItem", ActivitySubmoduleItem)

function ActivitySkinTrialSubmoduleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityId_ = ActivityTools.GetReprintActivityID(arg_1_2)
	self.theme_ = ActivityTools.GetActivityTheme(self.activityId_)
	self.refreshSkinTrialBtnHandler = handler(self, self.RefreshSkinTrialBtn)

	self:InitUI()
end

function ActivitySkinTrialSubmoduleItem:OnEnter()
	manager.notify:RegistListener(SKIN_TRIAL_UPDATE, self.refreshSkinTrialBtnHandler)
	self:RefreshSkinTrialBtn()
	self.super.OnEnter(self)
end

function ActivitySkinTrialSubmoduleItem:OnExit()
	self.super.OnExit(self)
	manager.notify:RemoveListener(SKIN_TRIAL_UPDATE, self.refreshSkinTrialBtnHandler)
end

function ActivitySkinTrialSubmoduleItem:RefreshSkinTrialBtn()
	for iter_4_0, iter_4_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_TRIAL]) do
		if ActivityData:GetActivityIsOpen(iter_4_1) and ActivityTools.GetActivityTheme(iter_4_1) == self.theme_ then
			self.activityId_ = iter_4_1
		end
	end
end

return ActivitySkinTrialSubmoduleItem
