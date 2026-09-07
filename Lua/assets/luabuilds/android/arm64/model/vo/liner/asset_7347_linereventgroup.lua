local LinerEventGroup = class("LinerEventGroup", import("model.vo.BaseVO"))

function LinerEventGroup:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id
	self.events = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetIds()) do
		self.events[iter_1_1] = LinerEvent.New(iter_1_1)
	end

	return
end

function LinerEventGroup:bindConfigTable()
	return pg.activity_liner_event_group
end

function LinerEventGroup:GetTitle()
	return HXSet.hxLan(self:getConfig("title"))
end

function LinerEventGroup:GetPic()
	return self:getConfig("pic")
end

function LinerEventGroup:GetEvent(arg_5_1)
	return self.events[arg_5_1]
end

function LinerEventGroup:GetEvents()
	return self.events
end

function LinerEventGroup:GetIds()
	return self:getConfig("ids")
end

function LinerEventGroup:GetEventList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.events) do
		table.insert(var_8_0, iter_8_1)
	end

	return var_8_0
end

function LinerEventGroup:GetConclusions()
	return self:getConfig("conclusion")
end

function LinerEventGroup:GetDrop()
	return Drop.Create(self:getConfig("drop_display"))
end

return LinerEventGroup
