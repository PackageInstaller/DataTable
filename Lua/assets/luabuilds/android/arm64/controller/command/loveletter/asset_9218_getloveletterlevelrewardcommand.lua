local GetLoveLetterLevelRewardCommand = class("GetLoveLetterLevelRewardCommand", pm.SimpleCommand)

function GetLoveLetterLevelRewardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().list

	if not getProxy(LoveLetterProxy):CanGetReward(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12402, {
		id_list = var_1_0
	}, 12403, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(LoveLetterProxy):MarkReward(var_1_0)
			pg.m02:sendNotification(GAME.GET_LOVE_LETTER_REWARD_DONE, {
				list = var_1_0,
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GetLoveLetterLevelRewardCommand
