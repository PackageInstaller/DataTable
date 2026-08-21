local var_0_0 = class("IslandShipBreakOutCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(IslandProxy):GetIsland()

	if not getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21601, {
		ship_id = var_1_0
	}, 21602, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs((var_0:GetBreakoutMatrials())) do
				var_2_0:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			local var_2_1 = Clone(var_0)
			local var_2_2 = var_2_1:GetSkill():IsUnlock()

			var_0:UpgradeBreakOut()

			local var_2_3 = var_0:GetSkill():IsUnlock()
			local var_2_4 = not var_2_2 and var_2_3

			if not var_2_2 and var_2_3 then
				var_1_1:GetGlobalBuffAgency():OnShipSkillUnlock(var_1_0)
				getProxy(IslandProxy):GetIsland():GetCharacterAgency():DispatchEvent(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, var_0.id, true)
			end

			arg_1_0:sendNotification(GAME.ISLAND_SHIP_BREAKOUT_DONE, {
				newShip = var_0,
				oldShip = var_2_1,
				isUnlockSkill = var_2_4
			})
			IslandBookHelper.OnShipUpgradeOrBreakOut(var_1_0)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipBreakout(var_1_0, var_0:GetBreakLevel()))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
