class = var_0_10000

local var_0_0 = "ActivityProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ACTIVITY_ADDED = "ActivityProxy ACTIVITY_ADDED"
var_0_1.ACTIVITY_UPDATED = "ActivityProxy ACTIVITY_UPDATED"
var_0_1.ACTIVITY_DELETED = "ActivityProxy ACTIVITY_DELETED"
var_0_1.ACTIVITY_END = "ActivityProxy ACTIVITY_END"
var_0_1.ACTIVITY_OPERATION_DONE = "ActivityProxy ACTIVITY_OPERATION_DONE"
var_0_1.ACTIVITY_SHOW_AWARDS = "ActivityProxy ACTIVITY_SHOW_AWARDS"
var_0_1.ACTIVITY_SHOP_SHOW_AWARDS = "ActivityProxy ACTIVITY_SHOP_SHOW_AWARDS"
var_0_1.ACTIVITY_SHOW_BB_RESULT = "ActivityProxy ACTIVITY_SHOW_BB_RESULT"
var_0_1.ACTIVITY_LOTTERY_SHOW_AWARDS = "ActivityProxy ACTIVITY_LOTTERY_SHOW_AWARDS"
var_0_1.ACTIVITY_HITMONSTER_SHOW_AWARDS = "ActivityProxy ACTIVITY_HITMONSTER_SHOW_AWARDS"
var_0_1.ACTIVITY_SHOW_REFLUX_AWARDS = "ActivityProxy ACTIVITY_SHOW_REFLUX_AWARDS"
var_0_1.ACTIVITY_OPERATION_ERRO = "ActivityProxy ACTIVITY_OPERATION_ERRO"
var_0_1.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT = "ActivityProxy ACTIVITY_SHOW_LOTTERY_AWARD_RESULT"
var_0_1.ACTIVITY_SHOW_RED_PACKET_AWARDS = "ActivityProxy ACTIVITY_SHOW_RED_PACKET_AWARDS"
var_0_1.ACTIVITY_SHOW_SHAKE_BEADS_RESULT = "ActivityProxy ACTIVITY_SHOW_SHAKE_BEADS_RESULT"
var_0_1.ACTIVITY_EXCHANGE_RESOURCES = "ActivityProxy ACTIVITY_EXCHANGE_RESOURCES"
var_0_1.UPDATED_TIP = "ActivityProxy UPDATED_TIP"
var_0_1.ACTIVITY_PT_ID = 110

function var_0_1.register(arg_1_0)
	arg_1_0:on(11200, function(arg_2_0)
		arg_1_0.data = {}
		arg_1_0.params = {}
		arg_1_0.hxList = {}
		arg_1_0.stopList = {}

		if arg_2_0.hx_list then
			ipairs = var_1

			for iter_2_0, iter_2_1 in var_1(arg_2_0.hx_list) do
				table = var_2_10006

				var_2_10006.insert(arg_1_0.hxList, iter_2_1)
			end
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.activity_list) do
			pg = var_2_10006

			if not var_2_10006.activity_template[iter_2_3.id] then
				Debugger = var_2_10006

				var_2_10006.LogError("活动acvitity_template不存在: " .. iter_2_3.id)
			else
				Activity = var_2_10006

				local var_2_0 = var_2_10006.Create(iter_2_3)

				var_2_10007 = var_2_10006.getConfig(var_2_0, "type")
				ActivityConst = var_8

				if var_2_10007 == var_8.ACTIVITY_TYPE_PARAMETER then
					local var_2_1 = arg_1_0

					var_8.addActivityParameter(var_2_1, var_2_10006)
				else
					ActivityConst = var_8

					if var_2_10007 == var_8.ACTIVITY_TYPE_EVENT_SINGLE then
						local var_2_2 = arg_1_0

						var_8.CheckDailyEventRequest(var_2_2, var_2_10006)
					else
						local var_2_3 = arg_1_0

						var_8.CheckCreateActivityFleet(var_2_3, var_2_10006, iter_2_3)
					end
				end

				arg_1_0.data[iter_2_3.id] = var_2_10006

				if var_2_10006.stopTime > 0 then
					table = var_8

					var_8.insert(arg_1_0.stopList, {
						var_2_10006.stopTime,
						var_2_10006.id
					})

					table = var_8

					local var_2_4 = var_8.sort
					local var_2_5 = arg_1_0.stopList

					CompareFuncs = var_11

					var_2_4(var_2_5, var_11({
						function(arg_3_0)
							return arg_3_0[1]
						end
					}))
				end
			end
		end

		local var_2_6 = arg_1_0
		local var_2_7 = var_1.getActivityByType

		ActivityConst = iter_2_2

		if var_2_7(var_2_6, iter_2_2.ACTIVITY_TYPE_CHALLENGE) and not var_1:isEnd() then
			local var_2_8 = arg_1_0
			local var_2_9 = var_2.sendNotification

			GAME = iter_2_3

			var_2_9(var_2_8, iter_2_3.CHALLENGE2_INFO, {})
		end

		local var_2_10 = arg_1_0
		local var_2_11 = var_2.getActivityByType

		ActivityConst = iter_2_3

		if var_2_11(var_2_10, iter_2_3.ACTIVITY_TYPE_TASK_LIST_MONITOR) and not var_2:isEnd() and var_2.data1 == 0 then
			local var_2_12 = arg_1_0

			var_2_6.monitorTaskList(var_2_12, var_2)
		end

		pg = var_2_6

		local var_2_13 = var_2_6.ShipFlagMgr.GetInstance()

		var_3.UpdateFlagShips(var_2_13, "inElite")
		;(function()
			local var_4_0 = arg_1_0
			local var_4_1 = var_0.getActivityByType

			ActivityConst = var_3_10003

			if not var_4_1(var_4_0, var_3_10003.ACTIVITY_TYPE_ATELIER_LINK) then
				return
			end

			local var_4_2 = arg_1_0
			local var_4_3 = var_1.sendNotification

			GAME = var_3_10004

			var_4_3(var_4_2, var_3_10004.REQUEST_ATELIER, var_0.id)

			return
		end)()

		local var_2_14 = arg_1_0
		local var_2_15 = var_4.getActivityByType

		ActivityConst = var_2_10007

		if var_2_15(var_2_14, var_2_10007.ACTIVITY_TYPE_COLLECTION_EVENT) then
			local var_2_16 = var_4

			if not var_4.isEnd(var_2_16) then
				getProxy = var_2_13
				EventProxy = var_2_16

				local var_2_17 = var_2_13(var_2_16)

				var_2_13.CheckAddActivityEvent(var_2_17)
			end
		end

		BuffHelper = var_2_13

		var_2_13.GetAllBuff()

		return
	end)
	arg_1_0:on(11201, function(arg_5_0)
		Activity = var_2_10001

		local var_5_0 = var_2_10001.Create(arg_5_0.activity_info)

		assert = var_2_10002

		var_2_10002(var_5_0.id, "should exist activity")

		local var_5_1 = var_5_0:getConfig("type")

		ActivityConst = var_3

		if var_5_1 == var_3.ACTIVITY_TYPE_PARAMETER then
			local var_5_2 = arg_1_0

			var_3.addActivityParameter(var_5_2, var_5_0)
		end

		if arg_1_0.data[var_5_0.id] then
			ActivityConst = var_3

			if var_5_1 == var_3.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
				local var_5_3 = arg_1_0

				var_3.CheckCreateActivityFleet(var_5_3, var_5_0, arg_5_0.activity_info)
			end

			if not arg_1_0.data[var_5_0.id] then
				local var_5_4 = arg_1_0

				var_3.addActivity(var_5_4, var_5_0)
			else
				local var_5_5 = arg_1_0

				var_3.updateActivity(var_5_5, var_5_0)
			end

			local var_5_6 = arg_1_0
			local var_5_7 = var_3.sendNotification

			GAME = var_2_10006

			var_5_7(var_5_6, var_2_10006.ACTIVITY_BE_UPDATED, {
				activity = var_5_0
			})

			return
		end
	end)
	arg_1_0:on(40009, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_3

		if not var_1.GetBossActivityByChapterId(var_6_0, arg_6_0.arg1) then
			local var_6_1 = arg_1_0
			local var_6_2 = var_2.getActivityByType

			ActivityConst = var_2_10005
			var_6_3 = var_6_2(var_6_1, var_2_10005.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
		end

		local var_6_4

		if var_6_3 then
			var_6_4 = var_6_3:GetSeriesData()
		end

		BossRushSettlementCommand = var_6_0

		local var_6_5 = var_6_0.ConcludeEXP(arg_6_0, var_6_3, var_6_4 and var_6_4:GetBattleStatistics())

		;(function()
			local var_7_0 = arg_1_0

			var_0.GetBossRushRuntime(var_7_0, var_6_3.id).settlementData = var_6_5

			return
		end)()

		return
	end)
	arg_1_0:on(24100, function(arg_8_0)
		(function()
			local var_9_0 = arg_1_0
			local var_9_1 = var_0.getActivityByType

			ActivityConst = var_3_10003

			if not var_9_1(var_9_0, var_3_10003.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK) then
				return
			end

			var_0:Record(arg_8_0.score)

			local var_9_2 = arg_1_0

			var_1.updateActivity(var_9_2, var_0)

			return
		end)()

		local var_8_0 = arg_1_0

		if not var_2.getActivityById(var_8_0, arg_8_0.act_id) then
			return
		end

		if not var_2:GetSeriesData() then
			return
		end

		var_3:AddEXScore(arg_8_0)

		local var_8_1 = arg_1_0

		var_4.updateActivity(var_8_1, var_2)

		return
	end)
	arg_1_0:on(11028, function(arg_10_0)
		print = var_2_10001

		var_2_10001("接受到问卷状态", arg_10_0.result)

		if arg_10_0.result == 0 then
			local var_10_0 = arg_1_0

			var_1.setSurveyState(var_10_0, arg_10_0.result)
		elseif arg_10_0.result > 0 then
			local var_10_1 = arg_1_0

			var_1.setSurveyState(var_10_1, arg_10_0.result)
		else
			pg = var_1

			local var_10_2 = var_1.TipsMgr.GetInstance()
			local var_10_3 = var_1.ShowTips

			errorTip = var_4

			var_10_3(var_10_2, var_4("", arg_10_0.result))
		end

		return
	end)
	arg_1_0:on(26033, function(arg_11_0)
		local var_11_0 = arg_1_0
		local var_11_1 = var_1.getActivityByType

		ActivityConst = var_2_10004

		if not var_11_1(var_11_0, var_2_10004.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) then
			return
		end

		local var_11_2 = arg_11_0.point
		local var_11_3 = var_1:UpdateHighestScore(var_11_2)
		local var_11_4 = arg_1_0

		var_4.GetActivityBossRuntime(var_11_4, var_1.id).spScore = {
			score = var_11_2,
			new = var_11_3
		}

		local var_11_5 = arg_1_0

		var_4.updateActivity(var_11_5, var_1)

		return
	end)

	arg_1_0.requestTime = {}
	arg_1_0.extraDatas = {}

	return
end

function var_0_1.remove(arg_12_0)
	BuffHelper = var_1_10001

	var_1_10001.ClearAllCache()

	return
end

function var_0_1.timeCall(arg_13_0)
	local var_13_0 = {}

	ProxyRegister = var_1_10002
	var_13_0[var_1_10002.DayCall] = function(arg_14_0)
		pairs = var_2_10001

		for iter_14_0, iter_14_1 in var_2_10001(arg_13_0.data) do
			if not iter_14_1:isEnd() then
				switch = var_6

				local var_14_0 = iter_14_1
				local var_14_1 = iter_14_1.getConfig(var_14_0, "type")
				local var_14_2 = {}

				ActivityConst = var_14_0
				var_14_2[var_14_0.ACTIVITY_TYPE_7DAYSLOGIN] = function()
					iter_14_1.autoActionForbidden = false

					local var_15_0 = arg_13_0

					var_0.updateActivity(var_15_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_PROGRESSLOGIN] = function()
					iter_14_1.autoActionForbidden = false

					local var_16_0 = arg_13_0

					var_0.updateActivity(var_16_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_MONTHSIGN] = function()
					iter_14_1.autoActionForbidden = false

					local var_17_0 = arg_13_0

					var_0.updateActivity(var_17_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_REFLUX] = function()
					iter_14_1.data1KeyValueList = {
						{}
					}
					iter_14_1.autoActionForbidden = false

					local var_18_0 = arg_13_0

					var_0.updateActivity(var_18_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_HITMONSTERNIAN] = function()
					iter_14_1.autoActionForbidden = false

					local var_19_0 = arg_13_0

					var_0.updateActivity(var_19_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_BB] = function()
					iter_14_1.data2 = 0
					iter_14_1.autoActionForbidden = false

					local var_20_0 = arg_13_0

					var_0.updateActivity(var_20_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_LOTTERY_AWARD] = function()
					iter_14_1.data2 = 0
					iter_14_1.autoActionForbidden = false

					local var_21_0 = arg_13_0

					var_0.updateActivity(var_21_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_BOSSRUSH] = function()
					local var_22_0 = iter_14_1
					local var_22_1 = var_0.GetUsedBonus(var_22_0)

					table = var_3_10001

					var_3_10001.Foreach(var_22_1, function(arg_23_0, arg_23_1)
						var_22_1[arg_23_0] = 0

						return
					end)

					local var_22_2 = arg_13_0

					var_1.updateActivity(var_22_2, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_BOSSSINGLE] = function()
					local var_24_0 = iter_14_1
					local var_24_1 = var_0.GetDailyCounts(var_24_0)

					table = var_3_10001

					var_3_10001.Foreach(var_24_1, function(arg_25_0, arg_25_1)
						var_24_1[arg_25_0] = 0

						return
					end)

					local var_24_2 = arg_13_0

					var_1.updateActivity(var_24_2, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
					local var_26_0 = arg_13_0

					var_0.updateActivity(var_26_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_MANUAL_SIGN] = function()
					local var_27_0 = arg_13_0
					local var_27_1 = var_0.sendNotification

					GAME = var_3_10003

					local var_27_2 = var_3_10003.ACT_MANUAL_SIGN
					local var_27_3 = {
						activity_id = iter_14_1.id
					}

					ManualSignActivity = var_5
					var_27_3.cmd = var_5.OP_SIGN

					var_27_1(var_27_0, var_27_2, var_27_3)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_TURNTABLE] = function()
					local var_28_0 = iter_14_1
					local var_28_1 = var_0.getConfig(var_28_0, "config_id")

					pg = var_3_10001

					if var_3_10001.activity_event_turning[var_28_1].total_num <= iter_14_1.data3 then
						return
					end

					if not var_1.task_table[iter_14_1.data4] then
						return
					end

					getProxy = var_4
					TaskProxy = var_3_10006

					local var_28_2 = var_4(var_3_10006)

					ipairs = var_3_10005

					for iter_28_0, iter_28_1 in var_3_10005(var_3) do
						local var_28_3

						if not var_28_2:getTaskById(iter_28_1) then
							var_28_3 = var_28_2:getFinishTaskById(iter_28_1)
						end

						if var_28_3:getTaskStatus() ~= 2 then
							return
						end
					end

					local var_28_4 = arg_13_0
					local var_28_5 = var_5.sendNotification

					GAME = iter_28_0

					var_28_5(var_28_4, iter_28_0.ACTIVITY_OPERATION, {
						cmd = 2,
						activity_id = iter_14_1.id
					})

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_MONOPOLY] = function()
					local var_29_0 = arg_13_0

					var_0.updateActivity(var_29_0, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_CHALLENGE] = function()
					local var_30_0 = arg_13_0
					local var_30_1 = var_0.sendNotification

					GAME = var_3_10003

					var_30_1(var_30_0, var_3_10003.CHALLENGE2_INFO, {})

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
					local var_31_0 = iter_14_1.data1KeyValueList[1]

					pg = var_3_10001

					local var_31_1 = var_3_10001.activity_event_worldboss
					local var_31_2 = iter_14_1

					if var_31_1[var_2.getConfig(var_31_2, "config_id")] then
						ipairs = var_2

						local var_31_3

						if not var_1.normal_expedition_drop_num then
							var_31_3 = {}
						end

						for iter_31_0, iter_31_1 in var_2(var_31_3) do
							ipairs = var_3_10007

							for iter_31_2, iter_31_3 in var_3_10007(iter_31_1[1]) do
								local var_31_4

								if not iter_31_1[2] then
									var_31_4 = 0
								end

								var_31_0[iter_31_3] = var_31_4
							end
						end
					end

					local var_31_5 = arg_13_0

					var_2.updateActivity(var_31_5, iter_14_1)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_RANDOM_DAILY_TASK] = function()
					pg = var_3_10000

					local var_32_0 = var_3_10000.TimeMgr.GetInstance()
					local var_32_1 = var_0.GetServerTime(var_32_0)

					pg = var_3_10001

					local var_32_2 = var_3_10001.TimeMgr.GetInstance()

					if var_1.IsSameDay(var_32_2, iter_14_1.data1, var_32_1) then
						return
					end

					pg = var_32_0

					local var_32_3 = var_32_0.m02
					local var_32_4 = var_2.sendNotification

					GAME = var_5

					local var_32_5 = var_5.ACT_RANDOM_DAILY_TASK
					local var_32_6 = {
						activity_id = iter_14_1.id
					}

					ActivityConst = var_7
					var_32_6.cmd = var_7.RANDOM_DAILY_TASK_OP_RANDOM

					var_32_4(var_32_3, var_32_5, var_32_6)

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_EVENT_SINGLE] = function()
					local var_33_0 = arg_13_0
					local var_33_1 = var_0.sendNotification

					GAME = var_3_10003

					var_33_1(var_33_0, var_3_10003.SINGLE_EVENT_REFRESH, {
						actId = iter_14_1.id
					})

					return
				end
				ActivityConst = var_10
				var_14_2[var_10.ACTIVITY_TYPE_LOVE_LETTER_UP] = function()
					local var_34_0 = iter_14_1

					var_0.DayReset(var_34_0)

					local var_34_1 = arg_13_0

					var_0.updateActivity(var_34_1, iter_14_1)

					return
				end

				var_6(var_14_1, var_14_2)
			end
		end

		return
	end
	ProxyRegister = var_2
	var_13_0[var_2.SecondCall] = function(arg_35_0)
		pairs = var_2_10001

		for iter_35_0, iter_35_1 in var_2_10001(arg_13_0.data) do
			if not iter_35_1:isEnd() then
				switch = var_6

				local var_35_0 = iter_35_1
				local var_35_1 = iter_35_1.getConfig(var_35_0, "type")
				local var_35_2 = {}

				ActivityConst = var_35_0
				var_35_2[var_35_0.ACTIVITY_TYPE_TOWN] = function()
					local var_36_0 = iter_35_1

					var_0.UpdateTime(var_36_0)

					return
				end
				ActivityConst = var_10
				var_35_2[var_10.ACTIVITY_TYPE_TOWN2] = function()
					local var_37_0 = iter_35_1

					var_0.UpdateTime(var_37_0)

					return
				end

				var_6(var_35_1, var_35_2)
			end
		end

		if not arg_13_0.stopList then
			return
		end

		pg = var_1

		local var_35_3 = var_1.TimeMgr.GetInstance()
		local var_35_4 = var_1.GetServerTime(var_35_3)

		while #arg_13_0.stopList > 0 and arg_13_0.stopList[1][1] <= var_35_4 do
			unpack = var_35_5
			table = iter_35_0

			local var_35_5, var_35_6 = var_35_5(iter_35_0.remove(arg_13_0.stopList, 1))

			iter_35_0 = arg_13_0.data[var_35_6]
			switch = iter_35_1

			local var_35_7 = iter_35_0
			local var_35_8 = iter_35_0.getConfig(var_35_7, "type")
			local var_35_9 = {}

			ActivityConst = var_35_7
			var_35_9[var_35_7.ACTIVITY_TYPE_MILITARY_EXERCISE] = function()
				getProxy = var_3_10000
				MilitaryExerciseProxy = var_3_10002

				local var_38_0 = var_3_10000(var_3_10002)

				var_0.setSeasonOver(var_38_0)

				return
			end
			ActivityConst = var_9
			var_35_9[var_9.ACTIVITY_TYPE_NPC_COLLECTION] = function()
				getProxy = var_3_10000
				BayProxy = var_3_10002

				local var_39_0 = var_3_10000(var_3_10002)

				if var_0.getShipById(var_39_0, iter_35_0.data2) and var_0:isActivityNpc() then
					local var_39_1 = arg_13_0
					local var_39_2 = var_1.sendNotification

					GAME = var_3_10004

					var_39_2(var_39_1, var_3_10004.SEND_CMD, {
						cmd = "kick"
					})
				end

				return
			end
			ActivityConst = var_9
			var_35_9[var_9.ACTIVITY_TYPE_TASKS] = function()
				getProxy = var_3_10000
				TaskProxy = var_3_10002

				local var_40_0 = var_3_10000(var_3_10002)

				ipairs = var_3_10001

				local var_40_1 = iter_35_0

				for iter_40_0, iter_40_1 in var_3_10001(var_3.getConfig(var_40_1, "config_data")) do
					var_40_0:deleteTaskById(iter_40_1)
				end

				return
			end

			iter_35_1(var_35_8, var_35_9)

			pg = iter_35_1

			local var_35_10 = iter_35_1.ShipFlagMgr.GetInstance()

			iter_35_1.UpdateFlagShips(var_35_10, "inActivity")

			local var_35_11 = arg_13_0

			iter_35_1.sendNotification(var_35_11, var_0_1.ACTIVITY_END, var_35_6)
		end

		return
	end

	return var_13_0
end

function var_0_1.getAliveActivityByType(arg_41_0, arg_41_1)
	pairs = var_1_10002

	for iter_41_0, iter_41_1 in var_1_10002(arg_41_0.data) do
		if iter_41_1:getConfig("type") == arg_41_1 and not iter_41_1:isEnd() then
			return iter_41_1
		end
	end

	return
end

function var_0_1.getActivityByType(arg_42_0, arg_42_1)
	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.data) do
		if iter_42_1:getConfig("type") == arg_42_1 then
			return iter_42_1
		end
	end

	return
end

function var_0_1.getActivitiesByType(arg_43_0, arg_43_1)
	local var_43_0 = {}

	pairs = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10003(arg_43_0.data) do
		if iter_43_1:getConfig("type") == arg_43_1 then
			table = var_8

			var_8.insert(var_43_0, iter_43_1)
		end
	end

	return var_43_0
end

function var_0_1.getActivitiesByTypes(arg_44_0, arg_44_1)
	local var_44_0 = {}

	pairs = var_1_10003

	for iter_44_0, iter_44_1 in var_1_10003(arg_44_0.data) do
		table = var_1_10008

		if var_1_10008.contains(arg_44_1, iter_44_1:getConfig("type")) then
			table = var_1_10008

			var_1_10008.insert(var_44_0, iter_44_1)
		end
	end

	return var_44_0
end

function var_0_1.getMilitaryExerciseActivity(arg_45_0)
	local var_45_0

	pairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0.data) do
		local var_45_1 = iter_45_1:getConfig("type")

		ActivityConst = var_1_10008

		if var_45_1 == var_1_10008.ACTIVITY_TYPE_MILITARY_EXERCISE then
			var_45_0 = iter_45_1

			break
		end
	end

	Clone = var_2

	return var_2(var_45_0)
end

function var_0_1.getPanelActivities(arg_46_0)
	local function var_46_0(arg_47_0)
		local var_47_0 = arg_47_0
		local var_47_1 = arg_47_0.getConfig(var_47_0, "type")
		local var_47_2 = arg_47_0

		if arg_47_0.isShow(var_47_2) then
			var_47_2 = arg_47_0

			local var_47_3

			if not arg_47_0.isAfterShow(var_47_2) then
				var_47_2 = arg_47_0
				var_47_3 = arg_47_0.isCorePage(var_47_2, "")
			else
				var_47_3 = false
			end
		end

		if false then
			var_47_3 = true
		end

		if var_47_3 then
			ActivityConst = var_47_0

			if var_47_1 == var_47_0.ACTIVITY_TYPE_CHARGEAWARD then
				var_47_3 = arg_47_0.data2 == 0
			else
				ActivityConst = var_3

				if var_47_1 == var_3.ACTIVITY_TYPE_PROGRESSLOGIN then
					var_47_3 = arg_47_0.data1 < 7 or not arg_47_0.achieved
				else
					ActivityConst = var_3

					if var_47_1 == var_3.ACTIVITY_TYPE_SURVEY then
						PLATFORM = var_3
						PLATFORM_OPENHARMONY = var_47_2
						var_47_3 = var_3 ~= var_47_2
					end
				end
			end
		end

		return var_47_3 and not arg_47_0:isEnd()
	end

	local var_46_1 = {}

	pairs = var_1_10003

	for iter_46_0, iter_46_1 in var_1_10003(arg_46_0.data) do
		if var_46_0(iter_46_1) then
			table = var_8

			var_8.insert(var_46_1, iter_46_1)
		end
	end

	table = var_3

	local var_46_2 = var_3.sort
	local var_46_3 = var_46_1

	CompareFuncs = iter_46_0

	var_46_2(var_46_3, iter_46_0({
		function(arg_48_0)
			return -arg_48_0:getConfig("login_pop")
		end,
		function(arg_49_0)
			return arg_49_0.id
		end
	}))

	return var_46_1
end

function var_0_1.getCorePanelActivities(arg_50_0, arg_50_1)
	local var_50_0 = {}

	pairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.data) do
		if iter_50_1:isShow() and iter_50_1:isCorePage(arg_50_1) then
			table = var_8

			var_8.insert(var_50_0, iter_50_1)
		end
	end

	table = var_3

	local var_50_1 = var_3.sort
	local var_50_2 = var_50_0

	CompareFuncs = iter_50_0

	var_50_1(var_50_2, iter_50_0({
		function(arg_51_0)
			return -arg_51_0:getConfig("login_pop")
		end,
		function(arg_52_0)
			return arg_52_0.id
		end
	}))

	return var_50_0
end

function var_0_1.getIslandPanelActivities(arg_53_0)
	local function var_53_0(arg_54_0)
		local var_54_0 = arg_54_0
		local var_54_1 = arg_54_0.getConfig(var_54_0, "type")
		local var_54_6

		if arg_54_0:isIslandShow() then
			ActivityConst = var_54_0

			if var_54_1 == var_54_0.ACTIVITY_TYPE_SURVEY then
				local var_54_2 = arg_53_0
				local var_54_3 = var_3.isSurveyOpen(var_54_2)
				local var_54_4 = arg_53_0
				local var_54_5 = var_4.isSurveyDone(var_54_4)

				var_54_6 = var_54_3 and not var_54_5
				PLATFORM = var_54_2
				PLATFORM_OPENHARMONY = var_54_4

				if var_54_2 == var_54_4 then
					var_54_6 = false
				end
			end
		end

		return var_54_6 and not arg_54_0:isEnd()
	end

	local var_53_1 = {}

	pairs = var_1_10003

	for iter_53_0, iter_53_1 in var_1_10003(arg_53_0.data) do
		if var_53_0(iter_53_1) then
			table = var_8

			var_8.insert(var_53_1, iter_53_1)
		end
	end

	return var_53_1
end

function var_0_1.checkHxActivity(arg_55_0, arg_55_1)
	if arg_55_0.hxList and #arg_55_0.hxList > 0 then
		for iter_55_0 = 1, #arg_55_0.hxList do
			if arg_55_0.hxList[iter_55_0] == arg_55_1 then
				return true
			end
		end
	end

	return false
end

function var_0_1.getBannerDisplays(arg_56_0)
	_ = var_1_10001
	pg = var_1_10003

	local var_56_0 = var_1_10001(var_1_10003.activity_banner.all)
	local var_56_1 = var_1.chain(var_56_0)
	local var_56_2 = var_1.map(var_56_1, function(arg_57_0)
		pg = var_2_10001

		return var_2_10001.activity_banner[arg_57_0]
	end)
	local var_56_3 = var_1.filter(var_56_2, function(arg_58_0)
		pg = var_2_10001

		local var_58_0 = var_2_10001.TimeMgr.GetInstance()

		if var_1.inTime(var_58_0, arg_58_0.time) then
			local var_58_1 = arg_58_0.type

			GAMEUI_BANNER_9 = var_2_10002

			if var_58_1 ~= var_2_10002 then
				var_58_1 = arg_58_0.type
				GAMEUI_BANNER_11 = var_2_10002

				if var_58_1 ~= var_2_10002 then
					var_58_1 = arg_58_0.type
					GAMEUI_BANNER_10 = var_2_10002

					if var_58_1 ~= var_2_10002 then
						var_58_1 = arg_58_0.type
						GAMEUI_BANNER_12 = var_2_10002

						if var_58_1 ~= var_2_10002 then
							var_58_1 = arg_58_0.type
							GAMEUI_BANNER_13 = var_2_10002

							if var_58_1 == var_2_10002 then
								var_58_1 = false
							else
								var_58_1 = true
							end

							return var_58_1
						end
					end
				end
			end
		end
	end)

	return var_1.value(var_56_3)
end

function var_0_1.getActiveBannerByType(arg_59_0, arg_59_1)
	pg = var_1_10002

	if not var_1_10002.activity_banner.get_id_list_by_type[arg_59_1] then
		return nil
	end

	ipairs = var_1_10003

	for iter_59_0, iter_59_1 in var_1_10003(var_2) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.activity_banner[iter_59_1]
		pg = var_1_10009

		local var_59_0 = var_1_10009.TimeMgr.GetInstance()

		if var_1_10009.inTime(var_59_0, var_1_10008.time) then
			return var_1_10008
		end
	end

	return nil
end

function var_0_1.getNoticeBannerDisplays(arg_60_0)
	_ = var_1_10001

	local var_60_0 = var_1_10001.map

	pg = var_1_10003

	return var_60_0(var_1_10003.activity_banner_notice.all, function(arg_61_0)
		pg = var_2_10001

		return var_2_10001.activity_banner_notice[arg_61_0]
	end)
end

function var_0_1.findNextAutoActivity(arg_62_0, arg_62_1)
	local var_62_0

	pg = var_1_10003

	local var_62_1 = var_1_10003.TimeMgr.GetInstance()
	local var_62_2 = var_3.GetServerTime(var_62_1)
	local var_62_3

	if not arg_62_1 or arg_62_1 == "" or not arg_62_0:getCorePanelActivities(arg_62_1) then
		var_62_3 = arg_62_0:getPanelActivities()
	end

	ipairs = var_62_1

	for iter_62_0, iter_62_1 in var_62_1(var_62_3) do
		if not iter_62_1.autoActionForbidden then
			local var_62_4 = iter_62_1
			local var_62_5 = iter_62_1.getConfig(var_62_4, "type")

			ActivityConst = var_1_10012

			local var_62_6

			if var_62_5 == var_1_10012.ACTIVITY_TYPE_7DAYSLOGIN then
				var_62_6 = iter_62_1

				if iter_62_1.getConfig(var_62_6, "config_client") and var_1_10012.manulSign == true then
					-- block empty
				else
					var_62_4 = iter_62_1:getConfig("config_id")
					pg = var_62_6
					var_62_6 = var_62_6.activity_7_day_sign[var_62_4].front_drops

					if iter_62_1.data1 < #var_62_6 and not var_3:IsSameDay(var_62_2, iter_62_1.data2) and var_62_2 > iter_62_1.data2 then
						var_62_0 = iter_62_1

						break
					end
				end
			else
				ActivityConst = var_1_10012

				if var_62_5 == var_1_10012.ACTIVITY_TYPE_PROGRESSLOGIN then
					getProxy = var_1_10012
					ChapterProxy = var_62_6
					var_1_10012 = var_1_10012(var_62_6)

					if iter_62_1.data1 < 7 and not var_3:IsSameDay(var_62_2, iter_62_1.data2) or iter_62_1.data1 == 7 and not iter_62_1.achieved and var_1_10012:isClear(204) then
						var_62_0 = iter_62_1

						break
					end
				else
					ActivityConst = var_1_10012

					if var_62_5 == var_1_10012.ACTIVITY_TYPE_MONTHSIGN then
						pg = var_1_10012

						local var_62_7 = var_1_10012.TimeMgr.GetInstance()

						var_1_10012 = var_1_10012.STimeDescS(var_62_7, var_62_2, "*t")

						iter_62_1:setSpecialData("reMonthSignDay", nil)

						if var_1_10012.year ~= iter_62_1.data1 or var_1_10012.month ~= iter_62_1.data2 then
							iter_62_1.data1 = var_1_10012.year
							iter_62_1.data2 = var_1_10012.month
							iter_62_1.data1_list = {}
							var_62_0 = iter_62_1

							break
						else
							table = var_62_4

							if not var_62_4.contains(iter_62_1.data1_list, var_1_10012.day) then
								var_62_0 = iter_62_1

								break
							elseif var_1_10012.day > #iter_62_1.data1_list then
								pg = var_62_4

								if var_62_4.activity_month_sign[iter_62_1.data2].resign_count > iter_62_1.data3 then
									for iter_62_2 = var_1_10012.day, 1, -1 do
										table = var_1_10018

										if not var_1_10018.contains(iter_62_1.data1_list, iter_62_2) then
											iter_62_1:setSpecialData("reMonthSignDay", iter_62_2)

											break
										end
									end

									var_62_0 = iter_62_1
								end
							end
						end
					else
						var_1_10012 = iter_62_1.id
						ActivityConst = var_62_4

						if var_1_10012 == var_62_4.SHADOW_PLAY_ID and iter_62_1.clientData1 == 0 then
							var_1_10012 = iter_62_1:getConfig("config_data")[1]
							getProxy = var_13
							TaskProxy = var_15

							local var_62_8 = var_13(var_15)
							local var_62_9

							if not var_13.getTaskById(var_62_8, var_1_10012) then
								var_62_9 = var_13:getFinishTaskById(var_1_10012)
							end

							if var_62_9 and not var_62_9:isReceive() then
								var_62_0 = iter_62_1

								break
							end
						end
					end
				end
			end
		end
	end

	if not var_62_0 then
		pairs = var_6

		for iter_62_3, iter_62_4 in var_6(arg_62_0.data) do
			if not iter_62_4:isShow() then
				local var_62_10 = iter_62_4:getConfig("type")

				ActivityConst = var_1_10012

				if var_62_10 == var_1_10012.ACTIVITY_TYPE_7DAYSLOGIN then
					local var_62_11 = iter_62_4:getConfig("config_id")

					pg = var_1_10012
					var_1_10012 = var_1_10012.activity_7_day_sign[var_62_11].front_drops

					if iter_62_4.data1 < #var_1_10012 and not var_3:IsSameDay(var_62_2, iter_62_4.data2) and var_62_2 > iter_62_4.data2 then
						var_62_0 = iter_62_4

						break
					end
				end
			end
		end
	end

	return var_62_0
end

function var_0_1.findRefluxAutoActivity(arg_63_0)
	local var_63_0 = arg_63_0
	local var_63_1 = arg_63_0.getActivityByType

	ActivityConst = var_1_10004

	if var_63_1(var_63_0, var_1_10004.ACTIVITY_TYPE_REFLUX) then
		local var_63_2 = var_1

		if not var_1.isEnd(var_63_2) and not var_1.autoActionForbidden then
			pg = var_2

			local var_63_3 = var_2.TimeMgr.GetInstance()
			local var_63_4 = var_1.data1_list[2]

			pg = var_63_2

			if var_63_4 < #var_63_2.return_sign_template.all and not var_63_3:IsSameDay(var_63_3:GetServerTime(), var_1.data1_list[1]) then
				return 1
			end
		end
	end

	return
end

function var_0_1.existRefluxAwards(arg_64_0)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.getActivityByType

	ActivityConst = var_1_10004

	if var_64_1(var_64_0, var_1_10004.ACTIVITY_TYPE_REFLUX) and not var_1:isEnd() then
		pg = var_2

		for iter_64_0 = #var_2.return_pt_template.all, 1, -1 do
			local var_64_2 = var_2[var_2.all[iter_64_0]]

			if var_1.data3 >= var_64_2.pt_require and var_7 > var_1.data4 then
				return true
			end
		end

		getProxy = var_3
		TaskProxy = var_5

		local var_64_3 = var_3(var_5)

		_ = var_4

		local var_64_4 = var_4(var_1:getConfig("config_data")[7])
		local var_64_5 = var_4.chain(var_64_4)
		local var_64_6 = var_4.map(var_64_5, function(arg_65_0)
			return arg_65_0[2]
		end)
		local var_64_7 = var_4.flatten(var_64_6)
		local var_64_8 = var_4.map(var_64_7, function(arg_66_0)
			local var_66_0 = var_64_3
			local var_66_2

			if not var_1.getTaskById(var_66_0, arg_66_0) then
				local var_66_1 = var_64_3

				if not var_1.getFinishTaskById(var_66_1, arg_66_0) then
					var_66_2 = false
				end
			end

			return var_66_2
		end)
		local var_64_9 = var_4.filter(var_64_8, function(arg_67_0)
			return not not arg_67_0
		end)
		local var_64_10 = var_4.value(var_64_9)

		_ = var_5

		if var_5.any(var_64_10, function(arg_68_0)
			return arg_68_0:getTaskStatus() == 1
		end) then
			return true
		end
	end

	return
end

function var_0_1.getActivityById(arg_69_0, arg_69_1)
	Clone = var_1_10002

	return var_1_10002(arg_69_0.data[arg_69_1])
end

function var_0_1.RawGetActivityById(arg_70_0, arg_70_1)
	return arg_70_0.data[arg_70_1]
end

function var_0_1.updateActivity(arg_71_0, arg_71_1)
	assert = var_1_10002

	var_1_10002(arg_71_0.data[arg_71_1.id], "activity should exist" .. arg_71_1.id)

	assert = var_1_10002
	isa = var_4

	local var_71_0 = arg_71_1

	Activity = var_1_10007

	var_1_10002(var_4(var_71_0, var_1_10007), "activity should instance of Activity")

	local var_71_1 = arg_71_1:getConfig("type")

	ActivityConst = var_1_10003

	local var_71_4

	if var_71_1 == var_1_10003.ACTIVITY_TYPE_PT_CRUSING then
		pg = var_71_1

		local var_71_2 = var_71_1.battlepass_event_pt[arg_71_1.id].target

		if arg_71_0.data[arg_71_1.id].data1 < var_71_2[#var_71_2] and arg_71_1.data1 - arg_71_0.data[arg_71_1.id].data1 > 0 then
			pg = var_71_4

			local var_71_3 = var_71_4.ToastMgr.GetInstance()

			var_71_4 = var_71_4.ShowToast
			pg = var_71_0
			var_71_0 = var_71_0.ToastMgr.TYPE_CRUSING

			local var_71_5 = {}

			pg = var_1_10008
			var_71_5.ptId = var_1_10008.battlepass_event_pt[arg_71_1.id].pt
			var_71_5.ptCount = arg_71_1.data1 - arg_71_0.data[arg_71_1.id].data1

			var_71_4(var_71_3, var_71_0, var_71_5)
		end
	else
		local var_71_6 = arg_71_1:getConfig("type")

		ActivityConst = var_71_4

		if var_71_6 == var_71_4.ACTIVITY_TYPE_PT_HEI5 then
			pg = var_71_6

			local var_71_7 = var_71_6.black_friday_battlepass_event_pt[arg_71_1.id].target

			if arg_71_0.data[arg_71_1.id].data1 < var_71_7[#var_71_7] and arg_71_1.data1 - arg_71_0.data[arg_71_1.id].data1 > 0 then
				pg = var_3

				local var_71_8 = var_3.ToastMgr.GetInstance()
				local var_71_9 = var_3.ShowToast

				pg = var_71_0

				local var_71_10 = var_71_0.ToastMgr.TYPE_CRUSING
				local var_71_11 = {}

				pg = var_1_10008
				var_71_11.ptId = var_1_10008.black_friday_battlepass_event_pt[arg_71_1.id].pt
				var_71_11.ptCount = arg_71_1.data1 - arg_71_0.data[arg_71_1.id].data1

				var_71_9(var_71_8, var_71_10, var_71_11)
			end
		end
	end

	arg_71_0.data[arg_71_1.id] = arg_71_1

	arg_71_0:sendNotification(var_0_1.ACTIVITY_UPDATED, arg_71_1:clone())

	local var_71_12 = arg_71_0
	local var_71_13 = arg_71_0.sendNotification

	GAME = var_5

	var_71_13(var_71_12, var_5.SYN_GRAFTING_ACTIVITY, {
		id = arg_71_1.id
	})

	BuffHelper = var_71_13

	var_71_13.GenBuffsForActivity(arg_71_1)

	return
end

function var_0_1.addActivity(arg_72_0, arg_72_1)
	assert = var_1_10002

	var_1_10002(arg_72_0.data[arg_72_1.id] == nil, "activity already exist" .. arg_72_1.id)

	assert = var_1_10002
	isa = var_4

	local var_72_0 = arg_72_1

	Activity = var_1_10007

	var_1_10002(var_4(var_72_0, var_1_10007), "activity should instance of Activity")

	arg_72_0.data[arg_72_1.id] = arg_72_1

	arg_72_0:sendNotification(var_0_1.ACTIVITY_ADDED, arg_72_1:clone())

	if arg_72_1.stopTime > 0 then
		table = var_2

		var_2.insert(arg_72_0.stopList, {
			arg_72_1.stopTime,
			arg_72_1.id
		})

		table = var_2

		local var_72_1 = var_2.sort
		local var_72_2 = arg_72_0.stopList

		CompareFuncs = var_5

		var_72_1(var_72_2, var_5({
			function(arg_73_0)
				return arg_73_0[1]
			end
		}))
	end

	return
end

function var_0_1.deleteActivityById(arg_74_0, arg_74_1)
	assert = var_1_10002

	var_1_10002(arg_74_0.data[arg_74_1], "activity should exist" .. arg_74_1)

	arg_74_0.data[arg_74_1] = nil

	arg_74_0:sendNotification(var_0_1.ACTIVITY_DELETED, arg_74_1)

	table = var_2

	if var_2.getIndex(arg_74_0.stopList, function(arg_75_0)
		return arg_75_0[2] == arg_74_1
	end) then
		table = var_3

		var_3.remove(arg_74_0.stopList, var_2)
	end

	return
end

function var_0_1.IsActivityNotEnd(arg_76_0, arg_76_1)
	local var_76_1

	if arg_76_0.data[arg_76_1] then
		local var_76_0 = arg_76_0.data[arg_76_1]

		var_76_1 = not var_2.isEnd(var_76_0)
	end

	return var_76_1
end

function var_0_1.readyToAchieveByType(arg_77_0, arg_77_1)
	local var_77_0 = false
	local var_77_1 = arg_77_0:getActivitiesByType(arg_77_1)

	ipairs = var_1_10004

	for iter_77_0, iter_77_1 in var_1_10004(var_77_1) do
		if iter_77_1:readyToAchieve() then
			var_77_0 = true

			break
		end
	end

	return var_77_0
end

function var_0_1.getBuildActivityCfgByID(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_0
	local var_78_1 = arg_78_0.getActivitiesByTypes
	local var_78_2 = {}

	ActivityConst = var_1_10006
	var_78_2[1] = var_1_10006.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_6
	var_78_2[2] = var_6.ACTIVITY_TYPE_NEWSERVER_BUILD

	local var_78_3 = var_78_1(var_78_0, var_78_2)

	ipairs = var_1_10003

	for iter_78_0, iter_78_1 in var_1_10003(var_78_3) do
		if not iter_78_1:isEnd() and iter_78_1:getConfig("config_client") and var_8.id == arg_78_1 then
			return var_8
		end
	end

	return nil
end

function var_0_1.getNoneActBuildActivityCfgByID(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.getActivitiesByTypes
	local var_79_2 = {}

	ActivityConst = var_1_10006
	var_79_2[1] = var_1_10006.ACTIVITY_TYPE_BUILD

	local var_79_3 = var_79_1(var_79_0, var_79_2)

	ipairs = var_1_10003

	for iter_79_0, iter_79_1 in var_1_10003(var_79_3) do
		if not iter_79_1:isEnd() and iter_79_1:getConfig("config_client") and var_8.id == arg_79_1 then
			return var_8
		end
	end

	return nil
end

function var_0_1.getBuffShipList(arg_80_0)
	local var_80_0 = {}
	local var_80_1 = arg_80_0
	local var_80_2 = arg_80_0.getActivitiesByType

	ActivityConst = var_1_10005

	local var_80_3 = var_80_2(var_80_1, var_1_10005.ACTIVITY_TYPE_SHIP_BUFF)

	_ = var_1_10003

	var_1_10003.each(var_80_3, function(arg_81_0)
		if arg_81_0 and not arg_81_0:isEnd() then
			local var_81_0 = arg_81_0:getConfig("config_id")

			pg = var_2_10002

			if not var_2_10002.activity_expup_ship[var_81_0] then
				return
			end

			local var_81_1 = var_2.expup

			pairs = var_4

			for iter_81_0, iter_81_1 in var_4(var_81_1) do
				var_80_0[iter_81_1[1]] = iter_81_1[2]
			end
		end

		return
	end)

	return var_80_0
end

function var_0_1.getVirtualItemNumber(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0
	local var_82_1 = arg_82_0.getActivityByType

	ActivityConst = var_1_10005

	if var_82_1(var_82_0, var_1_10005.ACTIVITY_TYPE_VIRTUAL_BAG) and not var_2:isEnd() then
		local var_82_2

		if not var_2.data1KeyValueList[1][arg_82_1] or not var_2.data1KeyValueList[1][arg_82_1] then
			var_82_2 = 0
		end

		return var_82_2
	end

	return 0
end

function var_0_1.removeVitemById(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = arg_83_0
	local var_83_1 = arg_83_0.getActivityByType

	ActivityConst = var_1_10006

	local var_83_2 = var_83_1(var_83_0, var_1_10006.ACTIVITY_TYPE_VIRTUAL_BAG)

	assert = var_1_10004

	var_1_10004(var_83_2, "vbagType invalid")

	if var_83_2 and not var_83_2:isEnd() then
		var_83_2.data1KeyValueList[1][arg_83_1] = var_83_2.data1KeyValueList[1][arg_83_1] - arg_83_2
	end

	arg_83_0:updateActivity(var_83_2)

	return
end

function var_0_1.addVitemById(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_0
	local var_84_1 = arg_84_0.getActivityByType

	ActivityConst = var_1_10006

	local var_84_3

	if not var_84_1(var_84_0, var_1_10006.ACTIVITY_TYPE_VIRTUAL_BAG) then
		local var_84_2 = arg_84_0

		var_1_10004 = arg_84_0.getActivityByType
		ActivityConst = var_1_10007
		var_84_3 = var_1_10004(var_84_2, var_1_10007.ACTIVITY_TYPE_HOLIDAY_VILLA)
	end

	if not var_84_3 then
		local var_84_4 = arg_84_0

		var_1_10004 = arg_84_0.getActivityByType
		ActivityConst = var_1_10007
		var_84_3 = var_1_10004(var_84_4, var_1_10007.ACTIVITY_TYPE_CITY_REBUILD)
	end

	assert = var_1_10004

	var_1_10004(var_84_3, "vbagType invalid")

	if var_84_3 and not var_84_3:isEnd() then
		if not var_84_3.data1KeyValueList[1][arg_84_1] then
			var_84_3.data1KeyValueList[1][arg_84_1] = 0
		end

		var_84_3.data1KeyValueList[1][arg_84_1] = var_84_3.data1KeyValueList[1][arg_84_1] + arg_84_2
	end

	arg_84_0:updateActivity(var_84_3)

	Item = var_4

	if var_4.getConfigData(arg_84_1).link_id ~= 0 and arg_84_0:getActivityById(var_4) and not var_5:isEnd() then
		PlayerResChangeCommand = var_6

		var_6.UpdateActivity(var_5, arg_84_2)
	end

	return
end

function var_0_1.monitorTaskList(arg_85_0, arg_85_1)
	if arg_85_1 and not arg_85_1:isEnd() then
		local var_85_0 = arg_85_1:getConfig("type")

		ActivityConst = var_1_10003

		if var_85_0 == var_1_10003.ACTIVITY_TYPE_TASK_LIST_MONITOR then
			local var_85_1

			if not arg_85_1:getConfig("config_data")[1] then
				var_85_1 = {}
			end

			getProxy = var_3
			TaskProxy = var_5

			local var_85_2 = var_3(var_5)

			if var_3.isReceiveTasks(var_85_2, var_85_1) then
				local var_85_3 = arg_85_0
				local var_85_4 = arg_85_0.sendNotification

				GAME = var_6

				var_85_4(var_85_3, var_6.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = arg_85_1.id
				})
			end
		end
	end

	return
end

function var_0_1.CheckCreateActivityFleet(arg_86_0, arg_86_1, arg_86_2)
	switch = var_1_10003

	local var_86_0 = arg_86_1
	local var_86_1 = arg_86_1.getConfig(var_86_0, "type")
	local var_86_2 = {}

	ActivityConst = var_86_0
	var_86_2[var_86_0.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
		local var_87_0 = arg_86_1

		if var_0.checkBattleTimeInBossAct(var_87_0) then
			local var_87_1 = arg_86_0

			var_0.InitActtivityFleet(var_87_1, arg_86_1, arg_86_2)
		end

		local var_87_2 = arg_86_0

		var_0.InitActivityBossData(var_87_2, arg_86_1)

		return
	end
	ActivityConst = var_7
	var_86_2[var_7.ACTIVITY_TYPE_CHALLENGE] = function()
		local var_88_0 = arg_86_0

		var_0.InitActtivityFleet(var_88_0, arg_86_1, arg_86_2)

		return
	end
	ActivityConst = var_7

	local var_86_3 = var_7.ACTIVITY_TYPE_BOSSRUSH

	ActivityConst = var_8
	var_86_2[var_86_3] = var_8.ACTIVITY_TYPE_CHALLENGE
	ActivityConst = var_86_3

	local var_86_4 = var_86_3.ACTIVITY_TYPE_BOSSSINGLE

	ActivityConst = var_8
	var_86_2[var_86_4] = var_8.ACTIVITY_TYPE_CHALLENGE
	ActivityConst = var_86_4

	local var_86_5 = var_86_4.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE

	ActivityConst = var_8
	var_86_2[var_86_5] = var_8.ACTIVITY_TYPE_CHALLENGE
	ActivityConst = var_86_5

	local var_86_6 = var_86_5.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB

	ActivityConst = var_8
	var_86_2[var_86_6] = var_8.ACTIVITY_TYPE_CHALLENGE

	var_1_10003(var_86_1, var_86_2)

	return
end

function var_0_1.InitActtivityFleet(arg_89_0, arg_89_1, arg_89_2)
	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_89_0 = var_1_10003(var_1_10005)

	var_3.addActivityFleet(var_89_0, arg_89_1, arg_89_2.group_list)

	return
end

function var_0_1.InitActivityBossData(arg_90_0, arg_90_1)
	pg = var_1_10002

	if not var_1_10002.activity_event_worldboss[arg_90_1:getConfig("config_id")] then
		return
	end

	local var_90_0 = arg_90_1.data1KeyValueList

	pairs = var_1_10004

	local var_90_1

	if not var_2.normal_expedition_drop_num then
		var_90_1 = {}
	end

	for iter_90_0, iter_90_1 in var_1_10004(var_90_1) do
		pairs = var_1_10009

		for iter_90_2, iter_90_3 in var_1_10009(iter_90_1[1]) do
			local var_90_2 = iter_90_1[2]
			local var_90_3

			if not var_90_0[1][iter_90_3] then
				var_90_3 = 0
			end

			local var_90_4 = var_90_0[1]

			math = var_1_10017
			var_90_4[iter_90_3] = var_1_10017.max(var_90_2 - var_90_3, 0)

			local var_90_5 = var_90_0[2]

			if not var_90_0[2][iter_90_3] then
				var_1_10017 = 0
			end

			var_90_5[iter_90_3] = var_1_10017
		end
	end

	return
end

function var_0_1.RegisterRequestTime(arg_91_0, arg_91_1, arg_91_2)
	if not arg_91_1 or arg_91_1 <= 0 then
		return
	end

	arg_91_0.requestTime[arg_91_1] = arg_91_2

	return
end

function var_0_1.addActivityParameter(arg_92_0, arg_92_1)
	local var_92_0 = arg_92_1
	local var_92_1 = arg_92_1.getConfig(var_92_0, "config_data")
	local var_92_2 = arg_92_1.stopTime

	ipairs = var_92_0

	for iter_92_0, iter_92_1 in var_92_0(var_92_1) do
		arg_92_0.params[iter_92_1[1]] = {
			iter_92_1[2],
			var_92_2
		}
	end

	return
end

function var_0_1.getActivityParameter(arg_93_0, arg_93_1)
	if arg_93_0.params[arg_93_1] then
		unpack = var_2

		local var_93_0, var_93_1 = var_2(arg_93_0.params[arg_93_1])

		if 0 < var_93_1 then
			pg = var_4

			local var_93_2 = var_4.TimeMgr.GetInstance()

			if not (var_93_1 <= var_4.GetServerTime(var_93_2)) then
				return var_93_0
			end

			return
		end
	end
end

function var_0_1.IsShowFreeBuildMark(arg_94_0, arg_94_1)
	ipairs = var_1_10002

	local var_94_0 = arg_94_0
	local var_94_1 = arg_94_0.getActivitiesByType

	ActivityConst = var_1_10007

	for iter_94_0, iter_94_1 in var_1_10002(var_94_1(var_94_0, var_1_10007.ACTIVITY_TYPE_BUILD_FREE)) do
		if iter_94_1 and not iter_94_1:isEnd() then
			local var_94_2 = iter_94_1.data1

			if 0 < var_94_2 then
				local var_94_3 = iter_94_1.stopTime

				pg = var_8

				local var_94_4 = var_8.TimeMgr.GetInstance()

				if var_94_3 - var_8.GetServerTime(var_94_4) < 0 then
					tobool = var_7

					local var_94_5 = var_7(arg_94_1)

					PlayerPrefs = var_8

					local var_94_6 = var_8.GetString("Free_Build_Ticket_" .. iter_94_1.id, "")

					pg = var_9

					local var_94_7 = var_9.TimeMgr.GetInstance()

					if var_94_5 == (var_94_6 == var_9.CurrentSTimeDesc(var_94_7, "%Y/%m/%d")) then
						return iter_94_1
					end
				end
			end
		end
	end

	return false
end

function var_0_1.getBuildFreeActivityByBuildId(arg_95_0, arg_95_1)
	ipairs = var_1_10002

	local var_95_0 = arg_95_0
	local var_95_1 = arg_95_0.getActivitiesByType

	ActivityConst = var_1_10007

	for iter_95_0, iter_95_1 in var_1_10002(var_95_1(var_95_0, var_1_10007.ACTIVITY_TYPE_BUILD_FREE)) do
		underscore = var_7

		if var_7.any(iter_95_1:getConfig("config_data"), function(arg_96_0)
			return arg_96_0 == arg_95_1
		end) then
			return iter_95_1
		end
	end

	return
end

function var_0_1.getBuildPoolActivity(arg_97_0, arg_97_1)
	if arg_97_1:IsActivity() then
		return arg_97_0:getActivityById(arg_97_1.activityId)
	end

	return
end

function var_0_1.getEnterReadyActivity(arg_98_0)
	local var_98_0 = {}

	ActivityConst = var_1_10002
	var_98_0[var_1_10002.ACTIVITY_TYPE_ZPROJECT] = function(arg_99_0)
		return true
	end
	ActivityConst = var_2
	var_98_0[var_2.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function(arg_100_0)
		return arg_100_0:checkBattleTimeInBossAct()
	end
	ActivityConst = var_2
	var_98_0[var_2.ACTIVITY_TYPE_BOSSRUSH] = function(arg_101_0)
		return true
	end
	ActivityConst = var_2
	var_98_0[var_2.ACTIVITY_TYPE_BOSSSINGLE] = function(arg_102_0)
		return true
	end
	ActivityConst = var_2
	var_98_0[var_2.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function(arg_103_0)
		return true
	end
	ActivityConst = var_2
	var_98_0[var_2.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = function(arg_104_0)
		return true
	end

	local var_98_1 = {}

	pairs = var_3

	for iter_98_0, iter_98_1 in var_3(arg_98_0.data) do
		switch = var_1_10008

		if var_1_10008(iter_98_1:getConfig("type"), var_98_0, function(arg_105_0)
			return false
		end, iter_98_1) and not iter_98_1:isEnd() then
			tobool = var_1_10008

			if var_1_10008(iter_98_1:getConfig("config_client").entrance_bg) then
				table = var_1_10008

				var_1_10008.insert(var_98_1, iter_98_1)
			end
		end
	end

	table = var_3

	local var_98_2 = var_3.sort
	local var_98_3 = var_98_1

	CompareFuncs = iter_98_0

	var_98_2(var_98_3, iter_98_0({
		function(arg_106_0)
			local var_106_0

			if not arg_106_0:getConfig("config_client").order then
				var_106_0 = 1
			end

			return var_106_0
		end,
		function(arg_107_0)
			return -arg_107_0.id
		end
	}))

	return var_98_1
end

function var_0_1.AtelierActivityAllSlotIsEmpty(arg_108_0)
	local var_108_0 = arg_108_0
	local var_108_1 = arg_108_0.getActivityByType

	ActivityConst = var_1_10004

	if not var_108_1(var_108_0, var_1_10004.ACTIVITY_TYPE_ATELIER_LINK) or var_1:isEnd() then
		return false
	end

	local var_108_2 = var_1:GetSlots()

	pairs = var_108_0

	for iter_108_0, iter_108_1 in var_108_0(var_108_2) do
		if iter_108_1[1] ~= 0 then
			return false
		end
	end

	return true
end

function var_0_1.OwnAtelierActivityItemCnt(arg_109_0, arg_109_1, arg_109_2)
	local var_109_0 = arg_109_0
	local var_109_1 = arg_109_0.getActivityByType

	ActivityConst = var_1_10006

	if not var_109_1(var_109_0, var_1_10006.ACTIVITY_TYPE_ATELIER_LINK) or var_3:isEnd() then
		return false
	end

	return var_3:GetItems()[arg_109_1] and arg_109_2 <= var_5.count
end

function var_0_1.InitContinuousTime(arg_110_0, arg_110_1)
	arg_110_0.continuousOpeartionTime = arg_110_1
	arg_110_0.continuousOpeartionTotalTime = arg_110_1

	return
end

function var_0_1.UseContinuousTime(arg_111_0)
	if not arg_111_0.continuousOpeartionTime then
		return
	end

	arg_111_0.continuousOpeartionTime = arg_111_0.continuousOpeartionTime - 1

	return
end

function var_0_1.GetContinuousTime(arg_112_0)
	return arg_112_0.continuousOpeartionTime, arg_112_0.continuousOpeartionTotalTime
end

function var_0_1.AddBossRushAwards(arg_113_0, arg_113_1)
	local var_113_0

	if not arg_113_0.bossrushAwards then
		var_113_0 = {}
	end

	arg_113_0.bossrushAwards = var_113_0
	table = var_113_0

	var_113_0.insertto(arg_113_0.bossrushAwards, arg_113_1)

	return
end

function var_0_1.PopBossRushAwards(arg_114_0)
	local var_114_0

	if not arg_114_0.bossrushAwards then
		var_114_0 = {}
	end

	arg_114_0.bossrushAwards = nil

	return var_114_0
end

function var_0_1.GetBossRushRuntime(arg_115_0, arg_115_1)
	if not arg_115_0.extraDatas[arg_115_1] then
		arg_115_0.extraDatas[arg_115_1] = {
			record = 0,
			diff = 1
		}
	end

	return arg_115_0.extraDatas[arg_115_1]
end

function var_0_1.GetActivityBossRuntime(arg_116_0, arg_116_1)
	if not arg_116_0.extraDatas[arg_116_1] then
		arg_116_0.extraDatas[arg_116_1] = {
			buffIds = {},
			spScore = {
				score = 0
			}
		}
	end

	return arg_116_0.extraDatas[arg_116_1]
end

function var_0_1.GetTaskActivities(arg_117_0)
	local var_117_0 = {}

	table = var_1_10002

	local var_117_1 = var_1_10002.Foreach

	Activity = var_1_10004

	var_117_1(var_1_10004.GetType2Class(), function(arg_118_0, arg_118_1)
		isa = var_2_10002

		local var_118_0 = arg_118_1

		ITaskActivity = var_2_10005

		if not var_2_10002(var_118_0, var_2_10005) then
			return
		end

		table = var_2

		local var_118_1 = var_2.insertto
		local var_118_2 = var_117_0
		local var_118_3 = arg_117_0

		var_118_1(var_118_2, var_5.getActivitiesByType(var_118_3, arg_118_0))

		return
	end)

	return var_117_0
end

function var_0_1.setSurveyState(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0
	local var_119_1 = arg_119_0.getActivityByType

	ActivityConst = var_1_10005

	if var_119_1(var_119_0, var_1_10005.ACTIVITY_TYPE_SURVEY) and not var_2:isEnd() then
		arg_119_0.surveyState = arg_119_1

		if arg_119_1 > 0 then
			local var_119_2 = arg_119_0
			local var_119_3 = arg_119_0.sendNotification

			GAME = var_1_10006

			var_119_3(var_119_2, var_1_10006.SURVEY_DONE, var_2)
		end
	end

	return
end

function var_0_1.isSurveyDone(arg_120_0)
	local var_120_0 = arg_120_0
	local var_120_1 = arg_120_0.getActivityByType

	ActivityConst = var_1_10004

	if var_120_1(var_120_0, var_1_10004.ACTIVITY_TYPE_SURVEY) and not var_1:isEnd() then
		local var_120_2

		if arg_120_0.surveyState then
			var_120_2 = arg_120_0.surveyState > 0
		end

		return var_120_2
	end

	return
end

function var_0_1.isSurveyOpen(arg_121_0)
	local var_121_0 = arg_121_0
	local var_121_1 = arg_121_0.getActivityByType

	ActivityConst = var_1_10004

	if var_121_1(var_121_0, var_1_10004.ACTIVITY_TYPE_SURVEY) and not var_1:isEnd() then
		local var_121_2 = var_1:getConfig("config_data")[1]
		local var_121_3 = var_2[2]

		if var_121_2 == 1 then
			getProxy = var_5
			PlayerProxy = var_1_10007

			local var_121_4 = var_5(var_1_10007)
			local var_121_5 = var_121_3 <= var_5.getData(var_121_4).level
			local var_121_6 = var_1:getConfig("config_id")

			return var_121_5, var_121_6
		end
	end

	return
end

function var_0_1.GetActBossLinkPTActID(arg_122_0, arg_122_1)
	table = var_1_10002

	return var_1_10002.Find(arg_122_0.data, function(arg_123_0, arg_123_1)
		local var_123_0 = arg_123_1:getConfig("type")

		ActivityConst = var_2_10003

		if var_123_0 ~= var_2_10003.ACTIVITY_TYPE_PT_BUFF then
			return
		end

		return arg_123_1:getDataConfig("link_id") == arg_122_1
	end) and var_2.id
end

function var_0_1.CheckDailyEventRequest(arg_124_0, arg_124_1)
	if arg_124_1:CheckDailyEventRequest() then
		local var_124_0 = arg_124_0
		local var_124_1 = arg_124_0.sendNotification

		GAME = var_1_10005

		var_124_1(var_124_0, var_1_10005.SINGLE_EVENT_REFRESH, {
			actId = arg_124_1.id
		})
	end

	return
end

function var_0_1.IsTipLoveLetterMail(arg_125_0)
	local var_125_0 = arg_125_0
	local var_125_1 = arg_125_0.getActivityByType

	ActivityConst = var_1_10004

	return var_125_1(var_125_0, var_1_10004.ACTIVITY_TYPE_LOVE_LETTER_MAIL) and not var_1:isEnd() and var_1:readyToAchieve()
end

function var_0_1.GetBossRushActivities(arg_126_0, arg_126_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_126_0 = var_1_10002(var_1_10004)
	local var_126_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10005

	local var_126_2 = var_126_1(var_126_0, var_1_10005.ACTIVITY_TYPE_BOSSRUSH)

	_ = var_1_10003

	return var_1_10003.select(var_126_2, function(arg_127_0)
		pg = var_2_10001

		local var_127_0 = var_2_10001.activity_task_permanent[arg_127_0.id] ~= nil

		if arg_126_1 then
			return var_127_0 and not arg_127_0:isEnd()
		else
			return not var_127_0 and not arg_127_0:isEnd()
		end

		return
	end)
end

function var_0_1.GetBossRushActivitity(arg_128_0, arg_128_1)
	return arg_128_0:GetBossRushActivities(arg_128_1)[1]
end

function var_0_1.GetBossRushActivityById(arg_129_0, arg_129_1)
	local var_129_0 = arg_129_0

	if arg_129_0.getActivityById(var_129_0, arg_129_1) then
		local var_129_1 = var_2:getConfig("type")

		ActivityConst = var_129_0

		if var_129_1 == var_129_0.ACTIVITY_TYPE_BOSSRUSH and not var_2:isEnd() then
			return var_2
		end
	end

	return nil
end

function var_0_1.GetBossActivityByChapterId(arg_130_0, arg_130_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_130_0 = var_1_10002(var_1_10004)
	local var_130_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10005

	local var_130_2 = var_130_1(var_130_0, var_1_10005.ACTIVITY_TYPE_BOSSRUSH)

	ipairs = var_1_10003

	for iter_130_0, iter_130_1 in var_1_10003(var_130_2) do
		if not iter_130_1:isEnd() then
			local var_130_3 = iter_130_1:getConfig("config_data")

			table = var_1_10009

			if var_1_10009.contains(var_130_3, arg_130_1) then
				return iter_130_1
			end
		end
	end

	return nil
end

function var_0_1.GetFakeGiftPackActivity(arg_131_0, arg_131_1)
	ipairs = var_1_10002

	local var_131_0 = arg_131_0
	local var_131_1 = arg_131_0.getActivitiesByTypes
	local var_131_2 = {}

	ActivityConst = var_1_10008
	var_131_2[1] = var_1_10008.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE
	ActivityConst = var_8
	var_131_2[2] = var_8.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE

	for iter_131_0, iter_131_1 in var_1_10002(var_131_1(var_131_0, var_131_2)) do
		switch = var_131_2

		local var_131_3 = iter_131_1
		local var_131_4 = iter_131_1.getConfig(var_131_3, "type")
		local var_131_5 = {}

		ActivityConst = var_131_3
		var_131_5[var_131_3.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
			local var_132_0 = iter_131_1
			local var_132_3

			if not var_0.isEnd(var_132_0) and iter_131_1.data1 < 1 then
				underscore = var_0

				local var_132_1 = var_0.any
				local var_132_2 = iter_131_1

				var_132_3 = var_132_1(var_2.getConfig(var_132_2, "config_data")[1], function(arg_133_0)
					pg = var_3_10001

					return var_3_10001.ship_skin_template[arg_133_0].shop_id == arg_131_1.id
				end)
			else
				var_132_3 = false
			end

			if false then
				var_132_3 = true
			end

			return var_132_3
		end
		ActivityConst = var_11
		var_131_5[var_11.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
			pg = var_2_10000

			local var_134_0 = var_2_10000.activity_giftpackage
			local var_134_1 = iter_131_1
			local var_134_2 = var_134_0[var_1.getConfig(var_134_1, "config_id")]
			local var_134_3 = iter_131_1
			local var_134_4

			if not var_1.isEnd(var_134_3) and iter_131_1.data1 < var_134_2.limit_count then
				underscore = var_134_4

				if var_134_4.any(var_134_2.skin, function(arg_135_0)
					pg = var_3_10001

					return var_3_10001.ship_skin_template[arg_135_0].shop_id == arg_131_1.id
				end) then
					underscore = var_134_4
					var_134_4 = not var_134_4.all(var_134_2.skin, function(arg_136_0)
						getProxy = var_3_10001
						ShipSkinProxy = var_3_10003

						local var_136_0 = var_3_10001(var_3_10003)

						return var_1.hasNonLimitSkin(var_136_0, arg_136_0)
					end)
				end
			else
				var_134_4 = false
			end

			if false then
				var_134_4 = true
			end

			return var_134_4
		end

		if var_131_2(var_131_4, var_131_5, function()
			return
		end) then
			return iter_131_1
		end
	end

	return
end

return var_0_1
