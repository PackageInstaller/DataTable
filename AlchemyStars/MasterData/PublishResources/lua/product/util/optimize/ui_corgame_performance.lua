_class("UICoreGamePerformanceController", UIController)
UICoreGamePerformanceController = UICoreGamePerformanceController

function UICoreGamePerformanceController:OnShow(uiParams)
  self._fpsText = self:GetUIComponent("UILocalizationText", "fps")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self:AttachEvent(GameEventType.UpdateTestScenceInfo, self.UpdateTestScenceInfo)
  self:AttachEvent(GameEventType.TestSceneCloseButton, self.CloseButton)
  self.buttonGO = self:GetGameObject("Button")
  self._fpsTextGO = self:GetGameObject("fps")
end

function UICoreGamePerformanceController:CloseButton(state, fpsState)
  local sceneRoot = GameObjectHelper.Find("Script")
  if state then
    self.buttonGO:SetActive(false)
  else
    self.buttonGO:SetActive(true)
  end
  if fpsState then
    self._fpsTextGO:SetActive(false)
  else
    self._fpsTextGO:SetActive(true)
  end
end

function UICoreGamePerformanceController:Dispose()
  self:DetachEvent(GameEventType.UpdateTestScenceInfo)
end

function UICoreGamePerformanceController:DelaySendFPSInfo(TT, sceneName, themeID)
  YIELD(TT, 4000)
  local fpsNumber
  for s in string.gmatch(self._fpsText.text, "%d+") do
    fpsNumber = s
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateTestScenceFPS, sceneName, themeID, fpsNumber)
end

function UICoreGamePerformanceController:UpdateTestScenceInfo(sceneName, themeID)
  if not sceneName or sceneName == "" then
    Log.fatal("")
    return
  end
  self._info.text = "当前场景：" .. sceneName .. "  ThemeID：" .. tostring(themeID)
  GameGlobal.TaskManager():CoreGameStartTask(self.DelaySendFPSInfo, self, sceneName, themeID)
end

function UICoreGamePerformanceController:StopOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopTestScence)
end

function UICoreGamePerformanceController:BeginOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BeginTestScence, ScenePerfTestType.OnlySceneTheme)
end

function UICoreGamePerformanceController:BeginWithMonsterOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BeginTestScence, ScenePerfTestType.SceneAndMonster)
end

function UICoreGamePerformanceController:BeginWithTextureOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BeginTestScence, ScenePerfTestType.SceneAndTexture)
end

function UICoreGamePerformanceController:BeginWithStatsOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BeginTestScence, ScenePerfTestType.SceneAndStatsData)
end

function UICoreGamePerformanceController:OutOnClick(go)
  self:SwitchState(UIStateType.UIMain)
  GameGlobal:GetInstance():ExitPerformanceGame()
end

function UICoreGamePerformanceController:OpenCheatUIOnClick(go)
  self:ShowDialog("UIBattleCheat", nil, nil, nil, true)
end

function UICoreGamePerformanceController:SwitchSceneOnClick(go)
  local sceneName = self:GetUIComponent("InputField", "SceneName").text
  local themeID = tonumber(self:GetUIComponent("InputField", "ThemeID").text)
  themeID = themeID or 8
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchScene, sceneName, themeID)
end

function UICoreGamePerformanceController:BeginMonsterOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PerfMonsterStat)
end

function UICoreGamePerformanceController:SwitchMonsterOnClick(go)
  local monsterName = self:GetUIComponent("InputField", "MonsterName").text
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchMonster, monsterName)
end
