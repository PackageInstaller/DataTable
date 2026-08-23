local GuideCheckCondition = require("app.view.module.guide.const.GuideCheckCondition")
local var_0_1 = g.core.const.ConstMgr.BuglyTagConst
local var_0_2 = g.core.const.ConstMgr.GuideConst
local var_0_3 = g.core.const.ConstMgr.GuideConst.DEBUG_EVENT
local GuideService = class("GuideService")

GuideService.STATE_WAIT = 1
GuideService.STATE_EXECUTE = 2
GuideService.STATE_OPERATE = 3
GuideService.STEP_OPE = 1
GuideService.STEP_END = 2
GuideService.TICKED_NONE = 0
GuideService.TICKED_WAIT = 1

local var_0_6 = {
	[1] = true
}

GuideService.FINISH_CODE = 99999

function GuideService:ctor()
	if var_0_3.WAIT_BATTLE_READY_STATE then
		self._guideDebug = nil
	end

	self._isLaunching = true
	self._guideState = GuideService.STATE_OPERATE
	self._guideWaitCount = 0
	self._guideTouchStartCount = 0
	self._inTickSpeWeakGuide = false
	self._fightGuideReadyState = false
	self._playingGuideStory = false
	self._tickBindLayerName = nil
	self._exitWithUnlock = false
	self._curGuideIndex = nil
	self._guideData = nil
	self._curGuideData = nil
	self._battleGuideData = nil
	self._battleId = nil
	self._battleWave = nil
	self._guideDatas = nil
	self._safeSchedule = nil
	self._tickedState = GuideService.TICKED_NONE
	self._guideStepState = GuideService.STEP_END
	self._fromCreate = false
	self._isEnded = true
	self._isChecking = false
	self._checkParams = {}
	self._weakSpeGuideMap = {}
	self._loadedSpeGuildSaveData = false
	self._guideDialogComp = nil
	self._guideFingerComp = nil
	self._guideMask = nil
	self._guideLevelFlag = false
	self._curEnterModule = nil
	self._allWaitTraceback = {}
	self._waitingEnterScene = false
	self._curCheckStep = nil
	self._weakGuideTickList = {}
	self._inWaitEvent = false
	self._createTick = false
	self._nextStepJump = false
	self._disconnectFlag = false
	self._speWeakGuideWaitFinish = false
	self._speWeakGuideTarget = nil
	self._fightErrResetStepId = nil
	self._speWeakGuideCfg = nil
	self._sysCloseCall = nil
	self._sysShowState = false
	self._checkConds = {
		[20001] = GuideCheckCondition.checkDungeonStageChallenge,
		[20002] = GuideCheckCondition.checkDungeonStageCanGetStageReward,
		[20003] = GuideCheckCondition.checkDungeonStageCanGetStarReward,
		[20004] = GuideCheckCondition.checkTargetPosKnightCanLineup,
		[20005] = GuideCheckCondition.checkTargetEquipOrTreasureCanDress,
		[20006] = GuideCheckCondition.checkUniteTokenCanLineup,
		[20007] = GuideCheckCondition.checkKnightUpgradeItemCanEquip,
		[20008] = GuideCheckCondition.checkKnightCanUpgrade,
		[20009] = GuideCheckCondition.checkHasKnight,
		[20010] = GuideCheckCondition.checkHasItem,
		[20011] = GuideCheckCondition.checkUniteTokenCanAwake,
		[20015] = GuideCheckCondition.checkStormEventFinished,
		[20016] = GuideCheckCondition.checkWushIsFirstOpen,
		[20017] = GuideCheckCondition.checkArenaFirstOpen,
		[20018] = GuideCheckCondition.checkUniteTokenPosNotNull,
		[20019] = GuideCheckCondition.checkCanFirstRecruit,
		[20020] = GuideCheckCondition.checkKnightCanLvUp,
		[20021] = GuideCheckCondition.checkCanChangeKnightPos,
		[20022] = GuideCheckCondition.checkCanChangeUniteTokenPos,
		[20023] = GuideCheckCondition.checkPosIsDesignKnight,
		[20024] = GuideCheckCondition.checkCanJoinGuild,
		[20025] = GuideCheckCondition.checkBioTaskCanRun,
		[20027] = GuideCheckCondition.checkTrainBuild,
		[20028] = GuideCheckCondition.checkHasKnightInWork,
		[20029] = GuideCheckCondition.checkAutoFightOpen,
		[20030] = GuideCheckCondition.checkFight2x,
		[20031] = GuideCheckCondition.checkFight3x,
		[20032] = GuideCheckCondition.checkArenaHasChallengeTimes,
		[20033] = GuideCheckCondition.checkWushHasChallengeTimes,
		[20034] = GuideCheckCondition.checkRebelHasChallengeTimes,
		[20035] = GuideCheckCondition.checkHasGuide,
		[20036] = GuideCheckCondition.checkCanFightGuideBoss,
		[20037] = GuideCheckCondition.checkIsInPrimary,
		[20038] = GuideCheckCondition.checkInMineActivityTime,
		[20039] = GuideCheckCondition.checkInPeakArenaActivityTime,
		[20040] = GuideCheckCondition.checkGuideFightInTime,
		[20041] = GuideCheckCondition.checkIsGuildWarTime,
		[20042] = GuideCheckCondition.checkIsGuildWarDevelopTime,
		[20043] = GuideCheckCondition.checkIsGuildWarFightTime,
		[20044] = GuideCheckCondition.checkIsGuildWarFightTimeInDevelop,
		[20045] = GuideCheckCondition.checkIsGuildWarFightTimeInBattle,
		[20046] = GuideCheckCondition.checkFogNightmareInTime,
		[20047] = GuideCheckCondition.checkGveInSignUpStage,
		[20048] = GuideCheckCondition.checkGveInFormalStage,
		[20049] = GuideCheckCondition.checkIsFunctionUnlocked,
		[20050] = GuideCheckCondition.checkHardWushUnlocked,
		[20051] = GuideCheckCondition.checkChiefArenaUnlock,
		[20052] = GuideCheckCondition.checkGeneFirstActivate,
		[20053] = GuideCheckCondition.checkGeneCanActivate,
		[20054] = GuideCheckCondition.checkTeamPvpCanRoute,
		[20055] = GuideCheckCondition.checkExplorationCanRoute,
		[20056] = GuideCheckCondition.checkRedCliffCanRoute,
		[20057] = GuideCheckCondition.checkBountyCanRoute,
		[20058] = GuideCheckCondition.checkTeamBattleCanRoute,
		[20059] = GuideCheckCondition.checkAllianceUnlock,
		[20060] = GuideCheckCondition.checkIsSlgOpen,
		[20061] = GuideCheckCondition.checkIsHasAlliance,
		[20062] = GuideCheckCondition.checkIsPubgOpen,
		[20063] = GuideCheckCondition.checkIsSlgS1,
		[20064] = GuideCheckCondition.checkIsSlgS2,
		[20065] = GuideCheckCondition.checkSpireIsOpen,
		[20066] = GuideCheckCondition.checkElderBossIsOpen,
		[20067] = GuideCheckCondition.checkHandBookOpen,
		[20068] = GuideCheckCondition.checkKnightFragAttr,
		[20069] = GuideCheckCondition.checkOutpostTaskFinish,
		[20070] = GuideCheckCondition.checkOutpostTaskAward,
		[20071] = GuideCheckCondition.isHomeLandOpenTwo,
		[20072] = GuideCheckCondition.isWarriorsUsed,
		[20073] = GuideCheckCondition.isOutpostCityLevelUp,
		[20074] = GuideCheckCondition.isAncientsOpen,
		[90000] = handler(self, self._checkNextGuide)
	}
	self._createSteps = {
		[101] = true,
		[104] = true,
		[114] = true,
		[103] = true,
		[105] = true
	}
	self._debugList = {}
	self._sentCache = {}
	self._storyKey = "guide_story"

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CREATE_ROLE, self._onCreateRole, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGIN_LOADING, self._onGameLoginFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self._onGameLoginResume, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetDisconnected, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._onNetTimeOut, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_RECONNECT, self._onNetReconnect, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_EXPIRED, self._onNetLoginExpired, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_NOTIFY, self._onNetLoginNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_REPEAT, self._onLoginRepeat, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_OFFLINE_NEW, self._onLoginRepeat, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_SERVER_BROKEN, self._onNetServerBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOADING_START, self._onLoadingState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOADING_FINISH, self._onLoadingState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, self._onDungeonChallengeStageFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_LOGIN_STATE_PAUSE, self._onNetLoginStatePause, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_LOGIN_STATE_RESUME, self._onNetLoginStateResume, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_INTERACTIVE_TASK_FINISH, self._onNetInteractiveTaskFinish1, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ON_PRE_LOADING_FINISH, self._onNetInteractiveTaskFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_POPUP_ANI_START, self._onModulePopupAni, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_POPUP_ANI_FINISH, self._onModulePopupAni, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_WAIT, self._onCommonGuideEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_READY, self._onCommonGuideEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_WEAK_GUIDE_READY, self._checkWeakGuideShow, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_TOUCH_START, self._onGuideTouchStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_TOUCH_END, self._onGuideTouchEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_START, self._onBattleStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ANIME_END, self._onBattleAnimeEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_END_ASYNC, self._onBattleEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_HP_BAR_SHOW, self._onBattleHpBarShow, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_WAVE_START, self._onBattleWaveStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_OWN_TEAM_CHANGED, self._onOwnTeamChanged, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ROUND_UPDATE, self._onRoundUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ACTOR_HP_CHANGED, self._onBattleHPChanged, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ACTOR_ANGER_CHANGED, self._onBattleAngerChanged, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_NEW_SKILL, self._onBattleNewSkill, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ACTOR_ATK_BEFORE, self._onBattleATKBefore, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ACTOR_SKILL_BEFORE, self._onBattleSkillBefore, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ACTOR_PASSIVE_TRIGGER, self._onBattlePassiveTriggle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ENEMY_TEAM_CHANGED, self._checkFirstBattleSmallBossDead, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_START, self._onStoryStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_FORCE_START, self._onStoryForceStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER_ROOT, self._onModuleRootEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onModuleExit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CHECK, self._onGuideCheck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CHECK_BATTLE_FAIL, self._onGuideCheck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FUNC_UNLOCK_START, self._onFuncUnlockState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FUNC_UNLOCK_END, self._onFuncUnlockState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_CUSTOM_GUIDE_STEP, self._onAddCustomGuideStep, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_HOME_GUIDE_CHECK, self._onHomeGuideCheck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_WAIT_TEST_MATCH, self._onCheckTestMatch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_READY_TEST_MATCH, self._onCheckTestMatch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_WAIT_SURE_OK, self._onCheckMatchSure, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_READY_SURE_OK, self._onCheckMatchSure, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAY_TEST_BATTLE, self._onEnterTestBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_ENTER_DUNGEON_CHAPTER_1, self._onEnterDungeonChapter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAYER_GET_KNIGHT, self._onGetNewKnight, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_LINEUP_UNITE_TOKEN_1, self._onLineUpUniteToken1, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_LINEUP_UNITE_TOKEN_2, self._onLineUpUniteToken2, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_1, self._onShowUniteToken1, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_2, self._onShowUniteToken2, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_PLAYER_GET_UNITE_TOKEN_3, self._onShowUniteToken3, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_ENTER_DUNGEON_BATTLE, self._onEnterDungeonBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_SHOW_ALL_UNITE_TOKEN, self._onShowAllUniteToken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_NEW_KNIGHT_LINEUP, self._onNewKnightLineUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_DUNGEON_SPECIAL_LOCK, self._onDungeonSpecialLockScene, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CLEAR_COUNT, self._onGuideClearCount, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CHECK_PREDESTINATION_TICKED, self._onCheckPredestinationCheck, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CLEAR_GUIDE_COMP, self._onRemoveGuideComp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, self._onCheckTickTypeWeakGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH, self._onFinishTickTypeWeakGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_GUIDE_CHANGE_UI_STATE, self.onChangeSpeGuideCompShowState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FIGHT_SERVER_BACK_ERROR, self.resetToFightErrStep, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_CREATE, self.checkCurTickedGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, self.checkCurTickedGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self.checkCurTickedGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.checkCurTickedGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_GUIDE_RE_CHECK, self.checkCurTickedGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECV_ROLE_INFO, self.onUserDataBack, self)

	self._guideLayer = g.core.layer.LayerManager:getGuideLayer()

	self._guideLayer:setOpaque(true)
	self:_lockScreen(false)
	fgui.UIPackage:addPackage("ui/guide/guide")

	self._skipComp = fgui.UIPackage:createObject("guide", "GuideSkipBtn")

	g.core.layer.LayerManager:getGuideTopLayer():addChild(self._skipComp, 9999999)
	self._skipComp:setPosition(cc.p(display.width * 1.5 - 100, display.cy + 50))
	self._skipComp:addClickListener(handler(self, self._onSkipGuideClick))
	self._skipComp:setVisible(false)

	self._scheduleHandler = self._guideLayer:newSchedule(handler(self, self._onScheduleUpdate), 0.1)

	g.core.network.GameNetProxy:setMsgHook(handler(self, self._onMsgSend))

	if device.isWindowsDebug() or config.SHOW_DEBUG_BTN then
		local var_1_0 = g.core.common.Storage:load("guide_open_state.json", false)

		GUIDE_CLOSE = var_1_0 and not var_1_0.open or true
	end
end

function GuideService:reset()
	self._isLaunching = true
	self._guideState = GuideService.STATE_OPERATE
	self._fromCreate = false
	self._playingGuideStory = false
	self._disconnectFlag = false
	self._inTickSpeWeakGuide = false

	self:_lockScreen(false)
	self:_removeGuideTip()

	self._guideWaitCount = 0
	self._guideTouchStartCount = 0
	self._guideDialogComp = nil
	self._guideFingerComp = nil
	self._speWeakGuideWaitFinish = false
	self._fightGuideReadyState = false
	self._inWaitEvent = false
	self._createTick = false
	self._nextStepJump = false
	self._tickedState = GuideService.TICKED_NONE
	self._guideStepState = GuideService.STEP_END
	self._guideMask = nil
	self._selectRect = nil
	self._selectRect2 = nil

	if self._curTarget then
		self._curTarget:release()

		self._curTarget = nil
	end

	self:setIsEnded(true)

	self._isChecking = false
	self._checkParams = {}
	self._guideData = nil
	self._guideDatas = nil
	self._curGuideData = nil
	self._curGuideIndex = nil
	self._battleGuideData = nil
	self._sysCloseCall = nil
	self._sysShowState = false
	self._sentCache = {}
	self._curEnterModule = nil
	self._guideLevelFlag = false
	self._needUseResume = false
	self._nextGuideData = nil
	self._nextGuideDataIndex = nil
	self._waitingEnterScene = false
	self._curCheckStep = nil
	self._speWeakGuideTarget = nil
	self._fightErrResetStepId = nil
	self._weakGuideTickList = {}
end

function GuideService:_initGuideData()
	local var_3_0 = json.decodeFileIfExists("common/guide/guide_names.json")

	if not var_3_0 or #var_3_0.indices == 0 then
		return false
	end

	self._guideDatas = {
		createDict = {},
		levelDict = {},
		stageDict = {},
		battleFailDict = {},
		functionDict = {},
		enumDict = {},
		stepIndices = {}
	}
	self._weakGuideDatas = {
		levelDict = {},
		stageDict = {},
		battleFailDict = {},
		functionDict = {},
		enumDict = {},
		stepIndices = {}
	}
	self._tickGuideDatas = {
		levelDict = {},
		stageDict = {},
		battleFailDict = {},
		functionDict = {},
		enumDict = {},
		stepIndices = {}
	}

	local var_3_1 = self._guideDatas

	for iter_3_0, iter_3_1 in ipairs(var_3_0.indices) do
		local var_3_2 = json.decodeFileIfExists(string.format("guide/%s.json", iter_3_1))

		if var_3_2 and #var_3_2 > 0 then
			if var_3_2[1].gotType == var_0_2.TICK_CONST.CREATE then
				table.insert(var_3_1.createDict, var_3_2)

				if self:_needShowError() then
					assert(#var_3_1.createDict <= 1, "There is duplicate guide type which ticked create")
				end

				for iter_3_2, iter_3_3 in ipairs(var_3_2) do
					if self:_needShowError() then
						assert(not var_3_1.stepIndices[iter_3_3.stepId], "Duplicate stepId: " .. tostring(iter_3_3.stepId))
					end

					var_3_1.stepIndices[iter_3_3.stepId] = {
						index = iter_3_2,
						data = iter_3_3,
						guideData = var_3_2
					}
				end
			elseif var_3_2[1].gotType == var_0_2.TICK_CONST.LEVEL then
				local var_3_3 = var_3_2[1].guideType == var_0_2.GUIDE_TYPE.TICK and self._tickGuideDatas or var_3_2[1].guideType == var_0_2.GUIDE_TYPE.WEAK and self._weakGuideDatas or var_3_1
				local var_3_4 = var_3_2[1].gotValue

				if self:_needShowError() then
					assert(not var_3_3.levelDict[var_3_4], string.format("There is another level(%s) in guide data !", var_3_4))
				end

				var_3_3.levelDict[var_3_4] = var_3_2

				for iter_3_4, iter_3_5 in ipairs(var_3_2) do
					if self:_needShowError() then
						assert(not var_3_3.stepIndices[iter_3_5.stepId], "Duplicate stepId: " .. tostring(iter_3_5.stepId))
					end

					var_3_3.stepIndices[iter_3_5.stepId] = {
						level = var_3_4,
						index = iter_3_4,
						data = iter_3_5,
						guideData = var_3_2
					}
				end
			elseif var_3_2[1].gotType == var_0_2.TICK_CONST.MODULE_OPEN then
				local var_3_5 = var_3_2[1].guideType == var_0_2.GUIDE_TYPE.TICK and self._tickGuideDatas or var_3_2[1].guideType == var_0_2.GUIDE_TYPE.WEAK and self._weakGuideDatas or var_3_1
				local var_3_6 = var_3_2[1].gotValue

				if var_3_2[1].guideType == var_0_2.GUIDE_TYPE.STRONG then
					if self:_needShowError() then
						assert(not var_3_5.functionDict[var_3_6], string.format("There is another funcId(%s) in guide data !", tostring(var_3_6)))
					end

					var_3_5.functionDict[var_3_6] = var_3_2
					var_3_2.funcOpened = g.core.common.ModuleUnlock:isModuleUnlock(var_3_6)
				end

				for iter_3_6, iter_3_7 in ipairs(var_3_2) do
					if var_3_2[1].guideType == var_0_2.GUIDE_TYPE.STRONG and self:_needShowError() then
						assert(not var_3_5.stepIndices[iter_3_7.stepId], "Duplicate stepId: " .. tostring(iter_3_7.stepId))
					end

					var_3_5.stepIndices[iter_3_7.stepId] = {
						funcId = var_3_6,
						index = iter_3_6,
						data = iter_3_7,
						guideData = var_3_2
					}
				end
			elseif var_3_2[1].gotType == var_0_2.TICK_CONST.DUNGEON_STAGE then
				local var_3_7 = var_3_2[1].guideType == var_0_2.GUIDE_TYPE.TICK and self._tickGuideDatas or var_3_2[1].guideType == var_0_2.GUIDE_TYPE.WEAK and self._weakGuideDatas or var_3_1
				local var_3_8 = var_3_2[1].gotValue

				if self:_needShowError() then
					assert(not var_3_7.stageDict[var_3_8], string.format("There is another stageId(%s) in guide data !", var_3_8))
				end

				var_3_7.stageDict[var_3_8] = var_3_2

				for iter_3_8, iter_3_9 in ipairs(var_3_2) do
					if self:_needShowError() then
						assert(not var_3_7.stepIndices[iter_3_9.stepId], "Duplicate stepId: " .. tostring(iter_3_9.stepId))
					end

					var_3_7.stepIndices[iter_3_9.stepId] = {
						stageId = var_3_8,
						index = iter_3_8,
						data = iter_3_9,
						guideData = var_3_2
					}
				end
			elseif var_3_2[1].gotType == var_0_2.TICK_CONST.BATTLE_FAIL then
				local var_3_9 = var_3_2[1].guideType == var_0_2.GUIDE_TYPE.TICK and self._tickGuideDatas or var_3_2[1].guideType == var_0_2.GUIDE_TYPE.WEAK and self._weakGuideDatas or var_3_1
				local var_3_10 = var_3_2[1].gotValue2

				if self:_needShowError() then
					assert(not var_3_9.battleFailDict[var_3_10], string.format("There is another battle fail count(%s) in guide data !", tostring(var_3_10)))
				end

				var_3_9.battleFailDict[var_3_10] = var_3_2

				for iter_3_10, iter_3_11 in ipairs(var_3_2) do
					if self:_needShowError() then
						assert(not var_3_9.stepIndices[iter_3_11.stepId], "Duplicate stepId: " .. tostring(iter_3_11.stepId))
					end

					var_3_9.stepIndices[iter_3_11.stepId] = {
						failCount = var_3_10,
						index = iter_3_10,
						data = iter_3_11,
						guideData = var_3_2,
						level = var_3_2[1].gotValue
					}
				end
			elseif var_3_2[1].gotType == var_0_2.TICK_CONST.ENUM_TICK then
				local var_3_11 = var_3_2[1].guideType == var_0_2.GUIDE_TYPE.TICK and self._tickGuideDatas or var_3_2[1].guideType == var_0_2.GUIDE_TYPE.WEAK and self._weakGuideDatas or var_3_1
				local var_3_12 = var_3_2[1].gotValue

				if self:_needShowError() then
					assert(not var_3_1.enumDict[var_3_12], string.format("There is another enum(%s) in guide data !", tostring(var_3_12)))
				end

				var_3_11.enumDict[var_3_12] = var_3_2

				for iter_3_12, iter_3_13 in ipairs(var_3_2) do
					if iter_3_13.stepId ~= GuideService.FINISH_CODE then
						if self:_needShowError() then
							assert(not var_3_1.stepIndices[iter_3_13.stepId], "Duplicate stepId: " .. tostring(iter_3_13.stepId))
						end

						var_3_11.stepIndices[iter_3_13.stepId] = {
							enum = var_3_12,
							index = iter_3_12,
							data = iter_3_13,
							guideData = var_3_2
						}
					end
				end
			end
		end
	end

	self:_loadWeakGuideSteps()

	self._guideTickedMap = {}

	local var_3_13 = g.core.model.User:getGuideId()

	self._sentCache[var_3_13] = true

	local var_3_14 = g.core.model.User:getLevel()

	if (var_3_13 == 106 or var_3_13 == 107) and var_3_14 > 1 then
		return
	end

	if var_3_13 == 6 and var_3_14 > 3 then
		return
	end

	local var_3_15 = 0
	local var_3_16

	if var_3_13 ~= 0 then
		var_3_16 = self._guideDatas.stepIndices[var_3_13]

		if self:_needShowError() then
			if not var_3_16 then
				g.core.log:error("ERR---------->Invalid guideId: " .. tostring(var_3_13))

				return false
			end
		elseif not var_3_16 then
			return false
		end

		if var_3_16.data.resetId and var_3_16.data.resetId ~= GuideService.FINISH_CODE then
			var_3_15 = var_3_16.data.resetId

			if var_3_16.data.resetId == 0 then
				-- block empty
			end
		end
	end

	if var_3_15 ~= 0 then
		local var_3_17 = self._guideDatas.stepIndices[var_3_15]

		if self:_needShowError() then
			assert(var_3_17, "Invalid resetId: " .. tostring(var_3_15) .. " with guideId: " .. tostring(var_3_13))
		elseif not var_3_17 then
			return false
		end

		self._guideData = var_3_17.guideData
		self._curGuideIndex = var_3_17.index - 1
		self._sentCache[var_3_13] = true
	else
		local var_3_18 = self._guideDatas.levelDict[var_3_14]

		if var_3_13 == 0 and var_3_18 then
			self._guideData = var_3_18
			self._curGuideIndex = 0
		else
			return false
		end
	end

	return true
end

function GuideService:_needShowError()
	return device.isWindowsDebug()
end

function GuideService:checkAndResetFightErrId(arg_5_1, arg_5_2)
	if not self._guideData[arg_5_2 + 1] then
		return
	end

	if not arg_5_1.inBattle and self._guideData[arg_5_2 + 1].inBattle then
		self._fightErrResetStepId = arg_5_1.resetId

		g.core.log:info("-->设置战斗错误时的重置id->", arg_5_1.resetId)
	end
end

function GuideService:resetToFightErrStep()
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if self._isEnded then
		return
	end

	if not self._fightErrResetStepId then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self._guideData) do
		if iter_6_1.stepId == self._fightErrResetStepId then
			self._curGuideIndex = iter_6_0 - 1

			break
		end
	end

	g.core.network.GameNetProxy:send_C2S_Guide_Set({
		id = self._fightErrResetStepId
	}, true)
end

function GuideService:_loadTickedGuide()
	if not self._guideTickedMap or not next(self._guideTickedMap) then
		self._guideTickedMap = g.core.common.Storage:load("guide_ticked.json", true) or {}
	end
end

function GuideService:_saveTickedGuide()
	g.core.common.Storage:save("guide_ticked.json", self._guideTickedMap, true)
end

function GuideService:_checkGuide(arg_9_1)
	arg_9_1 = arg_9_1 or {}

	if not next(arg_9_1) then
		return false
	end

	local var_9_0 = arg_9_1.tickType

	if not self._guideDatas then
		return false
	end

	if var_9_0 == var_0_2.TICK_CONST.CREATE then
		if #self._guideDatas.createDict == 1 then
			self._createTick = true

			return true, self._guideDatas.createDict[1], 0
		end
	elseif var_9_0 == var_0_2.TICK_CONST.LEVEL then
		if self._weakGuideDatas.levelDict[arg_9_1.level] then
			local var_9_1 = self:checkFunctionOpenCond(true)

			if var_9_1 and self:_checkGuideCond(var_9_1, 0) then
				self._weakGuideTickList[var_9_1[1].stepId] = true
			end

			if self:_checkGuideCond(self._weakGuideDatas.levelDict[arg_9_1.level], 0) then
				self._weakGuideTickList[self._weakGuideDatas.levelDict[arg_9_1.level][1].stepId] = true
			end
		elseif self._guideDatas.levelDict[arg_9_1.level] then
			local var_9_2 = self:checkFunctionOpenCond(false)

			if var_9_2 and self:_checkGuideCond(var_9_2, 0) then
				return true, var_9_2, 0
			end

			local var_9_3 = self._guideDatas.levelDict[arg_9_1.level]

			if not self:_checkGuideCond(self._guideDatas.levelDict[arg_9_1.level], 0) then
				return false
			end

			return true, var_9_3, 0
		end
	elseif var_9_0 == var_0_2.TICK_CONST.MODULE_OPEN then
		if self._weakGuideDatas.functionDict[arg_9_1.funcId] then
			if self:_checkGuideCond(self._weakGuideDatas.functionDict[arg_9_1.funcId], 0) then
				self._weakGuideTickList[self._weakGuideDatas.functionDict[arg_9_1.funcId][1].stepId] = true
			end
		elseif self._guideDatas.functionDict[arg_9_1.funcId] then
			if not self:_checkGuideCond(self._guideDatas.functionDict[arg_9_1.funcId], 0) then
				return false
			end

			return true, self._guideDatas.functionDict[arg_9_1.funcId], 0
		end
	elseif var_9_0 == var_0_2.TICK_CONST.DUNGEON_STAGE then
		if self._weakGuideDatas.stageDict[arg_9_1.stageId] then
			local var_9_4 = self:checkFunctionOpenCond(true)

			if var_9_4 and self:_checkGuideCond(var_9_4, 0) then
				self._weakGuideTickList[var_9_4[1].stepId] = true
			end

			if g.core.model.User.dungeonData:isStagePassed(arg_9_1.stageId) then
				if self:_checkGuideCond(self._weakGuideDatas.stageDict[arg_9_1.stageId], 0) then
					self._weakGuideTickList[self._weakGuideDatas.stageDict[arg_9_1.stageId][1].stepId] = true
				end
			end
		elseif self._guideDatas.stageDict[arg_9_1.stageId] then
			local var_9_5 = self:checkFunctionOpenCond(false)

			if var_9_5 and self:_checkGuideCond(var_9_5, 0) then
				return true, var_9_5, 0
			end

			if g.core.model.User.dungeonData:isStagePassed(arg_9_1.stageId) then
				if not self:_checkGuideCond(self._guideDatas.stageDict[arg_9_1.stageId], 0) then
					return false
				end

				return true, self._guideDatas.stageDict[arg_9_1.stageId], 0
			else
				return false
			end
		end
	elseif var_9_0 == var_0_2.TICK_CONST.BATTLE_FAIL then
		local var_9_6 = g.core.common.Storage:load("battle_fail_count.json") or {
			count = 0
		}

		if self._weakGuideDatas.battleFailDict[var_9_6.count] then
			if self._weakGuideDatas.battleFailDict[var_9_6.count] and self._weakGuideDatas.battleFailDict[var_9_6.count][1].gotValue >= g.core.model.User:getLevel() and self:_checkGuideCond(self._weakGuideDatas.battleFailDict[var_9_6.count], 0) then
				self._weakGuideTickList[self._weakGuideDatas.battleFailDict[var_9_6.count][1].stepId] = true
			end
		elseif self._guideDatas.battleFailDict[var_9_6.count] then
			if self._guideDatas.battleFailDict[var_9_6.count] and self._guideDatas.stepIndices[self._guideDatas.battleFailDict[var_9_6.count][1].stepId].level < g.core.model.User:getLevel() then
				return false
			end

			if not self:_checkGuideCond(self._guideDatas.battleFailDict[var_9_6.count], 0) then
				return false
			end

			return true, self._guideDatas.battleFailDict[var_9_6.count], 0
		end
	elseif var_9_0 == var_0_2.TICK_CONST.ENUM_TICK then
		if self._weakGuideDatas.enumDict[arg_9_1.enum] then
			local var_9_7 = tostring(var_9_0)

			self._guideTickedMap[var_9_7] = self._guideTickedMap[var_9_7] or {}
			self._guideTickedMap[var_9_7][tostring(arg_9_1.enum)] = true

			if self:_checkGuideCond(self._weakGuideDatas.enumDict[arg_9_1.enum], 0) then
				self._weakGuideTickList[self._weakGuideDatas.enumDict[arg_9_1.enum][1].stepId] = true
			end
		elseif self._guideDatas.enumDict[arg_9_1.enum] then
			if not self:_checkGuideCond(self._guideDatas.enumDict[arg_9_1.enum], 0) then
				return false
			end

			return true, self._guideDatas.enumDict[arg_9_1.enum], 0
		end
	end

	if var_9_0 == var_0_2.TICK_CONST.DUNGEON_STAGE or var_9_0 == var_0_2.TICK_CONST.LEVEL then
		self:_onCheckPredestinationCheck()

		local var_9_8 = self:checkFunctionOpenCond(true)

		if var_9_8 and self:_checkGuideCond(var_9_8, 0) then
			self._weakGuideTickList[var_9_8[1].stepId] = true
		end

		local var_9_9 = self:checkFunctionOpenCond(false)

		if var_9_9 and self:_checkGuideCond(var_9_9, 0) then
			return true, var_9_9, 0
		end
	end

	return false
end

function GuideService:checkFunctionOpenCond(arg_10_1)
	local var_10_0

	if not arg_10_1 then
		if next(self._guideDatas.functionDict) then
			for iter_10_0, iter_10_1 in pairs(self._guideDatas.functionDict) do
				if not iter_10_1.funcOpened and g.core.common.ModuleUnlock:isModuleUnlock(iter_10_0) then
					var_10_0 = iter_10_1
					iter_10_1.funcOpened = true

					break
				end
			end
		end
	elseif next(self._weakGuideDatas.functionDict) then
		for iter_10_2, iter_10_3 in pairs(self._weakGuideDatas.functionDict) do
			if not iter_10_3.funcOpened and g.core.common.ModuleUnlock:isModuleUnlock(iter_10_2) then
				var_10_0 = iter_10_3
				iter_10_3.funcOpened = true

				break
			end
		end
	end

	return var_10_0
end

function GuideService:_checkGuideCond(arg_11_1, arg_11_2)
	local var_11_0 = 1

	arg_11_1 = arg_11_1 or self._guideData
	arg_11_2 = arg_11_2 or self._curGuideIndex

	local var_11_1 = arg_11_1[arg_11_2 + var_11_0]

	if arg_11_1[arg_11_2 + var_11_0] and var_11_1.inBattle ~= g.core.battle.BattleProxy:isInBattle() then
		return var_11_1, var_11_0
	end

	repeat
		if not var_11_1 then
			var_11_2 = true

			return false
		end

		if var_11_1.falseCond and var_11_1.falseCond ~= 0 then
			local var_11_3 = self._checkConds[var_11_1.falseCond]

			if not (not self._checkConds[var_11_1.falseCond] and true or var_11_3 and var_11_3(var_11_1.falseValue1, var_11_1.falseValue2)) then
				var_11_0 = var_11_0 + 1
				var_11_1 = arg_11_1[arg_11_2 + var_11_0]
				self._nextStepJump = true
			else
				var_11_2 = true
			end
		else
			var_11_2 = true
		end
	until false

	return var_11_1, var_11_0
end

function GuideService:_checkNextGuide()
	return checkbool(self._nextGuideData)
end

function GuideService:_checkGuideScene(arg_13_1, arg_13_2)
	if not arg_13_1 then
		return false, true
	end

	if self._createTick then
		if not self._sentCache[arg_13_1.stepId] and not self._isDebugGuide then
			self._sentCache[arg_13_1.stepId] = true

			if not var_0_6[arg_13_1.stepId] then
				g.core.network.GameNetProxy:send_C2S_Guide_Set({
					id = arg_13_1.stepId
				}, true)
			end
		end

		arg_13_1.ignoreScene = true
		self._createTick = false

		return true
	end

	if arg_13_1.ignoreScene then
		return true
	end

	local var_13_0 = arg_13_1.layerName
	local var_13_1 = g.core.module.ModuleManager:getCurModule()

	if not var_13_1 then
		return true
	end

	local var_13_2 = var_13_1.display:getName()
	local var_13_3 = g.core.battle.BattleProxy:isInBattle()

	if var_13_0 == var_13_2 and arg_13_1.inBattle == var_13_3 then
		self._nextStepJump = false

		return true
	end

	if self._nextStepJump and not arg_13_2 then
		if arg_13_1.moduleName then
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance[arg_13_1.moduleName], arg_13_1.moduleParams[1])
		end

		self._nextStepJump = false
	end

	if self._createSteps[arg_13_1.stepId] or arg_13_1.stepId == 1 then
		return true
	end

	table.insert(self._debugList, {
		needLayer = var_13_0,
		curLayer = var_13_2,
		value = "-----------------------------------> check Layer false," .. tostring(arg_13_1.inBattle) .. "," .. tostring(var_13_3)
	})

	return false
end

function GuideService:_NotifySaveStepId()
	if self._isEnded then
		return
	end

	local var_14_0 = self._guideData[self._curGuideIndex + 1]

	if self._guideData[self._curGuideIndex + 1] then
		if self._curGuideData then
			if self._curGuideData.inBattle and not var_14_0.inBattle then
				return
			end

			if var_14_0.layerName == "BattleResultLayer" then
				return
			end
		end

		if not self._sentCache[var_14_0.stepId] and not self._isDebugGuide and not g.core.battle.BattleProxy:isInBattle() and not var_0_6[var_14_0.stepId] then
			g.core.network.GameNetProxy:send_C2S_Guide_Set({
				id = var_14_0.stepId
			}, true)

			self._sentCache[var_14_0.stepId] = true
		end
	end
end

function GuideService:_executeGuide(arg_15_1)
	if self._guideState ~= GuideService.STATE_OPERATE then
		return
	end

	self._lastStepOffset = 0

	local var_15_0, var_15_1 = self:_checkGuideCond()

	if not var_15_0 then
		return true
	end

	if var_15_0.resetId == 99999 and var_15_0.opeType == 1 then
		if not self._sentCache[var_15_0.stepId] and not self._isDebugGuide then
			g.core.network.GameNetProxy:send_C2S_Guide_Set({
				id = var_15_0.stepId
			}, true)

			self._sentCache[var_15_0.stepId] = true
		end

		return true
	end

	self:_removeGuideTip()

	self._curRunningWeakGuide = nil
	self._curRunningWeakGuideId = nil

	if not self:_checkGuideScene(var_15_0) then
		return false
	end

	self._tickBindLayerName = nil

	if var_15_0.enterEvent and var_15_0.enterEvent ~= 0 and var_0_2.GUIDE_EVENT[var_15_0.enterEvent] then
		g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[var_15_0.enterEvent])
	end

	if self._speScheduler then
		g.core.common.Scheduler:cancelSchedule(self._speScheduler)

		self._speScheduler = nil
	end

	if var_15_0.waitEvent and not var_15_0.waitInvalid and not self._fromBattleEnd and not var_15_0.followFront and g.core.battle.BattleProxy:isInBattle() then
		var_15_0.waitInvalid = true

		if not self._fightGuideReadyState then
			self._inWaitEvent = true

			self:_onGuideStateWait(var_0_3.WAIT_BATTLE_READY_STATE)

			return false
		end
	else
		if self._fromBattleEnd then
			self._fromBattleEnd = false
		end

		self._inWaitEvent = false
	end

	if self:_checkStory() then
		return false
	end

	self._guideStepState = GuideService.STEP_OPE

	if self._waitOpeStepTouchEndNum and self._waitOpeStepTouchEndNum > 0 then
		for iter_15_0 = 1, self._waitOpeStepTouchEndNum do
			self:_onGuideTouchEnd()
		end
	end

	self._waitOpeStepTouchEndNum = 0

	if not self._sentCache[var_15_0.stepId] and not self._isDebugGuide and g.core.model.User:getGuideId() ~= var_15_0.stepId and not g.core.battle.BattleProxy:isInBattle() and not var_0_6[var_15_0.stepId] then
		g.core.network.GameNetProxy:send_C2S_Guide_Set({
			id = var_15_0.stepId
		}, true)

		self._sentCache[var_15_0.stepId] = true
	end

	self._lastStepOffset = var_15_1
	self._curGuideIndex = self._curGuideIndex + var_15_1
	self._curGuideData = var_15_0

	release_print("guide enter step-->stepId = " .. var_15_0.stepId, ",index = " .. self._curGuideIndex)
	self:checkAndResetFightErrId(var_15_0, self._curGuideIndex)

	if var_15_0.comment == "outpost_knight" then
		local var_15_2 = g.core.module.ModuleManager:getCurModule().display

		if var_15_2:getName() == "OutpostGameStage" and not var_15_2:getKnightWaitBuild() then
			return true
		end
	end

	if var_15_0.opeType == 1 then
		self._guideStepState = GuideService.STEP_END

		self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
		g.core.common.Scheduler:newScheduleOnce(function()
			self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
		end, 0)

		if var_15_0.exitEvent and var_15_0.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[var_15_0.exitEvent] then
			g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[var_15_0.exitEvent])
		end

		self:_onStepEnd()
	elseif var_15_0.opeType == 2 then
		if var_15_0.comment then
			local var_15_3 = g.core.layer.LayerManager:getRoot()
			local var_15_4 = true
			local var_15_5 = var_15_0.comment

			if var_15_0.listBindId and var_15_0.listBindId ~= 0 and var_15_0.listBindId ~= "" then
				var_15_5 = self:getListChangeComment(var_15_5, var_15_0.listBindId)
			end

			if var_15_5 == "outpost_knight" then
				self._target1 = g.core.module.ModuleManager:getCurModule().display:getKnightWaitBuild()
				var_15_4 = not not self._target1
			else
				var_15_4, self._target1 = pcall(handler(var_15_3, var_15_3.getDeepChild), var_15_5)
			end

			if not var_15_4 or not self._target1 then
				self:_setIgnoreGuide("can't find the target Btn", var_15_5)

				return true
			end
		end

		self._normalBgComp = fgui.GComponent:create()

		self._normalBgComp:setPivot(0.5, 0.5, true)
		self._normalBgComp:setOpaque(true)
		self._normalBgComp:setTouchable(true)
		self._normalBgComp:setSize(display.width, display.height)
		self._normalBgComp:setPosition(display.width, display.height)
		self._guideLayer:addChild(self._normalBgComp)
		self._normalBgComp:addClickListener(function()
			if self._tipsComp then
				self._tipsComp:playOnce()
			end
		end)

		local var_15_6 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_15_7 = self._target1:getSize()
		local var_15_8 = self._target1:getScale()
		local var_15_9 = self._target1:localToGlobal(cc.p(var_15_7.width * (0.5 - var_15_6.x), var_15_7.height * (0.5 - var_15_6.y)))
		local var_15_10 = self._guideLayer:globalToLocal(var_15_9)

		self:_createGuideTip(var_15_0, {
			globalCenterPos = var_15_9,
			centerPos = var_15_10,
			originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_15_7.width * -var_15_6.x * var_15_8.x, var_15_7.height * -var_15_6.y * var_15_8.y))),
			size = var_15_7,
			scale = var_15_8,
			position = self._target1:getPosition(),
			convertPos = cc.p(var_15_7.width * (0.5 - var_15_6.x), var_15_7.height * (0.5 - var_15_6.y)),
			voice = var_15_0.voice
		})

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setName(var_15_0.stepId)
		self._selectRect:setOpaque(true)
		self._guideLayer:addChild(self._selectRect)
		self._selectRect:setSize(var_15_7.width, var_15_7.height)
		self._selectRect:setPivot(0.5, 0.5, true)
		self._selectRect:setPosition(var_15_10)
		self._selectRect:addClickListener(function(arg_18_0)
			self._guideStepState = GuideService.STEP_END

			if var_15_0.listItemIndex then
				self._target1:bubbleEvent(fgui.UIEventType.Click)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_PLAY_UNITE_TOKEN_SKILL, false, {
					target = self._target1
				})
			else
				self._target1:dispatchEvent(fgui.UIEventType.Click)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_PLAY_UNITE_TOKEN_SKILL, false, {
					target = self._target1
				})
			end

			self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
			g.core.common.Scheduler:newScheduleOnce(function()
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			end, 0)

			if var_15_0.exitEvent and var_15_0.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[var_15_0.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[var_15_0.exitEvent])
			end

			self:_onStepEnd()
			arg_18_0:stopPropagation()
		end)
	elseif var_15_0.opeType == 3 then
		if var_15_0.comment then
			local var_15_11 = g.core.layer.LayerManager:getRoot()
			local var_15_13, var_15_14 = pcall(handler(var_15_11, var_15_11.getDeepChild), var_15_0.comment)

			self._target1 = var_15_14

			if var_15_13 and self._target1 then
				local var_15_15, var_15_16 = pcall(handler(var_15_11, var_15_11.getDeepChild), var_15_0.comment2)

				self._target2 = var_15_16

				if not var_15_15 or not self._target2 then
					self:_setIgnoreGuide("can't find the target Btn2", var_15_0.comment2)

					return true
				end
			else
				self:_setIgnoreGuide("can't find the target Btn1", var_15_0.comment)

				return true
			end
		end

		local var_15_17 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_15_18 = self._target1:getSize()
		local var_15_19 = self._target1:getScale()
		local var_15_20 = self._target1:localToGlobal(cc.p(var_15_18.width * (0.5 - var_15_17.x), var_15_18.height * (0.5 - var_15_17.y)))
		local var_15_21 = self._target2:isPivotAsAnchor() and self._target2:getPivot() or cc.p(0, 0)
		local var_15_22 = self._target2:getSize()
		local var_15_23 = self._target2:getScale()
		local var_15_24 = self._target2:localToGlobal(cc.p(var_15_22.width * (0.5 - var_15_21.x), var_15_22.height * (0.5 - var_15_21.y)))

		self:_createGuideTip(var_15_0, {
			globalCenterPos = var_15_20,
			centerPos = self._guideLayer:globalToLocal(var_15_20),
			originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_15_18.width * -var_15_17.x * var_15_19.x, var_15_18.height * -var_15_17.y * var_15_19.y))),
			size = var_15_18,
			globalCenterPos1 = var_15_24,
			centerPos1 = self._guideLayer:globalToLocal(var_15_24),
			originPos1 = self._guideLayer:globalToLocal(self._target2:localToGlobal(cc.p(var_15_22.width * -var_15_17.x * var_15_23.x, var_15_22.height * -var_15_17.y * var_15_23.y))),
			voice = var_15_0.voice
		}, true)

		self._normalBgComp = fgui.GComponent:create()

		self._normalBgComp:setPivot(0.5, 0.5, true)
		self._normalBgComp:setOpaque(true)
		self._normalBgComp:setTouchable(true)
		self._normalBgComp:setSize(display.width * 2, display.height * 2)
		self._normalBgComp:setPosition(display.width, display.height)
		self._guideLayer:addChild(self._normalBgComp)
		self._normalBgComp:addEventListener(fgui.UIEventType.Drop, function()
			self._target2:dispatchEventLua(fgui.UIEventType.Drop, 0)
		end)

		local var_15_25 = self._target1:getSize()
		local var_15_26 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_15_27 = self._guideLayer:globalToLocal((self._target1:localToGlobal(cc.p(0, 0))))

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setPivot(var_15_26.x, var_15_26.y, true)
		self._selectRect:setOpaque(true)
		self._guideLayer:addChild(self._selectRect)
		self._selectRect:setSize(var_15_25.width, var_15_25.height)
		self._selectRect:setPosition(var_15_27.x, var_15_27.y)
		self._selectRect:addEventListener(fgui.UIEventType.TouchBegin, function()
			self._target1:dispatchEvent(fgui.UIEventType.TouchBegin)
		end)
		self._selectRect:addEventListener(fgui.UIEventType.DragStart, function()
			self._target1:dispatchEvent(fgui.UIEventType.DragStart)
		end)
		self._selectRect:addEventListener(fgui.UIEventType.Drop, function()
			self._target2:dispatchEventLua(fgui.UIEventType.Drop, 0)
		end)

		local var_15_28 = self._target2:isPivotAsAnchor() and self._target2:getPivot() or cc.p(0, 0)
		local var_15_29 = self._guideLayer:globalToLocal((self._target2:localToGlobal(cc.p(0, 0))))
		local var_15_30 = self._target2:getSize()

		self._selectRect2 = fgui.GComponent:create()

		self._selectRect2:setPivot(var_15_28.x, var_15_28.y, true)
		self._selectRect2:setOpaque(true)
		self._selectRect2:setTouchable(true)
		self._guideLayer:addChild(self._selectRect2)
		self._selectRect2:setPosition(var_15_29.x, var_15_29.y)
		self._selectRect2:setSize(var_15_30.width, var_15_30.height)

		local var_15_31 = self._target1.getDragParam and self._target1:getDragParam() or 0

		if self:_needShowError() then
			assert(var_15_31 ~= 0, "can not get the drag target dataValue")
		end

		self._selectRect2:addEventListener(fgui.UIEventType.Drop, function()
			self._guideStepState = GuideService.STEP_END

			self._target2:dispatchEventLua(fgui.UIEventType.Drop, var_15_31)
			self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
			g.core.common.Scheduler:newScheduleOnce(function()
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			end, 0)

			if var_15_0.exitEvent and var_15_0.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[var_15_0.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[var_15_0.exitEvent])
			end

			self:_onStepEnd()
		end)
	elseif var_15_0.opeType == 4 then
		if var_15_0.comment then
			local var_15_32 = g.core.layer.LayerManager:getRoot()
			local var_15_34

			var_15_34, self._target1 = pcall(handler(var_15_32, var_15_32.getDeepChild), var_15_0.comment)

			if not self._target1 then
				local var_15_35

				var_15_35, self._target1 = pcall(handler(self._guideLayer, self._guideLayer.getDeepChild), var_15_0.comment)
			end

			if not self._target1 then
				self:_setIgnoreGuide("can't find the target selected Btn", var_15_0.comment)

				return true
			end
		end

		local var_15_36

		if self._target1 then
			local var_15_37 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
			local var_15_38 = self._target1:getSize()
			local var_15_39 = self._target1:getScale()
			local var_15_40 = self._target1:localToGlobal(cc.p(var_15_38.width * (0.5 - var_15_37.x), var_15_38.height * (0.5 - var_15_37.y)))

			var_15_36 = {
				globalCenterPos = var_15_40,
				centerPos = self._guideLayer:globalToLocal(var_15_40),
				originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_15_38.width * -var_15_37.x * var_15_39.x, var_15_38.height * -var_15_37.y * var_15_39.y))),
				size = var_15_38,
				scale = var_15_39,
				voice = var_15_0.voice
			}
		end

		self:_createGuideTip(var_15_0, var_15_36)

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setSize(display.width, display.height)
		self._selectRect:setPosition(cc.p(display.width / 2, display.height / 2))
		self._guideLayer:addChild(self._selectRect)
		self._selectRect:setOpaque(true)
		self._selectRect:setTouchable(true)
		self._selectRect:addClickListener(function(arg_26_0)
			self._guideStepState = GuideService.STEP_END

			self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
			g.core.common.Scheduler:newScheduleOnce(function()
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			end, 0)

			if var_15_0.exitEvent and var_15_0.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[var_15_0.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[var_15_0.exitEvent])
			end

			self:_onStepEnd()
			arg_26_0:stopPropagation()
		end)
	end

	self:_onCheckGuideStats()

	if tostring(var_15_0.adId) == "1670" then
		g.core.platform.PlatformProxy:sendAdvGuideCompleted()
	end
end

function GuideService:getListChangeComment(arg_28_1, arg_28_2)
	local var_28_0
	local var_28_1

	if type(arg_28_2) == "number" then
		var_28_0 = 1
		var_28_1 = arg_28_2
	else
		local var_28_2 = string.split(arg_28_2, "_")

		var_28_0 = tonumber(var_28_2[1])
		var_28_1 = tonumber(var_28_2[2])
	end

	local function var_28_3(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = 0

		for iter_29_0 in string.gmatch(arg_29_2, arg_29_0) do
			var_29_0 = var_29_0 + 1
		end

		if var_29_0 ~= #arg_29_1 then
			g.core.log:error("匹配数与传入数量不符：", arg_29_2)

			return arg_29_2
		end

		if not arg_29_1 or not next(arg_29_1) then
			return arg_29_2
		end

		if #arg_29_1 == 1 then
			arg_29_2 = string.gsub(arg_29_2, arg_29_0)

			return arg_29_2
		else
			for iter_29_1 = #arg_29_1, 1, -1 do
				arg_29_2 = string.gsub(arg_29_2, arg_29_0, arg_29_1[iter_29_1], iter_29_1)
			end

			return arg_29_2
		end
	end

	if var_28_0 == 1 then
		local var_28_4, var_28_5 = string.gsub(arg_28_1, "#%d", "#" .. g.core.model.User.CampaignData:getPosByCfgId(var_28_1))

		return var_28_4
	elseif var_28_0 == 2 then
		local var_28_6

		for iter_28_0, iter_28_1 in ipairs((require("app.view.module.recruit.const.RecruitFuncCfg"):getTabListCfgs())) do
			if iter_28_1.subTree then
				for iter_28_2, iter_28_3 in ipairs(iter_28_1.subTree) do
					local var_28_7

					if var_28_1 == iter_28_3.type then
						var_28_6 = iter_28_0 - 1
						var_28_7 = iter_28_2 - 1

						break
					end
				end
			end
		end

		return var_28_3("#%d", {
			"#" .. var_28_6,
			"#" .. nil
		}, arg_28_1)
	elseif var_28_0 == 3 then
		for iter_28_4, iter_28_5 in ipairs((g.core.model.User.guildCampaignData:getPlayDesInfo())) do
			if iter_28_5.cfgInfo.id == var_28_1 then
				local var_28_8, var_28_9 = string.gsub(arg_28_1, "#%d", "#" .. iter_28_4 - 1, 1)

				return var_28_8
			end
		end

		return arg_28_1
	elseif var_28_0 == 4 then
		for iter_28_6, iter_28_7 in ipairs((g.core.model.User.richmanData:getRightEventList())) do
			if iter_28_7.type == var_28_1 then
				local var_28_10, var_28_11 = string.gsub(arg_28_1, "#%d", "#" .. iter_28_6 - 1, 1)

				return var_28_10
			end
		end
	end
end

function GuideService:printTarget1Convert()
	if self._target1 then
		local var_30_0 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_30_1 = self._target1:getSize()
		local var_30_2 = self._target1:getScale()
		local var_30_3 = self._target1:localToGlobal(cc.p(var_30_1.width * (0.5 - var_30_0.x), var_30_1.height * (0.5 - var_30_0.y)))

		if config.DEBUG_VERSION then
			dump({
				globalCenterPos = var_30_3,
				centerPos = self._guideLayer:globalToLocal(var_30_3),
				originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_30_1.width * -var_30_0.x * var_30_2.x, var_30_1.height * -var_30_0.y * var_30_2.y))),
				size = var_30_1,
				scale = var_30_2,
				position = self._target1:getPosition(),
				convertPos = cc.p(var_30_1.width * (0.5 - var_30_0.x), var_30_1.height * (0.5 - var_30_0.y))
			}, "compParam")
		end
	end
end

function GuideService:_onStepEnd()
	if not self._curGuideIndex then
		return
	end

	local var_31_0 = self._guideData[self._curGuideIndex + 1]

	self:_removeGuideTip()
	self:_NotifySaveStepId()

	self._fightGuideReadyState = false

	if g.core.battle.BattleProxy:isInBattle() then
		if self._needGuideBattle and not var_31_0.followFront then
			self._needGuideBattle = false

			g.core.battle.BattleProxy:fightResume()
			self:_onGuideTouchStart()
		elseif self._needUseResume and not var_31_0.followFront then
			self._needUseResume = false

			g.core.battle.BattleProxy:resume()
			self:_onGuideTouchStart()
		end
	end

	local var_31_1 = g.core.battle.BattleProxy:getBattleLayer()

	if var_31_1 then
		var_31_1:setGuideUIVisible(true)
	end
end

function GuideService:_enterGuideOperate()
	self._guideState = GuideService.STATE_OPERATE
end

function GuideService:_enterGuideWait()
	self._guideState = GuideService.STATE_WAIT
end

function GuideService:_enterGuideExecute()
	self._guideState = GuideService.STATE_EXECUTE
end

function GuideService:_onCreateRole(arg_35_1, arg_35_2, arg_35_3)
	if g.core.platform.ServerListProxy:isForbiddedCreated(true) then
		g.core.network.GameNetProxy:closeManually()

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CREATE_ROLE, false, arg_35_2, arg_35_3)
	g.core.platform.ServerListProxy:saveLastServer((g.core.platform.ServerListProxy:getCurServer()))

	if not arg_35_3.need_activate then
		if g.core.module.ModuleManager:getCurModule().module == g.view.entrance.CREATE then
			return
		end

		self._fromCreate = true

		if GUIDE_EDIT or GUIDE_CLOSE then
			g.core.module.ModuleManager:pushModule(g.view.entrance.CREATE)
		else
			self:_initGuideData()

			self._storyList = {
				g.core.const.ConstMgr.StoryConst.CREATE_ROLE_TIP_STEP,
				g.core.const.ConstMgr.StoryConst.CREATE_ROLE_CG_STEP
			}
			self._storyStep = 1

			g.core.module.ModuleManager:clearModuleStack()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = self._storyList[self._storyStep]
			})
			;(function(arg_36_0)
				g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, function()
					self._storyStep = self._storyStep + 1

					if not self._storyList[self._storyStep] then
						g.core.event.EventManager:removeListenerWithTarget(self._storyKey)
						arg_36_0()
					else
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
							id = self._storyList[self._storyStep]
						})
					end
				end, self._storyKey)
			end)(function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.CREATE_MOVIE, true)
			end)
		end
	end
end

function GuideService:_onGameLoginFinish()
	if GUIDE_EDIT or GUIDE_CLOSE then
		if DEVELOP_UTILS_SUPPORT and LAUNCH_MODULE_DIRECTLY then
			g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance[LAUNCH_MODULE_DIRECTLY])
		else
			g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.HOME, true)
		end

		return
	end

	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("new_guide") then
		config.START_NEW_GUIDE = true
	end

	if config.START_NEW_GUIDE and not g.core.model.User.outpostData:isCanOutOutpost() then
		self:enterNewGuideState()
	else
		self:enterOldGuideState()
	end
end

function GuideService:enterNewGuideState()
	self:_initGuideData()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_UNLOCK_FEEDBACK_POP)
	g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.OUT_POST_STAGE, true)
end

function GuideService:enterOldGuideState()
	if GUIDE_EDIT or GUIDE_CLOSE then
		if DEVELOP_UTILS_SUPPORT and LAUNCH_MODULE_DIRECTLY then
			g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance[LAUNCH_MODULE_DIRECTLY])
		else
			g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.HOME, true)
		end

		self._isLaunching = false
	else
		local var_41_0 = g.core.model.User:getLevel()

		self:_initGuideData()

		if var_41_0 == 1 and self._isEnded then
			g.core.module.ModuleManager:clearModuleStack()

			self._guideWaitCount = 0

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_UNLOCK_FEEDBACK_POP)
			self:onEnterCreateRoleGuide()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 1
			})
		else
			if self:_checkSpecialBreakConnect() then
				g.core.module.ModuleManager:clearModuleStack()
				self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			else
				self:_gotoNormalModule()
			end

			self._isLaunching = false
		end
	end

	self:checkCurTickedGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_FLUSH)
end

function GuideService:onEnterCreateRoleGuide()
	g.core.model.User.storyData:endPlay()
	g.core.event.EventManager:removeListenerWithTarget(self._storyKey)
end

function GuideService:_checkSpecialBreakConnect()
	local var_43_0 = g.core.model.User:getGuideId()

	if self._createSteps[var_43_0] then
		self._guideData = self._guideDatas.stepIndices[self._guideDatas.stepIndices[var_43_0].data.resetId].guideData
		self._curGuideIndex = self._guideDatas.stepIndices[self._guideDatas.stepIndices[var_43_0].data.resetId].index - 1
		self._createTick = true

		self:setIsEnded(false)

		return true
	end

	return false
end

function GuideService:_onHomeGuideCheck()
	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("new_guide") then
		config.START_NEW_GUIDE = true
	end

	if config.START_NEW_GUIDE and not g.core.model.User.outpostData:isCanOutOutpost() then
		return
	end

	self:checkCurTickedGuide()

	if self._isEnded then
		if g.core.model.User:getLevel() == 1 and g.core.model.User:getGuideId() == 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 1
			})

			return
		end

		if not self._guideData or not self._curGuideIndex then
			return
		end

		local var_44_0 = self._guideData[self._curGuideIndex + 1]

		if self._guideData[self._curGuideIndex + 1] then
			self:setIsEnded(false)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_UNLOCK_FEEDBACK_POP)

			if var_44_0.moduleName ~= "HOME" then
				g.core.module.ModuleManager:pushModule(g.view.entrance[var_44_0.moduleName], var_44_0.moduleParams[1])
			end

			self:_lockScreen(true)
			self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
			g.core.common.Scheduler:newScheduleOnce(handler(self, function()
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			end), 0)
		end
	end
end

function GuideService:_onGameLoginResume()
	local var_46_0 = g.core.module.ModuleManager:getCurModule()

	if var_46_0 and var_46_0.module == g.view.entrance.LOGIN then
		self:_onGameLoginFinish()

		if self._isLaunching then
			self:_onNetInteractiveTaskFinish()
		end
	end
end

function GuideService:_onNetDisconnected()
	self._disConnectNumber = self._disConnectNumber or 0
	self._disConnectNumber = self._disConnectNumber + 1

	self:_onGuideStateWait(var_0_3.WAIT_NET_DISCONNECT)
end

function GuideService:_onNetTimeOut()
	self:_onGuideStateWait(var_0_3.WAIT_NET_TIMEOUT)
end

function GuideService:_onNetReconnect()
	self._disConnectNumber = self._disConnectNumber or 0
	self._disConnectNumber = self._disConnectNumber - 1

	self:_onGuideStateReady(var_0_3.READY_NET_RE_CONNECT)
end

function GuideService:_onNetLoginExpired()
	self:_stopGuide()
end

function GuideService:_onNetLoginNotify()
	if self._disConnectNumber and self._disConnectNumber > 0 and self._guideWaitCount >= self._disConnectNumber then
		self._guideWaitCount = self._guideWaitCount - self._disConnectNumber
		self._disConnectNumber = 0

		self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
		self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
	end
end

function GuideService:_onLoginRepeat()
	self:_stopGuide()
end

function GuideService:_onNetServerBroken()
	self:_stopGuide()
end

function GuideService:_onNetInteractiveTaskFinish1()
	if self._fromCreate then
		self:_onNetInteractiveTaskFinish()
	end
end

function GuideService:_onNetInteractiveTaskFinish()
	if self._isLaunching then
		self._isLaunching = false
	end
end

function GuideService:_onGuideStateWait(arg_56_1, arg_56_2)
	if self._guideWaitCount == 0 then
		self:_enterGuideWait()

		if self._guideStepState ~= GuideService.STEP_OPE then
			self:_removeGuideTip()
		end
	end

	self._guideWaitCount = self._guideWaitCount + (arg_56_2 or 1)

	if self._guideDebug then
		self._guideDebug:pushWaitInfo(arg_56_1, self)
	end

	table.insert(self._debugList, {
		name = "wait",
		event = arg_56_1,
		count = self._guideWaitCount
	})

	self._debugList[#self._debugList].trace = debug.traceback()

	if self._allWaitTraceback then
		local var_56_0 = {}

		if type(arg_56_1) == "string" and arg_56_1 ~= g.core.event.enum.EVENT_GUIDE_WAIT then
			var_56_0.event = arg_56_1
		else
			var_56_0.traceback = debug.traceback()
		end

		table.insert(self._allWaitTraceback, 1, var_56_0)
	end
end

function GuideService:_onGuideStateReady(arg_57_1, arg_57_2)
	if self._guideDebug then
		self._guideDebug:checkReadyInfo(arg_57_1, self)
	end

	if self._guideState ~= GuideService.STATE_WAIT then
		table.insert(self._debugList, {
			event = "Ready-----------Return",
			trace = debug.traceback()
		})

		return
	end

	if arg_57_2 then
		if self._guideWaitCount > 1 and self._allWaitTraceback then
			local var_57_0 = {
				event = {}
			}

			for iter_57_0, iter_57_1 in ipairs(self._allWaitTraceback) do
				if iter_57_1.event then
					var_57_0.event[iter_57_1.event] = var_57_0.event[iter_57_1.event] or 0
					var_57_0.event[iter_57_1.event] = var_57_0.event[iter_57_1.event] + 1
				end
			end

			g.core.platform.BuglyProxy:trace(var_0_1.MODULE_GUIDE, json.encode(var_57_0))

			for iter_57_2, iter_57_3 in ipairs(self._allWaitTraceback) do
				if iter_57_3.traceback then
					g.core.platform.BuglyProxy:trace(var_0_1.MODULE_GUIDE, json.encode(iter_57_3.traceback))
				end
			end

			g.core.platform.BuglyProxy:error("Invalid guide wait count: " .. tostring(self._guideWaitCount))

			self._guideWaitCount = 1
		end

		self._allWaitTraceback = nil
	end

	if self._guideWaitCount == 0 then
		return
	end

	if self._allWaitTraceback then
		local var_57_1 = {}

		if type(arg_57_1) == "string" and arg_57_1 ~= g.core.event.enum.EVENT_GUIDE_READY then
			var_57_1.event = arg_57_1
		else
			var_57_1.traceback = debug.traceback()
		end

		table.insert(self._allWaitTraceback, 1, var_57_1)
	end

	self._guideWaitCount = self._guideWaitCount - 1

	if self._guideDebug then
		self._guideDebug:pushReadyInfo(arg_57_1, self)
	end

	table.insert(self._debugList, {
		name = "ready",
		event = arg_57_1,
		count = self._guideWaitCount
	})

	self._debugList[#self._debugList].trace = debug.traceback()

	if self._guideWaitCount == 0 then
		if self._guideDebug then
			self._guideDebug:checkExecuteInfo(arg_57_1, self)
		end

		if not self._isEnded then
			if self._guideStepState == GuideService.STEP_OPE then
				return
			end

			table.insert(self._debugList, {
				name = "execute",
				event = arg_57_1,
				count = self._guideWaitCount
			})
			self:_enterGuideExecute()
		end
	end
end

function GuideService:dumpDebugLog()
	dump(self._debugList)
	print("---------------------->", self._guideTouchStartCount)
	print("--------------thisStep ----->", self._curGuideIndex)

	if self._guideDebug then
		self._guideDebug:showAllLog(self)
	end
end

function GuideService:getDebugLog()
	return self._debugList, self._curGuideIndex
end

function GuideService:_onGuideStateExecute()
	self:_enterGuideExecute()

	if self._selectRect then
		self._selectRect:setTouchable(false)
		self._selectRect:setVisible(false)
	end

	if self._selectRect2 then
		self._selectRect2:setTouchable(false)
		self._selectRect2:setVisible(false)
	end
end

function GuideService:_onGuideTouchStart()
	if self._isEnded then
		return
	end

	if self._guideTouchStartCount == 0 then
		self:_lockScreen(false)
	end

	self._guideTouchStartCount = self._guideTouchStartCount + 1
end

function GuideService:_onGuideTouchEnd()
	if self._guideTouchStartCount == 0 then
		if self._guideStepState == GuideService.STEP_END then
			self._waitOpeStepTouchEndNum = self._waitOpeStepTouchEndNum or 0
			self._waitOpeStepTouchEndNum = self._waitOpeStepTouchEndNum + 1
		end

		return
	end

	self._guideTouchStartCount = self._guideTouchStartCount - 1

	if self._guideTouchStartCount == 0 and not self._isEnded then
		self:_lockScreen(true)
	end
end

function GuideService:_checkWeakGuideShow()
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if not self._isEnded then
		return
	end

	if self._runningWeakGuide then
		return
	end

	self:_removeGuideTip()

	self._curRunningWeakGuide = nil
	self._curRunningWeakGuideId = nil

	for iter_63_0, iter_63_1 in pairs(self._weakGuideTickList) do
		if self._weakGuideDatas.stepIndices[iter_63_0] then
			if self._weakGuideDatas.stepIndices[iter_63_0].data.played then
				self._curRunningWeakGuide = self._weakGuideDatas.stepIndices[iter_63_0].data
				self._curRunningWeakGuideId = iter_63_0

				break
			end

			if self._weakGuideDatas.stepIndices[iter_63_0].data and self:_checkGuideScene(self._weakGuideDatas.stepIndices[iter_63_0].data, true) then
				self._curRunningWeakGuide = self._weakGuideDatas.stepIndices[iter_63_0].data
				self._curRunningWeakGuideId = iter_63_0

				break
			end
		end
	end

	if self._curRunningWeakGuide then
		self._runningWeakGuide = true

		g.core.common.Scheduler:newScheduleOnce(function()
			self._runningWeakGuide = false

			self:_executeWeakGuide(self._curRunningWeakGuide)
		end, 0)
	end
end

function GuideService:isRunningWeakGuide()
	return self._runningWeakGuide
end

function GuideService:_executeWeakGuide(arg_66_1)
	if arg_66_1.enterEvent and arg_66_1.enterEvent ~= 0 and var_0_2.GUIDE_EVENT[arg_66_1.enterEvent] then
		g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[arg_66_1.enterEvent])
	end

	g.core.model.User.guideData:onWeakGuideExec(arg_66_1.stepId)

	if self:_checkWeakStory(arg_66_1) then
		return
	end

	self:_removeGuideTip()

	if arg_66_1 and arg_66_1.adId and tostring(arg_66_1.adId) ~= "0" and not arg_66_1.sendStats then
		local var_66_0 = g.core.config.guide_log_info.fetch(tonumber(arg_66_1.adId))

		if var_66_0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = arg_66_1.adId,
				value = var_66_0.des
			})

			arg_66_1.sendStats = true
		end
	end

	if arg_66_1.opeType == 1 then
		if arg_66_1.exitEvent and arg_66_1.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[arg_66_1.exitEvent] then
			g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[arg_66_1.exitEvent])
		end

		self:_onWeakGuideStepEnd()
	elseif arg_66_1.opeType == 2 then
		if arg_66_1.comment then
			local var_66_1 = arg_66_1.comment

			if arg_66_1.listBindId and arg_66_1.listBindId ~= 0 and arg_66_1.listBindId ~= "" then
				var_66_1 = self:getListChangeComment(var_66_1, arg_66_1.listBindId)
			end

			local var_66_2 = g.core.layer.LayerManager:getRoot()
			local var_66_4, var_66_5 = pcall(handler(var_66_2, var_66_2.getDeepChild), var_66_1)

			self._target1 = var_66_5

			if not var_66_4 or not self._target1 then
				return true
			end
		end

		local var_66_6 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_66_7 = self._target1:getSize()
		local var_66_8 = self._target1:getScale()
		local var_66_9 = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_66_7.width * (0.5 - var_66_6.x), var_66_7.height * (0.5 - var_66_6.y))))

		self:_createGuideTip(arg_66_1, {
			centerPos = var_66_9,
			originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_66_7.width * -var_66_6.x * var_66_8.x, var_66_7.height * -var_66_6.y * var_66_8.y))),
			size = var_66_7,
			voice = arg_66_1.voice
		})

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setName(arg_66_1.stepId)
		self._selectRect:setOpaque(true)
		self._guideLayer:addChild(self._selectRect)
		self._selectRect:setSize(var_66_7.width, var_66_7.height)
		self._selectRect:setPivot(0.5, 0.5, true)
		self._selectRect:setPosition(var_66_9)
		self._selectRect:addEventListener(fgui.UIEventType.TouchBegin, function()
			self._target1:dispatchEvent(fgui.UIEventType.TouchBegin)
		end)
		self._selectRect:addEventListener(fgui.UIEventType.TouchEnd, function()
			self._target1:dispatchEvent(fgui.UIEventType.TouchEnd)
		end)
		self._selectRect:addClickListener(function(arg_69_0)
			if arg_66_1.listItemIndex then
				self._target1:bubbleEvent(fgui.UIEventType.Click)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_PLAY_UNITE_TOKEN_SKILL, false, {
					target = self._target1
				})
			else
				self._target1:dispatchEvent(fgui.UIEventType.Click)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_PLAY_UNITE_TOKEN_SKILL, false, {
					target = self._target1
				})
			end

			if arg_66_1.exitEvent and arg_66_1.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[arg_66_1.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[arg_66_1.exitEvent])
			end

			self:_onWeakGuideStepEnd(true)
		end)
	elseif arg_66_1.opeType == 3 then
		if arg_66_1.comment then
			local var_66_10 = g.core.layer.LayerManager:getRoot()
			local var_66_12, var_66_13 = pcall(handler(var_66_10, var_66_10.getDeepChild), arg_66_1.comment)

			self._target1 = var_66_13

			if var_66_12 and self._target1 then
				local var_66_14, var_66_15 = pcall(handler(var_66_10, var_66_10.getDeepChild), arg_66_1.comment2)

				self._target2 = var_66_15

				if not var_66_14 or not self._target2 then
					return true
				end
			else
				return true
			end
		end

		local var_66_16 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_66_17 = self._target1:getSize()
		local var_66_18 = self._target1:getScale()
		local var_66_19 = self._target1:localToGlobal(cc.p(var_66_17.width * (0.5 - var_66_16.x), var_66_17.height * (0.5 - var_66_16.y)))
		local var_66_20 = self._target2:isPivotAsAnchor() and self._target2:getPivot() or cc.p(0, 0)
		local var_66_21 = self._target2:getSize()
		local var_66_22 = self._target2:getScale()
		local var_66_23 = self._target2:localToGlobal(cc.p(var_66_21.width * (0.5 - var_66_20.x), var_66_21.height * (0.5 - var_66_20.y)))

		self:_createGuideTip(arg_66_1, {
			globalCenterPos = var_66_19,
			centerPos = self._guideLayer:globalToLocal(var_66_19),
			originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_66_17.width * -var_66_16.x * var_66_18.x, var_66_17.height * -var_66_16.y * var_66_18.y))),
			size = var_66_17,
			globalCenterPos1 = var_66_23,
			centerPos1 = self._guideLayer:globalToLocal(var_66_23),
			originPos1 = self._guideLayer:globalToLocal(self._target2:localToGlobal(cc.p(var_66_21.width * -var_66_16.x * var_66_22.x, var_66_21.height * -var_66_16.y * var_66_22.y))),
			voice = arg_66_1.voice
		}, true)

		local var_66_24 = self._target1:getSize()
		local var_66_25 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_66_26 = self._guideLayer:globalToLocal((self._target1:localToGlobal(cc.p(0, 0))))

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setPivot(var_66_25.x, var_66_25.y, true)
		self._selectRect:setOpaque(true)
		self._guideLayer:addChild(self._selectRect)
		self._selectRect:setSize(var_66_24.width, var_66_24.height)
		self._selectRect:setPosition(var_66_26.x, var_66_26.y)
		self._selectRect:addEventListener(fgui.UIEventType.TouchBegin, function()
			self._target1:dispatchEvent(fgui.UIEventType.TouchBegin)
		end)
		self._selectRect:addEventListener(fgui.UIEventType.DragStart, function()
			self._target1:dispatchEvent(fgui.UIEventType.DragStart)
		end)

		local var_66_27 = self._target2:isPivotAsAnchor() and self._target2:getPivot() or cc.p(0, 0)
		local var_66_28 = self._guideLayer:globalToLocal((self._target2:localToGlobal(cc.p(0, 0))))
		local var_66_29 = self._target2:getSize()

		self._selectRect2 = fgui.GComponent:create()

		self._selectRect2:setPivot(var_66_27.x, var_66_27.y, true)
		self._selectRect2:setOpaque(true)
		self._selectRect2:setTouchable(true)
		self._guideLayer:addChild(self._selectRect2)
		self._selectRect2:setPosition(var_66_28.x, var_66_28.y)
		self._selectRect2:setSize(var_66_29.width, var_66_29.height)

		local var_66_30 = self._target1.getSkillId and self._target1:getSkillId() or 0

		if self:_needShowError() then
			assert(var_66_30 ~= 0, "can not get the drag target dataValue")
		end

		self._selectRect2:addEventListener(fgui.UIEventType.Drop, function()
			self._target2:dispatchEventLua(fgui.UIEventType.Drop, var_66_30)

			if arg_66_1.exitEvent and arg_66_1.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[arg_66_1.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[arg_66_1.exitEvent])
			end

			self:_onWeakGuideStepEnd()
		end)
	elseif arg_66_1.opeType == 4 then
		if arg_66_1.comment then
			local var_66_31 = g.core.layer.LayerManager:getRoot()
			local var_66_33

			var_66_33, self._target1 = pcall(handler(var_66_31, var_66_31.getDeepChild), arg_66_1.comment)

			if not self._target1 then
				local var_66_34

				var_66_34, self._target1 = pcall(handler(self._guideLayer, self._guideLayer.getDeepChild), arg_66_1.comment)
			end

			if not self._target1 then
				return true
			end
		end

		local var_66_36 = self._target1:isPivotAsAnchor() and self._target1:getPivot() or cc.p(0, 0)
		local var_66_37 = self._target1:getSize()
		local var_66_38 = self._target1:getScale()
		local var_66_39 = self._target1:localToGlobal(cc.p(var_66_37.width * (0.5 - var_66_36.x), var_66_37.height * (0.5 - var_66_36.y)))

		self:_createGuideTip(arg_66_1, {
			globalCenterPos = var_66_39,
			centerPos = self._guideLayer:globalToLocal(var_66_39),
			originPos = self._guideLayer:globalToLocal(self._target1:localToGlobal(cc.p(var_66_37.width * -var_66_36.x * var_66_38.x, var_66_37.height * -var_66_36.y * var_66_38.y))),
			size = var_66_37,
			voice = arg_66_1.voice
		})

		self._selectRect = fgui.GComponent:create()

		self._selectRect:setPosition(cc.p(display.width / 2, display.height / 2))
		self._guideLayer:addChild(self._selectRect, 1000)
		self._selectRect:setSize(display.width, display.height)
		self._selectRect:setOpaque(true)
		self._selectRect:setTouchable(true)
		self._selectRect:addClickListener(function(arg_73_0)
			arg_73_0:stopPropagation()

			if arg_66_1.exitEvent and arg_66_1.exitEvent ~= 0 and var_0_2.GUIDE_EVENT[arg_66_1.exitEvent] then
				g.core.event.EventManager:dispatchEvent(var_0_2.GUIDE_EVENT[arg_66_1.exitEvent])
			end

			self:_onWeakGuideStepEnd()
		end)
	end
end

function GuideService:_onWeakGuideStepEnd(arg_74_1)
	if self._curRunningWeakGuideId then
		self._weakGuideTickList[self._curRunningWeakGuideId] = nil

		if self._weakGuideDatas.stepIndices[self._curRunningWeakGuideId].guideData[self._weakGuideDatas.stepIndices[self._curRunningWeakGuideId].index + 1] then
			self._weakGuideTickList[self._weakGuideDatas.stepIndices[self._curRunningWeakGuideId].guideData[self._weakGuideDatas.stepIndices[self._curRunningWeakGuideId].index + 1].stepId] = true
		else
			self._curRunningWeakGuide = nil
			self._curRunningWeakGuideId = nil
		end

		self:_saveWeakGuideSteps()
	end

	self._exitWithUnlock = false

	if not arg_74_1 then
		self:_checkWeakGuideShow()
	end
end

function GuideService:_saveWeakGuideSteps()
	local var_75_0 = {}

	for iter_75_0, iter_75_1 in pairs(self._weakGuideTickList) do
		table.insert(var_75_0, iter_75_0)
	end

	g.core.common.Storage:save("weak_guide_step_ids.json", {
		weakList = var_75_0
	}, true)
end

function GuideService:_loadWeakGuideSteps()
	local var_76_0 = g.core.common.Storage:load("weak_guide_step_ids.json", true)
	local var_76_1

	if var_76_0 then
		var_76_1 = var_76_0.weakList or {}
	end

	self._weakGuideTickList = {}

	for iter_76_0, iter_76_1 in ipairs(var_76_1) do
		self._weakGuideTickList[iter_76_1] = true
	end
end

function GuideService:_onGuideCheck(arg_77_1, arg_77_2)
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if self:_ignoreGuide() then
		return
	end

	local var_77_0 = arg_77_2.level or arg_77_2.funcId or arg_77_2.stageId or arg_77_2.enum
	local var_77_1 = tostring(arg_77_2.tickType)
	local var_77_2 = tostring(var_77_0)

	self:_loadTickedGuide()
	self:checkCurTickedGuide()

	if arg_77_2.tickType ~= var_0_2.TICK_CONST.CREATE and self._guideTickedMap and self._guideTickedMap[var_77_1] and self._guideTickedMap[var_77_1][var_77_2] then
		return
	end

	local var_77_3, var_77_4, var_77_5 = self:_checkGuide(arg_77_2)

	self:_saveWeakGuideSteps()

	if var_77_3 then
		self._guideTickedMap[var_77_1] = self._guideTickedMap[var_77_1] or {}
		self._guideTickedMap[var_77_1][var_77_2] = true

		if not self._isEnded then
			-- block empty
		else
			self._guideData = var_77_4
			self._curGuideIndex = var_77_5
			self._tickBindLayerName = self._guideData[1].layerName

			self:setIsEnded(false)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TICKED_SUCCESS)

			if self._guideTouchStartCount == 0 then
				self:_lockScreen(true)
			end

			if arg_77_2.tickType ~= var_0_2.TICK_CONST.BATTLE_FAIL then
				g.core.network.GameNetProxy:send_C2S_Guide_Set({
					id = self._guideData[self._curGuideIndex + 1].stepId
				}, true)

				self._sentCache[self._guideData[self._curGuideIndex + 1].stepId] = true
			end

			self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
			g.core.common.Scheduler:newScheduleOnce(function()
				self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
			end, 0.2)
		end
	end

	self:_saveTickedGuide()
end

function GuideService:_resetBattleVar()
	self._needUseResume = false
	self._bossFull = false
	self._battleId = nil
	self._battleWave = nil
	self._battleRound = nil
	self._battleValueMatchCount = nil
	self._needGuideBattle = false
	self._battleValueMatchCount1 = nil
end

function GuideService:_onBattleStart(arg_80_1, arg_80_2)
	if self._isEnded then
		return
	end

	self:_resetBattleVar()

	if not self._guideData[self._curGuideIndex + 1] then
		return
	end

	self._battleId = arg_80_2.value

	g.core.battle.BattleProxy:setInGuide(true)

	local var_80_0 = g.core.model.User.dungeonData:isStagePassed(200102)
	local var_80_1 = g.core.model.User.dungeonData:isStagePassed(200203)
	local var_80_2 = g.core.model.User.dungeonData:isStagePassed(200202)

	g.core.battle.BattleProxy:setSkillShow(40020, var_80_0)
	g.core.battle.BattleProxy:setSkillShow(40030, var_80_1)
	g.core.battle.BattleProxy:setSkillShow(30003, var_80_2)
	g.core.battle.BattleProxy:setSkillUIShow(var_80_0 or var_80_1 or var_80_2)
end

function GuideService:_onBattleEnd()
	self:_clearBattleSoftComp()

	if self._isEnded then
		return
	end

	if self._battleEndNotifyId and not self._sentCache[self._battleEndNotifyId] and not self._isDebugGuide then
		if not var_0_6[self._battleEndNotifyId] then
			g.core.network.GameNetProxy:send_C2S_Guide_Set({
				id = self._battleEndNotifyId
			}, true)

			self._sentCache[self._battleEndNotifyId] = true
		end

		self._battleEndNotifyId = nil
	end

	if self._inTestBattle then
		self._inTestBattle = false

		if self._inWaitEvent then
			self._inWaitEvent = false

			self:_onGuideStateReady(var_0_3.READY_BATTLE_END)
		end

		self:_onGuideStateWait(var_0_3.WAIT_FAKE_PVP_RESULT)

		self._fromBattleEnd = true
		self._guideData[self._curGuideIndex + 1].ignoreScene = true

		if g.core.battle.BattleProxy:isInBattle() then
			(function(arg_82_0)
				g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FAKE_PVP_BATTLE_RESULT, function()
					g.core.event.EventManager:removeListenerWithTarget("battle_end_event")
					arg_82_0()
				end, "battle_end_event")
			end)(function()
				self:_onGuideStateReady(var_0_3.READY_FAKE_PVP_RESULT)
			end)
		else
			g.core.common.Scheduler:newScheduleOnce(function()
				self:_onGuideStateReady(var_0_3.READY_FAKE_PVP_RESULT)
			end, 0.5)
		end

		self:_filterBattleStepAfterBattle()

		self._curGuideIndex = self._curGuideIndex - 1
	else
		if self._inWaitEvent then
			self._inWaitEvent = false

			self:_onGuideStateReady(var_0_3.READY_BATTLE_END)
		end

		self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
		g.core.common.Scheduler:newScheduleOnce(function()
			self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
		end, 0.5)
		self:_filterBattleStepAfterBattle()
	end
end

function GuideService:_filterBattleStepAfterBattle()
	local var_87_1 = 1

	repeat
		if not self._guideData[self._curGuideIndex + var_87_1] then
			self._curGuideIndex = self._curGuideIndex + var_87_1 - 1
			var_87_0 = true

			return
		end

		if self._guideData[self._curGuideIndex + var_87_1].resetId and self._guideData[self._curGuideIndex + var_87_1].resetId == 99999 then
			if not self._sentCache[self._guideData[self._curGuideIndex + var_87_1].stepId] and not self._isDebugGuide then
				g.core.network.GameNetProxy:send_C2S_Guide_Set({
					id = self._guideData[self._curGuideIndex + var_87_1].stepId
				}, true)

				self._sentCache[self._guideData[self._curGuideIndex + var_87_1].stepId] = true
			end

			self:_stopGuide()

			return
		end

		if self._guideData[self._curGuideIndex + var_87_1].waitEvent then
			var_87_1 = var_87_1 + 1
		else
			self._curGuideIndex = self._curGuideIndex + var_87_1 - 1
			var_87_0 = true
		end
	until false
end

function GuideService:_onBattleAnimeEnd(arg_88_1)
	self:debugTip("收到战斗暂停成功回调")

	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end

	if not self._needGuideBattle then
		return
	end

	self:debugTip("即将触发引导")

	self._needUseResume = false
	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_ANIME_END)
end

function GuideService:_onBattleHpBarShow(arg_89_1, arg_89_2)
	if self._isEnded then
		return
	end
end

function GuideService:_onBattleWaveStart(arg_90_1, arg_90_2)
	if self._isEnded then
		return
	end

	self._battleWave = arg_90_2.value
end

function GuideService:_onOwnTeamChanged(arg_91_1, arg_91_2)
	if self._isEnded then
		return
	end

	if self:_checkFirstBattleGuideSecondTeamStart(arg_91_2.value) then
		return
	end
end

function GuideService:_onRoundUpdate(arg_92_1, arg_92_2)
	if self._isEnded then
		return
	end

	self._battleRound = arg_92_2.value.round

	if self:_checkMainBattle2_2GuideThreeRound(arg_92_2.value.round) then
		return
	end
end

function GuideService:_onBattleNewSkill(arg_93_1, arg_93_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end

	local var_93_0 = arg_93_2.value

	if self:_checkFirstBattleGuideComboValueFirstMatch(arg_93_2.value.value) then
		return
	end

	if self:_checkFirstBattleGuideComboValueSecondMatch(var_93_0.value) then
		return
	end

	if self:_checkMainBattle1_2GuideComboValueMatch(var_93_0.value) then
		return
	end
end

function GuideService:_onBattleHPChanged(arg_94_1, arg_94_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end

	local var_94_0 = arg_94_2.value

	if self:_checkFirstBattleGuideMainRoleHp(arg_94_2.value.hp / arg_94_2.value.maxHp * 100, arg_94_2.value.id) then
		return
	end

	if self:_checkMainBattle1_2GuideMonsterHp(var_94_0.hp / var_94_0.maxHp * 100, var_94_0.identity, var_94_0.pos) then
		return
	end

	if self:_checkMainBattle1_4GuideFirstMonsterDestroy(var_94_0.totalHp, var_94_0.identity) then
		return
	end
end

function GuideService:_onBattleAngerChanged(arg_95_1, arg_95_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end
end

function GuideService:_onBattleATKBefore(arg_96_1, arg_96_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end

	if self:_checkMainBattle1_1GuideMainRoleWillUseSkill(arg_96_2.value.advanceId, arg_96_2.value.isFull) then
		return
	end
end

function GuideService:_onBattleSkillBefore(arg_97_1, arg_97_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end

	local var_97_0 = arg_97_2.value

	if self:_checkMainBattle1_1GuideBattleStart(arg_97_2.value.actor) then
		return
	end

	if self:_checkMainBattle2_1PassiveSkillTriggled(nil, var_97_0.skillId) then
		return
	end
end

function GuideService:_onBattlePassiveTriggle(arg_98_1, arg_98_2)
	if self._isEnded then
		return
	end

	if not self._guideData[self._curGuideIndex + 1] or not self._guideData[self._curGuideIndex + 1].inBattle then
		return
	end
end

function GuideService:_onDungeonChallengeStageFinish(arg_99_1, arg_99_2, arg_99_3)
	if self._isEnded then
		return
	end

	local var_99_0 = {
		[10000] = {
			1030,
			g.core.lang:get(1104)
		},
		[10020] = {
			1260,
			g.core.lang:get(1105)
		},
		[10060] = {
			1330,
			g.core.lang:get(1106)
		},
		[10080] = {
			1610,
			g.core.lang:get(1107)
		},
		[10100] = {
			1860,
			g.core.lang:get(1108)
		}
	}

	if arg_99_3.id and var_99_0[arg_99_3.id] then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = var_99_0[arg_99_3.id][1],
			value = var_99_0[arg_99_3.id][2]
		})
	end
end

function GuideService:_checkStory()
	if self._isEnded then
		return
	end

	local var_100_0 = self._guideData[self._curGuideIndex + 1]

	if not self._guideData[self._curGuideIndex + 1] or var_100_0.played then
		return
	end

	if not g.core.model.User.storyData:isInStory() and var_100_0.storyId and var_100_0.storyId ~= 0 then
		var_100_0.played = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_100_0.storyId,
			subEvent = g.core.event.enum.EVENT_GUIDE_STORY_PROCESSING
		})

		self._playingGuideStory = true

		return true
	end

	return false
end

function GuideService:_checkWeakStory(arg_101_1)
	if not self._isEnded then
		return
	end

	local var_101_0 = arg_101_1

	if not arg_101_1 or var_101_0.played then
		return
	end

	if not g.core.model.User.storyData:isInStory() and var_101_0.storyId and var_101_0.storyId ~= 0 then
		var_101_0.played = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_101_0.storyId,
			subEvent = g.core.event.enum.EVENT_GUIDE_STORY_PROCESSING
		})

		self._playingGuideStory = true

		return true
	end

	return false
end

function GuideService:_onStoryStart(arg_102_1, arg_102_2)
	if self._isEnded then
		self:_lockScreen(false)

		return
	end

	self:_onGuideStateWait(var_0_3.WAIT_STORY_OVER)
	self:_onGuideTouchStart()
	self._skipComp:setVisible(false)
end

function GuideService:_onStoryEnd(arg_103_1, arg_103_2)
	self:changeSkipBtnVisible()

	self._playingGuideStory = false

	if self._isEnded then
		self:_checkWeakGuideShow()

		return
	end

	self:_onGuideTouchEnd()
	self:_onGuideStateReady(var_0_3.READY_STORY_OVER)
end

function GuideService:_onSpeUniteTokenMovieFinish()
	self:_onGuideTouchEnd()
	self:_onGuideStateReady()
end

function GuideService:onUserDataBack()
	if g.core.model.User:getGuideId() == var_0_2.GUIDE_SERVER_CLOSE_ID then
		self:_stopGuide()

		GUIDE_CLOSE = true
	end
end

function GuideService:_onStoryForceStart(arg_106_1, arg_106_2)
	if self._isEnded then
		return
	end
end

function GuideService:_onCheckGuideStats()
	if not self._curGuideData then
		return
	end

	local var_107_0 = self._curGuideData

	if self._curGuideData and var_107_0.adId and tostring(var_107_0.adId) ~= "0" and not var_107_0.sendStats then
		local var_107_1 = g.core.config.guide_log_info.fetch(tonumber(var_107_0.adId))

		if var_107_1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = var_107_0.adId,
				value = var_107_1.des
			})

			var_107_0.sendStats = true
		end
	end
end

function GuideService:_onModuleEnter(arg_108_1, arg_108_2, arg_108_3)
	if self._isEnded then
		self:_removeGuideTip()

		return
	end

	if self._guideStepState == GuideService.STEP_OPE then
		if g.core.model.User.storyData:isInStory() then
			return
		end

		self._guideStepState = GuideService.STEP_END
		self._curGuideIndex = self._curGuideIndex - self._lastStepOffset
		self._lastStepOffset = 0

		self:_removeGuideTip()
		self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
		g.core.common.Scheduler:newScheduleOnce(function()
			self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
		end, 0.2)
	end
end

function GuideService:_onModuleExit()
	if self._exitWithUnlock then
		self:_lockScreen(false)

		self._exitWithUnlock = false
	end
end

function GuideService:_onRemoveGuideComp()
	self:_removeGuideTip()
end

function GuideService:_onModuleRootEnter(arg_112_1, arg_112_2, arg_112_3)
	if self._isEnded then
		return
	end

	self:_removeGuideTip()
end

function GuideService:_onDungeonSpecialLockScene()
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if self._isEnded then
		return
	end

	self:_lockScreen(true)

	self._speScheduler = g.core.common.Scheduler:newScheduleOnce(handler(self, self._schedulerCheckGuideState), 5)
end

function GuideService:_schedulerCheckGuideState()
	self._guideWaitCount = 0

	self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
	self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
end

function GuideService:_lockScreen(arg_115_1)
	if self._guideLayer then
		self:_onSafeScheduleCancel()
		self._guideLayer:setRevertHitRect(arg_115_1 and cc.rect(0, 0, 0, 0) or cc.rect(0, 0, display.width * 2, display.height * 2))

		if g.core.model.User:getLevel() > 7 then
			if arg_115_1 then
				self:_onSafeScheduleStart()
			elseif self._skipComp then
				self:changeSkipBtnVisible()
			end
		end
	end
end

function GuideService:_beforeStopGuide()
	if g.core.battle.BattleProxy:isInBattle() then
		if self._needGuideBattle then
			self._needGuideBattle = false

			g.core.battle.BattleProxy:fightResume()
			self:_onGuideTouchStart()
		elseif self._needUseResume then
			self._needUseResume = false

			g.core.battle.BattleProxy:resume()
			self:_onGuideTouchStart()
		end
	end
end

function GuideService:changeSkipBtnVisible()
	if g.core.model.User.guideData:isNeedShowSkip() then
		self._skipComp:setVisible(true)
	else
		self._skipComp:setVisible(false)
	end
end

function GuideService:_onSkipGuideClick()
	if not self._skipTips then
		self._skipTips = require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(2602),
			desc = g.core.lang:get(2603),
			onCancel = handler(self, self._onSkipCancel),
			onConfirm = handler(self, self._onSkipConfirm)
		})

		self._skipTips:setOpeWithOutClose(true)
		self._skipTips:setPosition(display.cx, display.cy)
		g.core.layer.LayerManager:getGuideTopLayer():addChild(self._skipTips, 9999999)
	else
		self._skipTips:setVisible(true)
	end
end

function GuideService:_onSkipCancel()
	self._skipTips:setVisible(false)
end

function GuideService:_onSkipConfirm()
	self._skipTips:setVisible(false)
	self:_stopGuide()
end

function GuideService:_stopGuide(arg_121_1)
	if arg_121_1 then
		g.core.log:info("force guide finish--------------------->")
	end

	self:_beforeStopGuide()
	self:_clearSpeWeakGuideComp()
	g.core.model.User.guideData:clearSkipState()
	self:changeSkipBtnVisible()
	self:_removeGuideTip()

	self._guideDialogComp = nil
	self._guideFingerComp = nil
	self._guideMask = nil
	self._weakSpeGuideMap = {}
	self._loadedSpeGuildSaveData = false
	self._disconnectFlag = false
	self._fightGuideReadyState = false
	self._waitingEnterScene = false
	self._curCheckStep = nil
	self._inWaitEvent = false
	self._playingGuideStory = false
	self._createTick = false
	self._inTickSpeWeakGuide = false
	self._guideWaitCount = 0
	self._tickBindLayerName = nil
	self._selectRect = nil
	self._selectRect2 = nil
	self._lastStepOffset = 0
	self._nextStepJump = false
	self._tickedState = GuideService.TICKED_NONE
	self._guideStepState = GuideService.STEP_END
	self._guideState = GuideService.STATE_OPERATE
	self._speWeakGuideWaitFinish = false
	self._sysCloseCall = nil
	self._sysShowState = false
	self._exitWithUnlock = false

	if self._curTarget then
		self._curTarget:release()

		self._curTarget = nil
	end

	self:_lockScreen(false)
	self:setIsEnded(true)
	g.core.network.GameNetProxy:send_C2S_Guide_Set({
		id = 0
	}, true)

	self._isChecking = false
	self._checkParams = nil
	self._guideData = nil
	self._curGuideData = nil
	self._curGuideIndex = nil
	self._battleGuideData = nil

	g.core.event.EventManager:removeListenerWithTarget(self._storyKey)

	self._speWeakGuideTarget = nil
	self._fightErrResetStepId = nil
	self._guideLevelFlag = false
	self._nextGuideData = nil
	self._nextGuideDataIndex = nil
	self._speWeakGuideCfg = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_FINISH)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_STOP)
end

function GuideService:_gotoNextGuideModule()
	if not self._guideData then
		self:setIsEnded(true)
		g.core.network.GameNetProxy:send_C2S_Guide_Set({
			id = 0
		}, true)
		self:_gotoNormalModule()

		return
	end

	if not self._guideData[self._curGuideIndex + 1] then
		return
	end
end

function GuideService:_gotoNormalModule()
	self:_removeGuideTip()
	self:_lockScreen(false)

	if DEVELOP_UTILS_SUPPORT and LAUNCH_MODULE_DIRECTLY then
		g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance[LAUNCH_MODULE_DIRECTLY])
	else
		g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.HOME, true)
	end
end

function GuideService:_onScheduleUpdate()
	if self._guideState == GuideService.STATE_EXECUTE then
		if self._playingGuideStory then
			return
		end

		self:_enterGuideOperate()

		if self:_executeGuide(...) then
			self:_stopGuide(true)
		end
	end
end

function GuideService:_createGuideTip(arg_125_1, arg_125_2, arg_125_3)
	fgui.UIPackage:addPackage("ui/guide/guide")

	if arg_125_1.maskCheck then
		self._guideMask = self:_createGuideMask()

		self._guideMask:setPosition(display.cx, display.cy)
		self._guideMask:updateView(arg_125_1, arg_125_2)
	end

	if arg_125_1.dialogSelect then
		local var_125_1

		self._dialogComp, var_125_1 = self:_createGuideDialog(arg_125_1.dialogType)

		local var_125_3 = cc.pAdd((arg_125_2 or nil) and (arg_125_2.centerPos or cc.p(0, 0)), arg_125_1.posOffset or cc.p(0, 0))

		self._dialogComp:updateView(arg_125_1, arg_125_2.voice)

		if var_125_1 then
			self._dialogComp:setSize(display.width, display.height)
			self._dialogComp:setPosition(display.width, display.height)
		else
			self._dialogComp:setPosition(var_125_3)
		end
	end

	if arg_125_1.showTips and not arg_125_3 then
		self._tipsComp = self:_createTipComp()

		local var_125_5

		if arg_125_2 then
			local var_125_4 = arg_125_2.centerPos or cc.p(0, 0)

			if var_125_4 then
				self._tipsComp:setPosition(var_125_4)
			end

			if arg_125_2 then
				var_125_5 = arg_125_2.size or cc.size(100, 100)
			end
		end

		local var_125_6 = arg_125_2.scale or {
			x = 1,
			y = 1
		}

		self._tipsComp:setSize(cc.size(var_125_5.width * math.abs(var_125_6.x), var_125_5.height * math.abs(var_125_6.y)))

		local var_125_7

		if arg_125_1.tipScaleX then
			var_125_7 = arg_125_1.tipScaleX / 100 or 1

			local var_125_8

			if arg_125_1.tipScaleY then
				var_125_8 = arg_125_1.tipScaleY / 100 or 1
			end
		end

		self._tipsComp:setScaleAsSize(var_125_7, var_125_8, (arg_125_1.tipsShape or nil) and (arg_125_1.tipsShape - 1 or 0))
	end

	if arg_125_1.touchSelect and not arg_125_3 then
		self._touchComp = self:_createGuideFinger()

		self._touchComp:setPosition(cc.pAdd((arg_125_2 or nil) and (arg_125_2.centerPos or cc.p(0, 0)), arg_125_1.touchPosOffset or cc.p(0, 0)))
		self._touchComp:setScaleX(arg_125_1.flipX and -1 or 1)
		self._touchComp:setScaleY(arg_125_1.flipY and -1 or 1)
		self._touchComp:updateView(arg_125_1, arg_125_2, false)
	end

	if arg_125_3 then
		self._tipsComp = self:_createTipComp()

		self._tipsComp:setScaleAsSize(1, 1, 1, 1)
		self._tipsComp:setPosition(arg_125_2.centerPos)

		self._touchComp = self:_createGuideFinger()

		self._touchComp:setPosition(arg_125_2.centerPos1)
		self._touchComp:updateView(arg_125_1, arg_125_2, true)
	end

	if self._safeSchedule then
		self:_onSafeScheduleCancel()
		self:changeSkipBtnVisible()
	end
end

function GuideService:_removeGuideTip()
	if self._guideMask then
		self._guideMask:removeFromParent()

		self._guideMask = nil
	end

	if self._guideDialogComp then
		if self._typeWriter then
			self._typeWriter:finish()

			self._typeWriter = nil
		end

		self._guideDialogComp:removeFromParent()

		self._guideDialogComp = nil
	end

	if self._normalBgComp then
		self._normalBgComp:removeFromParent()

		self._normalBgComp = nil
	end

	if self._touchComp then
		self._touchComp:removeFromParent()

		self._touchComp = nil
	end

	if self._dialogComp then
		self._dialogComp:removeFromParent()

		self._dialogComp = nil
	end

	if self._tipsComp then
		self._tipsComp:removeFromParent()

		self._tipsComp = nil
	end

	if self._selectRect then
		self._selectRect:removeFromParent()

		self._selectRect = nil
	end

	if self._selectRect2 then
		self._selectRect2:removeFromParent()

		self._selectRect2 = nil
	end
end

function GuideService:_createGuideMask()
	local var_127_0 = fgui.UIPackage:createObject("guide", "GuideMaskComp")

	self._guideLayer:addChild(var_127_0)
	var_127_0:setTouchable(false)

	return var_127_0
end

function GuideService:_createGuideDialog(arg_128_1)
	local var_128_0
	local var_128_1 = false

	if arg_128_1 and arg_128_1 == 2 then
		var_128_0 = fgui.UIPackage:createObject("guide", "GuideFullDialogComp")
		var_128_1 = true
	else
		var_128_0 = fgui.UIPackage:createObject("guide", "GuideDialogComp")
	end

	self._guideLayer:addChild(var_128_0)
	var_128_0:setTouchable(false)

	return var_128_0, var_128_1
end

function GuideService:_createGuideFinger()
	local var_129_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	self._guideLayer:addChild(var_129_0)
	var_129_0:setTouchable(false)

	return var_129_0
end

function GuideService:_justCreateGuideFinger()
	local var_130_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_130_0:setTouchable(false)

	return var_130_0
end

function GuideService:_createTipComp()
	local var_131_0 = fgui.UIPackage:createObject("guide", "GuideTipsBoxComp")

	self._guideLayer:addChild(var_131_0)
	var_131_0:setTouchable(false)

	return var_131_0
end

function GuideService:_onMsgSend(arg_132_1, arg_132_2)
	if GUIDE_EDIT or GUIDE_CLOSE then
		return arg_132_1, arg_132_2
	end

	if self._curGuideData and self._curGuideData.isCustom then
		return arg_132_1, arg_132_2
	end

	if self._isEnded then
		return arg_132_1, arg_132_2
	end

	if arg_132_1 == g.core.network.proto.MSG_C2G_KeepAlive or arg_132_1 == g.core.network.proto.MSG_C2S_SyncTime or arg_132_1 == g.core.network.proto.MSG_C2S_Dungeon_ChallengeStageBegin or arg_132_1 == g.core.network.proto.MSG_C2S_DeadBattle_ChallengeBegin or arg_132_1 == g.core.network.proto.MSG_C2S_Biography_AttackStageBegin or arg_132_1 == g.core.network.proto.MSG_C2S_Biography_AttackCampaignBegin or arg_132_1 == g.core.network.proto.MSG_C2S_GuildDungeon_AttackBegin or arg_132_1 == g.core.network.proto.MSG_C2S_Rebel_AttackBegin or arg_132_1 == g.core.network.proto.MSG_C2S_DailyDungeon_ChallengeBegin or arg_132_1 == g.core.network.proto.MSG_C2S_GetModuleTaskInfo or arg_132_1 == g.core.network.proto.MSG_C2S_GetModuleTaskAward or arg_132_1 == g.core.network.proto.MSG_C2S_CustomActivity_ReqInfo or arg_132_1 == g.core.network.proto.MSG_C2S_GetUserState or arg_132_1 == g.core.network.proto.MSG_C2S_Sevendays_Info then
		return arg_132_1, arg_132_2
	end

	if not next(arg_132_2) then
		return arg_132_1, arg_132_2
	end

	local var_132_0 = arg_132_1
	local var_132_1 = arg_132_2
	local var_132_2

	if self._battleGuideData then
		var_132_2 = self._battleGuideData.stepId or self._curGuideData and self._curGuideData.stepId

		if not var_132_2 then
			return arg_132_1, arg_132_2
		end
	end

	self._battleGuideData = nil

	if self._sentCache[var_132_2] or self._isDebugGuide then
		return arg_132_1, arg_132_2
	end

	self._sentCache[var_132_2] = true
	arg_132_1 = g.core.network.proto.MSG_C2S_Guide_Set
	arg_132_2 = {
		id = var_132_2,
		msg_id = var_132_0,
		msg = {
			__bytes = true,
			msgId = var_132_0,
			content = var_132_1
		}
	}

	return g.core.network.proto.MSG_C2S_Guide_Set, arg_132_2, var_132_0
end

function GuideService:isInTickedSpeGuide()
	return self._inTickSpeWeakGuide
end

function GuideService:_onCheckTickTypeWeakGuide(arg_134_1, arg_134_2)
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if not self._isEnded then
		return
	end

	if self._inTickSpeWeakGuide then
		return
	end

	local var_134_0 = arg_134_2.key

	if not self._loadedSpeGuildSaveData then
		self._loadedSpeGuildSaveData = true
		self._weakSpeGuideMap = g.core.common.Storage:load("guide_spe_weak_guide.json", true) or {}
	end

	if self._weakSpeGuideMap[var_134_0] and not var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].canReTick then
		return
	end

	if var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].canReTick and var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].tickTimes and self._weakSpeGuideMap[var_134_0] and self._weakSpeGuideMap[var_134_0] >= var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].tickTimes then
		return
	end

	local var_134_1 = arg_134_2.targetBtn

	self._speWeakGuideTarget = arg_134_2.targetBtn

	if var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key] then
		if var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].tickEventId then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].tickEventId,
				value = var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].tickEventDesc
			})
		end

		self:_saveTickWeakGuide(var_134_0)
		self:_createSpeWeakGuideComp(var_134_1, var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key], arg_134_2.dragDist)

		self._inTickSpeWeakGuide = true
		self._speWeakGuideCfg = var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key]

		if not var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].opeType or var_0_2.TICK_WEAK_GUIDE_CFG[arg_134_2.key].opeType == 0 then
			self._speWeakTickTarget = var_134_1

			var_134_1:addClickListener(handler(self, self.onSpeGuideClickEvent), 919)
		else
			self._speWeakGuideWaitFinish = true
		end
	end
end

function GuideService:_onGameTouchFinish()
	if self._speWeakGuideWaitFinish then
		self:_onFinishTickTypeWeakGuide(nil, {
			finish = true
		})

		self._speWeakGuideWaitFinish = false
	end
end

function GuideService:onSpeGuideClickEvent()
	self:_onFinishTickTypeWeakGuide(nil, {
		finish = true
	})
end

function GuideService:_onFinishTickTypeWeakGuide(arg_137_1, arg_137_2)
	if arg_137_2 and arg_137_2.finish then
		self:onSpeWeakGuideOpeFinish()
	end

	self._inTickSpeWeakGuide = false

	self:_clearSpeWeakGuideComp()

	if self._speWeakTickTarget and not tolua.isnull(self._speWeakTickTarget) then
		self._speWeakTickTarget:removeClickListener(919)

		self._speWeakTickTarget = nil
	end

	if self._speWeakGuideTouchComp and not tolua.isnull(self._speWeakTickTarget) then
		self._speWeakGuideTouchComp:removeSelf()

		self._speWeakGuideTouchComp = nil
	end

	self._runningWeakGuide = false
	self._speWeakGuideCfg = nil
end

function GuideService:onSpeWeakGuideOpeFinish()
	if self._speWeakGuideCfg and self._speWeakGuideCfg.finishEventId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = self._speWeakGuideCfg.finishEventId,
			value = self._speWeakGuideCfg.finishEventDesc
		})
	end
end

function GuideService:_createSpeWeakGuideComp(arg_139_1, arg_139_2, arg_139_3)
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_139_0 = arg_139_1 and arg_139_1:getSize() or cc.size(0, 0)
	local var_139_1 = 0.5 * var_139_0.width
	local var_139_2 = 0.5 * var_139_0.height
	local var_139_3 = self._guideLayer:globalToLocal(arg_139_1 and arg_139_1:localToGlobal(cc.p(0, 0)) or cc.p(display.cx, display.cy))

	if arg_139_2.frame then
		self._speFrameComp = fgui.UIPackage:createObject("guide", "GuideTipsBoxComp")

		if arg_139_2.addToSelf and arg_139_1 then
			arg_139_1:addChild(self._speFrameComp)
			self._speFrameComp:setPosition(cc.p(var_139_1, var_139_2))
		else
			self._guideLayer:addChild(self._speFrameComp)
			self._speFrameComp:setPosition(cc.pAdd(cc.p(var_139_1, var_139_2), var_139_3))
		end

		self._speFrameComp:setSize(var_139_0)
		self._speFrameComp:setScaleAsSize(1, 1, arg_139_2.frame)
		self._speFrameComp:setTouchable(false)
	end

	if arg_139_2.finger then
		self._speGuideFinger = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		self._speGuideFinger:setTouchable(false)

		if arg_139_2.fingerRevert then
			self._speGuideFinger:setScaleX(arg_139_2.fingerRevert.x or 1)
			self._speGuideFinger:setScaleY(arg_139_2.fingerRevert.y or 1)
		end

		arg_139_2.fingerDir = arg_139_2.fingerDir or {
			x = 0,
			y = 0
		}

		if arg_139_2.addToSelf and arg_139_1 then
			arg_139_1:addChild(self._speGuideFinger)
			self._speGuideFinger:setPosition(cc.p(arg_139_2.fingerDir.x * var_139_1 + var_139_1, arg_139_2.fingerDir.y * var_139_2 * -1 + var_139_2))
		else
			self._guideLayer:addChild(self._speGuideFinger)
			self._speGuideFinger:setPosition(cc.pAdd(cc.p(arg_139_2.fingerDir.x * var_139_1 + var_139_1, arg_139_2.fingerDir.y * var_139_2 * -1 + var_139_2), var_139_3))
		end

		if arg_139_2.isDrag and arg_139_3 then
			self._speGuideFinger:updateView(arg_139_2, {
				centerPos1 = self._guideLayer:globalToLocal(arg_139_1:localToGlobal(cc.p(0, 0))),
				centerPos = self._guideLayer:globalToLocal(arg_139_3:localToGlobal(cc.p(arg_139_3:getWidth() / 2, arg_139_3:getHeight() / 2)))
			}, arg_139_2.isDrag)
		else
			self._speGuideFinger:updateView()
		end
	end

	if arg_139_2.tipsTxt then
		self._speGuideDialog = arg_139_2.isBigTips and fgui.UIPackage:createObject("guide", "GuideFullDialogComp") or fgui.UIPackage:createObject("guide", "GuideDialogComp")

		local var_139_5 = arg_139_2.tipsTxtDir or cc.p(0, 0)

		if arg_139_2.addToSelf and not arg_139_2.isBigTips and arg_139_1 then
			arg_139_1:addChild(self._speGuideDialog)
			self._speGuideDialog:setPosition(cc.p(var_139_5.x + var_139_1, var_139_5.y + var_139_2))
		else
			self._guideLayer:addChild(self._speGuideDialog)

			if not arg_139_2.isBigTips then
				self._speGuideDialog:setPosition(cc.pAdd(cc.p(var_139_5.x + var_139_1, var_139_5.y + var_139_2), var_139_3))
			else
				self._speGuideDialog:setPosition(display.width, display.height)
			end
		end

		self._speGuideDialog:updateView({
			dialogId = arg_139_2.tipsTxt
		}, arg_139_2.tipsTxt)
		self._speGuideDialog:setTouchable(false)
	end
end

function GuideService:onSpeGuideCompRemoved()
	self._speWeakGuideTarget = nil
	self._inTickSpeWeakGuide = false
	self._speFrameComp = nil
	self._speGuideFinger = nil
	self._speWeakTickTarget = nil
	self._speWeakGuideTouchComp = nil
	self._speGuideDialog = nil
end

function GuideService:onChangeSpeGuideCompShowState(arg_141_1, arg_141_2)
	if arg_141_2 then
		if self._speFrameComp then
			self._speFrameComp:setVisible(arg_141_2.show)
		end

		if self._speGuideFinger then
			self._speGuideFinger:setVisible(arg_141_2.show)
		end

		if self._speGuideDialog then
			self._speGuideDialog:setVisible(arg_141_2.show)
		end
	end
end

function GuideService:_clearSpeWeakGuideComp()
	self._speWeakGuideTarget = nil

	if self._speFrameComp and not tolua.isnull(self._speFrameComp) then
		self._speFrameComp:removeSelf()

		self._speFrameComp = nil
	end

	if self._speGuideFinger and not tolua.isnull(self._speGuideFinger) then
		self._speGuideFinger:removeSelf()

		self._speGuideFinger = nil
	end

	if self._speGuideDialog and not tolua.isnull(self._speGuideDialog) then
		self._speGuideDialog:removeSelf()

		self._speGuideDialog = nil
	end

	self._runningWeakGuide = false
end

function GuideService:_saveTickWeakGuide(arg_143_1)
	self._weakSpeGuideMap[arg_143_1] = not self._weakSpeGuideMap[arg_143_1] and 1 or (tonumber(self._weakSpeGuideMap[arg_143_1]) or 1) + 1

	g.core.common.Storage:save("guide_spe_weak_guide.json", self._weakSpeGuideMap, true)
end

function GuideService:checkCurTickedGuide()
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if not self._tickGuideDatas then
		return
	end

	local var_144_0 = g.core.model.User.guideData:getTickedGuideList()

	if next(var_144_0) then
		for iter_144_0, iter_144_1 in ipairs(var_144_0) do
			if self._tickGuideDatas.stepIndices[iter_144_1.cfg.guide_id] then
				if not self:checkGuideTickCond(self._tickGuideDatas.stepIndices[iter_144_1.cfg.guide_id].data) or not self:checkFalseCond(self._tickGuideDatas.stepIndices[iter_144_1.cfg.guide_id]) then
					g.core.model.User.guideData:setGuideUnTicked(iter_144_1.cfg.id)
				end
			else
				g.core.log:error("触发式引导: 未找到配置表配置的对应引导步骤！！！id = ", iter_144_1.cfg.guide_id)
			end
		end
	end

	local var_144_1 = g.core.model.User.guideData:getUnTickedGuide()

	if next(var_144_1) then
		for iter_144_2, iter_144_3 in ipairs(var_144_1) do
			if self._tickGuideDatas.stepIndices[iter_144_3.cfg.guide_id] then
				if self:checkGuideTickCond(self._tickGuideDatas.stepIndices[iter_144_3.cfg.guide_id].data) and self:checkFalseCond(self._tickGuideDatas.stepIndices[iter_144_3.cfg.guide_id]) then
					g.core.model.User.guideData:setGuideTicked(iter_144_3.cfg.id)
					self:setBindWeakGuideTick(iter_144_3.cfg.weak_guide)
				end
			else
				g.core.log:error("触发式引导: 未找到配置表配置的对应引导步骤！！！id = ", iter_144_3.cfg.guide_id)
			end
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_FLUSH)
end

function GuideService:checkFalseCond(arg_145_1)
	local var_145_0 = self._checkConds[arg_145_1.data.falseCond]

	return not self._checkConds[arg_145_1.data.falseCond] and true or var_145_0 and var_145_0(arg_145_1.data.falseValue1, arg_145_1.data.falseValue2)
end

function GuideService:checkGuideTickCond(arg_146_1)
	if arg_146_1.gotType == var_0_2.TICK_CONST.LEVEL then
		if g.core.model.User:getLevel() >= arg_146_1.gotValue then
			return true
		end
	elseif arg_146_1.gotType == var_0_2.TICK_CONST.MODULE_OPEN then
		if g.core.common.ModuleUnlock:isModuleUnlock(arg_146_1.gotValue) then
			return true
		end
	elseif arg_146_1.gotType == var_0_2.TICK_CONST.ENUM_TICK then
		if arg_146_1.gotValue == var_0_2.ENUM_TICK.HOME_GUIDE_TICKED then
			return GuideCheckCondition.checkHomeGuideCond()
		elseif arg_146_1.gotValue == var_0_2.ENUM_TICK.HOME_SHOWER_GUIDE_TICKED then
			return GuideCheckCondition.checkHomeShowerGuideCond()
		end
	end

	return false
end

function GuideService:setBindWeakGuideTick(arg_147_1)
	self._weakGuideTickList[arg_147_1] = true

	self:_saveWeakGuideSteps()
end

function GuideService:delBindWeakGuideTick(arg_148_1)
	if not self._weakGuideTickList[arg_148_1] then
		return
	end

	self._weakGuideTickList[arg_148_1] = nil

	self:_saveWeakGuideSteps()
end

function GuideService:enterTickedGuide(arg_149_1)
	g.core.model.User.guideData:setGuideTickedFinish(arg_149_1)
	g.core.model.User.guideData:checkSkipState(arg_149_1)
	self:changeSkipBtnVisible()

	local var_149_0 = g.core.config.function_guide_info.get(arg_149_1)

	self:enterGuide(var_149_0.guide_id)
	self:delBindWeakGuideTick(var_149_0.weak_guide)
end

function GuideService:enterGuide(arg_150_1)
	self._guideData = self._tickGuideDatas.stepIndices[arg_150_1].guideData
	self._curGuideIndex = 0
	self._tickBindLayerName = self._guideData[1].layerName

	self:setIsEnded(false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TICKED_SUCCESS)

	if self._guideTouchStartCount == 0 then
		self:_lockScreen(true)
	end

	local var_150_0 = self._guideData[self._curGuideIndex + 1]

	g.core.network.GameNetProxy:send_C2S_Guide_Set({
		id = self._guideData[self._curGuideIndex + 1].stepId
	}, true)

	self._sentCache[var_150_0.stepId] = true
	self._guideWaitCount = 0

	self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
	g.core.common.Scheduler:newScheduleOnce(function()
		self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
	end, 0.2)
end

function GuideService:_getErrStateInfo(arg_152_1)
	if not arg_152_1 then
		return "nil guide step"
	end

	local var_152_0 = arg_152_1.layerName
	local var_152_1 = g.core.module.ModuleManager:getCurModule()

	return "needLayer:" .. var_152_0 .. ";curLayerName : ->" .. ((var_152_1 or nil) and var_152_1.display:getName())
end

function GuideService:_setIgnoreGuide(arg_153_1, arg_153_2)
	arg_153_1 = arg_153_1 or ""
	arg_153_2 = arg_153_2 or ""

	g.core.log:error(arg_153_2 .. arg_153_1)
	g.core.common.Storage:save("guide_cache.json", {
		ignore = true
	}, true)

	local var_153_0

	if self._curGuideData then
		var_153_0 = self._curGuideData.stepId or nil
	end

	local var_153_1 = self:_getErrStateInfo(self._curGuideData)

	g.core.log.error("Error: ignore guide ! guideId: " .. tostring(var_153_0) .. " info:" .. arg_153_1 .. ";" .. var_153_1)
	g.core.platform.BuglyProxy:error("Error: ignore guide ! guideId: " .. tostring(var_153_0) .. " info:" .. arg_153_1 .. ";" .. var_153_1 .. ";" .. arg_153_2)
	self:setIsEnded(true)
	g.core.network.GameNetProxy:send_C2S_Guide_Set({
		id = 0
	}, true)
end

function GuideService:_ignoreGuide()
	do return false end

	local var_154_0 = g.core.common.Storage:load("guide_cache.json", true)

	if not var_154_0 or not var_154_0.ignore then
		return false
	end

	return true
end

function GuideService:_onAddCustomGuideStep(arg_155_1, arg_155_2)
	if not arg_155_2 or #arg_155_2 == 0 then
		return
	end

	for iter_155_0, iter_155_1 in ipairs(arg_155_2) do
		iter_155_1.stepId = -1
		iter_155_1.isCustom = true
		iter_155_1.btnName = iter_155_1.btnName or ""
	end

	self._guideData = arg_155_2
	self._curGuideData = arg_155_2[1]
	self._curGuideIndex = 0

	self:setIsEnded(false)

	self._guideWaitCount = 0

	self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
	self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
end

function GuideService:getNextGuideStep()
	if not self._isEnded and self._guideData and self._curGuideIndex then
		return self:_checkGuideCond()
	end
end

function GuideService:setIsEnded(arg_157_1)
	self._isEnded = arg_157_1

	if self._isEnded and g.core.model.User:getId() ~= 0 and g.core.model.User.outpostData:isCanOutOutpost() then
		g.core.sound.SoundManager:unloadGuideBanks()
		require("upgrade.UpgradeSilent").showUpgradeTip()
	end
end

function GuideService:isEnded()
	return self._isEnded
end

function GuideService:_onGuideClearCount()
	if self:isEnded() then
		self._guideWaitCount = 0
		self._guideStepState = GuideService.STEP_END
	end
end

function GuideService:_forceShowJumpBtn()
	self._skipComp:setVisible(true)

	self._safeSchedule = nil
end

function GuideService:_onSafeScheduleStart()
	self:_onSafeScheduleCancel()

	self._safeSchedule = g.core.common.Scheduler:newScheduleOnce(handler(self, self._forceShowJumpBtn), 5)
end

function GuideService:_onSafeScheduleCancel()
	if self._safeSchedule then
		g.core.common.Scheduler:cancelSchedule(self._safeSchedule)
	end

	self._safeSchedule = nil
end

function GuideService:_onEnterTestBattle()
	g.core.battle.BattleProxy:playTestTeamBattle((g.core.config.knight_info.get((g.core.model.User:getBaseId())).sex == 0 or nil) and 299061, 299041, true, 999)

	self._inTestBattle = true
end

function GuideService:_onShowAllUniteToken()
	g.core.battle.BattleProxy:setSkillUIShow(true)
end

function GuideService:setDebugStep(arg_165_1)
	if not self._isEnded then
		self:_stopGuide()
	end

	self._isDebugGuide = true

	local var_165_0 = self._guideDatas.stepIndices[arg_165_1] or self._tickGuideDatas.stepIndices[arg_165_1]

	if var_165_0 then
		self._guideData = var_165_0.guideData

		self:setIsEnded(false)

		self._curGuideIndex = var_165_0.index - 1

		self:_onGuideStateWait(var_0_3.WAIT_NEXT_FRAME_DELAY)
		g.core.common.Scheduler:newScheduleOnce(function()
			self:_onGuideStateReady(var_0_3.READY_NEXT_FRAME_DELAY)
		end, 0)
	else
		g.core.log:error("---------------->没有该步骤，id=", arg_165_1)
	end
end

function GuideService:_onCheckPredestinationCheck()
	return
end

function GuideService:_onLineUpUniteToken1()
	g.core.network.GameNetProxy:send_C2S_Guide_Action({
		id = 1
	}, true)
end

function GuideService:_onLineUpUniteToken2()
	g.core.network.GameNetProxy:send_C2S_Guide_Action({
		id = 2
	}, true)
end

function GuideService:_onShowUniteToken1()
	g.core.battle.BattleProxy:setSkillShow(40020, true)
end

function GuideService:_onShowUniteToken2()
	g.core.battle.BattleProxy:setSkillShow(30003, true)
end

function GuideService:_onShowUniteToken3()
	g.core.battle.BattleProxy:setSkillShow(30003, true)
end

function GuideService:_onGetNewKnight()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = {
			awards = {
				{
					size = 1,
					value = 500070,
					isNew = true,
					type = g.core.common.Goods.TYPE_KNIGHT
				}
			}
		}
	})
end

function GuideService:_onNewKnightLineUp()
	if not checkbool((g.core.model.User.knightsData:getKnightByFormationIndex(3))) then
		local var_174_0 = g.core.model.User.knightsData:getKnight({
			advance_id = 500070
		})

		if var_174_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				pos = 3,
				tp = 1,
				id = var_174_0:getServerId()
			})
		else
			g.core.log:error("——————————————————————————————————————————————没有500070优化体")
		end
	end
end

function GuideService:setSystemTipsState(arg_175_1)
	self._sysShowState = arg_175_1

	if not arg_175_1 and self._sysCloseCall then
		self._sysCloseCall()

		self._sysCloseCall = nil
	end
end

function GuideService:_onEnterDungeonChapter()
	if self._sysShowState then
		self._sysCloseCall = handler(self, self._onEnterDungeonChapter)

		return
	end

	table.insert(self._debugList, {
		line = "----------------------------------------------"
	})
	g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON_STAGE, {
		chapterId = 1
	})
end

function GuideService:_onEnterDungeonBattle()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_ENTER_DUNGEON_BATTLE_OPE)
	g.core.network.GameNetProxy:send_C2S_Dungeon_ChallengeStageBegin({
		id = 200102
	})
end

function GuideService:_checkFirstBattleSmallBossDead(arg_178_1, arg_178_2)
	if self._battleValueMatchCount1 == 1 then
		return
	end

	if arg_178_2.value.identity ~= 2 then
		return false
	end

	if self._battleId ~= 10001 then
		return false
	end

	if arg_178_2.value.id ~= 299042 then
		return false
	end

	self._battleValueMatchCount1 = 1

	self:debugTip("序章普通荷鲁斯死亡时触发")

	self._needUseResume = true

	g.core.battle.BattleProxy:pause()

	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_0_BOSS_ROUND)
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkFirstBattleGuideMainRoleHp(arg_179_1, arg_179_2)
	if self._battleId ~= 10001 then
		return false
	end

	if arg_179_2 ~= 299062 and arg_179_2 ~= 299002 then
		return false
	end

	if arg_179_1 >= 1 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needGuideBattle = true

	self:debugTip("首场战报主角血量低于20触发")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkFirstBattleGuideSecondTeamStart(arg_180_1)
	if self._battleId ~= 10001 then
		return false
	end

	if arg_180_1 ~= 2 then
		return false
	end

	self._needGuideBattle = true

	self:debugTip("首场战报第二波开始")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkFirstBattleGuideComboValueFirstMatch(arg_181_1)
	if self._battleId ~= 10001 then
		return false
	end

	if self._battleValueMatchCount ~= 1 then
		return false
	end

	if arg_181_1 ~= 4 then
		return false
	end

	self._battleValueMatchCount = 2
	self._needGuideBattle = true

	self:debugTip("首场战报第二回合怒气初次到4")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()
	g.core.battle.BattleProxy:getBattleLayer():setGuideUIVisible(false)

	return true
end

function GuideService:_checkFirstBattleGuideEnterBossRound(arg_182_1, arg_182_2)
	if self._battleId ~= 10001 then
		return false
	end

	if arg_182_1 ~= 600070 then
		return false
	end

	if arg_182_2 ~= 2 then
		return false
	end

	if self._bossFull then
		return false
	end

	self._bossFull = true
	self._needUseResume = true

	self:debugTip("--序章第一波进入boss回合并且满怒")
	g.core.battle.BattleProxy:pause()

	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_0_BOSS_ROUND)
	self:_onGuideTouchEnd()

	return false
end

function GuideService:_checkFirstBattleGuideComboValueSecondMatch(arg_183_1)
	if self._battleId ~= 10001 then
		return false
	end

	if self._battleValueMatchCount ~= 2 then
		return false
	end

	if arg_183_1 ~= 4 then
		return false
	end

	self._battleValueMatchCount = 3
	self._needGuideBattle = true

	self:debugTip("首场战报第二回合合击值第二次到4")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()
	g.core.battle.BattleProxy:getBattleLayer():setGuideUIVisible(false)

	return true
end

function GuideService:_checkMainBattle1_1GuideBattleStart(arg_184_1)
	if self._battleId == 10001 then
		return false
	end

	if g.core.model.User.dungeonData:isStagePassed(200101) then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needUseResume = true

	g.core.common.Scheduler:newScheduleOnce(function()
		arg_184_1:forceShowBar()
		self:debugTip("主线1-1开始触发")
		g.core.battle.BattleProxy:pause()

		self._fightGuideReadyState = true

		self:_onGuideStateReady(var_0_3.READY_BATTLE_1_1_START)
		self:_onGuideTouchEnd()
	end, 0.025)

	return true
end

function GuideService:_checkMainBattle1_1GuideMainRoleWillUseSkill(arg_186_1, arg_186_2)
	if self._needUseResume then
		return
	end

	if self._battleId == 10001 then
		return false
	end

	if g.core.model.User.dungeonData:isStagePassed(200101) then
		return false
	end

	if arg_186_1 ~= 210000 and arg_186_1 ~= 200000 then
		return false
	end

	if not arg_186_2 then
		return false
	end

	if self._battleValueMatchCount ~= 1 then
		return false
	end

	self._bossFull = true
	self._needUseResume = true
	self._battleValueMatchCount = 2

	self:debugTip("主线1-1战斗中主角即将释放大招")
	g.core.battle.BattleProxy:pause()

	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_0_BOSS_ROUND)
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkMainBattle1_2GuideMonsterHp(arg_187_1, arg_187_2, arg_187_3)
	if self._battleId == 10001 then
		return false
	end

	if not g.core.model.User.dungeonData:isStagePassed(200101) or g.core.model.User.dungeonData:isStagePassed(200102) then
		return false
	end

	if arg_187_2 ~= 2 then
		return false
	end

	if arg_187_3 ~= 1 then
		return false
	end

	if arg_187_1 >= 50 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needGuideBattle = true

	self:debugTip("--主线1-2战斗中第一波3号怪血量低于50")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()
	g.core.battle.BattleProxy:getBattleLayer():setGuideUIVisible(false)

	return true
end

function GuideService:_checkMainBattle1_2GuideComboValueMatch(arg_188_1)
	if self._battleId == 10001 then
		return false
	end

	if not g.core.model.User.dungeonData:isStagePassed(200101) or g.core.model.User.dungeonData:isStagePassed(200102) then
		return false
	end

	if self._battleWave ~= 2 then
		return false
	end

	if arg_188_1 < 4 then
		return false
	end

	if not self._battleValueMatchCount or self._battleValueMatchCount > 1 then
		return false
	end

	self._battleValueMatchCount = 2
	self._needGuideBattle = true

	self:debugTip("--主线1-2第二波合击值达到4")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()
	g.core.battle.BattleProxy:getBattleLayer():setGuideUIVisible(false)

	return true
end

function GuideService:_checkMainBattle1_3GuideMainRoleHp(arg_189_1, arg_189_2)
	if self._battleId == 10001 then
		return false
	end

	if not g.core.model.User.dungeonData:isStagePassed(200102) or g.core.model.User.dungeonData:isStagePassed(200103) then
		return false
	end

	if arg_189_2 ~= 210000 and arg_189_2 ~= 200000 then
		return false
	end

	if arg_189_1 >= 20 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needGuideBattle = true

	self:debugTip("--主线1-3主角血量低于20%")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkMainBattle1_4GuideFirstMonsterDestroy(arg_190_1, arg_190_2)
	if self._battleId == 10001 then
		return false
	end

	if not g.core.model.User.dungeonData:isStagePassed(200103) or g.core.model.User.dungeonData:isStagePassed(200104) then
		return false
	end

	if arg_190_2 ~= 2 then
		return false
	end

	if arg_190_1 >= 1 then
		return false
	end

	if self._battleWave then
		return false
	end

	self._needGuideBattle = true

	self:debugTip("--主线1-4第一波怪物消灭完毕")
	g.core.battle.BattleProxy:fightPause()
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkMainBattle2_1PassiveSkillTriggled(arg_191_1, arg_191_2)
	if g.core.model.User.dungeonData:isStagePassed(200201) then
		return false
	end

	if arg_191_2 ~= 50009010 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needUseResume = true

	self:debugTip("--主线2-1战斗雪崩技能50009010触发后")
	g.core.battle.BattleProxy:pause()

	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_2_1_SKILL)
	self:_onGuideTouchEnd()

	return true
end

function GuideService:_checkMainBattle2_2GuideThreeRound(arg_192_1)
	if not g.core.model.User.dungeonData:isStagePassed(200201) or g.core.model.User.dungeonData:isStagePassed(200202) then
		return false
	end

	if arg_192_1 ~= 3 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1

	self:debugTip("--主线2-2战斗第三回合")
	g.core.battle.BattleProxy:pause()

	self._needUseResume = true
	self._fightGuideReadyState = true

	self:_onGuideStateReady(var_0_3.READY_BATTLE_2_2_ROUND)
	self:_onGuideTouchEnd()
end

function GuideService:_checkMainBattle2_3GuideComboValueMatch(arg_193_1)
	if g.core.battle.BattleProxy:getBattleId() ~= 200203 or g.core.model.User.dungeonData:isStagePassed(200203) then
		return false
	end

	if arg_193_1 ~= 4 then
		return false
	end

	if self._battleValueMatchCount then
		return false
	end

	self._battleValueMatchCount = 1
	self._needGuideBattle = true

	self:debugTip("--主线2-3我方合击值达到4时")
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_193_0 = self:_justCreateGuideFinger()
	local var_193_1 = g.core.battle.BattleProxy:getUILayerSubComp("uniteComp/skillComp1")

	var_193_0:setPosition((cc.p(var_193_1:getSize().width / 2, var_193_1:getSize().height / 2)))
	var_193_0:updateView()
	var_193_1:addChild(var_193_0)
	var_193_1:addClickListener(handler(self, self._clearBattleSoftComp))

	self._battleSoftComp = var_193_0

	g.core.battle.BattleProxy:getBattleLayer():setGuideUIVisible(false)

	return true
end

function GuideService:_clearBattleSoftComp()
	if self._battleSoftComp then
		self._battleSoftComp:removeFromParent()
	end

	self._battleSoftComp = nil
end

function GuideService:debugTip(arg_195_1)
	return
end

function GuideService:_onNetLoginStateEnter(arg_196_1, arg_196_2)
	self:_onGuideStateWait(var_0_3.WAIT_NET_LOGIN_ENTER, arg_196_2)
end

function GuideService:_onNetLoginStateExit(arg_197_1, arg_197_2)
	self:_onGuideStateReady(var_0_3.READY_NET_LOGIN_EXIT, arg_197_2)
end

function GuideService:_onNetLoginStateResume(arg_198_1, arg_198_2)
	self:_onGuideStateWait(var_0_3.WAIT_NET_LOGIN_RESUME, arg_198_2)
end

function GuideService:_onNetLoginStatePause(arg_199_1, arg_199_2)
	self:_onGuideStateReady(var_0_3.READY_NET_LOGIN_PAUSE, arg_199_2)
end

function GuideService:_onModulePopupAni(arg_200_1, arg_200_2)
	if arg_200_1 == g.core.event.enum.EVENT_MODULE_POPUP_ANI_START then
		self:_onGuideStateWait(var_0_3.WAIT_MODULE_POP_ANI, arg_200_2)
	elseif arg_200_1 == g.core.event.enum.EVENT_MODULE_POPUP_ANI_FINISH then
		self:_onGuideStateReady(var_0_3.READY_MODULE_POP_ANI, arg_200_2)
	end
end

function GuideService:_onCommonGuideEvent(arg_201_1, arg_201_2)
	if arg_201_1 == g.core.event.enum.EVENT_GUIDE_WAIT then
		self:_onGuideStateWait(var_0_3.WAIT_COMMON_GUIDE, arg_201_2)
	elseif arg_201_1 == g.core.event.enum.EVENT_GUIDE_READY then
		self:_onGuideStateReady(var_0_3.READY_COMMON_GUIDE, arg_201_2)
	end
end

function GuideService:_onFuncUnlockState(arg_202_1, arg_202_2)
	if arg_202_1 == g.core.event.enum.EVENT_FUNC_UNLOCK_START then
		self:_onGuideStateWait(var_0_3.WAIT_FUNC_UNLOCK, arg_202_2)
	elseif arg_202_1 == g.core.event.enum.EVENT_FUNC_UNLOCK_END then
		self:_onGuideStateReady(var_0_3.READY_FUNC_UNLOCK, arg_202_2)
	end
end

function GuideService:tickWeakGuide(arg_203_1)
	self._weakGuideTickList[arg_203_1] = true
end

function GuideService:tickWeakGuideDebug(arg_204_1)
	self._weakGuideTickList = {
		[arg_204_1] = true
	}
end

function GuideService:_onLoadingState(arg_205_1, arg_205_2)
	if arg_205_1 == g.core.event.enum.EVENT_LOADING_START then
		self:_onGuideStateWait(var_0_3.WAIT_LOADING_MASK, arg_205_2)
	elseif arg_205_1 == g.core.event.enum.EVENT_LOADING_FINISH then
		self:_onGuideStateReady(var_0_3.READY_LOADING_MASK, arg_205_2)
	end
end

function GuideService:_onCheckMatchSure(arg_206_1, arg_206_2)
	if arg_206_1 == g.core.event.enum.EVENT_GUIDE_WAIT_SURE_OK then
		self:_onGuideStateWait(var_0_3.WAIT_SURE_OK_EVENT, arg_206_2)
	elseif arg_206_1 == g.core.event.enum.EVENT_GUIDE_READY_SURE_OK then
		self:_onGuideStateReady(var_0_3.READY_SURE_OK_EVENT, arg_206_2)
	end
end

function GuideService:_onCheckTestMatch(arg_207_1, arg_207_2)
	if arg_207_1 == g.core.event.enum.EVENT_GUIDE_WAIT_TEST_MATCH then
		self:_onGuideStateWait(var_0_3.WAIT_TEST_MATCH_EVENT, arg_207_2)
	elseif arg_207_1 == g.core.event.enum.EVENT_GUIDE_READY_TEST_MATCH then
		self:_onGuideStateReady(var_0_3.READY_TEST_MATCH_EVENT, arg_207_2)
	end
end

return GuideService
