local var_0_0 = class("IslandSetAccessAuthorityCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21002, {
		open_flag = var_1_0.openList,
		close_flag = var_1_0.closeList
	}, 21003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetAccessAgency()

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				var_2_0:RemoveOpenFlag(iter_2_1)
			end

			for iter_2_2, iter_2_3 in ipairs(var_0) do
				var_2_0:AddOpenFlag(iter_2_3)
			end

			arg_1_0:sendNotification(GAME.ISLAND_SET_ACCESS_TYPE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_0
