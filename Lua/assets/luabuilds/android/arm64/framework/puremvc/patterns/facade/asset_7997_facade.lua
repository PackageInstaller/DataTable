local Controller = import("...core.Controller")
local Model = import("...core.Model")
local View = import("...core.View")
local Notification = import("..observer.Notification")
local Facade = class("Facade")

function Facade:Ctor(arg_1_1)
	if Facade.instanceMap[arg_1_1] ~= nil then
		error(Facade.MULTITON_MSG)
	end

	self:initializeNotifier(arg_1_1)

	Facade.instanceMap[arg_1_1] = self

	self:initializeFacade()

	return
end

function Facade:initializeFacade()
	self:initializeModel()
	self:initializeController()
	self:initializeView()

	return
end

function Facade:getInstance()
	if self == nil then
		return nil
	end

	if Facade.instanceMap[self] == nil then
		Facade.instanceMap[self] = Facade.New(self)
	end

	return Facade.instanceMap[self]
end

function Facade:initializeController()
	if self.controller ~= nil then
		return
	end

	self.controller = Controller.getInstance(self.multitonKey)

	return
end

function Facade:initializeModel()
	if self.model ~= nil then
		return
	end

	self.model = Model.getInstance(self.multitonKey)

	return
end

function Facade:initializeView()
	if self.view ~= nil then
		return
	end

	self.view = View.getInstance(self.multitonKey)

	return
end

function Facade:registerCommand(arg_7_1, arg_7_2)
	assert(arg_7_2)
	self.controller:registerCommand(arg_7_1, arg_7_2)

	return
end

function Facade:removeCommand(arg_8_1)
	self.controller:removeCommand(arg_8_1)

	return
end

function Facade:hasCommand(arg_9_1)
	return self.controller:hasCommand(arg_9_1)
end

function Facade:registerProxy(arg_10_1)
	self.model:registerProxy(arg_10_1)

	return
end

function Facade:retrieveProxy(arg_11_1)
	return self.model:retrieveProxy(arg_11_1)
end

function Facade:removeProxy(arg_12_1)
	return (self.model ~= nil or nil) and self.model:removeProxy(arg_12_1)
end

function Facade:hasProxy(arg_13_1)
	return self.model:hasProxy(arg_13_1)
end

function Facade:registerMediator(arg_14_1)
	if self.view ~= nil then
		self.view:registerMediator(arg_14_1)
	end

	return
end

function Facade:retrieveMediator(arg_15_1)
	return self.view:retrieveMediator(arg_15_1)
end

function Facade:removeMediator(arg_16_1)
	return (self.view ~= nil or nil) and self.view:removeMediator(arg_16_1)
end

function Facade:hasMediator(arg_17_1)
	return self.view:hasMediator(arg_17_1)
end

function Facade:sendNotification(arg_18_1, arg_18_2, arg_18_3)
	self:notifyObservers(Notification.New(arg_18_1, arg_18_2, arg_18_3))

	return
end

function Facade:notifyObservers(arg_19_1)
	if self.view ~= nil then
		self.view:notifyObservers(arg_19_1)
	end

	return
end

function Facade:initializeNotifier(arg_20_1)
	self.multitonKey = arg_20_1

	return
end

function Facade:hasCore()
	return Facade.instanceMap[self] ~= nil
end

function Facade:removeCore()
	if Facade.instanceMap[self] == nil then
		return
	end

	Model.removeModel(self)
	View.removeView(self)
	Controller.removeController(self)

	Facade.instanceMap[self] = nil

	return
end

Facade.instanceMap = {}
Facade.MULTITON_MSG = "Facade instance for this Multiton key already constructed!"

return Facade
