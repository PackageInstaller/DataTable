local var_0_0 = class("ExitIslandCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21204, {
		island_id = var_1_0.id
	}, 21205, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland()

			if var_2_0:IsPrivate() then
				local var_2_1 = var_2_0:GetSystemTipInfos()

				getProxy(SystemTipProxy):SetIslandTipData(var_2_1.awardCnt, var_2_1.emptyCnt, var_2_1.timestamps, var_2_1.postFlag)
			end

			getProxy(IslandProxy):ExitIsland()
			arg_1_0:sendNotification(GAME.ISLAND_EXIT_DONE)

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
