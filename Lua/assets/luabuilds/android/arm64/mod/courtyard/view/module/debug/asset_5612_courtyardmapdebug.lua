local CourtYardMapDebug = class("CourtYardMapDebug")

function CourtYardMapDebug:Ctor(arg_1_1, arg_1_2)
	self.map = arg_1_1
	self.mapGrids = {}

	if arg_1_2 then
		self.r = arg_1_2.r or 0
	end

	if arg_1_2 then
		self.g = arg_1_2.g or 0
	end

	if arg_1_2 then
		self.b = arg_1_2.b or 0
	end

	self:Init()

	return
end

function CourtYardMapDebug:GetView()
	return self.map:GetHost():GetBridge():GetView()
end

function CourtYardMapDebug:Init()
	local var_3_0 = self:GetView():GetRect():Find("grids")
	local var_3_1 = self.map.sizeX
	local var_3_2 = self.map.sizeY

	for iter_3_0 = self.map.minSizeX, self.map.sizeX do
		local var_3_3 = {}

		for iter_3_1 = self.map.minSizeY, var_3_2 do
			local var_3_4 = self:GetView().poolMgr:GetGridPool():Dequeue()

			setParent(var_3_4, var_3_0)

			tf(var_3_4).localScale = Vector3.one
			tf(var_3_4).localPosition = CourtYardCalcUtil.Map2Local(Vector2(iter_3_0, iter_3_1))
			var_3_4:GetComponent(typeof(Image)).color = (iter_3_1 == var_3_2 or iter_3_0 == var_3_1) and Color.New(1, 1, 0, 0.5) or Color.New(0, 1, 0, 1)
			var_3_3[iter_3_1] = var_3_4
		end

		self.mapGrids[iter_3_0] = var_3_3
	end

	self:Flush()

	return
end

function CourtYardMapDebug:Flush()
	local var_4_0 = self.map.sizeX
	local var_4_1 = self.map.sizeY

	for iter_4_0, iter_4_1 in pairs(self.mapGrids) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			local var_4_2 = iter_4_3:GetComponent(typeof(Image))

			var_4_2.color = self.map:IsEmptyPosition(Vector2(iter_4_0, iter_4_2)) and ((iter_4_2 == var_4_1 or iter_4_0 == var_4_0) and Color.New(1, 1, 0, 0.5) or Color.New(0, 1, 0, 1)) or Color.New(self.r, self.g, self.b, var_4_2.color.a)
		end
	end

	return
end

function CourtYardMapDebug:Clear()
	for iter_5_0, iter_5_1 in pairs(self.mapGrids) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			iter_5_3:GetComponent(typeof(Image)).color = Color.New(0, 1, 0, 1)

			self:GetView().poolMgr:GetGridPool():Enqueue(iter_5_3)
		end
	end

	self.mapGrids = {}

	return
end

function CourtYardMapDebug:Dispose()
	self:Clear()

	return
end

return CourtYardMapDebug
