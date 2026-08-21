local var_0_0 = {}

function var_0_0.TryToUseItem(arg_1_0)
	local var_1_0 = {
		use_item_list = arg_1_0
	}
	local var_1_1 = true

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if ItemTools.IsItemExpired({
			id = iter_1_1.item_info.id,
			timeValid = iter_1_1.item_info.timeValid
		}) then
			var_1_1 = false

			break
		end
	end

	if var_1_1 then
		manager.net:SendWithLoadingNew(17012, var_1_0, 17013, var_0_0.OnTryToUseItem)
	else
		ShowTips("ERROR_ITEM_TIME_INVALID")
	end
end

function var_0_0.OnTryToUseItem(arg_2_0, arg_2_1)
	manager.notify:CallUpdateFunc(ON_TRY_TO_USE_ITEM, arg_2_0, arg_2_1)

	if isSuccess(arg_2_0.result) then
		manager.notify:Invoke(USE_ITEM_SUCCESS)
	end
end

function var_0_0.TryToUseItemWitchCallback(arg_3_0, arg_3_1)
	local var_3_0 = {
		use_item_list = arg_3_0
	}
	local var_3_1 = true

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if ItemTools.IsItemExpired({
			id = iter_3_1.item_info.id,
			timeValid = iter_3_1.item_info.timeValid
		}) then
			var_3_1 = false

			break
		end
	end

	if var_3_1 then
		manager.net:SendWithLoadingNew(17012, var_3_0, 17013, function(arg_4_0)
			if isSuccess(arg_4_0.result) then
				manager.notify:Invoke(USE_ITEM_SUCCESS)
				arg_3_1(arg_4_0)
			else
				ShowTips(arg_4_0.result)
			end
		end)
	else
		ShowTips("ERROR_ITEM_TIME_INVALID")
	end
end

return var_0_0
