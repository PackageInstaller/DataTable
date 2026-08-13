class = var_0_10000

local var_0_0 = "EquipCode"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.shipGroupId = arg_1_1.shipGroupId
	arg_1_0.str = arg_1_1.eqcode
	arg_1_0.new = arg_1_1.new
	arg_1_0.like = arg_1_1.like
	arg_1_0.evaPoint = arg_1_1.eval_point
	arg_1_0.state = arg_1_1.state
	string = var_2

	if #var_2.split(arg_1_0.str, "&") == 4 then
		local var_1_0 = arg_1_0.shipGroupId

		tonumber = var_4

		local var_1_1

		if var_1_0 ~= var_4(var_2[2], 32) then
			var_1_1 = false
		else
			var_1_1 = true
		end

		arg_1_0.valid = var_1_1

		local var_1_2 = {}

		tonumber = var_4
		var_1_2[1] = var_4(var_2[3])
		tonumber = var_4
		var_1_2[2] = var_4(var_2[4])
		arg_1_0.tags = var_1_2

		return
	end
end

function var_0_1.IsValid(arg_2_0)
	return arg_2_0.valid
end

function var_0_1.GetLabels(arg_3_0)
	return arg_3_0.tags
end

function var_0_1.MarkLike(arg_4_0)
	arg_4_0.afterLike = true

	return
end

return var_0_1
