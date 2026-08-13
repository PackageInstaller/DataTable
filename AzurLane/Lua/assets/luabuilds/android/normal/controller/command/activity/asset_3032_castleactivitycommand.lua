class = var_0_10000

local var_0_0 = "CastleActivityCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_1_1, var_1_0) or var_5:isEnd() then
		return
	end

	pg = var_1_1

	local var_1_2 = var_1_1.ConnectionMgr.GetInstance()
	local var_1_3 = var_6.Send
	local var_1_4 = 11202
	local var_1_5 = {
		activity_id = var_1_0,
		cmd = var_2.cmd
	}
	local var_1_6

	if not var_2.arg1 then
		var_1_6 = 0
	end

	var_1_5.arg1 = var_1_6

	local var_1_7

	if not var_2.arg2 then
		var_1_7 = 0
	end

	var_1_5.arg2 = var_1_7

	local var_1_8

	if not var_2.arg3 then
		var_1_8 = 0
	end

	var_1_5.arg3 = var_1_8
	var_1_5.arg_list = {}

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			if var_0.cmd == 1 then
				var_2_0 = var_0
				var_2_0.data1 = arg_2_0.number[2]

				if arg_2_0.number[1] <= 50 then
					var_2_0 = var_0
					var_2_0.data2 = var_0.data2 - 1
				end

				local var_2_1 = var_0

				var_2_0.updateActivity(var_2_1, var_0)

				local var_2_2 = arg_1_0

				var_2_0 = var_2_0.sendNotification
				GAME = var_2_10003

				var_2_0(var_2_2, var_2_10003.CASTLE_DICE_OP_DONE, arg_2_0)
			elseif var_0.cmd == 2 then
				warning = var_2_0

				var_2_0(#arg_2_0.number)

				var_2_0 = var_0
				var_2_0.data1 = arg_2_0.number[1]

				local var_2_3 = var_0

				var_2_0.updateActivity(var_2_3, var_0)

				local var_2_4 = arg_1_0

				var_2_0 = var_2_0.sendNotification
				GAME = var_2_10003

				var_2_0(var_2_4, var_2_10003.CASTLE_STORY_OP_DONE, arg_2_0)
			elseif var_0.cmd == 3 then
				local var_2_5 = arg_1_0

				var_2_0 = var_2_0.sendNotification
				GAME = var_2_10003

				var_2_0(var_2_5, var_2_10003.CASTLE_FIRST_STORY_OP_DONE)
			end
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_7(var_2_6, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
