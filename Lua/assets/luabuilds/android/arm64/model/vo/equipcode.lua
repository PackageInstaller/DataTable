local var_0_0 = class("EquipCode", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.shipGroupId = arg_1_1.shipGroupId
	arg_1_0.str = arg_1_1.eqcode
	arg_1_0.new = arg_1_1.new
	arg_1_0.like = arg_1_1.like
	arg_1_0.evaPoint = arg_1_1.eval_point
	arg_1_0.state = arg_1_1.state

	local var_1_0 = string.split(arg_1_0.str, "&")

	arg_1_0.valid = #var_1_0 == 4 and arg_1_0.shipGroupId == tonumber(var_1_0[2], 32)
	arg_1_0.tags = {
		tonumber(var_1_0[3]),
		tonumber(var_1_0[4])
	}

	return
end

function var_0_0.IsValid(arg_2_0)
	return arg_2_0.valid
end

function var_0_0.GetLabels(arg_3_0)
	return arg_3_0.tags
end

function var_0_0.MarkLike(arg_4_0)
	arg_4_0.afterLike = true

	return
end

return var_0_0
