class = var_0_10000

local var_0_0 = "CollectionEventActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.collections = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.collection_list) do
		EventInfo = var_1_10007

		local var_1_0 = var_1_10007.New(iter_1_1)

		var_1_10007.SetActivityId(var_1_0, arg_1_0.id)

		table = var_8

		var_8.insert(arg_1_0.collections, var_1_10007)
	end

	return
end

function var_0_1.getDayIndex(arg_2_0)
	local var_2_0 = arg_2_0.data1

	pg = var_1_10002

	local var_2_1 = var_1_10002.TimeMgr.GetInstance()
	local var_2_2 = var_2.GetServerTime(var_2_1)

	return var_2:DiffDay(var_2_0, var_2_2) + 1
end

function var_0_1.GetCollectionList(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("config_data")
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.getDayIndex(var_3_1)

	underscore = var_3_1
	arg_3_0.collections = var_3_1.filter(arg_3_0.collections, function(arg_4_0)
		table = var_2_10001

		local var_4_0 = var_2_10001.contains
		local var_4_1 = arg_3_0

		if var_4_0(var_2.getData1List(var_4_1), arg_4_0.id) then
			return false
		end

		table = var_1

		if var_1.indexof(var_3_0, arg_4_0.id) < var_3_2 then
			local var_4_2 = arg_4_0
			local var_4_3 = arg_4_0.GetState(var_4_2)

			EventInfo = var_4_2

			if var_4_3 < var_4_2.StateActive then
				return false
			end
		end

		return true
	end)

	if #arg_3_0.collections == 0 and var_3_0[var_3_2] then
		table = var_3

		if not var_3.contains(arg_3_0:getData1List(), var_3_0[var_3_2]) then
			EventInfo = var_3

			local var_3_3 = var_3.New({
				finish_time = 0,
				over_time = 0,
				id = var_3_0[var_3_2],
				ship_id_list = {},
				activity_id = arg_3_0.id
			})

			table = var_4

			var_4.insert(arg_3_0.collections, var_3_3)
		end
	end

	return arg_3_0.collections
end

return var_0_1
