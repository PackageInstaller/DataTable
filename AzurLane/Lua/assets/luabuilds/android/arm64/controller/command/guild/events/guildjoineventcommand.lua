class = var_0_10000

local var_0_0 = "GuildJoinEventCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 61031, {
		type = 0
	}, 61032, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)
			local var_2_1 = var_2.GetActiveEvent(var_2_0)

			var_3.IncreaseJoinCnt(var_2_1)

			pg = var_2_10004
			var_2_10004 = var_2_10004.guildset.operation_event_guild_active.key_value
			getProxy = var_2_0
			PlayerProxy = var_2_10007

			local var_2_2 = var_2_0(var_2_10007)
			local var_2_3 = var_5.getRawData(var_2_2).id
			local var_2_4 = var_2:getMemberById(var_2_3)

			var_6.AddLiveness(var_2_4, var_2_10004)
			var_1:updateGuild(var_2)

			local var_2_5 = arg_1_0
			local var_2_6 = var_7.sendNotification

			GAME = var_10

			var_2_6(var_2_5, var_10.ON_GUILD_JOIN_EVENT_DONE)
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_8(var_2_7, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
