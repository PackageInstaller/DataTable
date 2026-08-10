local var_0_0 = class("ActivityTaskLevelCommonItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityID = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.GetLevelInfo(arg_3_0)
	local var_3_0, var_3_1 = SummerPubTool:GetTaskInfo()

	return var_3_0, var_3_1
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0.curLv_, arg_5_0.maxLv_ = arg_5_0:GetLevelInfo()

	if arg_5_1.type == 1 then
		arg_5_0.levelText_.text = "<size=45><color=\"#F4D179\">" .. arg_5_0.curLv_ .. "</color></size><color=\"#93847D\">/" .. arg_5_0.maxLv_ .. "</color>"
	else
		arg_5_0.levelText_.text = "<size=90><color=\"#F4D179\">" .. arg_5_0.curLv_ .. "</color></size><color=\"#93847D\">/" .. arg_5_0.maxLv_ .. "</color>"
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.taskLevelBtn_, nil, function()
		JumpTools.OpenPageByJump("/summerPubRecordTaskView")
	end)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
