class = var_0_10000

local var_0_0 = "ActivityMallOPCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.CMD = {
	START_ORDER = 1,
	GET_STAFF_DATA = 8,
	TRIGGER_POINT = 6,
	SET_FLOOR_STAFF = 7,
	INPUT_GOLD = 4,
	SETTLE_ROUND = 3,
	COMPLETE_ORDER = 2
}

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_2.activity_id
	local var_1_3 = var_1_1

	if not var_1_1.getActivityById(var_1_3, var_1_2) or var_6:isEnd() then
		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()
	local var_1_5 = var_7.Send
	local var_1_6 = 11202
	local var_1_7 = {
		activity_id = var_2.activity_id
	}
	local var_1_8

	if not var_2.cmd then
		var_1_8 = 0
	end

	var_1_7.cmd = var_1_8

	local var_1_9

	if not var_2.arg1 then
		var_1_9 = 0
	end

	var_1_7.arg1 = var_1_9

	local var_1_10

	if not var_2.arg2 then
		var_1_10 = 0
	end

	var_1_7.arg2 = var_1_10

	local var_1_11

	if not var_2.arg_list then
		var_1_11 = {}
	end

	var_1_7.arg_list = var_1_11

	var_1_5(var_1_4, var_1_6, var_1_7, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1

			var_2_10003 = var_1.getActivityById(var_2_0, var_1_2)
			var_2_10003 = var_1.GetLevelData(var_2_10003).level
			switch = var_2_10004

			var_2_10004(var_0.cmd, {
				[var_0_1.CMD.START_ORDER] = function()
					local var_3_0 = var_0

					var_0.OnStartOrderDone(var_3_0, var_0.arg1, arg_2_0.number[1], var_0.arg_list)

					ipairs = var_0
					MallOrder = var_3_0

					for iter_3_0, iter_3_1 in var_0(var_3_0.GetCost(var_0.arg1)) do
						reducePlayerOwn = var_3_10005

						var_3_10005(iter_3_1)
					end

					return
				end,
				[var_0_1.CMD.COMPLETE_ORDER] = function()
					var_2_10003 = arg_2_0.number[1]

					local var_4_0 = var_0

					var_0.OnCompleteOrderDone(var_4_0, var_0.arg1)

					return
				end,
				[var_0_1.CMD.SETTLE_ROUND] = function()
					var_2_10003 = arg_2_0.number[1]

					local var_5_0 = var_0

					var_0.NextRound(var_5_0, arg_2_0.number)

					return
				end,
				[var_0_1.CMD.INPUT_GOLD] = function()
					local var_6_0 = var_0

					var_0.ReduceGold(var_6_0, var_0.arg1)

					pg = var_0

					local var_6_1 = var_0.TipsMgr.GetInstance()
					local var_6_2 = var_0.ShowTips

					i18n = var_2

					var_6_2(var_6_1, var_2("mall_gold_input_success_tip"))

					return
				end,
				[var_0_1.CMD.TRIGGER_POINT] = function()
					local var_7_0 = var_0

					var_0.OnTriggerPointDone(var_7_0, var_0.arg1)

					return
				end,
				[var_0_1.CMD.SET_FLOOR_STAFF] = function()
					local var_8_0 = var_0

					var_0.OnUpdateFloorStaffDone(var_8_0, var_0.arg_list)

					return
				end,
				[var_0_1.CMD.GET_STAFF_DATA] = function()
					assert = var_3_10000

					var_3_10000(#arg_2_0.number % 2 == 0, "staff attr data must be even")

					local var_9_0 = var_0

					var_0.SetStaffExtraData(var_9_0, var_0.arg1, arg_2_0.number)

					return
				end
			})

			if var_2_10003 ~= var_2 then
				var_1:OnUpgradeDone(var_2_10003)
			end

			local var_2_1 = var_1_1

			var_4.updateActivity(var_2_1, var_1)

			local var_2_2 = {}

			PlayerConst = var_2_1

			local var_2_3 = var_2_1.addTranDrop(arg_2_0.award_list)
			local var_2_4 = arg_1_0
			local var_2_5 = var_5.sendNotification

			GAME = var_7

			local var_2_6 = var_7.ACTIVITY_MALL_OP_DONE
			local var_2_7 = {
				cmd = var_0.cmd,
				awards = var_2_3,
				levels = {
					var_2,
					var_2_10003
				}
			}
			local var_2_8

			if var_0.cmd ~= var_0_1.CMD.COMPLETE_ORDER or not var_0.arg1 then
				var_2_8 = 0
			end

			var_2_7.completeOrderId = var_2_8

			var_2_5(var_2_4, var_2_6, var_2_7)

			existCall = var_2_5

			var_2_5(var_1_0)
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_10(var_2_9, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
