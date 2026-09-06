-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/controller/BattleController.lua

module("logic.extensions.battle.controller.BattleController", package.seeall)

local BattleController = class("BattleController", BaseController)

function BattleController:onInit()
	BattleController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.BattleStartBaseAnimFinish, self._onBattleStartBaseAnimFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleSpiritInvocationEnterFinish, self._onBattleSpiritInvocationEnterFinish, self)
	BattleStatisticsDataModel.instance:onInit()

	self._originSceneType = nil
	self._originSceneId = nil
	self._playerBirdgeSgate = nil
	self._playerUsersVars = nil
	self._originSceneBgm = nil
	self._stageLoaded = false
	self._forbidPause = 0
	self.battleMainview = nil
	self.battleStartEffFinished = nil
	self._battleStartAnimStage = nil
	self.preloadModelsOnLoadScene = true

	self:_resetContinuousFight()
end

function BattleController:onReset()
	BattleItemController.instance:onReset()
	BattlePsychicModel.instance:onReset()
	BattleGenesisModel.instance:onReset()
	BattleAwakeChangeSkillModel.instance:onReset()
	BattleSpiritInvocationModel.instance:onReset()
	BattleFacade.instance:onBattleEndReset()
	BattleFacade.instance:clearStatus()
	BattleDoaminSkillMgr.instance:clear()
	self:clearStartBattleCgRes()

	self._originSceneType = nil
	self.battleStartEffFinished = nil
	self._battleStartAnimStage = nil
	SceneMgr.instance.isGogingToEnterBattleScene = nil
	self._originSceneId = nil
	self._originSceneBgm = nil
	self._stageLoaded = false
	self.battleMainview = nil
	self._playerBirdgeSgate = nil
	self._playerUsersVars = nil
	self._forbidPause = 0

	BattleFacade.instance:registerResultHandler(nil, nil)
	self:_resetContinuousFight()
end

function BattleController:_onBattleStartBaseAnimFinish()
	if self._battleStartAnimStage == "spiritInvocationEnter" then
		return
	end

	self._battleStartAnimStage = "spiritInvocationEnter"

	GlobalDispatcher:dispatch(GlobalNotify.PlayBattleSpiritInvocationEnter)
end

function BattleController:_onBattleSpiritInvocationEnterFinish()
	if self._battleStartAnimStage ~= "spiritInvocationEnter" then
		return
	end

	self._battleStartAnimStage = "finished"
	self.battleStartEffFinished = true
end

function BattleController:updateHeadIconDir(go, raceId)
	if raceId == 10381 then
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
	else
		Framework.TransformUtil.SetLocalScale(go.transform, -1, 1, 1)
	end
end

function BattleController:startBattleCg()
	BattleModel.instance.isPlayingCgBattle = true

	self:startLocalBattle(BattleModel.CgBattleStartPath, BattleModel.CgBattleRoundPath, BattleModel.CgBattleResultPath)
end

function BattleController:startLocalBattle(startPath, roundPath, resultPath)
	SceneMgr.instance.isGogingToEnterBattleScene = true

	self:clearStartBattleCgRes()

	self._startPath = startPath
	self._roundPath = roundPath
	self._resultPath = resultPath
	self._battleRecordLoader = MultiResLoader.New()

	self._battleRecordLoader:addResPath(startPath, true, ResType.Bytes)
	self._battleRecordLoader:addResPath(roundPath, true, ResType.Bytes)
	self._battleRecordLoader:addResPath(resultPath, true, ResType.Bytes)
	self._battleRecordLoader:load(self._onBattleRecordLoaded, nil, self)
end

function BattleController:_onBattleRecordLoaded()
	local battleStartRes = rescache:GetResourceNoLoadIfNotExists(self._startPath)
	local battleRoundRes = rescache:GetResourceNoLoadIfNotExists(self._roundPath)
	local battleResultRes = rescache:GetResourceNoLoadIfNotExists(self._resultPath)

	if self:_isBattleLocalValid(battleStartRes) and self:_isBattleLocalValid(battleRoundRes) and self:_isBattleLocalValid(battleResultRes) then
		local btlStart = BattleExtension_pb.PM_BtlStartRes()
		local btlRound = BattlePublicDef_pb.PM_OneFightResult()
		local btlResult = BattleExtension_pb.PM_BtlEndRes()

		btlStart:ParseFromString(battleStartRes:GetLuaByteBuffer())
		btlRound:ParseFromString(battleRoundRes:GetLuaByteBuffer())
		btlResult:ParseFromString(battleResultRes:GetLuaByteBuffer())

		local battleResult = {}

		battleResult.originalStates = btlStart.originalStates
		battleResult.oneFightResult = btlRound
		battleResult.originalWinner = btlResult.originalWinner
		battleResult.activityWinner = btlResult.activityWinner
		battleResult.teamAStatistics = btlResult.teamAStatistics
		battleResult.teamBStatistics = btlResult.teamBStatistics
		battleResult.teamATotalDamage = btlResult.teamATotalDamage
		battleResult.teamBTotalDamage = btlResult.teamBTotalDamage
		SceneMgr.instance.isGogingToEnterBattleScene = nil

		BattleFacade.instance:onViewUserFightMonsterBtlResult(battleResult)
	else
		self:clearStartBattleCgRes()

		SceneMgr.instance.isGogingToEnterBattleScene = nil

		if BattleModel.instance.isPlayingCgBattle then
			BattleModel.instance.isPlayingCgBattle = nil

			SceneMgr.instance:enter(SceneType.CreateRole, sceneId, 0, 0)
		end
	end
end

function BattleController:_isBattleLocalValid(battleRes)
	local var_9_0

	if battleRes then
		::label_9_0::

		var_9_0 = battleRes.IsSuccess and battleRes:GetLuaByteBuffer() ~= nil
	end

	return var_9_0
end

function BattleController:isGoingToBattleCg()
	return BattleModel.instance.isPlayingCgBattle
end

function BattleController:clearStartBattleCgRes()
	if self._battleRecordLoader then
		GameUtil.unloadMultiResLoaderResource(self._battleRecordLoader)

		self._battleRecordLoader = nil
	end
end

function BattleController:onRetreat()
	if BattleModel.instance.skipType or BattleModel.instance:hasReceivedResult() then
		return
	end

	BattleModel.instance.skipType = BattleModel.Skip_Retreat

	BattleModel.instance:onRetreatRound(true)
end

function BattleController:onRetreatPass()
	if BattleModel.instance.skipType or BattleModel.instance:hasReceivedResult() then
		return
	end

	BattleModel.instance.skipType = BattleModel.Skip_Pass

	BattleModel.instance:onRetreatRound(false)
end

function BattleController:onSkipBattle()
	if BattleModel.instance.skipType or BattleModel.instance:hasReceivedResult() then
		return
	end

	BattleModel.instance.skipType = BattleModel.Skip_Pass

	BattleModel.instance:onSkipBattle()
end

function BattleController:updateUnitBattleInfoType()
	local infoType = BattleModel.instance:getBtlInfoType()
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	if not units then
		return
	end

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:updateBattleInfoType(infoType)
		end
	end
end

function BattleController:getOriginSceneId()
	return self._originSceneId
end

function BattleController:isBattling()
	return BattleModel.instance.isRunning
end

function BattleController:forbidPause(forbid)
	self._forbidPause = forbid and self._forbidPause + 1 or self._forbidPause - 1
end

function BattleController:isForbidPause()
	return self._forbidPause > 0
end

function BattleController:resetForbidPause()
	self._forbidPause = 0
end

function BattleController:setBattlePause(pause)
	BattleModel.instance.pauseBattle = pause

	local battleScene = SceneMgr.instance:getCurScene()

	if battleScene and battleScene.pauseBattle then
		battleScene:pauseBattle(pause)
	end
end

function BattleController:pauseAll(pause)
	if BattleModel.instance.pauseBattle == pause then
		return
	end

	BattleModel.instance.pauseBattle = pause

	local battleScene = SceneMgr.instance:getCurScene()

	if battleScene and battleScene.pauseBattle then
		battleScene:pauseBattle(pause)
	end

	SoloAudioMgr.instance:pause(pause)
end

function BattleController:getLastBattleResult()
	return BattleModel.instance.battleResult
end

function BattleController:onBattleStart(battleData)
	BattleDoaminSkillMgr.instance:clear()

	local battleModel = BattleModel.instance

	if battleModel.isEndlessBattle then
		EndlessBattleModel.instance:pushBattleStartData(battleData)
	end

	BattlePsychicModel.instance:onBattleStart(battleData)
	BattleAwakeChangeSkillModel.instance:onBattleStart(battleData)
	BattleGenesisModel.instance:onBattleStart(battleData)
	BattleSpiritInvocationModel.instance:onBattleStart(battleData)

	if battleModel.isEndlessBattle and EndlessBattleController.instance:getDefendCount() >= 1 then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	elseif BattleModel.instance.isWTower and WTowerController.instance:isCanNextBattle() then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	elseif battleModel.isRoguelikeBattle and RoguelikeController.instance:isCanNextBattle() then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	elseif battleModel.UltimateWarTowerStage and UltimateWarController.instance:isCanNextBattleInTowerStage() then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	elseif BattleModel.instance.SixArtChallengeId == SixartdaoguanController.ChallengeType.Defense and SixartdaoguanController.instance:isCanNextBattle() then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	elseif battleModel.instance.isContinuousBattle then
		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)

		local battleScene = SceneMgr.instance:getCurScene()

		battleScene:onEnterNextBattle()
	else
		if SceneMgr.instance.isGogingToEnterBattleScene then
			return
		end

		self.battleStartEffFinished = nil

		battleModel:onBattleStartData(battleData)
		BattleItemsModel.instance:onBattleStartData(battleData)
		self:onEnterBattleScene()
		GlobalDispatcher:dispatch(GlobalNotify.BattleEnter)
	end
end

function BattleController:onBattleContinue(btlResult)
	local battleModel = BattleModel.instance

	self.battleStartEffFinished = nil

	battleModel:viewUserFightMonsterBtlResult(btlResult, false)
	BattlePsychicModel.instance:onBattleStart(btlResult)
	BattleAwakeChangeSkillModel.instance:onBattleStart(btlResult)
	BattleSpiritInvocationModel.instance:onBattleStart(btlResult)

	local battleScene = SceneMgr.instance:getCurScene()

	battleScene:onEnterNextBattle()
end

function BattleController:onEnterBattleScene()
	SceneMgr.instance.isGogingToEnterBattleScene = true

	self:resetForbidPause()

	local curScene = SceneMgr.instance:getCurScene()

	if curScene then
		self._originSceneType = curScene:getSceneType()
		self._originSceneId = curScene:getSceneId()
		self._originSceneBgm = curScene.bgm and curScene.bgm:getBgmId() or 0
	end

	if SceneMainPlayer.instance then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		self._playerUsersVars = nil

		if mainPlayer then
			self._playerBirdgeSgate = mainPlayer:isUnderBridge()
		end
	end

	if self:isGoingToBattleCg() then
		SDKManager.sensorsTrackLoadingOnce("进入开场战斗", "stl_start_cg_battle")
	end

	SceneMgr.instance:enter(SceneType.Battle, SceneConfig.BattleSceneId)
end

function BattleController:getOriginSceneBgm()
	return self._originSceneBgm
end

function BattleController:startBattle()
	BattleModel.instance:startBattle()

	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	battleScene:startBattle()

	local key = BattleModel.instance:getBulletKey()

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.InBattle)
	BulletScreenModel.instance:setKey(key)
	BulletScreenController.instance:tryOpenView()
	self:_openEvaluateView()
	self:_openBattleVerifyView()
	GlobalDispatcher:addListener(GlobalNotify.ManualSetBattlePetStatus, self._onManualSetPetAttrs, self)
end

function BattleController:_onManualSetPetAttrs(arr)
	local attrType = arr[1]
	local operand = arr[2]
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	if not units then
		return
	end

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if attrType == "HP" then
				local curHp = v2.attrs:getCurHp()

				curHp = curHp + operand

				v2.attrs:setCurHp(curHp)
			elseif attrType == "VIGOUR" then
				local curVigour = v2.attrs:getCurVigour()

				curVigour = curVigour + operand

				v2.attrs:setCurVigour(curVigour)
			end
		end
	end
end

function BattleController:endBattle()
	BattleSettlementController.instance:clearElements()
	GlobalDispatcher:removeListener(GlobalNotify.ManualSetBattlePetStatus, self._onManualSetPetAttrs, self)
	self:clearStartBattleCgRes()
	BattleItemsModel.instance:clearItemSprites()
	BattleItemsModel.instance:clearItemWidgets()

	SceneMgr.instance.isGogingToEnterBattleScene = nil

	GlobalDispatcher:dispatch(GlobalNotify.BattleResult, self:getLastBattleResult())
	MissionModel.instance:onReset()
	BattleSettlementModel.instance:onReset()
	BattlePsychicModel.instance:onReset()
	BattleGenesisModel.instance:onReset()
	BattleSpiritInvocationModel.instance:onReset()
	BattleAwakeChangeSkillModel.instance:onReset()
	BattleModel.instance:endBattle()
	BattleStatisticsDataModel.instance:clearStatics()
	BattleFacade.instance:onBattleEndReset()

	local isPlayingCgBattle = BattleModel.instance.isPlayingCgBattle

	BattleModel.instance.isPlayingCgBattle = nil
	BattleModel.instance.isPlayingOnlyLocalBattle = nil

	local battleScene = SceneMgr.instance:getCurScene()

	if battleScene:getSceneType() ~= SceneType.Battle then
		return
	end

	battleScene:endBattle()
	self:_closeEvaluateView()
	self:_closeBattleVerifyView()

	if self._originSceneType and self._originSceneId then
		local x, y = SceneMainPlayer.instance:getMainPlayer().transform:getPos()

		SceneMgr.instance:enter(self._originSceneType, self._originSceneId, x, y, self._playerBirdgeSgate, self._playerUsersVars)
	elseif isPlayingCgBattle then
		SDKManager.sensorsTrackLoadingOnce("结束开场战斗", "stl_end_cg_battle")
		SceneMgr.instance:enter(SceneType.CreateRole, sceneId, 0, 0)
	end

	BattleSkipTimeMgr.instance:setCurrFightConfig(nil)
	GlobalDispatcher:dispatch(GlobalNotify.BattleEnd)
end

function BattleController:onReciveBattleEnd(rData)
	local battleModel = BattleModel.instance

	battleModel:calculateBattleResult(rData)
	battleModel:finishBattle()

	if battleModel.isEndlessBattle == true and battleModel:isSelfRealWin() and EndlessBattleController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.isSeniorArena == true and not battleModel.isPassing and SeniorArenaController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.isMangTower3v3 == true and not battleModel.isPassing and MangTowerController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.Infinitefuture == true and not battleModel.isPassing and InfinitefutureController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.VillainPet == true and VillaintrialController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.SeasonPVEBoss == true and SeasonPVEBossController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.HolyStripeCopyFight and not battleModel.isPassing and HolyStripeCopyController.instance:tryNextBattle(battleModel.HolyStripeCopyFight) then
		-- block empty
	elseif battleModel.StarGodChallenge and not battleModel.isPassing and StarGodChallengeController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.PeakTournamentFight and PeakTournamentController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.StartGodStatuesWar and not battleModel.isPassing and GodStatuesWarController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.isRoguelikeBattle and RoguelikeController.instance:tryNextBattle() then
		-- block empty
	elseif battleModel.UltimateWarTowerStage and UltimateWarController.instance:tryNextBattleInTowerStage() then
		-- block empty
	elseif battleModel.SixArtChallengeId == SixartdaoguanController.ChallengeType.Defense and SixartdaoguanController.instance:tryNextBattle() then
		-- block empty
	elseif self:tryAutoPlayNextBattle() then
		-- block empty
	elseif battleModel:isSelfRealWin() and battleModel:getEndDialogId() then
		UIStateManager.instance:push(ViewName.DialogueView, battleModel:getEndDialogId(), nil, function()
			self:_enterBattleResult()
		end)
		battleModel:setEndDialogId()
	else
		self:_enterBattleResult()
	end
end

function BattleController:_enterBattleResult()
	UnityEngine.Time.timeScale = 1

	CommonTipsMgr.instance:closeAllTips()
	self:_closeAllViewsWithOutBattle()

	if BattleModel.instance:isCombatPlayback() then
		if BattleModel.instance.isPlayingCgBattle or BattleModel.instance.isPlayingOnlyLocalBattle then
			self:endBattle()
		else
			local title = "提示"
			local content = string.format("战斗回放的精彩表现已经播放完啦！")
			local btnTxt = "知道了"

			TipsFacade.instance:openTipWindowValidX(title, content, function()
				self:endBattle()
			end, btnTxt)
		end

		BattleFacade.instance:registerResultHandler()
	elseif BattleModel.instance.isOverRoundLimit and not BattleModel.instance.isherotrial and BattleModel.instance.skipType ~= BattleModel.Skip_Retreat then
		local title = "提示"
		local content = string.format("出手次数超过上限，战斗结束！")
		local btnTxt = "确定"
		local func

		TipsFacade.instance:openTipWindowNoX(title, content, BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.ResCopy and function()
			self:_onEnterResCopyResult()
			BattleFacade.instance:registerResultHandler()
		end or function()
			self:_enterResultView()
			BattleFacade.instance:registerResultHandler()
		end, btnTxt)
	else
		self:_enterResultView()
		BattleFacade.instance:registerResultHandler()
	end

	HardwareQuality._adaptLRSide()
end

function BattleController:_enterResultView()
	print("curMissionType = " .. tostring(BattleModel.instance.curMissionType))

	if BattleModel.instance.summonTowerGridId then
		self:endBattle()
	elseif BattleModel.instance.isEndlessBattle == true then
		self:_enterEndlessBattleResult()
	elseif BattleModel.instance.isSeniorArena == true then
		self:_enterSeniorBattleResult()
	elseif BattleModel.instance.isMangTower3v3 == true then
		MangTowerController.instance:openBattleResultView()
	elseif BattleModel.instance.Infinitefuture == true then
		InfinitefutureController.instance:openBattleResultView()
	elseif BattleModel.instance.VillainPet == true then
		VillaintrialController.instance:openBattleResultView()
	elseif BattleModel.instance.isRankingRace or BattleModel.instance.eveA and BattleModel.instance.eveB or BattleModel.instance.skipType == BattleModel.Skip_Retreat then
		self:endBattle()
	elseif BattleModel.instance.isFamilyBoss then
		if not BattleFacade.instance:invokeResultHandler() then
			ViewMgr.instance:open(ViewName.FamilybossbattlesuccessView)
		end
	elseif checknumber(BattleModel.instance.shareBossId) > 0 then
		ViewMgr.instance:open(ViewName.ShareBattleResult)
	elseif BattleModel.instance.isherotrial then
		HerotrialController.instance:openBattleResultView()
	elseif BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.ResCopy then
		self:_onEnterResCopyResult()
	elseif BattleModel.instance.isTimeLimitedChallenge == true then
		self:_enterTLCBattleResult()
	elseif BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.QieCuo and not BattleModel.instance.isPkBattlePVE then
		self:endBattle()
	elseif BattleModel.instance.isAnheimm then
		ViewMgr.instance:open(ViewName.AnheimmresultView)
	elseif BattleModel.instance.nianNianChall then
		ViewMgr.instance:open(ViewName.NianNianChallResultView)
	elseif BattleModel.instance.perfectRuleModeChanllengeId then
		PerfectRuleModeController.instance:openResultView(BattleModel.instance.perfectRuleModeChanllengeId)
	elseif BattleModel.instance.isSenluo then
		ViewMgr.instance:open(ViewName.SenluowanxiangresultView)
	elseif BattleModel.instance.familyTeamPlayType then
		self:openSettlementView()
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.LIGHTKING then
		ViewMgr.instance:open(ViewName.LightKingResultView)
	elseif BattleModel.instance.isFBBBattle then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif BattleModel.instance.isDragonTrail then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif BattleModel.instance.goddesGloryChallengeId then
		self:_enterGoddesGloryResultView()
	elseif BattleModel.instance.HolyStripeCopyFight then
		self:_enterHolyStripeCopySoloResultView()
	elseif BattleModel.instance.StarGodChallenge then
		StarGodChallengeController.instance:openBattleResultView()
	elseif BattleModel.instance.isGodARuiShiBossFight then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif BattleModel.instance.PeakTournamentFight then
		PeakTournamentController.instance:openBattleResultViewAsPT()
	elseif BattleModel.instance.isXiuMumChallenge then
		XiuMumChallengeModel.instance:setBattleSettlementCI()
		self:openSettlementView()
	elseif BattleModel.instance.isGuardCityChallenge == true then
		ViewMgr.instance:open(ViewName.GuardCityBattleResultView)
	elseif BattleModel.instance.isLotusBattle then
		LotusbattleController.instance:enterResultView()
	elseif BattleModel.instance.isAutoChessFight then
		AutochessController.instance:enterResultView()
	elseif BattleModel.instance.isHolyWaterOrder then
		self:_enterHolyWaterOrderResultView()
	elseif BattleModel.instance.kingJiChallengeType == GameEnum.KingjiChallengeType.Shizhe then
		BattleController.instance:endBattle()
	elseif BattleModel.instance.isDivineNuoYaClg then
		self:_enterDivineWaterOrderResultView()
	elseif BattleModel.instance.WuDiClgNor then
		WuDiClgController.instance:enterWuDiClgNorResultView()
	elseif BattleModel.instance.isDestroyEvil then
		DestroyEvilController.instance:openBattleResultView()
	elseif BattleModel.instance.isDragonXiuerBoss then
		DragonXiuerController.instance:openBattleResultView()
	elseif BattleModel.instance.DivineXiuErClgNor then
		local params = BattleModel.instance.DivineXiuErClgNorOfParams

		DivineXiuErClgController.instance:enterDivineXiuErClgNorResultView(unpack(params))
	elseif BattleModel.instance.DivineXiuErClgExt then
		local params = BattleModel.instance.DivineXiuErClgExtOfParams

		DivineXiuErClgController.instance:enterDivineXiuErClgExtResultView(unpack(params))
	elseif BattleModel.instance.StartGodStatuesWarNest then
		if not BattleModel.instance.StartGodStatuesWarNestParams then
			local params = {}

			GodStatuesWarController.instance:enterGodStatuesWarFightNestResultView(unpack(params))
		end
	elseif BattleModel.instance.FarnasClgNor then
		if FarnasModel.instance.isNormalFightWin then
			FarnasController.instance:enterClgNorResultView()
		else
			self:openSettlementView()
		end

		FarnasModel.instance.isNormalFightWin = false
	elseif BattleModel.instance.FarnasClgExt then
		FarnasController.instance:enterClgExtResultView()
	elseif BattleModel.instance.FamilyHoudingClg then
		FamilyHoudingClgController.instance:openBattleResultViewOfFhc()
	elseif BattleModel.instance.isXiaYin then
		XiaYinController.instance:openResultView(BattleModel.instance.xiaYinActivityId, BattleModel.instance.xiaYinCreepsMasterId)
	elseif BattleModel.instance.isNightFeastBoss then
		self:_openNightFeastBossView()
	elseif BattleModel.instance.StartGodStatuesWar then
		GodStatuesWarController.instance:openBattleResultViewAsGsw()
	elseif BattleModel.instance.DragonKingARuiShi then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	else
		self:openSettlementView()
	end
end

function BattleController:_enterGoddesGloryResultView()
	local eventCo = GoddessGloryConfig.instance:getEventCo(BattleModel.instance.goddesGloryEventId)

	if eventCo and eventCo.type == GoddessGloryEvtType.Challenge and eventCo.isBossEvent then
		local title = "提示"
		local content = string.format("本次总共造成%s伤害", GoddessGloryModel.instance:getBossBloodLossHp())
		local btnTxt = "知道了"

		TipsFacade.instance:openTipWindowValidX(title, content, function()
			self:endBattle()
		end, btnTxt)

		return
	end

	local monsterCo = GoddessGloryConfig.instance:getMonsterCo(eventCo.creepsMasterId)

	if BattleModel.instance.battleResult ~= GameEnum.BattleResult.ExpSuccess and BattleModel.instance.battleResult ~= GameEnum.BattleResult.Success and monsterCo and checknumber(monsterCo.winId) > 0 then
		local winCo = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(monsterCo.winId))

		if winCo.type == GameEnum.BattleWinnerOpType.DamageTotal or winCo.type == GameEnum.BattleWinnerOpType.DamageTotalRange then
			local title = "提示"
			local content = string.format("很遗憾，挑战失败，本次总共造成%s伤害", BattleModel.instance:getTotalHurt(GameEnum.TargetType.Friend))
			local btnTxt = "关闭"

			TipsFacade.instance:openTipWindowValidX(title, content, function()
				self:endBattle()
			end, btnTxt)
		else
			self:openSettlementView()
		end
	else
		self:openSettlementView()
	end
end

function BattleController:_enterEndlessBattleResult()
	ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
end

function BattleController:_enterSeniorBattleResult()
	SeniorArenaController.instance:openBattleResultView()
end

function BattleController:_enterHolyWaterOrderResultView()
	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		HolyWaterOrderController.instance:openBattleResultView()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall or BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end
end

function BattleController:_enterDivineWaterOrderResultView()
	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		DivineNuoYaChallengeController.instance:openBattleResultView()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall or BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end
end

function BattleController:_openNightFeastBossView()
	local isBoss = BattleModel.instance.nightFeastBossType == 2

	if not isBoss then
		if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
			NightFeastBossController.instance:openResultView(BattleModel.instance.nightFeastBossActivityId)
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall or BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		self:openSettlementView()
	end
end

function BattleController:_enterTLCBattleResult()
	UIStateManager.instance:open(ViewName.TLCBattleResultView)
end

function BattleController:_closeAllViewsWithOutBattle()
	UIStateManager.instance:clear(false)

	local views = ViewMgr.instance._views

	for k, v in pairs(views) do
		if k ~= ViewName.battle and k ~= "popupwindow" and ViewMgr.instance:isOpen(k) then
			ViewMgr.instance:close(k)
		end
	end

	if TipsFacade.popupWindowSource == ViewName.Battle then
		ViewMgr.instance:close("popupwindow")
	end
end

function BattleController:openSettlementView()
	if not BattleFacade.instance:invokeResultHandler() then
		if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		end
	end
end

function BattleController:_onEnterResCopyResult()
	local score, rewardStr = MaterialChallengeModel.instance:getScore()

	self:openSettlementView()
end

function BattleController:pass()
	local battleModel = BattleModel.instance
	local bettleResult = battleModel.bettleResultData

	if bettleResult then
		local battid = checknumber(bettleResult.battleId)
		local winner = checknumber(bettleResult.originalWinner)

		if battid ~= battleModel:getBattleId() then
			printBattleError("战斗ID 不对应")
		end

		local battleScene = SceneMgr.instance:getCurScene()

		if battleScene and battleScene.passBattle then
			battleModel.isPassing = true

			battleScene:passBattle()
		end
	end
end

function BattleController:retreat()
	local battleScene = SceneMgr.instance:getCurScene()

	if battleScene and battleScene.retreatBattle then
		battleScene:retreatBattle()
	end
end

function BattleController:onContinueFightRes()
	local skipType = BattleModel.instance.skipType

	if skipType then
		if skipType == BattleModel.Skip_Pass then
			self:pass()
		else
			self:retreat()
		end
	else
		local battleScene = SceneMgr.instance:getCurScene()

		if battleScene and battleScene.onContinueFightRes then
			battleScene:onContinueFightRes()
		end
	end
end

function BattleController:viewUserFightMonsterBtlResultWithList(btlResultList, doContinuousNexCallBack, isResord, entry)
	self._btlResultList = btlResultList
	self._doContinuousNexCallBack = doContinuousNexCallBack
	self._curContinuousIdx = 1

	local btlResult = self._btlResultList[self._curContinuousIdx]

	if btlResult == nil then
		if enableDebug then
			printError(">>>>>>>>> 别玩我啊 ~ 传了个空列表 ")
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		self:_resetContinuousFight()
	else
		GameUtil.callBack(self._doContinuousNexCallBack, self._curContinuousIdx)
		self:viewUserFightMonsterBtlResult(btlResult, checkbool(isResord), entry)
	end
end

function BattleController:_resetContinuousFight()
	self._btlResultList = nil
	self._curContinuousIdx = nil
	self._doContinuousNexCallBack = nil
end

function BattleController:tryAutoPlayNextBattle()
	if self._btlResultList == nil or #self._btlResultList == 0 then
		self:_resetContinuousFight()

		return false
	end

	self._curContinuousIdx = self._curContinuousIdx + 1

	local btlResult = self._btlResultList[self._curContinuousIdx]

	if btlResult == nil then
		self:_resetContinuousFight()

		return false
	end

	GameUtil.callBack(self._doContinuousNexCallBack, self._curContinuousIdx)
	BattleController.instance:onBattleContinue(btlResult)

	return true
end

function BattleController:viewUserFightMonsterBtlResult(btlresult, isResord, entry)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	self.battleStartEffFinished = nil

	BattleModel.instance:viewUserFightMonsterBtlResult(btlresult, isResord)
	BattlePsychicModel.instance:onBattleStart(btlresult)
	BattleSpiritInvocationModel.instance:onBattleStart(btlresult)
	BattleAwakeChangeSkillModel.instance:onBattleStart(btlresult)
	BattleItemsModel.instance:viewUserFightMonsterBtlResult(btlresult)

	BattleModel.instance.recordEntry = entry

	self:onEnterBattleScene()
	GlobalDispatcher:dispatch(GlobalNotify.BattleEnter)
end

function BattleController:viewUserShareTaskFightMonsterBtlResult(btlresult, isResord, entry)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	self.battleStartEffFinished = nil

	BattleModel.instance:viewUserShareTaskFightMonsterBtlResult(btlresult, isResord)
	BattlePsychicModel.instance:onBattleStart(btlresult)
	BattleSpiritInvocationModel.instance:onBattleStart(btlresult)
	BattleAwakeChangeSkillModel.instance:onBattleStart(btlresult)
	BattleItemsModel.instance:viewUserFightMonsterBtlResult(btlresult)

	BattleModel.instance.recordEntry = entry

	self:onEnterBattleScene()
	GlobalDispatcher:dispatch(GlobalNotify.BattleEnter)
end

function BattleController:_openEvaluateView()
	MaterialChallengeController.instance:openEvaluateView()
end

function BattleController:_closeEvaluateView()
	MaterialChallengeController.instance:closeEvaluateView()
end

function BattleController:_openBattleVerifyView()
	local settlementType = BattleSettlementModel.instance:getType()

	if settlementType == BattleSettlementModel.Enum.Legend then
		ViewMgr.instance:open(ViewName.BattleVerifyView, settlementType)
	end
end

function BattleController:_closeBattleVerifyView()
	if ViewMgr.instance:isOpen(ViewName.BattleVerifyView) then
		ViewMgr.instance:close(ViewName.BattleVerifyView)
	end
end

function BattleController:_enterHolyStripeCopySoloResultView()
	HolyStripeCopyController.instance:openBattleResultView()
end

function BattleController:_openDivineKingOrderClgResultView()
	if DivineKingOrderClgModel.instance:getLastBattleResult() then
		DivineKingOrderClgController.instance:openBattleResultView()
	else
		self:openSettlementView()
	end
end

function BattleController:getStageBgName()
	local leftId = BattleModel.instance:getLeftTeamId()
	local playerViewLeft = BattleModel.instance:getPlayer(leftId)
	local battleBackgroundSkinId = 1

	if playerViewLeft and playerViewLeft.battleBackgroundSkinId > 0 then
		battleBackgroundSkinId = playerViewLeft.battleBackgroundSkinId
	end

	if battleBackgroundSkinId == 1 and not BattleStartAnimController.instance:isSeeSelfBattleBg() then
		local rightId = BattleModel.instance:getRightTeamId()
		local playerViewRight = BattleModel.instance:getPlayer(rightId)

		if playerViewRight and playerViewRight.battleBackgroundSkinId > 0 and playerViewRight.battleBackgroundSkinId ~= 1 then
			battleBackgroundSkinId = playerViewRight.battleBackgroundSkinId
		end
	end

	if BattleModel.instance.testBattleSkinId > 0 then
		battleBackgroundSkinId = BattleModel.instance.testBattleSkinId
	end

	local cfg = BattleStartAnimConfig.instance:getBattleBackgroundSkinCfg(battleBackgroundSkinId)

	return cfg.bgName
end

function BattleController:getStageBgCfg()
	local leftId = BattleModel.instance:getLeftTeamId()
	local playerViewLeft = BattleModel.instance:getPlayer(leftId)
	local battleBackgroundSkinId = 1

	if playerViewLeft and playerViewLeft.battleBackgroundSkinId > 0 then
		battleBackgroundSkinId = playerViewLeft.battleBackgroundSkinId
	end

	if battleBackgroundSkinId == 1 and not BattleStartAnimController.instance:isSeeSelfBattleBg() then
		local rightId = BattleModel.instance:getRightTeamId()
		local playerViewRight = BattleModel.instance:getPlayer(rightId)

		if playerViewRight and playerViewRight.battleBackgroundSkinId > 0 and playerViewRight.battleBackgroundSkinId ~= 1 then
			battleBackgroundSkinId = playerViewRight.battleBackgroundSkinId
		end
	end

	if BattleModel.instance.testBattleSkinId > 0 then
		battleBackgroundSkinId = BattleModel.instance.testBattleSkinId
	end

	return (BattleStartAnimConfig.instance:getBattleBackgroundSkinCfg(battleBackgroundSkinId))
end

function BattleController:getBattleUserInterfaceSkinId()
	if BattleModel.instance.testBattleUISkinId > 0 then
		return BattleModel.instance.testBattleUISkinId
	end

	local teamId = BattleModel.instance:getLeftTeamId()
	local playerView = BattleModel.instance:getPlayer(teamId)

	return (playerView and playerView.battleUserInterfaceSkinId > 0 or nil) and playerView.battleUserInterfaceSkinId
end

function BattleController:getRetreatTips()
	return BattleConfig.instance:getRetreatTips(BattleModel.instance.retreatMsgType)
end

function BattleController:getCurRound()
	local battleScene = SceneMgr.instance:getCurScene()

	if battleScene:getSceneType() ~= SceneType.Battle then
		return nil
	end

	return battleScene.roundHandler.curRound
end

function BattleController:showStartUIBattleEffect(unit, curFaceId, callBack)
	self._tempCallBack = callBack

	GlobalDispatcher:dispatch(GlobalNotify.OnUseSpiritInvocationSkillStart, unit, curFaceId)
end

function BattleController:showEndUIBattleEffect()
	GameUtil.callBack(self._tempCallBack)

	self._tempCallBack = nil
end

BattleController.instance = BattleController.New()

return BattleController
