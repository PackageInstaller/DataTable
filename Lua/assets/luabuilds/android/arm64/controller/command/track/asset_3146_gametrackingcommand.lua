local GameTrackingCommand = class("GameTrackingCommand", pm.SimpleCommand)

function GameTrackingCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(10991, {
		infos = arg_1_1:getBody().infos
	})

	return
end

return GameTrackingCommand
