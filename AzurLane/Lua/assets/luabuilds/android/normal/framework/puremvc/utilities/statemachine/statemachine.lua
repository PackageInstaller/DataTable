import = var_0_10000

local var_0_0 = var_0_10000("...patterns.mediator.Mediator")

class = var_1

local var_0_1 = var_1("StateMachine", var_0_0)

var_0_1.NAME = "StateMachine"
var_0_1.ACTION = var_0_1.NAME .. "/notes/action"
var_0_1.CHANGED = var_0_1.NAME .. "/notes/changed"
var_0_1.CANCEL = var_0_1.NAME .. "/notes/cancel"

function var_0_1.Ctor(arg_1_0)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = var_0_1.NAME

	null = var_1_10004

	var_1_0(var_1_1, var_1_2, var_1_10004)

	arg_1_0.states = {}

	return
end

function var_0_1.onRegister(arg_2_0)
	if arg_2_0.initial ~= nil then
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.transitionTo
		local var_2_2 = arg_2_0.initial

		null = var_1_10004

		var_2_1(var_2_0, var_2_2, var_1_10004)
	end

	return
end

function var_0_1.registerState(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == nil or arg_3_0.states[arg_3_1.name] ~= nil then
		return
	end

	arg_3_0.states[arg_3_1.name] = arg_3_1

	if arg_3_2 then
		arg_3_0.initial = arg_3_1
	end

	return
end

function var_0_1.retrieveState(arg_4_0, arg_4_1)
	return arg_4_0.states[arg_4_1]
end

function var_0_1.removeState(arg_5_0, arg_5_1)
	if arg_5_0.states[arg_5_1] == nil then
		return
	end

	arg_5_0.states[arg_5_1] = nil

	return
end

function var_0_1.transitionTo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return
	end

	arg_6_0.canceled = false

	if arg_6_0:getCurrentState() ~= nil and var_3.exiting ~= nil then
		arg_6_0:sendNotification(var_3.exiting, arg_6_2, arg_6_1.name)
	end

	if arg_6_0.canceled then
		arg_6_0.canceled = false

		return
	end

	if arg_6_1.entering ~= nil then
		arg_6_0:sendNotification(arg_6_1.entering, arg_6_2)
	end

	if arg_6_0.canceled then
		arg_6_0.canceled = false

		return
	end

	arg_6_0:setCurrentState(arg_6_1)

	if arg_6_1.changed ~= nil then
		arg_6_0:sendNotification(arg_6_1.changed, arg_6_2)
	end

	arg_6_0:sendNotification(var_0_1.CHANGED, arg_6_2, arg_6_1.name)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	return {
		var_0_1.ACTION,
		var_0_1.CANCEL
	}
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	if arg_8_1:getName() == var_0_1.ACTION then
		local var_8_0 = arg_8_1:getType()
		local var_8_1 = arg_8_0:getCurrentState()

		if var_4.getTarget(var_8_1, var_8_0) ~= nil then
			if arg_8_0.states[var_4] ~= nil then
				arg_8_0:transitionTo(var_8_1, arg_8_1:getBody())
			else
				print = var_6

				var_6("state not found, target: " .. var_4)
			end
		else
			print = var_8_1

			var_8_1("target not found, action: " .. var_8_0)
		end
	elseif var_2 == var_0_1.CANCEL then
		arg_8_0.canceled = true
	end

	return
end

function var_0_1.getCurrentState(arg_9_0)
	return arg_9_0.viewComponent
end

function var_0_1.setCurrentState(arg_10_0, arg_10_1)
	arg_10_0.viewComponent = arg_10_1

	return
end

return var_0_1
