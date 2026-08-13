class = var_0_10000

local var_0_0 = "ActivityTownOPCommand"

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

	local var_1_9

	if not var_2.arg_list then
		var_1_9 = {}
	end

	var_1_5.arg_list = var_1_9
	var_1_5.kvargs1 = var_2.kvargs1

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			PlayerConst = var_2_10002
			var_2_0 = var_2_10002.addTranDrop(arg_2_0.award_list)
			var_2_10003 = var_0
			var_0 = var_2.getActivityById(var_2_10003, var_0.activity_id)
			var_2_10003 = var_0

			local var_2_1 = var_2.getConfig(var_2_10003, "type")

			ActivityConst = var_2_10003

			if var_2_1 == var_2_10003.ACTIVITY_TYPE_TOWN2 then
				switch = var_2_1
				var_2_10003 = var_0.cmd

				local var_2_2 = {}

				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.UPGRADE_TOWN] = function()
					return
				end
				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.UPGRADE_PLACE] = function()
					local var_4_0 = var_0

					var_0.OnUpgradePlace(var_4_0, var_0.arg1, arg_2_0.number[1])

					return
				end
				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.CHANGE_SHIPS] = function()
					local var_5_0 = var_0

					var_0.OnChangeShips(var_5_0, var_0.kvargs1)

					return
				end
				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.CLICK_BUBBLE] = function()
					local var_6_0 = var_0

					var_0.OnGetBubbleAward(var_6_0, var_0.arg_list, arg_2_0.number)

					return
				end
				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.SETTLE_GOLD] = function()
					local var_7_0 = var_0

					var_0.OnGatherPlaceGold(var_7_0, var_0.arg1, arg_2_0.number[2])

					return
				end
				TownActivity2 = var_2_10005
				var_2_2[var_2_10005.OPERATION.ALL_GOLD] = function()
					local var_8_0 = var_0

					var_0.OnAllGatherPlaceGold(var_8_0, arg_2_0.number)

					return
				end

				var_2_1(var_2_10003, var_2_2)
			else
				switch = var_2_1
				var_2_10003 = var_0.cmd

				local var_2_3 = {}

				TownActivity = var_2_10005
				var_2_3[var_2_10005.OPERATION.UPGRADE_TOWN] = function()
					local var_9_0 = var_0

					var_0.OnUpgradeTown(var_9_0, arg_2_0.number[1])

					return
				end
				TownActivity = var_5
				var_2_3[var_5.OPERATION.UPGRADE_PLACE] = function()
					local var_10_0 = var_0

					var_0.OnUpgradePlace(var_10_0, var_0.arg1, arg_2_0.number[1])

					return
				end
				TownActivity = var_5
				var_2_3[var_5.OPERATION.CHANGE_SHIPS] = function()
					local var_11_0 = var_0

					var_0.OnChangeShips(var_11_0, var_0.kvargs1)

					return
				end
				TownActivity = var_5
				var_2_3[var_5.OPERATION.CLICK_BUBBLE] = function()
					local var_12_0 = var_0

					var_0.OnGetBubbleAward(var_12_0, var_0.arg_list, arg_2_0.number)

					return
				end
				TownActivity = var_5
				var_2_3[var_5.OPERATION.SETTLE_GOLD] = function()
					local var_13_0 = var_0

					var_0.OnSettleGold(var_13_0, arg_2_0.number[2])

					return
				end

				var_2_1(var_2_10003, var_2_3)
			end

			var_2_10003 = var_0

			var_2.updateActivity(var_2_10003, var_0)

			if var_1_0 then
				var_1_0()
			end

			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_4

			var_2_4(var_2_10003, var_4.ACTIVITY_TOWN_OP_DONE, {
				awards = var_2_0,
				cmd = var_0.cmd
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
