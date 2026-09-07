local SubmitTaskOneStepCommand = class("SubmitTaskOneStepCommand", pm.SimpleCommand)

function SubmitTaskOneStepCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.dontSendMsg
	local var_1_3 = var_1_0.resultList
	local var_1_4 = {}
	local var_1_5 = {}
	local var_1_6 = getProxy(TaskProxy)

	for iter_1_0, iter_1_1 in ipairs(var_1_0.resultList) do
		local var_1_7 = {}

		if iter_1_1.choiceItemList then
			for iter_1_2, iter_1_3 in ipairs(iter_1_1.choiceItemList) do
				table.insert(var_1_7, iter_1_3)
			end
		end

		local var_1_8 = var_1_6:getTaskById(iter_1_1.id)

		if not var_1_8 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("task_is_not_existence", iter_1_1.id))

			return
		end

		if not var_1_8:isFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("task_submitTask_error_notFinish"))

			return
		end

		table.insert(var_1_4, iter_1_1.id)
	end

	pg.ConnectionMgr.GetInstance():Send(20011, {
		id_list = var_1_4
	}, 20012, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.id_list) do
			local var_2_0 = var_1_6:getTaskById(iter_2_1)

			if var_2_0:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
				getProxy(BagProxy):removeItemById(tonumber((tonumber(var_2_0:getConfig("target_id")))), tonumber((var_2_0:getConfig("target_num"))))
			elseif var_2_0:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM then
				getProxy(ActivityProxy):removeVitemById(tonumber(var_2_0:getConfig("target_id")), (var_2_0:getConfig("target_num")))
			elseif var_2_0:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
				local var_2_1 = getProxy(PlayerProxy)
				local var_2_2 = var_2_1:getData()

				var_2_2:consume({
					[id2res((tonumber(var_2_0:getConfig("target_id"))))] = var_2_0:getConfig("target_num")
				})
				var_2_1:updatePlayer(var_2_2)
			end

			SubmitTaskCommand.AddGuildLivness(var_2_0)
			SubmitTaskCommand.CheckTaskType(var_2_0)

			local var_2_3 = getProxy(ActivityProxy)
			local var_2_4 = var_2_3:getActivityByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST_MONITOR)

			if var_2_4 and not var_2_4:isEnd() then
				if table.contains(var_2_4:getConfig("config_data")[1] or {}, var_2_0.id) then
					var_2_3:monitorTaskList(var_2_4)
				end
			end
		end

		var_1_5 = PlayerConst.addTranDrop(arg_2_0.award_list)

		if not var_1_2 then
			self:sendNotification(GAME.SUBMIT_TASK_DONE, var_1_5, _.map(var_1_3, function(arg_3_0)
				return arg_3_0.id
			end))
		end

		if var_1_1 then
			var_1_1(var_1_5)
		end

		return
	end)

	return
end

return SubmitTaskOneStepCommand
