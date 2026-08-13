class = var_0_10000

local var_0_0 = "IslandUseShipExpBookCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetCharacterAgency(var_1_2)

	if not var_5.GetShipById(var_1_3, var_1_0) then
		return
	end

	local var_1_4 = {}

	pairs = var_8

	local var_1_5

	if not var_2.list then
		var_1_5 = {}
	end

	for iter_1_0, iter_1_1 in var_8(var_1_5) do
		table = var_1_10013

		var_1_10013.insert(var_1_4, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg = var_8

	local var_1_6 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 21607, {
		ship_id = var_1_0,
		item_list = var_1_4
	}, 21608, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.GetLevel(var_2_0)
			local var_2_2 = var_0

			var_2.AddExp(var_2_2, arg_2_0.add_exp)

			local var_2_3 = var_0
			local var_2_4

			if var_2_1 < var_2.GetLevel(var_2_3) then
				IslandAchievementHelper = var_2_3

				var_2_3.OnShipUpgrade(var_2_1, var_2)

				IslandBookHelper = var_2_3

				var_2_3.OnShipUpgradeOrBreakOut(var_1_0)

				pg = var_2_3
				var_2_4 = var_2_3.GameTrackerMgr.GetInstance()
				var_2_3 = var_2_3.Record
				GameTrackerBuilder = var_5

				var_2_3(var_2_4, var_5.BuildIslandShipUpgrade(var_0.id, var_2))
			end

			getProxy = var_2_3
			IslandProxy = var_2_4

			local var_2_5 = var_2_3(var_2_4)
			local var_2_6 = var_3.GetIsland(var_2_5)
			local var_2_7 = var_3.GetInventoryAgency(var_2_6)

			pairs = var_2_6

			local var_2_8

			if not var_0.list then
				var_2_8 = {}
			end

			for iter_2_0, iter_2_1 in var_2_6(var_2_8) do
				var_2_7:RemoveItem(iter_2_0, iter_2_1)
			end

			local var_2_9 = arg_1_0
			local var_2_10 = var_4.sendNotification

			GAME = var_6

			var_2_10(var_2_9, var_6.ISLAND_USE_SHIP_EXP_BOOK_DONE)
		end

		return
	end)

	return
end

return var_0_1
