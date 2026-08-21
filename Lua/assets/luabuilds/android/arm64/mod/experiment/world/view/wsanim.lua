local var_0_0 = class("WSAnim", import("...BaseEntity"))

var_0_0.Fields = {
	caches = "table"
}

function var_0_0.Setup(arg_1_0)
	arg_1_0.caches = {}

	return
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.caches) do
		iter_2_1:Dispose()
	end

	arg_2_0:Clear()

	return
end

function var_0_0.GetAnim(arg_3_0, arg_3_1)
	return arg_3_0.caches[arg_3_1]
end

function var_0_0.SetAnim(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.caches[arg_4_1] = arg_4_2

	return
end

function var_0_0.Stop(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.caches) do
		if iter_5_1.playing then
			iter_5_1:Stop()
		end
	end

	return
end

return var_0_0
