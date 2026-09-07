local UpgradeIslandCommand = class("UpgradeIslandCommand", pm.SimpleCommand)

function UpgradeIslandCommand:execute(arg_1_1)
	self:DoUpgrade(arg_1_1:getBody().callback)

	return
end

function UpgradeIslandCommand:DoUpgrade(arg_2_1)
	if not getProxy(IslandProxy):GetIsland():CanLevelUp() then
		arg_2_1()

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21000, {
		type = 0
	}, 21001, function(arg_3_0)
		if arg_3_0.ret == 0 then
			local var_3_0 = getProxy(IslandProxy):GetIsland()

			var_3_0:Upgrade()
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.ISLAND_LV)
			IslandAchievementHelper.UpdateRecord(IslandAchievementType.ISLAND_LV, 0, var_3_0:GetLevel())
			self:sendNotification(GAME.ISLAND_UPGRADE_DONE, {
				dropData = IslandDropHelper.AddItems(arg_3_0),
				callback = function()
					self:DoUpgrade(arg_2_1)

					return
				end
			})
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandUpgrade(var_3_0:GetLevel()))
			var_3_0:GetTechnologyAgency():TryAutoUnlock()
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.ret] .. arg_3_0.ret)
		end

		return
	end)

	return
end

return UpgradeIslandCommand
