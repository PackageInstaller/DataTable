-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleModel.lua

module("logic.extensions.battle.model.BattleModel", package.seeall)

local BattleModel = class("BattleModel", BaseListModel)

BattleModel.InfoType_Hp_None = 1
BattleModel.InfoType_Hp_Vigour = 2
BattleModel.InfoType_Hp_Vigour_Attr_Name_Level = 3
BattleModel.MaxVigour = 150
BattleModel.Skip_Retreat = 1
BattleModel.Skip_Pass = 2
BattleModel.CgBattleStartPath = "scene/battle/local/cg_battlestart.txt"
BattleModel.CgBattleRoundPath = "scene/battle/local/cg_battlerounds.txt"
BattleModel.CgBattleResultPath = "scene/battle/local/cg_battleresult.txt"
BattleModel.accFModEffRoundLimit = 10
BattleModel.SkillMaxLv = 5
BattleModel.SameSkillIdDifference = 25

function BattleModel:ctor()
	BattleModel.super.ctor(self)

	self.testBattleSceneName = nil
	self.myTeamId = nil
	self.originalStates = nil
	self.oneFightResult = nil
	self.rounds = nil
	self.isRunning = nil
	self.isBirthing = nil
	self.winnerTeam = nil
	self.battleResult = nil
	self.realBattleResult = nil
	self.currRoundNum = 1
	self.currSubRoundNum = 0
	self.challengeLvId = nil
	self.monsterId = nil
	self.monsterZoneId = nil
	self.viewFightBtl = nil
	self.storyData = nil
	self.pauseBattle = nil
	self.recentlyBattleId = nil
	self.btlInfoType = nil
	self.testSkippedBattle = nil
	self._hasError = nil
	self.recordEntry = nil
	self.isOverRoundLimit = nil
	self.skipType = nil
	self.retreatMsgType = 0
	self.enableSkip = nil
	self._strikeBackTimes = nil
	self.transformingCount = 0
	self.showPetZdl = false
	self._battleRoundInitId = -1
	self._battleRoundOverId = -2
	self.testBattleSkinId = 0
	self.testBattleUISkinId = 0
end

function BattleModel:onReset()
	BattleModel.super.onReset(self)
	self:_resetBattle()

	self._leftTeamId = nil
	self.storyData = nil
	self.isPlayingCgBattle = nil
	self.isPlayingOnlyLocalBattle = nil
	self.testBattleSceneName = nil
	self._endDialogId = nil
	self._skillChecked = false
	self.testBattleSkinId = 0
	self.testBattleUISkinId = 0
end

function BattleModel:setSkillCheck(isCheck)
	self._skillChecked = isCheck
end

function BattleModel:isSkillCheck()
	return self._skillChecked
end

function BattleModel:setErrorCheck()
	self._errorChecked = true
end

function BattleModel:isErrorCheck()
	return self._errorChecked
end

function BattleModel:_resetBattle()
	BattleItemsModel.instance:onReset()
	BattleStatisticsDataModel.instance:onReset()

	self._hasError = nil
	self.isOverRoundLimit = nil
	self._errorChecked = nil
	self.skipType = nil
	self._strikeBackTimes = nil
	self.pauseBattle = nil
	self.myTeamId = nil
	self.originalStates = nil
	self.oneFightResult = nil
	self.preStatsRounds = nil
	self.transformingCount = 0
	self.recordEntry = nil
	self.isBirthing = nil
	self.bettleResultData = nil
	self.rounds = nil
	self.retreatMsgType = 0
	self.enableSkip = nil
	self.afterEndRounds = nil
	self.isRunning = nil
	self.winnerTeam = nil
	self.battleResult = nil
	self.realBattleResult = nil
	self.currRoundNum = 1
	self.currSubRoundNum = 0
	self.viewFightBtl = nil
	self.btlInfoType = nil
	self.pm_BattleResult = nil
	self._battleRoundInitId = -1
	self._battleRoundOverId = -2
end

function BattleModel:setBattleName(name)
	self._battleName = name
end

function BattleModel:getBattleName()
	return self._battleName
end

function BattleModel:setBulletKey(val)
	self._bulletKey = val
end

function BattleModel:getBulletKey()
	return self._bulletKey
end

function BattleModel:setLeftTeamId(teamId)
	self._leftTeamId = teamId
end

function BattleModel:getLeftTeamId()
	return self._leftTeamId or self.myTeamId
end

function BattleModel:getRightTeamId()
	local leftTeamId = self:getLeftTeamId()

	if leftTeamId == GameEnum.BattleTeam.Left then
		return GameEnum.BattleTeam.Right
	end

	return GameEnum.BattleTeam.Left
end

function BattleModel:getTeamDirection(teamId)
	if not self._leftTeamId then
		return teamId
	end

	return (self._leftTeamId == teamId or nil) and (GameEnum.BattleTeam.Left or GameEnum.BattleTeam.Right)
end

function BattleModel:addStrickBackTimes(teamId, id, roundNum)
	self._strikeBackTimes = self._strikeBackTimes or {}

	local teams = self._strikeBackTimes[teamId]

	if not teams then
		teams = {}
		self._strikeBackTimes[teamId] = teams
	end

	local rounds = teams[id]

	if not rounds then
		rounds = {}
		teams[id] = rounds
	end

	table.insert(rounds, roundNum)
end

function BattleModel:popStrickBackTimes(teamId, id)
	if not self._strikeBackTimes then
		return
	end

	local teams = self._strikeBackTimes[teamId]

	if not teams then
		return
	end

	local rounds = teams[id]

	if not rounds or #rounds == 0 then
		return
	end

	table.remove(rounds, 1)
end

function BattleModel:getStrickBackTimes(teamId, id)
	if not self._strikeBackTimes then
		return 0
	end

	local teams = self._strikeBackTimes[teamId]

	if not teams then
		return 0
	end

	local rounds = teams[id]

	if not rounds or #rounds == 0 then
		return 0
	end

	if rounds[1] ~= self.currRoundNum then
		return 0
	end

	return 1
end

function BattleModel:getAutoSkipShenyaoSkill()
	local skip = checknumber(UnityEngine.PlayerPrefs.GetInt("skip_skills_shenyao"))

	return skip ~= 0
end

function BattleModel:setAutoSkipShenyaoSkill(skip)
	UnityEngine.PlayerPrefs.SetInt("skip_skills_shenyao", skip and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:getAutoSkipUtilSkill()
	local skip = checknumber(UnityEngine.PlayerPrefs.GetInt("skip_utlskills"))

	return skip ~= 0
end

function BattleModel:setAutoSkipUtilSkill(skip)
	UnityEngine.PlayerPrefs.SetInt("skip_utlskills", skip and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:getAutoSkipShenHuaEnter()
	local skip = checknumber(UnityEngine.PlayerPrefs.GetInt("skip_shenhua_enter"))

	return skip ~= 0
end

function BattleModel:setAutoSkipShenHuaEnter(skip)
	UnityEngine.PlayerPrefs.SetInt("skip_shenhua_enter", skip and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:getOnlyShowSelfShenHuaEnter()
	local skip = checknumber(UnityEngine.PlayerPrefs.GetInt("only_show_shenhua_enter"))

	return skip ~= 0
end

function BattleModel:setOnlyShowSelfShenHuaEnter(skip)
	UnityEngine.PlayerPrefs.SetInt("only_show_shenhua_enter", skip and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:getBattleBgCoverDomain()
	local flag = checknumber(UnityEngine.PlayerPrefs.GetInt("cover_battlebg"))

	return flag ~= 0
end

function BattleModel:setBattleBgCoverDomain(flag)
	UnityEngine.PlayerPrefs.SetInt("cover_battlebg", flag and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:getBattleNickName()
	local leftTeamId = self:getTeamDirection(self.myTeamId)
	local playerView = self:getPlayer(leftTeamId)

	if playerView and playerView.name and #playerView.name > 0 then
		return playerView.name
	end

	return RoleModel.instance:getUserName()
end

function BattleModel:getEnemyNickName()
	if self.isEndlessBattle == true then
		return EndlessBattleController.instance:getBattleName()
	end

	local rightTeamId = self:getTeamDirection(self:getEnemyPlayerTeam())
	local playerView = self:getPlayer(rightTeamId)

	if playerView and playerView.name and #playerView.name > 0 then
		return playerView.name
	end

	return self:getBattleName()
end

function BattleModel:_getInfomationKey()
	return "btlInfoCfg_" .. LoginModel.instance.userId
end

function BattleModel:getBtlInfoType()
	self.btlInfoType = self.btlInfoType or UnityEngine.PlayerPrefs.GetInt(self:_getInfomationKey())

	if not self.btlInfoType or self.btlInfoType == 0 then
		self.btlInfoType = BattleModel.InfoType_Hp_Vigour
	end

	return self.btlInfoType
end

function BattleModel:saveBtlInfoType(type)
	self.btlInfoType = type

	UnityEngine.PlayerPrefs.SetInt(self:_getInfomationKey(), self.btlInfoType)
	UnityEngine.PlayerPrefs.Save()
end

function BattleModel:_getInfomationKey()
	return "btlInfoCfg_" .. LoginModel.instance.userId
end

function BattleModel:getTeamSpeed(teamId)
	local player = self:getPlayer(teamId)

	return player.speed
end

function BattleModel:getPlayer(teamId)
	local originalStates = self.originalStates

	if not originalStates then
		return
	end

	for k, v in pairs(originalStates.teams) do
		if v.playerView and v.teamId == teamId then
			return v.playerView
		end
	end
end

function BattleModel:getEnemyPlayerTeam()
	if self.myTeamId == GameEnum.BattleTeam.Left then
		return GameEnum.BattleTeam.Right
	end

	return GameEnum.BattleTeam.Left
end

function BattleModel:getEnemyPlayer()
	local teamId = self:getEnemyPlayerTeam()

	return self:getPlayer(teamId)
end

function BattleModel:getCharactor(teamId, petId)
	local player = self:getPlayer(teamId)

	if player then
		if player.characterViews then
			for i, v in ipairs(player.characterViews) do
				if v.raceId == petId then
					return v
				end
			end
		end

		if player.extCharacterViews then
			for i, v in ipairs(player.extCharacterViews) do
				if v.raceId == petId then
					return v
				end
			end
		end
	end
end

function BattleModel:updateCharactor(teamId, petId, charactorView)
	local player = self:getPlayer(teamId)

	if player then
		if player.characterViews then
			for i, v in ipairs(player.characterViews) do
				if v.id == petId then
					player.characterViews[i] = charactorView
				end
			end
		end

		if player.extCharacterViews then
			for i, v in ipairs(player.extCharacterViews) do
				if v.id == petId then
					player.extCharacterViews[i] = charactorView
				end
			end
		end
	end
end

function BattleModel:getCharactorById(teamId, id)
	local player = self:getPlayer(teamId)

	if player then
		if player.characterViews then
			for i, v in ipairs(player.characterViews) do
				if v.id == id then
					return v
				end
			end
		end

		if player.extCharacterViews then
			for i, v in ipairs(player.extCharacterViews) do
				if v.id == id then
					return v
				end
			end
		end
	end
end

function BattleModel:getActionMode()
	local originalStates = self.originalStates

	if not originalStates then
		return
	end

	return originalStates.mode
end

function BattleModel:getFightPlace()
	return self.originalStates.fightPlace
end

function BattleModel:startBattle()
	self.isRunning = true
end

function BattleModel:finishBattle()
	return
end

function BattleModel:endBattle()
	self.storyData = nil
	self.isRunning = nil
	self.expedition = nil
	self.challengeLvId = nil
	self.monsterId = nil
	self.monsterZoneId = nil
	self.eveA = nil
	self.eveB = nil
	self._battleName = nil
	self.pveId = nil
	self.copyId = nil
	self.isRankingRace = nil
	self.copyLevelId = nil
	self._hasError = nil
	self.pauseBattle = nil
	self._bulletKey = nil
	self.testBattleSkinId = 0
	self.testBattleUISkinId = 0
end

function BattleModel:getTotalHurt(targetType)
	if self.recordEntry then
		if targetType == GameEnum.TargetType.Friend then
			return checknumber(self.pm_BattleResult.teamATotalDamage)
		else
			return checknumber(self.pm_BattleResult.teamBTotalDamage)
		end
	elseif targetType == GameEnum.TargetType.Friend then
		return checknumber(self.bettleResultData.teamATotalDamage)
	else
		return checknumber(self.bettleResultData.teamBTotalDamage)
	end
end

function BattleModel:getConditionType()
	if self.bettleResultData.conditionType then
		return self.bettleResultData.conditionType
	end

	return ""
end

function BattleModel:getConditionParams()
	if self.bettleResultData.conditionParams then
		return self.bettleResultData.conditionParams
	end

	return ""
end

function BattleModel:getConditionTypeParams()
	if self.bettleResultData.conditionTypeParams then
		return self.bettleResultData.conditionTypeParams
	end

	return "0"
end

function BattleModel:isPerfectWin()
	return self.bettleResultData.isPerfectWin
end

function BattleModel:getPerfectWinType()
	if self.bettleResultData.perfectWinType then
		return self.bettleResultData.perfectWinType
	end

	return ""
end

function BattleModel:getPerfectWinParams()
	if self.bettleResultData.perfectWinParams then
		return self.bettleResultData.perfectWinParams
	end

	return ""
end

function BattleModel:getPerfectWinTypeParams()
	if self.bettleResultData.perfectWinTypeParams then
		return self.bettleResultData.perfectWinTypeParams
	end

	return "0"
end

function BattleModel:viewUserFightMonsterBtlResult(btlresult, isResord)
	self:_resetBattle()
	self:setBattleId(checknumber(btlresult.originalStates.battleId))

	self.originalStates = btlresult.originalStates
	self.battleResult = nil
	self.realBattleResult = nil
	self.currSubRoundNum = 0
	self.skipType = nil
	self.isOverRoundLimit = nil
	self.myTeamId = GameEnum.BattleTeam.Left
	self.recentlyBattleId = self.battleId
	self.viewFightBtl = isResord
	self.pm_BattleResult = btlresult

	if self.isPlayingCgBattle then
		self:_parseBattleStoryData()
	end

	self:_getRound(1, BattleRoundBase.RoundBirth)

	self.retreatMsgType = 0
	self.enableSkip = nil

	self:pushOneRoundResult(self.battleId, btlresult.oneFightResult.roundList)

	local result = {}

	result.battleId = self.battleId
	result.originalWinner = btlresult.originalWinner
	result.activityWinner = btlresult.activityWinner
	result.teamAStatistics = btlresult.teamAStatistics
	result.teamBStatistics = btlresult.teamBStatistics

	self:onBattleResult(result)
end

function BattleModel:viewUserShareTaskFightMonsterBtlResult(btlresult, isResord)
	self:viewUserFightMonsterBtlResult(btlresult, isResord)

	self.enableSkip = btlresult.originalStates.enableSkip
end

function BattleModel:onBattleStartData(battleData)
	self:_resetBattle()

	self.myTeamId = battleData.myTeamId or GameEnum.BattleTeam.Left

	self:setBattleId(checknumber(battleData.originalStates.battleId))
	self:_setPreviewParams(battleData)

	self.originalStates = battleData.originalStates
	self.battleResult = nil
	self.skipType = nil
	self.isOverRoundLimit = nil
	self.realBattleResult = nil
	self.currSubRoundNum = 0
	self.retreatMsgType = battleData.originalStates.retreatMsgType
	self.enableSkip = battleData.originalStates.enableSkip
	self.recentlyBattleId = self:getBattleId()

	self:_parseBattleStoryData()
	self:_buildExpression(battleData)
	self:_getRound(1, BattleRoundBase.RoundBirth)
	self:_parsePetIntrodRound()

	if self:getActionMode() ~= GameEnum.ActionModel.NoneAction then
		self:_getRound(1, BattleRoundBase.RoundBegin)
	else
		self:_parseBattleStartRoundFromStory()
	end
end

function BattleModel:onBattleResult(result)
	if checknumber(result.battleId) ~= self.battleId then
		return
	end

	if self._hasError then
		return
	end

	self.bettleResultData = result

	BattleStatisticsDataModel.instance:onBtlEndRes(result)
	self:calculateBattleResult(result)
	self:_parseBattleEndRoundFromStory()

	local round = self:_getRound(0, BattleRoundBase.End)

	round.result = result
end

function BattleModel:isEvE()
	return self.eveA and self.eveB and self.eveA ~= 0 and self.eveB ~= 0
end

function BattleModel:isExpedition()
	return self.expedition
end

function BattleModel:getUnits()
	local battleScene = SceneMgr.instance:getCurScene()

	return battleScene.unitFactory:getBttleUnits(self:getTeamDirection(self.myTeamId)) or {}
end

function BattleModel:getEnemyUnits()
	local battleScene = SceneMgr.instance:getCurScene()

	return battleScene.unitFactory:getBttleUnits(self:getTeamDirection(self:getEnemyPlayerTeam())) or {}
end

function BattleModel:getCatchedUnits()
	return BattleItemsModel.instance:getCatchedUnits() or {}
end

function BattleModel:_parsePetIntrodRound()
	local petId = PetIntroductionModel.instance:getIntroducePetId()

	if petId and petId > 0 then
		local round = self:_getRound(1, BattleRoundBase.RoundPetIntrod)

		round.raceId = petId

		return true
	end
end

function BattleModel:setStoryData(storyData)
	self.storyData = storyData
end

function BattleModel:_parseBattleStoryData()
	if DebugBattleStory.DebugMode then
		self.storyData = {}
		self.storyData.storyId = DebugBattleStory.StoryId
		self.storyData.mode = DebugBattleStory.DebugMode
		self.storyData.petId = DebugBattleStory.PetId
		self.storyData.round = DebugBattleStory.RoundNum
	else
		self.storyData = self.storyData or TaskFacade.instance:getBattleStoryConfig(self.eveA, self.eveB, self.pveId, self.challengeLvId)
		self.storyData = self.storyData or StoryFacade.instance:getBattleStoryConfig(self.eveA, self.eveB)
	end
end

function BattleModel:_parseBattleStartRoundFromStory()
	if self.storyData and not self.storyData.hasPlayed and self.storyData.mode == TaskConst.BattleStoryTrigger_Start then
		local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

		round.storyId = self.storyData.storyId
		self.storyData.hasPlayed = true
	end
end

function BattleModel:_parseBattleEndRoundFromStory()
	local handler = BattleFacade.instance:getBattleEndRoundFromStoryHandler()

	if handler then
		local isWin = self.battleResult == GameEnum.BattleResult.Success or self.battleResult == GameEnum.BattleResult.ExpSuccess

		handler(isWin)
	end

	local hasResult

	if self.storyData and not self.storyData.hasPlayed and self.storyData.mode == TaskConst.BattleStoryTrigger_End then
		local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

		round.storyId = self.storyData.storyId
		self.storyData.hasPlayed = true
		round.isResult = true
		hasResult = true
	end

	if not hasResult then
		local storyData = StoryFacade.instance:getBattleResultStoryConfig(self.eveA, self.eveB)

		if storyData then
			local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

			round.storyId = storyData.storyId
			round.isResult = true
		end
	end
end

function BattleModel:_parseRoundStartRoundFromStory(currRound)
	if BattleModel.instance.isPlayingCgBattle then
		local storyId = StoryFacade.instance:getBattleRoundConfig(currRound)

		if storyId then
			local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

			round.storyId = storyId

			return
		end
	end

	if self.storyData and not self.storyData.hasPlayed and self.storyData.mode == TaskConst.BattleStoryTrigger_Round and currRound == self.storyData.round then
		local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

		round.storyId = self.storyData.storyId
		self.storyData.hasPlayed = true
	end
end

function BattleModel:_parsePetAttackRoundFromStory(oneRoundCharacterResult)
	if self.storyData and not self.storyData.hasPlayed and self.storyData.mode == TaskConst.BattleStoryTrigger_PetAttacke and oneRoundCharacterResult.caster and oneRoundCharacterResult.caster.targetTeamId ~= self.myTeamId then
		local playerView = self:getPlayer(oneRoundCharacterResult.caster.targetTeamId)
		local characterViews = playerView.characterViews

		for i, v in ipairs(characterViews) do
			if checknumber(v.id) == oneRoundCharacterResult.caster.targetCharacterId and checknumber(v.raceId) == self.storyData.petId then
				local round = self:_getRound(0, BattleRoundBase.RoundPlayStory)

				round.storyId = self.storyData.storyId
				self.storyData.hasPlayed = true

				return
			end
		end
	end
end

function BattleModel:_buildExpression(battleData)
	local limitCo

	if self.monsterId and self.monsterId > 0 then
		local mstCo = SceneConfig.instance:getMonsterMaskterCo(self.monsterId)

		if mstCo.limitClazz and #mstCo.limitClazz > 0 then
			limitCo = mstCo
		end
	elseif self.challengeLvId and self.challengeLvId > 0 then
		local challengeCo = ChallengeConfig.instance:getMissionCfg(self.challengeLvId)

		if challengeCo.limitClazz and #challengeCo.limitClazz > 0 then
			limitCo = challengeCo
		end
	end

	if limitCo then
		BattleItemsModel.instance.expression = BattleExpressionBase.createExpression(limitCo)
	end
end

function BattleModel:pushOneRoundResult(battleId, oneRoundResult)
	if checknumber(battleId) ~= self.battleId then
		return
	end

	if self._hasError then
		return
	end

	for i, v in ipairs(oneRoundResult) do
		self:_createRound(v)
	end

	self._battleRoundOverId = checknumber(battleId)

	GlobalDispatcher:dispatch(GlobalNotify.OnBattleRoundPush)
end

function BattleModel:checkHasBattleIdInitRound(battleId)
	return self._battleRoundInitId == self._battleRoundOverId
end

function BattleModel:onBtlStartError(errCode)
	self._hasError = true
end

function BattleModel:pushErrorRound(errCode)
	if self._hasError or self:hasReceivedResult() then
		return
	end

	self._hasError = true
	self.rounds = {}

	local round = self:_getRound(self.roundNum, BattleRoundBase.RoundError)

	round.errorCode = errCode
end

function BattleModel:calculateBattleResult(rData)
	local battid = checknumber(rData.battleId)
	local winner = checknumber(rData.activityWinner)

	if battid ~= self:getBattleId() then
		printBattleError("战斗ID 不对应")
	end

	self.realBattleResult = rData.activityWinner
	self.winnerTeam = winner

	local leftTeamId = self:getLeftTeamId()

	if winner == leftTeamId then
		self.battleResult = GameEnum.BattleResult.Success

		PetIntroductionModel.instance:saveBreakFormationIntroduce()
	else
		self.battleResult = winner == -1 and GameEnum.BattleResult.DogFall or GameEnum.BattleResult.Failed
	end

	if self:isExpedition() then
		ExpeditionModel.instance:setBattleResult(self.battleResult)
	else
		ExpeditionModel.instance:setBattleResult(nil)
	end

	if rData.expResult and rData.expResult.petGainExp and #rData.expResult.petGainExp > 0 then
		self.battleResult = GameEnum.BattleResult.ExpSuccess
	end

	self:_checkOpenMainUIWhileBackToCity()
end

function BattleModel:_checkOpenMainUIWhileBackToCity()
	if self.battleResult == GameEnum.BattleResult.Success or self.battleResult == GameEnum.BattleResult.ExpSuccess then
		if self.copyId then
			local taskes = TaskModel.instance:getCompeleteTaskesRelateToCopyId(self.copyId, self.copyLevelId)

			if taskes and #taskes > 0 then
				UIJumper.instance:clear()
			end
		elseif self.sccopyActivityId and self.sccopyTypeId and self.sccopyChapterId then
			local taskes = TaskModel.instance:getCompeleteTaskesRelateToSCCopyId(self.sccopyActivityId, self.sccopyTypeId, self.sccopyChapterId)

			if taskes and #taskes > 0 then
				UIJumper.instance:clear()
			end
		end
	end
end

function BattleModel:isSelfRealWin()
	return self.realBattleResult == 0
end

function BattleModel:hasReceivedResult()
	return self.bettleResultData
end

function BattleModel:hasError()
	return self._hasError
end

function BattleModel:pushContinueFightRound()
	if self._hasError or self:hasReceivedResult() then
		return
	end

	local round = self:_getRound(0, BattleRoundBase.RoundContinue)

	round.isRetreat = false
end

function BattleModel:onRetreatRound(isRetreat)
	if self._hasError or self:hasReceivedResult() then
		return
	end

	BattleAgent.instance:sendPM_ContinueFightReq(self:getBattleId(), isRetreat or false)
end

function BattleModel:onSkipBattle()
	if self._hasError or self:hasReceivedResult() then
		return
	end

	BattleAgent.instance:sendPM_SkipReq(self:getBattleId())
end

function BattleModel:setBattleId(id)
	self.battleId = id
	self._battleRoundInitId = id
	self._battleRoundOverId = -2
end

function BattleModel:getBattleId()
	return self.battleId
end

function BattleModel:popRound()
	if self.rounds then
		local round = self.rounds[1]

		if round then
			table.remove(self.rounds, 1)
		end

		return round
	end
end

function BattleModel:isRoundsEmpty()
	if self.rounds then
		return #self.rounds == 0
	end

	return true
end

function BattleModel:_createRound(oneRoundResult)
	local roundNum = oneRoundResult.curCircleSeqNum

	self:_ensureRoundBegin(roundNum)

	if oneRoundResult:HasField("oneRoundCharacterResult") then
		self:_parsePetAttackRoundFromStory(oneRoundResult.oneRoundCharacterResult)

		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushCharactorResult(oneRoundResult.oneRoundCharacterResult)
		self:_createStrickBackRound(roundNum, oneRoundResult.oneRoundCharacterResult)

		self.isOverRoundLimit = self.isOverRoundLimit or oneRoundResult.oneRoundCharacterResult.isOverRoundLimit
	end

	if oneRoundResult:HasField("oneRoundUserActionResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.RoundUseItem)

		round:pushUserActionResult(oneRoundResult.oneRoundUserActionResult)
	end

	if oneRoundResult:HasField("oneCircleBeforeResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushCharactorResult(oneRoundResult.oneCircleBeforeResult.circleBeforeOneRoundCharacterResult, false, true)
	end

	if oneRoundResult:HasField("oneCircleCombineResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushBeforeCombineResult(oneRoundResult.oneCircleCombineResult, roundNum)
	end

	if oneRoundResult:HasField("oneCircleDisintegrateResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushDisintegrateResult(oneRoundResult.oneCircleDisintegrateResult, roundNum)
	end

	if oneRoundResult:HasField("oneCircleBattleEndFixResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.RoundAfter)

		round:pushAfterEndResult(oneRoundResult.oneCircleBattleEndFixResult)
	end

	if oneRoundResult:HasField("oneCircleAfterResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.RoundAfter)

		round:pushAfterEndResult(oneRoundResult.oneCircleAfterResult)
	end

	if oneRoundResult:HasField("oneCircleBeforeDomainChangeResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushBeforeDomainResult(roundNum, oneRoundResult.oneCircleBeforeDomainChangeResult)
	end

	if oneRoundResult:HasField("oneCircleBeforeCreateDoppelgangerResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushBeforeCreateDoppelgangerResult(roundNum, oneRoundResult.oneCircleBeforeCreateDoppelgangerResult)
	end

	if oneRoundResult:HasField("oneCircleAfterCreateDoppelgangerResult") then
		local round = self:_getRound(roundNum, BattleRoundBase.Round)

		round:pushAfterCreateDoppelgangerResult(roundNum, oneRoundResult.oneCircleAfterCreateDoppelgangerResult)
	end
end

function BattleModel:_createStrickBackRound(roundNum, oneRoundCharacterResult)
	local targetCharacterResults = oneRoundCharacterResult.targetCharacterResults

	if targetCharacterResults then
		local cnt = #targetCharacterResults
		local strikeBackHps, strikeBackVigours = self:_getStrickBackRound(oneRoundCharacterResult)

		if strikeBackVigours or strikeBackHps then
			for i = 1, cnt do
				local result = targetCharacterResults[i]

				if result.isStrikeBack then
					result.isStrikeBack = false

					local characterResult = {}

					characterResult.caster = result.target

					local charactor = self:getCharactorById(result.target.targetTeamId, result.target.targetCharacterId)
					local petSkinCO = PetSkinConfig.instance:getPetSkinCfg(charactor.curFaceId)

					characterResult.skillId = self:isSameSkill(charactor.normalSkillId, petSkinCO.normalSkillId) and charactor.normalSkillId or petSkinCO.normalSkillId
					characterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
					characterResult.targetCharacterResults = {}
					characterResult.isStrikeBack = true

					self:addStrickBackTimes(result.target.targetTeamId, result.target.targetCharacterId, roundNum)

					local resultStrikeBack = {}

					resultStrikeBack.target = oneRoundCharacterResult.caster
					resultStrikeBack.isHit = true
					resultStrikeBack.isSkillEffected = true
					resultStrikeBack.targetNum = {}
					resultStrikeBack.targetNum.attackHps = {}

					if strikeBackHps then
						for k = 1, #strikeBackHps do
							table.insert(resultStrikeBack.targetNum.attackHps, strikeBackHps[k].power)
						end
					end

					resultStrikeBack.targetNum.attackVigours = {}

					if strikeBackVigours then
						for k = 1, #strikeBackVigours do
							table.insert(resultStrikeBack.targetNum.attackVigours, strikeBackVigours[k].power)
						end
					end

					characterResult.targetCharacterResults[1] = resultStrikeBack

					local seqId = self:_getStrickSequenceId(strikeBackHps, strikeBackVigours)

					self:_doSeperateNumResults(seqId, oneRoundCharacterResult, resultStrikeBack)

					local round = self:_getRound(roundNum, BattleRoundBase.Round)

					round:pushCharactorResult(characterResult, true)

					break
				end
			end
		end
	end
end

function BattleModel:_getStrickBackRound(oneRoundCharacterResult)
	local targetCharacterResults = oneRoundCharacterResult.targetCharacterResults

	if targetCharacterResults then
		local cnt = #targetCharacterResults
		local strikeBackHps, strikeBackVigours

		for i = 1, cnt do
			local result = targetCharacterResults[i]

			if result.target.targetTeamId == oneRoundCharacterResult.caster.targetTeamId and result.target.targetCharacterId == oneRoundCharacterResult.caster.targetCharacterId and result.targetNum then
				strikeBackHps = result.targetNum.strikeBackHps
				strikeBackVigours = result.targetNum.strikeBackVigours

				if result.targetNum.strikeBackHps or strikeBackVigours then
					break
				end
			end
		end

		return strikeBackHps, strikeBackVigours
	end
end

function BattleModel:_getStrickSequenceId(strikeBackHps, strikeBackVigours)
	local seqId = math.huge

	if strikeBackHps then
		for i = 1, #strikeBackHps do
			if seqId > strikeBackHps[i].sequenceId then
				seqId = strikeBackHps[i].sequenceId
			end
		end
	end

	if strikeBackVigours then
		for i = 1, #strikeBackVigours do
			if seqId > strikeBackVigours[i].sequenceId then
				seqId = strikeBackVigours[i].sequenceId
			end
		end
	end

	return seqId
end

function BattleModel:_doSeperateNumResults(seqId, oneRoundCharacterResult, resultStrikeBack)
	local targetCharacterResults = oneRoundCharacterResult.targetCharacterResults
	local cnt = #targetCharacterResults

	for i = 1, cnt do
		local resultCaster = targetCharacterResults[i]

		if resultCaster.target.targetTeamId == oneRoundCharacterResult.caster.targetTeamId and resultCaster.target.targetCharacterId == oneRoundCharacterResult.caster.targetCharacterId then
			if resultCaster.targetNum.afterBuffHps then
				local buffPre, buffAft = self:_seperateSequencesBySequenceId(resultCaster.targetNum.afterBuffHps, seqId)

				if buffAft then
					resultStrikeBack.targetNum.afterBuffHps = buffAft

					table.clear(resultCaster.targetNum.afterBuffHps)
				end

				if buffPre then
					self:_mergeSeperateSequences(resultCaster.targetNum.afterBuffHps, buffPre)
				end
			end

			if resultCaster.targetNum.afterBuffVigours then
				local buffPre, buffAft = self:_seperateSequencesBySequenceId(resultCaster.targetNum.afterBuffVigours, seqId)

				if buffAft then
					resultStrikeBack.targetNum.afterBuffVigours = buffAft

					table.clear(resultCaster.targetNum.afterBuffVigours)
				end

				if buffPre then
					self:_mergeSeperateSequences(resultCaster.targetNum.afterBuffVigours, buffPre)
				end
			end

			if resultCaster.targetNum.afterDisplayBuffs then
				local buffPre, buffAft = self:_seperateSequencesBySequenceId(resultCaster.targetNum.afterDisplayBuffs, seqId)

				if buffAft then
					resultStrikeBack.targetNum.afterDisplayBuffs = buffAft

					table.clear(resultCaster.targetNum.afterDisplayBuffs)
				end

				if buffPre then
					self:_mergeSeperateSequences(resultCaster.targetNum.afterDisplayBuffs, buffPre)
				end
			end

			self:_seperateResultObjectSummary(seqId, resultCaster.targetNum.resultObjectSummary, resultStrikeBack)
		end
	end
end

function BattleModel:_seperateResultObjectSummary(seqId, resultObjectSummary, resultStrikeBack)
	if not resultObjectSummary then
		return
	end

	if resultObjectSummary.attrTransform then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.attrTransform, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.attrTransform = aft

			table.clear(resultObjectSummary.attrTransform)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.attrTransform, pre)
		end
	end

	if resultObjectSummary.psychicSkillFightViewUpdate then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.psychicSkillFightViewUpdate, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.psychicSkillFightViewUpdate = aft

			table.clear(resultObjectSummary.psychicSkillFightViewUpdate)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.psychicSkillFightViewUpdate, pre)
		end
	end

	if resultObjectSummary.awakenChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.awakenChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.awakenChange = aft

			table.clear(resultObjectSummary.awakenChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.awakenChange, pre)
		end
	end

	if resultObjectSummary.summon then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.summon, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.summon = aft

			table.clear(resultObjectSummary.summon)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.summon, pre)
		end
	end

	if resultObjectSummary.transform then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.transform, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.transform = aft

			table.clear(resultObjectSummary.transform)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.transform, pre)
		end
	end

	if resultObjectSummary.maxHpUpdate then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.maxHpUpdate, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.maxHpUpdate = aft

			table.clear(resultObjectSummary.maxHpUpdate)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.maxHpUpdate, pre)
		end
	end

	if resultObjectSummary.btlItemChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.btlItemChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.btlItemChange = aft

			table.clear(resultObjectSummary.btlItemChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.btlItemChange, pre)
		end
	end

	if resultObjectSummary.playerBtlItemEnergyChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.playerBtlItemEnergyChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.playerBtlItemEnergyChange = aft

			table.clear(resultObjectSummary.playerBtlItemEnergyChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.playerBtlItemEnergyChange, pre)
		end
	end

	if resultObjectSummary.positionChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.positionChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.positionChange = aft

			table.clear(resultObjectSummary.positionChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.positionChange, pre)
		end
	end

	if resultObjectSummary.domainChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.domainChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.domainChange = aft

			table.clear(resultObjectSummary.domainChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.domainChange, pre)
		end
	end

	if resultObjectSummary.doppelgangerChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.doppelgangerChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.doppelgangerChange = aft

			table.clear(resultObjectSummary.doppelgangerChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.doppelgangerChange, pre)
		end
	end

	if resultObjectSummary.carriedChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.carriedChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.carriedChange = aft

			table.clear(resultObjectSummary.carriedChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.carriedChange, pre)
		end
	end

	if resultObjectSummary.heavenAwakenSummonChange then
		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.heavenAwakenSummonChange, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.heavenAwakenSummonChange = aft

			table.clear(resultObjectSummary.heavenAwakenSummonChange)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.heavenAwakenSummonChange, pre)
		end
	end

	if resultObjectSummary.genesisSkillFightViewUpdate then
		local maxSequenceId = 0
		local maxSequenceIdData

		for i, v in ipairs(resultObjectSummary.genesisSkillFightViewUpdate) do
			if maxSequenceId < v.sequenceId then
				maxSequenceId = v.sequenceId
				maxSequenceIdData = v
			end
		end

		table.clear(resultObjectSummary.genesisSkillFightViewUpdate)
		table.insert(resultObjectSummary.genesisSkillFightViewUpdate, maxSequenceIdData)

		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.genesisSkillFightViewUpdate, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.genesisSkillFightViewUpdate = aft

			table.clear(resultObjectSummary.genesisSkillFightViewUpdate)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.genesisSkillFightViewUpdate, pre)
		end
	end

	if resultObjectSummary.spiritInvocationSkillFightViewUpdate then
		local maxSequenceId = 0
		local maxSequenceIdData

		for i, v in ipairs(resultObjectSummary.spiritInvocationSkillFightViewUpdate) do
			if maxSequenceId < v.sequenceId then
				maxSequenceId = v.sequenceId
				maxSequenceIdData = v
			end
		end

		table.clear(resultObjectSummary.spiritInvocationSkillFightViewUpdate)
		table.insert(resultObjectSummary.spiritInvocationSkillFightViewUpdate, maxSequenceIdData)

		local pre, aft = self:_seperateSequencesBySequenceId(resultObjectSummary.spiritInvocationSkillFightViewUpdate, seqId)

		if aft then
			resultStrikeBack.targetNum.resultObjectSummary = resultStrikeBack.targetNum.resultObjectSummary or {}
			resultStrikeBack.targetNum.resultObjectSummary.spiritInvocationSkillFightViewUpdate = aft

			table.clear(resultObjectSummary.spiritInvocationSkillFightViewUpdate)
		end

		if pre then
			self:_mergeSeperateSequences(resultObjectSummary.spiritInvocationSkillFightViewUpdate, pre)
		end
	end
end

function BattleModel:_seperateSequencesBySequenceId(sequences, sequenceId)
	local pre, aft

	if sequences then
		for i = 1, #sequences do
			if sequenceId > sequences[i].sequenceId then
				pre = pre or {}

				table.insert(pre, sequences[i])
			else
				aft = aft or {}

				table.insert(aft, sequences[i])
			end
		end
	end

	return pre, aft
end

function BattleModel:_mergeSeperateSequences(t, vals)
	table.clear(t)

	for i = 1, #vals do
		table.insert(t, vals[i])
	end
end

function BattleModel:_ensureRoundBegin(roundNum)
	if self:getActionMode() ~= GameEnum.ActionModel.NoneAction then
		if roundNum > self.currRoundNum then
			self:_getRound(roundNum, BattleRoundBase.RoundBegin)
		end
	else
		self:_parseRoundStartRoundFromStory(roundNum)
		self:_getRound(roundNum, BattleRoundBase.RoundBegin)
	end
end

function BattleModel:_getRound(roundNum, roundType)
	local round = self:_findRound(roundNum, roundType)

	if round then
		return round
	end

	round = roundType == BattleRoundBase.RoundBefore and BattleRoundBefore.New() or roundType == BattleRoundBase.Round and BattleRound.New() or roundType == BattleRoundBase.RoundAfter and BattleRoundAfter.New() or roundType == BattleRoundBase.RoundBegin and BattleRoundBegin.New() or roundType == BattleRoundBase.RoundContinue and BattleRoundContinue.New() or roundType == BattleRoundBase.RoundPetIntrod and BattleRoundPetIntrod.New() or roundType == BattleRoundBase.RoundBattleStart and RoundBattleStart.New() or roundType == BattleRoundBase.RoundUseItem and BattleRoundUseItem.New() or roundType == BattleRoundBase.RoundPlayStory and BattleRoundPlayStory.New() or roundType == BattleRoundBase.RoundError and BattleRoundError.New() or roundType == BattleRoundBase.RoundBirth and BattleRoundBirth.New() or BattleRoundEnd.New()
	self.rounds = self.rounds or {}
	round.roundIndex = #self.rounds
	round.roundNum = roundNum
	round.roundType = roundType

	table.insert(self.rounds, round)

	return round
end

function BattleModel:_findRound(roundNum, roundType)
	if not self.rounds or roundNum == 0 then
		return nil
	end

	if roundType == BattleRoundBase.Round or roundType == BattleRoundBase.RoundUseItem then
		return nil
	end

	local cnt = #self.rounds

	for i = cnt, 1, -1 do
		local round = self.rounds[i]

		if round and round.roundNum == roundNum and round.roundType == roundType then
			return round
		end

		if round and roundNum > round.roundNum then
			return
		end
	end
end

function BattleModel:isCombatPlayback()
	return self.viewFightBtl
end

function BattleModel:getOtherHeadInfo()
	local rightTeamId = self:getTeamDirection(self:getEnemyPlayerTeam())
	local playerView = self:getPlayer(rightTeamId)
	local headInfo = {}

	headInfo.headIcon = playerView.headIcon or 0
	headInfo.headFrame = playerView.headFrame
	headInfo.vipLv = 0
	headInfo.playerLv = playerView.playerLv
	headInfo.headRaceId = BattleIconsMgr.instance:getIconRaceId()

	return headInfo
end

function BattleModel:getMyHeadInfo()
	local leftTeamId = self:getTeamDirection(self.myTeamId)
	local playerView = self:getPlayer(leftTeamId)
	local headInfo = {}

	headInfo.headIcon = playerView.headIcon
	headInfo.headFrame = playerView.headFrame
	headInfo.vipLv = 0
	headInfo.playerLv = playerView.playerLv

	if checknumber(headInfo.headIcon) > 0 then
		return headInfo
	end
end

function BattleModel:setOtherHeadInfo(info)
	return
end

function BattleModel:setEndDialogId(id)
	self._endDialogId = id
end

function BattleModel:getEndDialogId()
	local id = checknumber(self._endDialogId)

	if self._endDialogId and id > 0 then
		return id
	end
end

function BattleModel:isSameSkill(skillId1, skillId2)
	local num1 = checknumber(skillId1)
	local num2 = checknumber(skillId2)

	if num1 > 0 and num2 > 0 then
		return Mathf.Abs(num1 - num2) < BattleModel.SameSkillIdDifference
	else
		return false
	end
end

function BattleModel:_setPreviewParams(battleData)
	local previewOpeningEffectId = checknumber(BattleModel.instance.previewOpeningEffectId)

	if previewOpeningEffectId > 0 then
		for i, v in ipairs(battleData.originalStates.teams) do
			v.playerView.openingEffectId = previewOpeningEffectId
		end
	end

	local previewBattleBackgroundSkinId = checknumber(BattleModel.instance.previewBattleBackgroundSkinId)

	if previewBattleBackgroundSkinId > 0 then
		for i, v in ipairs(battleData.originalStates.teams) do
			v.playerView.battleBackgroundSkinId = previewBattleBackgroundSkinId
		end
	end
end

BattleModel.instance = BattleModel.New()

return BattleModel
