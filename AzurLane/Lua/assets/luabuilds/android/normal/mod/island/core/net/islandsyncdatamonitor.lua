class = var_0_10000

local var_0_0 = "IslandSyncDataMonitor"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMonitor"))

function var_0_1.register(arg_1_0)
	arg_1_0:on(21212, function(arg_2_0)
		local var_2_0 = arg_1_0

		if not var_1.GetIsland(var_2_0) then
			return
		end

		local var_2_1 = {}

		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.sync_ob_list) do
			SyncUnitData = var_2_10007
			var_2_10007 = var_2_10007.New(iter_2_1)
			table = var_8

			var_8.insert(var_2_1, var_2_10007)
		end

		IslandConst = var_2

		local var_2_6

		if var_2.SYNC_TEST_DELAY_ON then
			math = var_2

			local var_2_2 = var_2.random

			IslandConst = var_3

			local var_2_3 = var_3.SYNC_TEST_DELAY_L

			IslandConst = var_2_6

			local var_2_4 = var_2_2(var_2_3, var_2_6.SYNC_TEST_DELAY_R)

			LeanTween = var_2_3

			local var_2_5 = var_2_3.delayedCall

			var_2_6 = var_2_4 / 1000
			System = iter_2_0

			var_2_5(var_2_6, iter_2_0.Action(function()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.GetIsland(var_3_0)
				local var_3_2 = var_0.DispatchEvent

				IslandSyncMgr = var_3_10002

				var_3_2(var_3_1, var_3_10002.ISLAND_SYNC_DATA_UPDATE, var_2_1)

				return
			end))
		else
			local var_2_7 = arg_1_0
			local var_2_8 = var_2.GetIsland(var_2_7)
			local var_2_9 = var_2.DispatchEvent

			IslandSyncMgr = var_2_6

			var_2_9(var_2_8, var_2_6.ISLAND_SYNC_DATA_UPDATE, var_2_1)
		end

		return
	end)
	arg_1_0:on(21207, function(arg_4_0)
		local var_4_0 = arg_1_0

		if not var_1.GetIsland(var_4_0) then
			return
		end

		IslandConst = var_1

		if var_1.SYNC_TEST_DELAY_ON then
			math = var_1

			local var_4_1 = var_1.random

			IslandConst = var_4_0

			local var_4_2 = var_4_0.SYNC_TEST_DELAY_L

			IslandConst = var_2_10003

			local var_4_3 = var_4_1(var_4_2, var_2_10003.SYNC_TEST_DELAY_R)

			LeanTween = var_4_2

			local var_4_4 = var_4_2.delayedCall

			var_2_10003 = var_4_3 / 1000
			System = var_2_10004

			var_4_4(var_2_10003, var_2_10004.Action(function()
				local var_5_0 = arg_1_0
				local var_5_1 = var_0.GetIsland(var_5_0)
				local var_5_2 = var_0.DispatchEvent

				IslandSyncMgr = var_3_10002

				var_5_2(var_5_1, var_3_10002.ISLAND_SYNC_OBJ_UPDATE, arg_4_0.object_list)

				return
			end))
		else
			local var_4_5 = arg_1_0
			local var_4_6 = var_1.GetIsland(var_4_5)
			local var_4_7 = var_1.DispatchEvent

			IslandSyncMgr = var_2_10003

			var_4_7(var_4_6, var_2_10003.ISLAND_SYNC_OBJ_UPDATE, arg_4_0.object_list)
		end

		return
	end)
	arg_1_0:on(21304, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.GetIsland(var_6_0)

		getProxy = var_6_0
		IslandProxy = var_2_10003

		local var_6_2 = var_6_0(var_2_10003)
		local var_6_3 = var_2.GetIsland(var_6_2)

		pg = var_6_2

		local var_6_4 = var_6_2.m02
		local var_6_5 = var_3.sendNotification

		GAME = var_2_10005

		var_6_5(var_6_4, var_2_10005.ISLAND_EXIT, {
			id = var_6_1.id,
			callback = function()
				pg = var_3_10000

				local var_7_0 = var_3_10000.TipsMgr.GetInstance()
				local var_7_1 = var_0.ShowTips

				i18n = var_3_10002

				var_7_1(var_7_0, var_3_10002("island_visit_tip4"))

				pg = var_7_1

				local var_7_2 = var_7_1.m02
				local var_7_3 = var_0.sendNotification

				GAME = var_2

				var_7_3(var_7_2, var_2.ISLAND_ENTER, {
					id = var_6_3.id
				})

				return
			end
		})

		return
	end)

	return
end

return var_0_1
