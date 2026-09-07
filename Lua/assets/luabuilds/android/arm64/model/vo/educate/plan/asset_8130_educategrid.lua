local EducateGrid = class("EducateGrid")

EducateGrid.TYPE_LOCK = -1
EducateGrid.TYPE_EMPTY = 0
EducateGrid.TYPE_PLAN = 1
EducateGrid.TYPE_PLAN_OCCUPY = 2
EducateGrid.TYPE_EVENT = 3
EducateGrid.TYPE_EVENT_OCCUPY = 4

function EducateGrid:Ctor(arg_1_1)
	self.type = arg_1_1.type
	self.id = arg_1_1.id or 0

	self:initData(arg_1_1)

	return
end

function EducateGrid:initData()
	switch(self.type, {
		[EducateGrid.TYPE_LOCK] = function()
			self.data = nil

			return
		end,
		[EducateGrid.TYPE_EMPTY] = function()
			self.data = nil

			return
		end,
		[EducateGrid.TYPE_PLAN] = function()
			self.data = EducatePlan.New(self.id)

			return
		end,
		[EducateGrid.TYPE_PLAN_OCCUPY] = function()
			self.data = EducatePlan.New(self.id)

			return
		end,
		[EducateGrid.TYPE_EVENT] = function()
			self.data = EducateSpecialEvent.New(self.id)

			return
		end,
		[EducateGrid.TYPE_EVENT_OCCUPY] = function()
			self.data = EducateSpecialEvent.New(self.id)

			return
		end
	})

	return
end

function EducateGrid:IsLock()
	return self.type == EducateGrid.TYPE_LOCK
end

function EducateGrid:IsEmpty()
	return self.type == EducateGrid.TYPE_EMPTY
end

function EducateGrid:IsPlan()
	return self.type == EducateGrid.TYPE_PLAN
end

function EducateGrid:IsPlanOccupy()
	return self.type == EducateGrid.TYPE_PLAN_OCCUPY
end

function EducateGrid:IsEvent()
	return self.type == EducateGrid.TYPE_EVENT
end

function EducateGrid:IsEventOccupy()
	return self.type == EducateGrid.TYPE_EVENT_OCCUPY
end

function EducateGrid:GetOccupyGridCnt()
	return (self:IsPlan() or self:IsPlanOccupy() or nil) and (self.data:getConfig("cost_resource3") or 1)
end

function EducateGrid:GetName()
	if self.type == EducateGrid.TYPE_PLAN then
		return self.data:getConfig("name")
	elseif self.type == EducateGrid.TYPE_EVENT then
		return self.data:getConfig("id")
	end

	return ""
end

function EducateGrid:GetPerformance()
	return self.data and self.data:GetPerformance() or ""
end

function EducateGrid:GetResult()
	return self.data and self.data:GetResult() or {}
end

return EducateGrid
