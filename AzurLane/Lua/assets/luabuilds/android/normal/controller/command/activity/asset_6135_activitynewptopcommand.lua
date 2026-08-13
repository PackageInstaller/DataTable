class = var_0_10000

local var_0_0 = "ActivityNewPtOPCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_1_1, var_2.activity_id) or var_5:isEnd() then
		return
	end

	pg = var_1_1

	local var_1_2 = var_1_1.ConnectionMgr.GetInstance()
	local var_1_3 = var_6.Send
	local var_1_4 = 11202
	local var_1_5 = {
		activity_id = var_2.activity_id
	}
	local var_1_6

	if not var_2.cmd then
		var_1_6 = 0
	end

	var_1_5.cmd = var_1_6

	local var_1_7

	if not var_2.arg1 then
		var_1_7 = 0
	end

	var_1_5.arg1 = var_1_7

	local var_1_8

	if not var_2.arg2 then
		var_1_8 = 0
	end

	var_1_5.arg2 = var_1_8
	var_1_5.arg_list = {}

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}

			if var_0.cmd == 1 then
				PlayerConst = var_2_10002
				var_2_0 = var_2_10002.addTranDrop(arg_2_0.award_list)

				local var_2_1 = var_0

				var_0 = var_2_10002.getActivityById(var_2_1, var_0.activity_id)
				table = var_2_10002

				var_2_10002.insert(var_0.data1_list, var_0.arg1)

				local var_2_2 = var_0

				var_2_10002 = var_2_10002.getConfig(var_2_2, "type")
				ActivityConst = var_2_2

				if var_2_10002 == var_2_2.ACTIVITY_TYPE_PIZZA_PT and var_0.arg2 and var_0.arg2 > 0 then
					table = var_3

					var_3.insert(var_0.data2_list, var_0.arg2)
				end
			elseif var_0.cmd == 2 then
				var_2_10002 = var_0
				var_2_10002.data3 = arg_2_0.number[1]
			elseif var_0.cmd == 3 then
				PlayerConst = var_2_10002
				var_2_0 = var_2_10002.addTranDrop(arg_2_0.award_list)

				local var_2_3 = var_0

				var_0 = var_2_10002.getActivityById(var_2_3, var_0.activity_id)

				if var_0.arg1 then
					var_2_10002 = var_0.arg1

					if 0 < var_2_10002 then
						table = var_2_10002

						var_2_10002.insert(var_0.data2_list, var_0.arg1)
					end
				end

				if not var_0.oldBuffId then
					var_2_10002 = 0
				end

				ipairs = var_2_3

				for iter_2_0, iter_2_1 in var_2_3(var_0.data3_list) do
					if iter_2_1 == var_2_10002 then
						var_2_10008 = var_0.data3_list
						var_2_10008[iter_2_0] = var_0.arg2
					end
				end
			elseif var_0.cmd == 4 then
				PlayerConst = var_2_10002
				var_2_0 = var_2_10002.addTranDrop(arg_2_0.award_list)

				local var_2_4 = var_0

				var_0 = var_2_10002.getActivityById(var_2_4, var_0.activity_id)

				local var_2_5 = var_0

				var_2_10002 = var_2_10002.getDataConfig(var_2_5, "target")
				ipairs = var_2_5

				for iter_2_2, iter_2_3 in var_2_5(var_2_10002) do
					if iter_2_3 <= var_0.arg1 then
						table = var_2_10008

						if not var_2_10008.contains(var_0.data1_list, iter_2_3) then
							table = var_2_10008

							var_2_10008.insert(var_0.data1_list, iter_2_3)
						end
					else
						break
					end
				end
			elseif var_0.cmd == 5 then
				var_2_10002 = arg_2_0.number[1]

				local var_2_6 = var_0

				var_2_6.data1 = var_0.data1 + var_2_10002
				getProxy = var_2_6
				PlayerProxy = var_4

				local var_2_7 = var_2_6(var_4)
				local var_2_8 = var_3.getRawData(var_2_7)
				local var_2_9 = var_4.consume
				local var_2_10 = {}

				id2res = var_2_10008
				var_2_10[var_2_10008(var_0.arg1)] = var_2_10002

				var_2_9(var_2_8, var_2_10)
				var_3:updatePlayer(var_4)
			end

			local var_2_11 = var_0

			var_2_10002.updateActivity(var_2_11, var_0)

			local var_2_12 = arg_1_0

			var_2_10002 = var_2_10002.sendNotification
			GAME = var_4

			var_2_10002(var_2_12, var_4.ACT_NEW_PT_DONE, {
				awards = var_2_0,
				callback = var_1_0
			})
		else
			originalPrint = var_2_0
			errorTip = var_2_10002

			var_2_0(var_2_10002("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
