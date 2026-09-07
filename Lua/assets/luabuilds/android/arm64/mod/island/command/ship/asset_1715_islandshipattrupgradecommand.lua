local IslandShipAttrUpgradeCommand = class("IslandShipAttrUpgradeCommand", pm.SimpleCommand)

function IslandShipAttrUpgradeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1:GetIsland():GetCharacterAgency():GetShipById(var_1_0.id)

	if not var_1_1 then
		return
	end

	local var_1_3 = var_1_0.attrKy
	local var_1_4 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.list or {}) do
		table.insert(var_1_4, {
			id = iter_1_0,
			num = iter_1_1
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21605, {
		ship_id = var_1_0.id,
		type = var_1_3,
		item_list = var_1_4
	}, 21606, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Clone(var_1_2)
			local var_2_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
			local var_2_2 = 0

			for iter_2_0, iter_2_1 in pairs(var_1_0.list or {}) do
				var_2_2 = var_2_2 + tonumber(IslandItem.New({
					id = iter_2_0
				}):GetUseArg()) * iter_2_1

				var_2_1:RemoveItem(iter_2_0, iter_2_1)
			end

			var_1_2:AddExtraAttr(IslandShipAttr.GetAtrrName(var_1_3), var_2_2)
			self:sendNotification(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE)
			IslandAchievementHelper.OnShipAttrUpgrade(var_2_0, var_1_2)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipAttrUpgrade(var_2_0, var_1_2))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandShipAttrUpgradeCommand
