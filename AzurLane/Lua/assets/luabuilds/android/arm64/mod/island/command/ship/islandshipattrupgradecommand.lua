local var_0_0 = class("IslandShipAttrUpgradeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_1_0.id) then
		return
	end

	local var_1_1 = var_1_0.attrKy
	local var_1_2 = var_1_0.list or {}

	for iter_1_0, iter_1_1 in pairs(var_1_2) do
		table.insert({}, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21605, {
		ship_id = var_1_0.id,
		type = var_1_1,
		item_list = {}
	}, 21606, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Clone(var_0)
			local var_2_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
			local var_2_2 = 0
			local var_2_3 = var_1_0.list or {}

			for iter_2_0, iter_2_1 in pairs(var_2_3) do
				local var_2_4 = IslandItem.New({
					id = iter_2_0
				})

				var_2_2 = var_2_2 + tonumber(var_2_4:GetUseArg()) * iter_2_1

				var_2_1:RemoveItem(iter_2_0, iter_2_1)
			end

			var_0:AddExtraAttr(IslandShipAttr.GetAtrrName(var_1_1), var_2_2)
			arg_1_0:sendNotification(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE)
			IslandAchievementHelper.OnShipAttrUpgrade(var_2_0, var_0)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipAttrUpgrade(var_2_0, var_0))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
