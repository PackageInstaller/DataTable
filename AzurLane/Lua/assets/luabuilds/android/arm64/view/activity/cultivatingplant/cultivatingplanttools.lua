local var_0_0 = {
	GetTaskIDList = function()
		for iter_1_0, iter_1_1 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1070]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_1) then
				table.insert({}, iter_1_1)
			end
		end

		for iter_1_2, iter_1_3 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1071]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_3) then
				table.insert({}, iter_1_3)
			end
		end

		table.sort({}, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)

		return {}
	end
}

;({
	GetTaskIDList = function()
		for iter_1_0, iter_1_1 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1070]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_1) then
				table.insert({}, iter_1_1)
			end
		end

		for iter_1_2, iter_1_3 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1071]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_3) then
				table.insert({}, iter_1_3)
			end
		end

		table.sort({}, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)

		return {}
	end
}).NeedShowRedPoint = function()
	local var_3_0 = getProxy(TaskProxy)

	for iter_3_0, iter_3_1 in ipairs((var_0_0.GetTaskIDList())) do
		local var_3_1 = var_3_0:getTaskVO(iter_3_1)

		if var_3_1 then
			local var_3_2 = var_3_1:isReceive()

			if var_3_1:isFinish() and not var_3_2 then
				return true
			end
		end
	end

	return false
end
;({
	GetTaskIDList = function()
		for iter_1_0, iter_1_1 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1070]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_1) then
				table.insert({}, iter_1_1)
			end
		end

		for iter_1_2, iter_1_3 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1071]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_3) then
				table.insert({}, iter_1_3)
			end
		end

		table.sort({}, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)

		return {}
	end
}).IsPopActivity = function(arg_4_0)
	local var_4_0 = getProxy(TaskProxy)

	for iter_4_0, iter_4_1 in ipairs((var_0_0.GetTaskIDList())) do
		local var_4_1 = var_4_0:getTaskVO(iter_4_1)

		if var_4_1 and tonumber(var_4_1:getConfig("target_id")) == arg_4_0 then
			local var_4_2 = var_4_1:isReceive()

			if var_4_1:isFinish() and not var_4_2 then
				return true
			end
		end
	end

	return false
end

return {
	GetTaskIDList = function()
		for iter_1_0, iter_1_1 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1070]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_1) then
				table.insert({}, iter_1_1)
			end
		end

		for iter_1_2, iter_1_3 in ipairs(pg.task_data_template.get_id_list_by_sub_type[1071]) do
			if table.keyof(pg.task_data_template.get_id_list_by_type[6], iter_1_3) then
				table.insert({}, iter_1_3)
			end
		end

		table.sort({}, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)

		return {}
	end
}
