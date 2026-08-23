local var_0_0 = g.core.config.rebel_award_info
local RebelElemData = import(".RebelElemData")
local var_0_2 = g.core.const.ConstMgr.RebelConst.REBEL_TYPE
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.common.ModuleUnlock
local RebelData = class("RebelData")

function RebelData:ctor()
	self:initData()
end

function RebelData:initData()
	self._rebelDefault1 = nil
	self._rebelDefault2 = nil
	self._rebelElemArr = {}
	self._dailyMaxLevel = 0
	self._dailyMaxDamage = 0
	self._dailyTotalDamage = 0
	self._dailyAwards = {}
	self._newestRebelElem = nil
	self._notifyData = nil
	self._isNeedBattle = false
	self._seen2RealDict = nil
	self._attackTargetId = nil
	self._rebelInfoConnectTime = 0
	self._monsterVersion = 1
	self._displayVersion = 1
end

function RebelData:_initLevelSeen2Real()
	self._seen2RealDict = {}

	for iter_3_0, iter_3_1 in g.core.config.rebel_grade_info.ipairs() do
		if self._displayVersion == 1 then
			self._seen2RealDict[iter_3_1.seen_grade] = iter_3_1.real_grade or iter_3_1["real_grade_" .. self._displayVersion]
		end
	end
end

function RebelData:onS2CRebelInfo(arg_4_1)
	self._rebelDefault1 = nil
	self._rebelDefault2 = nil
	self._rebelElemArr = {}

	if arg_4_1.self_rebel then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.self_rebel) do
			local var_4_1 = RebelElemData.new(iter_4_1, true, self._seen2RealDict[iter_4_1.level] or 1)
			local var_4_2 = var_4_1:getRebelType()

			if var_4_2 == var_0_2.DEFAULT_1 then
				self._rebelDefault1 = var_4_1
			elseif var_4_2 == var_0_2.DEFAULT_2 then
				self._rebelDefault2 = var_4_1
			else
				table.insert(self._rebelElemArr, var_4_1)
			end
		end
	end

	if arg_4_1.friend_rebel then
		for iter_4_2, iter_4_3 in ipairs(arg_4_1.friend_rebel) do
			table.insert(self._rebelElemArr, (RebelElemData.new(iter_4_3, false, self._seen2RealDict[iter_4_3.level] or 1)))
		end
	end

	table.sort(self._rebelElemArr, self._sortCompare)

	if arg_4_1.level then
		self._dailyMaxLevel = arg_4_1.level
	end

	self._dailyMaxDamage = arg_4_1.max_damage or 0
	self._dailyTotalDamage = arg_4_1.total_damage or 0
	self._dailyAwards = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.award_ids or {}) do
		self._dailyAwards[tostring(iter_4_5)] = iter_4_5
	end
end

function RebelData:addNotifyRebel(arg_5_1)
	self._newestRebelElem = nil

	if arg_5_1.rebel then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.rebel) do
			local var_5_1 = RebelElemData.new(iter_5_1, true, self._seen2RealDict[iter_5_1.level] or 1)

			if var_5_1:getBaseInfo().type == var_0_2.DUNGEON_TRIGGER then
				self._newestRebelElem = var_5_1
			end

			table.insert(self._rebelElemArr, var_5_1)
		end

		table.sort(self._rebelElemArr, self._sortCompare)
	end
end

function RebelData:addRebelAward(arg_6_1)
	self._dailyAwards[tostring(arg_6_1.id)] = arg_6_1.id
end

function RebelData:addRebelAwardArr(arg_7_1)
	if not arg_7_1.ids then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.ids) do
		self._dailyAwards[tostring(iter_7_1)] = iter_7_1

		local var_7_1 = var_0_0.get(iter_7_1)

		table.insert(var_7_0, {
			type = var_7_1.type,
			value = var_7_1.value,
			size = var_7_1.size
		})
	end

	return var_7_0
end

function RebelData:getAllDamage()
	return self._dailyMaxDamage, self._dailyTotalDamage
end

function RebelData:getRebelDefault()
	return self._rebelDefault1, self._rebelDefault2
end

function RebelData:getRebelArr()
	return self._rebelElemArr
end

function RebelData:getDailyAwards()
	return self._dailyAwards
end

function RebelData:getMaxLevel()
	return self._dailyMaxLevel
end

function RebelData:isNeedBattle()
	return self._isNeedBattle
end

function RebelData:onRebelShare(arg_14_1)
	local var_14_0 = arg_14_1 and arg_14_1.id

	for iter_14_0, iter_14_1 in pairs(self._rebelElemArr) do
		if var_14_0 == iter_14_1:getId() then
			iter_14_1:shareSucc()
		end
	end
end

function RebelData:setNeedBattle(arg_15_1)
	self._isNeedBattle = arg_15_1
end

function RebelData:getNewestRebelElem()
	self._newestRebelElem = nil

	return self._newestRebelElem
end

function RebelData:isHotTime()
	local var_17_0 = g.core.config.time_event_info.match("id", 3)
	local var_17_1 = g.core.common.ServerTime:secondsFromToday(g.core.common.ServerTime:getTime())

	for iter_17_0 = 1, #var_17_0 do
		if var_17_1 > var_17_0[iter_17_0].open_time and var_17_1 < var_17_0[iter_17_0].end_time then
			return true
		end
	end

	return false
end

function RebelData:setTodayNotifyState(arg_18_1)
	local var_18_0 = os.date("*t", os.time())

	self._notifyData = self._notifyData or {}
	self._notifyData[var_18_0.year .. var_18_0.month .. var_18_0.day] = arg_18_1

	g.core.common.Storage:save("rebel_notify.json", {
		[var_18_0.year .. var_18_0.month .. var_18_0.day] = arg_18_1
	}, true)
end

function RebelData:isTodayNotify()
	self._notifyData = self._notifyData or g.core.common.Storage:load("rebel_notify.json", true) or {}

	local var_19_0 = os.date("*t", os.time())

	return not self._notifyData[var_19_0.year .. var_19_0.month .. var_19_0.day]
end

function RebelData:setMonsterVersion(arg_20_1)
	self._monsterVersion = arg_20_1

	self:_initLevelSeen2Real()
end

function RebelData:getSwitchMonsterTeamId(arg_21_1)
	local var_21_0 = g.core.config.monster_team_switch_info.get(arg_21_1)

	return (self._monsterVersion == 1 or nil) and (var_21_0.id or var_21_0["id_" .. self._monsterVersion])
end

function RebelData:setDisplayVersion(arg_22_1)
	self._displayVersion = arg_22_1
end

function RebelData:getDisplayVersion(arg_23_1)
	return self._displayVersion
end

function RebelData:_sortCompare(arg_24_1)
	if self:isMySelf() ~= arg_24_1:isMySelf() then
		return self:isMySelf()
	end

	local var_24_0 = self:getBaseInfo()
	local var_24_1 = arg_24_1:getBaseInfo()

	if var_24_0.quality ~= var_24_1.quality then
		return var_24_0.quality > var_24_1.quality
	end

	if self:getEndTime() ~= arg_24_1:getEndTime() then
		return self:getEndTime() > arg_24_1:getEndTime()
	end

	return var_24_0.id < var_24_1.id
end

function RebelData:setAttackTargetId(arg_25_1)
	self._attackTargetId = arg_25_1
end

function RebelData:getAttackTargetId()
	return self._attackTargetId
end

function RebelData:onS2CFlushRedPoint(arg_27_1)
	if not arg_27_1.rebel_hint then
		return
	end

	if arg_27_1.rebel_hint.level then
		self._dailyMaxLevel = arg_27_1.rebel_hint.level
	end

	if arg_27_1.rebel_hint.award_ids then
		for iter_27_0, iter_27_1 in ipairs(arg_27_1.rebel_hint.award_ids) do
			self._dailyAwards[tostring(iter_27_1)] = iter_27_1
		end
	end

	self._dailyMaxDamage = arg_27_1.rebel_hint.max_damage or 0
	self._dailyTotalDamage = arg_27_1.rebel_hint.total_damage or 0
end

function RebelData:isOneKeyGetEnable()
	if var_0_4:isModuleUnlock(var_0_3.REBEL_ONCE_GOT) and var_0_4:isModuleShow(var_0_3.REBEL_ONCE_GOT) then
		return self:isExistDailyReward()
	end
end

function RebelData:isExistDailyReward()
	for iter_29_0, iter_29_1 in var_0_0:ipairs() do
		if self._dailyMaxLevel >= iter_29_1.seen_grade_min and self._dailyMaxLevel <= iter_29_1.seen_grade_max then
			if math.uint64_lt(iter_29_1.damage, self._dailyTotalDamage, true) and self._dailyAwards[tostring(iter_29_1.id)] == nil then
				return true
			end
		end
	end
end

function RebelData:isRebelCntEnough()
	local var_30_0 = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_REBEL_ATTACK).time_limit

	return g.core.model.User.resourceData:getRebelAttack() > 0
end

function RebelData:setRebelInfoConnectTime(arg_31_1)
	self._rebelInfoConnectTime = arg_31_1
end

function RebelData:getRebelInfoConnectTime()
	return self._rebelInfoConnectTime
end

return RebelData
