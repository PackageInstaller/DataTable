local var_0_0 = class("ChangeLivingAreaCoverCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(LivingAreaCoverProxy)

	pg.ConnectionMgr.GetInstance():Send(11030, {
		livingarea_cover_id = var_1_0.coverId
	}, 11031, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:UpdateCoverId(var_0)
			arg_1_0:sendNotification(GAME.CHANGE_LIVINGAREA_COVER_DONE)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCover(var_0, 2))

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
