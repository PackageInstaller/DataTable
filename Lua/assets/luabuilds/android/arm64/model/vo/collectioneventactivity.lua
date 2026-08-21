local var_0_0 = class("CollectionEventActivity", import(".Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.collections = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.collection_list) do
		local var_1_0 = EventInfo.New(iter_1_1)

		var_1_0:SetActivityId(arg_1_0.id)
		table.insert(arg_1_0.collections, var_1_0)
	end

	return
end

function var_0_0.getDayIndex(arg_2_0)
	local var_2_0 = pg.TimeMgr.GetInstance()

	return var_2_0:DiffDay(arg_2_0.data1, (var_2_0:GetServerTime())) + 1
end

function var_0_0.GetCollectionList(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("config_data")
	local var_3_1 = arg_3_0:getDayIndex()

	arg_3_0.collections = underscore.filter(arg_3_0.collections, function(arg_4_0)
		if table.contains(arg_3_0:getData1List(), arg_4_0.id) then
			return false
		end

		if table.indexof(var_3_0, arg_4_0.id) < var_3_1 and arg_4_0:GetState() < EventInfo.StateActive then
			return false
		end

		return true
	end)

	if #arg_3_0.collections == 0 and var_3_0[var_3_1] and not table.contains(arg_3_0:getData1List(), var_3_0[var_3_1]) then
		table.insert(arg_3_0.collections, (EventInfo.New({
			finish_time = 0,
			over_time = 0,
			id = var_3_0[var_3_1],
			ship_id_list = {},
			activity_id = arg_3_0.id
		})))
	end

	return arg_3_0.collections
end

return var_0_0
