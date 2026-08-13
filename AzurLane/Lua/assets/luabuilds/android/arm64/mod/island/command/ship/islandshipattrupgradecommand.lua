class = var_0_10000

local var_0_0 = "IslandShipAttrUpgradeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	IslandProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetIsland(var_1_2)
	local var_1_4 = var_4.GetCharacterAgency(var_1_3)

	if not var_5.GetShipById(var_1_4, var_1_1) then
		return
	end

	local var_1_5 = var_2.attrKy
	local var_1_6 = {}

	pairs = var_9

	local var_1_7

	if not var_2.list then
		var_1_7 = {}
	end

	for iter_1_0, iter_1_1 in var_9(var_1_7) do
		table = var_1_10014

		var_1_10014.insert(var_1_6, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg = var_9

	local var_1_8 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_8, 21605, {
		ship_id = var_1_1,
		type = var_1_5,
		item_list = var_1_6
	}, 21606, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Clone = var_2_0
			var_2_0 = var_2_0(var_0)
			getProxy = var_2_10002
			IslandProxy = var_2_10004
			var_2_10004 = var_2_10002(var_2_10004)
			var_2_10004 = var_2.GetIsland(var_2_10004)

			local var_2_1 = var_2.GetInventoryAgency(var_2_10004)
			local var_2_2 = 0

			pairs = var_2_10004

			local var_2_3

			if not var_0.list then
				var_2_3 = {}
			end

			for iter_2_0, iter_2_1 in var_2_10004(var_2_3) do
				IslandItem = var_2_10009
				var_2_10009 = var_2_10009.New({
					id = iter_2_0
				})
				tonumber = var_2_10010
				var_2_2 = var_2_2 + var_2_10010(var_2_10009:GetUseArg()) * iter_2_1

				var_2_1:RemoveItem(iter_2_0, iter_2_1)
			end

			IslandShipAttr = var_2_10004
			var_2_10004 = var_2_10004.GetAtrrName(var_1_5)

			local var_2_4 = var_0

			var_5.AddExtraAttr(var_2_4, var_2_10004, var_2_2)

			local var_2_5 = arg_1_0
			local var_2_6 = var_5.sendNotification

			GAME = var_8

			var_2_6(var_2_5, var_8.ISLNAD_SHIP_ATTR_UPGRADE_DONE)

			IslandAchievementHelper = var_2_6

			var_2_6.OnShipAttrUpgrade(var_2_0, var_0)

			pg = var_5

			local var_2_7 = var_5.GameTrackerMgr.GetInstance()
			local var_2_8 = var_5.Record

			GameTrackerBuilder = var_8

			var_2_8(var_2_7, var_8.BuildIslandShipAttrUpgrade(var_2_0, var_0))
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_10(var_2_9, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
