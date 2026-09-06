-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtDisintegrate.lua

module("logic.extensions.battle.model.events.BattleEvtDisintegrate", package.seeall)

local BattleEvtDisintegrate = class("BattleEvtDisintegrate", BattleEvtCharactorAttack)

function BattleEvtDisintegrate:ctor()
	BattleEvtDisintegrate.super.ctor(self)

	self.oneCircleDisintegrateResult = nil
end

function BattleEvtDisintegrate:handleEvt()
	self:_initDisintegration()

	if self._hasInitDisintegration then
		BattleEvtDisintegrate.super.handleEvt(self)
	end
end

function BattleEvtDisintegrate:_initDisintegration()
	if not self._hasInitDisintegration then
		self._hasInitDisintegration = true

		local unit = self:_getDisintegrationCasterUnit()
		local scene = SceneMgr.instance:getCurScene()
		local teamId = self.oneCircleDisintegrateResult.teamId
		local characterViews = self.oneCircleDisintegrateResult.characterViews

		for i = 1, #characterViews do
			local sourceUnit = scene.unitFactory:getUnit(teamId, characterViews[i].id)

			if sourceUnit ~= unit then
				self._skillTargets = self._skillTargets or {}

				table.insert(self._skillTargets, {
					unit = sourceUnit
				})
			end
		end

		unit.oneCircleDisintegrateResult = self.oneCircleDisintegrateResult
	end
end

function BattleEvtDisintegrate:getTransformModelId(characterId, teamId)
	local preTfsModelId, afterTfModelId
	local characterViews = self.oneCircleDisintegrateResult.characterViews
	local triggerCharacterId = self.oneCircleDisintegrateResult.triggerCharacterId

	for i = 1, #characterViews do
		if characterViews[i].id == triggerCharacterId then
			afterTfModelId = characterViews[i].curFaceId

			break
		end
	end

	return preTfsModelId, afterTfModelId
end

function BattleEvtDisintegrate:isDone()
	if not self._hasInitDisintegration then
		return
	end

	return BattleEvtDisintegrate.super.isDone(self)
end

function BattleEvtDisintegrate:handleDisintegrate(oneCircleDisintegrateResult, roundNum)
	self.oneCircleDisintegrateResult = oneCircleDisintegrateResult

	self:_buildRoundCharacterResult(roundNum)
end

function BattleEvtDisintegrate:_buildRoundCharacterResult(roundNum)
	local teamId = self.oneCircleDisintegrateResult.teamId
	local oneRoundCharacterResult = {}
	local skillCo = BattleConfig.instance:getCombinionSkillformulaCo(self.oneCircleDisintegrateResult.combinationSkillId, self.oneCircleDisintegrateResult.formulaId)

	self.oneRoundCharacterResult = oneRoundCharacterResult
	oneRoundCharacterResult.curRound = roundNum
	oneRoundCharacterResult.caster = {}
	oneRoundCharacterResult.caster.targetTeamId = teamId
	oneRoundCharacterResult.caster.targetCharacterId = self.oneCircleDisintegrateResult.triggerCharacterId
	oneRoundCharacterResult.skillCurBatterCount = 1
	oneRoundCharacterResult.skillId = skillCo.disintegrationSkillId
	oneRoundCharacterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
	oneRoundCharacterResult.isOverRoundLimit = false
	oneRoundCharacterResult.targetPlayerResults = GameUtil.emptyTable
	oneRoundCharacterResult.targetCharacterResults = GameUtil.emptyTable
	self.oneRoundCharacterResult = oneRoundCharacterResult
end

function BattleEvtDisintegrate:_getDisintegrationCasterUnit()
	local battleScene = SceneMgr.instance:getCurScene()
	local triggerCharacterId = self.oneCircleDisintegrateResult.triggerCharacterId

	return (battleScene.unitFactory:getUnit(self.oneCircleDisintegrateResult.teamId, triggerCharacterId))
end

function BattleEvtDisintegrate:onPass()
	self:_initDisintegration()

	local unit = self:_getDisintegrationCasterUnit()

	BattleAnimEvevts.onStartDisintegrate(unit)
	BattleEvtDisintegrate.super.onPass(self)
end

function BattleEvtDisintegrate:clear()
	local unit = self:_getDisintegrationCasterUnit()

	unit.oneCircleDisintegrateResult = nil
	self._skillTargets = nil
	self.oneCircleDisintegrateResult = nil

	BattleEvtCombine.super.clear(self)
end

return BattleEvtDisintegrate
