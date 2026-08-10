local var_0_0 = class("PushBoxReplayItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/pushBox", {
			map_id = arg_4_0.cfg_.param,
			activityID = arg_4_0.cfg_.main_activity,
			id = arg_4_0.id_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshData(arg_7_0, arg_7_1)
	arg_7_0.id_ = arg_7_1
	arg_7_0.cfg_ = ActivityCelebrationOrderCfg[arg_7_0.id_]
	arg_7_0.title_.text = arg_7_0.cfg_.order_title
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
