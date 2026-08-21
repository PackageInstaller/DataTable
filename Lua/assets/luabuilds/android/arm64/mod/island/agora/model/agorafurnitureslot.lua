local var_0_0 = class("AgoraFurnitureSlot")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.hostId = arg_1_2
	arg_1_0.userId = nil

	return
end

function var_0_0.Lock(arg_2_0, arg_2_1)
	arg_2_0.userId = arg_2_1

	return
end

function var_0_0.Release(arg_3_0)
	arg_3_0.userId = nil

	return
end

function var_0_0.IsEmpty(arg_4_0)
	return arg_4_0.userId == nil
end

function var_0_0.IsUsing(arg_5_0, arg_5_1)
	return arg_5_0.userId == arg_5_1
end

function var_0_0.GetHostId(arg_6_0)
	return arg_6_0.hostId
end

function var_0_0.GetUserId(arg_7_0)
	return arg_7_0.userId
end

return var_0_0
