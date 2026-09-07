local SenrankaguraTrainCommand = class("SenrankaguraTrainCommand", pm.SimpleCommand)

function SenrankaguraTrainCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0.id)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	local var_1_2 = {
		activity_id = var_1_0.id,
		cmd = var_1_0.cmd
	}

	var_1_2.arg1 = var_1_0.arg1 or 0
	var_1_2.arg2 = var_1_0.arg2 or 0
	var_1_2.arg3 = var_1_0.arg3 or 0
	var_1_2.arg_list = var_1_0.arg_list or {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_2, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_0.cmd == 1 then
				for iter_2_0, iter_2_1 in pairs(var_1_0.arg_list) do
					table.insert(var_1_1.data2_list, iter_2_1)
				end
			elseif var_1_0.cmd == 2 then
				var_1_1.data1_list[var_1_0.arg1] = var_1_1.data1_list[var_1_0.arg1] + 1
				var_1_1.data1 = var_1_1.data1 - var_1_0.cost

				for iter_2_2, iter_2_3 in pairs(var_1_0.arg_list) do
					table.insert(var_1_1.data2_list, iter_2_3)
				end
			end

			getProxy(ActivityProxy):updateActivity(var_1_1)
			self:sendNotification(GAME.SENRANKAGURA_TRAIN_ACT_OP_DONE, (PlayerConst.addTranDrop(arg_2_0.award_list)))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return SenrankaguraTrainCommand
