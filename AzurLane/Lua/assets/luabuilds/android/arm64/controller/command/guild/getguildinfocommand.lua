class = var_0_10000

local var_0_0 = "GetGuildInfoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getRawData(var_1_1) then
		getProxy = var_3
		GuildProxy = var_1_1

		if not var_3(var_1_1).isFetchMainInfo then
			pg = var_3

			local var_1_2 = var_3.ConnectionMgr.GetInstance()

			var_3.Send(var_1_2, 5, {
				type = 0
			}, 60000, function(arg_2_0)
				getProxy = var_2_10001
				GuildProxy = var_2_10003
				var_2_10001(var_2_10003).isFetchMainInfo = true

				local var_2_0 = arg_1_0
				local var_2_1 = var_1.sendNotification

				GAME = var_2_10004

				var_2_1(var_2_0, var_2_10004.GET_GUILD_INFO_DONE)

				return
			end)

			goto label_1_0
		end
	end

	do
		local var_1_3 = arg_1_0
		local var_1_4 = arg_1_0.sendNotification

		GAME = var_1_10006

		var_1_4(var_1_3, var_1_10006.GET_GUILD_INFO_DONE)
	end

	::label_1_0::

	return
end

return var_0_1
