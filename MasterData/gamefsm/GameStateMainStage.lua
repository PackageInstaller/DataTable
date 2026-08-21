-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMainStage.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local GameState = require("GameFsm/GameState")
local DoLoadWaitLogin = require("System/Load/DoLoadWaitLogin")
local ResScene = require("ClientData/ResScene")
local ResTower = require("ClientData/ResTower")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local PerformManager = require("Logic/perform/PerformManager")
local SubpackageHelper = require("Helper/SubpackageHelper")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local LuaToolkit = Framework.Tools.LuaToolkit
local CameraManager = Framework.CameraSystem.CameraManager
local SubpackageUtils = Framework.Download.SubpackageUtils
local strClassName = "GameStateMainStage"
local GameStateMainStage = Class(strClassName, GameState)

function GameStateMainStage:ctor(name)
	self._waitSyncDataPhase = DoLoadWaitLogin(self)
end

function GameStateMainStage:onEnter(preStateName)
	if SceneManager.mCurSceneID == nil or CurAvatar and CurAvatar:needScenePreStage() then
		if CurAvatar then
			self.sceneNo = CurAvatar:getMainStageScene()
		end

		GameStateMainStage.super.onEnter(self, preStateName)

		if CurAvatar and not CurAvatar.syncDataReady then
			LoadManager.addLoadPhase(self._waitSyncDataPhase)
		end
	else
		GameStateMainStage.super.onEnter(self, preStateName)

		if CurAvatar and not CurAvatar.syncDataReady then
			LoadManager.addLoadPhase(self._waitSyncDataPhase)
		end
	end

	self.parent:setDefaultMainState(self.stateName)
	self:setStageCueFlag()
end

function GameStateMainStage:onExit(nextStateName)
	GameStateMainStage.super.onExit(self, nextStateName)
	PerformManager.stop()
	self:revertCueFlag()

	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if mainStageDlg then
		mainStageDlg:clearPredictTimer()
	end

	UIManager.tryHideUI("mainStageDlg")
end

function GameStateMainStage:onSceneLoaded()
	GameStateMainStage.super.onSceneLoaded(self)
end

function GameStateMainStage:setCameraPostProcess(postCue)
	if self.postCue then
		CueManager.releaseCue(nil, self.postCue)
	end

	self.postCue = postCue

	if self.postCue then
		CueManager.playCue(nil, self.postCue)
	end
end

function GameStateMainStage:onLoadEnded()
	GameStateMainStage.super.onLoadEnded(self)
	CameraModeManager.setMainStageMode()

	self.sceneNo = nil

	if not self:checkEnterReason() then
		self.panelRecovery = true

		BeginnerManager.onTrigger(Const.BEGINNER_TRIGGER_MAIN_STATE)

		if self.panelRecovery and GameFsm.isInState(Const.STATE_MAIN_STAGE) then
			self:recoveryPanel()
			CurAvatar:showCachedClientAct()
		end
	end

	self:checkSceneConfig()
end

function GameStateMainStage:checkSceneConfig()
	if not GameFsm.isInState(self.stateName) or not CurAvatar.syncDataReady then
		return
	end

	if not CurAvatar:isFirstBeginnerOver() then
		return
	end

	local tgtSceneNo = CurAvatar:getMainStageScene()

	if tgtSceneNo and SceneManager.isSameScene(tgtSceneNo, SceneManager.mCurSceneID) and not LoadManager.mRunning then
		PerformManager.start()

		if ResScene[tgtSceneNo] then
			local fov = ResScene[tgtSceneNo].camera_fov or 60

			CameraManager.CameraGrp:SetFov(fov, 0)
		end

		self:setStageBGM()
	else
		self:setStageBGM()
		CueManager.playBaseBGM()
	end
end

function GameStateMainStage:recoveryPanel()
	if self.parent.preStateName == Const.STATE_BATTLE then
		local preState = GameFsm.getState(Const.STATE_BATTLE)

		if preState.failEnhanceExit == 1 then
			JumpGuideManager.jump(6)
		elseif preState.failEnhanceExit == 2 then
			JumpGuideManager.jump(15)
		elseif preState.failEnhanceExit == 3 then
			JumpGuideManager.jump(28)
		elseif preState.failEnhanceExit == 6 then
			JumpGuideManager.jump(8)
		elseif preState.failEnhanceExit == 7 then
			UIManager.getUI("gameAssistantMainDlg", true):setData()
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
			local preEquipTower = preState.battlePreInfo.equipTowerData

			UIManager.getUI("equipTowerMainDlg", true)
			UIManager.getUI("equipTowerLevelDlg", true):refreshData(preEquipTower.type)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_ONCETOWER then
			UIManager.getUI("onceTowerLevelDlg", true)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
			local preBossTower = preState.battlePreInfo.bossTowerData

			if preBossTower.type == Const.BOSS_TOWER_TYPE_ZOMBIE and CurAvatar:isInCircle() then
				RPC.clanGet()
			end

			if preBossTower.type == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() then
				UIManager.showConfirmWithId(1002)
				UIManager.getUI("mainStageDlg", true)
			elseif not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND) and Const.IS_NEW_BOSSTOWER_SHOW then
				local ui = UIManager.getUI("bossEntryDlg", true)

				ui:backToOldBoss(preBossTower.type, preState.result == BattleConst.BATTLE_RESULT_WIN or preState.result == nil)
			else
				UIManager.getUI("bossChooseDlg", true):entryBoss(preBossTower.type, preState.result == BattleConst.BATTLE_RESULT_WIN or preState.result == nil)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
			local preBossTower = preState.battlePreInfo.bossTowerExpandData
			local ui = UIManager.getUI("bossEntryDlg", true)

			ui:backToBossExpand(preBossTower.type, preBossTower.camp, preBossTower.layer)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_STEPTOWER then
			local result = BattleConst.BATTLE_RESULT_LOSE

			if preState.battleResult then
				result = preState.battleResult[2]
			end

			local layer = preState.battlePreInfo.data.layer
			local level = preState.battlePreInfo.data.level

			CurAvatar:stepTowerRecoveryMainState(result, layer, level)
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_ASYNC_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
			UIManager.getUI("pvpChooseDlg", true):show()
			UIManager.getUI("pvpMainDlg", true):show()
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
			UIManager.getUI("pvpChooseDlg", true):show()
			UIManager.getUI("seniorPvpMainDlg", true)
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_OPACT_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
			local data = preState.battlePreInfo.opactPvpData

			if data.actId then
				UIManager.getUI("activityGatherMainDlg", true)
				CurAvatar:jumpToShowActivity(data.actId)
			end
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_TOP_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH or self.parent.preBattleType == BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT then
			local data = preState.battlePreInfo.topPvpData

			if data and data.actId then
				UIManager.getUI("activityGatherMainDlg", true)
				CurAvatar:jumpToShowActivity(data.actId)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_ACTIVITY and preState.battlePreInfo.actData then
			CurAvatar:jumpToShowActivity(preState.battlePreInfo.actData.actId, preState.battlePreInfo.actData.nodeIndex)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
			UIManager.getUI("activityGatherMainDlg", true)
			CurAvatar:jumpToShowActivity(WorldBossCommon.getCurBossActId())
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and preState.battlePreInfo.seasonTowerData then
			UIManager.getUI("activityGatherMainDlg", true)
			CurAvatar:jumpToShowActivity(preState.battlePreInfo.seasonTowerData.actId, preState.battlePreInfo.seasonTowerData.towerId)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_RENT then
			UIManager.getUI("activityGatherMainDlg", true)

			local rentData = preState.battlePreInfo.rentData
			local gtid = rentData.gtId

			if rentData.overdueTick and ClientUtils.getServerTime() >= rentData.overdueTick then
				UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(gtid)
			else
				local taskInfo = RentTaskUtils.getGroupTaskSvrData(gtid)
				local isRentTaskComplete = taskInfo.taskStatus == Const.RENT_GROUPTASK_STATUS.Complete
				local isRentedBattle = rentData.teamId ~= nil
				local isWin = preState.result == BattleConst.BATTLE_RESULT_WIN
				local needShowWriteLetterDlg = CurAvatar.rentTaskNeedOpenWriteLetterDlg

				if isWin then
					if isRentTaskComplete then
						if rentData and rentData.teamId and needShowWriteLetterDlg then
							UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(rentData.gtId)

							local ui = UIManager.createUI("rentTaskWriteLetterDlg", true)

							ui:setData(rentData)
						else
							UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(rentData.gtId)
						end

						CurAvatar.rentTaskNeedOpenWriteLetterDlg = false
					else
						UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(rentData.gtId)
						UIManager.getUI("rentBossInfoDlg", true):setRentBossInfo(rentData.gtId)
					end
				elseif isRentedBattle then
					UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(rentData.gtId)
					UIManager.getUI("rentBossInfoDlg", true):setRentBossInfo(rentData.gtId)

					local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", true)

					if borrowDlg then
						borrowDlg:setTeamBorrowInfo(rentData.gtId, rentData.taskId)
						borrowDlg:selectNewsPanel()
					end
				else
					UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks(rentData.gtId)
					UIManager.getUI("rentBossInfoDlg", true):setRentBossInfo(rentData.gtId)
				end
			end

			if CurAvatar.rentBattleResultCache then
				table.insert(CurAvatar.rentBattleResultCache, rentData.taskId)
				CurAvatar:onGetBonusNotice("commonRentBonusDlg", "onShow", CurAvatar.rentBattleResultCache)

				CurAvatar.rentBattleResultCache = nil
			end
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_RENT_DEFEND then
			UIManager.getUI("activityGatherMainDlg", true)
			UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks()
			UIManager.getUI("rentTeamSetupDlg", true)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
			local actObj = CurAvatar:getNewMazeActivity()

			if actObj and actObj:isValid() then
				if actObj.actData.seasonCache and actObj.actData.seasonCache.cur_cycle == -1 and actObj.actData.hasGotFirstPassAward[1] then
					MsgManager.notice(Lang.get(65463))

					CurAvatar.newMazeBattleMultiAward = nil

					UIManager.getUI("activityGatherMainDlg", true)
				else
					UIManager.getUI("activityGatherMainDlg", true)
					CurAvatar:jumpToShowActivity(preState.battlePreInfo.newMazeData.actId)

					if preState.result and preState.result == BattleConst.BATTLE_RESULT_WIN then
						local mainDlg = UIManager.getUI("newMazeMainDlg", true)

						mainDlg:setData()
					else
						local mainDlg = UIManager.getUI("newMazeMainDlg", true)

						mainDlg:setData()
					end
				end
			else
				MsgManager.notice(Lang.get(32785))

				CurAvatar.newMazeBattleMultiAward = nil

				UIManager.getUI("activityGatherMainDlg", true)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_MAZE_PET then
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
			local checkOpenChooseDlg = actObj ~= nil and actObj:isValid()

			if checkOpenChooseDlg then
				CurAvatar:jumpToShowActivity(actObj.actId)
			else
				MsgManager.notice(Lang.get(32785))
				UIManager.getUI("mainStageDlg", true)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SNEAK_BATTLE)

			if actObj and actObj:isValid() then
				UIManager.getUI("activityGatherMainDlg", true)
				CurAvatar:jumpToShowActivity(actObj.actId)
				UIManager.getUI("sneakBattleLevelMainDlg", true):setData(actObj.actData)
			else
				MsgManager.notice(Lang.get(32785))
				UIManager.getUI("mainStageDlg", true)
			end
		else
			UIManager.getUI("mainStageDlg", true)
		end
	elseif self.parent.preStateName == Const.STATE_BATTLE_REPLAY then
		local preState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		if preState.replayEnv and preState.replayEnv.isShareType == true then
			UIManager.getUI("mainStageDlg", true)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_ONCETOWER then
			UIManager.getUI("onceTowerLevelDlg", true):recoveryFromReplay(preState.replayEnv)
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_ASYNC_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
			UIManager.getUI("pvpChooseDlg", true):show()
			UIManager.getUI("pvpMainDlg", true):show()

			local ui = UIManager.getUI("pvpRecordDlg", true)

			ui:show()
			ui:recoveryFromReplay(preState.replayEnv)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
			UIManager.getUI("pvpChooseDlg", true):show()
			UIManager.getUI("seniorPvpMainDlg", true)

			local ui = UIManager.getUI("seniorPvpRecordDlg", true)

			ui:show()
			ui:recoveryFromReplay(preState.replayEnv)
		elseif self.parent.preBattleType == BattleConst.FORMATION_TYPE_OPACT_PVP or self.parent.preBattleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
			local data = preState.replayEnv

			if data.actId then
				CurAvatar:jumpToShowActivity(data.actId)
			end

			local ui = UIManager.tryGetUI("activityPvpMainDlg")

			if ui then
				local ui = UIManager.getUI("activityPvpRecordDlg", true)

				ui:show()
				ui:recoveryFromReplay(preState.replayEnv)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
			local data = preState.replayEnv

			if data.actId then
				UIManager.getUI("activityGatherMainDlg", true)
				CurAvatar:jumpToShowActivity(data.actId)
			end

			local ui = UIManager.tryGetUI("topPvpMainDlg")

			if ui then
				ui:setMode(1)

				local ui = UIManager.getUI("topPvpRecordDlg", true)

				ui:show(BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT then
			local data = preState.replayEnv

			if data.actId then
				UIManager.getUI("activityGatherMainDlg", true)
				CurAvatar:jumpToShowActivity(data.actId)
			end

			local ui = UIManager.tryGetUI("topPvpMainDlg")

			if ui then
				local index = data.nowUiIndex

				ui.panelKnockoutPanel:refreshUI(index)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
			CurAvatar:jumpToShowActivity(WorldBossCommon.getCurBossActId())

			local ui = UIManager.getUI("worldBossMainDlg", nil, false)

			if ui then
				ui:recoveryFromReplay(preState.replayEnv)
			end

			local ui = UIManager.getUI("worldBossRecordDlg", true)

			if preState.replayEnv.multirePlayEnvsMode then
				ui:show({
					preState.replayEnv[1].data,
					preState.replayEnv[2].data
				})
			else
				ui:show(preState.replayEnv.data)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_STAGE then
			UIManager.getUI("mainStageDlg", true)
			UIManager.getUI("stageInfoDlg", true):recoveryFromReplay(preState.replayEnv)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_RENT then
			UIManager.getUI("rentTaskMainDlg", true):refreshRentTasks()

			if preState.replayEnv.letterType and preState.replayEnv.letterType == "SELF_SEND" then
				UIManager.getUI("rentSendLetterListDlg", true):onPanelOpen()
			else
				UIManager.getUI("rentTaskReceiveLetterDlg", true):selectLetterListPanel()
			end

			UIManager.getUI("rentTaskLetterInfoDlg", true):setDealedData(RentTaskUtils.getLastLetterInfo())
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
			local preEquipTower = preState.replayEnv.equipTowerData

			UIManager.getUI("equipTowerMainDlg", true)

			if preEquipTower then
				UIManager.getUI("equipTowerLevelDlg", true):showTowerLayer(preEquipTower[1], preEquipTower[2])
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
			local preBossTower = preState.replayEnv.bossTowerData

			if preBossTower then
				if preBossTower[1] == Const.BOSS_TOWER_TYPE_ZOMBIE and CurAvatar:isInCircle() then
					RPC.clanGet()
				end

				if preBossTower[1] == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() then
					UIManager.showConfirmWithId(1002)
					UIManager.getUI("mainStageDlg", true)
				elseif not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND) and Const.IS_NEW_BOSSTOWER_SHOW then
					local ui = UIManager.getUI("bossEntryDlg", true)

					ui:backToOldBoss(preBossTower[1])
				else
					UIManager.getUI("bossChooseDlg", true):entryBoss(preBossTower[1])
				end
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
			local data = preState.replayEnv.bossExpandData

			if data then
				local ui = UIManager.getUI("bossEntryDlg", true)

				ui:backToBossExpand(data.bossType, data.camp, data.layer)
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
			local preSeasonTower = preState.replayEnv.seasonTowerData

			if preSeasonTower then
				CurAvatar:jumpToShowActivity(preSeasonTower[1], preSeasonTower[2])
			end
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_MAZE_PET then
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
			local checkOpenChooseDlg = actObj ~= nil and actObj:isValid()

			if checkOpenChooseDlg then
				CurAvatar:jumpToShowActivity(actObj.actId)
			else
				MsgManager.notice(Lang.get(32785))
				UIManager.getUI("mainStageDlg", true)
			end
		else
			UIManager.getUI("mainStageDlg", true)
		end
	else
		UIManager.getUI("mainStageDlg", true)
	end

	if self.parent.preStateName ~= Const.STATE_LOGIN then
		local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

		if mainStageDlg then
			mainStageDlg:replayAppearAnimation()
		end
	end

	if UIManager.tryGetUI("mainStageDlg") and not ClientUtils.isInBeginner() and not CurAvatar:checkRebackState() and (self.parent.preStateName == Const.STATE_LOGIN or self.parent.preStateName == nil and self.preStateName == Const.STATE_MAIN_HOME) then
		CurAvatar:checkPushActivityState()
	end

	self.parent.preStateName = nil
	self.parent.preBattleType = nil
end

function GameStateMainStage:playStateBGM(...)
	return
end

function GameStateMainStage:setStageBGM(...)
	local sceneNo = CurAvatar:getMainStageScene()

	if sceneNo ~= nil then
		local bgmId = ResScene[sceneNo].bgm

		if bgmId then
			CueManager.setBaseBGM(bgmId)
		end
	end
end

function GameStateMainStage:setMainBGM(...)
	CueManager.setBaseBGMByState(Const.STATE_MAIN_STAGE)
end

function GameStateMainStage:setStageCueFlag(...)
	Const.SKIP_SCREEN_EFX = true
end

function GameStateMainStage:revertCueFlag(...)
	Const.SKIP_SCREEN_EFX = false
end

function GameStateMainStage:performVisible(isVisible)
	if not PerformManager.running then
		return
	end

	if isVisible then
		PerformManager.resume()
	else
		PerformManager.pause()
	end
end

function GameStateMainStage:onBgVisible(isVisible)
	CameraManager.SetMainCameraEnable(isVisible)
	self:performVisible(isVisible)
end

return GameStateMainStage
