local CourtYardFurniturePlaceareaDebug = class("CourtYardFurniturePlaceareaDebug")
local var_0_1 = true

function CourtYardFurniturePlaceareaDebug:Ctor(arg_1_1)
	self.furniture = arg_1_1
	self.mapGrids = {}

	self:Flush()

	return
end

function CourtYardFurniturePlaceareaDebug:GetView()
	return self.furniture:GetHost():GetBridge():GetView()
end

function CourtYardFurniturePlaceareaDebug:Flush()
	self:Clear()

	local var_3_0 = self:GetView():GetRect():Find("grids")
	local var_3_1 = var_0_1 and self.furniture:RawGetOffset() or Vector3.zero

	for iter_3_0, iter_3_1 in ipairs((self.furniture:GetCanputonPosition())) do
		local var_3_2 = self:GetView().poolMgr:GetGridPool():Dequeue()

		setParent(var_3_2, var_3_0)

		tf(var_3_2).localScale = Vector3.one
		tf(var_3_2).localPosition = CourtYardCalcUtil.Map2Local(iter_3_1) + var_3_1
		var_3_2:GetComponent(typeof(Image)).color = Color.New(0, 0, 1, 1)

		table.insert(self.mapGrids, var_3_2)
	end

	return
end

function CourtYardFurniturePlaceareaDebug:Clear()
	for iter_4_0, iter_4_1 in pairs(self.mapGrids) do
		iter_4_1:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1)

		self:GetView().poolMgr:GetGridPool():Enqueue(iter_4_1)
	end

	self.mapGrids = {}

	return
end

function CourtYardFurniturePlaceareaDebug:Dispose()
	self:Clear()

	return
end

return CourtYardFurniturePlaceareaDebug
