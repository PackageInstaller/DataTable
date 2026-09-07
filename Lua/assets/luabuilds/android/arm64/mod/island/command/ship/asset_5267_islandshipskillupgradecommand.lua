local IslandShipSkillUpgradeCommand = class("IslandShipSkillUpgradeCommand", pm.SimpleCommand)

function IslandShipSkillUpgradeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1:GetIsland()
	local var_1_3 = var_1_2:GetCharacterAgency():GetShipById(var_1_0)

	if not var_1_1 then
		return
	end

	if not var_1_3:CanUpgradeSkill() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21611, {
		ship_id = var_1_0
	}, 21612, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3:GetSkill()

			var_2_0:Upgrade()

			local var_2_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			for iter_2_0, iter_2_1 in ipairs((var_2_0:GetUpgradeMaterial())) do
				var_2_1:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			IslandAchievementHelper.OnShipSkillUpgrade(var_2_0:GetLevel())
			var_1_2:GetGlobalBuffAgency():OnShipSkillUpgrade(var_1_0)
			self:sendNotification(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipSkillUpgrade(var_1_3.id, var_2_0.id, var_2_0:GetLevel()))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandShipSkillUpgradeCommand
