local EducateEvent = class("EducateEvent", import("model.vo.BaseVO"))

EducateEvent.TYPE_PLAN = 1
EducateEvent.TYPE_OPTION = 2
EducateEvent.TYPE_BUBBLE = 3

function EducateEvent:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id

	return
end

function EducateEvent:bindConfigTable()
	return pg.child_event
end

function EducateEvent:GetPerformance()
	return self:getConfig("performance")
end

return EducateEvent
