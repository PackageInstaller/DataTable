local var_0_0 = class("BaseReactor")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.responder = arg_1_3
	arg_1_0._tf = arg_1_2
	arg_1_0.callDic = {}
	arg_1_0.rangeDic = {}

	arg_1_0:Init(arg_1_1)
	arg_1_0.responder:CreateCall(arg_1_0)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	return
end

function var_0_0.Register(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	assert(arg_3_3)

	arg_3_0.callDic[arg_3_1] = arg_3_2
	arg_3_0.rangeDic[arg_3_1] = underscore.map(arg_3_3, function(arg_4_0)
		return NewPos(unpack(arg_4_0))
	end)

	arg_3_0.responder:AddListener(arg_3_1, arg_3_0, arg_3_0.rangeDic[arg_3_1])

	return
end

function var_0_0.Deregister(arg_5_0, arg_5_1)
	arg_5_0.responder:RemoveListener(arg_5_1, arg_5_0, arg_5_0.rangeDic[arg_5_1])

	arg_5_0.callDic[arg_5_1] = nil
	arg_5_0.rangeDic[arg_5_1] = nil

	return
end

function var_0_0.DeregisterAll(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.callDic) do
		arg_6_0:Deregister(iter_6_0)
	end

	return
end

function var_0_0.Calling(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.responder:EventCall(arg_7_1, arg_7_2, arg_7_0, arg_7_3)

	return
end

function var_0_0.React(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.callDic[arg_8_1] then
		return
	end

	arg_8_0.callDic[arg_8_1](unpack(arg_8_2))

	return
end

function var_0_0.Destroy(arg_9_0, arg_9_1)
	arg_9_0:DeregisterAll()

	local var_9_0 = defaultValue(arg_9_1, true) and RyzaMiniGameConfig.GetDestroyPoint(arg_9_0) or 0

	arg_9_0.responder:DestroyCall(arg_9_0, var_9_0)

	arg_9_0.responder = nil
	arg_9_0.callDic = nil
	arg_9_0.rangeDic = nil

	Destroy(arg_9_0._tf)

	return
end

return var_0_0
