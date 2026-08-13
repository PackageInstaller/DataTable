local var_0_0 = {
	GetTaskIDList = function()
		local var_1_0 = {}

		ipairs = var_1_10001
		pg = var_1_10003

		for iter_1_0, iter_1_1 in var_1_10001(var_1_10003.task_data_template.get_id_list_by_sub_type[1070]) do
			table = var_1_10006
			var_1_10006 = var_1_10006.keyof
			pg = var_1_10008

			if var_1_10006(var_1_10008.task_data_template.get_id_list_by_type[6], iter_1_1) then
				table = var_1_10006

				var_1_10006.insert(var_1_0, iter_1_1)
			end
		end

		ipairs = var_1
		pg = var_3

		for iter_1_2, iter_1_3 in var_1(var_3.task_data_template.get_id_list_by_sub_type[1071]) do
			table = var_1_10006
			var_1_10006 = var_1_10006.keyof
			pg = var_1_10008

			if var_1_10006(var_1_10008.task_data_template.get_id_list_by_type[6], iter_1_3) then
				table = var_1_10006

				var_1_10006.insert(var_1_0, iter_1_3)
			end
		end

		table = var_1

		var_1.sort(var_1_0, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)

		return var_1_0
	end
}

function var_0_0.NeedShowRedPoint()
	local var_3_0 = var_0_0.GetTaskIDList()

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_3_1 = var_1_10001(var_1_10003)

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_3_0) do
		if var_3_1:getTaskVO(iter_3_1) then
			local var_3_2 = var_7:isReceive()

			if var_7:isFinish() and not var_3_2 then
				return true
			end
		end
	end

	return false
end

function var_0_0.IsPopActivity(arg_4_0)
	local var_4_0 = var_0_0.GetTaskIDList()

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_4_1 = var_1_10002(var_1_10004)

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(var_4_0) do
		if var_4_1:getTaskVO(iter_4_1) then
			tonumber = var_1_10009

			if var_1_10009(var_8:getConfig("target_id")) == arg_4_0 then
				var_1_10009 = var_8:isReceive()

				if var_8:isFinish() and not var_1_10009 then
					return true
				end
			end
		end
	end

	return false
end

return var_0_0
