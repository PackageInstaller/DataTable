local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventBoss = class("TeamBattleEventBoss", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventMonster")))

function TeamBattleEventBoss:ctor(arg_1_1)
	TeamBattleEventBoss.super.ctor(self, arg_1_1)

	self._killTime = 0
	self._bindUid = 0
	self._bindBossEventList = {}
	self._endTime = 0
end

function TeamBattleEventBoss:updateEvent(arg_2_1)
	TeamBattleEventBoss.super.updateEvent(self, arg_2_1)

	self._killTime = arg_2_1.kill_time or 0
	self._endTime = self._createTime + g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.BOSS_TIME_ID).parameter
	self._monsterInfo.endTime = self._endTime
	self._bindUid = arg_2_1.bind_user_id

	if self._killTime > 0 then
		self:onFinishEvent()

		self._monsterInfo.killUid = self._bindUid

		return
	end

	if not self:checkBossEventIsInTime() then
		self._state = TeamBattleConst.EVENT_STATE.EXPIRE
	end
end

function TeamBattleEventBoss:canTriggerEvent()
	if self:checkBossEventIsInTime() and self._state ~= TeamBattleConst.EVENT_STATE.FINISH then
		return TeamBattleEventBoss.super.canTriggerEvent(self)
	end

	return true
end

function TeamBattleEventBoss:onFinishEvent(arg_4_1)
	if not self._killTime and self:checkBossEventIsInTime() and not self:checkAllMemberIsDead() then
		return
	end

	TeamBattleEventBoss.super.onFinishEvent(self, arg_4_1)
end

function TeamBattleEventBoss:getBossLeftHpRatio()
	local var_5_0 = 0
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(self._monsterInfo.hpRatioList) do
		var_5_0 = var_5_0 + 1000
		var_5_1 = var_5_1 + iter_5_1
	end

	return math.floor(var_5_1 / var_5_0 * 1000)
end

function TeamBattleEventBoss:setBindBossEvent(arg_6_1)
	self._bindBossEventList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1 ~= self then
			self._bindBossEventList[#self._bindBossEventList + 1] = iter_6_1
		end
	end
end

function TeamBattleEventBoss:getBindUid()
	return self._bindUid
end

function TeamBattleEventBoss:checkBindUidIsSelf()
	return self._bindUid == g.core.model.User:getId()
end

function TeamBattleEventBoss:getAllBindBossEvent()
	return self._bindBossEventList
end

function TeamBattleEventBoss:checkBossEventIsInTime()
	return g.core.common.ServerTime:getTime() < self._endTime
end

function TeamBattleEventBoss:isInTime()
	if self._state ~= TeamBattleConst.EVENT_STATE.FINISH then
		if self:checkBossEventIsInTime() then
			return true
		else
			self._state = TeamBattleConst.EVENT_STATE.EXPIRE
		end
	else
		return true
	end
end

function TeamBattleEventBoss:getEndTime()
	return self._endTime
end

function TeamBattleEventBoss:checkAllMemberIsDead()
	for iter_13_0, iter_13_1 in ipairs(self._monsterInfo.hpRatioList) do
		if iter_13_1 > 1 then
			return false
		end
	end

	return true
end

function TeamBattleEventBoss:isKillOtherBoss()
	if self._state ~= TeamBattleConst.EVENT_STATE.FINISH then
		for iter_14_0, iter_14_1 in ipairs(self._bindBossEventList) do
			if iter_14_1:getState() == TeamBattleConst.EVENT_STATE.FINISH and iter_14_1:getBindUid() == g.core.model.User:getId() then
				return true
			end
		end
	end

	return false
end

return TeamBattleEventBoss
