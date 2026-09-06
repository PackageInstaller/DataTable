-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleTaskCaculator.lua

module("logic.extensions.battle.model.BattleTaskCaculator", package.seeall)

local BattleTaskCaculator = class("BattleTaskCaculator")

BattleTaskCaculator.MyPetAttrType = "MyPetAttrType"
BattleTaskCaculator.MyAttackCount = "MyAttackCount"
BattleTaskCaculator.MyCriticalCount = "MyCriticalCount"
BattleTaskCaculator.MyInitPos = "MyInitPos"
BattleTaskCaculator.MyActiveRoundCount = "MyActiveRoundCount"
BattleTaskCaculator.MyUltCount = "MyUltCount"

function BattleTaskCaculator:ctor()
	self:clear()
end

function BattleTaskCaculator:initData(taskIds)
	self._taskTypeMap = {}

	if taskIds and #taskIds > 0 then
		for _, taskId in ipairs(taskIds) do
			local taskConf = BattleSettlementConfig.instance:getBattleTaskCfgById(taskId)

			if taskConf then
				self._taskTypeMap[taskConf.type] = taskConf
			end
		end
	end

	self:_updateInitConditions()
end

function BattleTaskCaculator:hasTaskType(taskType)
	return self._taskTypeMap[taskType]
end

function BattleTaskCaculator:getTaskTypeMap()
	return self._taskTypeMap
end

function BattleTaskCaculator:_updateInitConditions()
	if self:hasTaskType(BattleTaskCaculator.MyPetAttrType) or self:hasTaskType(BattleTaskCaculator.MyInitPos) then
		local scene = SceneMgr.instance:getCurScene()
		local unitFactory = scene.unitFactory
		local myUnits = {}

		if scene then
			local leftTeamId = BattleModel.instance:getLeftTeamId()

			myUnits = unitFactory:getBttleUnits(leftTeamId) or {}
		end

		if self:hasTaskType(BattleTaskCaculator.MyPetAttrType) then
			local raceTypeMap = {}

			for _, v in ipairs(myUnits) do
				local race = PetSkinConfig.instance:getFisrtEleAttrIdx((v.modelId > 0 or nil) and v.modelId)

				raceTypeMap[race] = true
			end

			self._myPetAttrType = table.nums(raceTypeMap)
		end

		if self:hasTaskType(BattleTaskCaculator.MyInitPos) then
			for _, v in ipairs(myUnits) do
				self._myInitPos[v.fmtIndex] = true
			end
		end
	end
end

function BattleTaskCaculator:clear()
	self._myPetAttrType = 0
	self._myInitPos = {}
	self._myAttackCount = 0
	self._myCriticalCount = 0
	self._myActiveRoundCount = 0
	self._myUltCount = 0
end

function BattleTaskCaculator:setRound(value)
	self._myActiveRoundCount = value
end

function BattleTaskCaculator:increaseMyAttackCount()
	self._myAttackCount = self._myAttackCount + 1
end

function BattleTaskCaculator:increaseMyCriticalCount()
	self._myCriticalCount = self._myCriticalCount + 1
end

function BattleTaskCaculator:increaseMyUltCount()
	self._myUltCount = self._myUltCount + 1
end

function BattleTaskCaculator:getValueByString(key)
	return self[key] or 0
end

return BattleTaskCaculator
