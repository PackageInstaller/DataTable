class = var_0_10000

local var_0_0 = "FetchNpcShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	TaskProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getTaskById(var_1_2, var_1_0) then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()
		local var_1_4 = var_7.ShowTips

		i18n = var_1_10009

		var_1_4(var_1_3, var_1_10009("task_is_not_existence", var_1_0))

		return
	end

	local var_1_6

	if not var_6:isFinish() then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10009

		var_1_6(var_1_5, var_1_10009("task_submitTask_error_notFinish"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 20205, {
		act_id = var_6:getActId(),
		task_ids = {
			var_6.id
		}
	}, 20206, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.award_list) do
				table = var_2_10007
				var_2_10007 = var_2_10007.insert

				local var_2_1 = var_2_0

				Drop = var_2_10009

				var_2_10007(var_2_1, var_2_10009.New({
					type = iter_2_1.type,
					id = iter_2_1.id,
					count = iter_2_1.number
				}))
			end

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.FETCH_NPC_SHIP_DONE, {
				items = var_2_0,
				callback = var_1_1
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("task_submitTask", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
