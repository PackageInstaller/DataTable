class = var_0_10000

local var_0_0 = "CollabrateBossRushRequestDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body.actId

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 26081, {
		act_id = var_1_0
	}, 26082, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.getActivityById(var_2_0, var_1_0)
			local var_2_2 = {}

			ipairs = var_3

			for iter_2_0, iter_2_1 in var_3(arg_2_0.boss_list) do
				var_2_2[iter_2_1.id] = {
					hpRate = iter_2_1.boss_hp,
					deathTimeStamp = iter_2_1.death,
					trafficPerHour = iter_2_1.hour_traffic,
					damagePerHour = iter_2_1.hour_off
				}
			end

			local var_2_3 = var_2_1

			var_2_1.UpdateCollabrateBossData(var_2_3, var_2_2)

			getProxy = var_3
			ActivityProxy = var_2_3

			local var_2_4 = var_3(var_2_3)

			var_3.updateActivity(var_2_4, var_2_1)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_5

			var_2_6(var_2_5, var_5.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE, arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
