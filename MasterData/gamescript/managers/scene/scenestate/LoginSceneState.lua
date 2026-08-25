local System = require("System.System")
local BaseSceneState = require("GameScript.Managers.Scene.SceneState.BaseSceneState")
local UIManager = require("Managers.UI.UIManager")
local Urls = require("Managers.UI.Urls")
local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
local AudioManager = require("Managers.AudioManager")
local LoginScene, Super = System.NewClass("LoginScene", BaseSceneState)

function LoginScene:ctor()
  Super.ctor(self)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.ctor", "-")
end

function LoginScene:OnInitSceneData()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnInitSceneData_1", "-")
  Super.OnInitSceneData(self)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnInitSceneData_2", "-")
  LoginMgr.Instance:ResetAllData()
  CopyDataUtils.ResetAll()
  DailyCopyDataUtils.ResetAll()
  GameTimeEventManager.Instance:Disable()
  UIAsyncLoadMgr.Instance:ClearUnusedPanels()
  TimeUtils.SetServerTime(0, 0, 0)
end

function LoginScene:OnEnterScene()
  Super.OnEnterScene(self)
  require("Managers.Reconnect.ReconnectMgr").Instance:Disable()
  require("Managers.EventManager.EventMgr").Instance.CloseReqMask:Dispatch()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_1", "-")
  UIManager.Instance:Reopen(Urls.ReqMaskPanel)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_2", "-")
  WorldStageManager.Instance:FinishStage(WorldStageManager.Instance.curGroupId)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_3", "-")
  AudioManager.Instance:StopBGM()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_4", "-")
  SceneMgr.Instance:UnLoadAllBattleScenes()
  UnityBattleSceneMgr.UnLoadAllBattleResources()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_5", "-")
  SceneMgr.Instance:UnLoadAllMapScenes()
  
  local function OnShowPVEnd()
    local isFirstIn = true
    Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_7", "-")
    UIManager.Instance:Reopen(Urls.LoginPanel, isFirstIn)
  end
  
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_6", "-")
  OnShowPVEnd()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_8", "-")
  local BattleManger = require("Battle.BattleManager").Instance
  if BattleManger then
    Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_9", "-")
    BattleManger:DisposeCurrentBattle()
  end
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "LoginScene.OnEnterScene_10", "-")
  UIManager.Instance:CloseByUrl(Urls.DBGMainCopyOutPanel)
end

function LoginScene:OnExitScene(byDestroy)
  Super.OnExitScene(self, byDestroy)
  UIManager.Instance:CloseByUrl(Urls.LoginPanel)
  if not byDestroy then
    UIManager.Instance:Reopen(Urls.ReqMaskPanel)
  end
end

return LoginScene
