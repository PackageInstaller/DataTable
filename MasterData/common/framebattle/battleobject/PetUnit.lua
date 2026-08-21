-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\PetUnit.lua

local ResPet = require("ClientData/ResPet")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local CombatUnit = require("Common/FrameBattle/BattleObject/CombatUnit")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local AttackCalc = require("Common/FrameBattle/AttackProcess/AttackCalc")
local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local MAX_MANA = 100
local strClassName = "PetUnit"
local PetUnit = Class(strClassName, CombatUnit)

function PetUnit:ctor(id, mgr, frameLength, playerinfo)
	self.coordX = 0
	self.coordY = 0
	self.realCoordX = 0
	self.realCoordY = 0
end

function PetUnit:initCommonData(playerinfo)
	self.petId = playerinfo.petId
	self.battleCommonData = ResPet[playerinfo.petId]
	self.name = self.battleCommonData.name
	self.pet = playerinfo.pet
	self.mainAmulet, self.assistAmulet = self.pet:getBattleFightAmulet()
	self.weaponType = self.mainAmulet.resData.skill_type
	self.skillCardId, self.skillLevel = self.mainAmulet:getMainSkill()

	if ResSkillConfig[self.skillCardId] then
		if ResSkillConfig[self.skillCardId][self.skillLevel] and ResSkillConfig[self.skillCardId][self.skillLevel].skill_ids then
			self.skillId = ResSkillConfig[self.skillCardId][self.skillLevel].skill_ids[1]
		else
			self.skillId = ResSkillConfig[self.skillCardId][1].skill_ids[1]
		end
	else
		self.skillId = self.skillCardId
	end

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

	self.animPauseTime = 0

	if self.battleCommonData.skill_pause_time then
		self.animPauseTime = math.floor(self.battleCommonData.skill_pause_time * self.framePerSec / 30)
	end

	self.playerControl = true
	self.pauseInSkill = true
	self.moveFrame = 0
	self.halfMoveFrame = 0
	self.moveTime = 0
	self.attackDist = 100
	self.isArcher = 1
	self.attackInnerCd = 0
	self.attackEnableFrame = 0
	self.selfHealFrame = 0
	self.passiveCardInfo = {}
	self.passiveCardTriggerFrame = {}
	self.moveEndFrame = 0
	self.moveHalfFrame = 0
	self.skillRecordTargets = {}

	local gemList = self.pet:getBattlePetGem()
	local libs = {}

	for _, gem in ipairs(gemList or {}) do
		local mainAttr = gem:getMainAttr() or {}

		table.insert(libs, mainAttr.attr_id)

		local subAttrs = gem:getSubAttr()

		for _, subAttr in ipairs(subAttrs or {}) do
			table.insert(libs, subAttr.attr_id)
		end
	end

	for _, libId in ipairs(libs) do
		local attrData = ResPetGemAttrLibrary[libId]

		if attrData and attrData.status then
			self.mgr:_addCampEffect(self.camp, {
				state_level = 1,
				state_id = attrData.status
			})
		elseif attrData and attrData.event_id and attrData.event_id[1] then
			self.mgr:_addCampEffect(self.camp, {
				event_id = attrData.event_id
			})
		end
	end
end

function PetUnit:initConfig()
	self.mana = self.mainAmulet.resData.init_mana

	self:_update_mana_frame()
end

function PetUnit:initInEnterBattle()
	if self.assistAmulet then
		local passiveSkillId, passiveSkillLevel = self.assistAmulet:getAssistSkill()

		if passiveSkillId then
			self:addPassiveSkill(passiveSkillId, passiveSkillLevel, self.id)
		end
	end
end

function PetUnit:checkHeroSkill()
	if self:_checkManaFullSkill() and self.pauseInSkill then
		self.mgr.frameSkillEntity = self
		self.mgr.frameSkillPause = self.pauseInSkill and self.skillPauseTime and self.skillPauseTime > 0
		self.mgr.predictSkillEntity = self
	end
end

function PetUnit:_useSkill(skillId, skillLevel, skillData)
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

	local useSkillArgs = {}

	useSkillArgs.delayFrame = self.animPauseTime

	self.behaviorFSM:useSkill(self.usingSkill, useSkillArgs)
	self:initSkillVideoData(skillData)

	if self.pauseInSkill and self.skillPauseTime and self.skillPauseTime > 0 then
		local targets, base = AttackCalc.getSkillTargets(self.mgr, self, self.target.id, self.skillCardId, self.nowSkillLevel, self.skillAreaEvent)

		self.mgr:onSkillActTime(self, self.animPauseTime + self.skillPauseTime + self.videoPauseFrame, targets, self.skillAreaTime, self.skillCardId, skillData.hideEffect == 1)
	end

	self.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD, {
		self.skillCardId,
		self.target.id,
		self.attackType
	})

	self.manaFullSkillNum = self.manaFullSkillNum + 1
	self.recordSkillHitNum = 0
end

function PetUnit:usingManaFullSkill()
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

function PetUnit:nextFrame(frameNumber, noAction)
	self.frameNumber = frameNumber

	if frameNumber == 1 then
		self:initInEnterBattle()
	end

	if frameNumber < BattleConst.MATRIX_ENTITY_PREPARE_FRAME then
		return
	end

	local inSkill = self.frameNumber < self.resumePauseFrame

	if inSkill then
		if not self.skillSelf then
			return
		end
	elseif self.frameNumber == self.resumePauseFrame then
		self.behaviorFSM:cancelPauseBH()
		self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL, {
			self.skillSelf
		})
	end

	if self.mgr.frameSkillEntity and self.mgr.frameSkillEntity ~= self and self.mgr.frameSkillPause then
		return
	end

	if self.isOver then
		self:_tickQuests(frameNumber)

		if next(self.tickQuestDict) == nil then
			self.mgr:onPetOver(self)
		end
	elseif inSkill and self.skillSelf then
		self:_tickQuests(frameNumber, true)
	else
		if not noAction and self:isAlive() then
			self:_checkFrameAction()

			if self.mana_frame > 0 and self.mana < 100 then
				self:onChangeMana(self.mana_frame, true)
			elseif self.mana_frame < 0 and self.mana > 0 then
				self:onChangeMana(self.mana_frame, true)
			end
		end

		self:_tickQuests(frameNumber)
		self.stateGroup:nextFrame()
	end
end

function PetUnit:_checkFrameAction()
	if not self.behaviorFSM:canUseSkill() then
		return
	end

	if self:usingManaFullSkill() then
		return
	end
end

function PetUnit:processSkillAtkEvent(skillEventInfo)
	local eventId = skillEventInfo[4] or 0

	self:triggerSkillEvent(self.usingSkill, eventId, self.target.id, self.nowCardId, self.nowSkillLevel)
end

function PetUnit:_tickQuests(frameNumber, skillTick)
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

function PetUnit:_skillRealEnd(nextSkill)
	local preSkill = self.usingSkill

	self.usingSkill = nil

	if not nextSkill then
		if self.attackType ~= BattleConst.ATTACK_CA then
			self:clearTarget()
		else
			self:confirmTarget()
		end
	end

	self.isOver = true

	self:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SKILL_END, {})
end

function PetUnit:canBeHited()
	return false
end

function PetUnit:onKillSomeOne(victim)
	return
end

return PetUnit
