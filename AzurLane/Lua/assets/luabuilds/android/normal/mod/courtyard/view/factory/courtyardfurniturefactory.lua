class = var_0_10000

local var_0_0 = var_0_10000("CourtYardFurnitureFactory")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.poolMgr = arg_1_1
	arg_1_0.caches = {}
	arg_1_0.jobs = {}

	local function var_1_0()
		local var_2_0 = arg_1_0

		var_0.OnJobFinish(var_2_0)

		return
	end

	CourtYardFurnitureJob = var_1_10003

	local var_1_1 = var_1_10003.New(arg_1_0.poolMgr, var_1_0)

	table = var_4

	var_4.insert(arg_1_0.jobs, var_1_1)

	return
end

function var_0_0.Make(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.poolMgr
	local var_3_1 = var_2.GetFurniturePool(var_3_0)
	local var_3_2 = var_2.Dequeue(var_3_1)
	local var_3_3

	isa = var_1_10004

	local var_3_4 = arg_3_1

	CourtYardCanPutFurniture = var_1_10006

	if var_1_10004(var_3_4, var_1_10006) then
		CourtYardCanPutFurnitureModule = var_4
		var_3_3 = var_4.New(arg_3_1, var_3_2)
	else
		CourtYardFurnitureModule = var_4
		var_3_3 = var_4.New(arg_3_1, var_3_2)
	end

	table = var_4

	var_4.insert(arg_3_0.caches, {
		arg_3_1,
		var_3_3
	})

	if #arg_3_0.caches == 1 and arg_3_0:GetIdleJob() then
		var_4:Work(var_3_3, arg_3_1)
	end

	return var_3_3
end

function var_0_0.GetIdleJob(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.jobs) do
		if not iter_4_1:IsWorking() then
			return iter_4_1
		end
	end

	return
end

function var_0_0.OnJobFinish(arg_5_0)
	table = var_1_10001

	var_1_10001.remove(arg_5_0.caches, 1)

	if #arg_5_0.caches > 0 then
		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.GetIdleJob(var_5_0)

		assert = var_5_0

		var_5_0(var_5_1)

		local var_5_2 = arg_5_0.caches[1][1]
		local var_5_3 = var_2[2]

		var_5_1:Work(var_5_3, var_5_2)
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.caches = nil
	pairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.jobs) do
		iter_6_1:Stop()
	end

	arg_6_0.jobs = nil

	return
end

return var_0_0
