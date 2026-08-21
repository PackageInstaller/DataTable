local var_0_0 = class("BatchGetFriendsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		local var_1_3 = getProxy(IslandProxy):GetPlayerDataCache(iter_1_1)

		if not var_1_3 then
			table.insert({}, iter_1_1)
		else
			table.insert({}, var_1_3)
		end
	end

	if #{} == 0 then
		var_1_0.callback({})
		arg_1_0:sendNotification(GAME.BATCH_GET_FRIEND_DONE)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50018, {
		user_id_list = {}
	}, 50019, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.user_list) do
			local var_2_0 = Friend.New(iter_2_1)

			table.insert(var_1_2, var_2_0)
			getProxy(IslandProxy):AddPlayerDataCache(var_2_0)
		end

		var_1_1(var_1_2)
		arg_1_0:sendNotification(GAME.BATCH_GET_FRIEND_DONE)

		return
	end)

	return
end

return var_0_0
