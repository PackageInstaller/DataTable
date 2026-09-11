local var_0_0 = singletonClass("SnowballGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.unlockedLevels = {
		[0] = 0
	}
	arg_1_0.lastSelectPlayer = nullable(SnowballGameUnitCfg, getData("snowball", "lastSelectedPlayer"), "id") or nullable(SnowballGameUnitCfg.get_id_list_by_unit_type, 0, 1)
	arg_1_0.lastEnter = getData("snowball", "lastEnter")
end

local function var_0_1(arg_2_0, arg_2_1)
	return string.format("%s_%s", arg_2_0, arg_2_1)
end

local var_0_3 = "ACTIVITY_TASK"
local var_0_4 = "INFINITY_POOL"

function var_0_0.InitSnowballRedPoint(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1(var_0_3, arg_3_1)
	local var_3_1 = {
		RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE
	}
	local var_3_2 = ActivityTools.GetAllSubActivityByTemplate(arg_3_1, ActivityTemplateConst.INFINITY_POOL)

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		table.insert(var_3_1, (var_0_1(var_0_4, iter_3_1)))
	end

	arg_3_0.infPoolSubActivity = var_3_2

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME, var_3_1, true)
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_3_1) .. arg_3_1, {
		RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_DAILY
	}, true)
end

function var_0_0:CheckTaskRedPoint()
	local var_4_0 = false
	local var_4_1 = false

	for iter_4_0, iter_4_1 in ipairs((TaskTools:GetCanGetActivityTaskList(self.activityID))) do
		if AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.SNOWBALL_TASK_CHALLENGE then
			var_4_0 = true
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY or AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
			var_4_1 = true
		end

		if var_4_1 and var_4_0 then
			break
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_DAILY, var_4_1 and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE, var_4_0 and 1 or 0)
end

function var_0_0:GetTaskRedPointKey()
	return var_0_1(var_0_3, self.activityID)
end

function var_0_0:GetInfPoolRedPointKey(arg_6_1)
	return var_0_1(var_0_4, self.infPoolSubActivity[arg_6_1])
end

function var_0_0:InitFromServer(arg_7_1)
	self.activityID = arg_7_1.activity_id

	self:InitSnowballRedPoint(self.activityID)
	self:CheckTaskRedPoint()

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.stage_list) do
		self.unlockedLevels[iter_7_1.stage_id] = iter_7_1.max_score
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED, self:IsFirstEnterGame() and 1 or 0)
	self:UpdateUnlockLevelRedPoint()
end

function var_0_0:UpdateUnlockLevelRedPoint()
	if self:AnyLevelNotPlayed() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL, 1)
	end
end

var_0_0.LevelLockReason = {
	NEED_UNLOCK_OTHER_LEVEL = 1,
	ACTIVITY_TIME_LOCK = 0
}

function var_0_0.CheckLevelCost(arg_9_0, arg_9_1)
	local var_9_0 = SnowballGameCfg[arg_9_1].level_cost[1]

	if SnowballGameCfg[arg_9_1].level_cost[1] == nil then
		return true
	else
		return ItemTools.getItemNum(var_9_0[1]) >= var_9_0[2]
	end
end

function var_0_0:IsLevelUnlocked(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or false

	local var_10_0 = SnowballGameCfg[arg_10_1]

	if not ActivityTools.GetActivityIsOpenWithTip(SnowballGameCfg[arg_10_1].activity_id, arg_10_2) then
		return false, var_0_0.LevelLockReason.ACTIVITY_TIME_LOCK, SnowballGameCfg[arg_10_1].activity_id
	elseif not self.unlockedLevels[var_10_0.level_unlock] then
		return false, var_0_0.LevelLockReason.NEED_UNLOCK_OTHER_LEVEL, var_10_0.level_unlock
	else
		return true
	end
end

function var_0_0.CacheLevelAlreadyUnlocked(arg_11_0, arg_11_1)
	saveData("snowballLevel", tostring(arg_11_1), true)
end

function var_0_0.IsLevelFirstUnlocked(arg_12_0, arg_12_1)
	return not getData("snowballLevel", tostring(arg_12_1))
end

function var_0_0:AnyLevelUnlocked()
	for iter_13_0, iter_13_1 in ipairs(SnowballGameCfg.all) do
		if self:IsLevelUnlocked(iter_13_1) then
			return true
		end
	end

	return false
end

function var_0_0:AnyLevelNotPlayed()
	for iter_14_0, iter_14_1 in ipairs(SnowballGameCfg.all) do
		if self:IsLevelUnlocked(iter_14_1) and self:GetLevelHighScore(iter_14_1) == nil and self:CheckLevelCost(iter_14_1) then
			return true
		end
	end

	return false
end

function var_0_0:GetLastSelectedPlayer()
	return self.lastSelectPlayer
end

function var_0_0.SetLastSelectedPlayer(arg_16_0, arg_16_1)
	saveData("snowball", "lastSelectedPlayer", arg_16_1)

	arg_16_0.lastSelectPlayer = arg_16_1
end

function var_0_0:IsFirstEnterGame()
	return self.lastEnter == nil or self.lastEnter < ActivityData:GetActivityData(self.activityID).startTime
end

function var_0_0:SetAlreadyEnter()
	self.lastEnter = manager.time:GetServerTime()

	saveData("snowball", "lastEnter", self.lastEnter)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED, 0)
end

function var_0_0:GetLevelHighScore(arg_19_1)
	return self.unlockedLevels[arg_19_1]
end

function var_0_0:OnLevelClear(arg_20_1, arg_20_2)
	local var_20_0 = self.unlockedLevels[arg_20_1] == nil
	local var_20_1 = self.unlockedLevels[arg_20_1] or 0
	local var_20_2 = var_20_1 < arg_20_2

	self.unlockedLevels[arg_20_1] = math.max(var_20_1, arg_20_2)

	return var_20_0, var_20_2
end

function var_0_0.CheckAlreadyShowInGameTip(arg_21_0, arg_21_1)
	return getData("snowballInGameTips", arg_21_1)
end

function var_0_0.InGameTipClose(arg_22_0, arg_22_1)
	saveData("snowballInGameTips", arg_22_1, true)
end

var_0_0.InGameTips = {
	Shoot = "shoot",
	Move = "move"
}

return var_0_0
