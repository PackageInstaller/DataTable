local var_0_0 = class("Activity", import(".BaseVO"))
local var_0_1

function var_0_0.GetType2Class()
	if var_0_1 then
		return var_0_1
	end

	var_0_1 = {
		[ActivityConst.ACTIVITY_TYPE_HITMONSTERNIAN] = BeatMonterNianActivity,
		[ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT] = CollectionEventActivity,
		[ActivityConst.ACTIVITY_TYPE_RETURN_AWARD] = ReturnerActivity,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF] = BuildingBuffActivity,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2] = BuildingBuff2Activity,
		[ActivityConst.ACTIVITY_TYPE_ATELIER_LINK] = AtelierActivity,
		[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = ActivityBossActivity,
		[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = BossRushActivity,
		[ActivityConst.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK] = BossRushRankActivity,
		[ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB] = CollabrateBossRushActivity,
		[ActivityConst.ACTIVITY_TYPE_WORKBENCH] = WorkBenchActivity,
		[ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG] = VirtualBagActivity,
		[ActivityConst.ACTIVITY_TYPE_SCULPTURE] = SculptureActivity,
		[ActivityConst.ACTIVITY_TYPE_HOTSPRING] = SpringActivity,
		[ActivityConst.ACTIVITY_TYPE_HOTSPRING_2] = Spring2Activity,
		[ActivityConst.ACTIVITY_TYPE_TASK_RYZA] = ActivityTaskActivity,
		[ActivityConst.ACTIVITY_TYPE_PUZZLA] = PuzzleActivity,
		[ActivityConst.ACTIVITY_TYPE_SKIN_COUPON] = SkinCouponActivity,
		[ActivityConst.ACTIVITY_TYPE_MANUAL_SIGN] = ManualSignActivity,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = BossSingleActivity,
		[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = BossSingleVariableActivity,
		[ActivityConst.ACTIVITY_TYPE_EVENT_SINGLE] = SingleEventActivity,
		[ActivityConst.ACTIVITY_TYPE_LINER] = LinerActivity,
		[ActivityConst.ACTIVITY_TYPE_TOWN] = TownActivity,
		[ActivityConst.ACTIVITY_TYPE_TOWN2] = TownActivity2,
		[ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE] = AirFightActivity,
		[ActivityConst.ACTIVITY_TYPE_NOT_TRACEABLE] = NotTraceableTaskActivity,
		[ActivityConst.ACTIVITY_TYPE_HOLIDAY_VILLA] = VirtualBagActivity,
		[ActivityConst.ACTIVITY_TYPE_CITY_REBUILD] = VirtualBagActivity,
		[ActivityConst.ACTIVITY_TYPE_ISLAND_DRAW_AWARD] = DrawAwardActivity,
		[ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_UP] = LoveLetterActivity,
		[ActivityConst.ACTIVITY_TYPE_MALL] = MallActivity,
		[ActivityConst.ACTIVITY_TYPE_AUCTION_GAME] = AuctionGameActivity
	}

	return var_0_1
end

function var_0_0.Create(arg_2_0)
	local var_2_0 = var_0_0.GetType2Class()[pg.activity_template[arg_2_0.id].type] or Activity

	return var_2_0.New(arg_2_0)
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.configId = arg_3_0.id
	arg_3_0.stopTime = arg_3_1.stop_time
	arg_3_0.data1 = defaultValue(arg_3_1.data1, 0)
	arg_3_0.data2 = defaultValue(arg_3_1.data2, 0)
	arg_3_0.data3 = defaultValue(arg_3_1.data3, 0)
	arg_3_0.data4 = defaultValue(arg_3_1.data4, 0)
	arg_3_0.str_data1 = defaultValue(arg_3_1.str_data1, "")
	arg_3_0.data1_list = {}

	local var_3_0 = arg_3_1.data1_list or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(arg_3_0.data1_list, iter_3_1)
	end

	arg_3_0.data2_list = {}

	local var_3_1 = arg_3_1.data2_list or {}

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		table.insert(arg_3_0.data2_list, iter_3_3)
	end

	arg_3_0.data3_list = {}

	local var_3_2 = arg_3_1.data3_list or {}

	for iter_3_4, iter_3_5 in ipairs(var_3_2) do
		table.insert(arg_3_0.data3_list, iter_3_5)
	end

	arg_3_0.data4_list = {}

	local var_3_3 = arg_3_1.data4_list or {}

	for iter_3_6, iter_3_7 in ipairs(var_3_3) do
		table.insert(arg_3_0.data4_list, iter_3_7)
	end

	arg_3_0.data1KeyValueList = {}

	local var_3_4 = arg_3_1.date1_key_value_list or {}

	for iter_3_8, iter_3_9 in ipairs(var_3_4) do
		arg_3_0.data1KeyValueList[iter_3_9.key] = {}

		local var_3_5 = iter_3_9.value_list or {}

		for iter_3_10, iter_3_11 in ipairs(var_3_5) do
			arg_3_0.data1KeyValueList[iter_3_9.key][iter_3_11.key] = iter_3_11.value
		end
	end

	arg_3_0.buffList = {}

	local var_3_6 = arg_3_1.buff_list or {}

	for iter_3_12, iter_3_13 in ipairs(var_3_6) do
		table.insert(arg_3_0.buffList, ActivityBuff.New(arg_3_0.id, iter_3_13.id, iter_3_13.timestamp))
	end

	if arg_3_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP then
		arg_3_0.data2KeyValueList = {}

		local var_3_7 = arg_3_1.date1_key_value_list or {}

		for iter_3_14, iter_3_15 in ipairs(var_3_7) do
			arg_3_0.data2KeyValueList[iter_3_15.key] = {}
			arg_3_0.data2KeyValueList[iter_3_15.key].value = iter_3_15.value
			arg_3_0.data2KeyValueList[iter_3_15.key].dataMap = {}

			local var_3_8 = iter_3_15.value_list or {}

			for iter_3_16, iter_3_17 in ipairs(var_3_8) do
				arg_3_0.data2KeyValueList[iter_3_15.key].dataMap[iter_3_17.key] = iter_3_17.value
			end
		end
	end

	arg_3_0.clientData1 = 0
	arg_3_0.clientList = {}

	return
end

function var_0_0.GetBuffList(arg_4_0)
	return arg_4_0.buffList
end

function var_0_0.AddBuff(arg_5_0, arg_5_1)
	assert(isa(arg_5_1, ActivityBuff), "activityBuff should instance of ActivityBuff")
	table.insert(arg_5_0.buffList, arg_5_1)

	return
end

function var_0_0.setClientList(arg_6_0, arg_6_1)
	arg_6_0.clientList = arg_6_1

	return
end

function var_0_0.getClientList(arg_7_0)
	return arg_7_0.clientList
end

function var_0_0.updateDataList(arg_8_0, arg_8_1)
	table.insert(arg_8_0.data1_list, arg_8_1)

	return
end

function var_0_0.setDataList(arg_9_0, arg_9_1)
	arg_9_0.data1_list = arg_9_1

	return
end

function var_0_0.updateKVPList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.data1KeyValueList[arg_10_1] = arg_10_0.data1KeyValueList[arg_10_1] or {}
	arg_10_0.data1KeyValueList[arg_10_1][arg_10_2] = arg_10_3

	return
end

function var_0_0.getKVPList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.data1KeyValueList[arg_11_1] = arg_11_0.data1KeyValueList[arg_11_1] or {}

	return arg_11_0.data1KeyValueList[arg_11_1][arg_11_2] or 0
end

function var_0_0.getData1(arg_12_0)
	return arg_12_0.data1
end

function var_0_0.getData2(arg_13_0)
	return arg_13_0.data2
end

function var_0_0.getData3(arg_14_0)
	return arg_14_0.data3
end

function var_0_0.getStrData1(arg_15_0)
	return arg_15_0.str_data1
end

function var_0_0.getData1List(arg_16_0)
	return arg_16_0.data1_list
end

function var_0_0.bindConfigTable(arg_17_0)
	return pg.activity_template
end

function var_0_0.getDataConfigTable(arg_18_0)
	local var_18_0 = arg_18_0:getConfig("type")
	local var_18_1 = arg_18_0:getConfig("config_id")

	if var_18_0 == ActivityConst.ACTIVITY_TYPE_MONOPOLY then
		return pg.activity_event_monopoly[tonumber(var_18_1)]
	elseif var_18_0 == ActivityConst.ACTIVITY_TYPE_PIZZA_PT or var_18_0 == ActivityConst.ACTIVITY_TYPE_PT_BUFF then
		return pg.activity_event_pt[tonumber(var_18_1)]
	elseif var_18_0 == ActivityConst.ACTIVITY_TYPE_VOTE then
		return pg.activity_vote[tonumber(var_18_1)]
	end

	return
end

function var_0_0.getDataConfig(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getDataConfigTable()

	assert(var_19_0, "miss config : " .. arg_19_0.id)

	return var_19_0 and var_19_0[arg_19_1]
end

function var_0_0.getIslandConfigTable(arg_20_0)
	return pg.island_activity_template[arg_20_0.configId]
end

function var_0_0.getIslandConfig(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getIslandConfigTable()

	assert(var_21_0, "miss config : " .. arg_21_0.id)

	if var_21_0 then
		return var_21_0[arg_21_1] or arg_21_0:getConfig(arg_21_1)
	end
end

function var_0_0.isIslandShow(arg_22_0)
	return arg_22_0:getIslandConfigTable() and arg_22_0:getIslandConfig("is_show") > 0
end

function var_0_0.isEnd(arg_23_0)
	if arg_23_0.stopTime > 0 then
		local var_23_0 = pg.TimeMgr.GetInstance():GetServerTime() >= arg_23_0.stopTime

		return var_23_0
	end
end

function var_0_0.increaseUsedCount(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		arg_24_0.data1 = arg_24_0.data1 + 1
	elseif arg_24_1 == 2 then
		arg_24_0.data2 = arg_24_0.data2 + 1
	end

	return
end

function var_0_0.readyToAchieve(arg_25_0)
	local var_25_0, var_25_1 = arg_25_0:IsShowTipById()

	if var_25_0 then
		return var_25_1
	end

	local var_25_2 = var_0_0

	var_25_2.readyToAchieveDic = var_0_0.readyToAchieveDic or {
		[ActivityConst.ACTIVITY_TYPE_CARD_PAIRS] = function(arg_26_0)
			local var_26_0 = math.ceil(os.difftime(pg.TimeMgr.GetInstance():GetServerTime(), arg_26_0.data3) / 0)

			return var_26_0 > arg_26_0.data2 and arg_26_0.data2 < arg_26_0:getConfig("config_data")[4]
		end,
		[ActivityConst.ACTIVITY_TYPE_LEVELAWARD] = function(arg_27_0)
			local var_27_0 = getProxy(PlayerProxy):getRawData()
			local var_27_1 = pg.activity_level_award[arg_27_0:getConfig("config_id")]

			for iter_27_0 = 1, #var_27_1.front_drops do
				if var_27_1.front_drops[iter_27_0][1] <= var_27_0.level and not _.include(arg_27_0.data1_list, var_27_1.front_drops[iter_27_0][1]) then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_STORY_AWARD] = function(arg_28_0)
			local var_28_0 = getProxy(PlayerProxy):getRawData()
			local var_28_1 = pg.activity_event_chapter_award[arg_28_0:getConfig("config_id")]

			for iter_28_0 = 1, #var_28_1.chapter do
				local var_28_2 = getProxy(ChapterProxy)

				if var_28_2:isClear(var_28_1.chapter[iter_28_0]) and not _.include(arg_28_0.data1_list, var_28_1.chapter[iter_28_0]) then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_TASKS] = function(arg_29_0)
			local var_29_0 = arg_29_0:getConfig("config_client").subType

			if var_29_0 then
				return arg_29_0:activityTasksSubTypeFunc(var_29_0)
			end

			local var_29_1 = getProxy(TaskProxy)

			if IslandTaskActhelper.IsIslandTaskAct(arg_29_0) then
				return IslandTaskActhelper.ShouldTipIslandTask(arg_29_0)
			end

			if _.any(_.flatten(arg_29_0:getConfig("config_data")), function(arg_30_0)
				local var_30_0 = var_29_1:getTaskById(arg_30_0)

				return var_30_0 and var_30_0:isFinish() and not var_30_0:isReceive()
			end) then
				return true
			end

			local var_29_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

			if var_29_2 and not var_29_2:isEnd() and var_29_2:getConfig("config_client").linkActID == arg_29_0.id and var_29_2:readyToAchieve() then
				return true
			end

			if arg_29_0:getConfig("config_client") and arg_29_0:getConfig("config_client").decodeGameId then
				local var_29_3 = getProxy(MiniGameProxy):GetHubByGameId(arg_29_0:getConfig("config_client").decodeGameId)

				if var_29_3 then
					local var_29_4 = arg_29_0:getConfig("config_data")

					if var_29_3.ultimate <= 0 and _.all(var_29_4[#var_29_4], function(arg_31_0)
						local var_31_0 = getProxy(TaskProxy)

						return var_31_0:getFinishTaskById(arg_31_0) ~= nil
					end) then
						return true
					end
				end
			end

			if arg_29_0:getConfig("config_client") and arg_29_0:getConfig("config_client").linkTaskPoolAct then
				local var_29_5 = getProxy(ActivityProxy):getActivityById(arg_29_0:getConfig("config_client").linkTaskPoolAct)

				if var_29_5 and var_29_5:readyToAchieve() then
					return true
				end
			end

			if arg_29_0:getConfig("config_client") and arg_29_0:getConfig("config_client").link_act then
				local var_29_6 = getProxy(ActivityProxy):getActivityById(arg_29_0:getConfig("config_client").link_act)

				if var_29_6 and var_29_6:readyToAchieve() then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_TASK_LIST] = function(...)
			return var_0_0.readyToAchieveDic[ActivityConst.ACTIVITY_TYPE_TASKS](...)
		end,
		[ActivityConst.ACTIVITY_TYPE_HITMONSTERNIAN] = function(arg_33_0)
			local var_33_0 = arg_33_0:GetCountForHitMonster()

			return arg_33_0:GetDataConfig("hp") > arg_33_0.data3 and var_33_0 > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_DODGEM] = function(arg_34_0)
			local var_34_0 = pg.TimeMgr.GetInstance()
			local var_34_1 = var_34_0:DiffDay(arg_34_0.data1, var_34_0:GetServerTime()) + 1
			local var_34_2 = arg_34_0:getConfig("config_id")

			if var_34_2 == 1 then
				return arg_34_0.data4 == 0 and arg_34_0.data2 >= 7 or defaultValue(arg_34_0.data2_list[1], 0) > 0 or defaultValue(arg_34_0.data2_list[2], 0) > 0 or arg_34_0.data2 < math.min(var_34_1, 7) or var_34_1 > arg_34_0.data3
			elseif var_34_2 == 2 then
				return arg_34_0.data4 == 0 and arg_34_0.data2 >= 7 or defaultValue(arg_34_0.data2_list[1], 0) > 0 or defaultValue(arg_34_0.data2_list[2], 0) > 0 or arg_34_0.data2 < math.min(var_34_1, 7)
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_MONOPOLY] = function(arg_35_0)
			local var_35_0 = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_35_0.data1) / 0)

			return var_35_0 * arg_35_0:getDataConfig("daily_time") + arg_35_0.data1_list[1] - arg_35_0.data1_list[2] > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_PIZZA_PT] = function(arg_36_0)
			local var_36_0 = ActivityPtData.New(arg_36_0):CanGetAward()
			local var_36_1 = true

			if arg_36_0:getConfig("config_client") then
				local var_36_2 = arg_36_0:getConfig("config_client").task_act_id

				if var_36_2 and var_36_2 ~= 0 and pg.activity_template[var_36_2] then
					local var_36_3 = _.flatten(pg.activity_template[var_36_2].config_data)

					if var_36_3 and #var_36_3 > 0 then
						local var_36_4 = getProxy(TaskProxy)

						for iter_36_0 = 1, #var_36_3 do
							local var_36_5 = var_36_4:getTaskById(var_36_3[iter_36_0])

							if var_36_5 and var_36_5:isFinish() then
								return true
							end
						end
					end
				end
			end

			local var_36_6 = false
			local var_36_7 = arg_36_0:getConfig("config_client").fireworkActID

			if var_36_7 and var_36_7 ~= 0 then
				local var_36_8 = getProxy(ActivityProxy):getActivityById(var_36_7)

				var_36_6 = var_36_8 and var_36_8:readyToAchieve() or false
			end

			local var_36_9 = arg_36_0:getConfig("config_client")[2]
			local var_36_10 = type(var_36_9) == "number" and ManualSignActivity.IsManualSignActAndAnyAwardCanGet(var_36_9)

			return var_36_0 and var_36_1 or var_36_6 or var_36_10
		end,
		[ActivityConst.ACTIVITY_TYPE_PT_BUFF] = function(...)
			return var_0_0.readyToAchieveDic[ActivityConst.ACTIVITY_TYPE_PIZZA_PT](...)
		end,
		[ActivityConst.ACTIVITY_TYPE_RETURN_AWARD] = function(arg_38_0)
			if arg_38_0.data1 == 1 then
				local var_38_0 = pg.activity_template_headhunting[arg_38_0.id]
				local var_38_1 = pg.activity_template_headhunting[arg_38_0.id].target
				local var_38_2 = 0

				for iter_38_0, iter_38_1 in ipairs(arg_38_0:getClientList()) do
					var_38_2 = var_38_2 + iter_38_1:getPt()
				end

				local var_38_3 = 0

				for iter_38_2 = #var_38_1, 1, -1 do
					if table.contains(arg_38_0.data1_list, var_38_1[iter_38_2]) then
						var_38_3 = iter_38_2

						break
					end
				end

				local var_38_4 = var_38_0.drop_client
				local var_38_5 = _.any(var_38_0.tasklist, function(arg_39_0)
					local var_39_0 = getProxy(TaskProxy):getTaskById(arg_39_0)

					return var_39_0 and var_39_0:isFinish() and not var_39_0:isReceive()
				end)

				return var_38_2 >= var_38_1[math.min(var_38_3 + 1, #var_38_0.drop_client)] and var_38_3 ~= #var_38_4 or var_38_5
			elseif arg_38_0.data1 == 2 then
				local var_38_6 = getProxy(TaskProxy)

				return _.any(_.flatten(pg.activity_template_returnner[arg_38_0.id].task_list), function(arg_40_0)
					local var_40_0 = var_38_6:getTaskById(arg_40_0)

					return var_40_0 and var_40_0:isFinish()
				end)
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_MINIGAME] = function(arg_41_0)
			local var_41_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_41_0:getConfig("config_id"))

			if var_41_0.count > 0 then
				return true
			end

			if var_41_0:getConfig("reward") ~= 0 and var_41_0.usedtime >= var_41_0:getConfig("reward_need") and var_41_0.ultimate == 0 then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_TURNTABLE] = function(arg_42_0)
			local var_42_0 = pg.activity_event_turning[arg_42_0:getConfig("config_id")]

			if arg_42_0.data4 ~= 0 then
				local var_42_1 = getProxy(TaskProxy)

				for iter_42_0, iter_42_1 in ipairs(var_42_0.task_table[arg_42_0.data4]) do
					local var_42_2 = var_42_1:getTaskById(iter_42_1) or var_42_1:getFinishTaskById(iter_42_1)

					if var_42_2:getTaskStatus() == 1 then
						return true
					end
				end

				if math.clamp(pg.TimeMgr.GetInstance():DiffDay(arg_42_0.data1, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, pg.activity_event_turning[arg_42_0:getConfig("config_id")].total_num) > arg_42_0.data3 then
					for iter_42_2, iter_42_3 in ipairs(var_42_0.task_table[arg_42_0.data4]) do
						local var_42_3 = var_42_1:getTaskById(iter_42_3) or var_42_1:getFinishTaskById(iter_42_3)

						if var_42_3:getTaskStatus() ~= 2 then
							return false
						end
					end

					return true
				end
			elseif arg_42_0.data4 == 0 then
				if math.clamp(pg.TimeMgr.GetInstance():DiffDay(arg_42_0.data1, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, pg.activity_event_turning[arg_42_0:getConfig("config_id")].total_num) > arg_42_0.data3 then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_LOTTERY_AWARD] = function(arg_43_0)
			return arg_43_0.data2 <= 0
		end,
		[ActivityConst.ACTIVITY_TYPE_SHRINE] = function(arg_44_0)
			local var_44_0 = arg_44_0:getConfig("config_client").story

			if var_44_0 then
				local var_44_1 = #var_44_0 or 7
				local var_44_2 = pg.TimeMgr.GetInstance()
				local var_44_3 = math.clamp(var_44_2:DiffDay(arg_44_0.data3, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, var_44_1)

				if var_44_0 then
					local var_44_4 = pg.NewStoryMgr.GetInstance()
					local var_44_5 = math.clamp(arg_44_0.data2, 0, var_44_1)

					for iter_44_0 = 1, var_44_3 do
						if var_44_0[iter_44_0][1] and iter_44_0 <= var_44_5 and not var_44_4:IsPlayed(var_44_0[iter_44_0][1]) then
							return true
						end
					end
				end

				if var_44_1 <= var_44_3 and var_44_1 <= arg_44_0.data2 and arg_44_0.data1 <= 0 then
					return true
				end

				if Shrine2022View.IsNeedShowTipForShipCount() then
					return true
				end

				return false
			end
		end,
		[ActivityConst.ACTIVITY_TYPE_LINK_LINK] = function(arg_45_0)
			local var_45_0 = pg.TimeMgr.GetInstance()

			return math.clamp(var_45_0:DiffDay(arg_45_0.data3, var_45_0:GetServerTime()) + 1 - arg_45_0.data2, 0, #arg_45_0:getConfig("config_client")[3] - arg_45_0.data2) > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF] = function(arg_46_0)
			for iter_46_0, iter_46_1 in ipairs((arg_46_0:GetBuildingIds())) do
				local var_46_0 = arg_46_0:GetBuildingLevel(iter_46_1)

				if pg.activity_event_building[iter_46_1] and var_46_0 < #pg.activity_event_building[iter_46_1].buff and underscore.all(pg.activity_event_building[iter_46_1].material[var_46_0], function(arg_47_0)
					local var_47_0 = arg_47_0[2]
					local var_47_1 = arg_47_0[3]
					local var_47_2 = 0

					if arg_47_0[1] == DROP_TYPE_VITEM then
						assert(AcessWithinNull(Item.getConfigData(var_47_0), "link_id") == arg_46_0.id)

						var_47_2 = arg_46_0:GetMaterialCount(var_47_0)
					elseif arg_47_0[1] > DROP_TYPE_USE_ACTIVITY_DROP then
						local var_47_3 = AcessWithinNull(pg.activity_drop_type[arg_47_0[1]], "activity_id")

						assert(var_47_3)

						bagAct = getProxy(ActivityProxy):getActivityById(var_47_3)
						var_47_2 = bagAct:getVitemNumber(var_47_0)
					end

					return var_47_1 <= var_47_2
				end) then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2] = function(arg_48_0, ...)
			return var_0_0.readyToAchieveDic[ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF](arg_48_0, ...) or arg_48_0:CanRequest()
		end,
		[ActivityConst.ACTIVITY_TYPE_EXPEDITION] = function(arg_49_0)
			if arg_49_0.data3 > 0 and arg_49_0.data1 ~= 0 then
				return true
			else
				for iter_49_0 = 1, #arg_49_0.data1_list do
					if not bit.band(arg_49_0.data1_list[iter_49_0], ActivityConst.EXPEDITION_TYPE_GOT) ~= 0 then
						if bit.band(arg_49_0.data1_list[iter_49_0], ActivityConst.EXPEDITION_TYPE_OPEN) ~= 0 then
							return true
						elseif bit.band(arg_49_0.data1_list[iter_49_0], ActivityConst.EXPEDITION_TYPE_BAOXIANG) ~= 0 then
							return true
						elseif bit.band(arg_49_0.data1_list[iter_49_0], ActivityConst.EXPEDITION_TYPE_BOSS) ~= 0 then
							return true
						end
					end
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_CLIENT_DISPLAY] = function(arg_50_0)
			local var_50_0 = arg_50_0:getConfig("config_client")

			if var_50_0 and var_50_0.linkGameHubID then
				local var_50_1 = getProxy(MiniGameProxy):GetHubByHubId(var_50_0.linkGameHubID)

				if var_50_1 then
					if var_50_0.trimRed then
						if var_50_1.ultimate == 1 then
							return false
						end

						if var_50_1.usedtime == var_50_1:getConfig("reward_need") then
							return true
						end
					end

					return var_50_1.count > 0
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_BB] = function(arg_51_0)
			return arg_51_0.data2 > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_PUZZLA] = function(arg_52_0)
			local var_52_0 = arg_52_0.data1_list
			local var_52_1 = arg_52_0.data2_list
			local var_52_2 = arg_52_0:getConfig("config_client").linkActID

			if var_52_2 then
				local var_52_3 = getProxy(ActivityProxy):getActivityById(var_52_2)

				if var_52_3 and var_52_3:readyToAchieve() then
					return true
				end
			end

			if _.any(arg_52_0:GetPicturePuzzleIds(), function(arg_53_0)
				local var_53_0 = table.contains(var_52_0, arg_53_0)

				return not table.contains(var_52_1, arg_53_0) and var_53_0
			end) then
				return true
			end

			local var_52_4 = pg.activity_event_picturepuzzle[arg_52_0.id]

			if pg.activity_event_picturepuzzle[arg_52_0.id] and var_52_4.chapter > 0 and arg_52_0.data1 < 1 then
				return true
			end

			if var_52_4 and #var_52_4.auto_finish_args > 0 and arg_52_0.data1 == 1 then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE] = function(arg_54_0)
			return AirFightActivity.readyToAchieve(arg_54_0)
		end,
		[ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE] = function(arg_55_0)
			local var_55_0 = WorldInPictureActiviyData.New(arg_55_0)

			return not var_55_0:IsTravelAll() and var_55_0:GetTravelPoint() > 0 or var_55_0:GetDrawPoint() > 0 and var_55_0:AnyAreaCanDraw()
		end,
		[ActivityConst.ACTIVITY_TYPE_APRIL_REWARD] = function(arg_56_0)
			if arg_56_0.data1 == 0 then
				if arg_56_0:getConfig("config_client").autounlock <= pg.TimeMgr.GetInstance():GetServerTime() - arg_56_0:getStartTime() then
					return true
				end
			elseif arg_56_0.data1 ~= 0 and arg_56_0.data2 == 0 then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_TASK_POOL] = function(arg_57_0)
			local var_57_0 = arg_57_0:getConfig("config_data")
			local var_57_1 = getProxy(TaskProxy)

			if arg_57_0.data1 >= #var_57_0 then
				return false
			end

			local var_57_2 = pg.TimeMgr.GetInstance()
			local var_57_3 = (var_57_2:DiffDay(arg_57_0:getStartTime(), var_57_2:GetServerTime()) + 1) * arg_57_0:getConfig("config_id")

			var_57_3 = var_57_3 > #var_57_0 and #var_57_0 or var_57_3

			local var_57_4 = _.any(var_57_0, function(arg_58_0)
				local var_58_0 = var_57_1:getTaskById(arg_58_0)

				return var_58_0 and var_58_0:isFinish()
			end)

			return var_57_3 - arg_57_0.data1 > 0 and var_57_4
		end,
		[ActivityConst.ACTIVITY_TYPE_EVENT] = function(arg_59_0)
			local var_59_0 = getProxy(PlayerProxy)

			return PlayerPrefs.GetInt("ACTIVITY_TYPE_EVENT_" .. arg_59_0.id .. "_" .. var_59_0:getData().id) == 0
		end,
		[ActivityConst.ACTIVITY_TYPE_PT_OTHER] = function(arg_60_0)
			if arg_60_0.data2 and arg_60_0.data2 <= 0 and arg_60_0.data1 >= pg.activity_event_avatarframe[arg_60_0:getConfig("config_id")].target then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_HOTSPRING] = function(arg_61_0)
			local var_61_0, var_61_1 = arg_61_0:GetUpgradeCost()

			if arg_61_0:GetSlotCount() < arg_61_0:GetTotalSlotCount() and var_61_1 <= arg_61_0:GetCoins() then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_FIREWORK] = function(arg_62_0)
			if arg_62_0.data1 > 0 and arg_62_0:getConfig("config_data")[2][2] <= getProxy(PlayerProxy):getRawData():getResource(arg_62_0:getConfig("config_data")[2][1]) then
				return true
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_FLOWER_FIELD] = function(arg_63_0)
			local var_63_0 = pg.TimeMgr.GetInstance()

			return var_63_0:GetServerTime() >= var_63_0:GetTimeToNextTime(math.max(arg_63_0.data1, arg_63_0.data2))
		end,
		[ActivityConst.ACTIVITY_TYPE_ISLAND] = function(arg_64_0)
			for iter_64_0, iter_64_1 in pairs(getProxy(SixthAnniversaryIslandProxy):GetNodeDic()) do
				if iter_64_1:IsVisual() and iter_64_1:RedDotHint() then
					return true
				end
			end

			return false
		end,
		[ActivityConst.ACTIVITY_TYPE_HOTSPRING_2] = function(arg_65_0)
			return Spring2Activity.readyToAchieve(arg_65_0)
		end,
		[ActivityConst.ACTIVITY_TYPE_CARD_PUZZLE] = function(arg_66_0)
			local var_66_0 = #arg_66_0.data2_list

			if #arg_66_0:getData1List() == #arg_66_0:getConfig("config_data")[2] then
				return false
			end

			return (function()
				for iter_67_0, iter_67_1 in ipairs(var_0) do
					if not table.contains(var_0, iter_67_1[1]) and var_66_0 >= iter_67_1[1] then
						return true
					end
				end

				return false
			end)() or (function()
				local var_68_0 = getProxy(PlayerProxy)

				return PlayerPrefs.GetInt("DAY_TIP_" .. arg_66_0.id .. "_" .. var_68_0:getData().id .. "_" .. arg_66_0:getDayIndex()) == 0
			end)()
		end,
		[ActivityConst.ACTIVITY_TYPE_SURVEY] = function(arg_69_0)
			local var_69_0, var_69_1 = getProxy(ActivityProxy):isSurveyOpen()

			return var_69_0 and not getProxy(ActivityProxy):isSurveyDone() and not SurveyPage.IsEverEnter(var_69_1)
		end,
		[ActivityConst.ACTIVITY_TYPE_ZUMA] = function(arg_70_0)
			return LaunchBallActivityMgr.GetInvitationAble(arg_70_0.id)
		end,
		[ActivityConst.ACTIVITY_TYPE_GIFT_UP] = function(arg_71_0)
			local var_71_0 = arg_71_0:getConfig("config_client").gifts[2]

			return underscore(var_71_0):chain():first((math.min(#var_71_0, arg_71_0:getNDay()))):any(function(arg_72_0)
				local var_72_0 = getProxy(ShopsProxy):GetGiftCommodity(arg_72_0, Goods.TYPE_GIFT_PACKAGE)

				return var_72_0:canPurchase() and var_72_0:inTime() and not var_72_0:IsGroupLimit()
			end):value()
		end,
		[ActivityConst.ACTIVITY_TYPE_UR_EXCHANGE] = function(arg_73_0)
			local var_73_9000

			if getProxy(ShopsProxy):getActivityShops() == nil then
				return false
			end

			local var_73_0 = arg_73_0:getConfig("config_client")
			local var_73_1 = getProxy(PlayerProxy):getData()
			local var_73_2 = var_73_1.getResource(var_73_9000, var_73_0.uPtId)
			local var_73_3 = #var_73_0.goodsId + 1
			local var_73_4 = #var_73_0.goodsId + 1 - _.reduce(var_73_0.goodsId, 0, function(arg_74_0, arg_74_1)
				return arg_74_0 + getProxy(ShopsProxy):getActivityShopById(var_73_0.shopId):GetCommodityById(arg_74_1):GetPurchasableCnt()
			end)

			if var_73_1 < #var_73_0.goodsId + 1 then
				local var_73_5 = pg.activity_shop_template[var_73_0.goodsId[var_73_4]] or nil

				return var_73_4 < var_73_3 and var_73_2 >= var_73_5.resource_num
			end
		end,
		[ActivityConst.ACTIVITY_TYPE_SKIN_COUPON_COUNTING] = function(arg_75_0)
			return arg_75_0:getData1() > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_DAILY_STAGE_BONUS] = function(arg_76_0)
			return arg_76_0:NeedLoginRedPoint()
		end,
		[ActivityConst.ACTIVITY_TYPE_TASK_RYZA] = function(arg_77_0)
			for iter_77_0, iter_77_1 in ipairs((getProxy(ActivityTaskProxy):getTaskById(arg_77_0.id))) do
				if iter_77_1:getTaskStatus() == 1 then
					return true
				end
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_MINIGAME] = function(arg_78_0)
			if getProxy(MiniGameProxy):GetHubByHubId((arg_78_0:getConfig("config_id"))).count > 0 then
				return true
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_7DAYSLOGIN] = function(arg_79_0)
			local var_79_0 = pg.TimeMgr.GetInstance()
			local var_79_1 = var_79_0:GetServerTime()

			return arg_79_0.data1 < #pg.activity_7_day_sign[arg_79_0:getConfig("config_id")].front_drops and not var_79_0:IsSameDay(var_79_1, arg_79_0.data2) and var_79_1 > arg_79_0.data2
		end,
		[ActivityConst.ACTIVITY_TYPE_PT_HEI5] = function(arg_80_0)
			return #arg_80_0:GetHei5UnreceiveAward() > 0
		end,
		[ActivityConst.ACTIVITY_TYPE_TownSkinStory] = function(arg_81_0)
			local var_81_0 = pg.NewStoryMgr.GetInstance()

			if arg_81_0.data1 > 0 and underscore.any(arg_81_0:GetConfigClientSetting("story"), function(arg_82_0)
				return not var_81_0:IsPlayed(arg_82_0[1])
			end) then
				return true
			end

			return
		end,
		[ActivityConst.ACTIVITY_TYPE_MANUAL_SIGN] = function(arg_83_0)
			return arg_83_0:CanGetAward()
		end,
		[ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL] = function(arg_84_0)
			local var_84_0 = getProxy(PlayerProxy):getRawData().level

			return var_84_0 >= arg_84_0:getConfig("config_id") and arg_84_0.data1 == 0
		end,
		[ActivityConst.ACTIVITY_TYPE_ISLAND_GAME_PT] = function(arg_85_0)
			local var_85_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

			return IslandGamePtTemplatePage.ShouldFirstTip(arg_85_0.id) or _.any(pg.island_activity_pt_page[arg_85_0:getIslandConfig("config_id")].task_id, function(arg_86_0)
				local var_86_0 = var_85_0:GetTask(arg_86_0)

				return var_86_0 and var_86_0:IsFinish() and not var_85_0:IsFinishTask(arg_86_0)
			end)
		end,
		[ActivityConst.ACTIVITY_TYPE_ISLAND_CHEATE_TAVERN] = function(arg_87_0)
			for iter_87_0, iter_87_1 in ipairs((getProxy(ActivityTaskProxy):getTaskById(ActivityConst.ISLAND_BAR_ACT_ID))) do
				if iter_87_1:getTaskStatus() == 1 then
					return true
				end
			end

			return false
		end
	}

	if switch(arg_25_0:getConfig("type"), var_0_0.readyToAchieveDic, nil, arg_25_0) then
		return true
	elseif arg_25_0:getConfig("config_client").sub_act_id then
		local var_25_3 = getProxy(ActivityProxy):getActivityById(arg_25_0:getConfig("config_client").sub_act_id)

		return var_25_3 and not var_25_3:isEnd() and var_25_3:readyToAchieve()
	elseif arg_25_0:getConfig("config_client").is_showMedal then
		return ActivityMedalGroup.showTip(arg_25_0:getConfig("config_client").medal_group_id)
	elseif arg_25_0:getConfig("config_client").is_clickOnce then
		local var_25_4 = arg_25_0:getConfig("id")

		return PlayerPrefs.GetInt(Activity.GetPlayerActivyIDKey(arg_25_0:getConfig("id")), 0) == 0
	else
		return false
	end

	return
end

function var_0_0.IsShowTipById(arg_88_0)
	var_0_0.ShowTipTableById = var_0_0.ShowTipTableById or {
		[ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE] = function(arg_89_0)
			local var_89_0 = getProxy(SkirmishProxy)

			var_89_0:UpdateSkirmishProgress()

			local var_89_1 = 0
			local var_89_2 = 0

			for iter_89_0, iter_89_1 in ipairs((var_89_0:getRawData())) do
				local var_89_3 = iter_89_1:GetState()

				var_89_1 = var_89_3 > SkirmishVO.StateInactive and var_89_1 + 1 or var_89_1
				var_89_2 = var_89_3 == SkirmishVO.StateClear and var_89_2 + 1 or var_89_2
			end

			return var_89_2 < var_89_1
		end,
		[ActivityConst.POCKY_SKIN_LOGIN] = function(arg_90_0)
			local var_90_0 = arg_90_0:getConfig("config_client").linkids
			local var_90_1 = getProxy(TaskProxy)
			local var_90_2 = getProxy(ActivityProxy)
			local var_90_3 = var_90_2:getActivityById(var_90_0[2])
			local var_90_4 = var_90_2:getActivityById(var_90_0[3])

			assert(var_90_2:getActivityById(var_90_0[1]) and var_90_2:getActivityById(var_90_0[2]) and var_90_2:getActivityById(var_90_0[3]))

			return (function()
				local var_93_0 = _.flatten(arg_90_0:getConfig("config_data"))

				for iter_93_0 = 1, math.min(#var_93_0, var_90_3.data3) do
					local var_93_1 = var_90_1:getTaskById(var_93_0[iter_93_0])

					if var_93_1 and var_93_1:isFinish() and not var_93_1:isReceive() then
						return true
					end
				end

				return
			end)() or (function()
				return var_0 and var_0:readyToAchieve()
			end)() or (function()
				return var_90_3 and var_90_3:readyToAchieve()
			end)() or (function()
				local var_94_0 = var_90_4 and var_90_4:readyToAchieve()

				if not var_94_0 or not var_0 then
					return false
				end

				local var_94_1 = ActivityPtData.New(var_0)

				return var_94_1.level >= #var_94_1.targets
			end)()
		end,
		[ActivityConst.TOWERCLIMBING_SIGN] = function(arg_95_0)
			local var_95_0 = getProxy(MiniGameProxy):GetHubByHubId(9)
			local var_95_1 = var_95_0:getConfig("reward_need")
			local var_95_2 = var_95_0.usedtime

			return var_95_0.ultimate == 0 and var_95_1 <= var_95_2
		end,
		[pg.activity_const.NEWYEAR_SNACK_PAGE_ID.act_id] = NewYearSnackPage.IsTip,
		[ActivityConst.WWF_TASK_ID] = WWFPtPage.IsShowRed,
		[ActivityConst.NEWMEIXIV4_SKIRMISH_ID] = NewMeixiV4SkirmishPage.IsShowRed,
		[ActivityConst.JIUJIU_YOYO_ID] = JiujiuYoyoPage.IsShowRed,
		[ActivityConst.SENRANKAGURA_TRAIN_ACT_ID] = SenrankaguraTrainScene.IsShowRed,
		[ActivityConst.DORM_SIGN_ID] = DormSignPage.IsShowRed,
		[ActivityConst.DORM_SIGN_ID_2] = DormSignTwoPage.IsShowRed,
		[ActivityConst.DORM_SIGN_ID_3] = DormSignThirdPage.IsShowRed,
		[ActivityConst.ISLAND_SIGN_ID] = IslandSignPage.IsShowRed,
		[ActivityConst.GOASTSTORYACTIVITY_ID] = GhostSkinPageLayer.IsShowRed,
		[ActivityConst.YUMIA_BASE_ACT_ID] = YoumiyaStrongholdLayer.ShouldShowTip,
		[ActivityConst.NINJA_CITY_MAIN_ACTIVITY_ID] = function(arg_96_0)
			if CityRebuildBookLayer.ShouldShowTip() or CityRebuildTasksLayer.ShouldShowTip() then
				return true
			end

			return false
		end,
		[ActivityConst.MALL_MAIN_ACTIVITY_ID] = function(arg_97_0)
			return AnniversaryNineMainPage.IsTip()
		end,
		[ActivityConst.SAILING_SHIP_3_SKIN_ACT_ID] = SailingShip3SkinLayer.ShouldShowTip,
		[ActivityConst.HelenaPT_ACT_ID] = function(arg_98_0)
			return HelenaScenarioPage:IsShowRed(arg_98_0)
		end,
		[ActivityConst.LOVE_LETTER_LOGIN_ID] = function(arg_99_0)
			for iter_99_0 = 1, arg_99_0:getNDay() do
				local var_99_0 = arg_99_0:getConfig("config_data")[iter_99_0]

				if var_99_0 then
					local var_99_1 = getProxy(TaskProxy):getTaskVO(var_99_0) or nil

					if var_99_1 and var_99_1:getTaskStatus() == 1 then
						return true
					end
				end
			end

			return false
		end
	}

	return tobool(var_0_0.ShowTipTableById[arg_88_0.id]), var_0_0.ShowTipTableById[arg_88_0.id] and var_0_0.ShowTipTableById[arg_88_0.id](arg_88_0)
end

function var_0_0.activityTasksSubTypeFunc(arg_100_0, arg_100_1)
	if arg_100_1 == 1 then
		local var_100_0 = 1
		local var_100_1 = getProxy(TaskProxy)
		local var_100_2 = arg_100_0:getConfig("config_client").unlock_task
		local var_100_3 = math.min(arg_100_0:getNDay(), #var_100_2)

		for iter_100_0 = 1, var_100_3 do
			if not true then
				break
			end

			var_100_0 = iter_100_0

			if iter_100_0 < var_100_3 then
				for iter_100_1, iter_100_2 in ipairs(var_100_2[iter_100_0]) do
					local var_100_4 = var_100_1:getTaskById(iter_100_2) or var_100_1:getFinishTaskById(iter_100_2)
					local var_100_5

					if not var_100_4 or var_100_4:getTaskStatus() ~= 2 then
						var_100_5 = false

						break
					end
				end
			end
		end

		for iter_100_3, iter_100_4 in ipairs(var_100_2[math.min(var_100_0, #var_100_2)]) do
			local var_100_6 = var_100_1:getTaskById(iter_100_4) or var_100_1:getFinishTaskById(iter_100_4)

			if not var_100_6 then
				return false
			end

			if var_100_6:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isShow(arg_101_0)
	if LOCK_SKIN_US then
		if pg.gameset.levellimit_skinstory.key_value >= getProxy(PlayerProxy):getRawData().level and table.contains(pg.gameset.levellimit_skinstory.description, arg_101_0.id) then
			return false
		end
	end

	local var_101_0 = arg_101_0:getConfig("page_info")

	if arg_101_0:getConfig("is_show") <= 0 then
		return false
	elseif underscore.any({
		var_101_0.ui_name,
		var_101_0.ui_name2
	}, function(arg_102_0)
		return not checkABExist(string.format("ui/%s", arg_102_0))
	end) then
		warning(string.format("activity:%d without ui:%s", arg_101_0.id, table.concat({
			var_101_0.ui_name,
			var_101_0.ui_name2
		}, " or ")))

		return false
	end

	if arg_101_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_RETURN_AWARD then
		return arg_101_0.data1 ~= 0
	elseif arg_101_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_CLIENT_DISPLAY then
		local var_101_1 = arg_101_0:getConfig("config_client").display_link

		if var_101_1 then
			return underscore.any(var_101_1, function(arg_103_0)
				return arg_103_0[2] == 0 or pg.TimeMgr.GetInstance():inTime(pg.shop_template[arg_103_0[2]].time)
			end)
		end
	elseif arg_101_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SURVEY then
		local var_101_2 = getProxy(ActivityProxy)

		return var_101_2:isSurveyOpen() and not var_101_2:isSurveyDone()
	elseif arg_101_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_UR_EXCHANGE then
		if getProxy(ShopsProxy):getActivityShops() == nil then
			return false
		end

		local var_101_3 = arg_101_0:getConfig("config_client")
		local var_101_4 = getProxy(PlayerProxy):getData():getResource(var_101_3.uPtId)

		return #var_101_3.goodsId + 1 > #var_101_3.goodsId + 1 - _.reduce(var_101_3.goodsId, 0, function(arg_104_0, arg_104_1)
			return arg_104_0 + getProxy(ShopsProxy):getActivityShopById(var_101_3.shopId):GetCommodityById(arg_104_1):GetPurchasableCnt()
		end)
	elseif arg_101_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TASK_RYZA and table.contains({
		ActivityConst.DORM_SIGN_ID,
		ActivityConst.DORM_SIGN_ID_2,
		ActivityConst.DORM_SIGN_ID_3
	}, arg_101_0:getConfig("id")) then
		local var_101_5 = getProxy(ActivityProxy):getActivityById(arg_101_0:getConfig("id"))
		local var_101_6 = getProxy(ActivityTaskProxy)

		return #var_101_5:getConfig("config_data") ~= #var_101_6:getFinishTaskById(arg_101_0:getConfig("id"))
	end

	return true
end

function var_0_0.isAfterShow(arg_105_0)
	if arg_105_0.configId == ActivityConst.ISLAND_SIGN_ID then
		local var_105_0 = getProxy(ActivityTaskProxy):GetActivityTasks(arg_105_0.id)

		return _.all(_.flatten(arg_105_0:getConfig("config_data")), function(arg_106_0)
			return var_105_0[arg_106_0] and var_105_0[arg_106_0]:isOver()
		end)
	end

	if arg_105_0.configId == ActivityConst.UR_TASK_ACT_ID or arg_105_0.configId == ActivityConst.SPECIAL_WEAPON_ACT_ID then
		local var_105_1 = getProxy(TaskProxy)

		return underscore.all(arg_105_0:getConfig("config_data")[1], function(arg_107_0)
			local var_107_0 = var_105_1:getTaskVO(arg_107_0)

			return var_107_0 and var_107_0:isReceive()
		end)
	end

	return false
end

function var_0_0.getShowPriority(arg_108_0)
	return arg_108_0:getConfig("is_show")
end

function var_0_0.isCorePage(arg_109_0, arg_109_1)
	return arg_109_0:getConfig("page_core") == arg_109_1
end

function var_0_0.left4Day(arg_110_0)
	if arg_110_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
		return true
	end

	return false
end

function var_0_0.getAwardInfos(arg_111_0)
	return arg_111_0.data1KeyValueList or {}
end

function var_0_0.updateData(arg_112_0, arg_112_1, arg_112_2)
	if arg_112_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LOTTERY then
		if not arg_112_0:getAwardInfos()[arg_112_1] then
			arg_112_0.data1KeyValueList[arg_112_1] = {}
		end

		for iter_112_0, iter_112_1 in ipairs(arg_112_2) do
			arg_112_0.data1KeyValueList[arg_112_1][iter_112_1] = arg_112_0.data1KeyValueList[arg_112_1][iter_112_1] and arg_112_0.data1KeyValueList[arg_112_1][iter_112_1] + 1 or 1
		end
	end

	return
end

function var_0_0.getTaskShip(arg_113_0)
	return arg_113_0:getConfig("config_client")[1]
end

function var_0_0.getNotificationMsg(arg_114_0)
	local var_114_0 = arg_114_0:getConfig("type")
	local var_114_1 = ActivityProxy.ACTIVITY_SHOW_AWARDS

	if var_114_0 == ActivityConst.ACTIVITY_TYPE_SHOP or var_114_0 == ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE or var_114_0 == ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE then
		var_114_1 = ActivityProxy.ACTIVITY_SHOP_SHOW_AWARDS
	elseif var_114_0 == ActivityConst.ACTIVITY_TYPE_LOTTERY then
		var_114_1 = ActivityProxy.ACTIVITY_LOTTERY_SHOW_AWARDS
	elseif var_114_0 == ActivityConst.ACTIVITY_TYPE_REFLUX then
		var_114_1 = ActivityProxy.ACTIVITY_SHOW_REFLUX_AWARDS
	elseif var_114_0 == ActivityConst.ACTIVITY_TYPE_RED_PACKETS or var_114_0 == ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER then
		var_114_1 = ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS
	end

	return var_114_1
end

function var_0_0.getDayIndex(arg_115_0)
	local var_115_0 = pg.TimeMgr.GetInstance()

	return var_115_0:DiffDay(arg_115_0:getStartTime(), (var_115_0:GetServerTime())) + 1
end

function var_0_0.getStartTime(arg_116_0)
	local var_116_0, var_116_1 = parseTimeConfig(arg_116_0:getConfig("time"))

	if var_116_1 and var_116_1[1] == "newuser" then
		return arg_116_0.stopTime - var_116_1[3] * 0
	else
		return pg.TimeMgr.GetInstance():parseTimeFromConfig(var_116_0[2])
	end

	return
end

function var_0_0.getNDay(arg_117_0, arg_117_1)
	arg_117_1 = arg_117_1 or arg_117_0:getStartTime()

	local var_117_0 = pg.TimeMgr.GetInstance()

	return var_117_0:DiffDay(arg_117_1, var_117_0:GetServerTime()) + 1
end

function var_0_0.isVariableTime(arg_118_0)
	local var_118_0, var_118_1 = parseTimeConfig(arg_118_0:getConfig("time"))

	return var_118_1 and var_118_1[1] == "newuser"
end

function var_0_0.setSpecialData(arg_119_0, arg_119_1, arg_119_2)
	if arg_119_0.speciaData then
		arg_119_0.speciaData = arg_119_0.speciaData or {}
		arg_119_0.speciaData[arg_119_1] = arg_119_2

		return
	end
end

function var_0_0.getSpecialData(arg_120_0, arg_120_1)
	if arg_120_0.speciaData and arg_120_0.speciaData[arg_120_1] then
		return arg_120_0.speciaData[arg_120_1] or nil
	end
end

function var_0_0.canPermanentFinish(arg_121_0)
	local var_121_0 = arg_121_0:getConfig("type")

	if var_121_0 == ActivityConst.ACTIVITY_TYPE_TASK_LIST then
		local var_121_1 = arg_121_0:getConfig("config_data")
		local var_121_2 = getProxy(TaskProxy)

		;({})[1] = var_121_1[#var_121_1]

		return underscore.all(underscore.flatten({}), function(arg_122_0)
			return var_121_2:getFinishTaskById(arg_122_0) ~= nil
		end)
	elseif var_121_0 == ActivityConst.ACTIVITY_TYPE_PT_BUFF then
		local var_121_3 = ActivityPtData.New(arg_121_0)

		return var_121_3.level >= #var_121_3.targets
	end

	return false
end

function var_0_0.GetShopTime(arg_123_0)
	local var_123_0 = pg.TimeMgr.GetInstance()

	return var_123_0:STimeDescS(arg_123_0:getStartTime(), "%y.%m.%d") .. " - " .. var_123_0:STimeDescS(arg_123_0.stopTime, "%y.%m.%d")
end

function var_0_0.GetCrusingUnreceiveAward(arg_124_0)
	assert(arg_124_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_CRUSING, "type error")

	for iter_124_0, iter_124_1 in ipairs(arg_124_0.data1_list) do
		({})[iter_124_1] = true
	end

	for iter_124_2, iter_124_3 in ipairs(pg.battlepass_event_pt[arg_124_0.id].target) do
		if iter_124_3 > arg_124_0.data1 then
			break
		elseif not ({})[iter_124_3] then
			table.insert({}, Drop.Create(pg.battlepass_event_award[pg.battlepass_event_pt[arg_124_0.id].award[iter_124_2]].drop_client))
		end
	end

	if arg_124_0.data2 ~= 1 then
		return PlayerConst.MergePassItemDrop({})
	end

	local var_124_0 = {}

	for iter_124_4, iter_124_5 in ipairs(arg_124_0.data2_list) do
		var_124_0[iter_124_5] = true
	end

	for iter_124_6, iter_124_7 in ipairs(pg.battlepass_event_pt[arg_124_0.id].target) do
		if iter_124_7 > arg_124_0.data1 then
			break
		elseif not var_124_0[iter_124_7] then
			table.insert({}, Drop.Create(pg.battlepass_event_award[pg.battlepass_event_pt[arg_124_0.id].award_pay[iter_124_6]].drop_client))
		end
	end

	return PlayerConst.MergePassItemDrop({})
end

function var_0_0.GetCrusingInfo(arg_125_0)
	assert(arg_125_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_CRUSING, "type error")

	local var_125_0 = pg.battlepass_event_pt[arg_125_0.id].pt
	local var_125_1 = {}

	for iter_125_0, iter_125_1 in ipairs(pg.battlepass_event_pt[arg_125_0.id].key_point_display) do
		({})[iter_125_1] = true
	end

	for iter_125_2, iter_125_3 in ipairs(pg.battlepass_event_pt[arg_125_0.id].target) do
		table.insert(var_125_1, {
			id = iter_125_2,
			pt = iter_125_3,
			award = pg.battlepass_event_award[pg.battlepass_event_pt[arg_125_0.id].award[iter_125_2]].drop_client,
			award_pay = pg.battlepass_event_award[pg.battlepass_event_pt[arg_125_0.id].award_pay[iter_125_2]].drop_client,
			isImportent = ({})[iter_125_2]
		})
	end

	local var_125_2 = arg_125_0.data1
	local var_125_3 = arg_125_0.data2 == 1
	local var_125_4 = {}

	for iter_125_4, iter_125_5 in ipairs(arg_125_0.data1_list) do
		var_125_4[iter_125_5] = true
	end

	for iter_125_6, iter_125_7 in ipairs(arg_125_0.data2_list) do
		({})[iter_125_7] = true
	end

	local var_125_5 = 0

	for iter_125_8, iter_125_9 in ipairs(var_125_1) do
		if var_125_2 < iter_125_9.pt then
			break
		else
			var_125_5 = iter_125_8
		end
	end

	return {
		ptId = var_125_0,
		awardList = var_125_1,
		pt = var_125_2,
		isPay = var_125_3,
		awardDic = var_125_4,
		awardPayDic = {},
		phase = var_125_5
	}
end

function var_0_0.GetHei5Info(arg_126_0)
	local var_126_0 = pg.black_friday_battlepass_event_pt[arg_126_0.id].pt
	local var_126_1 = {}

	for iter_126_0, iter_126_1 in ipairs(pg.black_friday_battlepass_event_pt[arg_126_0.id].key_point_display) do
		({})[iter_126_1] = true
	end

	for iter_126_2, iter_126_3 in ipairs(pg.black_friday_battlepass_event_pt[arg_126_0.id].target) do
		table.insert(var_126_1, {
			id = iter_126_2,
			pt = iter_126_3,
			award = pg.black_friday_battlepass_event_award[pg.black_friday_battlepass_event_pt[arg_126_0.id].award[iter_126_2]].drop_client,
			award_pay = pg.black_friday_battlepass_event_award[pg.black_friday_battlepass_event_pt[arg_126_0.id].award_pay[iter_126_2]].drop_client,
			isImportent = ({})[iter_126_2]
		})
	end

	local var_126_2 = arg_126_0.data1
	local var_126_3 = arg_126_0.data2 == 1
	local var_126_4 = {}

	for iter_126_4, iter_126_5 in ipairs(arg_126_0.data1_list) do
		var_126_4[iter_126_5] = true
	end

	for iter_126_6, iter_126_7 in ipairs(arg_126_0.data2_list) do
		({})[iter_126_7] = true
	end

	local var_126_5 = 0

	for iter_126_8, iter_126_9 in ipairs(var_126_1) do
		if var_126_2 < iter_126_9.pt then
			break
		else
			var_126_5 = iter_126_8
		end
	end

	return {
		ptId = var_126_0,
		awardList = var_126_1,
		pt = var_126_2,
		isPay = var_126_3,
		awardDic = var_126_4,
		awardPayDic = {},
		phase = var_126_5
	}
end

function var_0_0.GetHei5UnreceiveAward(arg_127_0)
	for iter_127_0, iter_127_1 in ipairs(arg_127_0.data1_list) do
		({})[iter_127_1] = true
	end

	for iter_127_2, iter_127_3 in ipairs(pg.black_friday_battlepass_event_pt[arg_127_0.id].target) do
		if iter_127_3 > arg_127_0.data1 then
			break
		elseif not ({})[iter_127_3] then
			table.insert({}, Drop.Create(pg.black_friday_battlepass_event_award[pg.black_friday_battlepass_event_pt[arg_127_0.id].award[iter_127_2]].drop_client))
		end
	end

	if arg_127_0.data2 ~= 1 then
		return PlayerConst.MergePassItemDrop({})
	end

	local var_127_0 = {}

	for iter_127_4, iter_127_5 in ipairs(arg_127_0.data2_list) do
		var_127_0[iter_127_5] = true
	end

	for iter_127_6, iter_127_7 in ipairs(pg.black_friday_battlepass_event_pt[arg_127_0.id].target) do
		if iter_127_7 > arg_127_0.data1 then
			break
		elseif not var_127_0[iter_127_7] then
			table.insert({}, Drop.Create(pg.black_friday_battlepass_event_award[pg.black_friday_battlepass_event_pt[arg_127_0.id].award_pay[iter_127_6]].drop_client))
		end
	end

	return PlayerConst.MergePassItemDrop({})
end

function var_0_0.IsActivityReady(arg_128_0)
	return arg_128_0 and not arg_128_0:isEnd() and arg_128_0:readyToAchieve()
end

function var_0_0.NeedLoginRedPoint(arg_129_0)
	return PlayerPrefs.GetString(arg_129_0:GetLoginRedPointKey(), "") ~= arg_129_0:GetLoginRedPointValue()
end

function var_0_0.SetLoginRedPoint(arg_130_0)
	PlayerPrefs.SetString(arg_130_0:GetLoginRedPointKey(), arg_130_0:GetLoginRedPointValue())

	return
end

function var_0_0.GetLoginRedPointValue(arg_131_0)
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function var_0_0.GetLoginRedPointKey(arg_132_0)
	return string.format("%s_%s", arg_132_0:GetPlayerID(), arg_132_0.id)
end

function var_0_0.GetPlayerID(arg_133_0)
	return getProxy(PlayerProxy):getPlayerId()
end

function var_0_0.GetConfigClientSetting(arg_134_0, arg_134_1)
	return arg_134_0:getConfig("config_client")[arg_134_1]
end

function var_0_0.IsMaintenanceFinish(arg_135_0)
	return not arg_135_0:GetConfigClientSetting("no_maintenance")
end

function var_0_0.GetPlayerActivyIDKey(arg_136_0)
	return "Activity_PlayerPrefs_PlayerId_" .. getProxy(PlayerProxy):getPlayerId() .. "ActivityID_" .. arg_136_0
end

return var_0_0
