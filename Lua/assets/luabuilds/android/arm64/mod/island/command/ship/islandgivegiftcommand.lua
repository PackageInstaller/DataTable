local var_0_0 = class("IslandGiveGiftCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21613, {
		ship_id = var_1_0.id,
		gift_id = var_1_0.itemId
	}, 21614, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = IslandItem.StaticGetUsageArg(var_0)
			local var_2_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_0)

			if var_2_1:IsFavoriteGift(var_0) then
				local var_2_2 = IslandConst.GIFT_INDEX_FAVORITE or IslandConst.GIFT_INDEX_COMMON

				for iter_2_0, iter_2_1 in ipairs(var_2_0) do
					if var_2_2 == iter_2_0 then
						for iter_2_2, iter_2_3 in ipairs(iter_2_1[2]) do
							({
								id = iter_2_3
							}).start_time = pg.TimeMgr.GetInstance():GetServerTime()

							var_2_1:AddStatus((IslandShipStatus.New({
								id = iter_2_3
							})))
						end

						var_2_1:AddEnergy(iter_2_1[1])
					end
				end

				getProxy(IslandProxy):GetIsland():GetInventoryAgency():RemoveItem(var_0, 1)
				arg_1_0:sendNotification(GAME.ISLAND_GIVE_GIFT_DONE)
				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipGiveGift(var_0, var_0))
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_give_gift_success"))

				if false then
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

return var_0_0
