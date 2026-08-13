class = var_0_10000

local var_0_0 = "GetGuildChatListCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	GuildConst = var_1_10003

	local var_1_2 = var_1_10003.CHAT_LOG_MAX_COUNT

	getProxy = var_1_0
	GuildProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)

	if not var_4.getData(var_1_3) then
		return
	end

	pg = var_1_10006

	local var_1_4 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 60100, {
		count = var_1_2
	}, 60101, function(arg_2_0)
		var_0.isGetChatMsg = true

		local var_2_0 = {}

		ipairs = var_2

		local var_2_1

		if not arg_2_0.chat_list then
			var_2_1 = {}
		end

		for iter_2_0, iter_2_1 in var_2(var_2_1) do
			local var_2_2 = var_0
			local var_2_3 = var_7.warpChatInfo(var_2_2, iter_2_1)
			local var_2_4 = var_0

			var_8.addMsg(var_2_4, var_2_3)
		end

		local var_2_5 = arg_1_0
		local var_2_6 = var_2.sendNotification

		GAME = iter_2_0

		var_2_6(var_2_5, iter_2_0.GET_GUILD_CHAT_LIST_DONE)

		return
	end)

	return
end

return var_0_1
