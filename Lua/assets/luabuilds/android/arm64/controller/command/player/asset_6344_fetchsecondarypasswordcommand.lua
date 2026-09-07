local FetchSecondaryPasswordCommand = class("FetchSecondaryPasswordCommand", pm.SimpleCommand)

function FetchSecondaryPasswordCommand:execute(arg_1_1)
	pg.UIMgr.GetInstance():LoadingOn()
	pg.ConnectionMgr.GetInstance():Send(11603, {
		type = 1
	}, 11604, function(arg_2_0)
		pg.UIMgr.GetInstance():LoadingOff()
		getProxy(SecondaryPWDProxy):SetData(arg_2_0)
		self:sendNotification(GAME.FETCH_PASSWORD_STATE_DONE, arg_2_0)

		return
	end)

	return
end

return FetchSecondaryPasswordCommand
