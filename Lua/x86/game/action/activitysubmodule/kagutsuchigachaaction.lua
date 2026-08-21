local var_0_0 = {}

manager.net:Bind(76101, function(arg_1_0)
	KagutsuchiGachaData:InitDrawData(arg_1_0)
end)

function var_0_0.StartDraw(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	manager.net:SendWithLoadingNew(76102, {
		activity_id = arg_2_2,
		draw_num = arg_2_1,
		pool_id = arg_2_3
	}, 76103, function(arg_3_0, arg_3_1)
		arg_2_0:OnGetDrawReward(arg_3_0, arg_3_1, arg_2_4)
	end)
end

function var_0_0.OnGetDrawReward(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not isSuccess(arg_4_1.result) then
		ShowTips(arg_4_1.result)

		return
	end

	KagutsuchiGachaData:RefreshData(arg_4_2.pool_id, arg_4_1.reward_list)

	local var_4_0 = arg_4_2.activity_id

	if var_4_0 == ActivityConst.KAGUTSUCHI_ACTIVITY then
		KagutsuchiWorkAction:UpdateRedPoint(var_4_0)
	end

	arg_4_3(arg_4_1, arg_4_2)
end

return var_0_0
