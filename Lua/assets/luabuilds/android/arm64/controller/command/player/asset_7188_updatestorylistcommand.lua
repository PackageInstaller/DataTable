local UpdateStoryListCommand = class("UpdateStoryListCommand", pm.SimpleCommand)

function UpdateStoryListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	if pg.ConnectionMgr.GetInstance():getConnection() then
		if not pg.ConnectionMgr.GetInstance():isConnected() then
			return
		end

		if not getProxy(PlayerProxy) then
			return
		end
	end

	local var_1_2 = pg.NewStoryMgr.GetInstance()
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.storyIds) do
		if not var_1_2:GetPlayedFlag(iter_1_1) then
			table.insert(var_1_3, iter_1_1)
		end
	end

	if #var_1_3 == 0 then
		existCall(var_1_0.callback)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11032, {
		story_ids = var_1_3
	}, 11033, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:SetPlayedFlagList(var_1_3)
			existCall(var_1_1)
			self:sendNotification(GAME.STORY_UPDATE_LIST_DONE, {
				storyIds = var_1_3
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return UpdateStoryListCommand
