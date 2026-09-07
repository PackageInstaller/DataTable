local RequestLoveLetterContentCommand = class("RequestLoveLetterContentCommand", pm.SimpleCommand)

function RequestLoveLetterContentCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(12410, {
		letter_id = var_1_0.id
	}, 12411, function(arg_2_0)
		getProxy(LoveLetterProxy):RecordLoveLetterContent(var_1_1, arg_2_0.content)
		existCall(var_1_2)
		pg.m02:sendNotification(GAME.REQUEST_LOVE_LETTER_TEXT_DONE, {
			letterId = var_1_1
		})

		return
	end)

	return
end

return RequestLoveLetterContentCommand
