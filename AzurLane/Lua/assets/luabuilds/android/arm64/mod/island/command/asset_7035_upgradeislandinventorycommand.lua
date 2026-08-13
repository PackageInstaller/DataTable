class = var_0_10000

local var_0_0 = "UpgradeIslandInventoryCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetIsland(var_1_1)
	local var_1_3 = var_3.GetInventoryAgency(var_1_2)

	if not var_4.CanUpgrade(var_1_3) then
		pg = var_5

		local var_1_4 = var_5.TipsMgr.GetInstance()
		local var_1_5 = var_5.ShowTips

		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("island_bag_max_level"))

		return
	end

	local var_1_6 = var_4:GetUpgradeConsume()

	_ = var_1_2

	local var_1_8

	if var_1_2.any(var_1_6, function(arg_2_0)
		Drop = var_2_10001

		local var_2_0 = var_2_10001.New({
			type = arg_2_0[1],
			id = arg_2_0[2],
			count = arg_2_0[3]
		})

		return var_1.getOwnedCount(var_2_0) < arg_2_0[3]
	end) then
		pg = var_1_8

		local var_1_7 = var_1_8.TipsMgr.GetInstance()

		var_1_8 = var_1_8.ShowTips
		i18n = var_9

		var_1_8(var_1_7, var_9("common_no_resource"))

		return
	end

	pg = var_1_8

	local var_1_9 = var_1_8.ConnectionMgr.GetInstance()

	var_6.Send(var_1_9, 21012, {
		type = 0
	}, 21013, function(arg_3_0)
		local var_3_4

		if arg_3_0.ret == 0 then
			ipairs = var_3_4

			for iter_3_0, iter_3_1 in var_3_4(var_1_6) do
				Drop = var_2_10006
				var_2_10006 = var_2_10006.New({
					type = iter_3_1[1],
					id = iter_3_1[2],
					count = iter_3_1[3]
				})

				local var_3_0 = arg_1_0
				local var_3_1 = var_7.sendNotification

				GAME = var_2_10010

				var_3_1(var_3_0, var_2_10010.CONSUME_ITEM, var_2_10006)
			end

			local var_3_2 = var_0

			var_3_4.Upgrade(var_3_2)

			local var_3_3 = arg_1_0

			var_3_4 = var_3_4.sendNotification
			GAME = iter_3_0

			var_3_4(var_3_3, iter_3_0.ISLAND_UPGRADE_INVENTORY_DONE)

			pg = var_3_4

			local var_3_5 = var_3_4.TipsMgr.GetInstance()

			var_3_4 = var_3_4.ShowTips
			i18n = iter_3_0

			var_3_4(var_3_5, iter_3_0("island_bag_uprade_success"))

			pg = var_3_4

			local var_3_6 = var_3_4.GameTrackerMgr.GetInstance()

			var_3_4 = var_3_4.Record
			GameTrackerBuilder = iter_3_0
			iter_3_0 = iter_3_0.BuildIslandInventoryUpgrade

			local var_3_7 = var_0

			var_3_4(var_3_6, iter_3_0(var_6.GetLevel(var_3_7)))
		else
			pg = var_3_4

			local var_3_8 = var_3_4.TipsMgr.GetInstance()
			local var_3_9 = var_1.ShowTips

			ERROR_MESSAGE = iter_3_0

			var_3_9(var_3_8, iter_3_0[arg_3_0.ret] .. arg_3_0.ret)
		end

		return
	end)

	return
end

return var_0_1
