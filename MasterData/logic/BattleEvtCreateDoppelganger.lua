-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtCreateDoppelganger.lua

module("logic.extensions.battle.model.events.BattleEvtCreateDoppelganger", package.seeall)

local BattleEvtCreateDoppelganger = class("BattleEvtCreateDoppelganger", BattleEvtCharactorAttack)

function BattleEvtCreateDoppelganger:ctor()
	BattleEvtCreateDoppelganger.super.ctor(self)
end

function BattleEvtCreateDoppelganger:handleEvt()
	self:addDoppelgangerSkill()
	BattleEvtCreateDoppelganger.super.handleEvt(self)
end

function BattleEvtCreateDoppelganger:addDoppelgangerSkill()
	if self.oneCircleBeforeCreateDoppelgangerResult and self.singleCreateDoppelgangerResult then
		local teamId = self.oneCircleBeforeCreateDoppelgangerResult.teamId
		local doppelgangerSkillId = self.oneCircleBeforeCreateDoppelgangerResult.doppelgangerSkillId
		local id = self.singleCreateDoppelgangerResult.doppelgangerMasterCharacterId
		local battleScene = SceneMgr.instance:getCurScene()
		local unit = battleScene.unitFactory:getUnit(teamId, id)

		if unit then
			unit.skillList.doppelgangerSkillId = doppelgangerSkillId

			unit.skillList:addSkill(doppelgangerSkillId)
		end
	end
end

function BattleEvtCreateDoppelganger:handleCreateDoppelganger(oneCircleBeforeCreateDoppelgangerResult, singleCreateDoppelgangerResult, roundNum)
	self.oneCircleBeforeCreateDoppelgangerResult = oneCircleBeforeCreateDoppelgangerResult
	self.singleCreateDoppelgangerResult = singleCreateDoppelgangerResult

	self:_buildRoundCharacterResult(roundNum)
end

function BattleEvtCreateDoppelganger:_buildRoundCharacterResult(roundNum)
	local teamId = self.oneCircleBeforeCreateDoppelgangerResult.teamId
	local oneRoundCharacterResult = {}

	oneRoundCharacterResult.curRound = roundNum
	oneRoundCharacterResult.caster = {}
	oneRoundCharacterResult.caster.targetTeamId = teamId
	oneRoundCharacterResult.caster.targetCharacterId = self.singleCreateDoppelgangerResult.doppelgangerMasterCharacterId
	oneRoundCharacterResult.skillCurBatterCount = 1
	oneRoundCharacterResult.skillId = self.oneCircleBeforeCreateDoppelgangerResult.doppelgangerSkillId
	oneRoundCharacterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
	oneRoundCharacterResult.isOverRoundLimit = false
	oneRoundCharacterResult.targetPlayerResults = GameUtil.emptyTable
	oneRoundCharacterResult.targetCharacterResults = {}

	for i = 1, #self.oneCircleBeforeCreateDoppelgangerResult.targetCharacterResults do
		table.insert(oneRoundCharacterResult.targetCharacterResults, self.oneCircleBeforeCreateDoppelgangerResult.targetCharacterResults[i])
	end

	for i, dop in ipairs(self.singleCreateDoppelgangerResult.doppelgangerView) do
		local charactorResult = {}

		charactorResult.target = {
			targetTeamId = teamId,
			targetCharacterId = dop.id
		}
		charactorResult.isHit = true
		charactorResult.isSkillEffected = true

		local targetNum = {}

		for i, tar in ipairs(self.oneCircleBeforeCreateDoppelgangerResult.targetPlayerResults) do
			if tar.target.targetPlayerId == dop.id then
				targetNum = tar.targetNum

				break
			end
		end

		charactorResult.targetNum = targetNum

		table.insert(oneRoundCharacterResult.targetCharacterResults, charactorResult)
	end

	self.oneRoundCharacterResult = oneRoundCharacterResult
end

return BattleEvtCreateDoppelganger
