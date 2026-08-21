local var_0_0 = class("FetchNpcShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(TaskProxy):getTaskById(var_1_0.taskId)

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_is_not_existence", var_1_0.taskId))

		return
	end

	if not var_1_2:isFinish() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_submitTask_error_notFinish"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(20205, {
		act_id = var_1_2:getActId(),
		task_ids = {
			var_1_2.id
		}
	}, 20206, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.award_list) do
				table.insert({}, Drop.New({
					type = iter_2_1.type,
					id = iter_2_1.id,
					count = iter_2_1.number
				}))
			end

			arg_1_0:sendNotification(GAME.FETCH_NPC_SHIP_DONE, {
				items = {},
				callback = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("task_submitTask", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
