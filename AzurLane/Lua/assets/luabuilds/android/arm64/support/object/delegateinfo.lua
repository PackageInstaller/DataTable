pg = pg or {}

local var_0_0 = class("DelegateInfo")

pg.DelegateInfo = var_0_0
var_0_0.ClientsInfo = {}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.ClientsInfo[arg_1_1] = arg_1_0
	arg_1_0.events = {}

	return
end

function var_0_0.Add(arg_2_0, arg_2_1)
	if arg_2_0 == nil then
		return
	end

	local var_2_0 = var_0_0.ClientsInfo[arg_2_0]

	assert(var_0_0.ClientsInfo[arg_2_0], "没有初始化委托处理" .. arg_2_0.__cname)

	if var_2_0 then
		var_2_0:AddEventOb(arg_2_1)
	end

	return
end

function var_0_0.AddEventOb(arg_3_0, arg_3_1)
	arg_3_0.events[arg_3_1] = true

	return
end

function var_0_0.Dispose(arg_4_0)
	assert(var_0_0.ClientsInfo[arg_4_0], "没有初始化委托处理" .. arg_4_0.__cname)

	if var_0_0.ClientsInfo[arg_4_0] then
		var_0_0.ClientsInfo[arg_4_0]:Clear()
	end

	var_0_0.ClientsInfo[arg_4_0] = nil

	return
end

function var_0_0.Clear(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.events) do
		iter_5_0:RemoveAllListeners()
	end

	arg_5_0.events = nil

	return
end

return
