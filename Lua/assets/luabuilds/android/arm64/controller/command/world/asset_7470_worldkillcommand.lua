local WorldKillCommand = class("WorldKillCommand", pm.SimpleCommand)

function WorldKillCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(33112, {
		type = 0
	}, 33113, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(WorldProxy):BuildWorld(World.TypeFull)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_reset_error_", arg_2_0.result))
		end

		self:sendNotification(GAME.WORLD_KILL_DONE, {
			result = arg_2_0.result
		})

		return
	end)

	return
end

return WorldKillCommand
