local var_0_0 = class("PolyhedronTaskTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_2, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.startTime_ = ActivityData:GetActivityData(arg_5_1).startTime

	local var_5_0 = AssignmentCfg.get_id_list_by_activity_id[arg_5_1]
	local var_5_1 = manager.time:GetLostTimeStr(arg_5_0.startTime_)

	arg_5_0.tipsText_.text = string.format(GetTips("ERROR_MATRIX_SEASON_MISSIONS_TIME"), var_5_1, #var_5_0)

	arg_5_0:Show(true)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

return var_0_0
