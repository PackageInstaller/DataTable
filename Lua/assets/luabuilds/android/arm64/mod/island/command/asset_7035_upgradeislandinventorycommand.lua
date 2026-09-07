local UpgradeIslandInventoryCommand = class("UpgradeIslandInventoryCommand", pm.SimpleCommand)

function UpgradeIslandInventoryCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	if not var_1_1:CanUpgrade() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_max_level"))

		return
	end

	local var_1_2 = var_1_1:GetUpgradeConsume()

	if _.any(var_1_2, function(arg_2_0)
		return Drop.New({
			type = arg_2_0[1],
			id = arg_2_0[2],
			count = arg_2_0[3]
		}):getOwnedCount() < arg_2_0[3]
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21012, {
		type = 0
	}, 21013, function(arg_3_0)
		if arg_3_0.ret == 0 then
			for iter_3_0, iter_3_1 in ipairs(var_1_2) do
				self:sendNotification(GAME.CONSUME_ITEM, (Drop.New({
					type = iter_3_1[1],
					id = iter_3_1[2],
					count = iter_3_1[3]
				})))
			end

			var_1_1:Upgrade()
			self:sendNotification(GAME.ISLAND_UPGRADE_INVENTORY_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_uprade_success"))
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandInventoryUpgrade(var_1_1:GetLevel()))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.ret] .. arg_3_0.ret)
		end

		return
	end)

	return
end

return UpgradeIslandInventoryCommand
