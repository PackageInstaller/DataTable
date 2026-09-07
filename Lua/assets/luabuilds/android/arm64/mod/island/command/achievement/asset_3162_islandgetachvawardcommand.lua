local IslandGetAchvAwardCommand = class("IslandGetAchvAwardCommand", pm.SimpleCommand)

function IslandGetAchvAwardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids

	pg.ConnectionMgr.GetInstance():Send(21050, {
		id_list = var_1_0
	}, 21051, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetAchievementAgency():AddGotIds(var_1_0)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.ACHIEVEMENT)
			self:sendNotification(GAME.ISLAND_GET_ACHV_AWARD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0),
				id = var_1_0[1]
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandGetAchvAwardCommand
