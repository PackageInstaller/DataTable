local IslandShipBreakOutCommand = class("IslandShipBreakOutCommand", pm.SimpleCommand)

function IslandShipBreakOutCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1:GetIsland()
	local var_1_3 = var_1_2:GetCharacterAgency():GetShipById(var_1_0)

	if not var_1_1 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21601, {
		ship_id = var_1_0
	}, 21602, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs((var_1_3:GetBreakoutMatrials())) do
				var_2_0:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			local var_2_1 = Clone(var_1_3)
			local var_2_2 = var_2_1:GetSkill():IsUnlock()

			var_1_3:UpgradeBreakOut()

			local var_2_3 = not var_2_2 and var_1_3:GetSkill():IsUnlock()

			if not var_2_2 and var_1_3:GetSkill():IsUnlock() then
				var_1_2:GetGlobalBuffAgency():OnShipSkillUnlock(var_1_0)
				getProxy(IslandProxy):GetIsland():GetCharacterAgency():DispatchEvent(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, var_1_3.id, true)
			end

			self:sendNotification(GAME.ISLAND_SHIP_BREAKOUT_DONE, {
				newShip = var_1_3,
				oldShip = var_2_1,
				isUnlockSkill = var_2_3
			})
			IslandBookHelper.OnShipUpgradeOrBreakOut(var_1_0)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipBreakout(var_1_0, var_1_3:GetBreakLevel()))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandShipBreakOutCommand
