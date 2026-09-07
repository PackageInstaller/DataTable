local RefluxSignCommand = class("RefluxSignCommand", pm.SimpleCommand)

function RefluxSignCommand:execute()
	pg.ConnectionMgr.GetInstance():Send(11753, {
		type = 0
	}, 11754, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(RefluxProxy)

			var_2_0:setSignLastTimestamp()
			var_2_0:addSignCount()
			pg.m02:sendNotification(GAME.REFLUX_SIGN_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Sign Error:" .. arg_2_0.result)
			getProxy(RefluxProxy):setAutoActionForbidden(true)
		end

		return
	end)

	return
end

return RefluxSignCommand
