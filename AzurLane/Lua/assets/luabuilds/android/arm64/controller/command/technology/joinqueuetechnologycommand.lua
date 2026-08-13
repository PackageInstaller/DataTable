class = var_0_10000

local var_0_0 = "JoinQueueTechnologyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.pool_id

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = #var_1_10005(var_1_10007).queue

	TechnologyConst = var_1_10007

	if var_1_10007.QUEUE_TOTAL_COUNT <= var_1_2 then
		return
	end

	if not var_5:getTechnologyById(var_1_0) or not var_6:isActivate() or not var_6:finishCondition() or var_6:isCompleted() then
		return
	end

	pg = var_7

	local var_1_3 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 63013, {
		tech_id = var_1_0,
		refresh_id = var_1_1
	}, 63014, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.moveTechnologyToQueue(var_2_0, var_1_0)

			local var_2_1 = var_0

			var_2_3.updateTechnologys(var_2_1, arg_2_0.refresh_list)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.JOIN_QUEUE_TECHNOLOGY_DONE)

			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()

			var_2_3 = var_2_3.ShowTips
			i18n = var_2_10004

			var_2_3(var_2_4, var_2_10004("technology_queue_in_success"))
		else
			pg = var_2_3

			local var_2_5 = var_2_3.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			i18n = var_2_10004

			var_2_6(var_2_5, var_2_10004("blueprint_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
