local IslandCheaterReconectCommand = class("IslandCheaterReconectCommand", pm.SimpleCommand)

function IslandCheaterReconectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency()
	local var_1_2 = pg.ConnectionMgr.GetInstance().Send
	local var_1_3 = {}

	var_1_3.type = 1

	pg.ConnectionMgr.GetInstance():Send(23106, var_1_3, 23107, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:SetIsConnecting(true)
			var_1_1:SetResetGameData(arg_2_0)
			self:InitPlayerDate(arg_2_0)
			pg.m02:sendNotification(GAME.ISLAND_CHEATER_RECONNECT, {
				operation = {
					user_id = arg_2_0.user_id,
					operationType = IslandCheaterTavernConst.PlayerCurrentOperateType.PutCardOrQuery,
					auto_time = arg_2_0.auto_time
				}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

function IslandCheaterReconectCommand:InitPlayerDate(arg_3_1)
	local var_3_0 = getProxy(IslandProxy):GetIsland()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_list or {}) do
		var_3_0:DispatchEvent(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, {
			user_view = PlayRoomTools.GetGameViewID(iter_3_1.player_info.user_view),
			seat = iter_3_1.seat,
			id = iter_3_1.player_info.id
		})
	end

	var_3_0:DispatchEvent(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE)

	return
end

return IslandCheaterReconectCommand
