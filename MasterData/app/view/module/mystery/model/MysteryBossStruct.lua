local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.model.User.mysteryBossData
local var_0_2 = g.core.const.ConstMgr.MysteryBossConst
local var_0_3 = g.core.config.parameter_info
local var_0_4 = g.core.model.User.shopData
local var_0_5 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_6 = g.core.common.ServerTime
local RankAward = require("app.core.common.RankAward")
local MysteryBossStruct = class("MysteryBossStruct")

function MysteryBossStruct:ctor(arg_1_1)
	self._bossCfg = arg_1_1
	self._bossId = arg_1_1.id
	self._roomUserCount = 0
	self._initHp = 1
	self._curHp = 0
	self._deadTime = 0
	self._createTime = 0
	self._killUserId = 0
	self._killedRecord = {}
	self._roomPosMap = {}
	self._roomUserMap = {}
	self._nextRebornTime = 0
	self._roomUserCount = 0

	self:_initBossRankAwards()
end

function MysteryBossStruct:_initBossRankAwards()
	self._rankAward = {}
	self._rankAward = RankAward:getRankAwardArray(var_0_2.RANK_AWARD_TYPE, self._bossId)
end

function MysteryBossStruct:isUnlockBoss()
	return var_0_0:getLastPassChapterId() >= self._bossCfg.unlock_id
end

function MysteryBossStruct:getBossId()
	return self._bossId
end

function MysteryBossStruct:getBossName()
	return self._bossCfg.name
end

function MysteryBossStruct:getBossType()
	return self._bossCfg.type
end

function MysteryBossStruct:getLeftCount()
	return self._bossCfg.type == var_0_2.BOSS_TYPE.NOMARL and var_0_4:getLeftCount(var_0_2.NOMARL_PLAY_NUM) or var_0_4:getLeftCount(var_0_2.LIMIT_PLAY_NUM)
end

function MysteryBossStruct:getBossConfig()
	return self._bossCfg
end

function MysteryBossStruct:getBossState()
	local var_9_0 = var_0_2.BOSS_STATE.LOCK

	if not self:isUnlockBoss() then
		var_9_0 = var_0_2.BOSS_STATE.LOCK
	elseif self:getBossType() == var_0_2.BOSS_TYPE.LIMIT and var_0_1:getDefaultBossType() ~= var_0_2.BOSS_TYPE.LIMIT then
		var_9_0 = var_0_2.BOSS_STATE.UNOPEN_LIMIT
	elseif not self:getBossAlive() then
		if self:getBossType() == var_0_2.BOSS_TYPE.LIMIT then
			local var_9_1 = g.core.common.ServerTime:getWeekDay()

			if var_9_1 == 0 then
				var_9_1 = 7
			end

			var_9_0 = var_9_1 == 7 and not var_0_1:hasLeftLimitBossCnt() and var_0_2.BOSS_STATE.UNOPEN_LIMIT or var_0_2.BOSS_STATE.WAIT
		else
			var_9_0 = var_0_2.BOSS_STATE.WAIT
		end
	else
		var_9_0 = self._curHp < self._initHp and var_0_2.BOSS_STATE.FIGHTING or var_0_2.BOSS_STATE.CAN_BATTLE
	end

	return var_9_0
end

function MysteryBossStruct:getBossMonsterInfo()
	local var_10_0 = g.core.config.monster_team_info.fetch(self._bossCfg.monster_id, 1)

	if var_10_0 then
		return (g.core.config.monster_info.get(var_10_0.monster_1))
	end

	return {}
end

function MysteryBossStruct:getBossInfoRankAwards()
	return self._rankAward
end

function MysteryBossStruct:getAwardsByRankIdx(arg_12_1)
	return (RankAward:getAwardByRank(self._rankAward, arg_12_1))
end

function MysteryBossStruct:getPosAwardData()
	local var_13_0 = {}

	if self._bossCfg.type == var_0_2.BOSS_TYPE.LIMIT and self._bossCfg.special_award > 0 then
		table.insert(var_13_0, {
			rankIdx = 0,
			damage = self._bossCfg.buff_special / 10,
			award = g.core.common.Drops:getGoodsArray(self._bossCfg.special_award)
		})
	end

	for iter_13_0 = 1, var_0_2.NORMAL_POS_NUM do
		table.insert(var_13_0, {
			rankIdx = iter_13_0,
			damage = self._bossCfg.buff_normal / 10,
			award = g.core.common.Drops:getGoodsArray(self._bossCfg.reward)
		})
	end

	return var_13_0
end

function MysteryBossStruct:setBossSvrData(arg_14_1)
	self._nextRebornTime = arg_14_1.reborn_time or 0
	self._roomUserCount = arg_14_1.user_num or 0

	if arg_14_1.room then
		self._initHp = arg_14_1.room.hp or 0
		self._curHp = arg_14_1.room.hp_left or 0
		self._deadTime = arg_14_1.room.dead_time or 0
		self._createTime = arg_14_1.room.create_time or 0
		self._killUserId = arg_14_1.room.killer_id or 0
		self._killedRecord = arg_14_1.room.history_killers or {}
	end
end

function MysteryBossStruct:setBossCurHp(arg_15_1)
	self._curHp = arg_15_1
end

function MysteryBossStruct:getBossAlive()
	return not (self._deadTime > 0 or self._nextRebornTime > 0)
end

function MysteryBossStruct:getBossCreateTime()
	return self._createTime
end

function MysteryBossStruct:getRebornCD()
	return (not self:getBossAlive() or nil) and self._nextRebornTime - var_0_6:getTime()
end

function MysteryBossStruct:getBossRoomCount()
	return self._roomUserCount
end

function MysteryBossStruct:getBossInitHp()
	return self._initHp
end

function MysteryBossStruct:getBossCurHp()
	return self._curHp
end

function MysteryBossStruct:getHistoryKillers()
	return self._killedRecord
end

function MysteryBossStruct:updateBossRoomUserInfo(arg_23_1)
	self._roomPosMap = {}
	self._roomUserMap = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		self._roomPosMap[iter_23_1.pos] = self._roomPosMap[iter_23_1.pos] or {}
		self._roomPosMap[iter_23_1.pos] = iter_23_1
		self._roomUserMap[iter_23_1.user_id] = self._roomUserMap[iter_23_1.user_id] or {}
		self._roomUserMap[iter_23_1.user_id] = iter_23_1
	end
end

function MysteryBossStruct:changeUserPos(arg_24_1, arg_24_2)
	if self._roomUserMap[arg_24_1] then
		self._roomPosMap[self._roomUserMap[arg_24_1].pos] = nil
	end

	local var_24_0 = self._roomPosMap[arg_24_2]
	local var_24_2

	if self._roomPosMap[arg_24_2] then
		local var_24_1 = g.core.model.User:getId()

		if arg_24_1 == var_24_1 then
			var_0_1:setOldPosUserId(var_24_0.user_id)
		end

		if var_24_0.user_id == var_24_1 then
			self._roomPosMap[0] = var_24_0
			self._roomUserMap[var_24_1].pos = 0
		else
			self._roomPosMap[arg_24_2] = nil
			self._roomUserMap[var_24_0.user_id] = nil
			var_24_2 = {
				user_id = arg_24_1,
				pos = arg_24_2
			}
		end
	end

	var_24_2.last_hold_time = var_0_6:getTime()
	self._roomPosMap[arg_24_2] = var_24_2
	self._roomUserMap[arg_24_1] = self._roomPosMap[arg_24_2]
end

function MysteryBossStruct:getBossUserDataByPos(arg_25_1)
	return self._roomPosMap[arg_25_1]
end

function MysteryBossStruct:getMysteryBossPosByUserId(arg_26_1)
	return self._roomUserMap[arg_26_1]
end

function MysteryBossStruct:updateUserLeave(arg_27_1)
	if self._roomUserMap[arg_27_1] then
		if self._roomPosMap[self._roomUserMap[arg_27_1].pos] then
			self._roomPosMap[self._roomUserMap[arg_27_1].pos] = nil
			self._roomUserMap[arg_27_1] = nil
		end
	end
end

function MysteryBossStruct:getMySelfPos()
	local var_28_1 = g.core.model.User:getId()

	return (self._roomUserMap[var_28_1] or nil) and self._roomUserMap[var_28_1].pos
end

function MysteryBossStruct:isProtectPos(arg_29_1)
	local var_29_0 = false

	if self._roomPosMap[arg_29_1] then
		if self:getBossType() == var_0_2.BOSS_TYPE.LIMIT and arg_29_1 == var_0_2.LIMIT_SPECIAL_POS then
			local var_29_1 = self:getBossInitHp()

			if var_29_1 > 0 and self:getBossCurHp() / var_29_1 <= var_0_3.get(var_0_5.MYSTERYBOSS_HP_PROTECT).parameter / 1000 then
				var_29_0 = true
			end
		end

		var_29_0 = var_29_0 or var_0_3.get(var_0_5.MYSTERYBOSS_PROTECT_TIME).parameter >= var_0_6:getTime() - (self._roomPosMap[arg_29_1].last_hold_time or 0)
	end

	return var_29_0
end

function MysteryBossStruct:isLimitLowHpSpecialPosProtect()
	local var_30_0 = false

	if self:getBossType() == var_0_2.BOSS_TYPE.LIMIT and self:getMySelfPos() == var_0_2.LIMIT_SPECIAL_POS then
		if self:getBossAlive() and self:getBossCurHp() / self:getBossInitHp() <= var_0_3.get(var_0_5.MYSTERYBOSS_LOWHP_POS_PROTECT).parameter / 1000 then
			var_30_0 = true
		end
	end

	return var_30_0
end

return MysteryBossStruct
