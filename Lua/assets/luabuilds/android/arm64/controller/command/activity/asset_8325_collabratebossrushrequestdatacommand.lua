local CollabrateBossRushRequestDataCommand = class("CollabrateBossRushRequestDataCommand", pm.SimpleCommand)

function CollabrateBossRushRequestDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1.body.actId

	pg.ConnectionMgr.GetInstance():Send(26081, {
		act_id = arg_1_1.body.actId
	}, 26082, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_1_0)
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.boss_list) do
				var_2_1[iter_2_1.id] = {
					hpRate = iter_2_1.boss_hp,
					deathTimeStamp = iter_2_1.death,
					trafficPerHour = iter_2_1.hour_traffic,
					damagePerHour = iter_2_1.hour_off
				}
			end

			var_2_0:UpdateCollabrateBossData(var_2_1)
			getProxy(ActivityProxy):updateActivity(var_2_0)
			self:sendNotification(GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA_DONE, arg_2_0.result)
		end

		return
	end)

	return
end

return CollabrateBossRushRequestDataCommand
