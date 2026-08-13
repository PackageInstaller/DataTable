class = var_0_10000

local var_0_0 = "SculptureActivityOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.state

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getActivityByType

	ActivityConst = var_1_10007

	if var_1_3(var_1_2, var_1_10007.ACTIVITY_TYPE_SCULPTURE) then
		local var_1_4 = var_5

		if var_5.isEnd(var_1_4) then
			pg = var_1_2
			var_1_4 = var_1_2.TipsMgr.GetInstance()
			var_1_2 = var_1_2.ShowTips
			i18n = var_1_10008

			var_1_2(var_1_4, var_1_10008("common_activity_end"))

			return
		end

		getProxy = var_1_2
		ActivityProxy = var_1_4

		local var_1_5 = var_1_2(var_1_4)
		local var_1_6 = var_6.getActivityByType

		ActivityConst = var_1_10008

		if not var_1_6(var_1_5, var_1_10008.ACTIVITY_TYPE_VIRTUAL_BAG) or var_6:isEnd() then
			pg = var_1_5

			local var_1_7 = var_1_5.TipsMgr.GetInstance()
			local var_1_8 = var_7.ShowTips

			i18n = var_1_10009

			var_1_8(var_1_7, var_1_10009("common_activity_end"))

			return
		end

		local var_1_10

		if not var_5:CanEnterState(var_1_0, var_1_1) then
			pg = var_1_10

			local var_1_9 = var_1_10.TipsMgr.GetInstance()

			var_1_10 = var_1_10.ShowTips
			i18n = var_9

			var_1_10(var_1_9, var_9("common_error"))

			return
		end

		SculptureActivity = var_1_10

		local var_1_11

		if var_1_1 == var_1_10.STATE_UNLOCK then
			local var_1_12

			var_1_11, var_1_12 = var_5:_GetComsume(var_1_0)

			local var_1_13 = var_6

			if var_1_12 > var_6.getVitemNumber(var_1_13, var_1_11) then
				pg = var_1_13

				local var_1_14 = var_1_13.activity_workbench_item[var_1_11].name

				pg = var_11

				local var_1_15 = var_11.TipsMgr.GetInstance()
				local var_1_16 = var_11.ShowTips

				i18n = var_1_10013

				var_1_16(var_1_15, var_1_10013("gift_act_tips", var_1_14))

				return
			end
		end

		pg = var_1_11

		local var_1_17 = var_1_11.ConnectionMgr.GetInstance()

		var_7.Send(var_1_17, 11202, {
			cmd = 1,
			activity_id = var_5.id,
			arg1 = var_1_0,
			arg2 = var_1_1,
			arg_list = {},
			arg_list2 = {},
			kvargs1 = {}
		}, 11203, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				PlayerConst = var_2_0
				var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)

				local var_2_1 = var_1_1

				SculptureActivity = var_2_10003

				if var_2_1 == var_2_10003.STATE_UNLOCK then
					var_2_10003 = var_0

					local var_2_2

					var_2_2, var_2_10003 = var_2._GetComsume(var_2_10003, var_1_0)

					local var_2_3 = var_0
					local var_2_4 = var_4.getVitemNumber(var_2_3, var_2_2)
					local var_2_5 = var_0

					var_5.addVitemNumber(var_2_5, var_2_2, 0 - var_2_10003)

					getProxy = var_5
					ActivityProxy = var_2_5

					local var_2_6 = var_5(var_2_5)

					var_5.updateActivity(var_2_6, var_0)
				end

				var_2_10003 = var_0

				var_2.UpdateState(var_2_10003, var_1_0, var_1_1)

				getProxy = var_2
				ActivityProxy = var_2_10003
				var_2_10003 = var_2(var_2_10003)

				var_2.updateActivity(var_2_10003, var_0)

				var_2_10003 = arg_1_0

				local var_2_7 = var_2.sendNotification

				GAME = var_4

				var_2_7(var_2_10003, var_4.SCULPTURE_ACT_OP_DONE, {
					state = var_1_1,
					activity = var_0,
					id = var_1_0,
					awards = var_2_0
				})
			else
				pg = var_2_0

				local var_2_8 = var_2_0.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
