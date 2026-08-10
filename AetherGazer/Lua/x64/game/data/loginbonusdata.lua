local var_0_0 = singletonClass("LoginBonusData")

function var_0_0.Init(arg_1_0)
	arg_1_0.finishIndexList_ = {}
	arg_1_0.isFinish_ = false
end

function var_0_0.InitBonusData(arg_2_0, arg_2_1)
	arg_2_0.finishIndexList_ = arg_2_1.stage_list

	if arg_2_0.finishIndexList_ and #arg_2_0.finishIndexList_ > 0 then
		arg_2_0.isFinish_ = true
	else
		arg_2_0.isFinish_ = false
	end
end

function var_0_0.UpdateIndexData(arg_3_0, arg_3_1)
	arg_3_0.finishIndexList_ = {}

	if arg_3_1 and arg_3_1 > 0 then
		for iter_3_0 = 1, arg_3_1 do
			table.insert(arg_3_0.finishIndexList_, iter_3_0)
		end
	end
end

function var_0_0.GetIsFinish(arg_4_0)
	return arg_4_0.isFinish_
end

function var_0_0.GetCurIndex(arg_5_0)
	if arg_5_0.finishIndexList_ and #arg_5_0.finishIndexList_ > 0 then
		if #arg_5_0.finishIndexList_ == 1 then
			return 3
		elseif #arg_5_0.finishIndexList_ == 2 then
			return 5
		end
	else
		return 1
	end

	return 5
end

return var_0_0
