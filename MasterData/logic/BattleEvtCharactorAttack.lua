-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtCharactorAttack.lua

module("logic.extensions.battle.model.events.BattleEvtCharactorAttack", package.seeall)

local BattleEvtCharactorAttack = class("BattleEvtCharactorAttack", BattleEvtBase)
local unityTime = UnityEngine.Time

function BattleEvtCharactorAttack:ctor()
	self.oneRoundCharacterResult = nil
	self.isStrickBack = nil
	self.battleFlow = nil
	self._errorCheckTimeOnToggled = 0
	self._errorCheckTimeOnNoToggled = 0
end

function BattleEvtCharactorAttack:getCharactorResult()
	return self.oneRoundCharacterResult
end

function BattleEvtCharactorAttack:getTransformModelId(characterId, teamId)
	local result = self.oneRoundCharacterResult
	local preTfsModelId, afterTfModelId

	if not result.targetCharacterResults then
		return
	end

	for i = 1, #result.targetCharacterResults do
		local cR = result.targetCharacterResults[i]

		if cR.target.targetTeamId == teamId and cR.target.targetCharacterId == characterId and cR.targetNum then
			local sR = cR.targetNum.resultObjectSummary

			if sR then
				for k = 1, #sR.transform do
					local tR = sR.transform[k]

					if tR.oc == GameEnum.BattleOc.After then
						afterTfModelId = tR.curFaceId
					elseif tR.oc == GameEnum.BattleOc.Beffore then
						preTfsModelId = tR.curFaceId
					end

					if preTfsModelId and afterTfModelId then
						break
					end
				end

				if preTfsModelId and afterTfModelId then
					break
				end
			end
		end

		if preTfsModelId and afterTfModelId then
			break
		end
	end

	return preTfsModelId, afterTfModelId
end

function BattleEvtCharactorAttack:handleEvt()
	if self.isPause then
		return
	end

	if not self.battleFlow then
		local unit = self:getCasterUnit()

		if self.oneRoundCharacterResult.isStrikeBack then
			local petCO = CharacterConfig.instance:getPetCo(unit.raceId)
			local petSkinCo = PetSkinConfig.instance:getPetSkinCfg((unit.modelId > 0 or nil) and unit.modelId)
			local charactor = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

			self.oneRoundCharacterResult.skillId = BattleModel.instance:isSameSkill(charactor.normalSkillId, petSkinCo.normalSkillId) and charactor.normalSkillId or petSkinCo.normalSkillId
		end

		if unit then
			self.battleFlow = unit.battleFlow
			unit.battleFlow.attackEvt = self

			if not self._setPerformingAttackRound then
				self._setPerformingAttackRound = true

				unit.attrs:setPerformingAttackRound(true)
			end
		end
	end

	if not self.battleFlow then
		self.isToggled = true

		return
	end

	self:_checkExistDomainChange()
	self:_startLoadDomainChangeScene()
	self:_startSkill()
end

function BattleEvtCharactorAttack:errorChecker()
	if self.isPause then
		return
	end

	if self._errorCheckTimeOnNoToggled and not self.isToggled then
		local deltaTime = unityTime.deltaTime

		if deltaTime < 0.5 then
			self._errorCheckTimeOnNoToggled = self._errorCheckTimeOnNoToggled + deltaTime

			if self._errorCheckTimeOnNoToggled > 15 then
				return true
			end
		end
	end

	if self._errorCheckTimeOnToggled and self.isToggled then
		if not self._animLength or self._animLength <= 0 then
			local caster = self:getCasterUnit()

			self._animLength = caster.skillPlayer:getAnimLen()
		end

		if self._animLength > 0 then
			local deltaTime = unityTime.deltaTime

			if deltaTime < 0.5 then
				self._errorCheckTimeOnToggled = self._errorCheckTimeOnToggled + deltaTime

				if self._errorCheckTimeOnToggled > self._animLength + 15 and not self:_isPerformingHuds() then
					return true
				end
			end
		end
	end
end

function BattleEvtCharactorAttack:getCasterUnit()
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local casterTeamId = self.oneRoundCharacterResult.caster.targetTeamId
	local casterCharactorId = self.oneRoundCharacterResult.caster.targetCharacterId
	local unit = battleScene.unitFactory:getUnit(casterTeamId, casterCharactorId)

	if not unit then
		printError(">>>>>>>>>>>>>>>>>>>>找不到施放者getCasterUnit>>", casterTeamId, casterCharactorId)
	end

	return unit
end

function BattleEvtCharactorAttack:_startSkill()
	if self._isLoadingDomainChangeScene then
		return
	end

	if self:_isTransingPosition() then
		return
	end

	self:_checkUnitDead()
	self:_hookUtlSkill()

	local skillId = self.oneRoundCharacterResult.skillId
	local curAttackCount = self.oneRoundCharacterResult.skillCurBatterCount

	if self.battleFlow:attack(skillId, self.oneRoundCharacterResult.skillExecuteState, self.isStrickBack, curAttackCount, self._skillTargets) then
		self.isToggled = true

		self:_brocastUtlSkill()

		if self.oneRoundCharacterResult.curRound and not self.isRoundBefore then
			local curRound = BattleModel.instance.currSubRoundNum

			BattleModel.instance.currSubRoundNum = self.oneRoundCharacterResult.curRound

			if curRound < BattleModel.instance.currSubRoundNum then
				BattleItemsModel.instance:cooldownItemCd()
			end
		end
	end
end

function BattleEvtCharactorAttack:_checkUnitDead()
	local unit = self.battleFlow:getUnit()

	if unit:isDead() then
		unit.buffList:onRelive()
	end
end

function BattleEvtCharactorAttack:_hookUtlSkill()
	local skillId = self.oneRoundCharacterResult.skillId
	local unit = self.battleFlow:getUnit()
	local skill = unit.skillList:getSkill(skillId)

	if skill then
		GlobalDispatcher:dispatch(GlobalNotify.HookSkillStart, skill, self:getTargetCharactor())
	end
end

function BattleEvtCharactorAttack:_brocastUtlSkill()
	if self.oneRoundCharacterResult.skillExecuteState == GameEnum.SkillExecuteState.CanExecute then
		local skillId = self.oneRoundCharacterResult.skillId
		local unit = self.battleFlow:getUnit()
		local skill = unit.skillList:getSkill(skillId)

		if skill and skill.isUtlSkill then
			local tagts = skill:getSkillTargets()

			if tagts and #tagts > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.BattleUtlSkillStart, unit, skill)
			end
		end
	end
end

function BattleEvtCharactorAttack:testPrint()
	return
end

function BattleEvtCharactorAttack:isDone()
	if not self.isToggled then
		return
	end

	if BattleModel.instance.transformingCount > 0 then
		return
	end

	if not self.battleFlow then
		return true
	end

	if self.battleFlow:isSkillWithDraw() then
		if self:_isTransingPosition() then
			return
		end

		self:_resetPerformingAttackRound()

		local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

		if not battleScene.collisions:isEmpty() then
			return
		end

		self._allUnits = self._allUnits or self:getAllCharactors()

		if self._allUnits then
			for k, v in pairs(self._allUnits) do
				if k.attrs:isTriggerTransPosition() or k.attrs:isTransPosition() then
					return
				end

				if k.attrs:getCurHp() == 0 and not k.attrs.deadAnimFinished and not k.attrs:isCombineUnit() and BattleModel.instance:getStrickBackTimes(k.teamId, k.id) == 0 then
					return
				end

				if k:isPerformingHuds() then
					return
				end
			end
		end

		return true
	end
end

function BattleEvtCharactorAttack:_isTransingPosition()
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	if units then
		for k, v in pairs(units) do
			for k1, v1 in pairs(v) do
				if v1.attrs:isTriggerTransPosition() or v1.attrs:isTransPosition() then
					return true
				end
			end
		end
	end
end

function BattleEvtCharactorAttack:_checkExistDomainChange()
	if self._hasCheckExistDomainChange then
		return
	end

	self._hasCheckExistDomainChange = true

	if BattleModel.instance:getBattleBgCoverDomain() then
		return
	end

	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults
	local cnt = #targetCharacterResults

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.targetNum and result.targetNum.resultObjectSummary and result.targetNum.resultObjectSummary.domainChange then
			local domainChange = result.targetNum.resultObjectSummary.domainChange

			if #domainChange > 0 then
				for j = 1, #domainChange do
					local domainSkillCo = BattleConfig.instance:getDomainSkillLevelCo(domainChange[j].skillId, domainChange[j].level)

					if domainSkillCo then
						self._domainSkillScene = GameUrl.getBattleStageUrl(domainSkillCo.scene)

						return
					end
				end
			end
		end
	end
end

function BattleEvtCharactorAttack:_startLoadDomainChangeScene()
	if self._hasStartLoadDomainChangeScene then
		return
	end

	self._hasStartLoadDomainChangeScene = true
	self._isLoadingDomainChangeScene = true

	if string.nilorempty(self._domainSkillScene) then
		self._isLoadingDomainChangeScene = false

		return
	end

	BattleStagesMgr.instance:loadStage(self._domainSkillScene, self._onDomainChangeSceneLoaded, self)
end

function BattleEvtCharactorAttack:_onDomainChangeSceneLoaded()
	self._isLoadingDomainChangeScene = false
end

function BattleEvtCharactorAttack:_isPerformingHuds()
	if self._allUnits then
		for k, v in pairs(self._allUnits) do
			if k:isPerformingHuds() then
				return true
			end
		end
	end
end

function BattleEvtCharactorAttack:finish()
	self:_resetPerformingAttackRound()

	if self.oneRoundCharacterResult.isStrikeBack then
		local casterTeamId = self.oneRoundCharacterResult.caster.targetTeamId
		local casterCharactorId = self.oneRoundCharacterResult.caster.targetCharacterId

		BattleModel.instance:popStrickBackTimes(casterTeamId, casterCharactorId)
	end
end

function BattleEvtCharactorAttack:_resetPerformingAttackRound()
	if self._setPerformingAttackRound and self.battleFlow then
		local unit = self.battleFlow:getUnit()

		unit.attrs:setPerformingAttackRound(false)

		self._setPerformingAttackRound = nil
	end
end

function BattleEvtCharactorAttack:checkCharacterAttrs()
	local isCheck = false

	if not isCheck then
		return
	end

	local needModify = false
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults
	local cnt = #targetCharacterResults

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.targetNum and result.targetNum.afterRoundVigour and result.targetNum.afterRoundHp then
			local unitTarget = battleScene.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			if unitTarget then
				unitTarget:clearBuffDamages()

				local curHp = unitTarget.attrs:getCurHp()
				local srvHp = result.targetNum.afterRoundHp

				if curHp ~= srvHp then
					needModify = true

					local petCO = CharacterConfig.instance:getPetCo(unitTarget.raceId)

					unitTarget.attrs:setCurTempHp(srvHp)

					if unitTarget:isDead() and srvHp > 0 then
						unitTarget.buffList:onRelive()
					end
				end

				local curVigour = unitTarget.attrs:getCurVigour()
				local srvVigour = result.targetNum.afterRoundVigour

				if curVigour ~= srvVigour then
					needModify = true

					unitTarget.attrs:setCurVigour(srvVigour)
				end
			end
		end
	end

	if needModify then
		FloatWordMgr.instance:show("前后端数据不一致，修正成功")
	end
end

function BattleEvtCharactorAttack:clear()
	self.oneRoundCharacterResult = nil

	if self.battleFlow then
		self.battleFlow.attackEvt = nil
		self.battleFlow = nil
	end

	self._allUnits = nil
	self._errorCheckTimeOnToggled = nil
	self._errorCheckTimeOnNoToggled = nil
end

function BattleEvtCharactorAttack:onPass()
	self:finish()

	local unit = self:getCasterUnit()

	if unit and self.isToggled then
		unit:stopSkill()
	end

	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults
	local cnt = #targetCharacterResults

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.targetNum and result.targetNum.afterRoundVigour and result.targetNum.afterRoundHp then
			local unitTarget = battleScene.unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			if unitTarget then
				unitTarget:clearBuffDamages()
				unitTarget.attrs:setCurVigour(result.targetNum.afterRoundVigour)

				if result.targetNum.HasField ~= nil and result.targetNum:HasField("afterRoundHp") then
					unitTarget.attrs:setCurTempHp(result.targetNum.afterRoundHp)
					unitTarget.attrs:setCurHp(result.targetNum.afterRoundHp)
				end

				if unitTarget.attrs:isSummonedCharacter() and not unitTarget.attrs:isHaveBeenSummoned() then
					unitTarget.attrs:setHaveBeenSummoned(true)
				end

				if unitTarget.attrs:isDoppelganger() and not unitTarget.attrs:isHaveBeenDoppelgangerCreated() then
					unitTarget.attrs:setHaveBeenSummoned(true)
				end

				if unitTarget.attrs:isTJSummonedCharacter() and not unitTarget.attrs:isHaveBeenTJSummoned() then
					unitTarget.attrs:setHaveBeenTJSummoned(true)
				end
			end
		end
	end

	self:clear()
end

function BattleEvtCharactorAttack:pause(pause)
	self.isPause = pause

	if self.battleFlow then
		self.battleFlow:pause(pause)
	end
end

function BattleEvtCharactorAttack:getAllCharactors()
	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults

	if not targetCharacterResults then
		return
	end

	local cnt = #targetCharacterResults
	local allUnits
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local unitFactory = battleScene.unitFactory

	for i = 1, cnt do
		local result = targetCharacterResults[i]
		local unit = unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

		if unit then
			allUnits = allUnits or {}
			allUnits[unit] = true
		end
	end

	return allUnits
end

function BattleEvtCharactorAttack:getTargetCharactor()
	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults

	if not targetCharacterResults then
		return
	end

	local cnt = #targetCharacterResults
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local unitFactory = battleScene.unitFactory

	for i = 1, cnt do
		local result = targetCharacterResults[i]

		if result.isSkillEffected then
			local unit = unitFactory:getUnit(result.target.targetTeamId, result.target.targetCharacterId)

			if unit then
				return unit
			end
		end
	end
end

function BattleEvtCharactorAttack:getBuffEffectPaths()
	local targetCharacterResults = self.oneRoundCharacterResult.targetCharacterResults

	return self:_getBuffEffectPathsFromCharResults(targetCharacterResults)
end

return BattleEvtCharactorAttack
