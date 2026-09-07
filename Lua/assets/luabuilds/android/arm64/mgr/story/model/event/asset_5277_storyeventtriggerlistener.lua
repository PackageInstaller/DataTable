local StoryEventTriggerListener = class("StoryEventTriggerListener", pm.Mediator)

function StoryEventTriggerListener:Ctor(arg_1_1)
	self.eventList = arg_1_1

	StoryEventTriggerListener.super.Ctor(self)
	pg.m02:registerMediator(self)

	self.caches = {}

	return
end

function StoryEventTriggerListener:listNotificationInterests()
	return self.eventList
end

function StoryEventTriggerListener:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	print(var_3_0, var_3_1)

	self.caches[var_3_0] = {
		var_3_1
	}

	return
end

function StoryEventTriggerListener:Clear()
	self.caches = {}

	return
end

function StoryEventTriggerListener:ExistCache(arg_5_1)
	return self.caches[arg_5_1] ~= nil
end

function StoryEventTriggerListener:ExistArg(arg_6_1)
	return self.caches[arg_6_1][1] ~= nil
end

function StoryEventTriggerListener:GetArg(arg_7_1)
	if not self:ExistCache(arg_7_1) then
		return nil
	end

	if not self:ExistArg(arg_7_1) then
		return nil
	end

	return self.caches[arg_7_1][1]
end

function StoryEventTriggerListener:Dispose()
	self:Clear()
	pg.m02:removeMediator(self.__cname)

	return
end

return StoryEventTriggerListener
