local BatchGetFriendsCommand = class("BatchGetFriendsCommand", pm.SimpleCommand)

function BatchGetFriendsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = {}
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		local var_1_4 = getProxy(IslandProxy):GetPlayerDataCache(iter_1_1)

		if not var_1_4 then
			table.insert(var_1_3, iter_1_1)
		else
			table.insert(var_1_2, var_1_4)
		end
	end

	if #var_1_3 == 0 then
		var_1_0.callback(var_1_2)
		self:sendNotification(GAME.BATCH_GET_FRIEND_DONE)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50018, {
		user_id_list = var_1_3
	}, 50019, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.user_list) do
			local var_2_0 = Friend.New(iter_2_1)

			table.insert(var_1_2, var_2_0)
			getProxy(IslandProxy):AddPlayerDataCache(var_2_0)
		end

		var_1_1(var_1_2)
		self:sendNotification(GAME.BATCH_GET_FRIEND_DONE)

		return
	end)

	return
end

return BatchGetFriendsCommand
