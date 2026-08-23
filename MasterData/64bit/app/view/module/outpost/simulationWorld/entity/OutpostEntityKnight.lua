local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = table.insert
local var_0_3 = math.max
local var_0_4 = g.core.const.ConstMgr.outpostConst
local OutpostAttrType = require("app.view.module.outpost.simulationWorld.fight.OutpostAttrType")
local var_0_6 = g.core.config.outpost_battle_parameter_info
local var_0_7 = g.core.config.outpost_parameter_info
local var_0_8 = g.core.config.outpost_skill_info
local OutpostKnightRootFsm = require("app.view.module.outpost.simulationWorld.fsm.OutpostKnightRootFsm")
local OutpostEntityKnight = class("OutpostEntityKnight", require("app.view.module.outpost.simulationWorld.entity.OutpostEntityRoleBase"))

function OutpostEntityKnight:ctor()
	OutpostEntityKnight.super.ctor(self)

	self.entityType = var_0_4.EntityType.Knight
	self._attackUseHunger = var_0_7.get(var_0_4.WorldParam.AttackUseHunger).parameter
	self._skillUseHunger = var_0_7.get(var_0_4.WorldParam.SkillUseHunger).parameter
	self._hurtSubMood = var_0_7.get(var_0_4.WorldParam.HurtSubMood).parameter
	self._secondSubFatigue = 1 / var_0_7.get(var_0_4.WorldParam.TickSubFatigue).parameter
	self._hasBossHpValue = var_0_7.get(var_0_4.WorldParam.HasBossHpCheck).parameter * 0.001
	self._hasBossHungerValue = var_0_7.get(var_0_4.WorldParam.HasBossHungerCheck).parameter
	self._hasBossMoodValue = var_0_7.get(var_0_4.WorldParam.HasBossMoodCheck).parameter
	self._hasBossFatigueValue = var_0_7.get(var_0_4.WorldParam.HasBossFatigueCheck).parameter
	self._lowHp = var_0_7.get(var_0_4.WorldParam.LowerHpRecover).parameter
	self._knightStruct = nil
	self.inBuilding = nil
	self._isTalkFirstAttack = true
	self._isIgnoreAttrChange = false
end

function OutpostEntityKnight:onCreate(arg_2_1)
	self._knightStruct = arg_2_1
	self._uid = arg_2_1:getServerId()
	self._lastLevel = arg_2_1:getLevel()

	self:_refreshAttr()
	self:setEyeRange(var_0_7.get(var_0_4.WorldParam.FindMonsterRange).parameter)

	self.hunger = arg_2_1:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_HUNGER)
	self.mood = arg_2_1:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_MOOD)
	self.fatigue = arg_2_1:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_FATIGUE)

	self:refreshCurHp()

	local var_2_0 = arg_2_1:getCfg()

	if var_2_0.skill_1 > 0 then
		self.normalSkill = var_0_8.get(var_2_0.skill_1)
	end

	if var_2_0.skill_2 > 0 then
		self.activeSkill = var_0_8.get(var_2_0.skill_2)
	end

	if var_2_0.passive_skill_1 > 0 then
		self:addPassive(var_2_0.passive_skill_1)
	end

	self._rootFsm = OutpostKnightRootFsm.new()

	self._rootFsm:initPrepareFSM(self)
	self._rootFsm:startupFSM()
	self.world:addSecondTickEntity(self)
end

function OutpostEntityKnight:_refreshAttr()
	self._attr:setAttr(OutpostAttrType.moveSpeed, var_0_6.get(var_0_4.WorldParam.MoveSpeedId).value)
	self._attr:setAttr(OutpostAttrType.minAttackRange, var_0_6.get(var_0_4.WorldParam.MinAtkRangeId).value)
	self._attr:setAttr(OutpostAttrType.maxAttackRange, self._knightStruct:getCfg().atk_scope)
	self._attr:setAttr(OutpostAttrType.attackSpeed, self._knightStruct:getCfg().atk_speed)

	for iter_3_0, iter_3_1 in pairs((self._knightStruct:getFinalAtkAttrs())) do
		self._attr:setAttr(iter_3_0, iter_3_1)
	end

	self._attr:applyAttr()
end

function OutpostEntityKnight:checkAttrChange(arg_4_1)
	if self._isIgnoreAttrChange then
		return
	end

	if not arg_4_1 and self._lastLevel == self._knightStruct:getLevel() then
		return
	end

	self._lastLevel = self._knightStruct:getLevel()

	self:_refreshAttr()
	self:doAttrBuff()
end

function OutpostEntityKnight:closeAttrChange(arg_5_1)
	self._isIgnoreAttrChange = arg_5_1
end

function OutpostEntityKnight:refreshCurHp()
	self._attr:setCurHp(math.min(self._knightStruct:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_HP), self._attr:getMaxHp()))
end

function OutpostEntityKnight:refreshHunger()
	self.hunger = self._knightStruct:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_HUNGER)
end

function OutpostEntityKnight:refreshMood()
	self.mood = self._knightStruct:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_MOOD)
end

function OutpostEntityKnight:refreshFatigue()
	self.fatigue = self._knightStruct:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_FATIGUE)
end

function OutpostEntityKnight:onHurt(arg_10_1, arg_10_2)
	self._knightStruct:setKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_HP, self._attr:getHp())
	self:subMood(self._hurtSubMood)

	if not self.fightTarget then
		self:setMoveTarget(nil)
		self:setFightTarget(arg_10_2.attacker)
	end

	if self:isDead() then
		var_0_1:dispatchWorldEvent(OutpostEvent.KnightTalk, {
			talkType = var_0_4.TalkType.Talk1,
			entity = self
		})
	end
end

function OutpostEntityKnight:OnOutBuild(arg_11_1)
	if arg_11_1.buildType == var_0_4.BuildType.Hospital then
		self._isTalkFirstAttack = false
	end
end

function OutpostEntityKnight:isDead()
	if self:isClear() then
		return true
	end

	return self._attr:getHp() <= self._lowHp
end

function OutpostEntityKnight:getAdvanceId()
	return self._knightStruct:getAdvId()
end

function OutpostEntityKnight:useNormalSkillCd()
	self.normalSkillCd = self._knightStruct:getCfg().atk_cd * 0.001 * 100 / self._attr:getAtkRateSpeed()

	self:subHunger(self._attackUseHunger)
end

function OutpostEntityKnight:onUseActiveSkill()
	self:subHunger(self._skillUseHunger)
end

function OutpostEntityKnight:subHunger(arg_16_1)
	if self.hunger <= 0 then
		return
	end

	if var_0_1:getBuildData():getBuild({
		type = var_0_4.BuildType.Restaurant
	}):isLockBuild() then
		return
	end

	self.hunger = var_0_3(self.hunger - arg_16_1, 0)

	self._knightStruct:setKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_HUNGER, self.hunger)

	if self.hunger <= 0 then
		var_0_1:dispatchWorldEvent(OutpostEvent.KnightTalk, {
			talkType = var_0_4.TalkType.Talk3,
			entity = self
		})
	elseif not self._isTalkFirstAttack then
		self._isTalkFirstAttack = true

		var_0_1:dispatchWorldEvent(OutpostEvent.KnightTalk, {
			talkType = var_0_4.TalkType.Talk14,
			entity = self
		})
	end
end

function OutpostEntityKnight:subMood(arg_17_1)
	if self.mood <= 0 then
		return
	end

	if var_0_1:getBuildData():getBuild({
		type = var_0_4.BuildType.Tavern
	}):isLockBuild() then
		return
	end

	self.mood = var_0_3(self.mood - arg_17_1, 0)

	self._knightStruct:setKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_MOOD, self.mood)

	if self.mood <= 0 then
		var_0_1:dispatchWorldEvent(OutpostEvent.KnightTalk, {
			talkType = var_0_4.TalkType.Talk7,
			entity = self
		})
	end
end

function OutpostEntityKnight:subFatigue(arg_18_1)
	if var_0_1:getBuildData():getBuild({
		type = var_0_4.BuildType.Hotel
	}):isLockBuild() then
		if self.fatigue <= 0 then
			self.fatigue = self._knightStruct:getCfg().fatigue
		end

		return
	end

	self.fatigue = var_0_3(self.fatigue - arg_18_1, 0)

	self._knightStruct:setKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_FATIGUE, self.fatigue)

	if self.fatigue <= 0 then
		var_0_1:dispatchWorldEvent(OutpostEvent.KnightTalk, {
			talkType = var_0_4.TalkType.Talk5,
			entity = self
		})
	end
end

function OutpostEntityKnight:getDemonicEnergy()
	return self._knightStruct:getKnightStateValue(var_0_4.STATE_ENUM.KNIGHT_DEMONIC)
end

function OutpostEntityKnight:getFatigue()
	return self.fatigue
end

function OutpostEntityKnight:canVictim()
	if self:needRecover() then
		return false
	end

	if not self.cmdFinish then
		return false
	end

	if var_0_1:getOwnVit() <= 0 then
		if self.fightTarget and self.fightTarget:isBoss() then
			return true
		else
			return false
		end
	end

	return true
end

function OutpostEntityKnight:getProfession()
	return self._knightStruct:getCfg().profession
end

function OutpostEntityKnight:getElemental()
	return self._knightStruct:getCfg().classical
end

function OutpostEntityKnight:getEntityKnightStruct()
	return self._knightStruct
end

function OutpostEntityKnight:getMapType()
	return self._knightStruct:getMapType()
end

function OutpostEntityKnight:onTick(arg_26_1)
	self.normalSkillCd = var_0_3(self.normalSkillCd - arg_26_1, 0)
	self.activeSkillCd = var_0_3(self.activeSkillCd - arg_26_1, 0)

	self._rootFsm:updateTickFSM(arg_26_1)
end

function OutpostEntityKnight:onSecondTick()
	if self.world:getVirtualMap():getPixelPosLevel(self.x, self.y) > 1 then
		self:subFatigue(self._secondSubFatigue)
	end
end

function OutpostEntityKnight:onDestroy()
	OutpostEntityKnight.super.onDestroy(self)

	self._knightStruct = nil
	self.inBuilding = nil
end

function OutpostEntityKnight:getDebugData()
	local var_29_0 = {
		hp = self._attr:getHp(),
		demonicEnergy = self:getDemonicEnergy(),
		hunger = self.hunger,
		fatigue = self:getFatigue(),
		mood = self.mood
	}

	var_29_0.bag = self:getEntityKnightStruct():getOwnBagData()
	var_29_0.当前根状态名 = self._rootFsm._curState.__cname

	if self._rootFsm._curState._curFsm then
		var_29_0.当前子状态名 = self._rootFsm._curState._curFsm._curState.__cname or "---"
	end

	return var_29_0
end

function OutpostEntityKnight:toProtoOutpostKnightState()
	local var_30_0 = {}
	local var_30_1 = {
		tp = var_0_4.STATE_ENUM.KNIGHT_HP
	}

	var_30_1.value = self:getAttr():getHp()

	var_0_2(var_30_0, var_30_1)
	var_0_2(var_30_0, {
		tp = var_0_4.STATE_ENUM.KNIGHT_MOOD,
		value = self.mood
	})
	var_0_2(var_30_0, {
		tp = var_0_4.STATE_ENUM.KNIGHT_HUNGER,
		value = self.hunger
	})
	var_0_2(var_30_0, {
		tp = var_0_4.STATE_ENUM.KNIGHT_FATIGUE,
		value = self.fatigue
	})

	return {
		knight_id = self._knightStruct:getServerId(),
		advance_id = self._knightStruct:getAdvId(),
		map_type = self:getMapType(),
		states = var_30_0
	}
end

function OutpostEntityKnight:needRecover()
	return self:isDead() or self:getDemonicEnergy() <= 0 or self.hunger <= 0 or self:getFatigue() <= 0 or self.mood <= 0
end

function OutpostEntityKnight:needRecoverInBoss()
	return self._attr:getHpRate() <= self._hasBossHpValue or self:getDemonicEnergy() <= 0 or self.hunger <= self._hasBossHungerValue or self:getFatigue() <= self._hasBossFatigueValue or self.mood <= self._hasBossMoodValue
end

return OutpostEntityKnight
