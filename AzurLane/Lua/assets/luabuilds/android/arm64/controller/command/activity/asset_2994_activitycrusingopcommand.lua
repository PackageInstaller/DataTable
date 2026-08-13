class = var_0_10000

local var_0_0 = "ActivityCrusingOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getActivityById(var_1_2, var_2.activity_id) or var_5:isEnd() then
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()
	local var_1_4 = var_6.Send
	local var_1_5 = 11202
	local var_1_6 = {
		activity_id = var_2.activity_id
	}
	local var_1_7

	if not var_2.cmd then
		var_1_7 = 0
	end

	var_1_6.cmd = var_1_7

	local var_1_8

	if not var_2.arg1 then
		var_1_8 = 0
	end

	var_1_6.arg1 = var_1_8

	local var_1_9

	if not var_2.arg2 then
		var_1_9 = 0
	end

	var_1_6.arg2 = var_1_9
	var_1_6.arg_list = {}

	var_1_4(var_1_3, var_1_5, var_1_6, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}

			if var_0.cmd == 1 then
				PlayerConst = var_2
				var_2_0 = var_2.addTranDrop(arg_2_0.award_list)

				local var_2_1 = var_0

				var_2_1.data1_list = {}
				ipairs = var_2_1
				pg = var_4

				for iter_2_0, iter_2_1 in var_2_1(var_4.black_friday_battlepass_event_pt[var_0.id].target) do
					if iter_2_1 <= var_0.data1 then
						table = var_7

						var_7.insert(var_0.data1_list, iter_2_1)
					else
						break
					end
				end

				if var_0.data2 == 1 then
					local var_2_2 = var_0

					underscore = var_2_10003
					var_2_2.data2_list = var_2_10003.rest(var_0.data1_list, 1)
				end
			elseif var_0.cmd == 2 then
				PlayerConst = var_2
				var_2_0 = var_2.addTranDrop(arg_2_0.award_list)
				table = var_2

				var_2.insert(var_0.data1_list, var_0.arg1)
			elseif var_0.cmd == 3 then
				PlayerConst = var_2
				var_2_0 = var_2.addTranDrop(arg_2_0.award_list)
				table = var_2

				var_2.insert(var_0.data2_list, var_0.arg1)
			elseif var_0.cmd == 4 then
				PlayerConst = var_2
				var_2_0 = var_2.addTranDrop(arg_2_0.award_list)

				local var_2_3 = var_0

				var_2_3.data1_list = {}
				ipairs = var_2_3
				pg = var_4

				for iter_2_2, iter_2_3 in var_2_3(var_4.battlepass_event_pt[var_0.id].target) do
					if iter_2_3 <= var_0.data1 then
						table = var_7

						var_7.insert(var_0.data1_list, iter_2_3)
					else
						break
					end
				end

				if var_0.data2 == 1 then
					local var_2_4 = var_0

					underscore = var_2_10003
					var_2_4.data2_list = var_2_10003.rest(var_0.data1_list, 1)
				end
			end

			local var_2_5 = var_0

			var_2.updateActivity(var_2_5, var_0)

			local var_2_6 = arg_1_0
			local var_2_7 = var_2.sendNotification

			GAME = var_5

			var_2_7(var_2_6, var_5.CRUSING_CMD_DONE, {
				awards = var_2_0,
				callback = var_1_1
			})
		else
			originalPrint = var_2_0
			errorTip = var_2_10003

			var_2_0(var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
