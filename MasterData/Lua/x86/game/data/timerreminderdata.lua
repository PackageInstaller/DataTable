local var_0_0 = singletonClass("TimerReminderData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0:SetReminder(arg_2_1)
	var_0_1[arg_2_1] = var_0_1[arg_2_1] or {
		num = 0,
		sureNum = 0,
		id = arg_2_1
	}

	if arg_2_1 == TimerReminderConst.FATIGUE then
		local var_2_0 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
		local var_2_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		local var_2_3

		if var_2_0 <= var_2_1 then
			var_2_3 = 0
		else
			local var_2_4 = GameSetting.fatigue_recovery.value[1] * 60
			local var_2_5

			if CurrencyData:GetLastFatigueRecoverTime() ~= 0 or not var_2_4 then
				::label_2_0::

				var_2_5 = var_2_4 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_2_4
			end

			var_2_3 = (var_2_0 - var_2_1 - 1) * var_2_4 + var_2_5 + 28800
		end

		local var_2_6 = manager.time:GetServerTime() + var_2_3
		local var_2_7 = string.split(manager.time:DescCTime(var_2_6, "!%Y %m %d %H %M %S"), " ")
		local var_2_8 = tonumber(var_2_7[4])

		if var_2_8 >= 0 and var_2_8 < 8 then
			var_2_6 = manager.time:Table2ServerTime({
				hour = 8,
				min = 0,
				sec = 0,
				year = tonumber(var_2_7[1]),
				month = tonumber(var_2_7[2]),
				day = tonumber(var_2_7[3])
			})
		end

		if var_0_1[arg_2_1].nextReminderTime == nil then
			var_0_1[arg_2_1].nextReminderTime = var_2_6
		else
			if var_0_1[arg_2_1].nextReminderTime and var_0_1[arg_2_1].nextReminderTime == var_2_6 then
				return
			end

			if manager.time:GetServerTime() >= var_0_1[arg_2_1].nextReminderTime then
				var_0_1[arg_2_1].lastReminderTime = var_0_1[arg_2_1].nextReminderTime
			end

			if var_0_1[arg_2_1].lastReminderTime and var_2_6 <= var_0_1[arg_2_1].lastReminderTime + GameSetting.push_notification_fatigue_cooldown.value[1] * 60 then
				self:CancelReminder(arg_2_1)

				return
			end

			var_0_1[arg_2_1].nextReminderTime = var_2_6
		end

		local var_2_9 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_2_1][math.round(math.random(#PushNotificationCfg.get_id_list_by_type[arg_2_1]))]]

		if var_2_3 * 1000 >= 1000 then
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_2_1, GetI18NText(var_2_9.title), GetI18NText(var_2_9.content), var_2_3 * 1000))
		end
	elseif arg_2_1 == TimerReminderConst.DAILYFATIGUE then
		self:DailyFatigueReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CAT_EXPLORE then
		self:CatExploreReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CANTEEN_DISPATCH then
		self:CanteenDispatchReminder(arg_2_1)
	elseif arg_2_1 == TimerReminderConst.CANTEEN_FULL then
		self:CanteenFullReminder(arg_2_1)
	else
		print("未设置此推送类型", arg_2_1)
	end
end

function var_0_0.CalHeroWorkTime(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = CanteenData:GetPopularityNum()

	for iter_3_0, iter_3_1 in ipairs(GameSetting.canteen_popular_cost_time.value) do
		if var_3_0 < iter_3_1[1] then
			-- block empty
		end
	end

	local var_3_3 = 0

	for iter_3_2, iter_3_3 in ipairs((DormSkillData:CheckSkillCanOpen(arg_3_1, arg_3_2))) do
		if BackHomeHeroSkillCfg[iter_3_3].type == CanteenConst.HeroSkillType.FatigueRecuse then
			var_3_3 = var_3_3 + BackHomeHeroSkillCfg[iter_3_3].param[1]
		end
	end

	return GameSetting.dorm_canteen_fatigue_cost.value[1] / 100 * (100 - var_3_3) / 100
end

local var_0_2 = 9999999999
local var_0_3 = 0

function var_0_0:traceback(arg_4_1, arg_4_2, arg_4_3)
	var_0_3 = var_0_3 + 1

	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 9999999999

	for iter_4_0, iter_4_1 in pairs(arg_4_2) do
		if DormNpcTools:CheckIDIsNpc(iter_4_0) then
			for iter_4_2, iter_4_3 in pairs(arg_4_3) do
				var_4_1 = var_4_1 + (CanteenFoodData:GetFoodUnitCost(iter_4_2) or 0) / (CanteenFoodData:CalSignFoodTime(iter_4_2, 1) or 1)
			end

			var_0_2 = math.min(var_0_2, arg_4_1 / var_4_1)
		else
			local var_4_4 = CanteenData:GetPopularityNum() or 0
			local var_4_5 = GameSetting.canteen_popular_cost_time.value[#GameSetting.canteen_popular_cost_time.value][2]

			for iter_4_4, iter_4_5 in ipairs(GameSetting.canteen_popular_cost_time.value) do
				if var_4_4 < iter_4_5[1] then
					var_4_5 = iter_4_5[2]

					break
				end
			end

			local var_4_6 = self:CalHeroWorkTime(iter_4_0, iter_4_1.heroID) or 1

			var_4_2 = math.min(iter_4_1.curFatigue / var_4_6 * var_4_5, var_4_2)
			iter_4_1.curFatigue = iter_4_1.curFatigue - var_4_6
		end
	end

	for iter_4_6, iter_4_7 in pairs(arg_4_3) do
		local var_4_7 = CanteenFoodData:GetFoodUnitCost(iter_4_6) or 0
		local var_4_8 = CanteenFoodData:CalSignFoodTime(iter_4_6, iter_4_7.sellNum - iter_4_7.soldNum) or 1

		if var_4_8 <= 0 or iter_4_7.sellNum - iter_4_7.soldNum <= 0 then
			break
		end

		local var_4_9 = 0

		var_4_1 = var_4_1 + var_4_7 / (var_4_8 / (iter_4_7.sellNum - iter_4_7.soldNum))

		if var_4_2 / (var_4_8 / (iter_4_7.sellNum - iter_4_7.soldNum)) <= iter_4_7.sellNum - iter_4_7.soldNum then
			var_4_9 = var_4_7 / (var_4_8 / (iter_4_7.sellNum - iter_4_7.soldNum)) * var_4_2
			iter_4_7.soldNum = iter_4_7.soldNum + var_4_2 / (var_4_8 / (iter_4_7.sellNum - iter_4_7.soldNum))
		else
			var_4_9 = (iter_4_7.sellNum - iter_4_7.soldNum) * var_4_7
			iter_4_7.soldNum = iter_4_7.soldNum + (iter_4_7.sellNum - iter_4_7.soldNum)
		end

		var_4_0 = var_4_0 + var_4_9
	end

	if var_4_0 < arg_4_1 and var_0_3 <= 10 then
		if var_0_2 == 9999999999 then
			var_0_2 = 0
		end

		var_0_2 = var_0_2 + var_4_2

		self:traceback(arg_4_1 - var_4_0, arg_4_2, arg_4_3)
	else
		if var_0_2 == 9999999999 then
			var_0_2 = 0
		end

		var_0_2 = var_0_2 + arg_4_1 / var_4_1
		var_0_3 = 0
	end
end

function var_0_0:CanteenFullReminder(arg_5_1)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		if CanteenTools:CheckSignFoodNumCanOpen() and CanteenTools:CheckCanteenJobCanOpen() then
			local var_5_1 = 0
			local var_5_2 = {}

			for iter_5_0, iter_5_1 in ipairs((CanteenFoodData:GetChooseFoodList())) do
				local var_5_3 = CanteenFoodData:GetSignFoodInfo(iter_5_1)

				var_5_1 = var_5_1 + (var_5_3.sellNum - var_5_3.soldNum or 0) * (CanteenFoodData:GetFoodUnitCost(iter_5_1) or 0)
				var_5_2[iter_5_1] = {
					sellNum = var_5_3.sellNum,
					soldNum = var_5_3.soldNum
				}
			end

			local var_5_5 = CanteenData:GetAutoAwardNum() or 0
			local var_5_6 = DormSkillData:GetInComeStorageMax() or 0
			local var_5_7 = var_5_6 - var_5_5
			local var_5_8 = {}

			for iter_5_2, iter_5_3 in pairs((CanteenHeroTools:GetCanteenJobList())) do
				if not DormNpcTools:CheckIDIsNpc(iter_5_3.heroID) then
					local var_5_9 = DormData:GetCharacterInfo(iter_5_3.heroID):GetFatigue() or 0

					var_5_8[iter_5_3.heroID] = {
						curFatigue = var_5_9,
						jobType = CanteenHeroTools:GetJobTypeByHeroID(iter_5_3.heroID),
						heroID = iter_5_3.heroID
					}
				end
			end

			if var_5_1 < var_5_6 - var_5_5 then
				return
			else
				self:traceback(var_5_7, var_5_8, var_5_2)
			end
		else
			return
		end
	else
		return
	end

	local var_5_11
	local var_5_12 = math.ceil(var_0_2) or 0

	var_0_2 = 9999999999

	local var_5_13 = manager.time:GetServerTime() + var_5_12 + 28800 or 0

	if var_5_13 <= manager.time:GetServerTime() + 28800 then
		var_5_13 = manager.time:GetServerTime() + 7200 + 28800
		var_5_11 = true
		var_0_1[arg_5_1].sureNum = var_0_1[arg_5_1].num
	end

	local var_5_14 = string.split(manager.time:DescCTime(var_5_13, "!%Y %m %d %H %M %S"), " ")
	local var_5_15 = tonumber(var_5_14[4])
	local var_5_16 = math.floor(var_5_12 / 86400)

	if self:KrNotPush() then
		if var_5_15 > 20 or var_5_15 < 7 then
			var_5_13 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_5_14[1]),
				month = tonumber(var_5_14[2]),
				day = tonumber(var_5_14[3])
			})
			var_5_12 = var_5_13
			var_0_1[arg_5_1].num = 0
			var_0_1[arg_5_1].nextReminderTime = nil
			var_0_1[arg_5_1].lastReminderTime = nil
		end
	elseif var_5_15 >= 0 and var_5_15 < 8 then
		var_5_13 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_5_14[1]),
			month = tonumber(var_5_14[2]),
			day = tonumber(var_5_14[3])
		})
		var_5_12 = var_5_13
		var_0_1[arg_5_1].num = 0
		var_0_1[arg_5_1].nextReminderTime = nil
		var_0_1[arg_5_1].lastReminderTime = nil
	end

	if not var_0_1[arg_5_1].nextReminderTime then
		var_0_1[arg_5_1].nextReminderTime = var_5_13
	else
		if var_0_1[arg_5_1].nextReminderTime and var_0_1[arg_5_1].nextReminderTime == var_5_13 then
			return
		end

		if manager.time:GetServerTime() + 28800 >= var_0_1[arg_5_1].nextReminderTime then
			var_0_1[arg_5_1].lastReminderTime = var_0_1[arg_5_1].nextReminderTime
		end

		if var_0_1[arg_5_1].lastReminderTime and var_5_13 <= var_0_1[arg_5_1].lastReminderTime + GameSetting.push_notification_canteenfull_cooldown.value[1] * 60 then
			return
		end

		var_0_1[arg_5_1].nextReminderTime = var_5_13
	end

	local var_5_17 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_5_1][1]]

	if var_5_12 % 86400 == 0 then
		var_5_12 = var_5_12 == 0 and 7200 or 86400 - manager.time:GetServerTime() % 86400 + var_5_16 * 86400
	elseif var_5_11 then
		var_5_12 = 7200
	end

	print("餐厅收益上限推送", arg_5_1, var_5_17.title, var_5_17.content, var_5_12 * 1000)

	if var_5_12 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_5_1, GetI18NText(var_5_17.title), GetI18NText(var_5_17.content), var_5_12 * 1000))

		var_0_1[arg_5_1].num = var_0_1[arg_5_1].num + 1
	end
end

function var_0_0:CanteenDispatchReminder(arg_6_1)
	local var_6_1 = 9999999999

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_6_2 = CanteenEntrustData:GetEntrustList()

		if var_6_2 then
			for iter_6_0, iter_6_1 in pairs(var_6_2) do
				if iter_6_1.start_time and iter_6_1.start_time > 0 then
					var_6_1 = math.min(iter_6_1.start_time + BackHomeCanteenTaskCfg[iter_6_1.id].time[iter_6_1.timeLevel][1] * 60, var_6_1)
				end
			end
		end
	end

	local var_6_3
	local var_6_4 = var_6_1

	if var_6_1 == 9999999999 then
		return
	end

	local var_6_5 = var_6_4 + 28800

	if var_6_4 + 28800 < manager.time:GetServerTime() + 28800 then
		var_6_5 = manager.time:GetServerTime() + 7200 + 28800
		var_6_3 = true
		var_0_1[arg_6_1].sureNum = var_0_1[arg_6_1].num
	end

	local var_6_6 = string.split(manager.time:DescCTime(var_6_5, "!%Y %m %d %H %M %S"), " ")
	local var_6_7 = tonumber(var_6_6[4])

	if self:KrNotPush() then
		if var_6_7 > 20 or var_6_7 < 7 then
			var_6_5 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_6_6[1]),
				month = tonumber(var_6_6[2]),
				day = tonumber(var_6_6[3])
			})
			var_6_4 = var_6_5
			var_0_1[arg_6_1].num = 0
			var_0_1[arg_6_1].nextReminderTime = nil
			var_0_1[arg_6_1].lastReminderTime = nil
		end
	elseif var_6_7 >= 0 and var_6_7 < 8 then
		var_6_5 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_6_6[1]),
			month = tonumber(var_6_6[2]),
			day = tonumber(var_6_6[3])
		})
		var_6_4 = var_6_5
		var_0_1[arg_6_1].num = 0
		var_0_1[arg_6_1].nextReminderTime = nil
		var_0_1[arg_6_1].lastReminderTime = nil
	end

	if var_0_1[arg_6_1].nextReminderTime == nil then
		var_0_1[arg_6_1].nextReminderTime = var_6_5
	else
		if var_0_1[arg_6_1].nextReminderTime and var_0_1[arg_6_1].nextReminderTime == var_6_5 then
			return
		end

		if manager.time:GetServerTime() + 28800 >= var_0_1[arg_6_1].nextReminderTime then
			var_0_1[arg_6_1].lastReminderTime = var_0_1[arg_6_1].nextReminderTime
		end

		if var_0_1[arg_6_1].lastReminderTime and (var_6_5 <= var_0_1[arg_6_1].lastReminderTime + GameSetting.push_notification_canteendispatch_cooldown.value[1] * 60 or var_0_1[arg_6_1].sureNum >= PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_6_1][1]].times) then
			return
		end

		var_0_1[arg_6_1].nextReminderTime = var_6_5
	end

	local var_6_8 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_6_1][1]]

	if var_6_4 % 86400 == 0 then
		var_6_4 = 86400 - manager.time:GetServerTime() % 86400
	elseif var_6_3 then
		var_6_4 = 7200
	else
		var_6_4 = var_6_4 % 86400 - manager.time:GetServerTime() % 86400
		var_6_4 = math.abs(var_6_4)
	end

	print("餐厅派遣推送", arg_6_1, var_6_8.title, var_6_8.content, var_6_4 * 1000)

	if var_6_4 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_6_1, GetI18NText(var_6_8.title), GetI18NText(var_6_8.content), var_6_4 * 1000))

		var_0_1[arg_6_1].num = var_0_1[arg_6_1].num + 1
	end
end

function var_0_0:CatExploreReminder(arg_7_1)
	local var_7_0 = AdminCatExploreData:GetMinStopTime()

	if nil == 9999999999 then
		return
	end

	local var_7_2
	local var_7_3 = var_7_0 + 28800

	if var_7_0 + 28800 < manager.time:GetServerTime() + 28800 then
		var_7_3 = manager.time:GetServerTime() + 7200 + 28800
		var_7_2 = true
		var_0_1[arg_7_1].sureNum = var_0_1[arg_7_1].num
	end

	local var_7_4 = string.split(manager.time:DescCTime(var_7_3, "!%Y %m %d %H %M %S"), " ")
	local var_7_5 = tonumber(var_7_4[4])

	if self:KrNotPush() then
		if var_7_5 > 20 or var_7_5 < 7 then
			var_7_3 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(var_7_4[1]),
				month = tonumber(var_7_4[2]),
				day = tonumber(var_7_4[3])
			})
			var_7_0 = var_7_3
			var_0_1[arg_7_1].num = 0
			var_0_1[arg_7_1].nextReminderTime = nil
			var_0_1[arg_7_1].lastReminderTime = nil
		end
	elseif var_7_5 >= 0 and var_7_5 < 8 then
		var_7_3 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(var_7_4[1]),
			month = tonumber(var_7_4[2]),
			day = tonumber(var_7_4[3])
		})
		var_7_0 = var_7_3
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

		if var_0_1[arg_7_1].lastReminderTime and (var_7_3 <= var_0_1[arg_7_1].lastReminderTime + GameSetting.push_notification_catexplore_cooldown.value[1] * 60 or var_0_1[arg_7_1].sureNum >= PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_7_1][1]].times) then
			return
		end

		var_0_1[arg_7_1].nextReminderTime = var_7_3
	end

	local var_7_6 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_7_1][1]]

	if var_7_0 % 86400 == 0 then
		var_7_0 = 86400 - manager.time:GetServerTime() % 86400
	elseif var_7_2 then
		var_7_0 = 7200
	else
		var_7_0 = var_7_0 % 86400 - manager.time:GetServerTime() % 86400
		var_7_0 = math.abs(var_7_0)
	end

	print("猫咪探索推送", arg_7_1, var_7_6.title, var_7_6.content, var_7_0 * 1000)

	if var_7_0 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_7_1, GetI18NText(var_7_6.title), GetI18NText(var_7_6.content), var_7_0 * 1000))

		var_0_1[arg_7_1].num = var_0_1[arg_7_1].num + 1
	end
end

function var_0_0.DailyFatigueReminder(arg_8_0, arg_8_1)
	local var_8_0 = 43200 - manager.time:GetServerTime() % 86400

	if var_8_0 * 1000 >= 1000 and (DailyFatigueData:GetStatus(11) ~= 3 or DailyFatigueData:GetStatus(18) ~= 3) then
		print("吨吨补给站推送", arg_8_1, PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_8_1][1]].title, PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_8_1][1]].content, var_8_0 * 1000)
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", arg_8_1, GetI18NText(PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_8_1][1]].title), GetI18NText(PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[arg_8_1][1]].content), var_8_0 * 1000))
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
