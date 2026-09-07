local StateMachine = class("StateMachine", (import("...patterns.mediator.Mediator")))

StateMachine.NAME = "StateMachine"
StateMachine.ACTION = StateMachine.NAME .. "/notes/action"
StateMachine.CHANGED = StateMachine.NAME .. "/notes/changed"
StateMachine.CANCEL = StateMachine.NAME .. "/notes/cancel"

function StateMachine:Ctor()
	StateMachine.super.Ctor(self, StateMachine.NAME, null)

	self.states = {}

	return
end

function StateMachine:onRegister()
	if self.initial ~= nil then
		self:transitionTo(self.initial, null)
	end

	return
end

function StateMachine:registerState(arg_3_1, arg_3_2)
	if arg_3_1 == nil or self.states[arg_3_1.name] ~= nil then
		return
	end

	self.states[arg_3_1.name] = arg_3_1

	if arg_3_2 then
		self.initial = arg_3_1
	end

	return
end

function StateMachine:retrieveState(arg_4_1)
	return self.states[arg_4_1]
end

function StateMachine:removeState(arg_5_1)
	if self.states[arg_5_1] == nil then
		return
	end

	self.states[arg_5_1] = nil

	return
end

function StateMachine:transitionTo(arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return
	end

	self.canceled = false

	local var_6_0 = self:getCurrentState()

	if var_6_0 ~= nil and var_6_0.exiting ~= nil then
		self:sendNotification(var_6_0.exiting, arg_6_2, arg_6_1.name)
	end

	if self.canceled then
		self.canceled = false

		return
	end

	if arg_6_1.entering ~= nil then
		self:sendNotification(arg_6_1.entering, arg_6_2)
	end

	if self.canceled then
		self.canceled = false

		return
	end

	self:setCurrentState(arg_6_1)

	if arg_6_1.changed ~= nil then
		self:sendNotification(arg_6_1.changed, arg_6_2)
	end

	self:sendNotification(StateMachine.CHANGED, arg_6_2, arg_6_1.name)

	return
end

function StateMachine:listNotificationInterests()
	return {
		StateMachine.ACTION,
		StateMachine.CANCEL
	}
end

function StateMachine:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()

	if var_8_0 == StateMachine.ACTION then
		local var_8_1 = arg_8_1:getType()
		local var_8_2 = self:getCurrentState():getTarget(var_8_1)

		if var_8_2 ~= nil then
			if self.states[var_8_2] ~= nil then
				self:transitionTo(self.states[var_8_2], arg_8_1:getBody())
			else
				print("state not found, target: " .. var_8_2)
			end
		else
			print("target not found, action: " .. var_8_1)
		end
	elseif var_8_0 == StateMachine.CANCEL then
		self.canceled = true
	end

	return
end

function StateMachine:getCurrentState()
	return self.viewComponent
end

function StateMachine:setCurrentState(arg_10_1)
	self.viewComponent = arg_10_1

	return
end

return StateMachine
