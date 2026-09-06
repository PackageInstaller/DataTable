-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleAwakeChangeSkillModel.lua

module("logic.extensions.battle.model.BattleAwakeChangeSkillModel", package.seeall)

local BattleAwakeChangeSkillModel = class("BattleAwakeChangeSkillModel", BaseListModel)

function BattleAwakeChangeSkillModel:onReset()
	BattleAwakeChangeSkillModel.super.onReset(self)

	self._awakeChangeSkillMap = nil
end

function BattleAwakeChangeSkillModel:onBattleStart(battleData)
	self._awakeChangeSkillMap = nil

	local originalStates = battleData.originalStates

	for i = 1, #originalStates.teams do
		local team = originalStates.teams[i]

		if team.playerView and team.playerView.characterViews then
			local characterViews = team.playerView.characterViews

			self:_initAwakeChangeSkillInfo(team.teamId, characterViews)
		end
	end
end

function BattleAwakeChangeSkillModel:_initAwakeChangeSkillInfo(teamId, characterViews)
	self._awakeChangeSkillMap = self._awakeChangeSkillMap or {}

	if not self._awakeChangeSkillMap[teamId] then
		local map = {}

		for i, v in ipairs(characterViews) do
			if v.awakenSkillId > 0 then
				local cfg = BattleConfig.instance:getAwakenSkillConfig(v.awakenSkillId) or {}
				local id = v.id

				if not map[id] then
					map[id].awakenSkillId = v.awakenSkillId
					map[id].awakenSkillProcess = v.awakenSkillProcess
					map[id].awakenSkillHadTriggerTimes = v.awakenSkillHadTriggerTimes
					map[id].isAwakening = false
					map[id].progressLimit = checknumber(cfg.progressLimit)
					map[id].maxTriggerCount = checknumber(cfg.maxTriggerCount)
					map[id] = map[id]
					self._awakeChangeSkillMap[teamId] = map
				end
			end
		end
	end
end

function BattleAwakeChangeSkillModel:updateAwakeChnageSkillInfo(teamId, characterId, changeValue, awakenSkillHadTriggerTimes, isAwakening)
	local infoMO = self:getsetAwakeChangeSkillInfoInfo(teamId, characterId)

	if infoMO then
		infoMO.awakenSkillProcess = checknumber(infoMO.awakenSkillProcess) + changeValue
		infoMO.awakenSkillProcess = math.min(infoMO.awakenSkillProcess, infoMO.progressLimit)
		infoMO.awakenSkillHadTriggerTimes = awakenSkillHadTriggerTimes
		infoMO.isAwakening = isAwakening

		if not self._awakeChangeSkillMap[teamId] then
			self._awakeChangeSkillMap[teamId][characterId] = infoMO
			self._awakeChangeSkillMap[teamId] = self._awakeChangeSkillMap[teamId]
		end
	end
end

function BattleAwakeChangeSkillModel:getAwakenSkillStatus(teamId, characterId)
	local active, cur, total, isAwakening = false, 0, 0, false
	local infoMO = self:getsetAwakeChangeSkillInfoInfo(teamId, characterId)

	if infoMO and infoMO.awakenSkillHadTriggerTimes < infoMO.maxTriggerCount then
		active = true
		cur = infoMO.awakenSkillProcess
		total = infoMO.progressLimit
		isAwakening = infoMO.isAwakening
	end

	return active, cur, total, isAwakening
end

function BattleAwakeChangeSkillModel:getsetAwakeChangeSkillInfoInfo(teamId, characterId)
	if self._awakeChangeSkillMap and self._awakeChangeSkillMap[teamId] then
		return self._awakeChangeSkillMap[teamId][characterId]
	end

	return nil
end

BattleAwakeChangeSkillModel.instance = BattleAwakeChangeSkillModel.New()

return BattleAwakeChangeSkillModel
