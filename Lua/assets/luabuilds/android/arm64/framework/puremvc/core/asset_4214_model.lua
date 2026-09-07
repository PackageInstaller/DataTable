local Model = class("Model")

function Model:Ctor(arg_1_1)
	if Model.instanceMap[arg_1_1] then
		error(Model.MULTITON_MSG)
	end

	self.multitonKey = arg_1_1
	Model.instanceMap[arg_1_1] = self
	self.proxyMap = {}

	self:initializeModel()

	return
end

function Model:initializeModel()
	return
end

function Model:getInstance()
	if self == nil then
		return nil
	end

	if Model.instanceMap[self] == nil then
		return Model.New(self)
	else
		return Model.instanceMap[self]
	end

	return
end

function Model:registerProxy(arg_4_1)
	arg_4_1:initializeNotifier(self.multitonKey)

	self.proxyMap[arg_4_1:getProxyName()] = arg_4_1

	arg_4_1:onRegister()

	return
end

function Model:retrieveProxy(arg_5_1)
	return self.proxyMap[arg_5_1]
end

function Model:hasProxy(arg_6_1)
	return self.proxyMap[arg_6_1] ~= nil
end

function Model:removeProxy(arg_7_1)
	if self.proxyMap[arg_7_1] ~= nil then
		self.proxyMap[arg_7_1] = nil

		self.proxyMap[arg_7_1]:onRemove()
	end

	return self.proxyMap[arg_7_1]
end

function Model:removeModel()
	Model.instanceMap[self] = nil

	return
end

Model.instanceMap = {}
Model.MULTITON_MSG = "Model instance for this Multiton key already constructed!"

return Model
