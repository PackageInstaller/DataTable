local IslandUnlockTechCommand = class("IslandUnlockTechCommand", pm.SimpleCommand)

function IslandUnlockTechCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.techId
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21520, {
		tech_id = var_1_0.techId
	}, 21521, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland()
			local var_2_1 = var_2_0:GetTechnologyAgency()

			var_2_1:RemoveLockId(var_1_1)
			var_2_0:GetAblityAgency():AddAblity((var_2_1:GetTechnology(var_1_1):GetAbilityId()))
			existCall(var_1_2)
			self:sendNotification(GAME.ISLAND_UNLOCK_TECH_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandUnlockTechCommand
