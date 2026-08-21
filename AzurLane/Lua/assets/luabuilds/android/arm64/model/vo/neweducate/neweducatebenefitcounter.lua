local var_0_0 = class("NewEducateBenefitCounter")

var_0_0.TYPE = {
	GAIN = 1,
	COST = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.group = arg_1_1.group

	arg_1_0:InitData(arg_1_1.change)

	return
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.data = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.data[iter_2_1.drop_type] = arg_2_0.data[iter_2_1.drop_type] or {}
		arg_2_0.data[iter_2_1.drop_type][iter_2_1.drop_id] = {
			[var_0_0.TYPE.GAIN] = iter_2_1.positive_counter,
			[var_0_0.TYPE.COST] = iter_2_1.negative_counter
		}
	end

	return
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.data[iter_3_1.drop_type] = arg_3_0.data[iter_3_1.drop_type] or {}

		local var_3_0 = arg_3_0.data[iter_3_1.drop_type][iter_3_1.drop_id]
		local var_3_1 = arg_3_0.data[iter_3_1.drop_type]
		local var_3_2 = iter_3_1.drop_id
		local var_3_3 = {}
		local var_3_4 = var_0_0.TYPE.GAIN

		if arg_3_0.data[iter_3_1.drop_type][iter_3_1.drop_id] then
			local var_3_5 = var_3_0[var_0_0.TYPE.GAIN] or 0

			var_3_3[var_3_4] = var_3_5 + iter_3_1.positive_counter

			local var_3_6 = var_0_0.TYPE.COST

			if var_3_0 then
				local var_3_7 = var_3_0[var_0_0.TYPE.COST] or 0

				var_3_3[var_3_6] = var_3_7 + iter_3_1.negative_counter
				var_3_1[var_3_2] = var_3_3
			end
		end
	end

	return
end

function var_0_0.GetValue(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0.data[arg_4_2] or not arg_4_0.data[arg_4_2][arg_4_3] then
		return 0
	end

	return arg_4_0.data[arg_4_2][arg_4_3][arg_4_1]
end

return var_0_0
