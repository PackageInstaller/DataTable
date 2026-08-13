class = var_0_10000

local var_0_0 = var_0_10000("BaseReactor")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.responder = arg_1_3
	arg_1_0._tf = arg_1_2
	arg_1_0.callDic = {}
	arg_1_0.rangeDic = {}

	arg_1_0:Init(arg_1_1)

	local var_1_0 = arg_1_0.responder

	var_4.CreateCall(var_1_0, arg_1_0)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	return
end

function var_0_0.Register(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	assert = var_1_10004

	var_1_10004(arg_3_3)

	arg_3_0.callDic[arg_3_1] = arg_3_2

	local var_3_0 = arg_3_0.rangeDic

	underscore = var_5
	var_3_0[arg_3_1] = var_5.map(arg_3_3, function(arg_4_0)
		NewPos = var_2_10001
		unpack = var_2_10002

		return var_2_10001(var_2_10002(arg_4_0))
	end)

	local var_3_1 = arg_3_0.responder

	var_4.AddListener(var_3_1, arg_3_1, arg_3_0, arg_3_0.rangeDic[arg_3_1])

	return
end

function var_0_0.Deregister(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.responder

	var_2.RemoveListener(var_5_0, arg_5_1, arg_5_0, arg_5_0.rangeDic[arg_5_1])

	arg_5_0.callDic[arg_5_1] = nil
	arg_5_0.rangeDic[arg_5_1] = nil

	return
end

function var_0_0.DeregisterAll(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.callDic) do
		arg_6_0:Deregister(iter_6_0)
	end

	return
end

function var_0_0.Calling(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.responder

	var_4.EventCall(var_7_0, arg_7_1, arg_7_2, arg_7_0, arg_7_3)

	return
end

function var_0_0.React(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.callDic[arg_8_1] then
		return
	end

	local var_8_0 = arg_8_0.callDic[arg_8_1]

	unpack = var_1_10004

	var_8_0(var_1_10004(arg_8_2))

	return
end

function var_0_0.Destroy(arg_9_0, arg_9_1)
	arg_9_0:DeregisterAll()

	defaultValue = var_2

	if var_2(arg_9_1, true) then
		RyzaMiniGameConfig = var_2

		local var_9_0

		if not var_2.GetDestroyPoint(arg_9_0) then
			var_9_0 = 0
		end

		local var_9_1 = arg_9_0.responder

		var_3.DestroyCall(var_9_1, arg_9_0, var_9_0)

		arg_9_0.responder = nil
		arg_9_0.callDic = nil
		arg_9_0.rangeDic = nil
		Destroy = var_3

		var_3(arg_9_0._tf)

		return
	end
end

return var_0_0
