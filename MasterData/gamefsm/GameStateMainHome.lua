-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMainHome.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local GameState = require("GameFsm/GameState")
local DoLoadWaitLogin = require("System/Load/DoLoadWaitLogin")
local ResScene = require("ClientData/ResScene")
local ResTower = require("ClientData/ResTower")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "GameStateMainHome"
local GameStateMainHome = Class(strClassName, GameState)

function GameStateMainHome:ctor(name)
	self._waitSyncDataPhase = DoLoadWaitLogin(self)
end

function GameStateMainHome:onEnter(preStateName)
	if CurAvatar then
		self.sceneNo = CurAvatar:getMainStageScene()
	end

	GameStateMainHome.super.onEnter(self, preStateName)

	if CurAvatar and not CurAvatar.syncDataReady then
		LoadManager.addLoadPhase(self._waitSyncDataPhase)
	end

	self.parent:setDefaultMainState(self.stateName)
end

function GameStateMainHome:onExit(nextStateName)
	GameStateMainHome.super.onExit(self, nextStateName)

	if self.coActionStage then
		coroutine.stop(self.coActionStage)

		self.coActionStage = nil
	end

	local mainMenu = UIManager.getUI("mainMenu", nil, false)

	if mainMenu and mainMenu:getVisible() then
		mainMenu:setVisible(false)
	end

	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg:setVisible(false)
	end
end

function GameStateMainHome:onSceneLoaded()
	GameStateMainHome.super.onSceneLoaded(self)

	if ResScene[self.sceneNo] then
		local fov = ResScene[self.sceneNo].camera_fov or 60

		CameraModeManager.setMainStageMode()
		Framework.CameraSystem.CameraManager.CameraGrp:SetFov(fov, 0)
	end
end

function GameStateMainHome:onLoadEnded()
	GameStateMainHome.super.onLoadEnded(self)
	UIManager.getUI("homeBg", true)
	GameFsm.getState(Const.STATE_MAIN_STAGE):onBgVisible(false)

	if not self:checkEnterReason() then
		self.panelRecovery = true

		if self.panelRecovery and GameFsm.isInState(Const.STATE_MAIN_HOME) then
			self:recoveryPanel()
		end
	end
end

function GameStateMainHome:recoveryPanel()
	UIManager.getUI("mainMenu", true)

	if self.parent.preStateName == Const.STATE_BATTLE then
		local preState = GameFsm.getState(Const.STATE_BATTLE)

		if self.parent.preBattleType == BattleConst.BATTLE_TYPE_ACTIVITY and preState.battlePreInfo.actData then
			CurAvatar:jumpToShowActivity(preState.battlePreInfo.actData.actId, preState.battlePreInfo.actData.nodeIndex)
		elseif self.parent.preBattleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and preState.battlePreInfo.seasonTowerData then
			CurAvatar:jumpToShowActivity(preState.battlePreInfo.seasonTowerData.actId, preState.battlePreInfo.seasonTowerData.towerId)
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
		end
	end

	self.parent.preBattleType = nil
end

function GameStateMainHome:actionEnterStage()
	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg:playGoRiskVocal()
	end

	if self.coActionStage then
		coroutine.stop(self.coActionStage)

		self.coActionStage = nil
	end

	self.coActionStage = coroutine.start(self.coEnterStage, self)
end

function GameStateMainHome:coEnterStage()
	local mainMenu = UIManager.getUI("mainMenu", nil, false)

	if mainMenu then
		mainMenu:playAni("HideMainMenuMain", nil, true)
	end

	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg.stage:playTimelineByIndex(0)
	end

	coroutine.wait(UIMiscConfig.MAIN_DLG_SHOWTIME)

	if homeBg then
		homeBg.stage:setHide(true)
	end

	self.coActionStage = nil

	GameFsm.translateState(Const.STATE_MAIN_STAGE)
end

function GameStateMainHome:onEnterStageOver()
	CameraModeManager.setMainStageMode()
end

function GameStateMainHome:playStateBGM()
	if self.parent.preBattleType == BattleConst.BATTLE_TYPE_STAGE then
		self:setStageBGM()
	else
		self:setMainBGM()
	end

	CueManager.playBaseBGM()
end

function GameStateMainHome:setStageBGM()
	local sceneNo = CurAvatar:getMainStageScene()

	if sceneNo ~= nil then
		local bgmId = ResScene[sceneNo].bgm

		if bgmId then
			CueManager.setBaseBGM(bgmId)
		end
	end
end

function GameStateMainHome:setMainBGM()
	CueManager.setBaseBGMByState(Const.STATE_MAIN_HOME)
end

function GameStateMainHome:onBgVisible(isVisible)
	local bg = UIManager.getUI("homeBg", nil, false)

	if bg then
		bg:setHide(not isVisible)
	end
end

return GameStateMainHome
