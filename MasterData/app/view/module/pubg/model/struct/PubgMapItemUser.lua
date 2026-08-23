local var_0_0 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_1 = g.core.model.User.snapShotCacheData
local var_0_2 = g.core.config.pubg_level_info
local var_0_3 = g.core.config.pubg_buff_info
local var_0_4 = g.core.config.pubg_effect_info
local var_0_5 = g.core.config.pubg_robot_info
local var_0_6 = g.core.const.ConstMgr.PubgConst
local var_0_7 = g.core.common.ServerTime
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local var_0_9 = math.max
local PubgMapItemUser = class("PubgMapItemUser", (require("app.view.module.pubg.model.struct.PubgMapItemBase")))

function PubgMapItemUser:ctor(arg_1_1)
	PubgMapItemUser.super.ctor(self, arg_1_1)

	self._type = g.core.const.ConstMgr.PubgConst.map.itemType.knight
	self._snapShot = nil
	self._visualField = g.core.model.User.pubgData:getParams(var_0_6.Params.FGO_VIEW)
	self._attackRange = g.core.model.User.pubgData:getParams(var_0_6.Params.ATTACK_RANGE)
	self._hp = g.core.model.User.pubgData:getParams(var_0_6.Params.INIT_HP)
	self._moveDelayTime = g.core.model.User.pubgData:getParams(var_0_6.Params.MOVE_DELAY_TIME) * 0.001
	self._moveActionTime = g.core.model.User.pubgData:getParams(var_0_6.Params.MOVE_ACTION_TIME) * 0.001
	self._moveRoute = {}
	self._moveIncrement = 0
	self._lockMoveTime = 0
	self._moveActionIncrement = 0
	self._isDead = false
	self._score = 0
	self._fightValue = 0
	self._robotId = 0
	self._recoverTime = 0
	self._level = 1
	self._exp = 0
	self._addExp = 0
	self._winCount = 0
	self._failCount = 0
	self._buffDict = {}
	self._airBuffDict = {}
	self._invincibleTime = 0
	self._startInvincibleTime = 0
	self._lastIsInvincible = false
	self._attackCd = 0
	self._oldPos = {
		x = 0,
		y = 0
	}
	self._movingPos = nil
	self._targetOnlyId = ""
	self._isMe = self:getUid() == g.core.model.User:getId()
	self._robotSnapShot = nil
end

function PubgMapItemUser:setData(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._level = arg_2_1.level or self._level
	self._score = arg_2_1.score or self._score
	self._fightValue = arg_2_1.fight_value or self._fightValue
	self._robotId = arg_2_1.robot_id or self._robotId
	self._recoverTime = arg_2_1.recover_time or self._recoverTime
	self._invincibleTime = arg_2_1.invincible_time or self._invincibleTime
	self._isDead = arg_2_1.dead or self._isDead

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.buffs or {}) do
		self:addBuff(iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.effects or {}) do
		self:addAirBuff(iter_2_3)
	end

	self:setPosXY(arg_2_1.x, arg_2_1.y)
end

function PubgMapItemUser:getRobotId()
	return self._robotId
end

function PubgMapItemUser:addWinCount()
	self._winCount = self._winCount + 1
end

function PubgMapItemUser:addFailCount()
	self._failCount = self._failCount + 1
end

function PubgMapItemUser:getWinCount()
	return self._winCount
end

function PubgMapItemUser:getFailCount()
	return self._failCount
end

function PubgMapItemUser:setHp(arg_8_1)
	self._hp = arg_8_1
end

function PubgMapItemUser:getHp()
	return self._hp
end

function PubgMapItemUser:setLevel(arg_10_1)
	self._level = arg_10_1
end

function PubgMapItemUser:getLevel()
	return self._level
end

function PubgMapItemUser:getLevelProgress()
	local var_12_0 = var_0_2.fetch(self._level)

	if not var_12_0 then
		return 0
	end

	local var_12_1 = var_12_0.exp

	if var_12_0.exp <= 0 then
		return 0
	end

	return self:getExp() / var_12_1 * 100
end

function PubgMapItemUser:setWinCount(arg_13_1)
	self._winCount = arg_13_1
end

function PubgMapItemUser:setFailCount(arg_14_1)
	self._failCount = arg_14_1
end

function PubgMapItemUser:setExp(arg_15_1)
	self._exp = arg_15_1
end

function PubgMapItemUser:getExp()
	return self._exp
end

function PubgMapItemUser:getAddExp()
	return self._addExp
end

function PubgMapItemUser:setScore(arg_18_1)
	self._score = arg_18_1
end

function PubgMapItemUser:getScore()
	return self._score
end

function PubgMapItemUser:setFightValue(arg_20_1)
	self._fightValue = arg_20_1
end

function PubgMapItemUser:getFightValue()
	local var_21_0 = self._fightValue
	local var_21_1 = self:getBuff(var_0_6.map.BUFF_TYPE.FIGHT_VALUE_VALUE)

	if var_21_1 then
		var_21_0 = var_21_0 + var_21_1.cfg.effect_value_1
	end

	local var_21_2 = self:getAirBuff(var_0_6.map.BUFF_TYPE.FIGHT_VALUE_RATE)

	if var_21_2 then
		var_21_0 = var_21_0 * (1000 + var_21_2.cfg.effect_value_1) * 0.001
	end

	return math.floor(var_21_0)
end

function PubgMapItemUser:isInVisualField(arg_22_1, arg_22_2)
	if self:isDead() then
		return false
	end

	local var_22_0, var_22_1 = self:getPos()

	return math.abs(arg_22_1 - var_22_0) <= self._visualField and math.abs(arg_22_2 - var_22_1) <= self._visualField
end

function PubgMapItemUser:isInAttackRange(arg_23_1, arg_23_2)
	if self:isDead() then
		return false
	end

	local var_23_0 = self:getAttackRange()
	local var_23_1, var_23_2 = self:getPos()

	return math.abs(arg_23_1 - var_23_1) <= var_23_0 and math.abs(arg_23_2 - var_23_2) <= var_23_0
end

function PubgMapItemUser:isDead()
	return self._isDead
end

function PubgMapItemUser:tickMoveUpdate(arg_25_1)
	self._attackCd = self._attackCd - arg_25_1
	self._lockMoveTime = self._lockMoveTime - arg_25_1

	if self:isDead() then
		return
	end

	if self._movingPos then
		self._moveActionIncrement = self._moveActionIncrement + arg_25_1

		if self._moveActionIncrement > self:getMovingActionTime() + 0.1 then
			self._moveActionIncrement = 0
			self._movingPos = nil
		end

		return
	end

	if self._lockMoveTime > 0 then
		return
	end

	if #self._moveRoute > 0 then
		self._moveIncrement = self._moveIncrement + arg_25_1

		local var_25_0, var_25_1 = self:getPos()
		local var_25_2 = var_0_9(self._moveRoute[1].x - var_25_0)
		local var_25_3 = var_0_9(self._moveRoute[1].y - var_25_1)

		if self:getMoveDelayTime() * math.sqrt(var_25_2 * var_25_2 + var_25_3 * var_25_3) <= self._moveIncrement then
			self._oldPos = cc.p(self:getPos())
			self._moveIncrement = 0
			self._movingPos = self._moveRoute[1]
			self._lockMoveTime = self:getMovingActionTime()

			table.remove(self._moveRoute, 1)

			return true
		end
	end
end

function PubgMapItemUser:tickBuffUpdate(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = var_0_7:getTime()

	for iter_26_0, iter_26_1 in pairs(self._buffDict) do
		if iter_26_1.expire_time and iter_26_1.expire_time > 0 and var_26_1 >= iter_26_1.expire_time then
			self._buffDict[iter_26_0] = nil
			var_26_0[iter_26_0] = true
		end
	end

	for iter_26_2, iter_26_3 in pairs(self._airBuffDict) do
		local var_26_2 = false

		if iter_26_3.airBuffData.limit_value <= 0 then
			var_26_2 = true
		elseif var_0_4.get(iter_26_3.airBuffData.base_id).limit_type == var_0_6.map.BUFF_LIMIT_TYPE.TIME then
			var_26_2 = iter_26_3.airBuffData.limit_value - var_26_1 <= 0
		end

		if var_26_2 then
			self._airBuffDict[iter_26_2] = nil
			var_26_0[iter_26_2] = true
		end
	end

	return var_26_0
end

function PubgMapItemUser:getBuff(arg_27_1)
	return self._buffDict[arg_27_1]
end

function PubgMapItemUser:getAirBuffs()
	return self._airBuffDict
end

function PubgMapItemUser:getAirBuff(arg_29_1)
	return self._airBuffDict[arg_29_1]
end

function PubgMapItemUser:getName()
	local var_30_0 = self:getSnapShot()

	return (var_30_0 or nil) and (var_30_0.name or "")
end

function PubgMapItemUser:getSnapShot()
	if self:getRobotId() > 0 then
		if not self._robotSnapShot then
			local var_31_0 = var_0_5.get(self:getRobotId())

			self._robotSnapShot = {
				name = var_31_0.name,
				id = self:getUid(),
				fight_value = self:getFightValue(),
				base_id = var_31_0.knight_base
			}
		end

		return self._robotSnapShot
	end

	return var_0_1:getSnapShot(var_0_0.SNAP_SHOT_KEY.USER, self:getUid())
end

function PubgMapItemUser:setMoveRoute(arg_32_1)
	self._moveRoute = arg_32_1
end

function PubgMapItemUser:stopMove()
	self:setMoveRoute({})

	self._moveIncrement = 0
	self._moveActionIncrement = 0
end

function PubgMapItemUser:setTargetOnlyId(arg_34_1)
	self._targetOnlyId = arg_34_1
end

function PubgMapItemUser:getTargetOnlyId()
	return self._targetOnlyId
end

function PubgMapItemUser:getUserVisualFieldPos()
	local var_36_0 = {}
	local var_36_1 = math.min(self._oldPos.y - self._visualField, 0)

	for iter_36_0 = math.min(self._oldPos.x - self._visualField, 0), self._oldPos.x + self._visualField do
		for iter_36_1 = var_36_1, self._oldPos.y + self._visualField do
			var_36_0[PubgMapHelp.getKey(iter_36_0, iter_36_1)] = true
		end
	end

	local var_36_2, var_36_3 = self:getPos()
	local var_36_5 = math.min(var_36_3 - self._visualField, 0)

	for iter_36_2 = math.min(var_36_2 - self._visualField, 0), var_36_2 + self._visualField do
		for iter_36_3 = var_36_5, var_36_3 + self._visualField do
			var_36_0[PubgMapHelp.getKey(iter_36_2, iter_36_3)] = true
		end
	end

	return var_36_0
end

function PubgMapItemUser:getAttackRange()
	local var_37_0 = self._attackRange
	local var_37_1 = self:getBuff(var_0_6.map.BUFF_TYPE.ATTACK_RANGE)

	if var_37_1 then
		var_37_0 = var_37_0 + var_37_1.cfg.effect_value_1
	end

	return var_37_0
end

function PubgMapItemUser:getRouteFinal()
	if #self._moveRoute > 0 then
		return self._moveRoute[#self._moveRoute]
	end

	return cc.p(self:getPos())
end

function PubgMapItemUser:hasRoute()
	return #self._moveRoute > 0
end

function PubgMapItemUser:setMovingPos(arg_40_1)
	self._moveActionIncrement = 0
	self._movingPos = arg_40_1
end

function PubgMapItemUser:getMovingPos()
	return self._movingPos
end

function PubgMapItemUser:setOldPos(arg_42_1)
	self._oldPos = arg_42_1
end

function PubgMapItemUser:getOldPos()
	return self._oldPos
end

function PubgMapItemUser:getMoveDelayTime()
	local var_44_0 = self._moveDelayTime
	local var_44_1 = self:getBuff(var_0_6.map.BUFF_TYPE.MOVE_SPEED)

	if var_44_1 then
		var_44_0 = var_44_0 * (1 - var_44_1.cfg.effect_value_1 * 0.01)
	end

	return var_44_0
end

function PubgMapItemUser:getMovingActionTime()
	local var_45_0 = self._moveActionTime
	local var_45_1 = self:getBuff(var_0_6.map.BUFF_TYPE.MOVE_SPEED)

	if var_45_1 then
		var_45_0 = var_45_0 * (1 - var_45_1.cfg.effect_value_1 * 0.01)
	end

	return var_45_0
end

function PubgMapItemUser:addBuff(arg_46_1)
	self._buffDict[arg_46_1.tp] = self._buffDict[arg_46_1.tp] or {}
	self._buffDict[arg_46_1.tp].level = arg_46_1.level
	self._buffDict[arg_46_1.tp].expire_time = arg_46_1.expire_time

	for iter_46_0, iter_46_1 in var_0_3.ipairs() do
		if iter_46_1.effect_type == arg_46_1.tp and iter_46_1.level == arg_46_1.level then
			self._buffDict[arg_46_1.tp].cfg = iter_46_1

			break
		end
	end
end

function PubgMapItemUser:addAirBuff(arg_47_1)
	local var_47_0 = var_0_4.get(arg_47_1.base_id)

	self._airBuffDict[var_47_0.effect_type] = {
		cfg = var_47_0,
		airBuffData = arg_47_1
	}
end

function PubgMapItemUser:loseBuff(arg_48_1)
	if not self._buffDict[arg_48_1] then
		return
	end

	local var_48_0 = self._buffDict[arg_48_1].level - 1

	if self._buffDict[arg_48_1].level - 1 <= 0 then
		self._buffDict[arg_48_1] = nil

		return
	end

	self._buffDict[arg_48_1].level = var_48_0

	for iter_48_0, iter_48_1 in var_0_3.ipairs() do
		if iter_48_1.effect_type == arg_48_1 and iter_48_1.level == var_48_0 then
			self._buffDict[arg_48_1].cfg = iter_48_1

			break
		end
	end
end

function PubgMapItemUser:removeBuff(arg_49_1)
	if self._buffDict[arg_49_1] then
		self._buffDict[arg_49_1] = nil
	end
end

function PubgMapItemUser:getBuff(arg_50_1)
	return self._buffDict[arg_50_1]
end

function PubgMapItemUser:setDead(arg_51_1)
	self._isDead = arg_51_1

	if arg_51_1 then
		self:stopMove()
		self:setTargetOnlyId("")
	end
end

function PubgMapItemUser:isInvincible()
	local var_52_0 = var_0_7:getTime()

	if var_52_0 <= self._startInvincibleTime then
		return true
	end

	return var_52_0 <= self._invincibleTime
end

function PubgMapItemUser:setStartInvincibleTime(arg_53_1)
	self._startInvincibleTime = arg_53_1
end

function PubgMapItemUser:getLastInvincible()
	return self._lastIsInvincible
end

function PubgMapItemUser:setLastInvincible(arg_55_1)
	self._lastIsInvincible = arg_55_1
end

function PubgMapItemUser:setRecoverTime(arg_56_1)
	self._recoverTime = arg_56_1

	self:setInvincibleTime(arg_56_1 + g.core.model.User.pubgData:getParams(var_0_6.Params.INVINCIBLE_TIME))
end

function PubgMapItemUser:setInvincibleTime(arg_57_1)
	self._invincibleTime = arg_57_1
end

function PubgMapItemUser:subMustWin()
	local var_58_0 = self:getAirBuff(var_0_6.map.BUFF_TYPE.MUST_WIN)

	if var_58_0 then
		var_58_0.airBuffData.limit_value = var_58_0.airBuffData.limit_value - 1
	end
end

function PubgMapItemUser:getRecoverTime()
	return self._recoverTime
end

function PubgMapItemUser:isMe()
	return self._isMe
end

function PubgMapItemUser:isHide()
	return self:getBuff(var_0_6.map.BUFF_TYPE.HIDE) ~= nil
end

function PubgMapItemUser:startAttack()
	self:stopMove()

	self._attackCd = g.core.model.User.pubgData:getParams(var_0_6.Params.ATTACK_CD)
end

function PubgMapItemUser:getAttackCd()
	return self._attackCd
end

return PubgMapItemUser
