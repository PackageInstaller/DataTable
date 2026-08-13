class = var_0_10000

local var_0_0 = "GraftingActivityOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_1_1, var_1_0) or var_5:isEnd() then
		pg = var_1_1

		local var_1_2 = var_1_1.TipsMgr.GetInstance()
		local var_1_3 = var_6.ShowTips

		i18n = var_1_10008

		var_1_3(var_1_2, var_1_10008("common_activity_end"))

		return
	end

	local var_1_4 = var_5:getConfig("config_id")
	local var_1_5 = var_4
	local var_1_6

	if var_4.getActivityById(var_1_5, var_1_4) then
		var_1_6 = var_7

		if not var_7.isEnd(var_1_6) then
			pg = var_1_5
			var_1_6 = var_1_5.TipsMgr.GetInstance()
			var_1_5 = var_1_5.ShowTips
			i18n = var_1_10010

			var_1_5(var_1_6, var_1_10010("common_activity_not_start"))

			return
		end
	end

	pg = var_1_5

	local var_1_7 = var_1_5.activity_template[var_1_4].type

	pg = var_1_6

	local var_1_8 = var_1_6.ConnectionMgr.GetInstance()
	local var_1_9 = var_9.Send
	local var_1_10 = 11202
	local var_1_11 = {
		activity_id = var_1_0
	}
	local var_1_12

	if not var_2.cmd then
		var_1_12 = 0
	end

	var_1_11.cmd = var_1_12

	local var_1_13

	if not var_2.arg1 then
		var_1_13 = 0
	end

	var_1_11.arg1 = var_1_13

	local var_1_14

	if not var_2.arg2 then
		var_1_14 = 0
	end

	var_1_11.arg2 = var_1_14
	var_1_11.arg_list = {}

	var_1_9(var_1_8, var_1_10, var_1_11, 11203, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			if var_2_2.IsBuildShipType(var_2_0, var_1_7) then
				local var_2_1 = arg_1_0

				var_2_2.UpdateActivityForBuildShip(var_2_1, var_1_0)
			end

			PlayerConst = var_2_2
			var_2_2 = var_2_2.addTranDrop(arg_2_0.award_list)
			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_10003, var_2_10004.GRAFTING_ACT_OP_DONE, {
				linkActType = var_1_7,
				awards = var_2_2
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.IsBuildShipType(arg_3_0, arg_3_1)
	ActivityConst = var_1_10002

	local var_3_0

	if arg_3_1 ~= var_1_10002.ACTIVITY_TYPE_BUILDSHIP_1 then
		ActivityConst = var_2

		if arg_3_1 ~= var_2.ACTIVITY_TYPE_BUILD then
			ActivityConst = var_2

			if arg_3_1 ~= var_2.ACTIVITY_TYPE_NEWSERVER_BUILD then
				var_3_0 = false

				goto label_3_0
			end
		end
	end

	var_3_0 = true

	::label_3_0::

	return var_3_0
end

function var_0_1.UpdateActivityForBuildShip(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	var_3.data2 = var_2.getActivityById(var_4_0, arg_4_1).data2 + 1

	var_2:updateActivity(var_3)

	return
end

return var_0_1
