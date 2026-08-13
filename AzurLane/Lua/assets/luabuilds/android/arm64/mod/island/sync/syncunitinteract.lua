class = var_0_10000

local var_0_0 = var_0_10000("SyncUnitInteract")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.type = arg_1_2
	arg_1_0.owners = {}
	arg_1_0.status = -1

	return
end

function var_0_0.UpdateInfo(arg_2_0, arg_2_1)
	arg_2_0:UpdateOwner(arg_2_1.slots)

	arg_2_0.status = arg_2_1.status

	return
end

function var_0_0.SetStatus(arg_3_0, arg_3_1)
	arg_3_0.status = arg_3_1

	return
end

function var_0_0.GetStatus(arg_4_0)
	return arg_4_0.status
end

function var_0_0.InitOwner(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		arg_5_0.owners[iter_5_1.slot_id] = iter_5_1.owner_id
	end

	return
end

function var_0_0.OwnerCount(arg_6_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_6_0.owners)
end

function var_0_0.UpdateOwner(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_1
	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0 > arg_7_0.OwnerCount(var_7_1)
	local var_7_3
	local var_7_4

	if var_7_2 then
		ipairs = var_7_1

		for iter_7_0, iter_7_1 in var_7_1(arg_7_1) do
			if not arg_7_0.owners[iter_7_1.slot_id] then
				arg_7_0.owners[iter_7_1.slot_id] = iter_7_1.owner_id
				var_7_3 = iter_7_1.owner_id
				var_7_4 = iter_7_1.slot_id

				break
			end
		end
	else
		local var_7_5 = {}

		ipairs = var_1_10006

		for iter_7_2, iter_7_3 in var_1_10006(arg_7_1) do
			var_7_5[iter_7_3.slot_id] = iter_7_3.owner_id
		end

		pairs = var_6

		for iter_7_4, iter_7_5 in var_6(arg_7_0.owners) do
			if not var_7_5[iter_7_4] then
				var_7_3 = iter_7_5
				var_7_4 = iter_7_4
				arg_7_0.owners[iter_7_4] = nil

				break
			end
		end
	end

	return var_7_2, var_7_3, var_7_4
end

function var_0_0.RemoveOwner(arg_8_0, arg_8_1)
	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.owners) do
		if iter_8_1 == arg_8_1 then
			arg_8_0.owners[iter_8_0] = nil
		end
	end

	return
end

return var_0_0
