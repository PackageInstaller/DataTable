local ChangeLivingAreaCoverCommand = class("ChangeLivingAreaCoverCommand", pm.SimpleCommand)

function ChangeLivingAreaCoverCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.coverId
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(LivingAreaCoverProxy)

	pg.ConnectionMgr.GetInstance():Send(11030, {
		livingarea_cover_id = var_1_0.coverId
	}, 11031, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:UpdateCoverId(var_1_1)
			self:sendNotification(GAME.CHANGE_LIVINGAREA_COVER_DONE)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCover(var_1_1, 2))

			if var_1_2 then
				var_1_2()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ChangeLivingAreaCoverCommand
