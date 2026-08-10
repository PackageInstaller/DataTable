local var_0_0 = singletonClass("NorseSurpriseGiftReceiveData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	print("抽扭蛋初始数据", 65429)

	arg_2_0.delete_list = arg_2_1.delete_list
	arg_2_0.choose_list = arg_2_1.choose_list
	arg_2_0.draw_list = arg_2_1.draw_list
	arg_2_0.result_role_id = arg_2_1.result_role_id

	arg_2_0:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	arg_2_0:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function var_0_0.SetRoleData(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2.delete_list) do
		table.insert(arg_3_0.delete_list, iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2.draw_list) do
		table.insert(arg_3_0.draw_list, iter_3_3)
	end

	arg_3_0:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function var_0_0.GetDelRoleData(arg_4_0)
	return arg_4_0.delete_list
end

function var_0_0.GetDrawRoleData(arg_5_0)
	return arg_5_0.draw_list
end

function var_0_0.GetChooseRoleData(arg_6_0)
	return arg_6_0.choose_list
end

function var_0_0.SetChooseRoleData(arg_7_0, arg_7_1)
	arg_7_0.choose_list = arg_7_1
end

function var_0_0.GetResultRoleId(arg_8_0)
	return arg_8_0.result_role_id
end

function var_0_0.SetResultRoleId(arg_9_0, arg_9_1)
	arg_9_0.result_role_id = arg_9_1
end

function var_0_0.UpdateRedPointData(arg_10_0, arg_10_1)
	local var_10_0 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, arg_10_1)
	local var_10_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN)

	manager.redPoint:setTip(var_10_0, var_10_1)

	if #arg_10_0.draw_list >= 5 or arg_10_0.result_role_id and arg_10_0.result_role_id > 0 then
		manager.redPoint:setTip(var_10_0, 0)
	end
end

function var_0_0.UpdateRedPointData2(arg_11_0, arg_11_1)
	arg_11_0:UpdateRedPointData(arg_11_1)

	local var_11_0 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, arg_11_1)

	if arg_11_0.draw_list and #arg_11_0.draw_list >= 5 then
		manager.redPoint:setTip(var_11_0, 1)
	else
		manager.redPoint:setTip(var_11_0, 0)
	end

	if arg_11_0.result_role_id and arg_11_0.result_role_id > 0 then
		manager.redPoint:setTip(var_11_0, 0)
	end
end

return var_0_0
