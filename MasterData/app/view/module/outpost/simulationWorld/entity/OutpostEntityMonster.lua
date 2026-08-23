local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_3 = g.core.common.ServerTime
local var_0_4 = math.max
local var_0_5 = g.core.const.ConstMgr.outpostConst
local OutpostAttrType = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrType")
local var_0_7 = g.core.config.outpost_skill_info
local var_0_8 = g.core.config.outpost_knight_info
local var_0_9 = g.core.config.outpost_parameter_info
local var_0_10 = g.core.config.outpost_map_info
local var_0_11 = g.core.config.outpost_monster_info
local var_0_12 = g.core.config.outpost_monster_attribute_info
local var_0_13 = g.core.config.outpost_battle_parameter_info
local OutpostMonsterRootFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostMonsterRootFsm")
local OutpostEntityMonster = class("OutpostEntityMonster", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityRoleBase"))

function OutpostEntityMonster:ctor()
	OutpostEntityMonster.super.ctor(self)

	self.entityType = var_0_5.EntityType.Monster
	self.monsterInfo = nil
	self._knightInfo = nil
	self._hideInBoss = false
	self._aliveTime = 0
	self._cfgAtkCd = 0
end

function OutpostEntityMonster:onCreate(arg_2_1)
	self._uid = arg_2_1.unique_id
	self._aliveTime = arg_2_1.alive_time

	if self:isHide() then
		self.world:removeTickEntity(self)
		self.world:addSecondTickEntity(self)
	end

	self.monsterInfo = var_0_11.get(arg_2_1.monster_id)
	self._knightInfo = var_0_8.get(self.monsterInfo.knight_id)

	if self.monsterInfo.skill_1 > 0 then
		self.normalSkill = var_0_7.get(self.monsterInfo.skill_1)
	end

	if self.monsterInfo.skill_2 > 0 then
		self.activeSkill = var_0_7.get(self.monsterInfo.skill_2)
	end

	if self.monsterInfo.passive_skill_1 > 0 then
		self:addPassive(self.monsterInfo.passive_skill_1)
	end

	self:initAttr()
	self:setEyeRange(self:getAttr():getAttackMaxRange())

	self._rootFsm = OutpostMonsterRootFsm.new()

	self._rootFsm:initPrepareFSM(self)
	self._rootFsm:startupFSM()

	self._attackKnightDict = {}
end

function OutpostEntityMonster:initAttr()
	local var_3_0 = var_0_1:getBuildData():getBuild({
		type = var_0_9.get(var_0_5.WorldParam.MonsterAttrBindBuild).parameter
	}):getLevel()

	if var_3_0 == 0 then
		var_3_0 = 1
	end

	local var_3_1 = var_0_12.get((math.min(var_3_0, var_0_10.get(self.monsterInfo.map).monster_attribute_max)))

	self._cfgAtkCd = var_3_1.atk_cd

	self._attr:setAttr(OutpostAttrType.hp, math.floor(var_3_1.initial_hp * math.random(950, 1050) * 0.001))
	self._attr:setAttr(OutpostAttrType.atk, math.floor(var_3_1.attack * math.random(950, 1050) * 0.001))
	self._attr:setAttr(OutpostAttrType.def, math.floor(var_3_1.phy_defence * math.random(950, 1050) * 0.001))
	self._attr:setAttr(OutpostAttrType.hitRate, var_3_1.accuracy_rate)
	self._attr:setAttr(OutpostAttrType.dodgeRate, var_3_1.dodge_rate)
	self._attr:setAttr(OutpostAttrType.critRate, var_3_1.crit_rate)
	self._attr:setAttr(OutpostAttrType.critResistRate, var_3_1.harden_rate)
	self._attr:setAttr(OutpostAttrType.attackSpeed, var_3_1.atk_speed)
	self._attr:setAttr(OutpostAttrType.maxAttackRange, var_3_1.atk_scope)
	self._attr:setAttr(OutpostAttrType.moveSpeed, var_0_13.get(var_0_5.WorldParam.MoveSpeedId).value)
	self._attr:setAttr(OutpostAttrType.minAttackRange, var_0_13.get(var_0_5.WorldParam.MinAtkRangeId).value)
	self._attr:applyAttr()
end

function OutpostEntityMonster:getProfession()
	return self.monsterInfo.profession
end

function OutpostEntityMonster:getElemental()
	return self._knightInfo.classical
end

function OutpostEntityMonster:useNormalSkillCd()
	self.normalSkillCd = self._cfgAtkCd * 0.001 * 100 / self._attr:getAtkRateSpeed()
end

function OutpostEntityMonster:getMonsterInfo()
	return self.monsterInfo
end

function OutpostEntityMonster:getMapType()
	return self.monsterInfo.map
end

function OutpostEntityMonster:onHurt(arg_9_1, arg_9_2)
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

		if self.world then
			self.world:getVirtualMap():removeMonster(self)
		end

		self:dispose()
	end
end

function OutpostEntityMonster:onTick(arg_10_1)
	self.normalSkillCd = var_0_4(self.normalSkillCd - arg_10_1, 0)
	self.activeSkillCd = var_0_4(self.activeSkillCd - arg_10_1, 0)

	self._rootFsm:updateTickFSM(arg_10_1)
end

function OutpostEntityMonster:onSecondTick()
	if not self:isHide() then
		self.world:removeSecondTickEntity(self)
		self.world:addTickEntity(self)
		var_0_1:dispatchWorldEvent(OutpostEvent.EntityActive, {
			entity = self
		})
	end
end

function OutpostEntityMonster:setBossToHide(arg_12_1)
	self._hideInBoss = arg_12_1 == true

	if self:isHide() then
		self.world:removeTickEntity(self)
		self.world:addSecondTickEntity(self)
	else
		self.world:addTickEntity(self)
		self.world:removeSecondTickEntity(self)
	end
end

function OutpostEntityMonster:isHide()
	if self._aliveTime >= var_0_3:getTime() then
		return true
	end

	return self._hideInBoss
end

function OutpostEntityMonster:canVictim()
	return not self:isDead() and not self:isHide()
end

function OutpostEntityMonster:getDebugData()
	local var_15_0 = {
		hp = self._attr:getHp(),
		当前根状态名 = self._rootFsm._curState.__cname
	}

	if self._rootFsm._curState._curFsm then
		var_15_0.当前子状态名 = self._rootFsm._curState._curFsm._curState.__cname or "---"
	end

	return var_15_0
end

function OutpostEntityMonster:getAdvanceId()
	return self.monsterInfo.knight_id
end

function OutpostEntityMonster:onDestroy()
	self._attackKnightDict = {}

	self._rootFsm:cleanupFSM()

	self._rootFsm = nil
end

return OutpostEntityMonster
