local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_1 = g.core.config.outpost_knight_info
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local var_0_4 = g.core.common.ServerTime
local var_0_5 = math.max
local var_0_6 = g.core.const.ConstMgr.outpostConst
local OutpostAttrType = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrType")
local var_0_8 = g.core.config.outpost_skill_info
local var_0_9 = g.core.config.outpost_monster_info
local var_0_10 = g.core.config.outpost_monster_attribute_info
local var_0_11 = g.core.config.outpost_battle_parameter_info
local var_0_12 = g.core.config.outpost_parameter_info
local OutpostBossFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostBossFsm")
local OutpostEntityRoleBoss = class("OutpostEntityRoleBoss", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityRoleBase"))

function OutpostEntityRoleBoss:ctor()
	OutpostEntityRoleBoss.super.ctor(self)

	self.entityType = var_0_6.EntityType.Boss
	self.monsterInfo = nil
	self._knightInfo = nil
	self._isSleep = true
	self._aliveTime = 0
	self._cfgAtkCd = 0
	self._deltaActive = 0
	self._deltaDestroy = 0
	self._startTime = 0
end

function OutpostEntityRoleBoss:onCreate(arg_2_1)
	self._uid = arg_2_1.unique_id
	self.monsterInfo = var_0_9.get(arg_2_1.monster_id)
	self._knightInfo = var_0_1.get(self.monsterInfo.knight_id)
	self._aliveTime = arg_2_1.alive_time
	self._startTime = g.core.common.ServerTime:getTime()
	self._activeTime = self._aliveTime + 0
	self._deltaActive = self._aliveTime - self._startTime
	self._destroyTime = self._aliveTime + 0 + var_0_12.get(var_0_6.WorldParam.BossAttackTime).parameter
	self._deltaDestroy = self._destroyTime - self._startTime

	if self.monsterInfo.skill_1 > 0 then
		self.normalSkill = var_0_8.get(self.monsterInfo.skill_1)
	end

	if self.monsterInfo.skill_2 > 0 then
		self.activeSkill = var_0_8.get(self.monsterInfo.skill_2)
	end

	if self.monsterInfo.passive_skill_1 > 0 then
		self:addPassive(self.monsterInfo.passive_skill_1)
	end

	self:initAttr()

	local var_2_0 = var_0_3:getBossHp(self:getUid())

	if var_2_0 then
		self._attr:setCurHp(var_2_0)
	end

	self._rootFsm = OutpostBossFsm.new()

	self._rootFsm:initPrepareFSM(self)
	self._rootFsm:startupFSM()
	self.world:addSecondTickEntity(self)

	self._attackKnightDict = {}
end

function OutpostEntityRoleBoss:initAttr()
	local var_3_0 = var_0_10.get(self.monsterInfo.attribute_id)

	self._cfgAtkCd = var_3_0.atk_cd

	self._attr:setAttr(OutpostAttrType.hp, var_3_0.initial_hp)
	self._attr:setAttr(OutpostAttrType.atk, var_3_0.attack)
	self._attr:setAttr(OutpostAttrType.def, var_3_0.phy_defence)
	self._attr:setAttr(OutpostAttrType.hitRate, var_3_0.accuracy_rate)
	self._attr:setAttr(OutpostAttrType.dodgeRate, var_3_0.dodge_rate)
	self._attr:setAttr(OutpostAttrType.critRate, var_3_0.crit_rate)
	self._attr:setAttr(OutpostAttrType.critResistRate, var_3_0.harden_rate)
	self._attr:setAttr(OutpostAttrType.attackSpeed, var_3_0.atk_speed)
	self._attr:setAttr(OutpostAttrType.maxAttackRange, var_3_0.atk_scope)
	self._attr:setAttr(OutpostAttrType.moveSpeed, var_3_0.speed)
	self._attr:setAttr(OutpostAttrType.minAttackRange, var_0_11.get(var_0_6.WorldParam.MinAtkRangeId).value)
	self._attr:applyAttr()
end

function OutpostEntityRoleBoss:getProfession()
	return self.monsterInfo.profession
end

function OutpostEntityRoleBoss:getElemental()
	return self._knightInfo.classical
end

function OutpostEntityRoleBoss:useNormalSkillCd()
	self.normalSkillCd = self._cfgAtkCd * 0.001 * 100 / self._attr:getAtkRateSpeed()
end

function OutpostEntityRoleBoss:getMonsterInfo()
	return self.monsterInfo
end

function OutpostEntityRoleBoss:getMapType()
	return self.monsterInfo.map
end

function OutpostEntityRoleBoss:onHurt(arg_9_1, arg_9_2)
	var_0_3:setBossHp(self:getUid(), self._attr:getHp())

	if arg_9_2.attacker:isKnight() then
		self._attackKnightDict[arg_9_2.attacker:getUid()] = arg_9_2.attacker
	end

	if not self.fightTarget then
		self:setMovePos(nil)
		self:setFightTarget(arg_9_2.attacker)
	end

	if self:isDead() then
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._attackKnightDict) do
			if not iter_9_1:isClear() then
				table.insert(var_9_0, iter_9_1:toProtoOutpostKnightState())
			end
		end

		local var_9_1, var_9_2 = OutpostCommon.pixelToCoord(self.x, self.y)

		g.core.network.GameNetProxy:send_C2S_Outpost_BattleFinish({
			map_tp = self:getMapType(),
			unique_id = self:getUid(),
			knights = var_9_0,
			x = var_9_1,
			y = var_9_2
		})
		self:dispose()
	end
end

function OutpostEntityRoleBoss:onTick(arg_10_1)
	self.normalSkillCd = var_0_5(self.normalSkillCd - arg_10_1, 0)
	self.activeSkillCd = var_0_5(self.activeSkillCd - arg_10_1, 0)

	self._rootFsm:updateTickFSM(arg_10_1)
end

function OutpostEntityRoleBoss:onSecondTick()
	if var_0_4:getTime() >= self:getDestroyTime() then
		var_0_3:onBossTimeFinish(self._uid)
		self:dispose()

		return
	end

	var_0_3:dispatchWorldEvent(OutpostEvent.BossIsActive, {
		boss = self
	})
end

function OutpostEntityRoleBoss:getAdvanceId()
	return self.monsterInfo.knight_id
end

function OutpostEntityRoleBoss:isInSleep()
	return var_0_4:getTime() <= self:getActiveTime()
end

function OutpostEntityRoleBoss:getActiveTime()
	return self._startTime + self._deltaActive / var_0_3:getSpeed()
end

function OutpostEntityRoleBoss:getDestroyTime()
	return self._startTime + self._deltaDestroy / var_0_3:getSpeed()
end

function OutpostEntityRoleBoss:getDebugData()
	local var_16_0 = {
		hp = self._attr:getHp(),
		当前根状态名 = self._rootFsm._curState.__cname
	}

	if self._rootFsm._curState._curFsm then
		var_16_0.当前子状态名 = self._rootFsm._curState._curFsm._curState.__cname or "---"
	end

	return var_16_0
end

function OutpostEntityRoleBoss:dispose()
	if self.world then
		self.world:getVirtualMap():removeMonster(self)
	end

	OutpostEntityRoleBoss.super.dispose(self)
end

function OutpostEntityRoleBoss:onDestroy()
	self._attackKnightDict = {}

	self._rootFsm:cleanupFSM()

	self._rootFsm = nil
end

return OutpostEntityRoleBoss
