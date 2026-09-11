ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivityFactoryHeroTrialSubmoduleItem = class("ActivityFactoryHeroTrialSubmoduleItem", ActivitySubmoduleItem)

function ActivityFactoryHeroTrialSubmoduleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityId_ = arg_1_2
	self.theme_ = ActivityTools.GetActivityTheme(self.activityId_)
	self.refreshHeroTrialBtnHandler = handler(self, self.RefreshHeroTrialBtn)

	self:InitUI()
end

function ActivityFactoryHeroTrialSubmoduleItem:OnEnter()
	manager.notify:RegistListener(HERO_TRIAL_UPDATE, self.refreshHeroTrialBtnHandler)
	self:RefreshHeroTrialBtn()
	self.super.OnEnter(self)
end

function ActivityFactoryHeroTrialSubmoduleItem:OnExit()
	self.super.OnExit(self)
	manager.notify:RemoveListener(HERO_TRIAL_UPDATE, self.refreshHeroTrialBtnHandler)
end

function ActivityFactoryHeroTrialSubmoduleItem:BindRedPoint()
	return
end

function ActivityFactoryHeroTrialSubmoduleItem:UnBindRedPoint()
	return
end

function ActivityFactoryHeroTrialSubmoduleItem:RefreshHeroTrialBtn()
	for iter_6_0, iter_6_1 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		if ActivityData:GetActivityIsOpen(iter_6_0) and ActivityTools.GetActivityTheme(iter_6_0) == self.theme_ then
			self.activityId_ = iter_6_0
		end
	end

	if manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.FACTORY_HERO_TRIAL))) or manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.FACTORY_HERO_TRIAL_2))) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

return ActivityFactoryHeroTrialSubmoduleItem
