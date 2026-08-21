local var_0_0 = class("CourtYardFurnitureFactory")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.poolMgr = arg_1_1
	arg_1_0.caches = {}
	arg_1_0.jobs = {}

	table.insert(arg_1_0.jobs, (CourtYardFurnitureJob.New(arg_1_0.poolMgr, function()
		arg_1_0:OnJobFinish()

		return
	end)))

	return
end

function var_0_0.Make(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.poolMgr:GetFurniturePool():Dequeue()
	local var_3_1 = isa(arg_3_1, CourtYardCanPutFurniture) and CourtYardCanPutFurnitureModule.New(arg_3_1, var_3_0) or CourtYardFurnitureModule.New(arg_3_1, var_3_0)

	table.insert(arg_3_0.caches, {
		arg_3_1,
		var_3_1
	})

	if #arg_3_0.caches == 1 then
		local var_3_2 = arg_3_0:GetIdleJob()

		if var_3_2 then
			var_3_2:Work(var_3_1, arg_3_1)
		end
	end

	return var_3_1
end

function var_0_0.GetIdleJob(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.jobs) do
		if not iter_4_1:IsWorking() then
			return iter_4_1
		end
	end

	return
end

function var_0_0.OnJobFinish(arg_5_0)
	table.remove(arg_5_0.caches, 1)

	if #arg_5_0.caches > 0 then
		local var_5_0 = arg_5_0:GetIdleJob()

		assert(var_5_0)
		var_5_0:Work(arg_5_0.caches[1][2], arg_5_0.caches[1][1])
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.caches = nil

	for iter_6_0, iter_6_1 in pairs(arg_6_0.jobs) do
		iter_6_1:Stop()
	end

	arg_6_0.jobs = nil

	return
end

return var_0_0
