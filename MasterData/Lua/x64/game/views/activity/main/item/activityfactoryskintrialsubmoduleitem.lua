ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivityFactorySkinTrialSubmoduleItem = class("ActivityFactorySkinTrialSubmoduleItem", ActivitySubmoduleItem)

function ActivityFactorySkinTrialSubmoduleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityId_ = arg_1_2
	self.theme_ = ActivityTools.GetActivityTheme(self.activityId_)
	self.refreshSkinTrialBtnHandler = handler(self, self.RefreshSkinTrialBtn)

	self:InitUI()
end

function ActivityFactorySkinTrialSubmoduleItem:OnEnter()
	manager.notify:RegistListener(SKIN_TRIAL_UPDATE, self.refreshSkinTrialBtnHandler)
	self:RefreshSkinTrialBtn()
	self.super.OnEnter(self)
end

function ActivityFactorySkinTrialSubmoduleItem:OnExit()
	self.super.OnExit(self)
	manager.notify:RemoveListener(SKIN_TRIAL_UPDATE, self.refreshSkinTrialBtnHandler)
end

function ActivityFactorySkinTrialSubmoduleItem:RefreshSkinTrialBtn()
	for iter_4_0, iter_4_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_TRIAL]) do
		if ActivityData:GetActivityIsOpen(iter_4_1) and ActivityTools.GetActivityTheme(iter_4_1) == self.theme_ then
			self.activityId_ = iter_4_1
		end
	end

	if manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA))) or manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA))) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function ActivityFactorySkinTrialSubmoduleItem:BindRedPoint()
	return
end

function ActivityFactorySkinTrialSubmoduleItem:UnBindRedPoint()
	return
end

return ActivityFactorySkinTrialSubmoduleItem
