local ActivityWorldInPictureCommand = class("ActivityWorldInPictureCommand", pm.SimpleCommand)

function ActivityWorldInPictureCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

	if not var_1_1 or var_1_1:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	local var_1_2 = {
		activity_id = var_1_1.id,
		cmd = var_1_0.cmd
	}

	if var_1_0.cmd == ActivityConst.WORLDINPICTURE_OP_DRAW then
		var_1_2.arg1 = var_1_0.index or var_1_0.arg1
	end

	var_1_2.arg2 = var_1_0.arg2
	var_1_2.arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_2, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.award_list)

			if var_1_0.cmd == ActivityConst.WORLDINPICTURE_OP_TURN then
				var_1_1.data2 = var_1_1.data2 - 1

				table.insert(var_1_1.data1_list, var_1_0.index)
			elseif var_1_0.cmd == ActivityConst.WORLDINPICTURE_OP_DRAW then
				var_1_1.data3 = var_1_1.data3 - 1

				table.insert(var_1_1.data2_list, var_1_0.index)
			end

			getProxy(ActivityProxy):updateActivity(var_1_1)
			self:sendNotification(GAME.WORLDIN_PICTURE_OP_DONE, {
				activity = var_1_1,
				cmd = var_1_0.cmd,
				arg1 = var_1_0.arg1,
				arg2 = var_1_0.arg2,
				auto = var_1_0.auto,
				awards = var_2_0
			})
		else
			if arg_2_0.result == 3 or arg_2_0.result == 4 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("activity_op_error", arg_2_0.result))
			end

			self:sendNotification(GAME.WORLDIN_PICTURE_OP_ERRO, {
				cmd = var_1_0.cmd,
				auto = var_1_0.auto
			})
		end

		return
	end)

	return
end

return ActivityWorldInPictureCommand
