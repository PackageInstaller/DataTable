local FSMInjector = class("FSMInjector", (import("...patterns.observer.Notifier")))
local StateMachine = import(".StateMachine")
local State = import(".State")

function FSMInjector:Ctor(arg_1_1)
	FSMInjector.super.Ctor(self)

	self.fsm = arg_1_1

	return
end

function FSMInjector:inject()
	local var_2_0 = StateMachine.New()

	for iter_2_0, iter_2_1 in ipairs((self:getStates())) do
		var_2_0:registerState(iter_2_1, self:isInitial(iter_2_1.name))
	end

	self.facade:registerMediator(var_2_0)

	return
end

function FSMInjector:getStates()
	if self.stateList == nil then
		self.stateList = {}

		for iter_3_0, iter_3_1 in ipairs(self.fsm.state or {}) do
			table.insert(self.stateList, (self:createState(iter_3_1)))
		end
	end

	return self.stateList
end

function FSMInjector:createState(arg_4_1)
	local var_4_0 = State.New(arg_4_1["@name"], arg_4_1["@entering"], arg_4_1["@exiting"], arg_4_1["@changed"])

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.transition or {}) do
		var_4_0:defineTrans(iter_4_1["@action"], iter_4_1["@target"])
	end

	return var_4_0
end

function FSMInjector:isInitial(arg_5_1)
	return arg_5_1 == self.fsm["@initial"]
end

return FSMInjector
