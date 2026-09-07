local IslandUpgradeAgoraCommand = class("IslandUpgradeAgoraCommand", pm.SimpleCommand)

function IslandUpgradeAgoraCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland()
	local var_1_2 = var_1_1:GetAgoraAgency()

	if not var_1_2:CanUpgrade() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_max_level"))

		return
	end

	local var_1_3 = var_1_2:GetUpgradeConsume()

	if var_1_3 and var_1_1:GetInventoryAgency():GetOwnCount(var_1_3.id) < var_1_3.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21305, {
		type = 0
	}, 21306, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:Upgrade()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandAgoraUpgrade(var_1_2:GetLevel()))

			if var_1_3 then
				self:sendNotification(GAME.CONSUME_ITEM, var_1_3)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandUpgradeAgoraCommand
