ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("ActivityFactoryHeroTrialSubmoduleItem", ActivitySubmoduleItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityId_ = arg_1_2
	arg_1_0.theme_ = ActivityTools.GetActivityTheme(arg_1_0.activityId_)
	arg_1_0.refreshHeroTrialBtnHandler = handler(arg_1_0, arg_1_0.RefreshHeroTrialBtn)

	arg_1_0:InitUI()
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(HERO_TRIAL_UPDATE, arg_2_0.refreshHeroTrialBtnHandler)
	arg_2_0:RefreshHeroTrialBtn()
	arg_2_0.super.OnEnter(arg_2_0)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(HERO_TRIAL_UPDATE, arg_3_0.refreshHeroTrialBtnHandler)
end

function var_0_0.BindRedPoint(arg_4_0)
	return
end

function var_0_0.UnBindRedPoint(arg_5_0)
	return
end

function var_0_0.RefreshHeroTrialBtn(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		if ActivityData:GetActivityIsOpen(iter_6_0) and ActivityTools.GetActivityTheme(iter_6_0) == arg_6_0.theme_ then
			arg_6_0.activityId_ = iter_6_0
		end
	end

	local var_6_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.FACTORY_HERO_TRIAL)
	local var_6_2 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.FACTORY_HERO_TRIAL_2)

	if manager.redPoint:getTipBoolean(var_6_1) or manager.redPoint:getTipBoolean(var_6_2) then
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, false)
	end
end

return var_0_0
