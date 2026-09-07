local Task = class("Task", import("..BaseVO"))

Task.TYPE_SCENARIO = 1
Task.TYPE_BRANCH = 2
Task.TYPE_ROUTINE = 3
Task.TYPE_WEEKLY = 4
Task.TYPE_HIDDEN = 5
Task.TYPE_ACTIVITY = 6
Task.TYPE_ACTIVITY_ROUTINE = 36
Task.TYPE_ACTIVITY_BRANCH = 26
Task.TYPE_GUILD_WEEKLY = 12
Task.TYPE_NEW_WEEKLY = 13
Task.TYPE_REFLUX = 15
Task.TYPE_ACTIVITY_REPEAT = 16
Task.TYPE_ACTIVITY_WEEKLY = 46
Task.TYPE_COMMANDER_MANUAL = 17
Task.TYPE_REPEATABLE = 20

local var_0_1 = {
	"scenario",
	"branch",
	"routine",
	"weekly"
}

Task.TASK_PROGRESS_UPDATE = 0
Task.TASK_PROGRESS_APPEND = 1

function Task:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.progress = arg_1_1.progress or 0
	self.acceptTime = arg_1_1.accept_time
	self.submitTime = arg_1_1.submit_time or 0
	self._actId = nil
	self._autoSubmit = false

	return
end

function Task:isClientTrigger()
	return self:getConfig("sub_type") > 2000 and self:getConfig("sub_type") < 3000
end

function Task:bindConfigTable()
	return pg.task_data_template
end

function Task:isGuildTask()
	return self:getConfig("type") == Task.TYPE_GUILD_WEEKLY
end

function Task:IsRoutineType()
	return self:getConfig("type") == Task.TYPE_ROUTINE
end

function Task:IsActRoutineType()
	return self:getConfig("type") == Task.TYPE_ACTIVITY_ROUTINE
end

function Task:IsActType()
	return self:getConfig("type") == Task.TYPE_ACTIVITY
end

function Task:IsWeeklyType()
	return self:getConfig("type") == Task.TYPE_WEEKLY or self:getConfig("type") == Task.TYPE_NEW_WEEKLY
end

function Task:IsBackYardInterActionType()
	return self:getConfig("sub_type") == 2010
end

function Task:IsFlagShipInterActionType()
	return self:getConfig("sub_type") == 2011
end

function Task:IsGuildAddLivnessType()
	local var_11_0 = self:getConfig("type")

	return var_11_0 == Task.TYPE_ROUTINE or var_11_0 == Task.TYPE_WEEKLY or var_11_0 == Task.TYPE_GUILD_WEEKLY or var_11_0 == Task.TYPE_NEW_WEEKLY
end

function Task:IsCommanderManualType()
	return self:getConfig("type") == Task.TYPE_COMMANDER_MANUAL
end

function Task:isLock()
	return getProxy(PlayerProxy):getRawData().level < self:getConfig("level")
end

function Task:isFinish()
	local var_14_0 = self:getProgress()

	if self:getConfig("sub_type") == TASK_SUB_TYPE_REPEATABLE then
		return var_14_0 >= 1
	end

	return var_14_0 >= self:getConfig("target_num")
end

function Task:getProgress()
	return switch(self:getConfig("sub_type"), {
		[TASK_SUB_TYPE_GIVE_ITEM] = function()
			return getProxy(BagProxy):getItemCountById(tonumber((tonumber(self:getConfig("target_id")))))
		end,
		[TASK_SUB_TYPE_PT] = function()
			local var_17_0 = getProxy(ActivityProxy):getActivityById(tonumber(self:getConfig("target_id_2")))

			return (var_17_0 or nil) and (var_17_0.data1 or 0)
		end,
		[TASK_SUB_TYPE_PLAYER_RES] = function()
			return getProxy(PlayerProxy):getData():getResById((tonumber(self:getConfig("target_id"))))
		end,
		[TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM] = function()
			return getProxy(ActivityProxy):getVirtualItemNumber((tonumber(self:getConfig("target_id"))))
		end,
		[TASK_SUB_TYPE_BOSS_PT] = function()
			return getProxy(PlayerProxy):getData():getResById((tonumber(self:getConfig("target_id"))))
		end,
		[TASK_SUB_STROY] = function()
			local var_21_0 = 0

			_.each(self:getConfig("target_id"), function(arg_22_0)
				if pg.NewStoryMgr.GetInstance():GetPlayedFlag(arg_22_0) then
					var_21_0 = var_21_0 + 1
				end

				return
			end)

			return 0
		end,
		[TASK_SUB_TYPE_TECHNOLOGY_POINT] = function()
			return math.min(getProxy(TechnologyNationProxy):getNationPoint(tonumber(self:getConfig("target_id"))), self:getConfig("target_num"))
		end,
		[TASK_SUB_TYPE_VITEM] = function()
			local var_24_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[tonumber(self:getConfig("target_id"))].activity_id)

			if var_24_0 then
				return var_24_0:getVitemNumber((tonumber(self:getConfig("target_id_2"))))
			end

			return
		end,
		[TASK_SUB_TYPE_VITEMS] = function()
			local var_25_0 = tonumber(self:getConfig("target_id"))

			if underscore.all(self:getConfig("target_id_2"), function(arg_26_0)
				local var_26_0 = Drop.New({
					type = var_25_0,
					id = arg_26_0[1],
					count = arg_26_0[2]
				})

				return var_26_0:getOwnedCount() >= var_26_0.count
			end) then
				return 1
			end

			return
		end,
		[TASK_SUB_TYPE_JOIN_GUILD] = function()
			return getProxy(GuildProxy):getData() and 1 or 0
		end,
		[TASK_SUB_TYPE_COLLAB_BOSS_RUSH_DEFEAT] = function()
			local var_28_0 = tonumber(self:getConfig("target_id"))
			local var_28_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)

			if not var_28_1 then
				return 0
			end

			for iter_28_0, iter_28_1 in pairs((var_28_1:GetCollabSeriesDataList())) do
				if iter_28_1:GetCollabBossID() == var_28_0 then
					return iter_28_1:GetBossTimeStamp() ~= 0 and 1 or 0
				end
			end

			return 0
		end,
		[TASK_SUB_TYPE_REPEATABLE] = function()
			return self.progress >= 1 and 1 or 0
		end,
		[TASK_SUB_TYPE_COMPLETE_ALL_DAILY_TASKS] = function()
			return underscore.any(getProxy(TaskProxy):getTasks(), function(arg_31_0)
				return arg_31_0:IsRoutineType() and arg_31_0:getConfig("sub_type") ~= TASK_SUB_TYPE_COMPLETE_ALL_DAILY_TASKS
			end) and 0 or 1
		end
	}, function()
		return self.progress
	end) or 0
end

function Task:getTargetNumber()
	return self:getConfig("target_num")
end

function Task:isReceive()
	return self.submitTime > 0
end

function Task:isCircle()
	if self:isActivityTask() then
		if self:getConfig("type") == 16 and self:getConfig("sub_type") == 1006 then
			return true
		elseif self:getConfig("type") == 16 and self:getConfig("sub_type") == 20 then
			return true
		elseif self:getConfig("type") == 16 and self:getConfig("sub_type") == 1007 then
			return true
		elseif self:getConfig("type") == 16 and self:getConfig("sub_type") == 122 then
			return true
		end
	end

	return false
end

function Task:isDaily()
	return self:getConfig("sub_type") == 31 or self:getConfig("sub_type") == 28
end

function Task:getTaskStatus()
	if self:isLock() then
		return -1
	end

	if self:isReceive() then
		return 2
	end

	if self:isFinish() then
		return 1
	end

	return 0
end

function Task:onAdded()
	local function var_38_0()
		if self:getConfig("sub_type") == 29 then
			if _.any(getProxy(SkirmishProxy):getRawData(), function(arg_40_0)
				return arg_40_0:getConfig("task_id") == self.id
			end) then
				return
			end

			pg.m02:sendNotification(GAME.TASK_GO, {
				taskVO = self
			})
		elseif self:getConfig("added_tip") > 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				noText = "text_iknow",
				yesText = "text_forward",
				content = i18n("tip_add_task", self:getConfig("name")),
				onYes = (getProxy(ContextProxy):getCurrentContext().mediator.__cname ~= TaskMediator.__cname or nil) and function()
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TASK, {
						page = var_0_1[self:GetRealType()]
					})

					return
				end
			})
		end

		if self:IsCommanderManualType() then
			getProxy(CommanderManualProxy):AddPageTaskDone(self)
		end

		return
	end

	local var_38_1 = self:getConfig("story_id")

	if var_38_1 and var_38_1 ~= "" and (function()
		if not table.contains({
			"LevelScene",
			"BattleScene",
			"EventListScene",
			"MilitaryExerciseScene",
			"DailyLevelScene"
		}, getProxy(ContextProxy):getCurrentContext().viewComponent.__cname) then
			return true
		end

		return false
	end)() then
		pg.NewStoryMgr.GetInstance():Play(var_38_1, var_38_0, true, true)
	else
		var_38_0()
	end

	return
end

function Task:updateProgress(arg_43_1)
	self.progress = arg_43_1

	return
end

function Task:isSelectable()
	local var_44_0 = self:getConfig("award_choice")

	return var_44_0 ~= nil and type(var_44_0) == "table" and #var_44_0 > 0
end

function Task:judgeOverflow(arg_45_1, arg_45_2, arg_45_3)
	return Task.StaticJudgeOverflow(arg_45_1, arg_45_2, arg_45_3, self:getTaskStatus() == 1, self:ShowOnTaskScene(), self:getConfig("award_display"))
end

function Task:StaticJudgeOverflow(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	if arg_46_3 and arg_46_4 then
		local var_46_0 = getProxy(PlayerProxy):getData()
		local var_46_1 = pg.gameset.urpt_chapter_max.description[1]
		local var_46_2 = self or var_46_0.gold
		local var_46_3 = arg_46_1 or var_46_0.oil

		if not arg_46_2 then
			::label_46_0::

			local var_46_4

			if not LOCK_UR_SHIP then
				var_46_4 = getProxy(BagProxy):GetLimitCntById(var_46_1) or 0
			end
		end

		local var_46_5 = pg.gameset.max_gold.key_value
		local var_46_6 = pg.gameset.max_oil.key_value
		local var_46_7

		if not LOCK_UR_SHIP then
			var_46_7 = pg.gameset.urpt_chapter_max.description[2] or 0
		end

		local var_46_8 = false
		local var_46_9 = false
		local var_46_10 = false
		local var_46_11 = false
		local var_46_13 = {}

		for iter_46_0, iter_46_1 in ipairs(arg_46_5) do
			local var_46_14, var_46_15, var_46_16 = unpack(iter_46_1)

			if var_46_14 == DROP_TYPE_RESOURCE then
				if var_46_15 == PlayerConst.ResGold then
					if var_46_2 + var_46_16 - var_46_5 > 0 then
						var_46_8 = true

						table.insert(var_46_13, {
							type = DROP_TYPE_RESOURCE,
							id = PlayerConst.ResGold,
							count = setColorStr(var_46_2 + var_46_16 - var_46_5, COLOR_RED)
						})
					end
				elseif var_46_15 == PlayerConst.ResOil then
					if var_46_3 + var_46_16 - var_46_6 > 0 then
						var_46_9 = true

						table.insert(var_46_13, {
							type = DROP_TYPE_RESOURCE,
							id = PlayerConst.ResOil,
							count = setColorStr(var_46_3 + var_46_16 - var_46_6, COLOR_RED)
						})
					end
				end
			elseif not LOCK_UR_SHIP and var_46_14 == DROP_TYPE_VITEM then
				if Item.getConfigData(var_46_15).virtual_type == 20 then
					if var_46_4 + var_46_16 - var_46_7 > 0 then
						var_46_10 = true

						table.insert(var_46_13, {
							type = DROP_TYPE_VITEM,
							id = var_46_1,
							count = setColorStr(var_46_4 + var_46_16 - var_46_7, COLOR_RED)
						})
					end
				end
			elseif var_46_14 == DROP_TYPE_ITEM and Item.getConfigData(var_46_15).type == Item.EXP_BOOK_TYPE then
				local var_46_17 = getProxy(BagProxy):getItemCountById(var_46_15) + var_46_16
				local var_46_18 = Item.getConfigData(var_46_15).max_num

				if var_46_18 < var_46_17 then
					var_46_11 = true

					table.insert(var_46_13, {
						type = DROP_TYPE_ITEM,
						id = var_46_15,
						count = setColorStr(math.min(var_46_16, var_46_17 - var_46_18), COLOR_RED)
					})
				end
			end
		end

		return var_46_8 or var_46_9 or var_46_10 or var_46_11, var_46_13
	end

	return
end

function Task:IsUrTask()
	if not LOCK_UR_SHIP then
		local var_47_0 = pg.gameset.urpt_chapter_max.description[1]

		do return _.any(self:getConfig("award_display"), function(arg_48_0)
			return arg_48_0[1] == DROP_TYPE_ITEM and arg_48_0[2] == var_47_0
		end) end
		return
	end

	return false
end

function Task:GetRealType()
	local var_49_0 = self:getConfig("priority_type")

	if var_49_0 == 0 then
		var_49_0 = self:getConfig("type")
	end

	return var_49_0
end

function Task:IsOverflowShipExpItem()
	local function var_50_0(arg_51_0, arg_51_1)
		return getProxy(BagProxy):getItemCountById(arg_51_0) + arg_51_1 > Item.getConfigData(arg_51_0).max_num
	end

	for iter_50_0, iter_50_1 in ipairs((self:getConfig("award_display"))) do
		if iter_50_1[1] == DROP_TYPE_ITEM and Item.getConfigData(iter_50_1[2]).type == Item.EXP_BOOK_TYPE and var_50_0(iter_50_1[2], iter_50_1[3]) then
			return true
		end
	end

	return false
end

function Task:ShowOnTaskScene()
	local var_52_0 = self:getConfig("visibility") == 1

	if self.id == 17268 then
		var_52_0 = false

		local var_52_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.BUILDING_NEWYEAR_2022)

		if var_52_1 and not var_52_1:isEnd() then
			var_52_0 = (var_52_1.data1KeyValueList[2][17] or 1) >= 4 and (var_52_1.data1KeyValueList[2][18] or 1) >= 4
		end
	end

	return var_52_0
end

function Task:setTaskFinish()
	self.submitTime = 1

	self:updateProgress(self:getConfig("target_num"))

	return
end

function Task:isAvatarTask()
	return false
end

function Task:getActId()
	return self._actId
end

function Task:setActId(arg_56_1)
	self._actId = arg_56_1

	return
end

function Task:isActivityTask()
	return self._actId and self._actId > 0
end

function Task:setAutoSubmit(arg_58_1)
	self._autoSubmit = arg_58_1

	return
end

function Task:getAutoSubmit()
	return self._autoSubmit
end

function Task:getGiveDrops()
	local var_60_0 = {}

	if self:getConfig("sub_type") == TASK_SUB_TYPE_VITEMS then
		local var_60_1 = tonumber(self:getConfig("target_id"))

		for iter_60_0, iter_60_1 in ipairs(self:getConfig("target_id_2")) do
			table.insert(var_60_0, Drop.New({
				type = var_60_1,
				id = iter_60_1[1],
				count = iter_60_1[2]
			}))
		end
	end

	return var_60_0
end

function Task:OwnSpAward()
	local var_61_0 = {
		type = self[1],
		id = self[2],
		count = self[3]
	}

	if var_61_0.type == DROP_TYPE_FURNITURE then
		return (function(arg_62_0)
			return getProxy(DormProxy):getData():GetOwnFurnitureCount(arg_62_0) > 0
		end)(var_61_0.id)
	elseif var_61_0.type == DROP_TYPE_VITEM then
		if type(pg.item_virtual_data_statistics[var_61_0.id].album_config) == "table" then
			if pg.item_virtual_data_statistics[var_61_0.id].album_config[1] == 1 then
				return (function(arg_63_0)
					local var_63_0 = getProxy(CollectionProxy):GetTrophyById(arg_63_0)

					return var_63_0 and (var_63_0:canClaimed() or var_63_0:isClaimed())
				end)(pg.item_virtual_data_statistics[var_61_0.id].album_config[2])
			elseif pg.item_virtual_data_statistics[var_61_0.id].album_config[1] == 2 then
				return (function(arg_64_0)
					for iter_64_0, iter_64_1 in pairs((getProxy(PlayerProxy):getRawData():getActivityMedalGroup())) do
						if iter_64_1:OwnMedel(arg_64_0) then
							return true
						end
					end

					return false
				end)(pg.item_virtual_data_statistics[var_61_0.id].album_config[2])
			end
		end
	end

	return false
end

return Task
