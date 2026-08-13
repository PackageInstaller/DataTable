class = var_0_10000

local var_0_0 = "AtelierRefreshBuffCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)
	local var_1_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_1_10005.ACTIVITY_TYPE_ATELIER_LINK)

	assert = var_1_1

	var_1_1(var_1_3)

	local var_1_4 = {}

	table = var_5

	var_5.Foreach(var_1_0, function(arg_2_0, arg_2_1)
		if arg_2_1[1] == 0 then
			return
		end

		table = var_2

		var_2.insert(var_1_4, {
			pos = arg_2_0,
			itemid = arg_2_1[1],
			itemnum = arg_2_1[2]
		})

		return
	end)

	pg = var_5

	local var_1_5 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 26055, {
		act_id = var_1_3.id,
		slots = var_1_4
	}, 26056, function(arg_3_0)
		local var_3_1

		if arg_3_0.result == 0 then
			getProxy = var_3_1
			ActivityProxy = var_2_10002

			local var_3_0 = var_3_1(var_2_10002)

			var_3_1 = var_3_1.getActivityByType
			ActivityConst = var_2_10003
			var_1_3 = var_3_1(var_3_0, var_2_10003.ACTIVITY_TYPE_ATELIER_LINK)

			local var_3_2 = var_1_3

			var_3_1.UpdateBuffSlots(var_3_2, var_1_4)

			getProxy = var_3_1
			ActivityProxy = var_3_2

			local var_3_3 = var_3_1(var_3_2)

			var_3_1.updateActivity(var_3_3, var_1_3)

			local var_3_4 = arg_1_0

			var_3_1 = var_3_1.sendNotification
			GAME = var_2_10003

			var_3_1(var_3_4, var_2_10003.UPDATE_ATELIER_BUFF_DONE, var_1_3)
		else
			pg = var_3_1

			local var_3_5 = var_3_1.TipsMgr.GetInstance()
			local var_3_6 = var_1.ShowTips

			errorTip = var_2_10003

			var_3_6(var_3_5, var_2_10003("", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_1
