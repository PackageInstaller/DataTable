class = var_0_10000

local var_0_0 = "IslandShipAttrUpgradeCommand"

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

	local var_1_4 = var_2.attrKy
	local var_1_5 = {}

	pairs = var_1_10009

	local var_1_6

	if not var_2.list then
		var_1_6 = {}
	end

	for iter_1_0, iter_1_1 in var_1_10009(var_1_6) do
		table = var_1_10014

		var_1_10014.insert(var_1_5, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg = var_9

	local var_1_7 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 21605, {
		ship_id = var_1_0,
		type = var_1_4,
		item_list = var_1_5
	}, 21606, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Clone = var_2_0
			var_2_0 = var_2_0(var_0)
			getProxy = var_2
			IslandProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)
			var_2_10003 = var_2.GetIsland(var_2_10003)

			local var_2_1 = var_2.GetInventoryAgency(var_2_10003)

			var_2_10003 = 0
			pairs = var_2_10004

			local var_2_2

			if not var_0.list then
				var_2_2 = {}
			end

			for iter_2_0, iter_2_1 in var_2_10004(var_2_2) do
				IslandItem = var_2_10009
				var_2_10009 = var_2_10009.New({
					id = iter_2_0
				})
				tonumber = var_10
				var_2_10003 = var_2_10003 + var_10(var_2_10009:GetUseArg()) * iter_2_1

				var_2_1:RemoveItem(iter_2_0, iter_2_1)
			end

			IslandShipAttr = var_4

			local var_2_3 = var_4.GetAtrrName(var_1_4)
			local var_2_4 = var_0

			var_5.AddExtraAttr(var_2_4, var_2_3, var_2_10003)

			local var_2_5 = arg_1_0
			local var_2_6 = var_5.sendNotification

			GAME = var_7

			var_2_6(var_2_5, var_7.ISLNAD_SHIP_ATTR_UPGRADE_DONE)

			IslandAchievementHelper = var_2_6

			var_2_6.OnShipAttrUpgrade(var_2_0, var_0)

			pg = var_5

			local var_2_7 = var_5.GameTrackerMgr.GetInstance()
			local var_2_8 = var_5.Record

			GameTrackerBuilder = var_7

			var_2_8(var_2_7, var_7.BuildIslandShipAttrUpgrade(var_2_0, var_0))
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_10(var_2_9, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
