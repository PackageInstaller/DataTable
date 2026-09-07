local ReturnAwardOPCommand = class("ReturnAwardOPCommand", pm.SimpleCommand)

function ReturnAwardOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy)
	local var_1_2 = var_1_1:getActivityById(var_1_0.activity_id)

	if not var_1_2 or var_1_2:isEnd() then
		return
	end

	local var_1_3 = {
		activity_id = var_1_0.activity_id
	}

	var_1_3.cmd = var_1_0.cmd or 0
	var_1_3.arg1 = var_1_0.arg1 or 0
	var_1_3.arg2 = var_1_0.arg2 or 0
	var_1_3.arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_3, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.award_list)

			if var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_ACTIVTION then
				var_1_2.data1 = 1
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_GET_RETRUNERS then
				local var_2_1 = {}

				for iter_2_0, iter_2_1 in ipairs(arg_2_0.return_user_list) do
					table.insert(var_2_1, Returner.New(iter_2_1))
				end

				var_1_2:setClientList(var_2_1)
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_GET_AWARD then
				table.insert(var_1_2.data1_list, var_1_0.arg1)
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_PUSH_UID then
				var_1_2.data2_list[1] = 1

				pg.TipsMgr.GetInstance():ShowTips(i18n("returner_push_success"))
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_ACCEPT_TASK then
				-- block empty
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_SET_RETRUNER then
				var_1_2.data2 = var_1_0.arg1

				pg.TipsMgr.GetInstance():ShowTips(i18n("return_award_bind_success"))
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_RETURNER_GET_AWARD then
				var_1_2.data4 = math.min(var_1_2.data4 + 1, #pg.activity_template_returnner[var_1_2.id].task_list)
			elseif var_1_0.cmd == ActivityConst.RETURN_AWARD_OP_MATCH then
				var_1_2.data2 = arg_2_0.number[1]

				pg.TipsMgr.GetInstance():ShowTips(i18n("return_award_bind_success"))
			end

			var_1_1:updateActivity(var_1_2)
			self:sendNotification(GAME.RETURN_AWARD_OP_DONE, {
				awards = var_2_0,
				id = var_1_2.id,
				cmd = var_1_0.cmd
			})
		elseif ERROR_MESSAGE[arg_2_0.result] then
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result])
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[9999] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ReturnAwardOPCommand
