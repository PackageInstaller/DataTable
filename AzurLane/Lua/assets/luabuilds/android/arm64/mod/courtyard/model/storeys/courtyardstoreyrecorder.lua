class = var_0_10000

local var_0_0 = var_0_10000("CourtYardStoreyRecorder")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.storey = arg_1_1
	arg_1_0.setup = false

	return
end

function var_0_0.BeginCheckChange(arg_2_0)
	arg_2_0:Reset()

	arg_2_0.setup = true

	local var_2_0 = arg_2_0.storey

	arg_2_0.headSample = var_1.ToTable(var_2_0)

	return
end

function var_0_0.TakeSample(arg_3_0)
	if not arg_3_0.setup then
		return
	end

	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = arg_3_0.storey
	local var_3_3 = var_3.GetAllFurniture(var_3_2)

	pairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_0.furnitures) do
		if not var_3_3[iter_3_1.id] then
			table = var_9

			var_9.insert(var_3_1, iter_3_1.id)
		end
	end

	pairs = var_4

	for iter_3_2, iter_3_3 in var_4(var_3_3) do
		if iter_3_3:IsDirty() then
			table = var_9

			var_9.insert(var_3_0, iter_3_3:ToTable())
		end
	end

	arg_3_0:Reset()

	return var_3_0, var_3_1
end

function var_0_0.Reset(arg_4_0)
	local var_4_0 = arg_4_0.storey

	arg_4_0.furnitures = var_1.GetAllFurniture(var_4_0)
	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.furnitures) do
		if iter_4_1:IsDirty() then
			iter_4_1:UnDirty()
		end
	end

	return
end

function var_0_0.EndCheckChange(arg_5_0)
	arg_5_0:Clear()

	return
end

function var_0_0.Clear(arg_6_0)
	arg_6_0.furnitures = nil
	arg_6_0.setup = false
	arg_6_0.headSample = nil

	return
end

function var_0_0.HasChange(arg_7_0)
	local var_7_0 = arg_7_0.storey
	local var_7_1 = var_1.ToTable(var_7_0)
	local var_7_2 = arg_7_0.headSample

	table = var_7_0

	local var_7_3 = var_7_0.getCount(var_7_1)

	table = var_1_10004

	if var_7_3 ~= var_1_10004.getCount(var_7_2) then
		return true
	end

	local function var_7_4(arg_8_0, arg_8_1)
		if not arg_8_1 then
			return false
		end

		return arg_8_0.id == arg_8_1.id and arg_8_0.dir == arg_8_1.dir and arg_8_0.parent == arg_8_1.parent and arg_8_0.position == arg_8_1.position
	end

	pairs = var_4

	for iter_7_0, iter_7_1 in var_4(var_7_1) do
		if not var_7_4(iter_7_1, var_7_2[iter_7_1.id]) then
			return true
		end
	end

	return false
end

function var_0_0.GetHeadSample(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.headSample) do
		table = var_1_10007

		var_1_10007.insert(var_9_0, iter_9_1)
	end

	table = var_2

	local var_9_1 = var_2.sort
	local var_9_2 = var_9_0

	BackyardThemeFurniture = iter_9_0

	var_9_1(var_9_2, iter_9_0._LoadWeight)

	return var_9_0
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:Clear()

	return
end

return var_0_0
