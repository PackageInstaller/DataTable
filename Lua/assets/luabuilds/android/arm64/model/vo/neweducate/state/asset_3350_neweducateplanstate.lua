local NewEducatePlanState = class("NewEducatePlanState", import(".NewEducateStateBase"))

function NewEducatePlanState:Ctor(arg_1_1)
	self:SetPlans(arg_1_1.plans or {})

	self.curIdx = arg_1_1.cur_index or 0

	return
end

function NewEducatePlanState:SetPlans(arg_2_1)
	self.plans = {}
	self.idxList = {}
	self.drops = {}
	self.costs = {}
	self.curIdx = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.plans[iter_2_1.key] = iter_2_1.value

		table.insert(self.idxList, iter_2_1.key)
	end

	table.sort(self.idxList)

	return
end

function NewEducatePlanState:GetIdxList()
	return self.idxList
end

function NewEducatePlanState:GetPlans()
	return self.plans
end

function NewEducatePlanState:GetCurIdx()
	return self.curIdx
end

function NewEducatePlanState:SetNextPlanIdx()
	self.curIdx = self.curIdx == 0 and self.idxList[1] or self.idxList[table.indexof(self.idxList, self.curIdx) + 1]

	return
end

function NewEducatePlanState:SetDrops(arg_7_1)
	self.drops = arg_7_1

	return
end

function NewEducatePlanState:AddDrops(arg_8_1)
	self.drops = table.mergeArray(self.drops, arg_8_1)

	return
end

function NewEducatePlanState:GetDrops()
	return self.drops
end

function NewEducatePlanState:SetResources(arg_10_1)
	self.resources = arg_10_1

	return
end

function NewEducatePlanState:GetResources()
	return self.resources
end

function NewEducatePlanState:SetAttrs(arg_12_1)
	self.attrs = arg_12_1

	return
end

function NewEducatePlanState:GetAttrs()
	return self.attrs
end

function NewEducatePlanState:MarkFinish()
	self.curIdx = self.idxList[#self.idxList]

	return
end

function NewEducatePlanState:IsFinish()
	if #self.idxList == 0 then
		return true
	end

	return self.curIdx == self.idxList[#self.idxList]
end

function NewEducatePlanState:Reset()
	self.plans = {}
	self.idxList = {}
	self.drops = {}
	self.resources = {}
	self.attrs = {}
	self.curIdx = 0

	return
end

return NewEducatePlanState
