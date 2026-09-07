local LoveLetterLevelUpCommand = class("LoveLetterLevelUpCommand", pm.SimpleCommand)

function LoveLetterLevelUpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.groupId

	if not getProxy(LoveLetterProxy):GetGroupData(var_1_0.groupId):CanLevelUp() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12408, {
		group_id = var_1_0.groupId
	}, 12409, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy(LoveLetterProxy):LevelUp(var_1_1)
			existCall(var_1_0.callback)
			pg.m02:sendNotification(GAME.LOVE_LETTER_LEVEL_UP_DONE, {
				groupId = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return LoveLetterLevelUpCommand
