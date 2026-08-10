local var_0_0 = class("PushSnowBallWeeklyTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.data_ = arg_3_2
	arg_3_0.cfg_ = AssignmentCfg[arg_3_2.id]

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.SetCallBack(arg_5_0, arg_5_1)
	arg_5_0.callback = arg_5_1
end

function var_0_0.SetCheckCallBack(arg_6_0, arg_6_1)
	arg_6_0.checkCallBack_ = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshItem()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshItem(arg_8_0)
	arg_8_0.titleText_.text = arg_8_0.cfg_.name
	arg_8_0.descText_.text = arg_8_0.cfg_.desc
	arg_8_0.processText_.text = math.min(arg_8_0.data_.progress, AssignmentCfg[arg_8_0.cfg_.id].need) .. "/" .. AssignmentCfg[arg_8_0.cfg_.id].need
end

function var_0_0.RefreshState(arg_9_0)
	if not (arg_9_0.cfg_.need <= arg_9_0.data_.progress) then
		arg_9_0.rewardState_:SetSelectedState("normal")
	else
		arg_9_0.rewardState_:SetSelectedState("complete")
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
