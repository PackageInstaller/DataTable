local var_0_0 = class("OreMinersControl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.tpl = findTF(arg_1_0._tf, "tpl")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.minerList = {}

	eachChild(findTF(arg_2_0._tf, "pos"), function(arg_3_0)
		table.insert(arg_2_0.minerList, OreMiner.New(arg_2_0.binder, cloneTplTo(arg_2_0.tpl, arg_3_0, arg_3_0.name), 1.5 + math.random()))

		return
	end)

	return
end

function var_0_0.Reset(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.minerList) do
		iter_4_1:Reset()
	end

	return
end

function var_0_0.OnTimer(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.minerList) do
		iter_5_1:OnTimer(arg_5_1)
	end

	return
end

return var_0_0
