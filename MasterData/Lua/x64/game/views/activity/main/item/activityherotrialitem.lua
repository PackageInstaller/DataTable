ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivityHeroTrialItem = class("ActivityHeroTrialItem", ActivitySubmoduleItem)

function ActivityHeroTrialItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityId_ = arg_1_2
	self.theme_ = ActivityTools.GetActivityTheme(self.activityId_)
	self.refreshHeroTrialBtnHandler = handler(self, self.RefreshHeroTrialBtn)

	self:InitUI()
end

function ActivityHeroTrialItem:OnEnter()
	manager.notify:RegistListener(HERO_TRIAL_UPDATE, self.refreshHeroTrialBtnHandler)
	self:RefreshHeroTrialBtn()
	self.super.OnEnter(self)
end

function ActivityHeroTrialItem:OnExit()
	self.super.OnExit(self)
	manager.notify:RemoveListener(HERO_TRIAL_UPDATE, self.refreshHeroTrialBtnHandler)
end

function ActivityHeroTrialItem:RefreshHeroTrialBtn()
	for iter_4_0, iter_4_1 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		if ActivityData:GetActivityIsOpen(iter_4_0) and ActivityTools.GetActivityTheme(iter_4_0) == self.theme_ then
			self.activityId_ = iter_4_0
		end
	end
end

return ActivityHeroTrialItem
