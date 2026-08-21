local var_0_0 = class("GetAllLoveLetterLevelDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(12406, {
		type = 0
	}, 12407, function(arg_2_0)
		getProxy(LoveLetterProxy):SetGroupList(arg_2_0)
		existCall(var_1_0.callback)
		pg.m02:sendNotification(GAME.GET_ALL_LOVE_LETTER_DATA_DONE)

		return
	end)

	return
end

return var_0_0
