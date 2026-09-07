local View = import(".View")
local Observer = import("..patterns.observer.Observer")
local Controller = class("Controller")

function Controller:Ctor(arg_1_1)
	if Controller.instanceMap[arg_1_1] ~= nil then
		error(Controller.MULTITON_MSG)
	end

	self.multitonKey = arg_1_1
	Controller.instanceMap[self.multitonKey] = self
	self.commandMap = {}

	self:initializeController()

	return
end

function Controller:initializeController()
	self.view = View.getInstance(self.multitonKey)

	return
end

function Controller:getInstance()
	if self == nil then
		return nil
	end

	if Controller.instanceMap[self] == nil then
		return Controller.New(self)
	else
		return Controller.instanceMap[self]
	end

	return
end

function Controller:executeCommand(arg_4_1)
	local var_4_0 = self.commandMap[arg_4_1:getName()]

	if var_4_0 == nil then
		return
	end

	local var_4_1 = var_4_0.New()

	var_4_1:initializeNotifier(self.multitonKey)
	var_4_1:execute(arg_4_1)

	return
end

function Controller:registerCommand(arg_5_1, arg_5_2)
	if self.commandMap[arg_5_1] == nil then
		self.view:registerObserver(arg_5_1, Observer.New(self.executeCommand, self))
	end

	self.commandMap[arg_5_1] = arg_5_2

	return
end

function Controller:hasCommand(arg_6_1)
	return self.commandMap[arg_6_1] ~= nil
end

function Controller:removeCommand(arg_7_1)
	if self:hasCommand(arg_7_1) then
		self.view:removeObserver(arg_7_1, self)

		self.commandMap[arg_7_1] = nil
	end

	return
end

function Controller:removeController()
	Controller.instanceMap[self] = nil

	return
end

Controller.instanceMap = {}
Controller.MULTITON_MSG = "controller key for this Multiton key already constructed"

return Controller
