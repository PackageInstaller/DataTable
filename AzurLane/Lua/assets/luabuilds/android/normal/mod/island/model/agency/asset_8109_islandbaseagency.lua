class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseAgency")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.host = arg_1_1

	arg_1_0:Init(arg_1_2)
	arg_1_0:Register()

	arg_1_0.isInit = false

	return
end

function var_0_0.GetHost(arg_2_0)
	return arg_2_0.host
end

function var_0_0.DispatchEvent(arg_3_0, arg_3_1, ...)
	local var_3_0 = arg_3_0:GetHost()

	var_2.DispatchEvent(var_3_0, arg_3_1, ...)

	return
end

function var_0_0.On(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:GetHost()

	var_3.On(var_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_0.Init(arg_5_0, arg_5_1)
	arg_5_0.isInit = true

	arg_5_0:OnInit(arg_5_1)

	return
end

function var_0_0.IsInitData(arg_6_0)
	return arg_6_0.isInit
end

function var_0_0.SetDirty(arg_7_0)
	arg_7_0.isInit = false

	return
end

function var_0_0.Register(arg_8_0)
	return
end

function var_0_0.OnInit(arg_9_0, arg_9_1)
	return
end

function var_0_0.UpdatePerDay(arg_10_0)
	return
end

function var_0_0.UpdatePerDay(arg_11_0)
	return
end

function var_0_0.UpdatePerSecond(arg_12_0)
	return
end

return var_0_0
