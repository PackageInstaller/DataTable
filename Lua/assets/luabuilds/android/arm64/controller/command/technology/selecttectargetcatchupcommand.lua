local var_0_0 = class("SelectTecTargetCatchupCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(63011, {
		version = var_1_0.tecID,
		target = var_1_0.charID
	}, 63012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_0.tecID

			if var_0 == 0 then
				-- block empty
			else
				getProxy(TechnologyProxy):setCurCatchupTecInfo(var_2_0, var_0)
			end

			arg_1_0:sendNotification(GAME.SELECT_TEC_TARGET_CATCHUP_DONE, {
				tecID = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
