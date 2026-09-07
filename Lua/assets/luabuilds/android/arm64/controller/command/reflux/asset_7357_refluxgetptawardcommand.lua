local RefluxGetPTAwardCommand = class("RefluxGetPTAwardCommand", pm.SimpleCommand)

function RefluxGetPTAwardCommand:execute()
	pg.ConnectionMgr.GetInstance():Send(11755, {
		type = 0
	}, 11756, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(RefluxProxy):addPTStage()
			pg.m02:sendNotification(GAME.REFLUX_GET_PT_AWARD_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		end

		return
	end)

	return
end

return RefluxGetPTAwardCommand
