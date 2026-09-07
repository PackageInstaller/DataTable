local CourtYardGridAgent = class("CourtYardGridAgent", import(".CourtYardAgent"))

function CourtYardGridAgent:Ctor(arg_1_1)
	CourtYardGridAgent.super.Ctor(self, arg_1_1)

	self.grids = {}

	return
end

function CourtYardGridAgent:Reset(arg_2_1)
	table.clear(self.grids)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = self:GetPool():Dequeue()

		var_2_0.transform:SetParent(self.selectedModule.gridsTF)

		var_2_0.transform.localScale = Vector3(1, 1, 1)

		table.insert(self.grids, var_2_0)
		self:UpdatePositionAndColor(var_2_0, iter_2_1)
	end

	return
end

function CourtYardGridAgent:Flush(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		assert(self.grids[iter_3_0])
		self:UpdatePositionAndColor(self.grids[iter_3_0], iter_3_1)
	end

	return
end

function CourtYardGridAgent:UpdatePositionAndColor(arg_4_1, arg_4_2)
	local var_4_0 = CourtYardCalcUtil.Map2Local(arg_4_2.position) + arg_4_2.offset

	arg_4_1.transform.localPosition = CourtYardCalcUtil.TrPosition2LocalPos(self.gridsTF, arg_4_1.transform.parent, Vector3(var_4_0.x, var_4_0.y, 0))
	arg_4_1:GetComponent(typeof(Image)).color = self:GetColor(arg_4_2.flag)

	return
end

function CourtYardGridAgent:Clear()
	for iter_5_0, iter_5_1 in ipairs(self.grids) do
		iter_5_1.transform.localScale = Vector3(1, 1, 1)
		iter_5_1.transform.eulerAngles = Vector3.zero
		iter_5_1:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

		self:GetPool():Enqueue(iter_5_1)
	end

	self.grids = {}

	return
end

function CourtYardGridAgent:GetPool()
	return self:GetView().poolMgr:GetGridPool()
end

function CourtYardGridAgent:GetColor(arg_7_1)
	return ({
		CourtYardConst.BACKYARD_GREEN,
		CourtYardConst.BACKYARD_RED,
		CourtYardConst.BACKYARD_BLUE
	})[arg_7_1]
end

function CourtYardGridAgent:Dispose()
	CourtYardGridAgent.super.Dispose(self)
	self:Clear()

	return
end

return CourtYardGridAgent
