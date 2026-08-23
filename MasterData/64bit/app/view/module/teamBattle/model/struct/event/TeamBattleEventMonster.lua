local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventMonster = class("TeamBattleEventMonster", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventMonster:ctor(arg_1_1)
	TeamBattleEventMonster.super.ctor(self, arg_1_1)

	self._monsterInfo = {
		monsterId = -1,
		tp = -1,
		lockTime = 0,
		killUid = -1,
		diff = 0,
		hpRatioList = {}
	}
end

function TeamBattleEventMonster:triggerEvent()
	self._state = TeamBattleConst.EVENT_STATE.WAIT_TRIGGER
end

function TeamBattleEventMonster:updateEvent(arg_3_1, arg_3_2)
	TeamBattleEventMonster.super.updateEvent(self, arg_3_1)

	if self._monsterInfo.monsterId < 1 then
		self:_createMonster(arg_3_1.monster_id)
	end

	self._monsterInfo.tp = arg_3_1.monster_tp

	if self._monsterInfo.tp == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1 or self._monsterInfo.tp == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2 or self._monsterInfo.tp == TeamBattleConst.EVENT_STATE.GUARD then
		self._monsterInfo.scale = 1.2
	end

	self._monsterInfo.hpRatioList = arg_3_1.hp_left or self._monsterInfo.hpRatioList
	self._monsterInfo.killUid = arg_3_1.kill_user_id or 0
	self._monsterInfo.lockTime = arg_3_1.lock_time or 0

	if self._monsterInfo.killUid > 0 then
		self:onFinishEvent()
	elseif self._monsterInfo.lockTime + 600 > g.core.common.ServerTime:getTime() then
		self:lockEvent()
	end
end

function TeamBattleEventMonster:canTriggerEvent()
	if self._monsterInfo.lockTime + 600 <= g.core.common.ServerTime:getTime() and self._state ~= TeamBattleConst.EVENT_STATE.FINISH then
		self:triggerEvent()
	end

	return TeamBattleEventMonster.super.canTriggerEvent(self)
end

function TeamBattleEventMonster:requestFinishEvent(arg_5_1)
	return
end

function TeamBattleEventMonster:onFinishEvent(arg_6_1)
	if arg_6_1 and arg_6_1.kill_user_id then
		self._monsterInfo.killUid = arg_6_1.kill_user_id
		self._monsterInfo.needPlayDied = true
	end

	for iter_6_0 = 1, #self._monsterInfo.hpRatioList do
		self._monsterInfo.hpRatioList[iter_6_0] = 0
	end

	TeamBattleEventMonster.super.onFinishEvent(self, arg_6_1)
end

function TeamBattleEventMonster:getUIInfo()
	local var_7_0 = {
		knightInfo = self._monsterInfo
	}

	var_7_0.scale = self._monsterInfo.scale or 1

	return var_7_0
end

function TeamBattleEventMonster:getEventInfo()
	local var_8_0 = TeamBattleEventMonster.super.getEventInfo(self)

	var_8_0.monsterInfo = self._monsterInfo

	return var_8_0
end

function TeamBattleEventMonster:_createMonster(arg_9_1)
	self._monsterInfo.monsterId = arg_9_1

	local var_9_0 = g.core.config.team_battle_monster_info.get(arg_9_1)

	self._monsterInfo.diff = var_9_0.Grade
	self._monsterInfo.name = self:_getRandomName(var_9_0.guard_name, arg_9_1)
	self._monsterInfo.roomId = self._belongRoom

	if TeamBattleConst.EVENT_TYPE.GUARD == self._type then
		if self._monsterInfo.diff == 1 then
			self._monsterInfo.resId = 302120
		elseif self._monsterInfo.diff == 2 then
			self._monsterInfo.resId = 301020
		elseif self._monsterInfo.diff >= 3 then
			self._monsterInfo.resId = 302420
		end
	else
		self._monsterInfo.resId = TeamBattleConst.EVENT_TYPE.ROBBER == self._type and 301010 or 302420
	end

	local var_9_1 = 1
	local var_9_2 = 0
	local var_9_3

	self._monsterInfo.knightList = {}

	while g.core.config.team_battle_monster_info.hasKey("monster_" .. 1) do
		if var_9_0["monster_" .. 1] ~= 0 then
			local var_9_4 = g.core.config.massive_monster_team_info.get(var_9_0["monster_" .. 1])

			if var_9_2 < var_9_4.fight then
				var_9_3 = var_9_4
				var_9_2 = var_9_4.fight
			end

			local var_9_5 = 1

			while g.core.config.massive_monster_team_info.hasKey("knight_id_" .. 1) do
				self._monsterInfo.knightList[#self._monsterInfo.knightList + 1] = var_9_4["knight_id_" .. 1]
				self._monsterInfo.hpRatioList[#self._monsterInfo.hpRatioList + 1] = 1000
				var_9_5 = var_9_5 + 1
			end
		end

		var_9_1 = var_9_1 + 1
	end

	self._monsterInfo.spineId = g.core.config.knight_info.get(var_9_3.knight_id_1).res_id
	self._monsterInfo.fight = var_9_2 or 0
end

function TeamBattleEventMonster:_getRandomName(arg_10_1, arg_10_2)
	local var_10_0 = g.core.config.team_battle_monster_name_info.match(function(arg_11_0)
		return arg_11_0.name_group == arg_10_1
	end)

	return var_10_0[math.max(1, arg_10_2 * g.core.model.User.teamBattleData:getActivityId() % (#var_10_0 + 1))].monster_name
end

function TeamBattleEventMonster:getKillUid()
	return self._monsterInfo.killUid
end

function TeamBattleEventMonster:updateMonsterHp(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self._monsterInfo.hpRatioList[iter_13_0] = iter_13_1
	end
end

return TeamBattleEventMonster
