pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.Protocol = var_0_10001("Protocol")

function var_0.Protocol.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert = var_1_10004

	var_1_10004(arg_1_1 ~= nil and arg_1_2 ~= nil and arg_1_3 ~= nil, "pg.Protocol:Ctor invalid argument")

	arg_1_0._id = arg_1_1
	arg_1_0._name = arg_1_2
	arg_1_0._object = arg_1_3

	return
end

function var_0.Protocol.GetMessage(arg_2_0)
	assert = var_1_10001

	var_1_10001(arg_2_0._name ~= nil and arg_2_0._object ~= nil, "pg.Protocol:GetMessage object and name must not be nil")

	return arg_2_0._object[arg_2_0._name]()
end

function var_0.Protocol.GetId(arg_3_0)
	return arg_3_0._id
end

function var_0.Protocol.GetName(arg_4_0)
	return arg_4_0._name
end

return
