local var_0_0 = class("IslandEvent", import(".BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_map_event_data
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id

	return
end

function var_0_0.CheckTrigger(arg_3_0, arg_3_1)
	if arg_3_0:getConfig("type") == 2 then
		local var_3_0 = underscore.detect(arg_3_0:getConfig("params"), function(arg_4_0)
			return arg_4_0[1] == arg_3_1
		end)

		assert(var_3_0, string.format("event_%d without params option_%d", arg_3_0.id, arg_3_1))

		if var_3_0[2] then
			local var_3_1 = {}

			var_3_1.type, var_3_1.id, var_3_1.count = unpack(var_3_0[2])

			assert(var_3_1.type == DROP_TYPE_RESOURCE or var_3_1.type == DROP_TYPE_ITEM or var_3_1.type > DROP_TYPE_USE_ACTIVITY_DROP, "error config cosume type")

			if var_3_1:getOwnedCount() < var_3_1.count then
				local var_3_3 = i18n("common_no_item_1")

				return
			end
		end
	end

	return true
end

function var_0_0.AfterTrigger(arg_5_0, arg_5_1)
	if arg_5_0:getConfig("type") == 2 then
		local var_5_0 = underscore.detect(arg_5_0:getConfig("params"), function(arg_6_0)
			return arg_6_0[1] == arg_5_1
		end)

		if var_5_0[2] then
			local var_5_1, var_5_2, var_5_3 = unpack(var_5_0[2])

			switch(var_5_1, {
				[DROP_TYPE_RESOURCE] = function()
					local var_7_0 = getProxy(PlayerProxy)
					local var_7_1 = var_7_0:getData()

					var_7_1:consume({
						[id2res(var_5_2)] = var_5_3
					})
					var_7_0:updatePlayer(var_7_1)

					return
				end,
				[DROP_TYPE_ITEM] = function()
					getProxy(BagProxy):removeItemById(var_5_2, var_5_3)

					return
				end
			}, function()
				assert(var_5_1 > DROP_TYPE_USE_ACTIVITY_DROP)

				local var_9_0 = getProxy(ActivityProxy)
				local var_9_1 = var_9_0:getActivityById(pg.activity_drop_type[var_5_1].activity_id)

				var_9_1:addVitemNumber(var_5_2, -var_5_3)
				var_9_0:updateActivity(var_9_1)

				return
			end)
		end
	end

	return
end

return var_0_0
