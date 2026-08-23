local var_0_0 = g.core.config.mystery_boss_info
local var_0_1 = g.core.config.mystery_boss_time_info
local var_0_2 = g.core.model.User.mysteryData
local var_0_3 = g.core.const.ConstMgr.MysteryBossConst
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.config.parameter_info
local var_0_6 = g.core.const.ConstMgr.PARAMETER_CONST
local MysteryBossStruct = require("app.view.module.mystery.model.MysteryBossStruct")
local MysteryBossData = class("MysteryBossData")

function MysteryBossData:ctor()
	self._bossInfoIdMap = {}
	self._bossInfoTypeMap = {}
	self._limitBossOpenTimeDict = {}
	self._curBossId = 0
	self._isCanBackRoom = false
	self._challengeTag = false
	self._lastAttackUserTs = 0
	self._lastAttackBossTs = 0
	self._oldPosUserId = 0

	self:initData()
end

function MysteryBossData:initData()
	self:_initMysteryBossData()
	self:_initLimitBossOpenTime()
end

function MysteryBossData:_initMysteryBossData()
	self._bossInfoIdMap = {}
	self._bossInfoTypeMap = {}

	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		local var_3_1 = MysteryBossStruct.new(iter_3_1)

		self._bossInfoIdMap[iter_3_1.id] = var_3_1
		self._bossInfoTypeMap[iter_3_1.type] = self._bossInfoTypeMap[iter_3_1.type] or {}

		table.insert(self._bossInfoTypeMap[iter_3_1.type], var_3_1)
	end
end

function MysteryBossData:_initLimitBossOpenTime()
	self._limitBossOpenTimeDict = {}

	for iter_4_0, iter_4_1 in var_0_1.ipairs() do
		self._limitBossOpenTimeDict[iter_4_1.weekday] = self._limitBossOpenTimeDict[iter_4_1.weekday] or {}

		table.insert(self._limitBossOpenTimeDict[iter_4_1.weekday], iter_4_1)
	end
end

function MysteryBossData:getDefaultBossType()
	local var_5_0 = g.core.common.ServerTime:getWeekDay()

	if var_5_0 == 0 then
		var_5_0 = 7
	end

	if self._limitBossOpenTimeDict[var_5_0] then
		table.sort(self._limitBossOpenTimeDict[var_5_0], function(arg_6_0, arg_6_1)
			return arg_6_0.time < arg_6_1.time
		end)

		local var_5_1 = g.core.common.ServerTime:getDateObject()

		if var_5_1.hour >= self._limitBossOpenTimeDict[var_5_0][1].time and var_5_1.hour <= self._limitBossOpenTimeDict[var_5_0][#self._limitBossOpenTimeDict[var_5_0]].time then
			return var_0_3.BOSS_TYPE.LIMIT
		end
	end

	return var_0_3.BOSS_TYPE.NOMARL
end

function MysteryBossData:getOpenLimitTime()
	local var_7_0 = 0
	local var_7_1 = g.core.common.ServerTime:getWeekDay()

	if var_7_1 == 0 then
		var_7_1 = 7
	end

	if self._limitBossOpenTimeDict[var_7_1] then
		table.sort(self._limitBossOpenTimeDict[var_7_1], function(arg_8_0, arg_8_1)
			return arg_8_0.time < arg_8_1.time
		end)

		local var_7_2 = g.core.common.ServerTime:getDateObject()

		if var_7_2.hour < self._limitBossOpenTimeDict[var_7_1][1].time then
			var_7_0 = (self._limitBossOpenTimeDict[var_7_1][1].time - var_7_2.hour) * 3600 - var_7_2.min * 60 - var_7_2.sec
		elseif var_7_2.hour > self._limitBossOpenTimeDict[var_7_1][#self._limitBossOpenTimeDict[var_7_1]].time and var_7_1 == 6 then
			local var_7_3 = 0

			if self._limitBossOpenTimeDict[var_7_1 + 1] then
				table.sort(self._limitBossOpenTimeDict[var_7_1 + 1], function(arg_9_0, arg_9_1)
					return arg_9_0.time < arg_9_1.time
				end)

				var_7_3 = self._limitBossOpenTimeDict[var_7_1 + 1][1].time
			end

			var_7_0 = (24 - var_7_2.hour) * 3600 - var_7_2.min * 60 - var_7_2.sec + var_7_3 * 3600
		end
	end

	return var_7_0
end

function MysteryBossData:hasLeftLimitBossCnt()
	local var_10_0 = g.core.common.ServerTime:getWeekDay()

	if var_10_0 == 0 then
		var_10_0 = 7
	end

	if self._limitBossOpenTimeDict[var_10_0] then
		local var_10_1 = math.ceil(g.core.common.ServerTime:getTimeFromZero(g.core.common.ServerTime:getTime()) / 3600)

		table.sort(self._limitBossOpenTimeDict[var_10_0], function(arg_11_0, arg_11_1)
			return arg_11_0.time < arg_11_1.time
		end)

		for iter_10_0, iter_10_1 in ipairs(self._limitBossOpenTimeDict[var_10_0]) do
			if var_10_1 <= iter_10_1.time then
				return true
			end
		end
	end

	return false
end

function MysteryBossData:getRecommendBoss()
	local var_12_0 = var_0_2:getLastPassChapterId()

	if self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL] and next(self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL]) then
		table.sort(self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL], function(arg_13_0, arg_13_1)
			return arg_13_0:getBossConfig().unlock_id < arg_13_1:getBossConfig().unlock_id
		end)

		local var_12_1 = self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL][1]

		for iter_12_0, iter_12_1 in ipairs(self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL]) do
			if var_12_0 >= iter_12_1:getBossConfig().unlock_id then
				var_12_1 = iter_12_1
			end
		end

		return var_12_1
	end

	return nil
end

function MysteryBossData:getBossDataById(arg_14_1)
	return self._bossInfoIdMap[arg_14_1]
end

function MysteryBossData:getBossDatasByType(arg_15_1)
	return self._bossInfoTypeMap[arg_15_1]
end

function MysteryBossData:getBossRoomMaxUserCount()
	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MYSTERYBOSS_MAX_USER_COUNT).parameter
end

function MysteryBossData:getNormalBossChallengeTime()
	return g.core.model.User.shopData:getLeftCount(var_0_3.NOMARL_PLAY_NUM) or 0
end

function MysteryBossData:getLimitBossChallengeTime()
	return g.core.model.User.shopData:getLeftCount(var_0_3.LIMIT_PLAY_NUM) or 0
end

function MysteryBossData:onS2CMysteryBossGetInfo(arg_19_1)
	if arg_19_1.rooms then
		for iter_19_0, iter_19_1 in ipairs(arg_19_1.rooms) do
			if self._bossInfoIdMap[iter_19_1.room.id] then
				self._bossInfoIdMap[iter_19_1.room.id]:setBossSvrData(iter_19_1)
			end
		end
	end

	if arg_19_1.info and arg_19_1.info.room_id > 0 then
		local var_19_0 = self:getBossDataById(arg_19_1.info.room_id)

		if var_19_0 then
			if arg_19_1.info.room_create_time > 0 and arg_19_1.info.room_create_time == var_19_0:getBossCreateTime() and var_19_0:getBossAlive() then
				self._curBossId = arg_19_1.info.room_id
			end
		end
	end
end

function MysteryBossData:updateBossSvrData(arg_20_1)
	if self._bossInfoIdMap[arg_20_1.room.id] then
		self._bossInfoIdMap[arg_20_1.room.id]:setBossSvrData(arg_20_1)
	end
end

function MysteryBossData:onS2CMysteryBossEnterRoom(arg_21_1)
	if arg_21_1.id then
		self._curBossId = arg_21_1.id
	end

	if arg_21_1.room_snapshot then
		self:updateBossSvrData(arg_21_1.room_snapshot)
	end

	if arg_21_1.users then
		self:getBossDataById(self._curBossId):updateBossRoomUserInfo(arg_21_1.users)
	end
end

function MysteryBossData:onS2CMysteryBossLeaveRoom()
	self:resetBossData()
end

function MysteryBossData:resetBossData()
	self._curBossId = 0
	self._lastAttackBossTs = 0
	self._lastAttackUserTs = 0
end

function MysteryBossData:onS2CMysteryBossPosChallengeFinish(arg_24_1)
	if arg_24_1.is_win then
		self:getBossDataById(self._curBossId):changeUserPos(g.core.model.User:getId(), arg_24_1.pos)
	end

	self:setLastAttackUserTime()
end

function MysteryBossData:setOldPosUserId(arg_25_1)
	self._oldPosUserId = arg_25_1
end

function MysteryBossData:getOldPosUserId()
	return self._oldPosUserId
end

function MysteryBossData:onS2CBossChallengeFinish(arg_27_1)
	local var_27_0 = self:getBossDataById(self._curBossId)

	if var_27_0 then
		var_27_0:setBossCurHp(arg_27_1.hp_left)
	end

	self:setLastAttackBossTime()
end

function MysteryBossData:onS2CMysteryBossNotifyPosChallenge(arg_28_1)
	if arg_28_1.id then
		self:getBossDataById(arg_28_1.id):changeUserPos(arg_28_1.user_id, arg_28_1.target_pos)
	end
end

function MysteryBossData:onS2CMysteryBossNotifyBossChallenge(arg_29_1)
	if arg_29_1.room_snapshot then
		self:updateBossSvrData(arg_29_1.room_snapshot)
	end
end

function MysteryBossData:onS2CMysteryBossNotifyLeave(arg_30_1)
	if arg_30_1.room_snapshot then
		self:updateBossSvrData(arg_30_1.room_snapshot)
	end

	if arg_30_1.user_id then
		local var_30_0 = self:getBossDataById(self._curBossId)

		if var_30_0 then
			var_30_0:updateUserLeave(arg_30_1.user_id)
		end
	end
end

function MysteryBossData:onS2CMysteryBossNotifyAwards(arg_31_1)
	self._notifyAwardData = arg_31_1
end

function MysteryBossData:cleanResultAwards()
	self._notifyAwardData = nil
end

function MysteryBossData:getMysteryBossNotifyAwards()
	return self._notifyAwardData
end

function MysteryBossData:onS2CMysteryBossNotifyBossDead(arg_34_1)
	if arg_34_1.room_snapshot then
		self:updateBossSvrData(arg_34_1.room_snapshot)
	end

	self:resetBossData()
end

function MysteryBossData:onS2CMysteryBossNotifyDisband()
	self:resetBossData()
end

function MysteryBossData:getCurBossId()
	return self._curBossId
end

function MysteryBossData:onS2CRedPoint(arg_37_1)
	self._isCanBackRoom = arg_37_1.can_back_room or false
end

function MysteryBossData:isCanReturnBossRoom()
	return self._isCanBackRoom
end

function MysteryBossData:cleanRenturnRoomTag()
	self._isCanBackRoom = false
end

function MysteryBossData:hasMysteryBossChallengeCount()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MYSTERY_BOSS) then
		return false
	end

	if self:getDefaultBossType() == var_0_3.BOSS_TYPE.LIMIT then
		for iter_40_0, iter_40_1 in pairs(self._bossInfoIdMap) do
			if iter_40_1:getLeftCount() > 0 then
				return true
			end
		end
	elseif self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL] then
		for iter_40_2, iter_40_3 in pairs(self._bossInfoTypeMap[var_0_3.BOSS_TYPE.NOMARL]) do
			if iter_40_3:getLeftCount() > 0 then
				return true
			end
		end
	end

	return false
end

function MysteryBossData:setLastAttackUserTime()
	self._lastAttackUserTs = var_0_4:getTime()
end

function MysteryBossData:setLastAttackBossTime()
	self._lastAttackBossTs = var_0_4:getTime()
end

function MysteryBossData:isSelfAttackUserCD()
	local var_43_1 = math.max(self._lastAttackUserTs + var_0_5.get(var_0_6.MYSTERYBOSS_CHALLENGE_CD).parameter, 0)

	return (var_43_1 >= var_0_4:getTime() or nil) and true, var_43_1
end

function MysteryBossData:isSelfAttackBossCD()
	local var_44_1 = math.max(self._lastAttackBossTs + var_0_5.get(var_0_6.MYSTERYBOSS_ATTACK_INTERVAL).parameter, 0)

	return (var_44_1 >= var_0_4:getTime() or nil) and true, var_44_1
end

return MysteryBossData
