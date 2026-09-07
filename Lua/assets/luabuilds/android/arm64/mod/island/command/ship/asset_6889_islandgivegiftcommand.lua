local IslandGiveGiftCommand = class("IslandGiveGiftCommand", pm.SimpleCommand)

function IslandGiveGiftCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.itemId

	pg.ConnectionMgr.GetInstance():Send(21613, {
		ship_id = var_1_0.id,
		gift_id = var_1_0.itemId
	}, 21614, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = IslandItem.StaticGetUsageArg(var_1_2)
			local var_2_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_1_1)

			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				if ((var_2_1:IsFavoriteGift(var_1_2) or nil) and (IslandConst.GIFT_INDEX_FAVORITE or IslandConst.GIFT_INDEX_COMMON)) == iter_2_0 then
					for iter_2_2, iter_2_3 in ipairs(iter_2_1[2]) do
						local var_2_2 = {
							id = iter_2_3
						}

						var_2_2.start_time = pg.TimeMgr.GetInstance():GetServerTime()

						var_2_1:AddStatus((IslandShipStatus.New(var_2_2)))
					end

					var_2_1:AddEnergy(iter_2_1[1])
				end
			end

			getProxy(IslandProxy):GetIsland():GetInventoryAgency():RemoveItem(var_1_2, 1)
			self:sendNotification(GAME.ISLAND_GIVE_GIFT_DONE)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipGiveGift(var_1_1, var_1_2))
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_give_gift_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandGiveGiftCommand
