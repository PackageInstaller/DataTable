local UnlockLoveLetterCommand = class("UnlockLoveLetterCommand", pm.SimpleCommand)

function UnlockLoveLetterCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = pg.lover_letter_content[var_1_0]

	if not getProxy(LoveLetterProxy):GetGroupData(pg.lover_letter_content[var_1_0].ship_group):CanUnlockLetter(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12400, {
		id = var_1_0
	}, 12401, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(LoveLetterProxy):UnlockLetter(var_1_1.ship_group, var_1_0)
			pg.m02:sendNotification(GAME.UNLOCK_LOVE_LETTER_DONE, {
				letterId = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return UnlockLoveLetterCommand
