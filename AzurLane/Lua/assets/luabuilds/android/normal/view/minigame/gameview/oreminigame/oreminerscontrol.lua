class = var_0_10000

local var_0_0 = var_0_10000("OreMinersControl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	findTF = var_1_10003
	arg_1_0.tpl = var_1_10003(arg_1_0._tf, "tpl")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.minerList = {}
	eachChild = var_1
	findTF = var_1_10002

	var_1(var_1_10002(arg_2_0._tf, "pos"), function(arg_3_0)
		cloneTplTo = var_2_10001

		local var_3_0 = var_2_10001(arg_2_0.tpl, arg_3_0, arg_3_0.name)

		table = var_2

		local var_3_1 = var_2.insert
		local var_3_2 = arg_2_0.minerList

		OreMiner = var_4

		local var_3_3 = var_4.New
		local var_3_4 = arg_2_0.binder
		local var_3_5 = var_3_0

		math = var_2_10007

		var_3_1(var_3_2, var_3_3(var_3_4, var_3_5, 1.5 + var_2_10007.random()))

		return
	end)

	return
end

function var_0_0.Reset(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.minerList) do
		iter_4_1:Reset()
	end

	return
end

function var_0_0.OnTimer(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.minerList) do
		iter_5_1:OnTimer(arg_5_1)
	end

	return
end

return var_0_0
