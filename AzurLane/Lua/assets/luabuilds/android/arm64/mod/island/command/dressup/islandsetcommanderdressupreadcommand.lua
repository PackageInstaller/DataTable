local var_0_0 = class("IslandSetCommanderDressupReadCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21621, {
		dress_id = arg_1_1:getBody().dress_List
	}, 21622, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				var_2_0:SetDressHasRead(iter_2_1)
			end

			arg_1_0:sendNotification(GAME.ISLAND_SEND_COMMANDER_DRESS_READ_DONE, var_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
