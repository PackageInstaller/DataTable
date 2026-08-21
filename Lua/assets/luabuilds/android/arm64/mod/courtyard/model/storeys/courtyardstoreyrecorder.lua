local var_0_0 = class("CourtYardStoreyRecorder")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.storey = arg_1_1
	arg_1_0.setup = false

	return
end

function var_0_0.BeginCheckChange(arg_2_0)
	arg_2_0:Reset()

	arg_2_0.setup = true
	arg_2_0.headSample = arg_2_0.storey:ToTable()

	return
end

function var_0_0.TakeSample(arg_3_0)
	if not arg_3_0.setup then
		return
	end

	local var_3_0 = {}
	local var_3_1 = arg_3_0.storey:GetAllFurniture()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.furnitures) do
		if not var_3_1[iter_3_1.id] then
			table.insert({}, iter_3_1.id)
		end
	end

	for iter_3_2, iter_3_3 in pairs(var_3_1) do
		if iter_3_3:IsDirty() then
			table.insert(var_3_0, iter_3_3:ToTable())
		end
	end

	arg_3_0:Reset()

	return var_3_0, {}
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.furnitures = arg_4_0.storey:GetAllFurniture()

	for iter_4_0, iter_4_1 in pairs(arg_4_0.furnitures) do
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
	local var_7_0 = arg_7_0.storey:ToTable()

	if table.getCount(var_7_0) ~= table.getCount(arg_7_0.headSample) then
		return true
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if not var_7_1(iter_7_1, arg_7_0.headSample[iter_7_1.id]) then
			return true
		end
	end

	return false
end

function var_0_0.GetHeadSample(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.headSample) do
		table.insert({}, iter_9_1)
	end

	table.sort({}, BackyardThemeFurniture._LoadWeight)

	return {}
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:Clear()

	return
end

return var_0_0
