local var_0_0 = class("RequestLoveLetterContentCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(12410, {
		letter_id = var_1_0.id
	}, 12411, function(arg_2_0)
		getProxy(LoveLetterProxy):RecordLoveLetterContent(var_0, arg_2_0.content)
		existCall(var_1_1)
		pg.m02:sendNotification(GAME.REQUEST_LOVE_LETTER_TEXT_DONE, {
			letterId = var_0
		})

		return
	end)

	return
end

return var_0_0
