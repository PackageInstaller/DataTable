local var_0_0 = g.core.config.monster_info
local var_0_1 = g.core.config.monster_team_info
local var_0_2 = g.core.config.gve_boss_info
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local GveKnightStruct = class("GveKnightStruct")

function GveKnightStruct:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._bossId = arg_1_1
	self._posX = arg_1_2
	self._posY = arg_1_3
	self._bossInfo = var_0_2.get(arg_1_1)
	self._bossData = {}
	self._monsterDataList = {}
	self._bossRankAwardList = {}
	self._allRankAwardList = nil
	self._isGetServerBossDead = false
	self._isRefresh = false
	self._challengeCount = 0
	self._deadTime = 0
	self._damageMax = 0
	self._expireTime = 0

	self:_initData()
end

function GveKnightStruct:_initData()
	self._bossData = {
		isDead = true,
		curTotalHp = 0,
		maxTotalHp = 0,
		monsterTeamInfo = {},
		hpList = {}
	}

	while var_0_2.hasKey("guard_" .. 1) do
		local var_2_0

		if self._bossInfo["guard_" .. 1] > 0 then
			self._monsterDataList[1] = {
				curTotalHp = 0,
				maxTotalHp = 0,
				monsterTeamInfo = {},
				showPos = self._bossInfo["guard_" .. 1 .. "_elite"],
				hpList = {},
				guardIndex = 1,
				wave = 1
			}
			var_2_0 = 1 + 1
		end
	end
end

function GveKnightStruct:refreshMaxHp()
	if self._isRefresh then
		return
	end

	self._isRefresh = true

	local var_3_0 = var_0_1.get(self._bossInfo.boss_team, 1)

	self._bossData.monsterTeamInfo = var_3_0
	self._bossData.maxTotalHp = self:_getTotalHpByInfo(var_3_0)

	for iter_3_0, iter_3_1 in pairs(self._monsterDataList) do
		local var_3_1 = var_0_1.fetch(self._bossInfo["guard_" .. iter_3_0], 1)

		iter_3_1.monsterTeamInfo = var_3_1
		iter_3_1.maxTotalHp = self:_getTotalHpByInfo(var_3_1)
	end
end

function GveKnightStruct:getInfo()
	return self._bossInfo
end

function GveKnightStruct:isGetServerBossDead()
	return self._isGetServerBossDead
end

function GveKnightStruct:getBossData()
	self:refreshMaxHp()

	return self._bossData
end

function GveKnightStruct:_getTotalHpByInfo(arg_7_1)
	local var_7_0 = 0

	for iter_7_0 = 1, 6 do
		if arg_7_1["monster_" .. iter_7_0] > 0 then
			var_7_0 = var_7_0 + var_0_0.get(arg_7_1["monster_" .. iter_7_0]).initial_hp
		end
	end

	return var_7_0
end

function GveKnightStruct:updateBossData(arg_8_1)
	self._bossData.hpList = arg_8_1.boss_hp or {}

	local var_8_0 = self:_getTotalHpByProto(arg_8_1.boss_hp)

	self._bossData.curTotalHp = var_8_0
	self._bossData.isDead = var_8_0 <= 0
	self._expireTime = arg_8_1.expire_time or 0

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1.boss_guard or {}) do
		var_8_1[iter_8_1.id] = true

		if self._monsterDataList[iter_8_1.id] then
			self._monsterDataList[iter_8_1.id].hpList = iter_8_1.guard_hp
			self._monsterDataList[iter_8_1.id].curTotalHp = self:_getTotalHpByProto(iter_8_1.guard_hp)
		end
	end
end

function GveKnightStruct:setBossIsDead(arg_9_1, arg_9_2)
	if arg_9_2 == 0 then
		self._isGetServerBossDead = true
		self._bossData.isDead = arg_9_1 == true
	else
		local var_9_0 = self._monsterDataList[arg_9_2]

		if self._monsterDataList[arg_9_2] then
			var_9_0.hpList = {}
			var_9_0.curTotalHp = 0
		end
	end
end

function GveKnightStruct:_getTotalHpByProto(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_1 or {}) do
		var_10_0 = var_10_0 + iter_10_1
	end

	return var_10_0
end

function GveKnightStruct:isDeadByIndex(arg_11_1)
	if (arg_11_1 or 0) == 0 then
		return self._bossData.isDead == true
	end

	for iter_11_0, iter_11_1 in pairs((self._monsterDataList[arg_11_1] or {}).hpList or {}) do
		if iter_11_1 > 0 then
			return false
		end
	end

	return true
end

function GveKnightStruct:isAllMonsterDead()
	for iter_12_0, iter_12_1 in pairs(self._monsterDataList) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1.hpList or {}) do
			if iter_12_3 > 0 then
				return false
			end
		end
	end

	return true
end

function GveKnightStruct:getHpByIndexAndPos(arg_13_1, arg_13_2)
	return (arg_13_1 == 0 and (self._bossData.hpList or {}) or (self._monsterDataList[arg_13_1] or {}).hpList or {})[arg_13_2] or 0
end

function GveKnightStruct:getMonsterList()
	local var_14_0 = table.values(self._monsterDataList)

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		if arg_15_0.curTotalHp == 0 ~= (arg_15_1.curTotalHp == 0) then
			return arg_15_0.curTotalHp ~= 0
		end

		return arg_15_0.guardIndex < arg_15_1.guardIndex
	end)

	return table.values(var_14_0)
end

function GveKnightStruct:getAllBossRankAwardList()
	local var_16_0 = g.core.model.User.gveDataMgr:getGveBaseId()

	if self._allRankAwardList then
		return self._allRankAwardList
	end

	local var_16_2 = {}

	for iter_16_0, iter_16_1 in pairs((g.core.config.rank_award_info.match(function(arg_17_0)
		return arg_17_0.rank_type == self._bossInfo.rank_award_1 and arg_17_0.activity_id == var_16_0
	end))) do
		self:_addAwardList(iter_16_1, var_16_2)
	end

	for iter_16_2, iter_16_3 in pairs((g.core.config.rank_award_info.match(function(arg_18_0)
		return arg_18_0.rank_type == self._bossInfo.rank_award_2 and arg_18_0.activity_id == var_16_0
	end))) do
		self:_addAwardList(iter_16_3, var_16_2)
	end

	local var_16_3 = table.values(var_16_2)

	table.sort(var_16_3, function(arg_19_0, arg_19_1)
		if arg_19_0.quality == arg_19_1.quality then
			return arg_19_0.info.id > arg_19_1.info.id
		end

		return arg_19_0.quality > arg_19_1.quality
	end)

	self._allRankAwardList = var_16_3

	return var_16_3
end

function GveKnightStruct:_addAwardList(arg_20_1, arg_20_2)
	for iter_20_0 = 1, 4 do
		if arg_20_1["reward_type" .. iter_20_0] and arg_20_1["reward_type" .. iter_20_0] ~= 0 then
			arg_20_2[arg_20_1["reward_type" .. iter_20_0] .. "_" .. arg_20_1["reward_value" .. iter_20_0]] = arg_20_2[arg_20_1["reward_type" .. iter_20_0] .. "_" .. arg_20_1["reward_value" .. iter_20_0]] or var_0_3:convert({
				size = 1,
				type = arg_20_1["reward_type" .. iter_20_0],
				value = arg_20_1["reward_value" .. iter_20_0]
			})
		end
	end
end

function GveKnightStruct:getBossRankAwardList(arg_21_1)
	self._bossRankAwardList[arg_21_1] = self._bossRankAwardList[arg_21_1] or RankAward:getRankAwardArray(var_0_4.GVE, arg_21_1)

	return self._bossRankAwardList
end

function GveKnightStruct:isRandBoss()
	if not self._bossInfo then
		return false
	end

	return self._bossInfo.boss_type == 2
end

function GveKnightStruct:updateChallengeState(arg_23_1, arg_23_2, arg_23_3)
	self._challengeCount = arg_23_1
	self._deadTime = arg_23_2
	self._damageMax = arg_23_3
end

function GveKnightStruct:isTodayOpenChallenge()
	return not g.core.common.ServerTime:isToday(self._deadTime)
end

function GveKnightStruct:getFinalRewardTime()
	return self._challengeCount
end

function GveKnightStruct:getFinalDamageMax()
	return self._damageMax
end

function GveKnightStruct:getExpireTime()
	return self._expireTime
end

function GveKnightStruct:hasExpireTime()
	return self._bossInfo.end_time > 0
end

function GveKnightStruct:checkBossCanChallenge()
	if self._expireTime == 0 then
		return true
	end

	return g.core.common.ServerTime:getTime() <= self._expireTime
end

function GveKnightStruct:updateBossExpireTime(arg_30_1)
	self._expireTime = arg_30_1 or 0
end

return GveKnightStruct
