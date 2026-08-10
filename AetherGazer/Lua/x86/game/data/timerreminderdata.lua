local var_0_0 = singletonClass("TimerReminderData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.SetReminder(arg_2_0, arg_2_1)
	if not var_0_1[arg_2_1] then
		var_0_1[arg_2_1] = {
			num = 0,
			sureNum = 0,
			id = arg_2_1
		}
	end

	if arg_2_1 == TimerReminderConst.FATIGUE then
		local var_2_0 = PlayerData:GetPlayerInfo().userLevel
		local var_2_1 = GameLevelSetting[var_2_0].fatigue_max
		local var_2_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		local var_2_3
		local var_2_4

		if var_2_1 <= var_2_2 then
			var_2_4 = 0
		else
			local var_2_5 = GameSetting.fatigue_recovery.value[1] * 60
			local var_2_6 = CurrencyData:GetLastFatigueRecoverTime() == 0 and var_2_5 or var_2_5 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_2_5

			var_2_4 = (var_2_1 - var_2_2 - 1) * var_2_5 + var_2_6 + 28800
		end

		local var_2_7 = manager.time:GetServerTime() + var_2_4
		local var_2_8 = manager.time:DescCTime(var_2_7, "!%Y %m %d %H %M %S")
		local var_2_9 = string.split(var_2_8, " ")
		local var_2_10 = tonumber(var_2_9[4])

		if var_2_10 >= 0 and var_2_10 < 8 then
			local var_2_11 = {
				hour = 8,
				min = 0,
				sec = 0,
				year = tonumber(var_2_9[1]),
				month = tonumber(var_2_9[2]),
				day = tonumber(var_2_9[3])
			}

			var_2_7 = manager.time:Table2ServerTime(var_2_11)
		end

		if var_0_1[arg_2_1].nextReminderTime == nil then
			var_0_1[arg_2_1].nextReminderTime = var_2_7
		else
			if var_0_1[arg_2_1].nextReminderTime and var_0_1[arg_2_1].nextReminderTime == var_2_7 then
				return
			end

			if manager.time:GetServerTime() >= var_0_1[arg_2_1].nextReminderTime then
				var_0_1[arg_2_1].lastReminderTime = var_0_1[arg_2_1].nextReminderTime
			end

			if var_0_1[arg_2_1].lastReminderTime and var_2_7 <= var_0_1[arg_2_1].lastReminderTime + GameSetting.push_notification_fatigue_cooldown.value[1] * 60 then
				arg_2_0:CancelReminder(arg_2_1)

				return
			end

			var_0_1[arg_2_1].nextReminderTime = var_2_7
		end

		local var_2_12 = PushNotificationCfg.get_id_list_by_type[arg_2_1]
		local var_2_13 = math.round(math.random(#var_2_12))
		local var_2_14 = PushNotificationCfg[var_2_12[var_2_13]]

		if var_2_4 * 1000 >= 1000 then
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_2_1, GetI18NText(var_2_14.title), GetI18NText(var_2_14.content), var_2_4 * 1000))
		end
	elseif arg_2_1 == TimerReminderConst.DAILYFATIGUE then
		arg_2_0:DailyFatigueReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CAT_EXPLORE then
		arg_2_0:CatExploreReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CANTEEN_DISPATCH then
		arg_2_0:CanteenDispatchReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CANTEEN_FULL then
		arg_2_0:CanteenFullReminder(arg_2_1)
	else
		print("未设置此推送类型", arg_2_1)
	end
end

function var_0_0.CalHeroWorkTime(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = CanteenData:GetPopularityNum()
	local var_3_1 = GameSetting.canteen_popular_cost_time.value
	local var_3_2 = var_3_1[#var_3_1][2]

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if var_3_0 < iter_3_1[1] then
			local var_3_3 = iter_3_1[2]
		end
	end

	local var_3_4 = GameSetting.dorm_canteen_fatigue_cost.value[1] / 100
	local var_3_5 = DormSkillData:CheckSkillCanOpen(arg_3_1, arg_3_2)
	local var_3_6 = 0

	for iter_3_2, iter_3_3 in ipairs(var_3_5) do
		if BackHomeHeroSkillCfg[iter_3_3].type == CanteenConst.HeroSkillType.FatigueRecuse then
			var_3_6 = var_3_6 + BackHomeHeroSkillCfg[iter_3_3].param[1]
		end
	end

	return var_3_4 * (100 - var_3_6) / 100
end

local var_0_2 = 9999999999
local var_0_3 = 0

function var_0_0.traceback(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_3 = var_0_3 + 1

	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 9999999999
	local var_4_3 = arg_4_3
	local var_4_4 = arg_4_2

	for iter_4_0, iter_4_1 in pairs(var_4_4) do
		if DormNpcTools:CheckIDIsNpc(iter_4_0) then
			for iter_4_2, iter_4_3 in pairs(var_4_3) do
				var_4_1 = var_4_1 + (CanteenFoodData:GetFoodUnitCost(iter_4_2) or 0) / (CanteenFoodData:CalSignFoodTime(iter_4_2, 1) or 1)
			end

			local var_4_5 = arg_4_1 / var_4_1

			var_0_2 = math.min(var_0_2, var_4_5)
		else
			local var_4_6 = CanteenData:GetPopularityNum() or 0
			local var_4_7 = GameSetting.canteen_popular_cost_time.value
			local var_4_8 = var_4_7[#var_4_7][2]

			for iter_4_4, iter_4_5 in ipairs(var_4_7) do
				if var_4_6 < iter_4_5[1] then
					var_4_8 = iter_4_5[2]

					break
				end
			end

			local var_4_9 = arg_4_0:CalHeroWorkTime(iter_4_0, iter_4_1.heroID) or 1
			local var_4_10 = iter_4_1.curFatigue / var_4_9 * var_4_8

			var_4_2 = math.min(var_4_10, var_4_2)
			iter_4_1.curFatigue = iter_4_1.curFatigue - var_4_9
		end
	end

	for iter_4_6, iter_4_7 in pairs(var_4_3) do
		local var_4_11 = iter_4_7.sellNum - iter_4_7.soldNum
		local var_4_12 = CanteenFoodData:GetFoodUnitCost(iter_4_6) or 0
		local var_4_13 = CanteenFoodData:CalSignFoodTime(iter_4_6, var_4_11) or 1

		if var_4_13 <= 0 or var_4_11 <= 0 then
			break
		end

		local var_4_14 = var_4_2 / (var_4_13 / var_4_11)
		local var_4_15 = 0
		local var_4_16
		local var_4_17 = var_4_12 / (var_4_13 / var_4_11)

		var_4_1 = var_4_1 + var_4_17

		if var_4_14 <= var_4_11 then
			var_4_15 = var_4_17 * var_4_2
			iter_4_7.soldNum = iter_4_7.soldNum + var_4_14
		else
			var_4_15 = var_4_11 * var_4_12
			iter_4_7.soldNum = iter_4_7.soldNum + var_4_11
		end

		var_4_0 = var_4_0 + var_4_15
	end

	if var_4_0 < arg_4_1 and var_0_3 <= 10 then
		if var_0_2 == 9999999999 then
			var_0_2 = 0
		end

		var_0_2 = var_0_2 + var_4_2

		arg_4_0:traceback(arg_4_1 - var_4_0, var_4_4, var_4_3)
	else
		local var_4_18 = arg_4_1 / var_4_1

		if var_0_2 == 9999999999 then
			var_0_2 = 0
		end

		var_0_2 = var_0_2 + var_4_18

		local var_4_19 = 9999999999

		var_0_3 = 0
	end
end

function var_0_0.CanteenFullReminder(arg_5_0, arg_5_1)
	local var_5_0

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		if CanteenTools:CheckSignFoodNumCanOpen() and CanteenTools:CheckCanteenJobCanOpen() then
			local var_5_1 = CanteenFoodData:GetChooseFoodList()
			local var_5_2 = 0
			local var_5_3 = {}

			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				local var_5_4 = CanteenFoodData:GetSignFoodInfo(iter_5_1)

				var_5_2 = var_5_2 + (var_5_4.sellNum - var_5_4.soldNum or 0) * (CanteenFoodData:GetFoodUnitCost(iter_5_1) or 0)
				var_5_3[iter_5_1] = {
					sellNum = var_5_4.sellNum,
					soldNum = var_5_4.soldNum
				}
			end

			local var_5_5 = CanteenData:GetAutoAwardNum() or 0
			local var_5_6 = DormSkillData:GetInComeStorageMax() or 0
			local var_5_7 = var_5_6 - var_5_5
			local var_5_8 = CanteenHeroTools:GetCanteenJobList()
			local var_5_9 = {}

			for iter_5_2, iter_5_3 in pairs(var_5_8) do
				local var_5_10 = DormData:GetCharacterInfo(iter_5_3.heroID)

				if not DormNpcTools:CheckIDIsNpc(iter_5_3.heroID) then
					local var_5_11 = var_5_10:GetFatigue() or 0

					var_5_9[iter_5_3.heroID] = {
						curFatigue = var_5_11,
						jobType = CanteenHeroTools:GetJobTypeByHeroID(iter_5_3.heroID),
						heroID = iter_5_3.heroID
					}
				end
			end

			if var_5_2 < var_5_6 - var_5_5 then
				return
			else
				arg_5_0:traceback(var_5_7, var_5_9, var_5_3)
			end

			local var_5_12 = 0
		else
			return
		end
	else
		return
	end

	local var_5_13
	local var_5_14 = math.ceil(var_0_2) or 0

	var_0_2 = 9999999999

	local var_5_15 = manager.time:GetServerTime() + var_5_14 + 28800 or 0

	if var_5_15 <= manager.time:GetServerTime() + 28800 then
		var_5_15 = manager.time:GetServerTime() + 7200 + 28800
		var_5_13 = true
		var_0_1[arg_5_1].sureNum = var_0_1[arg_5_1].num
	end

	local var_5_16 = manager.time:DescCTime(var_5_15, "!%Y %m %d %H %M %S")
	local var_5_17 = string.split(var_5_16, " ")
	local var_5_18 = tonumber(var_5_17[4])
	local var_5_19 = math.floor(var_5_14 / 86400)

	if arg_5_0:KrNotPush() then
		if var_5_18 > 20 or var_5_18 < 7 then
			local var_5_20 = {
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_5_17[1]),
				month = tonumber(var_5_17[2]),
				day = tonumber(var_5_17[3])
			}

			var_5_15 = manager.time:Table2ServerTime(var_5_20)
			var_5_14 = var_5_15
			var_0_1[arg_5_1].num = 0
			var_0_1[arg_5_1].nextReminderTime = nil
			var_0_1[arg_5_1].lastReminderTime = nil
		end
	elseif var_5_18 >= 0 and var_5_18 < 8 then
		local var_5_21 = {
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_5_17[1]),
			month = tonumber(var_5_17[2]),
			day = tonumber(var_5_17[3])
		}

		var_5_15 = manager.time:Table2ServerTime(var_5_21)
		var_5_14 = var_5_15
		var_0_1[arg_5_1].num = 0
		var_0_1[arg_5_1].nextReminderTime = nil
		var_0_1[arg_5_1].lastReminderTime = nil
	end

	if not var_0_1[arg_5_1].nextReminderTime then
		var_0_1[arg_5_1].nextReminderTime = var_5_15
	else
		if var_0_1[arg_5_1].nextReminderTime and var_0_1[arg_5_1].nextReminderTime == var_5_15 then
			return
		end

		if manager.time:GetServerTime() + 28800 >= var_0_1[arg_5_1].nextReminderTime then
			var_0_1[arg_5_1].lastReminderTime = var_0_1[arg_5_1].nextReminderTime
		end

		if var_0_1[arg_5_1].lastReminderTime and var_5_15 <= var_0_1[arg_5_1].lastReminderTime + GameSetting.push_notification_canteenfull_cooldown.value[1] * 60 then
			return
		end

		var_0_1[arg_5_1].nextReminderTime = var_5_15
	end

	local var_5_22 = PushNotificationCfg.get_id_list_by_type[arg_5_1][1]
	local var_5_23 = PushNotificationCfg[var_5_22]

	if var_5_14 % 86400 == 0 then
		if var_5_14 == 0 then
			var_5_14 = 7200
		else
			var_5_14 = 86400 - manager.time:GetServerTime() % 86400 + var_5_19 * 86400
		end
	elseif var_5_13 then
		var_5_14 = 7200

		local var_5_24 = false
	end

	print("餐厅收益上限推送", arg_5_1, var_5_23.title, var_5_23.content, var_5_14 * 1000)

	if var_5_14 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_5_1, GetI18NText(var_5_23.title), GetI18NText(var_5_23.content), var_5_14 * 1000))

		var_0_1[arg_5_1].num = var_0_1[arg_5_1].num + 1
	end
end

function var_0_0.CanteenDispatchReminder(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = 9999999999

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_6_2 = CanteenEntrustData:GetEntrustList()

		if var_6_2 then
			for iter_6_0, iter_6_1 in pairs(var_6_2) do
				if iter_6_1.start_time and iter_6_1.start_time > 0 then
					local var_6_3 = iter_6_1.start_time + BackHomeCanteenTaskCfg[iter_6_1.id].time[iter_6_1.timeLevel][1] * 60

					var_6_1 = math.min(var_6_3, var_6_1)
				end
			end
		end
	end

	local var_6_4
	local var_6_5 = var_6_1

	if var_6_5 == 9999999999 then
		return
	end

	local var_6_6 = var_6_5 + 28800

	if var_6_6 < manager.time:GetServerTime() + 28800 then
		var_6_6 = manager.time:GetServerTime() + 7200 + 28800
		var_6_4 = true
		var_0_1[arg_6_1].sureNum = var_0_1[arg_6_1].num
	end

	local var_6_7 = manager.time:DescCTime(var_6_6, "!%Y %m %d %H %M %S")
	local var_6_8 = string.split(var_6_7, " ")
	local var_6_9 = tonumber(var_6_8[4])

	if arg_6_0:KrNotPush() then
		if var_6_9 > 20 or var_6_9 < 7 then
			local var_6_10 = {
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_6_8[1]),
				month = tonumber(var_6_8[2]),
				day = tonumber(var_6_8[3])
			}

			var_6_6 = manager.time:Table2ServerTime(var_6_10)
			var_6_5 = var_6_6
			var_0_1[arg_6_1].num = 0
			var_0_1[arg_6_1].nextReminderTime = nil
			var_0_1[arg_6_1].lastReminderTime = nil
		end
	elseif var_6_9 >= 0 and var_6_9 < 8 then
		local var_6_11 = {
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_6_8[1]),
			month = tonumber(var_6_8[2]),
			day = tonumber(var_6_8[3])
		}

		var_6_6 = manager.time:Table2ServerTime(var_6_11)
		var_6_5 = var_6_6
		var_0_1[arg_6_1].num = 0
		var_0_1[arg_6_1].nextReminderTime = nil
		var_0_1[arg_6_1].lastReminderTime = nil
	end

	if var_0_1[arg_6_1].nextReminderTime == nil then
		var_0_1[arg_6_1].nextReminderTime = var_6_6
	else
		if var_0_1[arg_6_1].nextReminderTime and var_0_1[arg_6_1].nextReminderTime == var_6_6 then
			return
		end

		if manager.time:GetServerTime() + 28800 >= var_0_1[arg_6_1].nextReminderTime then
			var_0_1[arg_6_1].lastReminderTime = var_0_1[arg_6_1].nextReminderTime
		end

		local var_6_12 = PushNotificationCfg.get_id_list_by_type[arg_6_1][1]

		if var_0_1[arg_6_1].lastReminderTime and (var_6_6 <= var_0_1[arg_6_1].lastReminderTime + GameSetting.push_notification_canteendispatch_cooldown.value[1] * 60 or var_0_1[arg_6_1].sureNum >= PushNotificationCfg[var_6_12].times) then
			return
		end

		var_0_1[arg_6_1].nextReminderTime = var_6_6
	end

	local var_6_13 = PushNotificationCfg.get_id_list_by_type[arg_6_1][1]
	local var_6_14 = PushNotificationCfg[var_6_13]

	if var_6_5 % 86400 == 0 then
		var_6_5 = 86400 - manager.time:GetServerTime() % 86400
	elseif var_6_4 then
		var_6_5 = 7200

		local var_6_15 = false
	else
		var_6_5 = var_6_5 % 86400 - manager.time:GetServerTime() % 86400
		var_6_5 = math.abs(var_6_5)
	end

	print("餐厅派遣推送", arg_6_1, var_6_14.title, var_6_14.content, var_6_5 * 1000)

	if var_6_5 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_6_1, GetI18NText(var_6_14.title), GetI18NText(var_6_14.content), var_6_5 * 1000))

		var_0_1[arg_6_1].num = var_0_1[arg_6_1].num + 1
	end
end

function var_0_0.CatExploreReminder(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = AdminCatExploreData:GetMinStopTime()

	if var_7_1 == 9999999999 then
		return
	end

	local var_7_2
	local var_7_3 = var_7_1 + 28800

	if var_7_3 < manager.time:GetServerTime() + 28800 then
		var_7_3 = manager.time:GetServerTime() + 7200 + 28800
		var_7_2 = true
		var_0_1[arg_7_1].sureNum = var_0_1[arg_7_1].num
	end

	local var_7_4 = manager.time:DescCTime(var_7_3, "!%Y %m %d %H %M %S")
	local var_7_5 = string.split(var_7_4, " ")
	local var_7_6 = tonumber(var_7_5[4])

	if arg_7_0:KrNotPush() then
		if var_7_6 > 20 or var_7_6 < 7 then
			local var_7_7 = {
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_7_5[1]),
				month = tonumber(var_7_5[2]),
				day = tonumber(var_7_5[3])
			}

			var_7_3 = manager.time:Table2ServerTime(var_7_7)
			var_7_1 = var_7_3
			var_0_1[arg_7_1].num = 0
			var_0_1[arg_7_1].nextReminderTime = nil
			var_0_1[arg_7_1].lastReminderTime = nil
		end
	elseif var_7_6 >= 0 and var_7_6 < 8 then
		local var_7_8 = {
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_7_5[1]),
			month = tonumber(var_7_5[2]),
			day = tonumber(var_7_5[3])
		}

		var_7_3 = manager.time:Table2ServerTime(var_7_8)
		var_7_1 = var_7_3
		var_0_1[arg_7_1].num = 0
		var_0_1[arg_7_1].nextReminderTime = nil
		var_0_1[arg_7_1].lastReminderTime = nil
	end

	if var_0_1[arg_7_1].nextReminderTime == nil then
		var_0_1[arg_7_1].nextReminderTime = var_7_3
	else
		if var_0_1[arg_7_1].nextReminderTime and var_0_1[arg_7_1].nextReminderTime == var_7_3 then
			return
		end

		if manager.time:GetServerTime() + 28800 >= var_0_1[arg_7_1].nextReminderTime then
			var_0_1[arg_7_1].lastReminderTime = var_0_1[arg_7_1].nextReminderTime
		end

		local var_7_9 = PushNotificationCfg.get_id_list_by_type[arg_7_1][1]

		if var_0_1[arg_7_1].lastReminderTime and (var_7_3 <= var_0_1[arg_7_1].lastReminderTime + GameSetting.push_notification_catexplore_cooldown.value[1] * 60 or var_0_1[arg_7_1].sureNum >= PushNotificationCfg[var_7_9].times) then
			return
		end

		var_0_1[arg_7_1].nextReminderTime = var_7_3
	end

	local var_7_10 = PushNotificationCfg.get_id_list_by_type[arg_7_1][1]
	local var_7_11 = PushNotificationCfg[var_7_10]

	if var_7_1 % 86400 == 0 then
		var_7_1 = 86400 - manager.time:GetServerTime() % 86400
	elseif var_7_2 then
		var_7_1 = 7200

		local var_7_12 = false
	else
		var_7_1 = var_7_1 % 86400 - manager.time:GetServerTime() % 86400
		var_7_1 = math.abs(var_7_1)
	end

	print("猫咪探索推送", arg_7_1, var_7_11.title, var_7_11.content, var_7_1 * 1000)

	if var_7_1 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_7_1, GetI18NText(var_7_11.title), GetI18NText(var_7_11.content), var_7_1 * 1000))

		var_0_1[arg_7_1].num = var_0_1[arg_7_1].num + 1
	end
end

function var_0_0.DailyFatigueReminder(arg_8_0, arg_8_1)
	local var_8_0 = PushNotificationCfg.get_id_list_by_type[arg_8_1][1]
	local var_8_1 = PushNotificationCfg[var_8_0]
	local var_8_2 = 43200 - manager.time:GetServerTime() % 86400

	if var_8_2 * 1000 >= 1000 and (DailyFatigueData:GetStatus(11) ~= 3 or DailyFatigueData:GetStatus(18) ~= 3) then
		print("吨吨补给站推送", arg_8_1, var_8_1.title, var_8_1.content, var_8_2 * 1000)
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_8_1, GetI18NText(var_8_1.title), GetI18NText(var_8_1.content), var_8_2 * 1000))
	end
end

function var_0_0.CancelReminder(arg_9_0, arg_9_1)
	if arg_9_1 == nil or var_0_1[arg_9_1] == nil then
		print("未设置此推送", arg_9_1)

		return
	end

	if var_0_1[arg_9_1].nextReminderTime and var_0_1[arg_9_1].nextReminderTime <= manager.time:GetServerTime() + 28800 then
		return
	end

	local var_9_0 = PushNotificationCfg.get_id_list_by_type[arg_9_1][1]

	GameToSDK.SendMessage(string.format("{\"messageType\" : \"CancelNotification\" , \"msgId\" : \"%d\"}", arg_9_1))

	if var_0_1[arg_9_1].sureNum >= 0 and var_0_1[arg_9_1].sureNum < PushNotificationCfg[var_9_0].times then
		var_0_1[arg_9_1].num = var_0_1[arg_9_1].num - 1
		var_0_1[arg_9_1].nextReminderTime = nil
	end
end

function var_0_0.KrNotPush(arg_10_0)
	if manager.time then
		if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].push_message == 1 then
			return true
		else
			return false
		end
	end
end

return var_0_0
