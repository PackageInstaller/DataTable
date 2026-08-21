local var_0_0 = class("IslandUseShipExpBookCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id

	if not getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_1_0.id) then
		return
	end

	local var_1_2 = {}
	local var_1_3 = var_1_0.list or {}

	for iter_1_0, iter_1_1 in pairs(var_1_3) do
		table.insert(var_1_2, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21607, {
		ship_id = var_1_0.id,
		item_list = var_1_2
	}, 21608, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0:GetLevel()

			var_0:AddExp(arg_2_0.add_exp)

			local var_2_1 = var_0:GetLevel()

			if var_2_0 < var_2_1 then
				IslandAchievementHelper.OnShipUpgrade(var_2_0, var_2_1)
				IslandBookHelper.OnShipUpgradeOrBreakOut(var_1_1)
				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipUpgrade(var_0.id, var_2_1))
			end

			local var_2_2 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
			local var_2_3 = var_1_0.list or {}

			for iter_2_0, iter_2_1 in pairs(var_2_3) do
				var_2_2:RemoveItem(iter_2_0, iter_2_1)
			end

			arg_1_0:sendNotification(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE)
		end

		return
	end)

	return
end

return var_0_0
