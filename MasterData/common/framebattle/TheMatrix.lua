-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\TheMatrix.lua

local MatrixRandom = require("Common/FrameBattle/Lib/Random")
local CombatUnitMgr = require("Common/FrameBattle/BattleObject/CombatUnitManager")
local BehaviorManager = require("Common/FrameBattle/Behavior/BehaviorManager")
local BattleConst = require("Common/FrameBattle/BattleConst")
local MatrixOp = require("Common/FrameBattle/Lib/MatrixOp")
local AttackCalc = require("Common/FrameBattle/AttackProcess/AttackCalc")
local StateGroup = require("Common/FrameBattle/BattleObject/StateGroup")
local strClassName = "TheMatrix"
local TheMatrix = Class(strClassName)

function TheMatrix:ctor(initInfo, loggingToFile)
	self.curFrame = 0
	self.loggingToFile = loggingToFile

	self:clearEnv()

	self.frameLength = 50
	self.frameOutput = {}
	self.frameInput = {}
	self.randomSeed = initInfo.randomSeed
	self.randGenerator = MatrixRandom:twister(self.randomSeed)
	self.bhMgr = BehaviorManager()
	self.bObjMgr = CombatUnitMgr(self, initInfo)
	self.battleOver = false
	self.manualOpera = initInfo.manualOpera

	self:initInputEventHandler()
end

function TheMatrix:clearEnv()
	AttackCalc.FakeProbInfo = {}
	AttackCalc.FakeCritInfo = {}
	StateGroup.CARD_TYPE_CACHE = {}
	StateGroup.SKILL_TYPE_CACHE = {}
end

function TheMatrix:destroy()
	if self.bObjMgr then
		self.bObjMgr:destroy()

		self.bObjMgr = nil
	end

	if self.bhMgr then
		self.bhMgr:destroy()

		self.bhMgr = nil
	end

	self.randGenerator = nil
	self.frameOutput = nil
end

function TheMatrix:receiveInputInfo(inputType, packArgs, frameNum)
	if not self.frameInput[frameNum] then
		self.frameInput[frameNum] = {}
	end

	table.insert(self.frameInput[frameNum], {
		inputType,
		packArgs
	})
end

function TheMatrix:initInputEventHandler()
	self.inputEventHandler = {
		[BattleConst.INPUT_EVENT_USE_SKILL] = {
			Slot(self.processInputSkillEvent, self)
		},
		[BattleConst.INPUT_EVENT_SET_AUTO] = {
			Slot(self.processInputSetAuto, self)
		},
		[BattleConst.INPUT_EVENT_SET_SHORT] = {
			Slot(self.processInputSetShort, self)
		}
	}
end

function TheMatrix:processInputSkillEvent(opSkillData)
	local objectKey = opSkillData[1]
	local object = self:getObjectByKey(objectKey)

	if object then
		object:manualClickSkill()
	else
		for _, pet in ipairs(self.bObjMgr.activePets) do
			if pet.id == objectKey then
				pet:manualClickSkill()

				break
			end
		end
	end
end

function TheMatrix:processInputSetAuto(opSkillData)
	local manual = opSkillData[1]

	if manual > 0 then
		self.manualOpera = true
	else
		self.manualOpera = false
	end
end

function TheMatrix:processInputSetShort(opSkillData)
	local short = opSkillData[1]

	if short > 0 then
		self.shortOpera = true
	else
		self.shortOpera = false
	end
end

function TheMatrix:nextFrame()
	for index = #self.frameOutput, 1, -1 do
		self.frameOutput[index] = nil
	end

	if self.battleOver then
		return
	end

	self.curFrame = self.curFrame + 1

	self.bhMgr:tick()
	self.bObjMgr:nextFrame(self.curFrame)
	self:_processEvent()
end

function TheMatrix:_processEvent()
	local input = self.frameInput[self.curFrame]

	if input then
		for _, eventData in ipairs(input) do
			local eventType = eventData[1]
			local func = self.inputEventHandler[eventType][1]

			if func then
				func(MatrixOp.unpackMatrixOp(eventType, eventData[2]))
			end
		end
	end
end

function TheMatrix:addOutput(outputType, filter, args)
	table.insert(self.frameOutput, {
		outputType,
		filter,
		args
	})
end

function TheMatrix:logToLogger(eventType, filter, args, isOut)
	return
end

function TheMatrix:getFrameOutput()
	return self.frameOutput
end

function TheMatrix:getObjectByKey(objectKey)
	return self.bObjMgr:getObjectByKey(objectKey)
end

function TheMatrix:objectExist(objectKey)
	if self.bObjMgr:getObjectByKey(objectKey) then
		return true
	else
		return false
	end
end

function TheMatrix:onBattleResult(lastDeadCamp)
	if not self.battleOver then
		self.battleRealPassedFrame = self.curFrame
		self.lastDeadCamp = lastDeadCamp

		self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_OVER, nil, {
			lastDeadCamp
		})

		if lastDeadCamp == BattleConst.CAMP_PLAYER then
			self.battleOver = BattleConst.BATTLE_OVER_LOSE
		else
			self.battleOver = BattleConst.BATTLE_OVER_WIN
		end

		self.battleOverFrame = self.bObjMgr.maxFrame - self.bObjMgr.curCountFrame
	end
end

function TheMatrix:onTimeOut()
	if not self.battleOver then
		self:addOutput(BattleConst.MATRIX_EVENT_BATTLE_OVER, nil, {
			[2] = BattleConst.BATTLE_RESULT_TIME_OUT
		})

		self.battleOver = BattleConst.BATTLE_OVER_TIME_OUT
		self.battleOverFrame = self.bObjMgr.maxFrame - self.bObjMgr.curCountFrame
	end
end

return TheMatrix
