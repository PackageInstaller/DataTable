local var_0_0 = class("IslandGetAutoCollectionCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21541, {
		type = arg_1_1:getBody().type
	}, 21542, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.ISLAND_GET_AUTO_COLLECTION_DATA_DONE, {
				data = arg_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
