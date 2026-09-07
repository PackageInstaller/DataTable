local CourtYardStoreyRecorder = class("CourtYardStoreyRecorder")

function CourtYardStoreyRecorder:Ctor(arg_1_1)
	self.storey = arg_1_1
	self.setup = false

	return
end

function CourtYardStoreyRecorder:BeginCheckChange()
	self:Reset()

	self.setup = true
	self.headSample = self.storey:ToTable()

	return
end

function CourtYardStoreyRecorder:TakeSample()
	if not self.setup then
		return
	end

	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = self.storey:GetAllFurniture()

	for iter_3_0, iter_3_1 in pairs(self.furnitures) do
		if not var_3_2[iter_3_1.id] then
			table.insert(var_3_1, iter_3_1.id)
		end
	end

	for iter_3_2, iter_3_3 in pairs(var_3_2) do
		if iter_3_3:IsDirty() then
			table.insert(var_3_0, iter_3_3:ToTable())
		end
	end

	self:Reset()

	return var_3_0, var_3_1
end

function CourtYardStoreyRecorder:Reset()
	self.furnitures = self.storey:GetAllFurniture()

	for iter_4_0, iter_4_1 in pairs(self.furnitures) do
		if iter_4_1:IsDirty() then
			iter_4_1:UnDirty()
		end
	end

	return
end

function CourtYardStoreyRecorder:EndCheckChange()
	self:Clear()

	return
end

function CourtYardStoreyRecorder:Clear()
	self.furnitures = nil
	self.setup = false
	self.headSample = nil

	return
end

function CourtYardStoreyRecorder:HasChange()
	local var_7_0 = self.storey:ToTable()

	if table.getCount(var_7_0) ~= table.getCount(self.headSample) then
		return true
	end

	local function var_7_1(arg_8_0, arg_8_1)
		if not arg_8_1 then
			return false
		end

		return arg_8_0.id == arg_8_1.id and arg_8_0.dir == arg_8_1.dir and arg_8_0.parent == arg_8_1.parent and arg_8_0.position == arg_8_1.position
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if not var_7_1(iter_7_1, self.headSample[iter_7_1.id]) then
			return true
		end
	end

	return false
end

function CourtYardStoreyRecorder:GetHeadSample()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.headSample) do
		table.insert(var_9_0, iter_9_1)
	end

	table.sort(var_9_0, BackyardThemeFurniture._LoadWeight)

	return var_9_0
end

function CourtYardStoreyRecorder:Dispose()
	self:Clear()

	return
end

return CourtYardStoreyRecorder
