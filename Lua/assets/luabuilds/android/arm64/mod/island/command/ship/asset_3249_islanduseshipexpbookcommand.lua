local IslandUseShipExpBookCommand = class("IslandUseShipExpBookCommand", pm.SimpleCommand)

function IslandUseShipExpBookCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = getProxy(IslandProxy)
	local var_1_3 = var_1_2:GetIsland():GetCharacterAgency():GetShipById(var_1_0.id)

	if not var_1_2 then
		return
	end

	local var_1_4 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.list or {}) do
		table.insert(var_1_4, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21607, {
		ship_id = var_1_0.id,
		item_list = var_1_4
	}, 21608, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3:GetLevel()

			var_1_3:AddExp(arg_2_0.add_exp)

			local var_2_1 = var_1_3:GetLevel()

			if var_2_0 < var_2_1 then
				IslandAchievementHelper.OnShipUpgrade(var_2_0, var_2_1)
				IslandBookHelper.OnShipUpgradeOrBreakOut(var_1_1)
				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipUpgrade(var_1_3.id, var_2_1))
			end

			local var_2_2 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			for iter_2_0, iter_2_1 in pairs(var_1_0.list or {}) do
				var_2_2:RemoveItem(iter_2_0, iter_2_1)
			end

			self:sendNotification(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE)
		end

		return
	end)

	return
end

return IslandUseShipExpBookCommand
