local CourtYardFurnitureFactory = class("CourtYardFurnitureFactory")

function CourtYardFurnitureFactory:Ctor(arg_1_1)
	self.poolMgr = arg_1_1
	self.caches = {}
	self.jobs = {}

	table.insert(self.jobs, (CourtYardFurnitureJob.New(self.poolMgr, function()
		self:OnJobFinish()

		return
	end)))

	return
end

function CourtYardFurnitureFactory:Make(arg_3_1)
	local var_3_0 = self.poolMgr:GetFurniturePool():Dequeue()
	local var_3_1 = isa(arg_3_1, CourtYardCanPutFurniture) and CourtYardCanPutFurnitureModule.New(arg_3_1, var_3_0) or CourtYardFurnitureModule.New(arg_3_1, var_3_0)

	table.insert(self.caches, {
		arg_3_1,
		var_3_1
	})

	if #self.caches == 1 then
		local var_3_2 = self:GetIdleJob()

		if var_3_2 then
			var_3_2:Work(var_3_1, arg_3_1)
		end
	end

	return var_3_1
end

function CourtYardFurnitureFactory:GetIdleJob()
	for iter_4_0, iter_4_1 in ipairs(self.jobs) do
		if not iter_4_1:IsWorking() then
			return iter_4_1
		end
	end

	return
end

function CourtYardFurnitureFactory:OnJobFinish()
	table.remove(self.caches, 1)

	if #self.caches > 0 then
		local var_5_0 = self:GetIdleJob()

		assert(var_5_0)
		var_5_0:Work(self.caches[1][2], self.caches[1][1])
	end

	return
end

function CourtYardFurnitureFactory:Dispose()
	self.caches = nil

	for iter_6_0, iter_6_1 in pairs(self.jobs) do
		iter_6_1:Stop()
	end

	self.jobs = nil

	return
end

return CourtYardFurnitureFactory
