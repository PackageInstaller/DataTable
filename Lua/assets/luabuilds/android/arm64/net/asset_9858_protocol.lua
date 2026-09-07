pg = pg or {}
pg.Protocol = class("Protocol")

function pg.Protocol.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_1 ~= nil and arg_1_2 ~= nil and arg_1_3 ~= nil, "pg.Protocol:Ctor invalid argument")

	arg_1_0._id = arg_1_1
	arg_1_0._name = arg_1_2
	arg_1_0._object = arg_1_3

	return
end

function pg.Protocol:GetMessage()
	assert(self._name ~= nil and self._object ~= nil, "pg.Protocol:GetMessage object and name must not be nil")

	return self._object[self._name]()
end

function pg.Protocol:GetId()
	return self._id
end

function pg.Protocol:GetName()
	return self._name
end

return
