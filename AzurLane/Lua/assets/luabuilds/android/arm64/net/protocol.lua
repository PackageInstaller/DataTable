pg = pg or {}
pg.Protocol = class("Protocol")

function pg.Protocol.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_1 ~= nil and arg_1_2 ~= nil and arg_1_3 ~= nil, "pg.Protocol:Ctor invalid argument")

	arg_1_0._id = arg_1_1
	arg_1_0._name = arg_1_2
	arg_1_0._object = arg_1_3

	return
end

function pg.Protocol.GetMessage(arg_2_0)
	assert(arg_2_0._name ~= nil and arg_2_0._object ~= nil, "pg.Protocol:GetMessage object and name must not be nil")

	return arg_2_0._object[arg_2_0._name]()
end

function pg.Protocol.GetId(arg_3_0)
	return arg_3_0._id
end

function pg.Protocol.GetName(arg_4_0)
	return arg_4_0._name
end

return
