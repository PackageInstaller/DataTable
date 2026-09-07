local IslandSendRoleSkinColorCommand = class("IslandSendRoleSkinColorCommand", pm.SimpleCommand)

function IslandSendRoleSkinColorCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ship_id
	local var_1_2 = var_1_0.skin_id
	local var_1_3 = var_1_0.color_id
	local var_1_4 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21619, {
		ship_id = var_1_0.ship_id,
		color_id = var_1_0.color_id
	}, 21620, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandUnlockColor(var_1_1, var_1_3))

			local var_2_0 = getProxy(IslandProxy):GetIsland()

			var_2_0:GetCharacterAgency():AddSkinColor(var_1_1, var_1_2, var_1_3)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SKIN_ALL_COLOR)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SKIN_COLOR)

			local var_2_1 = var_2_0:GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs(pg.island_skin_colordiff_template[var_1_3].cost) do
				var_2_1:RemoveItem(iter_2_1[1], iter_2_1[2])
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
			self:sendNotification(GAME.ISLAND_BUY_ROLE_SKIN_COLOR_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSendRoleSkinColorCommand
