class = var_0_10000

local var_0_0 = "ActivityWorldInPictureCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getActivityByType

	ActivityConst = var_1_10005

	if not var_1_3(var_1_2, var_1_10005.ACTIVITY_TYPE_WORLDINPICTURE) or var_3:isEnd() then
		pg = var_1_2

		local var_1_4 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_10006

		var_1_2(var_1_4, var_1_10006("common_activity_end"))

		return
	end

	pg = var_1_2

	local var_1_5 = var_1_2.ConnectionMgr.GetInstance()
	local var_1_6 = var_4.Send
	local var_1_7 = 11202
	local var_1_8 = {
		activity_id = var_3.id,
		cmd = var_1_1.cmd
	}
	local var_1_9 = var_1_1.cmd

	ActivityConst = var_1_10009

	local var_1_10

	if var_1_9 ~= var_1_10009.WORLDINPICTURE_OP_DRAW or not var_1_1.index then
		var_1_10 = var_1_1.arg1
	end

	var_1_8.arg1 = var_1_10
	var_1_8.arg2 = var_1_1.arg2
	var_1_8.arg_list = {}

	var_1_6(var_1_5, var_1_7, var_1_8, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			PlayerConst = var_1

			local var_2_0 = var_1.addTranDrop(arg_2_0.award_list)
			local var_2_1 = var_1_1.cmd

			ActivityConst = var_2_10003

			if var_2_1 == var_2_10003.WORLDINPICTURE_OP_TURN then
				var_2_1 = var_0
				var_2_1.data2 = var_0.data2 - 1
				table = var_2_1

				var_2_1.insert(var_0.data1_list, var_1_1.index)
			else
				var_2_1 = var_1_1.cmd
				ActivityConst = var_2_10003

				if var_2_1 == var_2_10003.WORLDINPICTURE_OP_DRAW then
					var_2_1 = var_0
					var_2_1.data3 = var_0.data3 - 1
					table = var_2_1

					var_2_1.insert(var_0.data2_list, var_1_1.index)
				end
			end

			getProxy = var_2_1
			ActivityProxy = var_2_10003
			var_2_10003 = var_2_1(var_2_10003)

			var_2.updateActivity(var_2_10003, var_0)

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.WORLDIN_PICTURE_OP_DONE, {
				activity = var_0,
				cmd = var_1_1.cmd,
				arg1 = var_1_1.arg1,
				arg2 = var_1_1.arg2,
				auto = var_1_1.auto,
				awards = var_2_0
			})
		else
			local var_2_4

			if arg_2_0.result == 3 or arg_2_0.result == 4 then
				pg = var_2_4

				local var_2_3 = var_2_4.TipsMgr.GetInstance()

				var_2_4 = var_2_4.ShowTips
				i18n = var_2_10003

				var_2_4(var_2_3, var_2_10003("common_activity_end"))
			else
				pg = var_2_4

				local var_2_5 = var_2_4.TipsMgr.GetInstance()
				local var_2_6 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_6(var_2_5, var_2_10003("activity_op_error", arg_2_0.result))
			end

			local var_2_7 = arg_1_0
			local var_2_8 = var_1.sendNotification

			GAME = var_2_10003

			var_2_8(var_2_7, var_2_10003.WORLDIN_PICTURE_OP_ERRO, {
				cmd = var_1_1.cmd,
				auto = var_1_1.auto
			})
		end

		return
	end)

	return
end

return var_0_1
