class = var_0_10000

local var_0_0 = "IslandUseItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1

	if not var_2.count then
		var_1_1 = 1
	end

	local var_1_2

	if not var_2.arg then
		var_1_2 = {}
	end

	getProxy = var_1_10006
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.GetIsland(var_1_3)
	local var_1_5 = var_6.GetInventoryAgency(var_1_4)

	if var_1_1 > var_7.GetOwnCount(var_1_5, var_1_0) then
		pg = var_1_4

		local var_1_6 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10012

		var_1_4(var_1_6, var_1_10012("common_no_resource"))

		return
	end

	pg = var_1_4

	local var_1_7 = var_1_4.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 21026, {
		id = var_1_0,
		count = var_1_1,
		arg = var_1_2
	}, 21027, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			IslandDropHelper = var_2_0
			var_2_0 = var_2_0.AddItems(arg_2_0)
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.ship_list) do
				local var_2_1 = var_0
				local var_2_2 = var_7.GetCharacterAgency(var_2_1)
				local var_2_3 = var_7.AddShip

				IslandShip = var_2_10010

				var_2_3(var_2_2, var_2_10010.New(iter_2_1))
			end

			var_2_10004 = var_0

			var_2.RemoveItem(var_2_10004, var_1_0, var_1_1)

			var_2_10004 = arg_1_0

			var_2.HandleUsageEffect(var_2_10004, var_1_0, var_1_2)

			var_2_10004 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_5

			var_2_4(var_2_10004, var_5.ISLAND_USE_ITEM_DONE, {
				dropData = var_2_0
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleUsageEffect(arg_3_0, arg_3_1, arg_3_2)
	IslandItem = var_1_10003

	local var_3_0 = var_1_10003.StaticGetUsageType(arg_3_1)

	return
end

return var_0_1
