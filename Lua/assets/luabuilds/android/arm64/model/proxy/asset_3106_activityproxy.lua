local ActivityProxy = class("ActivityProxy", import(".NetProxy"))

ActivityProxy.ACTIVITY_ADDED = "ActivityProxy ACTIVITY_ADDED"
ActivityProxy.ACTIVITY_UPDATED = "ActivityProxy ACTIVITY_UPDATED"
ActivityProxy.ACTIVITY_DELETED = "ActivityProxy ACTIVITY_DELETED"
ActivityProxy.ACTIVITY_END = "ActivityProxy ACTIVITY_END"
ActivityProxy.ACTIVITY_OPERATION_DONE = "ActivityProxy ACTIVITY_OPERATION_DONE"
ActivityProxy.ACTIVITY_SHOW_AWARDS = "ActivityProxy ACTIVITY_SHOW_AWARDS"
ActivityProxy.ACTIVITY_SHOP_SHOW_AWARDS = "ActivityProxy ACTIVITY_SHOP_SHOW_AWARDS"
ActivityProxy.ACTIVITY_SHOW_BB_RESULT = "ActivityProxy ACTIVITY_SHOW_BB_RESULT"
ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS = "ActivityProxy ACTIVITY_LOTTERY_SHOW_AWARDS"
ActivityProxy.ACTIVITY_HITMONSTER_SHOW_AWARDS = "ActivityProxy ACTIVITY_HITMONSTER_SHOW_AWARDS"
ActivityProxy.ACTIVITY_SHOW_REFLUX_AWARDS = "ActivityProxy ACTIVITY_SHOW_REFLUX_AWARDS"
ActivityProxy.ACTIVITY_OPERATION_ERRO = "ActivityProxy ACTIVITY_OPERATION_ERRO"
ActivityProxy.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT = "ActivityProxy ACTIVITY_SHOW_LOTTERY_AWARD_RESULT"
ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS = "ActivityProxy ACTIVITY_SHOW_RED_PACKET_AWARDS"
ActivityProxy.ACTIVITY_SHOW_SHAKE_BEADS_RESULT = "ActivityProxy ACTIVITY_SHOW_SHAKE_BEADS_RESULT"
ActivityProxy.ACTIVITY_EXCHANGE_RESOURCES = "ActivityProxy ACTIVITY_EXCHANGE_RESOURCES"
ActivityProxy.UPDATED_TIP = "ActivityProxy UPDATED_TIP"
ActivityProxy.ACTIVITY_PT_ID = 110

function ActivityProxy:register()
	self:on(11200, function(arg_2_0)
		self.data = {}
		self.params = {}
		self.hxList = {}
		self.stopList = {}

		if arg_2_0.hx_list then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.hx_list) do
				table.insert(self.hxList, iter_2_1)
			end
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.activity_list) do
			if not pg.activity_template[iter_2_3.id] then
				Debugger.LogError("活动acvitity_template不存在: " .. iter_2_3.id)
			else
				local var_2_0 = Activity.Create(iter_2_3)
				local var_2_1 = var_2_0:getConfig("type")

				if var_2_1 == ActivityConst.ACTIVITY_TYPE_PARAMETER then
					self:addActivityParameter(var_2_0)
				elseif var_2_1 == ActivityConst.ACTIVITY_TYPE_EVENT_SINGLE then
					self:CheckDailyEventRequest(var_2_0)
				else
					self:CheckCreateActivityFleet(var_2_0, iter_2_3)
				end

				self.data[iter_2_3.id] = var_2_0

				if var_2_0.stopTime > 0 then
					table.insert(self.stopList, {
						var_2_0.stopTime,
						var_2_0.id
					})
					table.sort(self.stopList, CompareFuncs({
						function(arg_3_0)
							return arg_3_0[1]
						end
					}))
				end
			end
		end

		local var_2_2 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

		if var_2_2 and not var_2_2:isEnd() then
			self:sendNotification(GAME.CHALLENGE2_INFO, {})
		end

		local var_2_3 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST_MONITOR)

		if var_2_3 and not var_2_3:isEnd() and var_2_3.data1 == 0 then
			self:monitorTaskList(var_2_3)
		end

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
		;(function()
			local var_4_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not var_4_0 then
				return
			end

			self:sendNotification(GAME.REQUEST_ATELIER, var_4_0.id)

			return
		end)()

		local var_2_4 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)

		if var_2_4 and not var_2_4:isEnd() then
			getProxy(EventProxy):CheckAddActivityEvent()
		end

		BuffHelper.GetAllBuff()

		return
	end)
	self:on(11201, function(arg_5_0)
		local var_5_0 = Activity.Create(arg_5_0.activity_info)

		assert(var_5_0.id, "should exist activity")

		local var_5_1 = var_5_0:getConfig("type")

		if var_5_1 == ActivityConst.ACTIVITY_TYPE_PARAMETER then
			self:addActivityParameter(var_5_0)
		end

		if not self.data[var_5_0.id] or var_5_1 == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			self:CheckCreateActivityFleet(var_5_0, arg_5_0.activity_info)
		end

		if not self.data[var_5_0.id] then
			self:addActivity(var_5_0)
		else
			self:updateActivity(var_5_0)
		end

		self:sendNotification(GAME.ACTIVITY_BE_UPDATED, {
			activity = var_5_0
		})

		return
	end)
	self:on(40009, function(arg_6_0)
		local var_6_0 = self:GetBossActivityByChapterId(arg_6_0.arg1) or self:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
		local var_6_1

		if var_6_0 then
			var_6_1 = var_6_0:GetSeriesData()
		end

		local var_6_2 = BossRushSettlementCommand.ConcludeEXP(arg_6_0, var_6_0, var_6_1 and var_6_1:GetBattleStatistics())

		;(function()
			self:GetBossRushRuntime(var_6_0.id).settlementData = var_6_2

			return
		end)()

		return
	end)
	self:on(24100, function(arg_8_0)
		(function()
			local var_9_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK)

			if not var_9_0 then
				return
			end

			var_9_0:Record(arg_8_0.score)
			self:updateActivity(var_9_0)

			return
		end)()

		local var_8_0 = self:getActivityById(arg_8_0.act_id)

		if not var_8_0 then
			return
		end

		local var_8_1 = var_8_0:GetSeriesData()

		if not var_8_1 then
			return
		end

		var_8_1:AddEXScore(arg_8_0)
		self:updateActivity(var_8_0)

		return
	end)
	self:on(11028, function(arg_10_0)
		print("接受到问卷状态", arg_10_0.result)

		if arg_10_0.result == 0 then
			self:setSurveyState(arg_10_0.result)
		elseif arg_10_0.result > 0 then
			self:setSurveyState(arg_10_0.result)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_10_0.result))
		end

		return
	end)
	self:on(26033, function(arg_11_0)
		local var_11_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
		local var_11_1

		if not var_11_0 then
			do return end

			var_11_1 = {}
		end

		var_11_1.score = arg_11_0.point
		var_11_1.new = var_11_0:UpdateHighestScore(arg_11_0.point)
		self:GetActivityBossRuntime(var_11_0.id).spScore = var_11_1

		self:updateActivity(var_11_0)

		return
	end)

	self.requestTime = {}
	self.extraDatas = {}

	return
end

function ActivityProxy:remove()
	BuffHelper.ClearAllCache()

	return
end

function ActivityProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_14_0)
			for iter_14_0, iter_14_1 in pairs(self.data) do
				if not iter_14_1:isEnd() then
					switch(iter_14_1:getConfig("type"), {
						[ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN] = function()
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN] = function()
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_MONTHSIGN] = function()
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_REFLUX] = function()
							iter_14_1.data1KeyValueList = {
								{}
							}
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_HITMONSTERNIAN] = function()
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_BB] = function()
							iter_14_1.data2 = 0
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_LOTTERY_AWARD] = function()
							iter_14_1.data2 = 0
							iter_14_1.autoActionForbidden = false

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
							local var_22_0 = iter_14_1:GetUsedBonus()

							table.Foreach(var_22_0, function(arg_23_0, arg_23_1)
								var_22_0[arg_23_0] = 0

								return
							end)
							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function()
							local var_24_0 = iter_14_1:GetDailyCounts()

							table.Foreach(var_24_0, function(arg_25_0, arg_25_1)
								var_24_0[arg_25_0] = 0

								return
							end)
							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_MANUAL_SIGN] = function()
							self:sendNotification(GAME.ACT_MANUAL_SIGN, {
								activity_id = iter_14_1.id,
								cmd = ManualSignActivity.OP_SIGN
							})

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_TURNTABLE] = function()
							local var_28_0 = pg.activity_event_turning[iter_14_1:getConfig("config_id")]

							if var_28_0.total_num <= iter_14_1.data3 then
								return
							end

							local var_28_1 = var_28_0.task_table[iter_14_1.data4]

							if not var_28_0.task_table[iter_14_1.data4] then
								return
							end

							local var_28_2 = getProxy(TaskProxy)

							for iter_28_0, iter_28_1 in ipairs(var_28_1) do
								if (var_28_2:getTaskById(iter_28_1) or var_28_2:getFinishTaskById(iter_28_1)):getTaskStatus() ~= 2 then
									return
								end
							end

							self:sendNotification(GAME.ACTIVITY_OPERATION, {
								cmd = 2,
								activity_id = iter_14_1.id
							})

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_MONOPOLY] = function()
							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_CHALLENGE] = function()
							self:sendNotification(GAME.CHALLENGE2_INFO, {})

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
							local var_31_0 = pg.activity_event_worldboss[iter_14_1:getConfig("config_id")]

							if var_31_0 then
								for iter_31_0, iter_31_1 in ipairs(var_31_0.normal_expedition_drop_num or {}) do
									for iter_31_2, iter_31_3 in ipairs(iter_31_1[1]) do
										iter_14_1.data1KeyValueList[1][iter_31_3] = iter_31_1[2] or 0
									end
								end
							end

							self:updateActivity(iter_14_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_RANDOM_DAILY_TASK] = function()
							if pg.TimeMgr.GetInstance():IsSameDay(iter_14_1.data1, (pg.TimeMgr.GetInstance():GetServerTime())) then
								return
							end

							pg.m02:sendNotification(GAME.ACT_RANDOM_DAILY_TASK, {
								activity_id = iter_14_1.id,
								cmd = ActivityConst.RANDOM_DAILY_TASK_OP_RANDOM
							})

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_EVENT_SINGLE] = function()
							self:sendNotification(GAME.SINGLE_EVENT_REFRESH, {
								actId = iter_14_1.id
							})

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_UP] = function()
							iter_14_1:DayReset()
							self:updateActivity(iter_14_1)

							return
						end
					})
				end
			end

			return
		end,
		[ProxyRegister.SecondCall] = function(arg_35_0)
			for iter_35_0, iter_35_1 in pairs(self.data) do
				if not iter_35_1:isEnd() then
					switch(iter_35_1:getConfig("type"), {
						[ActivityConst.ACTIVITY_TYPE_TOWN] = function()
							iter_35_1:UpdateTime()

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
							iter_35_1:UpdateTime()

							return
						end
					})
				end
			end

			if not self.stopList then
				return
			end

			while #self.stopList > 0 and pg.TimeMgr.GetInstance():GetServerTime() >= self.stopList[1][1] do
				local var_35_0, var_35_1 = unpack(table.remove(self.stopList, 1))
				local var_35_2 = self.data[var_35_1]

				switch(self.data[var_35_1]:getConfig("type"), {
					[ActivityConst.ACTIVITY_TYPE_MILITARY_EXERCISE] = function()
						getProxy(MilitaryExerciseProxy):setSeasonOver()

						return
					end,
					[ActivityConst.ACTIVITY_TYPE_NPC_COLLECTION] = function()
						local var_39_0 = getProxy(BayProxy):getShipById(var_35_2.data2)

						if var_39_0 and var_39_0:isActivityNpc() then
							self:sendNotification(GAME.SEND_CMD, {
								cmd = "kick"
							})
						end

						return
					end,
					[ActivityConst.ACTIVITY_TYPE_TASKS] = function()
						local var_40_0 = getProxy(TaskProxy)

						for iter_40_0, iter_40_1 in ipairs(var_35_2:getConfig("config_data")) do
							var_40_0:deleteTaskById(iter_40_1)
						end

						return
					end
				})
				pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inActivity")
				self:sendNotification(ActivityProxy.ACTIVITY_END, var_35_1)
			end

			return
		end
	}
end

function ActivityProxy:getAliveActivityByType(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(self.data) do
		if iter_41_1:getConfig("type") == arg_41_1 and not iter_41_1:isEnd() then
			return iter_41_1
		end
	end

	return
end

function ActivityProxy:getActivityByType(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self.data) do
		if iter_42_1:getConfig("type") == arg_42_1 then
			return iter_42_1
		end
	end

	return
end

function ActivityProxy:getActivitiesByType(arg_43_1)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(self.data) do
		if iter_43_1:getConfig("type") == arg_43_1 then
			table.insert(var_43_0, iter_43_1)
		end
	end

	return var_43_0
end

function ActivityProxy:getActivitiesByTypes(arg_44_1)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(self.data) do
		if table.contains(arg_44_1, iter_44_1:getConfig("type")) then
			table.insert(var_44_0, iter_44_1)
		end
	end

	return var_44_0
end

function ActivityProxy:getMilitaryExerciseActivity()
	local var_45_0

	for iter_45_0, iter_45_1 in pairs(self.data) do
		if iter_45_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MILITARY_EXERCISE then
			var_45_0 = iter_45_1

			break
		end
	end

	return Clone(var_45_0)
end

function ActivityProxy:getPanelActivities()
	local function var_46_0(arg_47_0)
		local var_47_0 = arg_47_0:getConfig("type")
		local var_47_1 = arg_47_0:isShow() and not arg_47_0:isAfterShow() and arg_47_0:isCorePage("")

		if var_47_1 then
			if var_47_0 == ActivityConst.ACTIVITY_TYPE_CHARGEAWARD then
				var_47_1 = arg_47_0.data2 == 0
			elseif var_47_0 == ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN then
				var_47_1 = arg_47_0.data1 < 7 or not arg_47_0.achieved
			elseif var_47_0 == ActivityConst.ACTIVITY_TYPE_SURVEY then
				var_47_1 = PLATFORM ~= PLATFORM_OPENHARMONY
			end
		end

		return var_47_1 and not arg_47_0:isEnd()
	end

	local var_46_1 = {}

	for iter_46_0, iter_46_1 in pairs(self.data) do
		if var_46_0(iter_46_1) then
			table.insert(var_46_1, iter_46_1)
		end
	end

	table.sort(var_46_1, CompareFuncs({
		function(arg_48_0)
			return -arg_48_0:getConfig("login_pop")
		end,
		function(arg_49_0)
			return arg_49_0.id
		end
	}))

	return var_46_1
end

function ActivityProxy:getCorePanelActivities(arg_50_1)
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in pairs(self.data) do
		if iter_50_1:isShow() and iter_50_1:isCorePage(arg_50_1) then
			table.insert(var_50_0, iter_50_1)
		end
	end

	table.sort(var_50_0, CompareFuncs({
		function(arg_51_0)
			return -arg_51_0:getConfig("login_pop")
		end,
		function(arg_52_0)
			return arg_52_0.id
		end
	}))

	return var_50_0
end

function ActivityProxy:getIslandPanelActivities()
	local function var_53_0(arg_54_0)
		local var_54_0 = arg_54_0:isIslandShow()

		if var_54_0 and arg_54_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SURVEY then
			var_54_0 = self:isSurveyOpen() and not self:isSurveyDone()

			if PLATFORM == PLATFORM_OPENHARMONY then
				var_54_0 = false
			end
		end

		return var_54_0 and not arg_54_0:isEnd()
	end

	local var_53_1 = {}

	for iter_53_0, iter_53_1 in pairs(self.data) do
		if var_53_0(iter_53_1) then
			table.insert(var_53_1, iter_53_1)
		end
	end

	return var_53_1
end

function ActivityProxy:checkHxActivity(arg_55_1)
	if self.hxList and #self.hxList > 0 then
		for iter_55_0 = 1, #self.hxList do
			if self.hxList[iter_55_0] == arg_55_1 then
				return true
			end
		end
	end

	return false
end

function ActivityProxy:getBannerDisplays()
	return _(pg.activity_banner.all):chain():map(function(arg_57_0)
		return pg.activity_banner[arg_57_0]
	end):filter(function(arg_58_0)
		local var_58_0 = pg.TimeMgr.GetInstance():inTime(arg_58_0.time)

		var_58_0 = var_58_0 and arg_58_0.type ~= GAMEUI_BANNER_9 and arg_58_0.type ~= GAMEUI_BANNER_11 and arg_58_0.type ~= GAMEUI_BANNER_10 and arg_58_0.type ~= GAMEUI_BANNER_12 and arg_58_0.type ~= GAMEUI_BANNER_13

		return var_58_0
	end):value()
end

function ActivityProxy:getActiveBannerByType(arg_59_1)
	if not pg.activity_banner.get_id_list_by_type[arg_59_1] then
		return nil
	end

	for iter_59_0, iter_59_1 in ipairs(pg.activity_banner.get_id_list_by_type[arg_59_1]) do
		if pg.TimeMgr.GetInstance():inTime(pg.activity_banner[iter_59_1].time) then
			return pg.activity_banner[iter_59_1]
		end
	end

	return nil
end

function ActivityProxy:getNoticeBannerDisplays()
	return _.map(pg.activity_banner_notice.all, function(arg_61_0)
		return pg.activity_banner_notice[arg_61_0]
	end)
end

function ActivityProxy:findNextAutoActivity(arg_62_1)
	local var_62_0
	local var_62_1 = pg.TimeMgr.GetInstance()
	local var_62_2 = var_62_1:GetServerTime()

	for iter_62_0, iter_62_1 in ipairs(arg_62_1 and arg_62_1 ~= "" and self:getCorePanelActivities(arg_62_1) or self:getPanelActivities()) do
		if not iter_62_1.autoActionForbidden then
			local var_62_3 = iter_62_1:getConfig("type")

			if var_62_3 == ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN then
				local var_62_4 = iter_62_1:getConfig("config_client")

				if var_62_4 and var_62_4.manulSign == true then
					-- block empty
				elseif iter_62_1.data1 < #pg.activity_7_day_sign[iter_62_1:getConfig("config_id")].front_drops and not var_62_1:IsSameDay(var_62_2, iter_62_1.data2) and var_62_2 > iter_62_1.data2 then
					var_62_0 = iter_62_1

					break
				end
			elseif var_62_3 == ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN then
				if iter_62_1.data1 < 7 and not var_62_1:IsSameDay(var_62_2, iter_62_1.data2) or iter_62_1.data1 == 7 and not iter_62_1.achieved and getProxy(ChapterProxy):isClear(204) then
					var_62_0 = iter_62_1

					break
				end
			elseif var_62_3 == ActivityConst.ACTIVITY_TYPE_MONTHSIGN then
				local var_62_5 = pg.TimeMgr.GetInstance():STimeDescS(var_62_2, "*t")

				iter_62_1:setSpecialData("reMonthSignDay", nil)

				if var_62_5.year ~= iter_62_1.data1 or var_62_5.month ~= iter_62_1.data2 then
					iter_62_1.data1 = var_62_5.year
					iter_62_1.data2 = var_62_5.month
					iter_62_1.data1_list = {}
					var_62_0 = iter_62_1

					break
				elseif not table.contains(iter_62_1.data1_list, var_62_5.day) then
					var_62_0 = iter_62_1

					break
				elseif var_62_5.day > #iter_62_1.data1_list and pg.activity_month_sign[iter_62_1.data2].resign_count > iter_62_1.data3 then
					for iter_62_2 = var_62_5.day, 1, -1 do
						if not table.contains(iter_62_1.data1_list, iter_62_2) then
							iter_62_1:setSpecialData("reMonthSignDay", iter_62_2)

							break
						end
					end

					var_62_0 = iter_62_1
				end
			elseif iter_62_1.id == ActivityConst.SHADOW_PLAY_ID and iter_62_1.clientData1 == 0 then
				local var_62_6 = iter_62_1:getConfig("config_data")[1]
				local var_62_7 = getProxy(TaskProxy)
				local var_62_8 = var_62_7:getTaskById(var_62_6) or var_62_7:getFinishTaskById(var_62_6)

				if var_62_8 and not var_62_8:isReceive() then
					var_62_0 = iter_62_1

					break
				end
			end
		end
	end

	if not var_62_0 then
		for iter_62_3, iter_62_4 in pairs(self.data) do
			if not iter_62_4:isShow() and iter_62_4:getConfig("type") == ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN and iter_62_4.data1 < #pg.activity_7_day_sign[iter_62_4:getConfig("config_id")].front_drops and not var_62_1:IsSameDay(var_62_2, iter_62_4.data2) and var_62_2 > iter_62_4.data2 then
				var_62_0 = iter_62_4

				break
			end
		end
	end

	return var_62_0
end

function ActivityProxy:findRefluxAutoActivity()
	local var_63_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

	if var_63_0 and not var_63_0:isEnd() and not var_63_0.autoActionForbidden then
		local var_63_1 = pg.TimeMgr.GetInstance()

		if var_63_0.data1_list[2] < #pg.return_sign_template.all and not var_63_1:IsSameDay(var_63_1:GetServerTime(), var_63_0.data1_list[1]) then
			return 1
		end
	end

	return
end

function ActivityProxy:existRefluxAwards()
	local var_64_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

	if var_64_0 and not var_64_0:isEnd() then
		for iter_64_0 = #pg.return_pt_template.all, 1, -1 do
			if var_64_0.data3 >= pg.return_pt_template[pg.return_pt_template.all[iter_64_0]].pt_require and pg.return_pt_template.all[iter_64_0] > var_64_0.data4 then
				return true
			end
		end

		local var_64_1 = getProxy(TaskProxy)

		if _.any(_(var_64_0:getConfig("config_data")[7]):chain():map(function(arg_65_0)
			return arg_65_0[2]
		end):flatten():map(function(arg_66_0)
			return var_64_1:getTaskById(arg_66_0) or var_64_1:getFinishTaskById(arg_66_0) or false
		end):filter(function(arg_67_0)
			return not not arg_67_0
		end):value(), function(arg_68_0)
			return arg_68_0:getTaskStatus() == 1
		end) then
			return true
		end
	end

	return
end

function ActivityProxy:getActivityById(arg_69_1)
	return Clone(self.data[arg_69_1])
end

function ActivityProxy:RawGetActivityById(arg_70_1)
	return self.data[arg_70_1]
end

function ActivityProxy:updateActivity(arg_71_1)
	assert(self.data[arg_71_1.id], "activity should exist" .. arg_71_1.id)
	assert(isa(arg_71_1, Activity), "activity should instance of Activity")

	if arg_71_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_CRUSING then
		if self.data[arg_71_1.id].data1 < pg.battlepass_event_pt[arg_71_1.id].target[#pg.battlepass_event_pt[arg_71_1.id].target] and arg_71_1.data1 - self.data[arg_71_1.id].data1 > 0 then
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_CRUSING, {
				ptId = pg.battlepass_event_pt[arg_71_1.id].pt,
				ptCount = arg_71_1.data1 - self.data[arg_71_1.id].data1
			})
		end
	elseif arg_71_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_HEI5 and self.data[arg_71_1.id].data1 < pg.black_friday_battlepass_event_pt[arg_71_1.id].target[#pg.black_friday_battlepass_event_pt[arg_71_1.id].target] and arg_71_1.data1 - self.data[arg_71_1.id].data1 > 0 then
		pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_CRUSING, {
			ptId = pg.black_friday_battlepass_event_pt[arg_71_1.id].pt,
			ptCount = arg_71_1.data1 - self.data[arg_71_1.id].data1
		})
	end

	self.data[arg_71_1.id] = arg_71_1

	self:sendNotification(ActivityProxy.ACTIVITY_UPDATED, arg_71_1:clone())
	self:sendNotification(GAME.SYN_GRAFTING_ACTIVITY, {
		id = arg_71_1.id
	})
	BuffHelper.GenBuffsForActivity(arg_71_1)

	return
end

function ActivityProxy:addActivity(arg_72_1)
	assert(self.data[arg_72_1.id] == nil, "activity already exist" .. arg_72_1.id)
	assert(isa(arg_72_1, Activity), "activity should instance of Activity")

	self.data[arg_72_1.id] = arg_72_1

	self:sendNotification(ActivityProxy.ACTIVITY_ADDED, arg_72_1:clone())

	if arg_72_1.stopTime > 0 then
		table.insert(self.stopList, {
			arg_72_1.stopTime,
			arg_72_1.id
		})
		table.sort(self.stopList, CompareFuncs({
			function(arg_73_0)
				return arg_73_0[1]
			end
		}))
	end

	return
end

function ActivityProxy:deleteActivityById(arg_74_1)
	assert(self.data[arg_74_1], "activity should exist" .. arg_74_1)

	self.data[arg_74_1] = nil

	self:sendNotification(ActivityProxy.ACTIVITY_DELETED, arg_74_1)

	local var_74_0 = table.getIndex(self.stopList, function(arg_75_0)
		return arg_75_0[2] == arg_74_1
	end)

	if var_74_0 then
		table.remove(self.stopList, var_74_0)
	end

	return
end

function ActivityProxy:IsActivityNotEnd(arg_76_1)
	return self.data[arg_76_1] and not self.data[arg_76_1]:isEnd()
end

function ActivityProxy:readyToAchieveByType(arg_77_1)
	local var_77_0 = false

	for iter_77_0, iter_77_1 in ipairs((self:getActivitiesByType(arg_77_1))) do
		if iter_77_1:readyToAchieve() then
			var_77_0 = true

			break
		end
	end

	return var_77_0
end

function ActivityProxy:getBuildActivityCfgByID(arg_78_1)
	for iter_78_0, iter_78_1 in ipairs((self:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1,
		ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
	}))) do
		if not iter_78_1:isEnd() then
			local var_78_0 = iter_78_1:getConfig("config_client")

			if var_78_0 and var_78_0.id == arg_78_1 then
				return var_78_0
			end
		end
	end

	return nil
end

function ActivityProxy:getNoneActBuildActivityCfgByID(arg_79_1)
	for iter_79_0, iter_79_1 in ipairs((self:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_BUILD
	}))) do
		if not iter_79_1:isEnd() then
			local var_79_0 = iter_79_1:getConfig("config_client")

			if var_79_0 and var_79_0.id == arg_79_1 then
				return var_79_0
			end
		end
	end

	return nil
end

function ActivityProxy:getBuffShipList()
	local var_80_0 = {}

	_.each(self:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHIP_BUFF), function(arg_81_0)
		if arg_81_0 and not arg_81_0:isEnd() then
			local var_81_0 = pg.activity_expup_ship[arg_81_0:getConfig("config_id")]

			if not var_81_0 then
				return
			end

			for iter_81_0, iter_81_1 in pairs(var_81_0.expup) do
				var_80_0[iter_81_1[1]] = iter_81_1[2]
			end
		end

		return
	end)

	return var_80_0
end

function ActivityProxy:getVirtualItemNumber(arg_82_1)
	local var_82_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	if var_82_0 and not var_82_0:isEnd() then
		return (var_82_0.data1KeyValueList[1][arg_82_1] or nil) and (var_82_0.data1KeyValueList[1][arg_82_1] or 0)
	end

	return 0
end

function ActivityProxy:removeVitemById(arg_83_1, arg_83_2)
	local var_83_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	assert(var_83_0, "vbagType invalid")

	if var_83_0 and not var_83_0:isEnd() then
		var_83_0.data1KeyValueList[1][arg_83_1] = var_83_0.data1KeyValueList[1][arg_83_1] - arg_83_2
	end

	self:updateActivity(var_83_0)

	return
end

function ActivityProxy:addVitemById(arg_84_1, arg_84_2)
	local var_84_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG) or self:getActivityByType(ActivityConst.ACTIVITY_TYPE_HOLIDAY_VILLA) or self:getActivityByType(ActivityConst.ACTIVITY_TYPE_CITY_REBUILD)

	assert(var_84_0, "vbagType invalid")

	if var_84_0 and not var_84_0:isEnd() then
		var_84_0.data1KeyValueList[1][arg_84_1] = var_84_0.data1KeyValueList[1][arg_84_1] or 0
		var_84_0.data1KeyValueList[1][arg_84_1] = var_84_0.data1KeyValueList[1][arg_84_1] + arg_84_2
	end

	self:updateActivity(var_84_0)

	local var_84_1 = Item.getConfigData(arg_84_1).link_id

	if var_84_1 ~= 0 then
		local var_84_2 = self:getActivityById(var_84_1)

		if var_84_2 and not var_84_2:isEnd() then
			PlayerResChangeCommand.UpdateActivity(var_84_2, arg_84_2)
		end
	end

	return
end

function ActivityProxy:monitorTaskList(arg_85_1)
	if arg_85_1 and not arg_85_1:isEnd() and arg_85_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TASK_LIST_MONITOR then
		if getProxy(TaskProxy):isReceiveTasks(arg_85_1:getConfig("config_data")[1] or {}) then
			self:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_85_1.id
			})
		end
	end

	return
end

function ActivityProxy:CheckCreateActivityFleet(arg_86_1, arg_86_2)
	switch(arg_86_1:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
			if arg_86_1:checkBattleTimeInBossAct() then
				self:InitActtivityFleet(arg_86_1, arg_86_2)
			end

			self:InitActivityBossData(arg_86_1)

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_CHALLENGE] = function()
			self:InitActtivityFleet(arg_86_1, arg_86_2)

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = ActivityConst.ACTIVITY_TYPE_CHALLENGE,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = ActivityConst.ACTIVITY_TYPE_CHALLENGE,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = ActivityConst.ACTIVITY_TYPE_CHALLENGE,
		[ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = ActivityConst.ACTIVITY_TYPE_CHALLENGE
	})

	return
end

function ActivityProxy:InitActtivityFleet(arg_89_1, arg_89_2)
	getProxy(FleetProxy):addActivityFleet(arg_89_1, arg_89_2.group_list)

	return
end

function ActivityProxy:InitActivityBossData(arg_90_1)
	local var_90_0 = pg.activity_event_worldboss[arg_90_1:getConfig("config_id")]

	if not var_90_0 then
		return
	end

	local var_90_1 = arg_90_1.data1KeyValueList

	for iter_90_0, iter_90_1 in pairs(var_90_0.normal_expedition_drop_num or {}) do
		for iter_90_2, iter_90_3 in pairs(iter_90_1[1]) do
			var_90_1[1][iter_90_3] = math.max(iter_90_1[2] - (var_90_1[1][iter_90_3] or 0), 0)
			var_90_1[2][iter_90_3] = var_90_1[2][iter_90_3] or 0
		end
	end

	return
end

function ActivityProxy:RegisterRequestTime(arg_91_1, arg_91_2)
	if not arg_91_1 or arg_91_1 <= 0 then
		return
	end

	self.requestTime[arg_91_1] = arg_91_2

	return
end

function ActivityProxy:addActivityParameter(arg_92_1)
	for iter_92_0, iter_92_1 in ipairs((arg_92_1:getConfig("config_data"))) do
		self.params[iter_92_1[1]] = {
			iter_92_1[2],
			arg_92_1.stopTime
		}
	end

	return
end

function ActivityProxy:getActivityParameter(arg_93_1)
	if self.params[arg_93_1] then
		local var_93_0, var_93_1 = unpack(self.params[arg_93_1])

		if var_93_1 > 0 then
			if var_93_1 > pg.TimeMgr.GetInstance():GetServerTime() then
				return var_93_0
			end
		end
	end

	return
end

function ActivityProxy:IsShowFreeBuildMark(arg_94_1)
	for iter_94_0, iter_94_1 in ipairs(self:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BUILD_FREE)) do
		if iter_94_1 and not iter_94_1:isEnd() and iter_94_1.data1 > 0 then
			if iter_94_1.stopTime - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
				if tobool(arg_94_1) == (PlayerPrefs.GetString("Free_Build_Ticket_" .. iter_94_1.id, "") == pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d")) then
					return iter_94_1
				end
			end
		end
	end

	return false
end

function ActivityProxy:getBuildFreeActivityByBuildId(arg_95_1)
	for iter_95_0, iter_95_1 in ipairs(self:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BUILD_FREE)) do
		if underscore.any(iter_95_1:getConfig("config_data"), function(arg_96_0)
			return arg_96_0 == arg_95_1
		end) then
			return iter_95_1
		end
	end

	return
end

function ActivityProxy:getBuildPoolActivity(arg_97_1)
	if arg_97_1:IsActivity() then
		return self:getActivityById(arg_97_1.activityId)
	end

	return
end

function ActivityProxy:getEnterReadyActivity()
	local var_98_0 = {
		[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function(arg_99_0)
			return true
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function(arg_100_0)
			return arg_100_0:checkBattleTimeInBossAct()
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function(arg_101_0)
			return true
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function(arg_102_0)
			return true
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function(arg_103_0)
			return true
		end,
		[ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = function(arg_104_0)
			return true
		end
	}
	local var_98_1 = {}

	for iter_98_0, iter_98_1 in pairs(self.data) do
		if switch(iter_98_1:getConfig("type"), var_98_0, function(arg_105_0)
			return false
		end, iter_98_1) and not iter_98_1:isEnd() and tobool(iter_98_1:getConfig("config_client").entrance_bg) then
			table.insert(var_98_1, iter_98_1)
		end
	end

	table.sort(var_98_1, CompareFuncs({
		function(arg_106_0)
			return arg_106_0:getConfig("config_client").order or 1
		end,
		function(arg_107_0)
			return -arg_107_0.id
		end
	}))

	return var_98_1
end

function ActivityProxy:AtelierActivityAllSlotIsEmpty()
	local var_108_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	if not var_108_0 or var_108_0:isEnd() then
		return false
	end

	for iter_108_0, iter_108_1 in pairs((var_108_0:GetSlots())) do
		if iter_108_1[1] ~= 0 then
			return false
		end
	end

	return true
end

function ActivityProxy:OwnAtelierActivityItemCnt(arg_109_1, arg_109_2)
	local var_109_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	if not var_109_0 or var_109_0:isEnd() then
		return false
	end

	local var_109_1 = var_109_0:GetItems()[arg_109_1]

	return var_109_1 and arg_109_2 <= var_109_1.count
end

function ActivityProxy:InitContinuousTime(arg_110_1)
	self.continuousOpeartionTime = arg_110_1
	self.continuousOpeartionTotalTime = arg_110_1

	return
end

function ActivityProxy:UseContinuousTime()
	if not self.continuousOpeartionTime then
		return
	end

	self.continuousOpeartionTime = self.continuousOpeartionTime - 1

	return
end

function ActivityProxy:GetContinuousTime()
	return self.continuousOpeartionTime, self.continuousOpeartionTotalTime
end

function ActivityProxy:AddBossRushAwards(arg_113_1)
	self.bossrushAwards = self.bossrushAwards or {}

	table.insertto(self.bossrushAwards, arg_113_1)

	return
end

function ActivityProxy:PopBossRushAwards()
	self.bossrushAwards = nil

	return self.bossrushAwards or {}
end

function ActivityProxy:GetBossRushRuntime(arg_115_1)
	self.extraDatas[arg_115_1] = self.extraDatas[arg_115_1] or {
		record = 0,
		diff = 1
	}

	return self.extraDatas[arg_115_1]
end

function ActivityProxy:GetActivityBossRuntime(arg_116_1)
	self.extraDatas[arg_116_1] = self.extraDatas[arg_116_1] or {
		buffIds = {},
		spScore = {
			score = 0
		}
	}

	return self.extraDatas[arg_116_1]
end

function ActivityProxy:GetTaskActivities()
	local var_117_0 = {}

	table.Foreach(Activity.GetType2Class(), function(arg_118_0, arg_118_1)
		if not isa(arg_118_1, ITaskActivity) then
			return
		end

		table.insertto(var_117_0, self:getActivitiesByType(arg_118_0))

		return
	end)

	return var_117_0
end

function ActivityProxy:setSurveyState(arg_119_1)
	local var_119_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_SURVEY)

	if var_119_0 and not var_119_0:isEnd() then
		self.surveyState = arg_119_1

		if arg_119_1 > 0 then
			self:sendNotification(GAME.SURVEY_DONE, var_119_0)
		end
	end

	return
end

function ActivityProxy:isSurveyDone()
	local var_120_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_SURVEY)

	if var_120_0 and not var_120_0:isEnd() then
		return self.surveyState and self.surveyState > 0
	end

	return
end

function ActivityProxy:isSurveyOpen()
	local var_121_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_SURVEY)

	if var_121_0 and not var_121_0:isEnd() then
		local var_121_1 = var_121_0:getConfig("config_data")

		if var_121_1[1] == 1 then
			return var_121_1[2] <= getProxy(PlayerProxy):getData().level, (var_121_0:getConfig("config_id"))
		end
	end

	return
end

function ActivityProxy:GetActBossLinkPTActID(arg_122_1)
	local var_122_0 = table.Find(self.data, function(arg_123_0, arg_123_1)
		if arg_123_1:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_PT_BUFF then
			return
		end

		return arg_123_1:getDataConfig("link_id") == arg_122_1
	end)

	return var_122_0 and var_122_0.id
end

function ActivityProxy:CheckDailyEventRequest(arg_124_1)
	if arg_124_1:CheckDailyEventRequest() then
		self:sendNotification(GAME.SINGLE_EVENT_REFRESH, {
			actId = arg_124_1.id
		})
	end

	return
end

function ActivityProxy:IsTipLoveLetterMail()
	local var_125_0 = self:getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

	return var_125_0 and not var_125_0:isEnd() and var_125_0:readyToAchieve()
end

function ActivityProxy:GetBossRushActivities(arg_126_1)
	return _.select(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSSRUSH), function(arg_127_0)
		local var_127_0 = pg.activity_task_permanent[arg_127_0.id] ~= nil

		if arg_126_1 then
			return var_127_0 and not arg_127_0:isEnd()
		else
			return not var_127_0 and not arg_127_0:isEnd()
		end

		return
	end)
end

function ActivityProxy:GetBossRushActivitity(arg_128_1)
	return self:GetBossRushActivities(arg_128_1)[1]
end

function ActivityProxy:GetBossRushActivityById(arg_129_1)
	local var_129_0 = self:getActivityById(arg_129_1)

	if var_129_0 and var_129_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSRUSH and not var_129_0:isEnd() then
		return var_129_0
	end

	return nil
end

function ActivityProxy:GetBossActivityByChapterId(arg_130_1)
	for iter_130_0, iter_130_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSSRUSH))) do
		if not iter_130_1:isEnd() and table.contains(iter_130_1:getConfig("config_data"), arg_130_1) then
			return iter_130_1
		end
	end

	return nil
end

function ActivityProxy:GetFakeGiftPackActivity(arg_131_1)
	for iter_131_0, iter_131_1 in ipairs(self:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE,
		ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE
	})) do
		if switch(iter_131_1:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
				return not iter_131_1:isEnd() and iter_131_1.data1 < 1 and underscore.any(iter_131_1:getConfig("config_data")[1], function(arg_133_0)
					return pg.ship_skin_template[arg_133_0].shop_id == arg_131_1.id
				end)
			end,
			[ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
				local var_134_0 = pg.activity_giftpackage[iter_131_1:getConfig("config_id")]

				return not iter_131_1:isEnd() and iter_131_1.data1 < var_134_0.limit_count and underscore.any(var_134_0.skin, function(arg_135_0)
					return pg.ship_skin_template[arg_135_0].shop_id == arg_131_1.id
				end) and not underscore.all(var_134_0.skin, function(arg_136_0)
					return getProxy(ShipSkinProxy):hasNonLimitSkin(arg_136_0)
				end)
			end
		}, function()
			return
		end) then
			return iter_131_1
		end
	end

	return
end

return ActivityProxy
