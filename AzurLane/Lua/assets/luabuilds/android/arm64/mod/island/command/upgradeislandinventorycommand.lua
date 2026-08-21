local var_0_0 = class("UpgradeIslandInventoryCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	if not var_1_1:CanUpgrade() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_max_level"))

		return
	end

	if _.any(var_1_1:GetUpgradeConsume(), function(arg_2_0)
		local var_2_0 = Drop.New({
			type = arg_2_0[1],
			id = arg_2_0[2],
			count = arg_2_0[3]
		})

		return var_2_0:getOwnedCount() < arg_2_0[3]
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21012, {
		type = 0
	}, 21013, function(arg_3_0)
		if arg_3_0.ret == 0 then
			for iter_3_0, iter_3_1 in ipairs(var_0) do
				arg_1_0:sendNotification(GAME.CONSUME_ITEM, (Drop.New({
					type = iter_3_1[1],
					id = iter_3_1[2],
					count = iter_3_1[3]
				})))
			end

			var_1_1:Upgrade()
			arg_1_0:sendNotification(GAME.ISLAND_UPGRADE_INVENTORY_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_uprade_success"))
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandInventoryUpgrade(var_1_1:GetLevel()))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.ret] .. arg_3_0.ret)
		end

		return
	end)

	return
end

return var_0_0
