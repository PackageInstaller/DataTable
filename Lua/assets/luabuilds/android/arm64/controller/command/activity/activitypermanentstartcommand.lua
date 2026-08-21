local var_0_0 = class("ActivityPermanentStartCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id
	local var_1_1 = getProxy(ActivityPermanentProxy)
	local var_1_2 = var_1_1:GetActivityTypeById(var_1_0)
	local var_1_3 = var_1_2 and var_1_1:getDoingActivityId(var_1_2)

	local function var_1_4()
		if var_1_3 == var_1_0 then
			arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_START_DONE, {
				id = var_1_0
			})

			return
		end

		pg.ConnectionMgr.GetInstance():Send(11206, {
			activity_id = var_1_0
		}, 11207, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_1:startSelectActivity(var_1_0)
				arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_START_DONE, {
					id = var_1_0
				})
			else
				warning("error permanent")
			end

			return
		end)

		return
	end

	if var_1_3 and var_1_3 ~= var_1_0 then
		(function(arg_4_0, arg_4_1)
			arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_STOP, {
				activity_id = arg_4_0,
				callback = arg_4_1
			})

			return
		end)(var_1_3, var_1_4)
	else
		var_1_4()
	end

	return
end

return var_0_0
