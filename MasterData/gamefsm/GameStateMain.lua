-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMain.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local GameState = require("GameFsm/GameState")
local DoLoadWaitLogin = require("System/Load/DoLoadWaitLogin")
local ResScene = require("ClientData/ResScene")
local ResTower = require("ClientData/ResTower")
local GameStateMainStage = require("GameFsm/GameStateMainStage")
local GameStateMainMaze = require("GameFsm/GameStateMainMaze")
local GameStateMainRearHouse = require("GameFsm/GameStateMainRearHouse")
local GameStateMainHome = require("GameFsm/GameStateMainHome")
local PerformManager = require("Logic/perform/PerformManager")
local GameStateMainCircle = require("GameFsm/GameStateMainCircle")
local GameStateClimbTower = require("ClimbTowerDemo/GameStateClimbTower")
local GameStateEliminate = require("EliminateGame/GameStateEliminate")
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "GameStateMain"
local GameStateMain = Class(strClassName, GameState)

function GameStateMain:ctor(name)
	self:_initData()

	self._waitSyncDataPhase = DoLoadWaitLogin(self)
	self._firstTimeEnter = true
end

function GameStateMain:_initData()
	self:addChildState(GameStateMainStage(Const.STATE_MAIN_STAGE), true)
	self:addChildState(GameStateMainHome(Const.STATE_MAIN_HOME))
	self:addChildState(GameStateMainMaze(Const.STATE_MAIN_MAZE))
	self:addChildState(GameStateMainRearHouse(Const.STATE_MAIN_REAR_HOUSE))
	self:addChildState(GameStateMainCircle(Const.STATE_MAIN_CIRCLE))
	self:addChildState(GameStateClimbTower(Const.STATE_CLIMB_TOWER))
	self:addChildState(GameStateEliminate(Const.STATE_ELIMINATE))
end

function GameStateMain:onEnter(preStateName)
	GameStateMain.super.onEnter(self, preStateName)

	self.preStateName = preStateName

	if preStateName == Const.STATE_BATTLE then
		self.preBattleType = GameFsm.getState(Const.STATE_BATTLE).battleType
	elseif preStateName == Const.STATE_BATTLE_REPLAY then
		self.preBattleType = GameFsm.getState(Const.STATE_BATTLE_REPLAY).battleType
	else
		self.preBattleType = nil
	end
end

function GameStateMain:onExit(nextStateName)
	GameStateMain.super.onExit(self, nextStateName)
end

function GameStateMain:onSceneLoaded()
	GameStateMain.super.onSceneLoaded(self)
end

function GameStateMain:onLoadEnded()
	GameStateMain.super.onLoadEnded(self)
end

function GameStateMain:setDefaultMainState(stateName)
	self.preDefaultState = stateName
end

function GameStateMain:enterDefaultMainState()
	GameFsm.translateState(self.preDefaultState or Const.STATE_MAIN_STAGE)
end

function GameStateMain:enterDefaultSubState(preStateName)
	local subStateName = Const.STATE_MAIN_STAGE

	if self.preBattleType == BattleConst.BATTLE_TYPE_MAZE and not CurAvatar.needResetMaze then
		subStateName = Const.STATE_MAIN_MAZE
	elseif self.preBattleType == BattleConst.BATTLE_TYPE_ACTIVITY then
		subStateName = Const.STATE_MAIN_HOME
	elseif self.preBattleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if not CurAvatar.needOutOfCircleBattle then
			subStateName = Const.STATE_MAIN_CIRCLE
		else
			CurAvatar.needOutOfCircleBattle = nil
		end
	end

	self.fsm:translateState(subStateName)
end

function GameStateMain:onDisconnect()
	PerformManager.stop()
end

UIConst.MAIN_NEED_BACK_DLG = {
	"mainMenu",
	"mainStageDlg",
	"chatDlg",
	"chatEmojiBox",
	"seniorPvpEnemyDlg",
	"activityMainDlg",
	"rentTaskWriteLetterDlg"
}
UIConst.RELINK_SAVE_DLG = {
	"sneakBattleTeamSetDlg"
}

function GameStateMain:onReconnect()
	local needRefresh = false

	if not ClientUtils.isInBeginner() then
		for _, uiName in ipairs(UIConst.MAIN_NEED_BACK_DLG) do
			local ui = UIManager.getUI(uiName, nil, false)

			if ui and (ui:isInShow() or not UIConst.CacheConfig[uiName]) then
				needRefresh = true
			end
		end

		for _, uiName in ipairs(UIConst.RELINK_SAVE_DLG) do
			local ui = UIManager.getUI(uiName, nil, false)

			if ui and ui:isInShow() then
				needRefresh = false
			end
		end
	end

	if needRefresh then
		for _, uiName in ipairs(UIConst.MAIN_NEED_BACK_DLG) do
			local ui = UIManager.getUI(uiName, nil, false)

			if ui and (ui:isInShow() or not UIConst.CacheConfig[uiName]) then
				ui:setVisible(false)
			end
		end

		UIManager.clearStateCanvas()
	end

	MsgManager.refreshBulletTimeInfo(nil, true)
end

return GameStateMain
