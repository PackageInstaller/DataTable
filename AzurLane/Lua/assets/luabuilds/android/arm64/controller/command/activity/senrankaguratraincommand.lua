class = var_0_10000

local var_0_0 = "SenrankaguraTrainCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getActivityById(var_1_2, var_1_1) or var_5:isEnd() then
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()
	local var_1_4 = var_6.Send
	local var_1_5 = 11202
	local var_1_6 = {
		activity_id = var_1_1,
		cmd = var_2.cmd
	}
	local var_1_7

	if not var_2.arg1 then
		var_1_7 = 0
	end

	var_1_6.arg1 = var_1_7

	local var_1_8

	if not var_2.arg2 then
		var_1_8 = 0
	end

	var_1_6.arg2 = var_1_8

	local var_1_9

	if not var_2.arg3 then
		var_1_9 = 0
	end

	var_1_6.arg3 = var_1_9

	local var_1_10

	if not var_2.arg_list then
		var_1_10 = {}
	end

	var_1_6.arg_list = var_1_10

	var_1_4(var_1_3, var_1_5, var_1_6, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			if var_0.cmd == 1 then
				pairs = var_2_0

				for iter_2_2, iter_2_3 in var_2_0(var_0.arg_list) do
					table = var_2_10006

					var_2_10006.insert(var_0.data2_list, iter_2_3)
				end
			elseif var_0.cmd == 2 then
				var_2_0 = var_0.data1_list
				var_2_0[var_0.arg1] = var_0.data1_list[var_0.arg1] + 1
				var_2_0 = var_0
				var_2_0.data1 = var_0.data1 - var_0.cost
				pairs = var_2_0

				for iter_2_2, iter_2_3 in var_2_0(var_0.arg_list) do
					table = var_2_10006

					var_2_10006.insert(var_0.data2_list, iter_2_3)
				end
			end

			getProxy = var_2_0
			ActivityProxy = var_2_10003

			local var_2_1 = var_2_0(var_2_10003)

			var_2_0.updateActivity(var_2_1, var_0)

			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			iter_2_2 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = iter_2_3

			var_2_2(iter_2_2, iter_2_3.SENRANKAGURA_TRAIN_ACT_OP_DONE, var_2_0)
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = iter_2_2

			var_2_4(var_2_3, iter_2_2("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
