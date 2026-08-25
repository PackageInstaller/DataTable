local WorldSpaceBasingY = CS.UnityEngine.Shader.PropertyToID("_WorldSpaceBasingY")
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local SceneMgr, Super = System.NewClass("SceneMgr", Manager)
local s_MapSceneType2Module = {
  [CommonDefine.SceneType.Null] = "NullSceneState",
  [CommonDefine.SceneType.Login] = "LoginSceneState",
  [CommonDefine.SceneType.Town] = "TownSceneState",
  [CommonDefine.SceneType.Copies] = "CopiesSceneState",
  [CommonDefine.SceneType.Challenge] = "GameChallengeSceneState",
  [CommonDefine.SceneType.Introduction] = "IntroductionSceneState",
  [CommonDefine.SceneType.Battle] = "BattleSceneState"
}
SceneMgr.isDestroying = false

function SceneMgr:Awake(binder)
  Super.Awake(self)
  self._curScene = nil
  self._sceneType = CommonDefine.SceneType.Null
  self._preSceneType = CommonDefine.SceneType.Null
  self.openedUrls = {}
  self.isEnableSceneUI = true
  self.isInUIQueue = nil
  if not CS.AMTimeline.AMPlayer.WorldCoordNode then
    CS.AMTimeline.AMPlayer.WorldCoordNode = CS.UnityEngine.GameObject("WorldCoordNode")
  end
  Vector3Pool.Instance:Reserve(128)
  self:ResetWorldSpaceBasingY()
  binder:BindEvent(EventMgr.Instance.OpenUIPanel, System.fn(self, self.OnPanelOpen))
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnPanelClose))
  binder:BindEvent(EventMgr.Instance.SceneUIQueueChange, System.fn(self, self.OnSceneUIQueueChange))
  binder:BindEvent(EventMgr.Instance.SceneUIChange, System.fn(self, self.OnSceneUIChange))
end

function SceneMgr:OnDestroy()
  Super.OnDestroy(self)
  Vector3Pool.Instance:Clear()
  PreRequireLuaFiles.Instance:Clear()
  AssetPreloader.Instance:Dispose()
  self:ExitCurScene()
  ResGcMgr.Instance:Gc()
end

function SceneMgr:UnLoadAllBattleScenes()
  UnityBattleSceneMgr.UnLoadAllBattleScenes()
end

function SceneMgr:UnLoadAllMapScenes()
  local sceneList = {}
  local sceneCount = SceneManager.sceneCount - 1
  for i = 0, sceneCount do
    table.insert(sceneList, SceneManager.GetSceneAt(i))
  end
  for i = 1, #sceneList do
    local scene = sceneList[i]
    if scene:IsValid() and scene.isLoaded and string.find(scene.path, "Assets/ArtRes/MScene") then
      pcall(ResLoadMgr.UnLoadScene, scene.path)
      pcall(SceneManager.UnloadSceneAsync, scene.path)
    end
  end
end

function SceneMgr:SetOpenUIQueueEnabled(isEnabled, uiQueueFinisCb)
  self.isEnableSceneUI = isEnabled
  if isEnabled then
    self.uiQueueFinisCb = uiQueueFinisCb
    self:OpenNextQueuePanel()
    self:OpenScenePanel()
  end
end

function SceneMgr:IsEnableSceneUI()
  return self.isEnableSceneUI
end

function SceneMgr:ResetWorldSpaceBasingY()
  CS.UnityEngine.Shader.SetGlobalFloat(WorldSpaceBasingY, -99999)
end

function SceneMgr:OnSceneUIQueueChange(sceneType)
  if sceneType == self._sceneType then
    self:OpenNextQueuePanel()
  end
end

function SceneMgr:OpenNextQueuePanel()
  if self.isInUIQueue then
    return
  end
  if not self.isEnableSceneUI then
    return
  end
  local sceneUIOpenQueue = UIManager.Instance:GetSceneUIOpenQueue(self._sceneType)
  local nextQueueUI = sceneUIOpenQueue[1]
  if nextQueueUI then
    self.isInUIQueue = true
    self:ClosePermanentUIs()
    UIManager.Instance:Reopen(nextQueueUI.url, table.unpack(nextQueueUI.args))
  elseif self.uiQueueFinisCb then
    self.uiQueueFinisCb()
  end
end

function SceneMgr:OnPanelOpen(panelUrl)
  self.openedUrls[panelUrl] = true
end

function SceneMgr:OnPanelClose(panelUrl)
  self.openedUrls[panelUrl] = nil
  local sceneUIOpenQueue = UIManager.Instance:GetSceneUIOpenQueue(self._sceneType)
  local firstQueueUrl = sceneUIOpenQueue[1] and sceneUIOpenQueue[1].url
  if firstQueueUrl == panelUrl then
    table.remove(sceneUIOpenQueue, 1)
    self.isInUIQueue = nil
    self:OpenNextQueuePanel()
  end
end

function SceneMgr:OnSceneUIChange(sceneType)
  if sceneType == self._sceneType then
    self:OpenScenePanel()
  end
end

function SceneMgr:OpenScenePanel()
  if not self.isEnableSceneUI then
    return
  end
  local sceneUIList = UIManager.Instance:GetSceneUI(self._sceneType)
  for _, ui in ipairs(sceneUIList) do
    UIManager.Instance:Reopen(ui.url, table.unpack(ui.args))
  end
  UIManager.Instance:ClearSceneUI(self._sceneType)
end

function SceneMgr:CloseRelatedPanel()
  local exceptUrls = UIDefine.ExceptUrls
  for url, _ in pairs(table.clone(self.openedUrls)) do
    if self.permanentUIs and self.permanentUIs[url] then
    elseif not table.contains(exceptUrls, url) then
      UIManager.Instance:CloseByUrl(url)
    end
  end
  self.openedUrls = {}
end

function SceneMgr:SetPermanentUI(url)
  self.permanentUIs = self.permanentUIs or {}
  self.permanentUIs[url] = true
end

function SceneMgr:ClosePermanentUIs()
  if self.permanentUIs then
    for k, _ in pairs(self.permanentUIs) do
      UIManager.Instance:CloseByUrl(k)
    end
  end
  self.permanentUIs = nil
end

function SceneMgr:IsPermanentUI(url)
  if self.permanentUIs then
    return self.permanentUIs[url]
  end
  return false
end

function SceneMgr:GetCurScene()
  return self._curScene
end

function SceneMgr:ExitCurScene(isBackToLogin)
  if self._curScene then
    self._curScene:OnExitScene(SceneMgr.isDestroying)
    self._curScene = nil
  end
  self.isInUIQueue = nil
  if isBackToLogin then
    UIManager.Instance:CloseAllExcept()
  else
    self:CloseRelatedPanel()
  end
  UIManager.Instance:ClearSceneOpenUIQueue(self._sceneType)
end

function SceneMgr:IsNullScene()
  return self._sceneType == CommonDefine.SceneType.Null
end

function SceneMgr:IsInTown()
  return self._sceneType == CommonDefine.SceneType.Town
end

function SceneMgr:IsInIntroduction()
  return self._sceneType == CommonDefine.SceneType.Introduction
end

function SceneMgr:IsInCopies()
  return self._sceneType == CommonDefine.SceneType.Copies
end

function SceneMgr:IsInBattle()
  return self._sceneType == CommonDefine.SceneType.Battle
end

function SceneMgr:IsInChallenge()
  return self._sceneType == CommonDefine.SceneType.Challenge
end

function SceneMgr:IsDemoScene()
  local sceneType = self._sceneType
  if sceneType == CommonDefine.SceneType.Null or sceneType == CommonDefine.SceneType.Login then
    return true
  end
end

function SceneMgr:IsLoginScene()
  return self._sceneType == CommonDefine.SceneType.Login
end

function SceneMgr:GetSceneType()
  return self._sceneType
end

function SceneMgr:EnterSceneType(sceneType)
  self:_EnterScene(sceneType)
end

function SceneMgr:EnterGame()
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_1", "-")
  LoginStepTracker.Instance:TrackStep(100)
  local pvAvgId = LoginPVDataUtils.GetBeforeLoginAvgId()
  local prePVAvgId = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.PreviewVideo)
  local PlayedPvIdList = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.PlayedPvIdList, {})
  if prePVAvgId ~= pvAvgId and pvAvgId and not table.contains(PlayedPvIdList, pvAvgId) then
    Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_1", "prepare play pv")
    LoginStepTracker.Instance:TrackStep(110)
    local _PlayPV
    
    function _PlayPV()
      LoginStepTracker.Instance:TrackStep(114)
      self.captureScreenImgGo = GameObject.Find("UIRoot/captureScreenImg")
      Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_4", "try to hide capture:" .. tostring(self.captureScreenImgGo ~= nil))
      if self.captureScreenImgGo then
        self.captureScreenImgGo:SetActive(false)
      end
      LoginStepTracker.Instance:TrackStep(115)
      
      local function tailCallback()
        LoginStepTracker.Instance:TrackStep(120)
        Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_7", "try to show capture on tailCallback:" .. tostring(not IsNil(self.captureScreenImgGo)))
        if not IsNil(self.captureScreenImgGo) then
          self.captureScreenImgGo:SetActive(true)
        end
        LoginStepTracker.Instance:TrackStep(121)
        Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_8", "call EnterLogin()")
        self:EnterLogin()
        LoginStepTracker.Instance:TrackStep(122)
      end
      
      LoginStepTracker.Instance:TrackStep(116)
      Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_5", "remove event 'OnVideoInited'")
      EventMgr.Instance.OnVideoInited:RemoveEvent(_PlayPV)
      LoginStepTracker.Instance:TrackStep(117)
      Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_6", "start play pv")
      AvgStoryManager.Instance:StartStoryById(pvAvgId, nil, nil, tailCallback)
      LoginStepTracker.Instance:TrackStep(118)
    end
    
    LoginStepTracker.Instance:TrackStep(111)
    if AVProManager.Instance.isInitedFinished then
      Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_2", "AvProVideoMgr init finish")
      LoginStepTracker.Instance:TrackStep(112)
      _PlayPV()
    else
      LoginStepTracker.Instance:TrackStep(113)
      Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_2_3", "AvProVideoMgr not init finish, register succ callback")
      EventMgr.Instance.OnVideoInited:RegisterEvent(_PlayPV)
    end
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.PreviewVideo, pvAvgId)
    table.insert(PlayedPvIdList, pvAvgId)
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.PlayedPvIdList, PlayedPvIdList)
    MobileFileDataManager.Instance:OnSaveCommInfo()
  else
    Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterGame_3", "dont play pv, enterLogin")
    LoginStepTracker.Instance:TrackStep(101)
    self:EnterLogin()
    LoginStepTracker.Instance:TrackStep(102)
  end
end

function SceneMgr:EnterLogin()
  LoginStepTracker.Instance:TrackStep(300)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_1", "-")
  LoginMgr.Instance.model:ResetLoginTokens()
  LoginStepTracker.Instance:TrackStep(301)
  DataCenter.playerData.netDelayTime = 0
  LoginStepTracker.Instance:TrackStep(302)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_2", "-")
  self:_EnterScene(CommonDefine.SceneType.Login, nil, true)
  LoginStepTracker.Instance:TrackStep(303)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_3", "-")
  AssetPreloader.PreloadShaders()
  LoginStepTracker.Instance:TrackStep(304)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_4", "-")
  UIAsyncLoadMgr.Instance:PreCreatePanels()
  LoginStepTracker.Instance:TrackStep(305)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_5", "-")
  AssetPreloader.Instance:StartPreLoadAssets()
  AssetDependenciesChecker.Instance:StartCheckDependencies()
  LoginStepTracker.Instance:TrackStep(306)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene.EnterLogin_6", "-")
  PreRequireLuaFiles.Instance:PreloadLuaFiles()
  LoginStepTracker.Instance:TrackStep(307)
end

function SceneMgr:EnterTown(isForce)
  if GroupDownloadMgr.Instance:TryInGameDownload() then
    return
  end
  self:_EnterScene(CommonDefine.SceneType.Town, nil, isForce)
  PopTipsManager.Instance:SetTutorialLock(false)
  GlobalDispatcher:Dispatch(NotifyId.OnEnterTown)
end

function SceneMgr:EnterNull(isForce)
  self:_EnterScene(CommonDefine.SceneType.Null, nil, isForce)
end

function SceneMgr:EnterCopies(data)
  self:_EnterScene(CommonDefine.SceneType.Copies, data)
  PopTipsManager.Instance:SetTutorialLock(false)
end

function SceneMgr:EnterChallenge(data)
  self:_EnterScene(CommonDefine.SceneType.Challenge, data)
  PopTipsManager.Instance:SetTutorialLock(false)
end

function SceneMgr:EnterIntroduction(data)
  self:_EnterScene(CommonDefine.SceneType.Introduction, data)
end

function SceneMgr:EnterBattleScene(data)
  self:_EnterScene(CommonDefine.SceneType.Battle, data)
  PopTipsManager.Instance:SetTutorialLock(false)
end

function SceneMgr:_EnterScene(sceneType, data, isForce)
  if not isForce and self._sceneType == sceneType then
    Logger.ReportApusInfo("EneterSameScene = {sceneType} {traceback}", self._sceneType, debug.traceback())
    if not DataCenter.gameData.EnterMockDemo then
      return
    end
  end
  local ingSceneGc = self._sceneType == CommonDefine.SceneType.Null
  EventMgr.Instance.OnExitScene:Dispatch(self._sceneType, sceneType)
  Logger.ReportApusInfo("ExitScene = {sceneType}", self._sceneType)
  local isBackToLogin = sceneType == cd.SceneType.Login
  self:ExitCurScene(isBackToLogin)
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  if sceneType == CommonDefine.SceneType.Login then
    Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Scene._EnterScene", "create sceneObj")
  end
  self._curScene = self:_CreateSceneObj(sceneType)
  assert(self._curScene, "ERROR: 无法正常创建Scene对象 " .. sceneType)
  Logger.ReportApusInfo("EnterScene = {sceneType} {traceback}", self._sceneType, debug.traceback())
  self._curScene:SetIngoreGc(ingSceneGc)
  self._curScene:OnInitSceneData()
  self._curScene:OnEnterScene(data)
  EventMgr.Instance.OnEnterScene:Dispatch(sceneType)
  GlobalDispatcher:Dispatch(NotifyId.OnEnterScene, sceneType)
  self:OpenNextQueuePanel()
  self:OpenScenePanel()
end

function SceneMgr:_CreateSceneObj(sceneType)
  if not s_MapSceneType2Module[sceneType] then
    Logger.Debug("============找不到sceneType===========")
    return nil
  end
  Logger.Debug("============_CreateSceneObj--------", sceneType)
  EventMgr.Instance.ChangeScene:Dispatch(sceneType)
  local modulePath = string.format("GameScript.Managers.Scene.SceneState.%s", s_MapSceneType2Module[sceneType])
  self._preSceneType = self._sceneType
  self._sceneType = sceneType
  do return require end
  return require, modulePath
end

return SceneMgr
