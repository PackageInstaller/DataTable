local var_0_0 = class("GotoActivityBase")

function var_0_0.GetId(arg_1_0)
	return arg_1_0.activityId
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.EnableCamera(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[1]
	local var_5_1 = arg_5_1[2]

	QWorldMgr:EnableCustomCamera(var_5_0, var_5_1 or 1, QWorldCameraLayer.Activity)
end

function var_0_0.TryTeleport(arg_6_0)
	return
end

return var_0_0
