local var_0_0 = class("DormSetCallCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(ApartmentProxy)

	if var_1_2:getApartment(var_1_0.groupId):GetSetCallCd() > 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(28021, {
		ship_group = var_1_0.groupId,
		name = var_1_0.callName
	}, 28022, function(arg_2_0)
		if arg_2_0.result == 0 then
			({
				callName = var_1_0.callName
			}).setCallCd = pg.TimeMgr.GetInstance():GetServerTime() + 0

			var_1_2:ModifyApartment(var_1_0.groupId, {
				callName = var_1_0.callName
			})
			arg_1_0:sendNotification(GAME.DORM_SET_CALL_DONE, {
				apartment = var_1_2:getApartment(var_1_0.groupId)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("dorm3d set call name error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
