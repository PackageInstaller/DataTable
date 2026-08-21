-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Behavior\\CombatFSM.lua

local Behavior = require("Common/FrameBattle/Behavior/Behavior")
local BattleConst = require("Common/FrameBattle/BattleConst")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local Class = Class
local Functor = Functor
local BaseState = Class("BaseState")

function BaseState:ctor(fsm, stateFlag)
	self.fsm = fsm
	self.Behavior = fsm.Behavior
	self.flag = stateFlag
	self.duration = -1
end

function BaseState:enter(duration)
	if duration then
		self.duration = duration
	end

	self.Behavior:changeState(self.flag, self.duration)
end

function BaseState:exit()
	return
end

function BaseState:canUseSkill()
	return false
end

local IdleState = Class("IdleState", BaseState)

function IdleState:ctor()
	return
end

function IdleState:canUseSkill()
	return true
end

local WaitState = Class("WaitState", BaseState)

function WaitState:ctor()
	return
end

function WaitState:canUseSkill()
	return true
end

local AtkState = Class("AtkState", BaseState)

function AtkState:ctor()
	self.mCurSkillID = -1
end

function AtkState:enter(skillInfo)
	local skillData = skillInfo[1]
	local useSkillArgs = skillInfo[2]

	self.mCurSkillID = skillData.id

	local condition = skillData.bhEvent

	self.Behavior:useSkill(condition, useSkillArgs)

	self.inSupercancel = false
end

function AtkState:enterSupercancel()
	self.inSupercancel = true
end

function AtkState:canUseSkill()
	if self.inSupercancel then
		return true
	end

	return false
end

function AtkState:exit()
	self.mCurSkillID = -1
end

local HitedState = Class("HitedState", BaseState)

function HitedState:ctor()
	return
end

function HitedState:enter(hitedInfo)
	local duration = hitedInfo[1]

	self.hitedAnim = hitedInfo[2]
	self.hitedFlag = hitedInfo[3]

	if duration then
		self.duration = duration
	end

	self.Behavior:changeState(self.flag, self.duration, nil, self.hitedAnim)
	self.fsm.mEntity:enterEntityHited(self.hitedFlag)
end

function HitedState:exit()
	self.fsm.mEntity:exitEntityHited(self.hitedFlag)
end

local DeathState = Class("DeathState", BaseState)

function DeathState:ctor()
	return
end

local strClassName = "CombatFSM"
local CombatFSM = Class(strClassName)

function CombatFSM:ctor(entity, frameLength, bhMgr)
	self.mEntity = entity

	local bhVariables = {
		frameLength = frameLength
	}

	self.Behavior = Behavior(entity, bhVariables, bhMgr)
	self.mAllStates = {}

	self:_initStates()

	self.mCurCombatState = nil

	self:setState(BattleConst.COMBAT_STATE_IDLE)
	self:_registerEvent()
end

function CombatFSM:destroy()
	self.Behavior:destroy()

	self.mEntity = nil
	self.mAllStates = nil
	self.Behavior = nil
end

function CombatFSM:_initStates()
	self.mAllStates[BattleConst.COMBAT_STATE_IDLE] = IdleState(self, BattleConst.COMBAT_STATE_IDLE)
	self.mAllStates[BattleConst.COMBAT_STATE_ATK] = AtkState(self, BattleConst.COMBAT_STATE_ATK)
	self.mAllStates[BattleConst.COMBAT_STATE_HITED] = HitedState(self, BattleConst.COMBAT_STATE_HITED)
	self.mAllStates[BattleConst.COMBAT_STATE_DEATH] = DeathState(self, BattleConst.COMBAT_STATE_DEATH)
	self.mAllStates[BattleConst.COMBAT_STATE_WAIT] = WaitState(self, BattleConst.COMBAT_STATE_WAIT)
end

function CombatFSM:_getCurState()
	return self.mCurCombatState
end

function CombatFSM:_getCurStateFlag()
	return self.mCurCombatState.flag
end

function CombatFSM:_isInState(stateFlag)
	if stateFlag == self:_getCurStateFlag() then
		return true
	else
		return false
	end
end

function CombatFSM:setState(nextStateName, argTable)
	if self.mAllStates[nextStateName] then
		if self.mCurCombatState then
			self.mCurCombatState:exit()
		end

		self.mCurCombatState = self.mAllStates[nextStateName]

		self.mCurCombatState:enter(argTable)
	end
end

function CombatFSM:canUseSkill()
	return self.mCurCombatState:canUseSkill()
end

function CombatFSM:predictCanUseSkill(predictFrameNum)
	if self.mCurCombatState:canUseSkill() then
		return true
	end

	if self:_isInState(BattleConst.COMBAT_STATE_ATK) then
		local behaviorState = self.Behavior.mCurrentState

		if behaviorState and behaviorState.mStateCurrentFrame and behaviorState.nextSkillEnableFrame then
			return predictFrameNum + behaviorState.mStateCurrentFrame >= behaviorState.nextSkillEnableFrame
		end
	end

	return false
end

function CombatFSM:useSkill(skillID, useSkillArgs)
	local skillData = SkillDataBank.getSkillData(self.mEntity.weaponType, skillID)

	if skillData then
		self:setState(BattleConst.COMBAT_STATE_ATK, {
			skillData,
			useSkillArgs
		})
	end
end

function CombatFSM:beHited(duration, hitedAnim, hitedFlag)
	self:setState(BattleConst.COMBAT_STATE_HITED, {
		duration,
		hitedAnim,
		hitedFlag
	})
end

function CombatFSM:onDead()
	self:setState(BattleConst.COMBAT_STATE_DEATH)
end

function CombatFSM:toIdle()
	self:setState(BattleConst.COMBAT_STATE_IDLE)
end

function CombatFSM:registerEvent(eventName, func)
	self.Behavior:addEventHandler(eventName, func)
end

function CombatFSM:_registerEvent()
	local func = Functor(self.onToIdle, self)

	self.Behavior:addEventHandler(BattleConst.BEHAVIOR_END, func)

	func = Functor(self.onSuperCancel, self)

	self.Behavior:addEventHandler(BattleConst.BEHAVIOR_EVENT_SUPERCANCEL, func)
end

function CombatFSM:onToIdle()
	self:setState(BattleConst.COMBAT_STATE_IDLE)
end

function CombatFSM:onToWait()
	if not self:_isInState(BattleConst.COMBAT_STATE_WAIT) then
		self:setState(BattleConst.COMBAT_STATE_WAIT)
	end
end

function CombatFSM:onSuperCancel(eventInfo)
	if self:_isInState(BattleConst.COMBAT_STATE_ATK) then
		local stateAtk = self:_getCurState()

		stateAtk:enterSupercancel()
	end
end

function CombatFSM:onToDead()
	self:setState(BattleConst.COMBAT_STATE_DEATH)
end

function CombatFSM:pauseBH()
	self.Behavior:pauseBH()
	self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH, {})
end

function CombatFSM:cancelPauseBH()
	self.Behavior:cancelPauseBH()
	self.mEntity:addOutput(BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH, {})
end

return CombatFSM
