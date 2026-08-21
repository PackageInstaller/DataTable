local var_0_0 = class("ApartmentChangeSkinCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.groupId
	local var_1_2 = var_1_0.skinId
	local var_1_3 = getProxy(ApartmentProxy)

	if getProxy(ApartmentProxy):getApartment(var_1_0.groupId).skinId == var_1_0.skinId then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(28013, {
		ship_group = var_1_0.groupId,
		skin = var_1_0.skinId
	}, 28014, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:ModifyApartment(var_1_1, {
				skinId = var_1_2
			})
			arg_1_0:sendNotification(GAME.APARTMENT_CHANGE_SKIN_DONE, var_1_3:getApartment(var_1_1))
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataChangeSkin(var_1_2))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
