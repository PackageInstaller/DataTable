class = var_0_10000

local var_0_0 = "IslandEvent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_map_event_data
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id

	return
end

function var_0_1.CheckTrigger(arg_3_0, arg_3_1)
	if arg_3_0:getConfig("type") == 2 then
		underscore = var_2

		local var_3_0 = var_2.detect(arg_3_0:getConfig("params"), function(arg_4_0)
			return arg_4_0[1] == arg_3_1
		end)

		assert = var_3

		local var_3_1 = var_3_0

		string = var_5

		var_3(var_3_1, var_5.format("event_%d without params option_%d", arg_3_0.id, arg_3_1))

		if var_3_0[2] then
			local var_3_2 = {}

			unpack = var_3_1

			local var_3_3, var_3_4, var_3_5 = var_3_1(var_3_0[2])

			var_3_2.count = var_3_5
			var_3_2.id = var_3_4
			var_3_2.type = var_3_3
			assert = var_3_3

			local var_3_6 = var_3_2.type

			DROP_TYPE_RESOURCE = var_3_5

			local var_3_9

			if var_3_6 ~= var_3_5 then
				local var_3_7 = var_3_2.type

				DROP_TYPE_ITEM = var_3_5

				if var_3_7 ~= var_3_5 then
					local var_3_8 = var_3_2.type

					DROP_TYPE_USE_ACTIVITY_DROP = var_3_5

					if not (var_3_5 < var_3_8) then
						var_3_9 = false

						goto label_3_0
					end
				end
			end

			var_3_9 = true

			::label_3_0::

			var_3_3(var_3_9, "error config cosume type")

			if var_3_2:getOwnedCount() < var_3_2.count then
				local var_3_10 = false

				i18n = var_5

				local var_3_11 = var_5("common_no_item_1")

				return
			end
		end
	end

	return true
end

function var_0_1.AfterTrigger(arg_5_0, arg_5_1)
	if arg_5_0:getConfig("type") == 2 then
		underscore = var_2

		if var_2.detect(arg_5_0:getConfig("params"), function(arg_6_0)
			return arg_6_0[1] == arg_5_1
		end)[2] then
			unpack = var_3

			local var_5_0, var_5_1, var_5_2 = var_3(var_2[2])

			switch = var_1_10006

			local var_5_3 = var_5_0
			local var_5_4 = {}

			DROP_TYPE_RESOURCE = var_1_10009
			var_5_4[var_1_10009] = function()
				getProxy = var_2_10000
				PlayerProxy = var_2_10001

				local var_7_0 = var_2_10000(var_2_10001)
				local var_7_1 = var_0.getData(var_7_0)
				local var_7_2 = var_1.consume
				local var_7_3 = {}

				id2res = var_2_10005
				var_7_3[var_2_10005(var_5_1)] = var_5_2

				var_7_2(var_7_1, var_7_3)
				var_0:updatePlayer(var_1)

				return
			end
			DROP_TYPE_ITEM = var_1_10009
			var_5_4[var_1_10009] = function()
				getProxy = var_2_10000
				BagProxy = var_2_10001

				local var_8_0 = var_2_10000(var_2_10001)

				var_0.removeItemById(var_8_0, var_5_1, var_5_2)

				return
			end

			var_1_10006(var_5_3, var_5_4, function()
				assert = var_2_10000

				local var_9_0 = var_5_0

				DROP_TYPE_USE_ACTIVITY_DROP = var_2_10002

				var_2_10000(var_2_10002 < var_9_0)

				getProxy = var_2_10000
				ActivityProxy = var_1

				local var_9_1 = var_2_10000(var_1)
				local var_9_2 = var_0.getActivityById

				pg = var_2_10003

				local var_9_3 = var_9_2(var_9_1, var_2_10003.activity_drop_type[var_5_0].activity_id)

				var_1.addVitemNumber(var_9_3, var_5_1, -var_5_2)
				var_0:updateActivity(var_1)

				return
			end)
		end
	end

	return
end

return var_0_1
