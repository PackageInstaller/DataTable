local var_0_0 = singletonClass("FukubukuroData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1 = {}

	arg_2_0:UpdateData(arg_2_1)
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1.item.num <= 0 then
			var_0_1[iter_3_1.instance_id] = nil
			var_3_0 = true
		else
			local var_3_1 = {}

			for iter_3_2, iter_3_3 in ipairs(iter_3_1.select_list) do
				table.insert(var_3_1, {
					id = iter_3_3.id,
					number = iter_3_3.num,
					timeValid = iter_3_3.time_valid
				})
			end

			var_0_1[iter_3_1.instance_id] = {
				item_id = iter_3_1.item.id,
				instance_id = iter_3_1.instance_id,
				select_list = var_3_1
			}
		end
	end

	if var_3_0 then
		manager.notify:Invoke(FUKUBURO_LIST_UPDATE)
	end
end

function var_0_0.GetFukubukuroByInstanceId(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_0.GetFukuburoList(arg_5_0)
	return var_0_1
end

function var_0_0.CheckHaveItemId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(var_0_1) do
		if arg_6_1 == iter_6_1.item_id then
			return true
		end
	end

	return false
end

return var_0_0
