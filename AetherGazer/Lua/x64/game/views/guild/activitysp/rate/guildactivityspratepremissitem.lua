local var_0_0 = class("GuildActivitySPRatePremissItem", ReduxView)

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

	arg_3_0.complateController = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.ID_ = arg_4_1
	arg_4_0.activityID_ = arg_4_2

	local var_4_0, var_4_1, var_4_2 = IsConditionAchieved(arg_4_0.ID_)

	arg_4_0.curNum_ = math.min(var_4_1, var_4_2)
	arg_4_0.needNum_ = var_4_2
	arg_4_0.currentText_.text = arg_4_0.curNum_
	arg_4_0.targetText_.text = string.format("/%d", var_4_2)
	arg_4_0.descText_.text = GuildActivityTools.GetGuildSpConditionDesc(arg_4_0.ID_)

	if var_4_2 <= arg_4_0.curNum_ then
		arg_4_0.complateController:SetSelectedState("true")
	else
		arg_4_0.complateController:SetSelectedState("false")
	end
end

return var_0_0
