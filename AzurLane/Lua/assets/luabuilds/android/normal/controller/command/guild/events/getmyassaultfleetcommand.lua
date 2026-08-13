class = var_0_10000

local var_0_0 = "GetMyAssaultFleetCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 61009, {
		type = 0
	}, 61010, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)

			getProxy = var_2_10003
			PlayerProxy = var_2_10004

			local var_2_1 = var_2_10003(var_2_10004)

			var_2_10003 = var_2_10003.getRawData(var_2_1).id

			local var_2_2 = var_2_0
			local var_2_3 = var_2_0.getMemberById(var_2_2, var_2_10003)

			assert = var_2_2

			var_2_2(var_2_3)

			GuildAssaultFleet = var_2_2

			local var_2_4 = var_2_2.New({})
			local var_2_5 = {}
			local var_2_6 = {}

			_ = var_2_10008

			var_2_10008.each(arg_2_0.person_ships, function(arg_3_0)
				Ship = var_3_10001

				local var_3_0 = var_3_10001.New(arg_3_0.ship)

				var_2_5[arg_3_0.pos] = var_3_0
				var_2_6[arg_3_0.pos] = arg_3_0.last_time

				return
			end)
			var_2_4:InitShips(var_2_10003, var_2_5)
			var_2_3:UpdateExternalAssaultFleet(var_2_4)
			var_1:updateGuild(var_2_0)

			var_1.isFetchAssaultFleet = true
			ipairs = var_8

			for iter_2_0, iter_2_1 in var_8(var_2_6) do
				var_1:UpdatePosCdTime(iter_2_0, iter_2_1)
			end

			local var_2_7 = arg_1_0
			local var_2_8 = var_8.sendNotification

			GAME = var_10

			var_2_8(var_2_7, var_10.GUILD_GET_MY_ASSAULT_FLEET_DONE)

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_10(var_2_9, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
