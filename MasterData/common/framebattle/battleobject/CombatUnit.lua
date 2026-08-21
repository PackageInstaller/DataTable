-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\CombatUnit.lua

local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleObject = require("Common/FrameBattle/BattleObject/BattleObject")
local AttackCalc = require("Common/FrameBattle/AttackProcess/AttackCalc")
local PropBoard = require("ClientData/PropBoard")
local FixedProp = require("Common/FrameBattle/BattleObject/FixedProp")
local StateGroup = require("Common/FrameBattle/BattleObject/StateGroup")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local CombatFSM = require("Common/FrameBattle/Behavior/CombatFSM")
local ResMonster = require("ClientData/ResMonster")
local ResHero = require("ClientData/ResHero")
local PassiveGroup = require("Common/FrameBattle/BattleObject/PassiveGroup")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResStar = require("ClientData/ResStar")
local ResHeroStepProp = require("ClientData/ResHeroStepProp")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResArtifact = require("ClientData/ResArtifact")
local ResRelics = require("ClientData/ResRelics")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ResPaintAbility = require("ClientData/ResPaintAbility")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResPaintRelate = require("ClientData/ResPaintRelate")
local ResStick = require("ClientData/ResStick")
local ResStickStateGroup = require("ClientData/ResStickStateGroup")
local strClassName = "CombatUnit"
local CombatUnit = Class(strClassName, BattleObject)
local MAX_MANA = 100
local TICK_QUEST_TYPE_THROW_BOX = 1
local TICK_QUEST_TYPE_SHIELD_TIMEOUT = 2
local TICK_QUEST_TYPE_PASSIVE_CARD_TRIGGER = 3
local TICK_QUEST_TYPE_PASSIVE_CARD_USE = 4
local AI_MODE_WALL_NUT = 1
local AI_MODE_ZOMBIE = 2
local AI_MODE_CHUYIN = 3

function CombatUnit:ctor(id, mgr, frameLength, playerinfo)
	self.act = 1
	self.playerinfo = playerinfo
	self.mgr = mgr
	self.randomGenerator = self.mgr:getRandomGenerator()
	self.tickQuestDict = {}
	self.tickQuestFuncConfig = {
		[TICK_QUEST_TYPE_THROW_BOX] = Slot(self.delayAtkEvent, self),
		[TICK_QUEST_TYPE_SHIELD_TIMEOUT] = Slot(self.onShieldOutTime, self),
		[TICK_QUEST_TYPE_PASSIVE_CARD_TRIGGER] = Slot(self.onPassiveCardTrigger, self),
		[TICK_QUEST_TYPE_PASSIVE_CARD_USE] = Slot(self.onPassiveCardUse, self)
	}
	self.camp = playerinfo.camp
	self.attackCamp = self.camp
	self.pos = playerinfo.pos
	self.coordX = playerinfo.coordX
	self.coordY = playerinfo.coordY
	self.realCoordX = self.coordX
	self.realCoordY = self.coordY
	self.master = playerinfo.master

	if self.master then
		self.isSummonEntity = 1
	else
		self.isSummonEntity = 0
	end

	self.isPvp = self.mgr.isPvp
	self.frameNumber = 1
	self.frameLength = frameLength
	self.framePerSec = 1000 / frameLength

	self:initCommonData(playerinfo)
	self:_initCombatProp()

	self.behaviorFSM = CombatFSM(self, self.frameLength, self.mgr.matrixInstance.bhMgr)

	self:initSkillEventHandler()

	self.resumePauseFrame = 0
	self.skillSelfPauseFrame = 0
	self.shieldInfo = {}
	self.shieldIndex = 1

	self:initConfig()

	self.killNum = 0
	self.manaFullSkillNum = 0
	self.minHpPercent = 1
	self.beInteruptSkillNum = 0
end

function CombatUnit:initCommonData(playerinfo)
	if playerinfo.monsterID then
		self.monsterID = playerinfo.monsterID
		self.battleCommonData = ResMonster[self.monsterID] or {}
		self.name = self.battleCommonData.name
		self.weaponType = self.battleCommonData.weapon
		self.level = self.battleCommonData.level or 1
		self.showLevel = self.mgr.monsterLevel

		if self.master then
			local masterObj = self.mgr:getObjectByKey(self.master)

			self.level = masterObj.level
			self.showLevel = masterObj.showLevel
		end

		self.monsterPropRate = self.mgr.monsterPropRate
		self.monsterMhpPropRate = self.mgr.monsterMhpPropRate
		self.bigMonster = self.battleCommonData.big_monster and self.battleCommonData.big_monster > 0
		self.playerControl = self.battleCommonData.skill_control
		self.pauseInSkill = self.battleCommonData.pause_in_skill == 1

		if self.camp ~= BattleConst.CAMP_PLAYER and not self.master then
			self.monsterStartPos = self.pos
		end

		if self.battleCommonData.full_skill_ani == 2 then
			self.forceLongSkill = true
		elseif self.battleCommonData.full_skill_ani ~= 1 then
			self.forceShortSkill = true
		end

		self.defReduceLimit = 0
	else
		if playerinfo.isRobot then
			self.isRobot = true
			self.robotEquips = playerinfo.robotEquips
			self.forceLongSkill = playerinfo.forceSkillAnim
		end

		self.hero = playerinfo.heroObj
		self.team = self.hero.team
		self.heroID = playerinfo.heroID
		self.fashionSkins = playerinfo.fashionSkins
		self.skin = self.hero.skin
		self.fashionBases = playerinfo.fashionBases
		self.paintData = playerinfo.paintData
		self.paintPlusData = playerinfo.paintPlusData
		self.heroEquips = playerinfo.equips
		self.heroArtifact = playerinfo.artifact
		self.heroRelic = playerinfo.heroRelic
		self.heroSeasonRelic = playerinfo.heroSeasonRelic
		self.relationPointData = playerinfo.relationPointData
		self.stickData = playerinfo.stickData
		self.battleCommonData = ResHero[self.heroID] or {}
		self.name = self.battleCommonData.hero_name
		self.weaponType = self.battleCommonData.ani_con_name
		self.stepId = self.battleCommonData.step_prop_id or 1
		self.level = playerinfo.level
		self.showLevel = playerinfo.showLevel
		self.step = self.hero.battleStep
		self.star = playerinfo.star
		self.suppressLevel = math.max(0, self.level + (self.star - math.max(math.floor(self.level / 20), 5)) * 10)
		self.playerControl = true
		self.pauseInSkill = true
		self.extraProps = playerinfo.extraProps

		if self.battleCommonData.record_heal_per then
			self.record_heal_per = 1 + self.battleCommonData.record_heal_per * 0.0001
		end

		if self.battleCommonData.record_damage_per then
			self.record_damage_per = 1 + self.battleCommonData.record_damage_per * 0.0001
		end

		self.defReduceLimit = 1

		for _, limitInfo in ipairs(BattleMiscConfig.BATTLE_LEVEL_DEF_LIMIT) do
			if self.level and self.level <= limitInfo[1] then
				self.defReduceLimit = limitInfo[2]

				break
			end
		end

		self.crystalMaxLevel = playerinfo.crystalMaxLevel
		self.storyUnlockDic = playerinfo.storyUnlockDic
		self.extraProps = utils.getHeroStoryProps(self.crystalMaxLevel, self.storyUnlockDic, self.extraProps or {})
	end

	if self.battleCommonData.skill_prior then
		if self.camp == BattleConst.CAMP_PLAYER then
			self.skillPrior = self.battleCommonData.skill_prior
		else
			self.skillPrior = self.battleCommonData.skill_prior + 100
		end
	else
		self.skillPrior = 99999
	end

	self.skillPriorTime = self.battleCommonData.prior_frame or 5
	self.race = self.battleCommonData.camp
	self.career = self.battleCommonData.career
end

function CombatUnit:initConfig()
	self.speed = self.battleCommonData.speed or 1
	self.moveFrame = math.floor(self.mgr.gridSize / self.speed * self.framePerSec)
	self.halfMoveFrame = math.floor(self.moveFrame / 2)
	self.moveTime = self.moveFrame * self.frameLength / 1000

	self:refreshAttackDist()

	if self.hero then
		self.mana = self.hero:getInitMana()
	else
		self.mana = self.battleCommonData.init_mana
	end

	if self.monsterID then
		self.attackLevel = self.battleCommonData.attack_level or 1
		self.skillLevel = self.battleCommonData.skill_level or 1
		self.enterPassiveLevel = self.battleCommonData.enter_passive_level or 1
		self.specialPassiveLevel = self.battleCommonData.hero_passive_level or 1
	else
		local stepData = ResHeroStepProp[self.stepId][self.step] or {}
		local starData = {}

		if self.battleCommonData.star_prop_id then
			starData = ResStar[self.battleCommonData.star_prop_id][self.star] or {}
		end

		if self.hero.skillBase then
			self.attackLevel = self.hero.skillBase.level
		else
			self.attackLevel = 1
		end

		if self.hero.skillLast then
			self.skillLevel = self.hero.skillLast.level
		else
			self.skillLevel = 1
		end

		if self.hero.skillPassive1 then
			self.enterPassiveLevel = self.hero.skillPassive1.level
		else
			self.enterPassiveLevel = 1
		end

		if self.hero.skillPassive2 then
			self.specialPassiveLevel = self.hero.skillPassive2.level
		else
			self.specialPassiveLevel = 1
		end
	end

	self:handleSpecBattle()

	if ResSkillConfig[self.skillCardId] then
		if ResSkillConfig[self.skillCardId][self.skillLevel] and ResSkillConfig[self.skillCardId][self.skillLevel].skill_ids then
			self.skillId = ResSkillConfig[self.skillCardId][self.skillLevel].skill_ids[1]
		else
			self.skillId = ResSkillConfig[self.skillCardId][1].skill_ids[1]
		end
	else
		self.skillId = self.skillCardId
	end

	self.attackInnerCd = 0

	if ResSkillConfig[self.caCardId] and ResSkillConfig[self.caCardId][self.attackLevel] then
		self.attackIds = ResSkillConfig[self.caCardId][self.attackLevel].skill_ids
		self.attackInnerCd = ResSkillConfig[self.caCardId][self.attackLevel].skill_cd
	end

	self:refreshAttackCd()

	self.attackEnableFrame = 0
	self.attackRandom = self.battleCommonData.attack_random
	self.skillData = {}

	if self.skillId then
		local skillData = SkillDataBank.getSkillData(self.weaponType, self.skillId)

		self.skillData = skillData or {}

		if skillData then
			self.skillPauseTime = skillData.actTime or 0
			self.skillPauseTime = math.floor(self.skillPauseTime * self.framePerSec / 30)
			self.skillAreaEvent = skillData.hideEvent
			self.skillAreaTime = skillData.hideTime
		end
	end

	self.attackers = {}
	self.selfHealFrame = 0
	self.passiveCardInfo = {}
	self.passiveCardTriggerFrame = {}
	self.moveEndFrame = 0
	self.moveHalfFrame = 0

	self:_update_mana_frame()

	self.skillRecordTargets = {}
end

function CombatUnit:handleSpecBattle()
	if self.camp == BattleConst.CAMP_PLAYER and self.mgr.specBattleType == BattleConst.SPECIAL_BATTLE_HOOK then
		self.caCardId = self.battleCommonData.hook_attack_id or self.battleCommonData.attack_id
		self.attackCd = self.battleCommonData.hook_attack_cd or BattleConst.DEFAULT_ATTACK_CD
		self.skillCardId = self.battleCommonData.hook_skill_id or self.battleCommonData.skill_id

		if self.battleCommonData.hook_skill_level then
			self.skillLevel = self.battleCommonData.hook_skill_level
		end
	else
		self.caCardId = self.battleCommonData.attack_id
		self.attackCd = self.battleCommonData.attack_cd or BattleConst.DEFAULT_ATTACK_CD
		self.skillCardId = self.battleCommonData.skill_id
	end

	if self.mgr.specBattleType == BattleConst.SPECIAL_BATTLE_SUN_FLOWER then
		if self.camp == BattleConst.CAMP_PLAYER then
			self.aiMode = AI_MODE_WALL_NUT
		else
			self.aiMode = AI_MODE_ZOMBIE
		end
	end
end

function CombatUnit:recordSkillNumTarget(skillId, skillEventId)
	self.recordSkillHitSkill = skillId
	self.recordSkillHitEvent = skillEventId
	self.recordSkillMaxHitNum = 0
	self.recordSkillHitNum = 0
	self.recordSkillFirstHitNum = 0
end

function CombatUnit:addSkillHitNum(targetNum)
	self.recordSkillHitNum = self.recordSkillHitNum + targetNum
	self.recordSkillMaxHitNum = math.max(self.recordSkillMaxHitNum, self.recordSkillHitNum)

	if self.manaFullSkillNum == 1 then
		self.recordSkillFirstHitNum = self.recordSkillFirstHitNum + targetNum
	end
end

function CombatUnit:moveOutOfPos()
	self.aiMode = AI_MODE_CHUYIN
	self.outOfPos = true
	self.showCoordX = self.mgr.GridConfig.CHUYIN_POS[1]
	self.showCoordY = self.mgr.GridConfig.CHUYIN_POS[2]

	self.mgr:enterOutOfPos(self)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS, {})
end

function CombatUnit:getRealFrameNum()
	return self.mgr.realFrameNumber
end

function CombatUnit:attackNear()
	return self.attackDist <= 1
end

function CombatUnit:initInEnterBattle()
	self:initEquipState()
	self:initBattleBuffs()
	self:initPositionFlag()
	self:initMonsterState()
	self.mgr:addEnterBattleBuff(self)
end

function CombatUnit:nextFrame(frameNumber, noAction)
	self.frameNumber = frameNumber

	if frameNumber == 1 then
		self:initInEnterBattle()
	end

	if frameNumber < BattleConst.MATRIX_ENTITY_PREPARE_FRAME then
		return
	elseif frameNumber == BattleConst.MATRIX_ENTITY_PREPARE_FRAME then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_START, {})
	end

	local inSkill = self.frameNumber < self.resumePauseFrame

	if inSkill then
		if not self.skillSelf then
			self:_tickQuests(frameNumber, true)

			return
		end

		if self.frameNumber < self.skillSelfPauseFrame then
			return
		elseif self.frameNumber == self.skillSelfPauseFrame then
			self.behaviorFSM:cancelPauseBH()
		end
	end

	if self.frameNumber == self.resumePauseFrame then
		self.behaviorFSM:cancelPauseBH()
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL, {
			self.skillSelf
		})
	end

	if self.mgr.frameSkillEntity and self.mgr.frameSkillEntity ~= self and self.mgr.frameSkillPause then
		return
	end

	if inSkill and self.skillSelf then
		self:_tickQuests(frameNumber, true)
		self:_checkSkillFrameAction()
	else
		self.stateGroup:tickHot()
		self.stateGroup:nextFrame()

		if not noAction and self:isAlive() then
			self:_checkFrameAction()

			if self.mana_frame > 0 and self.mana < MAX_MANA then
				self:onChangeMana(self.mana_frame, true)
			elseif self.mana_frame < 0 and self.mana > 0 then
				self:onChangeMana(self.mana_frame, true)
			end
		end

		self:_tickQuests(frameNumber)
	end
end

function CombatUnit:destroy()
	return
end

function CombatUnit:_initCombatProp()
	self.propInInitialization = true
	self.shield = 0

	PropBoard.set_default_props(self)

	self.fixedProp = FixedProp(self)
	self.stateGroup = StateGroup(self)
	self.passiveGroup = PassiveGroup(self)

	self.fixedProp:initProperty()
	PropBoard.init_props(self)

	if self.playerinfo.hpPercent and self.playerinfo.hpPercent > 0 then
		self.hp = self.mhp * self.playerinfo.hpPercent * 0.0001
	elseif self.mgr.monsterHps[self.monsterStartPos] then
		self.hp = self.mhp * self.mgr.monsterHps[self.monsterStartPos] * 0.0001
	else
		self.hp = self.mhp
	end

	self.initHp = self.hp
	self.mhp = math.max(1, math.floor(self.mhp))
	self.hp = math.max(1, math.floor(self.hp))
	self.hppct = self.hp / self.mhp
	self.propInInitialization = false
end

function CombatUnit:getPropLevel()
	if self.hero then
		return self.hero:getPropLevel()
	else
		return self.level
	end
end

function CombatUnit:refreshBoardProp(propName)
	local updateFuncName = "update_" .. propName

	if PropBoard[updateFuncName] then
		local preValueRecorder = {}

		if self.PROP_UPDATE_CONFIG[propName] and not self.propInInitialization then
			for index, affectPropName in pairs(self.PROP_UPDATE_CONFIG[propName]) do
				preValueRecorder[affectPropName] = self[affectPropName]
			end
		end

		PropBoard[updateFuncName](self)

		for affectPropName, preValue in pairs(preValueRecorder) do
			if self["update_" .. affectPropName] and preValue ~= nil then
				self["update_" .. affectPropName](self, preValue)
			end
		end
	end
end

function CombatUnit:update_mhp(preValue)
	if not self:isAlive() then
		return
	end

	self.mhp = math.max(1, math.floor(self.mhp))

	local changed = self.mhp - preValue

	self.hp = math.max(1, self.hp + changed)

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, {
		self.hp,
		self.mhp
	})
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_HP_CHANGE, {})
end

function CombatUnit:update_mana_gen(preValue)
	if not self:isAlive() then
		return
	end

	self:_update_mana_frame()
end

function CombatUnit:_update_mana_frame()
	if not self:isAlive() then
		return
	end

	if self.forceManaGen then
		self.mana_frame = self.forceManaGen * self.frameLength / 1000
	else
		self.mana_frame = self.mana_gen * self.frameLength / 1000
	end

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, {
		self.mana,
		MAX_MANA
	})
end

function CombatUnit:forceSetManaGen(manaGen)
	self.forceManaGen = manaGen

	self:_update_mana_frame()
end

function CombatUnit:update_attack_speed_up(preValue)
	self:refreshAttackCd()
end

function CombatUnit:refreshAttackDist(value)
	value = value or 0
	self.attackDist = (self.battleCommonData.attack_range or 1) + value

	if self.attackDist <= 1 then
		self.isArcher = 0
	else
		self.isArcher = 1
	end
end

function CombatUnit:onStatePropChanged(propName, value)
	if propName == BattleConst.STATE_RANGE_CHANGE then
		self:refreshAttackDist(value)
	end
end

function CombatUnit:refreshAttackCd()
	if self.attackCd and self.attack_speed_up then
		if self.attack_speed_up < 0.2 then
			self.attack_speed_up = 0.2
		end

		self.attackRealTime = math.max(self.attackCd / self.attack_speed_up, self.attackInnerCd)
		self.attackRealCD = self.attackRealTime * self.framePerSec
	end
end

function CombatUnit:initBattleBuffs()
	if self.hero and self.camp == BattleConst.CAMP_PLAYER then
		if self.mgr.mazeSlics then
			for _, slicID in ipairs(self.mgr.mazeSlics) do
				if ResRelics[slicID] and ResRelics[slicID].status_id then
					self:addBattleState(self, ResRelics[slicID].status_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end

		if self.mgr.STBuffs then
			for _, buffId in ipairs(self.mgr.STBuffs) do
				if ResOpActTowerBuff[buffId] and ResOpActTowerBuff[buffId].status_id then
					self:addBattleState(self, ResOpActTowerBuff[buffId].status_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end

		if self.mgr.newMazeBuffs then
			for _, buffId in ipairs(self.mgr.newMazeBuffs) do
				if ResNewMazeDeBuff[buffId] and ResNewMazeDeBuff[buffId].status_id then
					self:addBattleState(self, ResNewMazeDeBuff[buffId].status_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end

		if self.mgr.newMazeRelics then
			for _, relicId in ipairs(self.mgr.newMazeRelics) do
				if ResNewMazeRelic[relicId] and ResNewMazeRelic[relicId].status_id then
					self:addBattleState(self, ResNewMazeRelic[relicId].status_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end

		if self.mgr.newMazeHalos then
			for _, haloId in ipairs(self.mgr.newMazeHalos) do
				if ResNewMazeHalo[haloId] and ResNewMazeHalo[haloId].status_id then
					self:addBattleState(self, ResNewMazeHalo[haloId].status_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end

		if self.mgr.newMazeFetters then
			for _, fetterId in ipairs(self.mgr.newMazeFetters) do
				if ResNewMazeFetters[fetterId] and ResNewMazeFetters[fetterId].status_id then
					self:addBattleState(self, ResNewMazeFetters[fetterId].status_id, ResNewMazeFetters[fetterId].state_level or 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end
	end

	local skillCard = ResSkillConfig[self.skillCardId] or {}

	skillCard = skillCard[self.skillLevel]

	if skillCard and skillCard.skill_passive then
		self:addPassiveSkill(skillCard.skill_passive, self.skillLevel, self.id)
	end

	local caCard = ResSkillConfig[self.caCardId] or {}

	caCard = caCard[self.attackLevel]

	if caCard and caCard.skill_passive then
		self:addPassiveSkill(caCard.skill_passive, self.attackLevel, self.id)
	end
end

function CombatUnit:initPositionFlag()
	if self.heroID and self.relationPointData then
		local relatState = utils.getRelationPointBattleState(self.heroID, self.relationPointData)

		if relatState then
			self:addBattleState(self, relatState, 1, BattleConst.STATE_DURATION_UNLIMIT)
		end
	end

	if self.mgr.specBattleType ~= BattleConst.SPECIAL_BATTLE_HOOK and self.battleCommonData.hero_passive and self.specialPassiveLevel > 0 then
		self:addPassiveSkill(self.battleCommonData.hero_passive, self.specialPassiveLevel, self.id)
	end
end

function CombatUnit:initMonsterState()
	if self.battleCommonData.enter_state and self.battleCommonData.state_level then
		self:addBattleState(self, self.battleCommonData.enter_state, self.battleCommonData.state_level, BattleConst.STATE_DURATION_UNLIMIT)
	end

	if self.battleCommonData.enter_passive and self.enterPassiveLevel > 0 then
		self:addPassiveSkill(self.battleCommonData.enter_passive, self.enterPassiveLevel, self.id)
	end
end

function CombatUnit:initEquipState()
	if self.heroEquips then
		local suits = {}
		local speSuitsCnt = 0
		local speSuitsEffectId = 0
		local speSuitsList = {}

		for _, equip in pairs(self.heroEquips) do
			if ResEquipSuit[equip.suitId] then
				suits[equip.suitId] = (suits[equip.suitId] or 0) + 1
			end

			if equip:isDefineHeroEquip() and equip:getDefineHeroId() == self.heroID then
				speSuitsCnt = speSuitsCnt + 1
				speSuitsEffectId = equip.resDefineEffctData[1].effect_id

				table.insert(speSuitsList, equip)
			end
		end

		speSuitsCnt = self.hero:getRealSpeSuitCounts(speSuitsList, speSuitsCnt)

		local activeSuitsInfo

		if speSuitsEffectId > 0 then
			for effectLv, effectInfo in ipairs(ResEquipTowerCustomEquipEffect[speSuitsEffectId]) do
				if speSuitsCnt >= effectInfo.num then
					activeSuitsInfo = effectInfo
				end
			end
		end

		if activeSuitsInfo then
			self:addBattleState(self, activeSuitsInfo.state_id, activeSuitsInfo.effect_lv, BattleConst.STATE_DURATION_UNLIMIT)
		end

		local orderSuits = {}

		for suitId, suitNum in pairs(suits) do
			table.insert(orderSuits, suitId)
		end

		table.sort(orderSuits)

		for _, suitId in ipairs(orderSuits) do
			local suitNum = suits[suitId]
			local suitData = ResEquipSuit[suitId]
			local needNum = suitData.need_num

			if needNum <= suitNum and suitData.passive_id then
				self:addPassiveSkill(suitData.passive_id, 1, self.id)
			end

			if suitData.state_id then
				local layer = math.floor(suitNum / needNum)

				for index = 1, layer do
					self:addBattleState(self, suitData.state_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
				end
			end
		end
	end

	if self.heroArtifact and self.heroArtifact.skill then
		self:addPassiveSkill(self.heroArtifact.skill.id, self.heroArtifact.skill.level, self.id)
	end

	if self.heroRelic then
		local relicePassive, level = self.heroRelic:getPassiveInfo()

		if relicePassive then
			self:addPassiveSkill(relicePassive, level, self.id)
		end
	end

	if self.heroSeasonRelic then
		local relicePassive, level = self.heroSeasonRelic:getPassiveInfo()

		if relicePassive then
			self:addPassiveSkill(relicePassive, level, self.id)
		end
	end

	if self.robotEquips then
		local suits = self.robotEquips.suits or {}

		for _, suitId in ipairs(suits) do
			local suitData = ResEquipSuit[suitId]

			if suitData.passive_id then
				self:addPassiveSkill(suitData.passive_id, 1, self.id)
			end

			if suitData.state_id then
				self:addBattleState(self, suitData.state_id, 1, BattleConst.STATE_DURATION_UNLIMIT)
			end
		end

		local effectStateIds = self.robotEquips.effect_state_id or {}

		for idx, stateId in ipairs(effectStateIds) do
			local effectLv = self.robotEquips.effect_state_lv[idx] or 1

			self:addBattleState(self, stateId, effectLv, BattleConst.STATE_DURATION_UNLIMIT)
		end

		local robotStateIds = self.robotEquips.robot_state_id or {}

		for idx, stateId in ipairs(robotStateIds) do
			local effectLv = self.robotEquips.robot_state_lv[idx] or 1

			self:addBattleState(self, stateId, effectLv, BattleConst.STATE_DURATION_UNLIMIT)
		end
	end

	if self.stickData and self.stickData.id and ResStick[self.stickData.id] then
		local stateGroupId = ResStick[self.stickData.id].state_group_id
		local level = self.stickData.level or 0

		if ResStickStateGroup[stateGroupId] and ResStickStateGroup[stateGroupId][level] then
			local stickStateIds = ResStickStateGroup[stateGroupId][level].state_ids
			local stickStateIvs = ResStickStateGroup[stateGroupId][level].state_levels

			for index, stateId in ipairs(stickStateIds) do
				local lv = stickStateIvs[index] or 1

				self:addBattleState(self, stateId, lv, BattleConst.STATE_DURATION_UNLIMIT)
			end
		end
	end

	local stateIds = {}
	local passiveIds = {}
	local paintPlusConfig = ResPaintRelate[self.heroID]

	if paintPlusConfig and self.paintPlusData and self.paintPlusData.relateLevel and self.paintPlusData.relateLevel > 0 then
		local relateProps = paintPlusConfig.relate_ability

		for index = 1, self.paintPlusData.relateLevel do
			local abilityId = relateProps[index]

			if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].state_id then
				table.insert(stateIds, ResPaintAbility[abilityId].state_id)
			end

			if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].passive_id then
				table.insert(passiveIds, ResPaintAbility[abilityId].passive_id)
			end
		end
	end

	if self.paintData and self.paintData.abilityList then
		for _, abilityId in ipairs(self.paintData.abilityList) do
			if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].state_id then
				table.insert(stateIds, ResPaintAbility[abilityId].state_id)
			end

			if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].passive_id then
				table.insert(passiveIds, ResPaintAbility[abilityId].passive_id)
			end
		end
	end

	for _, passiveId in ipairs(passiveIds) do
		self:addPassiveSkill(passiveId, 1, self.id)
	end

	for _, stateId in ipairs(stateIds) do
		self:addBattleState(self, stateId, 1, BattleConst.STATE_DURATION_UNLIMIT)
	end
end

function CombatUnit:canBeNearHited(attacker)
	if attacker:attackNear() and self.inMoving and (self.coordX ~= self.realCoordX or self.coordY ~= self.realCoordY) then
		return false
	else
		return true
	end
end

function CombatUnit:getAttackId()
	local attackId, attackLevel = self.stateGroup:getSkillChange(BattleConst.ATTACK_CA, self.caCardId, self.attackLevel)

	if attackId then
		return attackId, attackLevel
	end

	if self.attackIds then
		local choose = self.randomGenerator:random(1, #self.attackIds)

		return self.attackIds[choose], self.attackLevel
	end

	return self.caCardId, self.attackLevel
end

function CombatUnit:getSkillId()
	local skillId, skillLevel = self.stateGroup:getSkillChange(BattleConst.ATTACK_SKILL, self.skillCardId, self.skillLevel)

	if skillId then
		return skillId, skillLevel
	end

	return self.skillId, self.skillLevel
end

function CombatUnit:getPassiveId(passiveCardId, passiveCardLevel, defaultSkillId)
	local skillId, skillLevel = self.stateGroup:getSkillChange(BattleConst.ATTACK_TRIGGER, passiveCardId, passiveCardLevel)

	if skillId then
		return skillId, skillLevel
	end

	return defaultSkillId, passiveCardLevel
end

function CombatUnit:triggerPassiveCard(cardId, cardLevel, triggerCD, cardUseCD, targetId)
	if self.passiveCardTriggerFrame[cardId] and self.passiveCardTriggerFrame[cardId].triggerDisable then
		return
	end

	if ResSkillConfig[cardId] and ResSkillConfig[cardId][cardLevel] and ResSkillConfig[cardId][cardLevel].skill_ids then
		for _, cardInfo in ipairs(self.passiveCardInfo) do
			if cardInfo[1] == cardId then
				return
			end
		end

		table.insert(self.passiveCardInfo, 1, {
			cardId,
			cardLevel,
			math.floor(cardUseCD * self.framePerSec),
			ResSkillConfig[cardId][cardLevel].skill_ids[1],
			targetId
		})

		if not self.passiveCardTriggerFrame[cardId] then
			self.passiveCardTriggerFrame[cardId] = {}
		end

		if triggerCD > 0 then
			self.passiveCardTriggerFrame[cardId].triggerDisable = true

			if self.resumePauseFrame >= self.frameNumber then
				self:addTickQuest(self.resumePauseFrame + math.floor(triggerCD * self.framePerSec), TICK_QUEST_TYPE_PASSIVE_CARD_TRIGGER, {
					cardId
				})
			else
				self:addTickQuest(self.frameNumber + math.floor(triggerCD * self.framePerSec), TICK_QUEST_TYPE_PASSIVE_CARD_TRIGGER, {
					cardId
				})
			end
		else
			self.passiveCardTriggerFrame[cardId].triggerDisable = false
		end
	end
end

function CombatUnit:handleSkillTarget(skillTarget)
	local target = AttackCalc.getSkillLockTarget(self.mgr, self, skillTarget)

	self:lockTarget(target)
end

function CombatUnit:onAddSilenceState()
	if self.usingSkill and self.attackType == BattleConst.ATTACK_SKILL then
		self:onSkillInterupt()
		self.behaviorFSM:onToIdle()
	end
end

function CombatUnit:onCheckCampState()
	local needCampChanged = self.stateGroup:getProp(BattleConst.STATE_CHANGE_CAMP, 0) > 0

	if needCampChanged then
		if self.attackCamp == self.camp then
			self.attackCamp = self.camp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER

			if self.usingSkill then
				self:onSkillInterupt()
				self.behaviorFSM:onToIdle()
			end

			self.attackEnableFrame = 0

			self:addOutput(BattleConst.MATRIX_EVENT_CHANGE_CAMP, {
				self.camp,
				self.attackCamp
			})
		end
	elseif self.attackCamp ~= self.camp then
		self.attackCamp = self.camp

		self:addOutput(BattleConst.MATRIX_EVENT_CHANGE_CAMP, {
			self.camp,
			self.attackCamp
		})
	end
end

function CombatUnit:usingPassiveSkill()
	for index, cardInfo in ipairs(self.passiveCardInfo) do
		local cardId = cardInfo[1]

		if not self.passiveCardTriggerFrame[cardId] or not self.passiveCardTriggerFrame[cardId].useDisable then
			local cardLevel = cardInfo[2]
			local cd = cardInfo[3]
			local skillId = cardInfo[4]

			skillId, cardLevel = self:getPassiveId(cardId, cardLevel, skillId)

			local targetId = cardInfo[5]
			local skillData = SkillDataBank.getSkillData(self.weaponType, skillId) or {}

			self:initSkillVideoData(skillData)

			if skillData.targetInherit == 1 then
				local inheritTarget = self.mgr:getObjectByKey(targetId)

				if inheritTarget and inheritTarget:isAlive() then
					self:lockTarget(inheritTarget)
				else
					self:clearTarget()
					self:handleSkillTarget(skillData.skillTarget or 0)
				end
			else
				self:handleSkillTarget(skillData.skillTarget or 0)
			end

			if self.target then
				local target = self.target

				table.remove(self.passiveCardInfo, index)
				self:_useTriggerSkill(cardId, cardLevel, skillId, skillData)

				if cd > 0 then
					self.passiveCardTriggerFrame[cardId].useDisable = true

					self:addTickQuest(self.frameNumber + cd, TICK_QUEST_TYPE_PASSIVE_CARD_USE, {
						cardId
					})
				else
					self.passiveCardTriggerFrame[cardId].useDisable = false
				end

				if skillData.actTime and skillData.actTime > 0 and self.mgr.specBattleType ~= BattleConst.SPECIAL_BATTLE_SUN_FLOWER then
					local targets, base = AttackCalc.getSkillTargets(self.mgr, self, target.id, skillId, cardLevel, skillData.hideEvent)
					local actTime = math.floor(skillData.actTime * self.framePerSec / 30)

					self.mgr:onSkillActTime(self, actTime, targets, skillData.hideTime, cardId, skillData.hideEffect == 1)
				end

				return true
			end
		end
	end

	return false
end

function CombatUnit:_checkManaFullSkill(predictFrame)
	if self.stateGroup:getProp(BattleConst.STATE_SILENCE, 0) > 0 or self.stateGroup:getProp(BattleConst.STATE_CHANGE_CAMP, 0) > 0 then
		return false
	end

	if predictFrame then
		if self.mana + predictFrame * self.mana_frame < MAX_MANA then
			return false
		end
	elseif self.mana < MAX_MANA then
		return false
	end

	if not self.skillCardId then
		return false
	end

	if self.camp == BattleConst.CAMP_PLAYER and self.playerControl and self.mgr:inManualOpera() and not self.manualHasClick then
		return false
	end

	return true
end

function CombatUnit:usingManaFullSkill()
	if not self:_checkManaFullSkill() then
		return false
	end

	local usingSkill, nowSkillLevel = self:getSkillId()
	local skillData = self.skillData

	if usingSkill == self.skillId then
		self:handleSkillTarget(self.skillData.skillTarget or 0)
	else
		skillData = SkillDataBank.getSkillData(self.weaponType, usingSkill)

		self:handleSkillTarget(skillData.skillTarget or 0)
	end

	if self.target then
		if self.mgr.frameSkillEntity == self and self.target:canBeNearHited(self) then
			self:_useSkill(usingSkill, nowSkillLevel, skillData)
		end

		return true
	end

	return false
end

function CombatUnit:usingCASkill()
	if self.stateGroup:getProp(BattleConst.STATE_DISARM, 0) > 0 then
		return false
	end

	if self.frameNumber < self.attackEnableFrame then
		return false
	end

	local target = self:_getNearestEnemy(self.attackDist)

	self:lockTarget(target)

	if self.target then
		self:_useAttack()

		return true
	end

	return false
end

function CombatUnit:_useAttack()
	if not self.target:canBeNearHited(self) then
		self:clearTarget()

		return
	end

	self.usingSkill, self.nowSkillLevel = self:getAttackId()
	self.nowCardId = self.caCardId

	self:initSkillVideoData()

	self.skillRecordTargets[self.usingSkill] = nil

	if self.attackRandom and self.attackRandom > 0 then
		local extraCd = self.randomGenerator:random(0, self.attackRandom)

		self.attackEnableFrame = self.frameNumber + self.attackRealCD + extraCd
	else
		self.attackEnableFrame = self.frameNumber + self.attackRealCD
	end

	self.attackType = BattleConst.ATTACK_CA

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, {
		self.usingSkill,
		self.attackType,
		[5] = self.nowCardId
	})

	local useSkillArgs = {}

	useSkillArgs.attackRealTime = self.attackRealTime
	useSkillArgs.attackCd = self.attackCd

	self.behaviorFSM:useSkill(self.usingSkill, useSkillArgs)
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD, {
		self.caCardId,
		self.target.id,
		self.attackType
	})
end

function CombatUnit:manualWaitingSkill()
	return self.manualHasClick
end

function CombatUnit:_useSkill(skillId, skillLevel, skillData)
	if self.usingSkill then
		self:_skillRealEnd(true)
	end

	self.manualHasClick = false

	self:onChangeMana(-MAX_MANA)

	self.nowCardId = self.skillCardId
	self.usingSkill = skillId
	self.nowSkillLevel = skillLevel
	self.attackType = BattleConst.ATTACK_SKILL

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, {
		self.usingSkill,
		self.attackType,
		skillData.prepareCamera,
		skillData.prepareCamDruation,
		self.nowCardId
	})

	self.skillRecordTargets[self.usingSkill] = nil

	self.behaviorFSM:useSkill(self.usingSkill)
	self:initSkillVideoData(skillData)

	if self.pauseInSkill and self.skillPauseTime and self.skillPauseTime > 0 then
		local targets, base = AttackCalc.getSkillTargets(self.mgr, self, self.target.id, self.skillCardId, self.nowSkillLevel, self.skillAreaEvent)

		self.mgr:onSkillActTime(self, self.skillPauseTime + self.videoPauseFrame, targets, self.skillAreaTime, self.skillCardId, skillData.hideEffect == 1)
	end

	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD, {
		self.skillCardId,
		self.target.id,
		self.attackType
	})

	self.manaFullSkillNum = self.manaFullSkillNum + 1
	self.recordSkillHitNum = 0
end

function CombatUnit:_useTriggerSkill(cardID, cardLevel, skillId, skillData)
	if self.usingSkill then
		self:_skillRealEnd(true)
	end

	self.nowCardId = cardID
	self.usingSkill = skillId
	self.attackType = BattleConst.ATTACK_TRIGGER
	self.nowSkillLevel = cardLevel

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN, {
		self.usingSkill,
		self.attackType,
		skillData.prepareCamera,
		skillData.prepareCamDruation
	})

	self.skillRecordTargets[self.usingSkill] = nil

	self.behaviorFSM:useSkill(self.usingSkill)
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD, {
		cardID,
		self.target.id,
		self.attackType
	})
end

function CombatUnit:manualClickSkill()
	self.manualHasClick = true

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_CACHE_SKILL, {})
end

function CombatUnit:_getNearestEnemy(needDist, ignoreBig)
	local coordX = self.coordX
	local coordY = self.coordY
	local target, objs
	local dist = needDist
	local tauntId = self.stateGroup:getTauntInfo()

	if tauntId then
		objs = {
			tauntId
		}
	else
		objs = self.mgr.orderObjects
	end

	local minY = 5
	local minDist = needDist

	for index, objId in ipairs(objs) do
		local obj = self.mgr.objects[objId]

		if obj.camp ~= self.attackCamp and obj.hp > 0 and obj ~= self then
			local yDist = math.abs(obj.coordY - coordY)
			local objDist = self.mgr:getDist(coordX, coordY, obj.coordX, obj.coordY)

			if obj.bigMonster then
				if ignoreBig then
					yDist = math.max(0, yDist - 0.5)
				else
					yDist = math.max(0, yDist - 1)
					objDist = objDist - 1
				end
			end

			if yDist == minY then
				if objDist < dist then
					target = obj
					dist = objDist
				elseif objDist == dist and (not target or target.coordY <= obj.coordY) then
					target = obj
				end
			elseif yDist < minY then
				if objDist <= needDist then
					target = obj
					minY = yDist
					dist = objDist
				elseif yDist == 0 then
					target = nil
					minY = 0
					dist = needDist
				end
			end
		end
	end

	return target
end

function CombatUnit:getMoveTargetCoord()
	local target = self:_getNearestEnemy(9999)

	if not target then
		return nil
	end

	local forwardX = self.coordX < target.coordX and 1 or -1
	local forwardY = self.coordY < target.coordY and 1 or -1

	if self.aiMode == AI_MODE_ZOMBIE then
		if math.abs(self.coordX - target.coordX) <= 1 then
			return nil
		elseif self.mgr:getObject(self.coordX + forwardX, self.coordY) == false then
			return {
				self.coordX + forwardX,
				self.coordY
			}
		else
			return nil
		end
	end

	local targetDist = self.mgr:getDist(self.coordX, self.coordY, target.coordX, target.coordY)

	if target.bigMonster then
		targetDist = targetDist - 1
	end

	if targetDist <= self.attackDist then
		return false
	end

	return self.mgr:getMoveInfo(self, target)
end

function CombatUnit:onSkillPause(pauseFrame, targets, attacker, hideDelayTime, cardId, hideEffect)
	self.resumePauseFrame = self.mgr.frameNumber + pauseFrame
	self.attackEnableFrame = self.attackEnableFrame + pauseFrame
	self.skillSelf = attacker == self

	local tmpDict = self.tickQuestDict

	self.tickQuestDict = {}

	for frameNumber, frameInfo in pairs(tmpDict) do
		self.tickQuestDict[frameNumber + pauseFrame] = frameInfo
	end

	if not self.inReborn then
		self.skillHideDict = {
			self.skillSelf,
			targets,
			hideDelayTime,
			cardId,
			hideEffect
		}

		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE, self.skillHideDict)

		if not self.skillSelf then
			self.behaviorFSM:pauseBH()

			if self.inMoving and self.moveEndFrame then
				self.moveEndFrame = self.moveEndFrame + pauseFrame
				self.moveHalfFrame = self.moveHalfFrame + pauseFrame
			end
		end
	end
end

function CombatUnit:checkHeroSkill()
	if self:_heroInMoving() then
		return
	end

	local frameSkillEntity = self.mgr.frameSkillEntity

	if frameSkillEntity and frameSkillEntity.skillPrior <= self.skillPrior then
		return
	end

	local updatePredict = false

	if self.behaviorFSM:canUseSkill() and self:_checkManaFullSkill() then
		local target = AttackCalc.getSkillLockTarget(self.mgr, self, self.skillData.skillTarget)

		if target and target:canBeNearHited(self) then
			self.mgr.frameSkillEntity = self
			self.mgr.frameSkillPause = self.pauseInSkill and self.skillPauseTime and self.skillPauseTime > 0
			self.mgr.predictSkillEntity = self
		end
	end
end

function CombatUnit:predictHeroSkill()
	local predictSkillEntity = self.mgr.predictSkillEntity

	if predictSkillEntity.skillPrior > self.skillPrior and self.behaviorFSM:predictCanUseSkill(self.skillPriorTime) and self:_checkManaFullSkill(self.skillPriorTime) then
		local target = AttackCalc.getSkillLockTarget(self.mgr, self, self.skillData.skillTarget)

		if target and target:canBeNearHited(self) then
			self.mgr.predictSkillEntity = self
		end
	end
end

function CombatUnit:_heroInMoving()
	return self.inMoving and self.frameNumber < self.moveEndFrame
end

function CombatUnit:_checkFrameAction()
	if self:_heroInMoving() then
		return
	end

	if not self.behaviorFSM:canUseSkill() then
		return
	end

	if self:usingManaFullSkill() then
		return
	end

	if self:usingPassiveSkill() then
		return
	end

	if self.usingSkill then
		return
	end

	if self.aiMode == AI_MODE_ZOMBIE then
		if self:_checkMoveAction() then
			return
		end

		self:usingCASkill()
	else
		if self:usingCASkill() then
			return
		end

		if self:_checkMoveAction() == nil and self.attackDist == 1 then
			self.behaviorFSM:onToWait()
		end
	end
end

function CombatUnit:_checkSkillFrameAction()
	if self:_heroInMoving() then
		return
	end

	if not self.behaviorFSM:canUseSkill() then
		return
	end

	if self:usingPassiveSkill() then
		return
	end
end

function CombatUnit:_checkMoveAction()
	if self.aiMode ~= AI_MODE_WALL_NUT and self.aiMode ~= AI_MODE_CHUYIN then
		local moveInfo = self:getMoveTargetCoord()

		if moveInfo then
			self.moveEndFrame = self.frameNumber + self.moveFrame
			self.moveHalfFrame = self.frameNumber + self.halfMoveFrame

			self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE, {
				true,
				self.coordX,
				self.coordY,
				moveInfo[1],
				moveInfo[2],
				self.moveTime
			})

			self.movePreX = self.coordX
			self.movePreY = self.coordY
			self.coordX = moveInfo[1]
			self.coordY = moveInfo[2]
			self.inMoving = true

			return true
		end

		return moveInfo
	end

	return nil
end

function CombatUnit:addTickQuest(tickNumber, questType, questArgs)
	if not self.tickQuestDict[tickNumber] then
		self.tickQuestDict[tickNumber] = {}
	end

	if not self.tickQuestDict[tickNumber][questType] then
		self.tickQuestDict[tickNumber][questType] = {}
	end

	table.insert(self.tickQuestDict[tickNumber][questType], questArgs)
end

function CombatUnit:_tickQuests(frameNumber, skillTick)
	if self.moveHalfFrame == frameNumber then
		self:onMoveHalf()
	end

	if self.moveEndFrame == frameNumber then
		self:onStopMove()
	end

	if not skillTick then
		self.selfHealFrame = self.selfHealFrame + 1

		if self.selfHealFrame >= self.framePerSec then
			if self.life_reply > 0 then
				self:calcHpChanged(BattleConst.DAMAGE_TYPE_SELF_HEAL, math.floor(self.life_reply), nil, self)
			end

			self.selfHealFrame = 0
		end
	end

	local tickQuests = self.tickQuestDict[frameNumber]

	if tickQuests then
		for tickQuestType, tickQuestArgs in pairs(tickQuests) do
			local func = self.tickQuestFuncConfig[tickQuestType]

			for index, info in ipairs(tickQuestArgs) do
				if func then
					func(unpack(info))
				end
			end
		end

		self.tickQuestDict[frameNumber] = nil
	end
end

function CombatUnit:delayAtkEvent(attackArgs, delayArgs)
	AttackCalc.calcDelayAttack(self.mgr, self, attackArgs, delayArgs)
end

function CombatUnit:onShieldOutTime(shieldIndex)
	self:onDelShieldByTime(shieldIndex)
end

function CombatUnit:onPassiveCardTrigger(cardId)
	self.passiveCardTriggerFrame[cardId].triggerDisable = false
end

function CombatUnit:onPassiveCardUse(cardId)
	self.passiveCardTriggerFrame[cardId].useDisable = false
end

function CombatUnit:onMoveHalf()
	self:onSetRealCoord(self.coordX, self.coordY)
end

function CombatUnit:onSetRealCoord(coordX, coordY)
	self.realCoordX = coordX
	self.realCoordY = coordY

	self.mgr:toRealCoord(self, coordX, coordY)
end

function CombatUnit:onStopMove(noBack)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE, {
		false,
		self.coordX,
		self.coordY,
		self.coordX,
		self.coordY,
		0,
		noBack
	})

	self.inMoving = false
end

function CombatUnit:beHited(attacker, damageInfo, damageType, isCrit, cardInfo, eventData, isAtkEvent, extraHitedInfo)
	local disablePassive = eventData and eventData.disablePassive and eventData.disablePassive > 0
	local disableHpPassive = eventData and eventData.disableHpPassive and eventData.disableHpPassive > 0

	if self.mgr.matrixInstance.battleOver then
		return
	end

	local cardId, skillId

	if cardInfo then
		cardId = cardInfo[1]
		skillId = cardInfo[2]
	end

	if isAtkEvent and self.inSpecialControlled then
		self.behaviorFSM:onToIdle()
	end

	local damage = damageInfo

	if damageType == BattleConst.DAMAGE_TYPE_REBOUND or BattleConst.HURT_DICT[damageType] or damageType == BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE or damageType == BattleConst.DAMAGE_TYPE_LINK then
		damage = damageInfo[1] + damageInfo[2]
	end

	if BattleConst.HURT_DICT[damageType] then
		self.lastBeHurtNum = damage
	end

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DAMAGE, {
		damage,
		damageType,
		isCrit,
		attacker.id,
		extraHitedInfo,
		cardId
	})
	self.mgr:recordCombatResult(attacker.id, self.id, damageType, damage, isCrit, attacker.master)

	if not disablePassive and not attacker.isToolMan then
		local block = false

		if extraHitedInfo then
			block = extraHitedInfo[4]
		end

		if not extraHitedInfo or not extraHitedInfo[1] then
			attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
				BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT,
				self,
				damageType,
				damageInfo,
				isCrit,
				cardId,
				block,
				skillId
			})
		end

		self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
			BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT,
			attacker,
			damageType,
			damageInfo,
			isCrit,
			cardId,
			block,
			skillId
		})
	end

	if damageType == BattleConst.DAMAGE_TYPE_HURT_ICE or damageType == BattleConst.DAMAGE_TYPE_HURT_FIRE then
		self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
			BattleConst.PASSIVE_TRIGGER_SPECIAL_DAMAGE,
			attacker,
			damageType,
			damageInfo
		})
	end

	if damageType == BattleConst.DAMAGE_TYPE_MISS then
		self.preMissFrame = self.frameNumber

		return
	elseif damageType == BattleConst.DAMAGE_TYPE_HURT_IMMUE then
		return
	end

	local preHp = self.hp

	self:calcHpChanged(damageType, damageInfo, extraHitedInfo, attacker, disableHpPassive)

	if self.hp <= 0 and preHp > 0 then
		self.mgr:onUnitDead(self, attacker)
		self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
			BattleConst.PASSIVE_TRIGGER_ATTACK_KILL,
			attacker
		})
		attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
			BattleConst.PASSIVE_TRIGGER_ATTACK_KILL,
			self
		})

		self.waiting_for_reborn = false
		self.pre_dead_round = self.curRound

		self:onDead(isCrit)

		return true
	end
end

function CombatUnit:calcHpChanged(damageType, damage, extraHitedInfo, attacker, disableHpPassive)
	local preHp = self.hp
	local preShield = self.shield
	local damageRaise = false

	if damageType == BattleConst.DAMAGE_TYPE_HP_REMOVE then
		self.hp = math.max(0, self.hp - damage)
		damageRaise = true
	elseif damageType == BattleConst.DAMAGE_TYPE_REBOUND or BattleConst.HURT_DICT[damageType] or damageType == BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE or damageType == BattleConst.DAMAGE_TYPE_LINK then
		damageRaise = true
		self.hp = math.max(0, self.hp - damage[1])

		if damage[2] > 0 then
			self:onDelShield(damage[2])
			self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, {
				self.shield
			})
			self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD, {})
		end
	elseif damageType == BattleConst.DAMAGE_TYPE_SHIELD then
		if extraHitedInfo and extraHitedInfo[2] and extraHitedInfo[2] > 0 then
			self:onAddShield(damage, extraHitedInfo[2])
		end
	elseif (damageType == BattleConst.DAMAGE_TYPE_HEAL or damageType == BattleConst.DAMAGE_TYPE_VAMPIRE or damageType == BattleConst.DAMAGE_TYPE_SELF_HEAL) and self:isAlive() then
		self.hp = math.min(self.mhp, self.hp + damage)
	end

	if preHp > 0 and self.hp <= 0 and self.stateGroup:getProp(BattleConst.STATE_UNDEAD, 0) > 0 then
		self.hp = 1
	end

	self.hppct = self.hp / self.mhp
	self.minHpPercent = math.min(self.hppct, self.minHpPercent)

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE, {
		self.hp,
		self.mhp,
		damageRaise
	})
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_HP_CHANGE, {
		attacker,
		preHp,
		preShield,
		disableHpPassive
	})
end

local KILL_MANA = BattleConst.KILL_MANA

function CombatUnit:onKillSomeOne(victim)
	if victim and victim.master then
		return
	end

	self.killNum = self.killNum + 1

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
		BattleConst.ENTITY_SOMETHING_KILL_SOMEONE,
		victim.id,
		self.mgr.realFrameNumber
	})

	if self.battleCommonData.kill_no_mana == 1 then
		return
	end

	self:onChangeMana(KILL_MANA)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED, {
		KILL_MANA,
		true
	})
end

function CombatUnit:onAddShield(shield, shieldTime)
	local preShield = self.shield

	self.shield = math.min(self.shield + shield, BattleMiscConfig.SHIELD_MAX)
	shield = self.shield - preShield

	table.insert(self.shieldInfo, {
		self.shieldIndex,
		shield
	})
	self:addTickQuest(self.frameNumber + math.floor(shieldTime * self.framePerSec), TICK_QUEST_TYPE_SHIELD_TIMEOUT, {
		self.shieldIndex
	})

	self.shieldIndex = self.shieldIndex + 1

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, {
		self.shield
	})
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD, {})
end

function CombatUnit:onDelShield(shield)
	if shield > 0 and self.shield > 0 then
		if shield >= self.shield then
			self.shieldInfo = {}
			self.shield = 0
		else
			self.shield = self.shield - shield

			for index = 1, #self.shieldInfo do
				local info = self.shieldInfo[1]

				if shield >= info[2] then
					shield = shield - info[2]

					table.remove(self.shieldInfo, 1)
				else
					info[2] = info[2] - shield

					break
				end
			end
		end
	end
end

function CombatUnit:onDelShieldByTime(shieldIndex)
	for index, info in ipairs(self.shieldInfo) do
		if info[1] == shieldIndex then
			self.shield = math.max(0, self.shield - info[2])

			table.remove(self.shieldInfo, index)
			self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE, {
				self.shield
			})
			self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD, {})

			break
		end
	end
end

function CombatUnit:beTaunted(aid)
	if self.inMoving then
		local back = true

		if self.mgr:getObject(self.movePreX, self.movePreY) then
			back = false
		elseif self.realCoordX == self.coordX and self.realCoordY == self.coordY then
			back = false
		end

		self:_interruptMoving(back)
	end
end

function CombatUnit:_interruptMoving(back)
	if self.inMoving then
		self:onStopMove(true)

		self.moveEndFrame = 0
		self.moveHalfFrame = 0

		if back then
			self.coordX = self.movePreX
			self.coordY = self.movePreY
		end

		self:onSetRealCoord(self.coordX, self.coordY)
	end
end

function CombatUnit:beHitedControlled(duration, attacker, hitedFlag)
	if self.stateGroup:getProp(BattleConst.STATE_IMMUNE_CONTROLLED, 0) > 0 then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.STATE_IMMUNE_CONTROLLED
		})
		self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, {
			BattleConst.STATE_IMMUNE_CONTROLLED,
			attacker
		})

		return
	end

	duration = duration * (1 - (self[BattleConst.STATE_CONTROLLED_RESIST] or 0) * 0.0001)

	if self.usingSkill then
		self:onSkillInterupt()
	end

	if self.inMoving then
		local attackerX = attacker.coordX
		local attackerY = attacker.coordY
		local back = true

		if self.mgr:getObject(self.movePreX, self.movePreY) then
			back = false

			if hitedFlag == "stun" then
				self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO, {
					0.1
				})
			end
		elseif hitedFlag == "stun" then
			if attackerX and attackerY then
				if self.movePreY == self.coordY then
					if attackerX == self.movePreX then
						back = false
					elseif attackerX > self.movePreX then
						if self.coordX < self.movePreX then
							back = false
						end
					elseif self.coordX > self.movePreX then
						back = false
					end
				elseif attackerY == self.movePreY then
					back = false
				elseif attackerY > self.movePreY then
					if self.coordY < self.movePreY then
						back = false
					end
				elseif self.coordY > self.movePreY then
					back = false
				end
			elseif self.realCoordX == self.coordX and self.realCoordY == self.coordY then
				back = false
			end

			self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO, {
				0.1
			})
		elseif self.realCoordX == self.coordX and self.realCoordY == self.coordY then
			back = false
		end

		self:_interruptMoving(back)
	end

	if hitedFlag == "freeze" or hitedFlag == "timelock" then
		self.behaviorFSM:beHited(duration, "", hitedFlag)
	else
		self.behaviorFSM:beHited(duration, hitedFlag or "", hitedFlag)
	end

	if self.offsetStart then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK, {
			0.1
		})

		self.offsetStart = false
	end

	attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
		BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED,
		self,
		hitedFlag,
		duration
	})
end

function CombatUnit:enterEntityHited(hitedFlag)
	self.inControlled = 1
	self.hitedFlag = hitedFlag

	if self.hitedFlag == "timelock" or self.hitedFlag == "sleep" then
		self.inSpecialControlled = true
	else
		self.inSpecialControlled = false
	end

	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
		BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED,
		hitedFlag,
		1
	})
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER, {
		BattleConst.ENTITY_STATE_HITED,
		hitedFlag
	})
end

function CombatUnit:exitEntityHited(hitedFlag)
	self.inControlled = nil

	if self.hitedFlag == "timelock" or self.hitedFlag == "sleep" then
		self.inSpecialControlled = false
	end

	self.hitedFlag = nil

	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
		BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED,
		hitedFlag,
		0
	})
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT, {
		BattleConst.ENTITY_STATE_HITED,
		hitedFlag
	})
end

function CombatUnit:beHitedAnim(hitedAnim)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM, {
		hitedAnim
	})
end

function CombatUnit:beHitedOffset(offsetPath)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET, {
		offsetPath
	})
end

function CombatUnit:onDead(isSpecialDie)
	self.stateGroup:clear()
	self.passiveGroup:clear()
	self.behaviorFSM:onToDead()
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DEAD, {})

	self.deadTime = self.mgr.countTime
end

function CombatUnit:onReborn(coordX, coordY, mhpPrecent, master)
	self:addOutput(BattleConst.MATRIX_EVENT_REBORN_ENTITY_START, {
		master.id
	})

	self.inReborn = true
	self.tickQuestDict = {}
	self.coordX = coordX
	self.coordY = coordY
	self.realCoordX = self.coordX
	self.realCoordY = self.coordY
	self.frameNumber = self.mgr.frameNumber
	self.inMoving = false
	self.moveEndFrame = 0
	self.moveHalfFrame = 0
	self.passiveCardInfo = {}
	self.passiveCardTriggerFrame = {}
	self.propInInitialization = true

	PropBoard.init_props(self)

	self.hp = self.mhp * mhpPrecent * 0.0001
	self.hppct = self.hp / self.mhp
	self.propInInitialization = false
	self.attackCamp = self.camp

	self:refreshAttackDist()
	self:refreshAttackCd()
	self:_update_mana_frame()

	if self.hero then
		self.mana = self.hero:getInitMana()
	else
		self.mana = self.battleCommonData.init_mana
	end

	self.shieldInfo = {}
	self.shieldIndex = 1

	local preSkill = self.usingSkill

	self.usingSkill = nil

	self:clearTarget()

	if master.resumePauseFrame and master.resumePauseFrame > self.frameNumber then
		local pauseFrame = master.resumePauseFrame - self.frameNumber

		self:onSkillPause(pauseFrame, {}, master)
	end

	self.behaviorFSM:cancelPauseBH()
	self.behaviorFSM:onToIdle()
	self:initInEnterBattle()

	self.inReborn = nil

	self:addOutput(BattleConst.MATRIX_EVENT_REBORN_ENTITY, {
		master.id
	})
end

function CombatUnit:onObjectDead(deadObject)
	self.stateGroup:onAttackerDead(deadObject)
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_DEAD, {
		deadObject
	})
	self:removeFromAttacker(deadObject)
end

function CombatUnit:raiseSimpleEvent(simpleArgs)
	local simpleEvent = simpleArgs[1]

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
		simpleEvent
	})
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, simpleArgs)
end

function CombatUnit:initSkillEventHandler()
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_ATTACK, Slot(self.processSkillAtkEvent, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_SKILLEND, Slot(self.onSkillEnd, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_CAMERA, Slot(self.onCameraEvent, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_OFFSET, Slot(self.onOffsetEvent, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM, Slot(self.onToIdleAnim, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_CLIENT_ANIM, Slot(self.onPlayClientAnim, self))
	self.behaviorFSM:registerEvent(BattleConst.BEHAVIOR_EVENT_VIDEO, Slot(self.onPlaySkillVideo, self))
end

function CombatUnit:onPlayClientAnim(animInfo)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM, {
		animInfo[2]
	})
end

function CombatUnit:initSkillVideoData(skillData)
	if skillData then
		local shortMode = false

		shortMode = (not self.forceLongSkill or false) and (self.forceShortSkill and true or self.mgr:inShortSkill())

		if shortMode then
			self.skillInShortMode = true
			self.videoCue = skillData.shortVideoActCue
			self.videoPauseFrame = skillData.shortVideoActTime or 0
			self.videoPauseFrame = math.floor(self.videoPauseFrame * self.framePerSec / 30)
		else
			self.skillInShortMode = false
			self.videoCue = skillData.videoActCue
			self.videoPauseFrame = skillData.videoActTime or 0
			self.videoPauseFrame = math.floor(self.videoPauseFrame * self.framePerSec / 30)
		end
	else
		self.videoCue = nil
		self.videoPauseFrame = 0
	end
end

function CombatUnit:onPlaySkillVideo(animInfo)
	if self.videoPauseFrame and self.videoPauseFrame > 0 then
		self.behaviorFSM:pauseBH()

		self.skillSelfPauseFrame = self.frameNumber + 1 + self.videoPauseFrame

		if self.videoCue then
			self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_MOVIE, {
				self.videoCue
			})
		end
	end
end

function CombatUnit:onToIdleAnim()
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM, {})
end

function CombatUnit:processSkillAtkEvent(skillEventInfo)
	local eventId = skillEventInfo[4] or 0

	self:triggerSkillEvent(self.usingSkill, eventId, self.target.id, self.nowCardId, self.nowSkillLevel)
end

function CombatUnit:onSkillInterupt()
	if self.usingSkill and self.attackType == BattleConst.ATTACK_SKILL then
		self.beInteruptSkillNum = self.beInteruptSkillNum + 1
	end

	self:_skillRealEnd()
end

function CombatUnit:onSkillEnd(skillEventInf)
	self.behaviorFSM:onToIdle()
	self:_skillRealEnd()
end

function CombatUnit:_skillRealEnd(nextSkill)
	local preSkill = self.usingSkill

	self.usingSkill = nil

	if not nextSkill then
		if self.attackType ~= BattleConst.ATTACK_CA then
			self:clearTarget()
		else
			self:confirmTarget()
		end
	end

	if self.attackType == BattleConst.ATTACK_CA then
		self.stateGroup:triggerInvalidCondition(BattleConst.STATE_INVALID_TYPE_CARD_CA)
	elseif self.attackType == BattleConst.ATTACK_SKILL then
		self.stateGroup:triggerInvalidCondition(BattleConst.STATE_INVALID_TYPE_CARD_NO_CA)
		self.mgr:noticeSkillEnd(self, preSkill)
	end

	self.stateGroup:triggerInvalidCondition(BattleConst.STATE_INVALID_TYPE_CARD)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_END, {})
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD_END, {
		self.nowCardId,
		self.attackType
	})
end

function CombatUnit:confirmTarget()
	if self.target and self.target.camp == self.attackCamp then
		self:clearTarget()

		return
	end

	if self.target and not self.target:isAlive() then
		self:clearTarget()

		return
	end

	if self.target and self.mgr:getDist(self.coordX, self.coordY, self.target.coordX, self.target.coordY) > self.attackDist then
		self:clearTarget()

		return
	end

	if self.stateGroup:getTauntInfo() then
		self:clearTarget()
	end
end

function CombatUnit:onCameraEvent(skillEventInfo)
	if skillEventInfo[2] and skillEventInfo[3] then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_CAMERA, {
			skillEventInfo[2],
			skillEventInfo[3]
		})
	end
end

function CombatUnit:onOffsetEvent(skillEventInfo)
	if skillEventInfo[2] == "start" then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP, {
			skillEventInfo[3],
			skillEventInfo[4]
		})

		self.offsetStart = true
	elseif skillEventInfo[2] == "start.target" then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP, {
			skillEventInfo[3],
			skillEventInfo[4],
			self.preRecordTarget
		})

		self.offsetStart = true
	elseif skillEventInfo[2] == "stop" then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK, {
			skillEventInfo[4]
		})

		self.offsetStart = false
	end
end

function CombatUnit:recordDamageValue(valueKey, value)
	if not self.dmgValueRecorder then
		self.dmgValueRecorder = {}
	end

	self.dmgValueRecorder[valueKey] = value
end

function CombatUnit:getDamageRecordValue(valueKey)
	if self.dmgValueRecorder and self.dmgValueRecorder[valueKey] then
		return self.dmgValueRecorder[valueKey]
	end

	return 0
end

function CombatUnit:triggerSkillEvent(skillId, eventId, targetId, cardId, eventLevel)
	local eventData = SkillDataBank.getAtkEventData(self.weaponType, skillId, eventId, eventLevel)

	if not eventData then
		return
	end

	eventLevel = eventLevel or 1

	local boxType = eventData.boxType

	if boxType == BattleConst.BOX_TYPE_STATIC then
		self:realAtkEvent(skillId, targetId, eventId, eventLevel, cardId)
	elseif boxType == BattleConst.BOX_TYPE_THROW then
		local boxDelay = eventData.delay
		local flySpeed = eventData.unitDelay
		local attackArgs = {
			skillId,
			targetId,
			eventId,
			eventLevel,
			cardId
		}
		local skillPower = self.stateGroup:getSkillEnhanceRate(cardId, skillId)
		local delayArgs = AttackCalc.onCalcAttack(self.mgr, self, attackArgs, skillPower, boxDelay, flySpeed)

		if delayArgs then
			for flyFrame, delayInfo in pairs(delayArgs) do
				self:addTickQuest(self.frameNumber + flyFrame, TICK_QUEST_TYPE_THROW_BOX, {
					attackArgs,
					delayInfo
				})
			end
		end
	end
end

function CombatUnit:realAtkEvent(skillId, targetId, eventId, eventLevel, cardId)
	local skillPower = self.stateGroup:getSkillEnhanceRate(cardId, skillId)
	local attackArgs = {
		skillId,
		targetId,
		eventId,
		eventLevel,
		cardId
	}

	AttackCalc.onCalcAttack(self.mgr, self, attackArgs, skillPower)
end

function CombatUnit:delStateLayer(attacker, stateId, delLayer)
	return self.stateGroup:delStateLayer(attacker, stateId, delLayer)
end

function CombatUnit:getStateLayer(stateId, attackerId)
	return self.stateGroup:getStateLayer(stateId, attackerId)
end

function CombatUnit:getStateDebuffNum()
	return self.stateGroup:getStateNum(BattleConst.STATE_TYPE_DEBUFF)
end

function CombatUnit:getStateRemainedTime(stateId, attackerId)
	return self.stateGroup:getStateRemainedTime(stateId, attackerId)
end

function CombatUnit:addBattleState(attacker, stateId, level, delayTime)
	local stateData = BattleStateData.getStateData(stateId, level)

	if stateData and stateData.conditionName and stateData.conditionValue then
		if self[stateData.conditionName] ~= stateData.conditionValue then
			return
		end
	elseif stateData and stateData.conditionName and stateData.multiConditionValue then
		local hasEqual = false

		for _, value in ipairs(stateData.multiConditionValue) do
			if self[stateData.conditionName] == value then
				hasEqual = true

				break
			end
		end

		if not hasEqual then
			return
		end
	end

	self.stateGroup:addState(attacker, stateId, level, delayTime)
end

function CombatUnit:deleteBattleState(attacker, stateId)
	if attacker then
		self.stateGroup:delState(attacker.id, stateId)
	end
end

function CombatUnit:hasBattleState(stateId, targetId)
	return self.stateGroup:hasState(stateId, targetId)
end

function CombatUnit:setStateLayer(attacker, stateId, level, delayTime, layer)
	self.stateGroup:forceSetLayer(attacker, stateId, level, delayTime, layer)
end

function CombatUnit:extendBattleState(selectType, selectMode, randomCount, selectIds, extendTime)
	return self.stateGroup:extendStateTime(selectType, selectMode, randomCount, selectIds, extendTime)
end

function CombatUnit:delBattleState(selectType, selectMode, randomCount, selectIds)
	return self.stateGroup:delStates(selectType, selectMode, randomCount, selectIds)
end

function CombatUnit:addPassiveSkill(passiveId, passiveLevel, attackId)
	return self.passiveGroup:addSkill(passiveId, passiveLevel, attackId)
end

function CombatUnit:calcAttrValue(args, layer, attackerId)
	if args[1] == "1" then
		return self:_calcAttrType1(args, layer, attackerId)
	end

	return 0
end

function CombatUnit:_calcAttrType1(args, layer, attackerId)
	local baseValue = tonumber(args[2]) or 0
	local rateValue = tonumber(args[3]) or 0
	local propName = args[4]
	local target = self

	if args[5] == "1" and self.mgr:getObjectByKey(attackerId) then
		target = self.mgr:getObjectByKey(attackerId)
	end

	local value = target[propName] or 0

	return (baseValue + rateValue * value) * (layer or 0)
end

function CombatUnit:isAlive()
	return self.hp > 0
end

function CombatUnit:missEnable()
	if self.preMissFrame and self.frameNumber - self.preMissFrame <= BattleMiscConfig.BATTLE_MISS_CD_FRAME then
		return false
	end

	return true
end

function CombatUnit:isTeammate(target)
	return self.attackCamp == target.camp
end

function CombatUnit:getDamageReduce()
	return self.damageReducePercent or 0
end

function CombatUnit:onAttackChangeMana(changeValue, notShow)
	if changeValue < 0 and self.stateGroup:getProp(BattleConst.STATE_IMMUNE_REDUCE_MANA, 0) > 0 then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.STATE_IMMUNE_REDUCE_MANA
		})

		return 0
	end

	self:onChangeMana(changeValue)
	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED, {
		changeValue,
		false,
		notShow
	})
end

function CombatUnit:onChangeMana(changeValue, autoAdd)
	self.mana = math.max(0, math.min(self.mana + changeValue, MAX_MANA))

	if not autoAdd or self.mana == MAX_MANA then
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SETMANA, {
			self.mana,
			MAX_MANA
		})
	end

	if self.mana == 0 then
		self:raiseSimpleEvent({
			BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO
		})
	end
end

function CombatUnit:canBeHited()
	return self:isAlive()
end

function CombatUnit:clearTarget()
	if self.target then
		self.target:removeFromAttacker(self)
	end

	self:lockTarget()
end

function CombatUnit:lockTarget(target)
	self.target = target

	if target and target ~= self then
		target:beLocked(self)
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_LOCK_TARGET, {
			target.id
		})
	end
end

function CombatUnit:beLocked(attacker)
	for index, obj in ipairs(self.attackers) do
		if obj == attacker then
			return
		end
	end

	table.insert(self.attackers, attacker)
end

function CombatUnit:removeFromAttacker(obj)
	for index, attacker in ipairs(self.attackers) do
		if attacker == obj then
			table.remove(self.attackers, index)
		end
	end
end

function CombatUnit:noticeSkillEnd(attacker, skillId)
	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, {
		BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SKILL,
		attacker,
		skillId
	})
end

function CombatUnit:addOutput(outputType, args)
	self.mgr:addOutput(outputType, self.id, args)
end

CombatUnit.PROP_UPDATE_CONFIG = {}

for propName, affectPropNames in pairs(PropBoard.PROP_RELATIONS) do
	local funcNames = {}
	local needRecord = false

	for index, pName in pairs(affectPropNames) do
		if CombatUnit["update_" .. pName] then
			needRecord = true

			table.insert(funcNames, pName)
		end
	end

	if needRecord then
		CombatUnit.PROP_UPDATE_CONFIG[propName] = funcNames
	end
end

return CombatUnit
