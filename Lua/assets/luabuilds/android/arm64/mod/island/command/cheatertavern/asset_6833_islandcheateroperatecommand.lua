local IslandCheaterOperateCommand = class("IslandCheaterOperateCommand", pm.SimpleCommand)

function IslandCheaterOperateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.arg_list

	pg.ConnectionMgr.GetInstance():Send(23103, {
		type = var_1_0.type,
		arg_list = var_1_0.arg_list
	}, 23104, function(arg_2_0)
		if arg_2_0.result == 0 then
			switch(var_1_1, {
				[IslandCheaterTavernConst.PlayerOperateType.PutCard] = function()
					getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency():MainPlayerPutCard(var_1_2)

					return
				end,
				[IslandCheaterTavernConst.PlayerOperateType.Query] = function()
					return
				end,
				[IslandCheaterTavernConst.PlayerOperateType.Shoot] = function()
					return
				end
			})
			self:sendNotification(GAME.ISLAND_PLAYER_CHEATER_OPERATE_DONE, {
				type = var_1_1,
				arg_list = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

return IslandCheaterOperateCommand
