-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundBase.lua

module("logic.extensions.battle.model.round.BattleRoundBase", package.seeall)

local BattleRoundBase = class("BattleRoundBase")

BattleRoundBase.RoundBefore = 1
BattleRoundBase.Round = 2
BattleRoundBase.RoundAfter = 3
BattleRoundBase.End = 4
BattleRoundBase.RoundBegin = 5
BattleRoundBase.RoundContinue = 6
BattleRoundBase.RoundUseItem = 7
BattleRoundBase.RoundPlayStory = 8
BattleRoundBase.RoundError = 9
BattleRoundBase.RoundBirth = 10
BattleRoundBase.RoundPetIntrod = 11
BattleRoundBase.RoundBattleStart = 12

function BattleRoundBase:ctor()
	self.roundNum = 0
	self._evts = nil
	self.isRunning = nil
	self._currEvt = nil
end

function BattleRoundBase:start()
	self.isRunning = true
end

function BattleRoundBase:update(deltaTime)
	self._currEvt = self._currEvt or self:popEvent()

	if self._currEvt and not self._currEvt.isPause then
		if not self._currEvt.isToggled then
			self._currEvt:handleEvt()
		end

		if self._currEvt.isToggled then
			if self._currEvt.update then
				self._currEvt:update(deltaTime)
			end

			if self._currEvt:isDone() then
				self._currEvt:checkCharacterAttrs()
				self._currEvt:finish()
				self._currEvt:clear()

				self._currEvt = nil
			end
		end

		if self._currEvt and self._currEvt.errorChecker and self._currEvt:errorChecker() then
			BattleModel.instance:setErrorCheck()
		end
	end
end

function BattleRoundBase:finish()
	return
end

function BattleRoundBase:clear()
	self.roundNum = nil
	self._evts = nil
	self.isRunning = nil
	self._currEvt = nil
end

function BattleRoundBase:isDone()
	if self._currEvt and not self._currEvt:isDone() then
		return
	end

	return not self._evts or #self._evts == 0
end

function BattleRoundBase:popEvent()
	if not self._evts then
		return nil
	end

	local evt = self._evts[1]

	if evt then
		table.remove(self._evts, 1)
	end

	return evt
end

function BattleRoundBase:onPass()
	if self._currEvt then
		self._currEvt:onPass()
	end

	local evt = self:popEvent()

	while evt do
		evt:onPass()

		evt = self:popEvent()
	end
end

function BattleRoundBase:onRetreat()
	return
end

function BattleRoundBase:pause(pause)
	if self._currEvt then
		self._currEvt:pause(pause)
	end
end

function BattleRoundBase:pushBeforeStartResult(beforeStartResult)
	if beforeStartResult.circleBeforeOneRoundCharacterResult then
		self:pushCharactorResult(beforeStartResult.circleBeforeOneRoundCharacterResult, false, true)
	end
end

function BattleRoundBase:pushCharactorResult(charactorResult, isStrickBack, isRoundBefore)
	if charactorResult.skillId == 0 then
		self:pushAfterEndResult(charactorResult)
	else
		self._evts = self._evts or {}

		local evt = BattleEvtCharactorAttack.New()

		evt.isRoundBefore = isRoundBefore
		evt.isStrickBack = isStrickBack
		evt.oneRoundCharacterResult = charactorResult

		table.insert(self._evts, evt)
	end
end

function BattleRoundBase:pushBeforeCombineResult(oneCircleCombineResult, roundNum)
	self._evts = self._evts or {}

	local evt = BattleEvtCombine.New()

	evt:handleCombine(oneCircleCombineResult, roundNum)
	table.insert(self._evts, evt)
end

function BattleRoundBase:pushBeforeCreateDoppelgangerResult(roundNum, oneCircleBeforeCreateDoppelgangerResult)
	self._evts = self._evts or {}

	local singleCreateDoppelgangerResults = oneCircleBeforeCreateDoppelgangerResult.singleCreateDoppelgangerResults

	for i, res in ipairs(singleCreateDoppelgangerResults) do
		local evt = BattleEvtCreateDoppelganger.New()

		evt:handleCreateDoppelganger(oneCircleBeforeCreateDoppelgangerResult, res, roundNum)
		table.insert(self._evts, evt)
	end
end

function BattleRoundBase:pushAfterCreateDoppelgangerResult(roundNum, oneCircleAfterCreateDoppelgangerResult)
	self._evts = self._evts or {}
end

function BattleRoundBase:pushDisintegrateResult(oneCircleDisintegrateResult, roundNum)
	self._evts = self._evts or {}

	local evt = BattleEvtDisintegrate.New()

	evt:handleDisintegrate(oneCircleDisintegrateResult, roundNum)
	table.insert(self._evts, evt)
end

function BattleRoundBase:getCharactorResult()
	if self._evts then
		for _, evt in ipairs(self._evts) do
			local info = evt:getCharactorResult()

			if info then
				return info
			end
		end
	end

	return nil
end

function BattleRoundBase:getTransformModelId(characterId, teamId)
	if self._evts then
		for _, evt in ipairs(self._evts) do
			local pre, aft = evt:getTransformModelId(characterId, teamId)

			if pre or aft then
				return pre, aft
			end
		end
	end

	return nil
end

function BattleRoundBase:pushUserActionResult(userActionResult)
	return
end

function BattleRoundBase:pushAfterEndResult(afterEndResult)
	self._evts = self._evts or {}

	if afterEndResult.targetPlayerResults and #afterEndResult.targetPlayerResults > 0 then
		local targetPlayerResults = afterEndResult.targetPlayerResults
		local evt = BattleEvtPlayerResult.New()

		evt.targetPlayerResults = targetPlayerResults

		table.insert(self._evts, evt)
	end

	if afterEndResult.targetCharacterResults and #afterEndResult.targetCharacterResults > 0 then
		local targetCharacterResults = afterEndResult.targetCharacterResults
		local evt = BattleEvtCharactorResult.New()

		evt.targetCharacterResults = targetCharacterResults

		table.insert(self._evts, evt)
	end
end

function BattleRoundBase:pushBeforeDomainResult(roundNum, beforeDomainChangeResult)
	local targetPlayerResults = beforeDomainChangeResult.targetPlayerResults
	local cnt = #targetPlayerResults
	local domainChange, targetNum

	for i = 1, cnt do
		local result = targetPlayerResults[i]
		local domainChanges = result.targetNum.resultObjectSummary.domainChange

		domainChange = domainChanges[1]

		if domainChanges[1] then
			targetNum = result.targetNum

			break
		end
	end

	if not domainChange then
		if beforeDomainChangeResult.targetCharacterResults and #beforeDomainChangeResult.targetCharacterResults > 0 then
			local targetCharacterResults = beforeDomainChangeResult.targetCharacterResults
			local evt = BattleEvtCharactorResult.New()

			evt.targetCharacterResults = targetCharacterResults

			table.insert(self._evts, evt)
		end

		return
	end

	local oneRoundCharacterResult = {}

	oneRoundCharacterResult.curRound = roundNum
	oneRoundCharacterResult.caster = {}
	oneRoundCharacterResult.caster.targetTeamId = domainChange.trigger.targetTeamId
	oneRoundCharacterResult.caster.targetCharacterId = domainChange.trigger.targetCharacterId
	oneRoundCharacterResult.skillCurBatterCount = 1
	oneRoundCharacterResult.skillId = domainChange.skillId
	oneRoundCharacterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
	oneRoundCharacterResult.isOverRoundLimit = false
	oneRoundCharacterResult.targetPlayerResults = GameUtil.emptyTable
	oneRoundCharacterResult.targetCharacterResults = {}

	for i = 1, #beforeDomainChangeResult.targetCharacterResults do
		table.insert(oneRoundCharacterResult.targetCharacterResults, beforeDomainChangeResult.targetCharacterResults[i])
	end

	local charactorResult = {}

	charactorResult.target = oneRoundCharacterResult.caster
	charactorResult.isHit = true
	charactorResult.isSkillEffected = true
	charactorResult.targetNum = targetNum

	table.insert(oneRoundCharacterResult.targetCharacterResults, charactorResult)
	self:pushCharactorResult(oneRoundCharacterResult, false, false)
end

function BattleRoundBase:getBuffEffectPaths()
	if not self._evts then
		return
	end

	local buffs = {}

	for i = 1, #self._evts do
		local buff = self._evts[i]:getBuffEffectPaths()

		if buff then
			table.merge(buffs, buff)
		end
	end

	return buffs
end

return BattleRoundBase
