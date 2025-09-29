-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/component/DungeonFlowCompWinCondition.lua

module("logic.extensions.dungeon.battleflow.component.DungeonFlowCompWinCondition", package.seeall)

local DungeonFlowCompWinCondition = class("DungeonFlowCompWinCondition", IBattleFlowComp, AbstractGlobalReusable)

function DungeonFlowCompWinCondition:onInit()
	self._additionalWinConditionTags = {}
	self._additionalLoseConditionTags = {}
	self._winConditionDescription = false
	self._loseConditionDescription = false
	self._extraWinConditionDescription = false
end

function DungeonFlowCompWinCondition:onStart()
	local levelCode = self.flow:getBattleLevelCode()
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(levelCode)

	BattleTableUtil.insertto(self._additionalWinConditionTags, dungeonBattleInfoCOWrapper:getDefaultWinTags())
	BattleTableUtil.insertto(self._additionalLoseConditionTags, dungeonBattleInfoCOWrapper:getDefaultLoseTags())
	self:_processConditionTagChanged()
end

function DungeonFlowCompWinCondition:onClear()
	BattleTableUtil.clearTable(self._additionalWinConditionTags)
	BattleTableUtil.clearTable(self._additionalLoseConditionTags)
end

function DungeonFlowCompWinCondition:addExtraWinConditionDesc(desc)
	self._extraWinConditionDescription = desc

	self:_processConditionTagChanged()
	BattleDispatcher:dispatchEvent(BattleEventType.OnCondtionsChanged)
end

function DungeonFlowCompWinCondition:addWinConditionTags(tags)
	if self:_checkTags(tags) then
		BattleTableUtil.insertto(self._additionalWinConditionTags, tags)
		self:_processConditionTagChanged()
	end
end

function DungeonFlowCompWinCondition:removeWinConditionTags(tags)
	if self:_checkTags(tags) then
		for _, tag in pairs(tags) do
			table.removebyvalue(self._additionalWinConditionTags, tag)
		end

		self:_processConditionTagChanged()
	end
end

function DungeonFlowCompWinCondition:addLoseConditionTags(tags)
	if self:_checkTags(tags) then
		BattleTableUtil.insertto(self._additionalLoseConditionTags, tags)
		self:_processConditionTagChanged()
	end
end

function DungeonFlowCompWinCondition:removeLoseConditionTags(tags)
	if self:_checkTags(tags) then
		for _, tag in pairs(tags) do
			table.removebyvalue(self._additionalLoseConditionTags, tag)
		end

		self:_processConditionTagChanged()
	end
end

function DungeonFlowCompWinCondition:getAdditionalWinConditionTags()
	return self._additionalWinConditionTags
end

function DungeonFlowCompWinCondition:getAdditionalLoseConditionTags()
	return self._additionalLoseConditionTags
end

function DungeonFlowCompWinCondition:getWinConditionDescription()
	return self._winConditionDescription
end

function DungeonFlowCompWinCondition:getLoseConditionDescription()
	return self._loseConditionDescription
end

function DungeonFlowCompWinCondition:_checkTags(tags)
	return tags and #tags > 0
end

function DungeonFlowCompWinCondition:_processConditionTagChanged()
	local levelCode = self.flow:getBattleLevelCode()
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(levelCode)

	self._winConditionDescription = dungeonBattleInfoCOWrapper:getWinConditionDescription(self._additionalWinConditionTags)
	self._loseConditionDescription = dungeonBattleInfoCOWrapper:getLoseConditionDescription(self._additionalLoseConditionTags)

	if self._extraWinConditionDescription then
		self._winConditionDescription = string.format("%s<color=#FFFFFF>或</color>%s", self._winConditionDescription, self._extraWinConditionDescription)
	end
end

function DungeonFlowCompWinCondition:getExtraWinConditionDesc()
	return self._extraWinConditionDescription
end

return DungeonFlowCompWinCondition
