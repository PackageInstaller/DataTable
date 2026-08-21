local var_0_0 = singletonClass("DormInfomationData")
local var_0_1 = import("game.data.Dorm.DormInfomationGenerator")

function var_0_0.Init(arg_1_0)
	arg_1_0.data = {}
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	if arg_2_1.content_list then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.content_list) do
			local var_2_0 = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.content_params) do
				table.insert(var_2_0, iter_2_3)
			end

			arg_2_0.data[iter_2_1.id] = var_2_0
		end
	end

	if arg_2_1.remove_id_list then
		for iter_2_4, iter_2_5 in ipairs(arg_2_1.remove_id_list) do
			arg_2_0.data[iter_2_5] = nil
		end
	end
end

function var_0_0.GetOpenList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.data) do
		if iter_3_1 then
			table.insert(var_3_0, iter_3_0)
		end
	end

	return var_3_0
end

function var_0_0.GetMarqueeList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0:GetOpenList()

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = var_0_1:GetContent(iter_4_1)

		for iter_4_2, iter_4_3 in ipairs(var_4_2) do
			table.insert(var_4_0, iter_4_3)
		end
	end

	local var_4_3 = arg_4_0:GetDefaultMarqueeList()

	for iter_4_4, iter_4_5 in ipairs(var_4_3) do
		table.insert(var_4_0, iter_4_5)
	end

	return var_4_0
end

function var_0_0.GetDefaultMarqueeList(arg_5_0)
	local var_5_0 = {}

	if GameSetting.dorm_entry_default_key then
		for iter_5_0, iter_5_1 in ipairs(GameSetting.dorm_entry_default_key.value or {}) do
			local var_5_1, var_5_2 = GetTips(iter_5_1)

			table.insert(var_5_0, var_5_1)
		end
	end

	return var_5_0
end

function var_0_0.GetParams(arg_6_0, arg_6_1)
	return arg_6_0.data[arg_6_1] or {}
end

return var_0_0
