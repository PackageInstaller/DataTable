local ActivityPtData = class("ActivityPtData")

function ActivityPtData:Ctor(arg_1_1)
	self.dropList = arg_1_1:getDataConfig("drop_client")
	self.targets = arg_1_1:getDataConfig("target")
	self.resId = arg_1_1:getDataConfig("pt")
	self.bindActId = arg_1_1:getDataConfig("id_2")
	self.unlockDay = arg_1_1:getDataConfig("day_unlock")
	self.type = arg_1_1:getDataConfig("type")

	self:Update(arg_1_1)

	return
end

function ActivityPtData:Update(arg_2_1)
	self.activity = arg_2_1
	self.count = arg_2_1.data1
	self.level = 0

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.data1_list) do
		table.insert(var_2_0, iter_2_1)
	end

	table.sort(var_2_0)

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		if iter_2_3 == self.targets[iter_2_2] then
			self.level = iter_2_2
		else
			break
		end
	end

	self.startTime = arg_2_1.data2
	self.value2 = arg_2_1.data3
	self.isDayUnlock = self:CheckDayUnlock() and 1 or 0
	self.curHasBuffs = arg_2_1.data2_list
	self.curBuffs = arg_2_1.data3_list

	return
end

function ActivityPtData:CheckDayUnlock()
	local var_3_0 = pg.TimeMgr.GetInstance()

	return var_3_0:DiffDay(self.startTime, var_3_0:GetServerTime()) + 1 >= (self.unlockDay[math.min(self.level + 1, #self.targets)] or 0)
end

function ActivityPtData:GetDayUnlockStamps()
	local var_4_0 = pg.TimeMgr.GetInstance()
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self.unlockDay) do
		table.insert(var_4_1, self.startTime + (iter_4_1 - 1) * 0)
	end

	return var_4_1
end

function ActivityPtData:GetLevelProgress()
	local var_5_0 = self:getTargetLevel()

	return var_5_0, #self.targets, var_5_0 / #self.targets
end

function ActivityPtData:GetResProgress()
	local var_6_0 = self:getTargetLevel()

	return self.count, self.targets[var_6_0], self.count / self.targets[var_6_0]
end

function ActivityPtData:GetUnlockedMaxResRequire()
	local var_7_0 = pg.TimeMgr.GetInstance()
	local var_7_1 = var_7_0:DiffDay(self.startTime, var_7_0:GetServerTime()) + 1

	for iter_7_0 = #self.targets, 1, -1 do
		if var_7_1 >= self.unlockDay[iter_7_0] then
			return self.targets[iter_7_0]
		end
	end

	return 1
end

function ActivityPtData:GetTotalResRequire()
	return self.targets[#self.targets]
end

function ActivityPtData:GetId()
	return self.activity.id
end

function ActivityPtData:GetRes()
	return {
		type = 1,
		id = self.resId
	}
end

function ActivityPtData:GetAward()
	local var_11_0 = self.dropList[self:getTargetLevel()]

	return Drop.New({
		type = var_11_0[1],
		id = var_11_0[2],
		count = var_11_0[3]
	})
end

function ActivityPtData:GetResItemId()
	return self:GetAward().id
end

function ActivityPtData:GetValue2()
	return self.value2
end

function ActivityPtData:getTargetLevel()
	return math.min(self.level + self.isDayUnlock, #self.targets)
end

function ActivityPtData:GetLevel()
	return self.level
end

function ActivityPtData:CanGetAward()
	return self:CanGetNextAward() and (function()
		local var_17_0, var_17_1, var_17_2 = self:GetResProgress()

		return var_17_2 >= 1
	end)()
end

function ActivityPtData:CanGetNextAward()
	return self.isDayUnlock > 0 and self.level < #self.targets
end

function ActivityPtData:CanGetMorePt()
	local var_19_0 = getProxy(ActivityProxy):getActivityById(self.bindActId)

	return var_19_0 and not var_19_0:isEnd()
end

function ActivityPtData:CanTrain()
	if not self:isInBuffTime() then
		return false
	end

	local function var_20_0(arg_21_0)
		for iter_21_0, iter_21_1 in ipairs(self.curHasBuffs) do
			if arg_21_0 == iter_21_1 then
				return false
			end
		end

		return true
	end

	for iter_20_0, iter_20_1 in ipairs(self.activity:getDataConfig("target_buff")) do
		if var_20_0(iter_20_1) and iter_20_1 <= self.level + 1 then
			return iter_20_1
		end
	end

	return false
end

function ActivityPtData:GetCurBuffInfos()
	local var_22_0 = {}
	local var_22_1 = #self.activity:getDataConfig("buff_group")

	for iter_22_0, iter_22_1 in ipairs(self.curBuffs) do
		for iter_22_2, iter_22_3 in ipairs(self.activity:getDataConfig("buff_group")) do
			for iter_22_4, iter_22_5 in ipairs(iter_22_3) do
				if iter_22_1 == iter_22_5 then
					table.insert(var_22_0, {
						id = iter_22_5,
						lv = iter_22_4,
						group = iter_22_2,
						next = iter_22_3[iter_22_4 + 1],
						award = self:GetBuffAwardInfo(iter_22_3[#iter_22_3])
					})
				end
			end
		end
	end

	return var_22_0
end

function ActivityPtData:GetBuffAwardInfo(arg_23_1)
	local var_23_0 = self.activity:getDataConfig("drop_display")

	if var_23_0 == "" then
		return nil
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if arg_23_1 == iter_23_1[1] then
			return {
				type = iter_23_1[2][1],
				id = iter_23_1[2][2],
				count = iter_23_1[2][3]
			}
		end
	end

	return nil
end

function ActivityPtData:GetBuffLevelProgress()
	local var_24_0 = false
	local var_24_1, var_24_2 = (function()
		for iter_25_0, iter_25_1 in ipairs(self.activity:getDataConfig("target_buff")) do
			if iter_25_1 > self.level then
				return iter_25_0, iter_25_1
			end
		end

		var_24_0 = true

		return #self.activity:getDataConfig("target_buff") + 1, 1
	end)()
	local var_24_3 = var_24_1 == 1 and 0 or self.activity:getDataConfig("target_buff")[var_24_1 - 1]

	return var_24_1, false and 1 or (self.level - var_24_3) / (var_24_2 - var_24_3)
end

function ActivityPtData:isInBuffTime()
	local var_26_0 = self.activity:getDataConfig("buff_time")

	if type(var_26_0) == "table" then
		return pg.TimeMgr.GetInstance():GetServerTime() < pg.TimeMgr.GetInstance():Table2ServerTime({
			year = var_26_0[1][1],
			month = var_26_0[1][2],
			day = var_26_0[1][3],
			hour = var_26_0[2][1],
			min = var_26_0[2][2],
			sec = var_26_0[2][3]
		})
	elseif var_26_0 == "always" then
		return true
	elseif var_26_0 == "stop" then
		return false
	end

	return false
end

function ActivityPtData:GetDrop(arg_27_1)
	return {
		type = self.dropList[arg_27_1][1],
		id = self.dropList[arg_27_1][2],
		count = self.dropList[arg_27_1][3]
	}
end

function ActivityPtData:GetPtTarget(arg_28_1)
	if arg_28_1 <= 0 then
		return 0
	elseif arg_28_1 > #self.targets then
		return self.targets[#self.targets]
	else
		return self.targets[arg_28_1]
	end

	return
end

function ActivityPtData:GetCurrLevel()
	for iter_29_0, iter_29_1 in ipairs(self.targets) do
		if iter_29_1 > self.count then
			return iter_29_0 - 1
		end
	end

	return #self.targets
end

function ActivityPtData:IsMaxLevel()
	return self:GetCurrLevel() == #self.targets
end

function ActivityPtData:GetNextLevel()
	for iter_31_0, iter_31_1 in ipairs(self.targets) do
		if iter_31_1 > self.count then
			return iter_31_0
		end
	end

	return #self.targets
end

function ActivityPtData:GetCurrTarget()
	return self:GetPtTarget((self:GetCurrLevel()))
end

function ActivityPtData:GetNextLevelTarget()
	return self:GetPtTarget((self:GetNextLevel()))
end

function ActivityPtData:IsGotLevelAward(arg_34_1)
	local var_34_0 = self:GetPtTarget(arg_34_1)

	for iter_34_0, iter_34_1 in ipairs(self.activity.data1_list) do
		if iter_34_1 == var_34_0 then
			return true
		end
	end

	return false
end

function ActivityPtData:GetLastAward()
	return {
		type = self.dropList[#self.targets][1],
		id = self.dropList[#self.targets][2],
		count = self.dropList[#self.targets][3]
	}
end

function ActivityPtData:GetMaxAvailableTargetIndex()
	for iter_36_0 = self.availableTargetIndex or 1, #self.targets do
		if self.count >= self.targets[iter_36_0] then
			self.availableTargetIndex = iter_36_0
		else
			break
		end
	end

	return self.availableTargetIndex or 0
end

function ActivityPtData:GetAllAvailableAwards()
	return _.slice(self.dropList, math.min(self:GetLevel() + 1, self:GetMaxAvailableTargetIndex()), self:GetMaxAvailableTargetIndex() - self:GetLevel())
end

ActivityPtData.STATE_LOCK = 1
ActivityPtData.STATE_CAN_GET = 2
ActivityPtData.STATE_GOT = 3

function ActivityPtData:GetDroptItemState(arg_38_1)
	if arg_38_1 > self:GetCurrLevel() then
		return ActivityPtData.STATE_LOCK
	elseif self:IsGotLevelAward(arg_38_1) then
		return ActivityPtData.STATE_GOT
	else
		return ActivityPtData.STATE_CAN_GET
	end

	return
end

function ActivityPtData:AnyAwardCanGet()
	for iter_39_0, iter_39_1 in ipairs(self.targets) do
		if self:GetDroptItemState(iter_39_0) == ActivityPtData.STATE_CAN_GET then
			return true
		end
	end

	return false
end

return ActivityPtData
