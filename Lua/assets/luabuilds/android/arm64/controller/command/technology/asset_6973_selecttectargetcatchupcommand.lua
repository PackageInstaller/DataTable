local SelectTecTargetCatchupCommand = class("SelectTecTargetCatchupCommand", pm.SimpleCommand)

function SelectTecTargetCatchupCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.charID

	pg.ConnectionMgr.GetInstance():Send(63011, {
		version = var_1_0.tecID,
		target = var_1_0.charID
	}, 63012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_0.tecID

			if var_1_1 == 0 then
				-- block empty
			else
				getProxy(TechnologyProxy):setCurCatchupTecInfo(var_2_0, var_1_1)
			end

			self:sendNotification(GAME.SELECT_TEC_TARGET_CATCHUP_DONE, {
				tecID = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return SelectTecTargetCatchupCommand
