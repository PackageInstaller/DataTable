local var_0_0 = singletonClass("OperationData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.InitOperationOpenList(arg_1_0, arg_1_1)
	var_0_1 = cleanProtoTable(arg_1_1.id_list)
end

function var_0_0.InitFollowOpenList(arg_2_0, arg_2_1)
	var_0_2 = {}

	local var_2_0 = arg_2_1.media_list

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_0_2, iter_2_1)
	end
end

function var_0_0.GetOperationOpenList(arg_3_0)
	return var_0_1
end

function var_0_0.IsOperationOpen(arg_4_0, arg_4_1)
	if not table.keyof(var_0_1, arg_4_1) then
		return true
	end

	return false
end

function var_0_0.IsFollowOpen(arg_5_0, arg_5_1)
	return not not table.keyof(var_0_2, arg_5_1)
end

function var_0_0.SetFunctionStopIdList(arg_6_0, arg_6_1)
	var_0_3 = nullable(arg_6_1, "id_list") or {}

	manager.notify:Invoke(OPERATION_STOP_UPDATE)
end

function var_0_0.IsFunctionStoped(arg_7_0, arg_7_1)
	if table.indexof(var_0_3, arg_7_1) then
		return true
	end

	return false
end

return var_0_0
