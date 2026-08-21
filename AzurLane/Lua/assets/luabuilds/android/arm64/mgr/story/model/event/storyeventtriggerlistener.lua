local var_0_0 = class("StoryEventTriggerListener", pm.Mediator)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.eventList = arg_1_1

	var_0_0.super.Ctor(arg_1_0)
	pg.m02:registerMediator(arg_1_0)

	arg_1_0.caches = {}

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return arg_2_0.eventList
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	print(var_3_0, var_3_1)

	arg_3_0.caches[var_3_0] = {
		var_3_1
	}

	return
end

function var_0_0.Clear(arg_4_0)
	arg_4_0.caches = {}

	return
end

function var_0_0.ExistCache(arg_5_0, arg_5_1)
	return arg_5_0.caches[arg_5_1] ~= nil
end

function var_0_0.ExistArg(arg_6_0, arg_6_1)
	return arg_6_0.caches[arg_6_1][1] ~= nil
end

function var_0_0.GetArg(arg_7_0, arg_7_1)
	if not arg_7_0:ExistCache(arg_7_1) then
		return nil
	end

	if not arg_7_0:ExistArg(arg_7_1) then
		return nil
	end

	return arg_7_0.caches[arg_7_1][1]
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:Clear()
	pg.m02:removeMediator(arg_8_0.__cname)

	return
end

return var_0_0
