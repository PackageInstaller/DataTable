class = var_0_10000

local var_0_0 = "WSPool"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	tplDic = "table",
	pooltf = "userdata",
	pools = "table"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.pools = {}
	GameObject = var_2
	arg_1_0.pooltf = var_2.Find("__Pool__").transform
	arg_1_0.tplDic = {}
	eachChild = var_2
	tf = var_4

	var_2(var_4(arg_1_1), function(arg_2_0, arg_2_1)
		arg_1_0.tplDic[arg_2_0.name] = arg_2_0

		return
	end)

	setActive = var_2

	var_2(arg_1_1, false)

	return
end

function var_0_1.Dispose(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.pools) do
		_ = var_1_10006

		var_1_10006.each(iter_3_1, function(arg_4_0)
			Destroy = var_2_10001

			var_2_10001(arg_4_0)

			return
		end)
	end

	pairs = var_1

	for iter_3_2, iter_3_3 in var_1(arg_3_0.tplDic) do
		arg_3_0.tplDic[iter_3_2] = nil
	end

	arg_3_0.tplDic = nil

	arg_3_0:Clear()

	return
end

function var_0_1.Get(arg_5_0, arg_5_1)
	if not arg_5_0.pools[arg_5_1] then
		var_2[arg_5_1] = {}
	end

	local var_5_0

	if #var_3 > 0 then
		table = var_5
		var_5_0 = var_5.remove(var_3, #var_3)
	else
		Instantiate = var_5
		var_5_0 = var_5(arg_5_0.tplDic[arg_5_1])
	end

	setActive = var_5

	var_5(var_5_0, true)

	tf = var_5

	local var_5_1 = var_5(var_5_0)

	var_5.SetParent(var_5_1, arg_5_0.pooltf, false)

	return var_5_0
end

function var_0_1.Return(arg_6_0, arg_6_1, arg_6_2)
	setActive = var_1_10003

	var_1_10003(arg_6_2, false)

	local var_6_0 = arg_6_2.transform

	var_3.SetParent(var_6_0, arg_6_0.pooltf, false)

	local var_6_1 = arg_6_0.pools[arg_6_1]

	table = var_1_10004

	var_1_10004.insert(var_6_1, arg_6_2)

	return
end

return var_0_1
