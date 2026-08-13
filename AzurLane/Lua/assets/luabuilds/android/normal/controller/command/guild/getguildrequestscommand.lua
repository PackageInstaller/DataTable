class = var_0_10000

local var_0_0 = "GetGuildRequestsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 60003, {
		id = var_1_1
	}, 60004, function(arg_2_0)
		local var_2_0 = {}
		local var_2_1 = {}

		ipairs = var_2_10003

		for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.request_list) do
			ChatMsg = var_2_10008
			var_2_10008 = var_2_10008.New
			ChatConst = var_2_10009
			var_2_10009 = var_2_10009.ChannelGuild

			local var_2_2 = {}

			Player = var_2_10011
			var_2_2.player = var_2_10011.New(iter_2_1.player)
			var_2_2.content = iter_2_1.content
			var_2_2.timestamp = iter_2_1.timestamp
			var_2_0[var_2_10008(var_2_10009, var_2_2).player.id] = var_2_10008
			table = var_2_10009

			var_2_10009.insert(var_2_1, var_2_10008)
		end

		getProxy = var_3
		GuildProxy = var_4

		local var_2_3 = var_3(var_4)

		var_3.setRequestList(var_2_3, var_2_0)

		local var_2_4 = arg_1_0
		local var_2_5 = var_4.sendNotification

		GAME = var_6

		var_2_5(var_2_4, var_6.GUILD_GET_REQUEST_LIST_DONE, var_2_1)

		return
	end)

	return
end

return var_0_1
