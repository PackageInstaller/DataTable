local var_0_0 = class("SnowBallInfinityLevelItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")

	arg_3_0:AddUIListener()
end

function var_0_0.GetController(arg_4_0)
	return arg_4_0.stateController
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.selectBtn_, nil, function()
		if arg_5_0.stateController:GetSelectedState() == "lock" then
			ShowTips("INFINITY_LOCK")
		else
			arg_5_0.register(arg_5_0.index)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0.poolID = arg_7_1
	arg_7_0.index = arg_7_2
	arg_7_0.activityId = arg_7_3
	arg_7_0.register = arg_7_5
	arg_7_0.phase = arg_7_4

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.levelTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), arg_8_0.index)

	if OsirisInfinityPoolData:GetOpenPhase(arg_8_0.activityId) < arg_8_0.index then
		arg_8_0.stateController:SetSelectedState("lock")
	else
		arg_8_0.stateController:SetSelectedState(arg_8_0.index == arg_8_0.phase and "select" or "normal")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
