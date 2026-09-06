-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/controller/AoQiHeroController.lua

module("logic.extensions.aoqihero.controller.AoQiHeroController", package.seeall)

local AoQiHeroController = class("AoQiHeroController", BaseController)

function AoQiHeroController:ctor()
	return
end

function AoQiHeroController:onReset()
	self:setNewReport(false)
end

function AoQiHeroController:endBattle()
	UIStateManager.instance:popByName(ViewName.AoQiHeroBattleView)
	UIStateManager.instance:popByName(ViewName.AoQiHeroEndlessBtlView)
	UIStateManager.instance:popByName(ViewName.AoqiHeroPvPBtlView)
end

function AoQiHeroController:handlePM_AoQiHeroInfoRes(msg)
	AoQiHeroModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:handlePM_AoQiHeroUnlockPetRes(msg)
	AoQiHeroModel.instance:unLockPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroUnlockPetRes, msg.raceId)
end

function AoQiHeroController:handlePM_AoQiHeroUpgradePositionRes(msg)
	AoQiHeroModel.instance:upgradePosition(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:handlePM_AoQiHeroCardListRes(msg)
	AoQiHeroModel.instance:saveTeamInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:handlePM_AoQiHeroSetCardListRes(msg)
	AoQiHeroModel.instance:saveTeamInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:changeCurTeamPet(activityId, posId, petId)
	local curTeamInfo = AoQiHeroModel.instance:getCurPetTeams(activityId)

	if curTeamInfo and curTeamInfo[posId] then
		local curPetTeam = {}

		for i, v in ipairs(curTeamInfo) do
			table.insert(curPetTeam, v.petId)
		end

		local emptyIndex, existIndex

		for i, v in ipairs(curPetTeam) do
			if v == 0 then
				emptyIndex = i

				break
			end

			if v == petId then
				existIndex = i
			end
		end

		local changePetId = curPetTeam[posId]

		if existIndex then
			curPetTeam[existIndex] = changePetId
			curPetTeam[posId] = petId
		elseif emptyIndex and emptyIndex > 0 then
			curPetTeam[emptyIndex] = petId
		else
			curPetTeam[posId] = petId
		end

		local raceIds = {}

		for i, v in ipairs(curPetTeam) do
			if v ~= 0 then
				table.insert(raceIds, v)
			end
		end

		AoQiHeroAgent.instance:sendPM_AoQiHeroSetCardListReq(activityId, raceIds)
	end
end

function AoQiHeroController:sendPM_AoQiHeroNormalChallengeReq(activityId, stageId, raceIds, battleView)
	AoQiHeroAgent.instance:sendPM_AoQiHeroNormalChallengeReq(activityId, stageId, raceIds)

	self._tempBattleView = battleView
end

function AoQiHeroController:handlePM_AoQiHeroNormalChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroNormalChallengeRes)
end

function AoQiHeroController:handlePM_NotifyAoQiHeroBattleReadyStart(msg)
	AoQiHeroBattleModel.instance:setReadyBattleStartInfo(msg)
end

function AoQiHeroController:sendPM_AoQiHeroBattleStartReq()
	local actionId = AoQiHeroBattleModel.instance:getActionId() + 1
	local clientKey = AoQiHeroBattleModel.instance:setRandomClientKey()
	local attackTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)
	local raceIds = {}

	for i, v in ipairs(attackTeamMo.pos) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(v)

		table.insert(raceIds, petMo.configId)
	end

	local towerMo = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)
	local enemyCharacters = self:getEnemyCharacterViews()

	AoQiHeroAgent.instance:sendPM_AoQiHeroBattleStartReq(actionId, clientKey, raceIds, towerMo:getMaxHp(), towerMo.curHp, enemyCharacters)
end

function AoQiHeroController:getEnemyCharacterViews()
	local defenceTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)
	local enemyCharacters = {}

	for k, v in pairs(defenceTeamMo.pos) do
		local characterView = AoQiHeroExtension_pb.PM_AoQiHeroEnemyCharacterView()
		local enemyMo = AoQiHeroEntityMgr.instance:getPet(v)

		characterView.id = enemyMo.id
		characterView.raceId = enemyMo.configId
		characterView.posId = enemyMo.pos
		characterView.lv = enemyMo.level
		characterView.maxHp = enemyMo:getMaxHp()
		characterView.isEnemy = enemyMo.isEnemy

		table.insert(enemyCharacters, characterView)
	end

	return enemyCharacters
end

function AoQiHeroController:handlePM_AoQiHeroBattleStartRes(msg)
	AoQiHeroBattleModel.instance:handleBattleStart(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroBattleStartRes)
end

function AoQiHeroController:sendPM_AoQiHeroSyncBattleReq(activityId, roundIndex, isWin)
	local actionId = AoQiHeroBattleModel.instance:getActionId() + 1
	local encryptedKey = 0
	local clientKey = AoQiHeroBattleModel.instance:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(AoQiHeroBattleModel.instance:getServerKey(), clientKey)

	encryptedKey = actionId % 2 == 0 and encryptedKey + (actionId + serverKey) * 5381 or encryptedKey + (actionId + clientKey) * 31

	local roundMoList = AoQiHeroRoundMgr.instance:getBigRoundList(roundIndex)
	local oneCircle = AoQiHeroExtension_pb.PM_AoQiHeroOneCircleResult()
	local towerMo = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)

	oneCircle.leftHp = towerMo.curHp
	oneCircle.maxHp = towerMo:getMaxHp()

	local killedEnemyRaceIds = {}
	local enemyTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)

	for i, v in pairs(enemyTeamMo.pos) do
		local enemyMo = AoQiHeroEntityMgr.instance:getPet(v)

		if not AoQiHeroEntityMgr.instance:isPetSurvival(v) and enemyMo.isEnemy == true then
			table.insert(killedEnemyRaceIds, v)
		end
	end

	for i, v in ipairs(killedEnemyRaceIds) do
		oneCircle.killedEnemyRaceIds:append(v)
	end

	local myOneCircle = AoQiHeroExtension_pb.PM_AoQiHeroMyOneCircleResult()
	local enemyOneCircle = AoQiHeroExtension_pb.PM_AoQiHeroEnemyOneCircleResult()
	local curRoundIndex = 1
	local hasAttackTeamInfo = false
	local hasDefenceTeamInfo = false

	for i, v in ipairs(roundMoList) do
		if v.teamId == 0 then
			if v.time == AoQiHeroConst.TimeBigRoundStart then
				local circleResult = self:_createEmptyCircleResult(v)
				local characterResults = oneCircle.beforeOneCircleResults:add()

				characterResults:ParseFromString(circleResult:SerializeToString())
			elseif v.time == AoQiHeroConst.TimeBigRoundEnd then
				local circleResult = self:_createEmptyCircleResult(v)
				local characterResults = oneCircle.afterOneCircleResults:add()

				characterResults:ParseFromString(circleResult:SerializeToString())
			end
		elseif v.teamId == AoQiHeroConst.AttackTeam then
			if v.skillMo then
				hasAttackTeamInfo = true

				local circleResult = self:_createMyTeamCircleResult(v, curRoundIndex)
				local myResultView = myOneCircle.cardResults:add()

				myResultView:ParseFromString(circleResult:SerializeToString())

				curRoundIndex = curRoundIndex + 1
			end
		elseif v.teamId == AoQiHeroConst.DefenceTeam and v.skillMo then
			hasDefenceTeamInfo = true

			local circleResult = self:_createEnemyTeamCircleResult(v, curRoundIndex)
			local enemyResultView = enemyOneCircle.roundResults:add()

			enemyResultView:ParseFromString(circleResult:SerializeToString())

			curRoundIndex = curRoundIndex + 1
		end
	end

	if hasAttackTeamInfo == true then
		oneCircle.myOneCircle:ParseFromString(myOneCircle:SerializeToString())
	end

	if hasDefenceTeamInfo == true then
		oneCircle.enemyOneCircle:ParseFromString(enemyOneCircle:SerializeToString())
	end

	AoQiHeroAgent.instance:sendPM_AoQiHeroSyncBattleReq(actionId, encryptedKey, isWin, oneCircle)
end

function AoQiHeroController:_createMyTeamCircleResult(roundMo, roundIndex)
	local myResult = AoQiHeroExtension_pb.PM_AoQiHeroMyCircleOneCardResult()

	myResult.curRound = roundIndex

	local belongMo = AoQiHeroEntityMgr.instance:getPet(roundMo.belongUnit)

	myResult.raceId = belongMo.configId
	myResult.skillId = roundMo.skillMo.configId
	myResult.isUltimate = roundMo.skillMo.isSuper

	if roundMo.teamId == AoQiHeroConst.AttackTeam then
		myResult.attackPoint = roundMo.skillMo.targetPos
	end

	local reportMap = {}

	for i, reportMos in ipairs(roundMo.reportMosList) do
		for petId, reportMo in pairs(reportMos) do
			reportMap[petId] = reportMap[petId] or {}

			table.insert(reportMap[petId], reportMo)
		end
	end

	for petId, reportMos in pairs(reportMap) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
		local result = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacterResult()
		local target = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacter()

		target.isMySide = petMo.teamId == AoQiHeroConst.AttackTeam

		if petMo.teamId == AoQiHeroConst.DefenceTeam then
			target.targetCharacterId = petId
		end

		result.target:ParseFromString(target:SerializeToString())

		local sequenceId = 1

		result.isCritical = false

		local targetNumResult = AoQiHeroExtension_pb.PM_AoQiHeroNumResult()

		for i, reportMo in ipairs(reportMos) do
			for j, buffInfo in ipairs(reportMo.effectHpBuffIds) do
				local buffHpChange = AoQiHeroExtension_pb.PM_AoQiHeroBuffPower()

				buffHpChange.sequenceId = sequenceId
				buffHpChange.buffId = buffInfo.buffId
				buffHpChange.changeHp = buffInfo.changeHp
				buffHpChange.afterChangeHp = buffInfo.afterChangeHp
				buffHpChange.changeMaxHp = buffInfo.changeMaxHp
				buffHpChange.afterChangeMaxHp = buffInfo.afterChangeMaxHp
				sequenceId = sequenceId + 1

				local buffHpView = targetNumResult.beforeBuffHps:add()

				buffHpView:ParseFromString(buffHpChange:SerializeToString())
			end

			if reportMo.isCritical == true then
				result.isCritical = reportMo.isCritical
			end

			targetNumResult.attackHps = reportMo.attackHps
			targetNumResult.afterRoundHp = reportMo.afterRoundHp
		end

		result.targetNumResult:ParseFromString(targetNumResult:SerializeToString())

		local resultView = myResult.targetCharacterResults:add()

		resultView:ParseFromString(result:SerializeToString())
	end

	return myResult
end

function AoQiHeroController:_createEnemyTeamCircleResult(roundMo, roundIndex)
	local enemyResult = AoQiHeroExtension_pb.PM_AoQiHeroEnemyCircleOneRoundResult()

	enemyResult.curRound = roundIndex

	local enemyMo = AoQiHeroEntityMgr.instance:getPet(roundMo.belongUnit)
	local caster = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacter()

	caster.isMySide = enemyMo.teamId == AoQiHeroConst.AttackTeam

	if enemyMo.teamId == AoQiHeroConst.DefenceTeam then
		caster.targetCharacterId = roundMo.belongUnit
	end

	enemyResult.caster:ParseFromString(caster:SerializeToString())

	local reportMap = {}

	for i, reportMos in ipairs(roundMo.reportMosList) do
		for petId, reportMo in pairs(reportMos) do
			reportMap[petId] = reportMap[petId] or {}

			table.insert(reportMap[petId], reportMo)
		end
	end

	for petId, reportMos in pairs(reportMap) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
		local result = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacterResult()
		local target = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacter()

		target.isMySide = petMo.teamId == AoQiHeroConst.AttackTeam

		if petMo.teamId == AoQiHeroConst.DefenceTeam then
			target.targetCharacterId = petId
		end

		result.target:ParseFromString(target:SerializeToString())

		local sequenceId = 1

		result.isCritical = false

		local targetNumResult = AoQiHeroExtension_pb.PM_AoQiHeroNumResult()

		for i, reportMo in ipairs(reportMos) do
			for j, buffInfo in ipairs(reportMo.effectHpBuffIds) do
				local buffHpChange = AoQiHeroExtension_pb.PM_AoQiHeroBuffPower()

				buffHpChange.sequenceId = sequenceId
				buffHpChange.buffId = buffInfo.buffId
				buffHpChange.changeHp = buffInfo.changeHp
				buffHpChange.afterChangeHp = buffInfo.afterChangeHp
				buffHpChange.changeMaxHp = buffInfo.changeMaxHp
				buffHpChange.afterChangeMaxHp = buffInfo.afterChangeMaxHp
				sequenceId = sequenceId + 1

				local buffHpView = targetNumResult.beforeBuffHps:add()

				buffHpView:ParseFromString(buffHpChange:SerializeToString())
			end

			if reportMo.isCritical == true then
				result.isCritical = reportMo.isCritical
			end

			targetNumResult.attackHps = reportMo.attackHps
			targetNumResult.afterRoundHp = reportMo.afterRoundHp
		end

		result.targetNumResult:ParseFromString(targetNumResult:SerializeToString())

		local resultView = enemyResult.targetCharacterResults:add()

		resultView:ParseFromString(result:SerializeToString())
	end

	return enemyResult
end

function AoQiHeroController:_createEmptyCircleResult(roundMo)
	local oneCircle

	if roundMo.time == AoQiHeroConst.TimeBigRoundStart then
		oneCircle = AoQiHeroExtension_pb.PM_AoQiHeroBeforeOneCircleResult()
	elseif roundMo.time == AoQiHeroConst.TimeBigRoundEnd then
		oneCircle = AoQiHeroExtension_pb.PM_AoQiHeroAfterOneCircleResult()
	end

	local reportMap = {}

	for i, reporeMos in ipairs(roundMo.reportMosList) do
		for petId, reporeMo in pairs(reporeMos) do
			reportMap[petId] = reportMap[petId] or {}

			table.insert(reportMap[petId], reporeMo)
		end
	end

	for petId, reporeMos in pairs(reportMap) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
		local result = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacterResult()
		local target = AoQiHeroExtension_pb.PM_AoQiHeroTargetCharacter()

		target.isMySide = petMo.teamId == AoQiHeroConst.AttackTeam

		if petMo.teamId == AoQiHeroConst.DefenceTeam then
			target.targetCharacterId = petId
		end

		result.target:ParseFromString(target:SerializeToString())

		local sequenceId = 1

		result.isCritical = false

		local targetNumResult = AoQiHeroExtension_pb.PM_AoQiHeroNumResult()

		targetNumResult.afterRoundHp = petMo.curHp

		for i, reporeMo in ipairs(reporeMos) do
			for j, buffInfo in ipairs(reporeMo.effectHpBuffIds) do
				local buffHpChange = AoQiHeroExtension_pb.PM_AoQiHeroBuffPower()

				buffHpChange.sequenceId = sequenceId
				buffHpChange.buffId = buffInfo.buffId
				buffHpChange.changeHp = buffInfo.changeHp
				buffHpChange.afterChangeHp = buffInfo.afterChangeHp
				buffHpChange.changeMaxHp = buffInfo.changeMaxHp
				buffHpChange.afterChangeMaxHp = buffInfo.afterChangeMaxHp
				sequenceId = sequenceId + 1

				local buffHpView = targetNumResult.beforeBuffHps:add()

				buffHpView:ParseFromString(buffHpChange:SerializeToString())
			end
		end

		result.targetNumResult:ParseFromString(targetNumResult:SerializeToString())

		local resultView = oneCircle.targetCharacterResults:add()

		resultView:ParseFromString(result:SerializeToString())
	end

	return oneCircle
end

function AoQiHeroController:handlePM_AoQiHeroSyncBattleRes(msg)
	AoQiHeroBattleModel.instance:handleBattleSync(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroSyncBattleRes)

	if msg.cause and msg.cause < 0 and msg.isLegal == false then
		FloatWordMgr.instance:show(lang("验证不通过"))
		self:endBattle()
	end
end

function AoQiHeroController:handlePM_NotifyAoQiHeroNormalChallengeEndRes(msg)
	AoQiHeroModel.instance:saveTempChangeSetId(msg.changeSetId)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	if msg.isWin == true then
		AoQiHeroModel.instance:savePassStage(msg)
	end

	UIStateManager.instance:push(ViewName.AoqiHeroSettlementView, msg.activityId, msg.isWin, 1)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAoQiHeroNormalChallengeEndRes)
end

function AoQiHeroController:sendPM_AoQiHeroEndlessChallengeReq(activityId, stageId, raceIds, battleView)
	AoQiHeroAgent.instance:sendPM_AoQiHeroEndlessChallengeReq(activityId, stageId, raceIds)
end

function AoQiHeroController:handlePM_AoQiHeroEndlessChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroEndlessChallengeRes)
end

function AoQiHeroController:saveEndlessStageInfo(activityId, stageId, lastStageRound)
	AoQiHeroModel.instance:saveEndlessStageInfo(activityId, stageId, lastStageRound)
end

function AoQiHeroController:handlePM_NotifyAoQiHeroEndlessChallengeEndRes(msg)
	AoQiHeroBattleModel.instance:resetTowerInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAoQiHeroEndlessChallengeEndRes, msg.isWin)
end

function AoQiHeroController:handlePM_AoQiHeroEndlessGainPrizeRes(msg)
	AoQiHeroModel.instance:saveEndlessGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroEndlessGainPrizeRes)
end

function AoQiHeroController:handlePM_AoQiHeroRankInfoRes(msg)
	AoQiHeroModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:handlePM_NotifyAoQiHeroPvPMailFailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAoQiHeroPvPMailFailRes)
end

function AoQiHeroController:handlePM_NotifyAoQiHeroPvpGameStartRes(msg)
	AoQiHeroModel.instance:savePvpOpInfo(msg)
	UIStateManager.instance:push(ViewName.AoqiHeroMatchSucView, msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAoQiHeroPvpGameStartRes)
end

function AoQiHeroController:handlePM_AoQiHeroPvPCancelMatchRes()
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroPvPCancelMatchRes)
end

function AoQiHeroController:sendPM_AoQiHeroPvPFightStartReq(activityId, raceIds, battleView, formationView)
	AoQiHeroAgent.instance:sendPM_AoQiHeroPvPFightStartReq(activityId, raceIds)

	self._tempBattleView = battleView
	self._tempFormationView = formationView
end

function AoQiHeroController:handlePM_AoQiHeroPvPFightStartRes(msg)
	if self._tempFormationView then
		UIStateManager.instance:popByName(self._tempFormationView)
	end

	UIStateManager.instance:push(self._tempBattleView, msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroPvPFightStartRes)
end

function AoQiHeroController:handlePM_AoQiHeroPvPSetDefFormationRes(msg)
	AoQiHeroModel.instance:savePvpMapInfo(msg)
end

function AoQiHeroController:handlePM_AoQiHeroPvPLeaveRoomRes(msg)
	AoQiHeroModel.instance:clearPvpOpInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroPvPLeaveRoomRes)
end

function AoQiHeroController:handlePM_NotifyAoQiHeroPvPRoomEndRes(msg)
	local curPvpInfo = AoQiHeroModel.instance:getPvPOpInfo()

	if msg.state == 0 and curPvpInfo and curPvpInfo.matchTimeMillis == msg.matchTimeMillis then
		AoQiHeroModel.instance:saveTempPvpInfo(msg)
		AoQiHeroController.instance:endBattle()
		UIStateManager.instance:push(ViewName.AoqiHeroPvPResultView, msg.activityId)
	else
		self:setNewReport(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAoQiHeroPvPRoomEndRes)
end

function AoQiHeroController:isPassAllStage(activityId)
	local passStageId = AoQiHeroModel.instance:getPassStage(activityId)
	local normalStageCfgs = AoQiHeroConfig.instance:getNormalStageCfgs(activityId)
	local isAllPass = true

	for i, v in ipairs(normalStageCfgs) do
		if passStageId < v.stageId then
			isAllPass = false

			break
		end
	end

	return isAllPass
end

function AoQiHeroController:handlePM_AoQiHeroPvPRecordRes(msg)
	AoQiHeroModel.instance:saveRecordInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroPvPRecordRes)
end

function AoQiHeroController:handlePM_AoQiHeroGainDailyPrizeRes(msg)
	AoQiHeroModel.instance:saveHadGainTodayPrize(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AoQiHeroInfoRes)
end

function AoQiHeroController:setAutoStartPvPTime(time)
	self._tempTime = ServerTime.now() + time
end

function AoQiHeroController:getAutoStartPvPTime()
	return self._tempTime
end

function AoQiHeroController:isCanGetEndlessPrize(activityId)
	local prizeList = AoQiHeroConfig.instance:getEndlessPrizeCfg(activityId)
	local isCanGetPrize = false
	local maxStageId, minCircleNum = AoQiHeroModel.instance:getEndlessStageInfo(activityId)

	for i, v in ipairs(prizeList) do
		local isCanGet = maxStageId >= v.stageId
		local isGainPrize = AoQiHeroModel.instance:getEndlessGainPrize(activityId, v.prizeId)

		if isCanGet and not isGainPrize then
			isCanGetPrize = true
		end
	end

	return isCanGetPrize
end

function AoQiHeroController:setNewReport(bool)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_AOQI_HERO_NEW_REPORT, bool)

	self._newReportTips = bool
end

function AoQiHeroController:hasNewReport()
	return self._newReportTips
end

function AoQiHeroController:checkHasPoeCanLvUp(activityId)
	local curPosInfos = AoQiHeroModel.instance:getCurPetTeams(activityId)
	local isCanLvUp = false

	for i, v in pairs(curPosInfos) do
		isCanLvUp = self:checkPosCanLvUp(activityId, i) and v.petId ~= 0

		if isCanLvUp == true then
			break
		end
	end

	return isCanLvUp
end

function AoQiHeroController:checkPosCanLvUp(activityId, posId)
	local teamInfo = AoQiHeroModel.instance:getCurPetTeam(activityId, posId)

	if teamInfo then
		local nextLvCfg = AoQiHeroConfig.instance:getPosUpgrade(activityId, teamInfo.lv + 1)

		if nextLvCfg then
			local matType, matId, matNum = MaterialMgr.getMatParams(nextLvCfg.cost)

			return MaterialModel.instance:IsEnough(matType, matId, matNum)
		else
			return false
		end
	else
		return false
	end
end

AoQiHeroController.instance = AoQiHeroController.New()

return AoQiHeroController
