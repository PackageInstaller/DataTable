class = var_0_10000

local var_0_0 = "ActivityMemoryOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.actId

	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getActivityById(var_1_3, var_1_1)
	local var_1_5 = var_2.awardCallback

	if not var_1_4 or var_1_4:isEnd() then
		return
	end

	table = var_1_3

	if not var_1_3.contains(var_1_4.data1_list, var_1_0) then
		return
	end

	table = var_8

	if var_8.contains(var_1_4.data2_list, var_1_0) then
		return
	end

	pg = var_8

	local var_1_6 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 11202, {
		cmd = 2,
		arg2 = 0,
		activity_id = var_1_1,
		arg1 = var_1_0,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			table = var_2_2

			var_2_2.insert(var_1_4.data2_list, var_1_0)

			local var_2_0 = var_1_2

			var_2_2.updateActivity(var_2_0, var_1_4)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.MEMORYBOOK_UNLOCK_DONE, var_1_0)

			if arg_2_0.award_list then
				if var_1_5 then
					var_2_2 = var_1_5
					PlayerConst = var_2_1

					var_2_2(var_2_1.addTranDrop(arg_2_0.award_list))
				else
					local var_2_3 = arg_1_0

					var_2_2 = var_2_2.sendNotification
					GAME = var_2_10004
					var_2_10004 = var_2_10004.MEMORYBOOK_UNLOCK_AWARD_DONE

					local var_2_4 = {}

					PlayerConst = var_2_10006
					var_2_4.awards = var_2_10006.addTranDrop(arg_2_0.award_list)

					var_2_2(var_2_3, var_2_10004, var_2_4)
				end
			end
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
