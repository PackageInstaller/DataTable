-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtCombine.lua

module("logic.extensions.battle.model.events.BattleEvtCombine", package.seeall)

local BattleEvtCombine = class("BattleEvtCombine", BattleEvtCharactorAttack)

function BattleEvtCombine:ctor()
	BattleEvtCombine.super.ctor(self)

	self.oneCircleCombineResult = nil
end

function BattleEvtCombine:handleEvt()
	if not self._hasBuildCombineUnit then
		self._hasBuildCombineUnit = true

		self:_startLoadCombineModel()
	end

	if self._combineModelLoaded then
		BattleEvtCombine.super.handleEvt(self)
	end
end

function BattleEvtCombine:isDone()
	if not self._combineModelLoaded then
		return
	end

	return BattleEvtCombine.super.isDone(self)
end

function BattleEvtCombine:handleCombine(oneCircleCombineResult, roundNum)
	self.oneCircleCombineResult = oneCircleCombineResult

	self:_buildRoundCharacterResult(roundNum)
end

function BattleEvtCombine:_buildRoundCharacterResult(roundNum)
	local charactorView = self.oneCircleCombineResult.characterView
	local oneRoundCharacterResult = {}

	self.oneRoundCharacterResult = oneRoundCharacterResult
	oneRoundCharacterResult.curRound = roundNum
	oneRoundCharacterResult.caster = {}
	oneRoundCharacterResult.caster.targetTeamId = self.oneCircleCombineResult.teamId
	oneRoundCharacterResult.caster.targetCharacterId = charactorView.id
	oneRoundCharacterResult.skillCurBatterCount = 1
	oneRoundCharacterResult.skillId = self.oneCircleCombineResult.combinationSkillId
	oneRoundCharacterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
	oneRoundCharacterResult.isOverRoundLimit = false
	oneRoundCharacterResult.targetPlayerResults = GameUtil.emptyTable
	oneRoundCharacterResult.targetCharacterResults = GameUtil.emptyTable
	self.oneRoundCharacterResult = oneRoundCharacterResult
end

function BattleEvtCombine:getTransformModelId(characterId, teamId)
	local preTfsModelId, afterTfModelId
	local charactorView = self.oneCircleCombineResult.characterView

	return preTfsModelId, charactorView.curFaceId
end

function BattleEvtCombine:_startLoadCombineModel()
	self:_prepareCombineUnits()

	local charactorView = self.oneCircleCombineResult.characterView
	local modelCo = CharacterConfig.instance:getModelCo(charactorView.curFaceId)

	if modelCo == nil then
		modelCo = CharacterConfig.instance:getModelCo(charactorView.raceId)
	end

	local url = GameUrl.getSpineUrl(modelCo.resName, modelCo.battleResName)

	getres(url, self._onCombineModelLoaded, self, ResType.AssetBunble, true)
end

function BattleEvtCombine:_prepareCombineUnits()
	if self._hasPrepareCombineUnits then
		return
	end

	self._hasPrepareCombineUnits = true

	local unit = self:_getCombineCasterUnit()

	if unit then
		local scene = SceneMgr.instance:getCurScene()
		local sourcePetIds = self.oneCircleCombineResult.sourcePetIds
		local teamId = self.oneCircleCombineResult.teamId

		for i = 1, #sourcePetIds do
			if sourcePetIds[i] ~= unit.id then
				local sourceUnit = scene.unitFactory:getUnit(teamId, sourcePetIds[i])

				self._skillTargets = self._skillTargets or {}

				sourceUnit.attrs:setCombinedSource(true)
				table.insert(self._skillTargets, {
					unit = sourceUnit
				})
			end
		end

		unit.oneCircleCombineResult = self.oneCircleCombineResult
	end
end

function BattleEvtCombine:_getCombineCasterUnit()
	local battleScene = SceneMgr.instance:getCurScene()
	local charactorView = self.oneCircleCombineResult.characterView

	return (battleScene.unitFactory:getUnit(self.oneCircleCombineResult.teamId, charactorView.id))
end

function BattleEvtCombine:_unLoadCombineModel()
	if self._combineModelRes then
		self._combineModelRes:Release()

		self._combineModelRes = nil
	end

	self._hasBuildCombineUnit = nil
	self._combineModelLoaded = nil
end

function BattleEvtCombine:_onCombineModelLoaded(res)
	self._combineModelRes = res

	res:Retain()

	self._combineModelLoaded = true
end

function BattleEvtCombine:onPass()
	self:_prepareCombineUnits()

	local unit = self:_getCombineCasterUnit()

	BattleAnimEvevts.onStartCombine(unit)
	BattleEvtCombine.super.onPass(self)
end

function BattleEvtCombine:clear()
	local unit = self:_getCombineCasterUnit()

	unit.oneCircleCombineResult = nil
	self._skillTargets = nil

	self:_unLoadCombineModel()

	self.oneCircleCombineResult = nil

	BattleEvtCombine.super.clear(self)
end

return BattleEvtCombine
