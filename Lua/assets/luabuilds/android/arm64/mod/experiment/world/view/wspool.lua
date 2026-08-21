local var_0_0 = class("WSPool", import("...BaseEntity"))

var_0_0.Fields = {
	tplDic = "table",
	pooltf = "userdata",
	pools = "table"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.pools = {}
	arg_1_0.pooltf = GameObject.Find("__Pool__").transform
	arg_1_0.tplDic = {}

	eachChild(tf(arg_1_1), function(arg_2_0, arg_2_1)
		arg_1_0.tplDic[arg_2_0.name] = arg_2_0

		return
	end)
	setActive(arg_1_1, false)

	return
end

function var_0_0.Dispose(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.pools) do
		_.each(iter_3_1, function(arg_4_0)
			Destroy(arg_4_0)

			return
		end)
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.tplDic) do
		arg_3_0.tplDic[iter_3_2] = nil
	end

	arg_3_0.tplDic = nil

	arg_3_0:Clear()

	return
end

function var_0_0.Get(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.pools[arg_5_1]

	if not arg_5_0.pools[arg_5_1] then
		var_5_0 = {}
		arg_5_0.pools[arg_5_1] = {}
	end

	local var_5_1 = #var_5_0 > 0 and table.remove(var_5_0, #var_5_0) or Instantiate(arg_5_0.tplDic[arg_5_1])

	setActive(var_5_1, true)
	tf(var_5_1):SetParent(arg_5_0.pooltf, false)

	return var_5_1
end

function var_0_0.Return(arg_6_0, arg_6_1, arg_6_2)
	setActive(arg_6_2, false)
	arg_6_2.transform:SetParent(arg_6_0.pooltf, false)
	table.insert(arg_6_0.pools[arg_6_1], arg_6_2)

	return
end

return var_0_0
