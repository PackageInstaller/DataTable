local SingleEvent = class("SingleEvent", import("model.vo.BaseVO"))

SingleEvent.EVENT_TYPE = {
	DAILY = 2,
	MAIN = 1
}
SingleEvent.STORY_TYPE = {
	STORY = 1,
	BATTLE = 2
}
SingleEvent.MODE_TYPE = {
	STORY = 1,
	BATTLE = 2
}

function SingleEvent:bindConfigTable()
	return pg.activity_single_event
end

function SingleEvent:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id

	return
end

function SingleEvent:IsMain()
	return self:getConfig("type") == SingleEvent.EVENT_TYPE.MAIN
end

function SingleEvent:IsDaily()
	return self:getConfig("type") == SingleEvent.EVENT_TYPE.DAILY
end

function SingleEvent:GetType()
	return self:getConfig("type")
end

function SingleEvent:GetMode()
	return self:getConfig("mode")
end

function SingleEvent:GetName()
	return self:getConfig("name")
end

function SingleEvent:GetPos()
	return self:getConfig("pos")
end

function SingleEvent:GetIconName()
	return self:getConfig("icon")
end

function SingleEvent:GetStoryType()
	return self:getConfig("story_type")
end

function SingleEvent:GetStory()
	return self:getConfig("story")
end

function SingleEvent:GetPreEventId()
	return self:getConfig("pre_event")
end

function SingleEvent:GetOptions()
	return self:getConfig("options")
end

function SingleEvent:GetMapOptions()
	return self:getConfig("map_options")
end

return SingleEvent
