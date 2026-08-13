class = var_0_10000

local var_0_0 = "GuildUpdateNodeAnimFlagCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.position
	local var_1_2 = arg_1_0

	if not arg_1_0.ExistMission(var_1_2, var_1_0) then
		return
	end

	local var_1_3 = {
		event_id = var_1_0,
		index = var_1_1
	}

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 61025, {
		perf = {
			var_1_3
		}
	}, 61026, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			GuildProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)
			local var_2_1 = var_2.GetActiveEvent(var_2_0)
			local var_2_2 = var_2_10003.GetMissionById(var_2_1, var_1_0)

			var_4.UpdateNodeAnimFlagIndex(var_2_2, var_1_1)
			var_1:updateGuild(var_2)

			local var_2_3 = arg_1_0
			local var_2_4 = var_5.sendNotification

			GAME = var_7

			var_2_4(var_2_3, var_7.GUILD_UPDATE_NODE_ANIM_FLAG_DONE, {
				id = var_1_0
			})
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
