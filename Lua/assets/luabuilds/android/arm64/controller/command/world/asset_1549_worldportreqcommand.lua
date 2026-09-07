local WorldPortReqCommand = class("WorldPortReqCommand", pm.SimpleCommand)

function WorldPortReqCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(33401, {
		map_id = var_1_0.mapId
	}, 33402, function(arg_2_0)
		if (arg_2_0.port.port_id > 0 and 0 or 1) == 0 then
			getProxy(WorldProxy):NetUpdateMapPort(var_1_0.mapId, arg_2_0.port)
			nowWorld():GetAtlas():UpdatePortMark(arg_2_0.port.port_id, nil, false)
		else
			pg.TipsMgr.GetInstance():ShowTips("port req error.")
		end

		self:sendNotification(GAME.WORLD_PORT_REQ_DONE)

		return
	end)

	return
end

return WorldPortReqCommand
