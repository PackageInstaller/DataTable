local var_0_0 = class("GuildActivityRatePremissItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.ID_ = arg_4_1
	arg_4_0.activityID_ = arg_4_2

	local var_4_0, var_4_1, var_4_2 = GuildActivityTools.IsConditionAchieved(arg_4_0.ID_)

	arg_4_0.curNum_ = var_4_1
	arg_4_0.needNum_ = var_4_2
	arg_4_0.currentText_.text = arg_4_0.curNum_
	arg_4_0.targetText_.text = string.format("/%d", var_4_2)

	SetActive(arg_4_0.completeFlagGo_, var_4_0)

	arg_4_0.descText_.text = GetI18NText(ConditionCfg[arg_4_0.ID_].desc)
end

return var_0_0
