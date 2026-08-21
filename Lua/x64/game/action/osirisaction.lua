local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

manager.net:Bind(11017, function(arg_2_0)
	var_0_0.UpdateRewardRedPoint()
end)

function var_0_0.OpenPoolBox(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(11024, {
		pool_id = arg_3_0,
		index = arg_3_1
	}, 11025, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			OsirisInfinityPoolData:OpenBox(arg_3_0, arg_3_1, arg_4_0.box_list)
			var_0_0.UpdateRewardRedPoint()
		end

		arg_3_2(arg_4_0)
	end)
end

function var_0_0.ResetPool(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(11026, {
		pool_id = arg_5_0
	}, 11027, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			OsirisInfinityPoolData:ResetPool(arg_5_0, arg_6_0.pool)
			var_0_0.UpdateRewardRedPoint()
		end

		arg_5_1(arg_6_0)
	end)
end

manager.notify:RegistListener(MATERIAL_MODIFY, function()
	var_0_0.UpdateRewardRedPoint()
end)

function var_0_0.UpdateRewardRedPoint()
	local var_8_0 = OsirisInfinityPoolData:GetPoolList()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_2 = ActivityInfinityPoolCfg[iter_8_0]

		if var_8_1[var_8_2.activity_id] == nil then
			var_8_1[var_8_2.activity_id] = 0
		end

		local var_8_3 = var_8_2.cost_item[1]
		local var_8_4 = var_8_2.cost_item[2]
		local var_8_5 = #iter_8_1.itemList + (iter_8_1.coreItem == nil and 0 or 1)

		if var_0_1(iter_8_1.openBoxList) ~= var_8_5 and var_8_4 <= ItemTools.getItemNum(var_8_3) then
			var_8_1[var_8_2.activity_id] = 1
		end
	end

	for iter_8_2, iter_8_3 in pairs(var_8_1) do
		manager.redPoint:setTip(string.format("%s_%s", "INFINITY_POOL", iter_8_2), iter_8_3)
	end
end

return var_0_0
