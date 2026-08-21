ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("ActivitySkinTrialSubmoduleItem", ActivitySubmoduleItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityId_ = ActivityTools.GetReprintActivityID(arg_1_2)
	arg_1_0.theme_ = ActivityTools.GetActivityTheme(arg_1_0.activityId_)
	arg_1_0.refreshSkinTrialBtnHandler = handler(arg_1_0, arg_1_0.RefreshSkinTrialBtn)

	arg_1_0:InitUI()
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(SKIN_TRIAL_UPDATE, arg_2_0.refreshSkinTrialBtnHandler)
	arg_2_0:RefreshSkinTrialBtn()
	arg_2_0.super.OnEnter(arg_2_0)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(SKIN_TRIAL_UPDATE, arg_3_0.refreshSkinTrialBtnHandler)
end

function var_0_0.RefreshSkinTrialBtn(arg_4_0)
	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_TRIAL]) do
		if ActivityData:GetActivityIsOpen(iter_4_1) and ActivityTools.GetActivityTheme(iter_4_1) == arg_4_0.theme_ then
			arg_4_0.activityId_ = iter_4_1
		end
	end
end

return var_0_0
