local EducateGetEndingsCommand = class("EducateGetEndingsCommand", pm.SimpleCommand)

function EducateGetEndingsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(27010, {
		type = 0
	}, 27011, function(arg_2_0)
		if arg_2_0.endings then
			getProxy(EducateProxy):SetEndings(arg_2_0.endings, arg_2_0.qualifieds)
			self:sendNotification(GAME.EDUCATE_GET_ENDINGS_DONE)

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate get endings error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateGetEndingsCommand
