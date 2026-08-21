_class("HomelandVisitClient", Object)
HomelandVisitClient = HomelandVisitClient

function HomelandVisitClient:Constructor()
  LogWrapper.LogDebug("拜访家园初始化")
  self._minimapManager = UIHomelandMinimapManager:New()
  self._sceneManager = HomelandSceneManager:New()
  self._interactPointManager = InteractPointManager:New()
  self._buildManager = HomeBuildManager:New()
  self._characterManager = HomelandCharacterManager:New()
  self._cameraManager = HomelandCameraManager:New()
  self._inputManager = HomelandInputManager:New()
  self._petManager = HomelandPetManager:New()
  self._3duiManager = Home3DUIManager:New()
  self._homelandSceneEffectManager = HomelandSceneEffectManager:New()
  self._homelandPetInviteManager = HomelandPetInviteManager:New()
  self._mode = HomelandMode.Normal
end

function HomelandVisitClient:Init(TT)
  self._lastTick = GameGlobal:GetInstance():GetLastTimeMS()
  self._sceneManager:Init()
  self._interactPointManager:Init(self)
  self._buildManager:Init(TT, self)
  self._characterManager:Init(self)
  self._cameraManager:Init(self)
  self._inputManager:Init(self)
  self._petManager:Init(self)
  self._3duiManager:Init(self)
  self._homelandSceneEffectManager:Init(self)
  self._homelandPetInviteManager:Init(self)
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMEnterHomeland, AudioConstValue.BGMCrossFadeTime)
end

function HomelandVisitClient:OnEnterHomeland()
end

function HomelandVisitClient:AfterHomelandUIShow()
  if self._isMainUIShown then
    return
  end
  self._isMainUIShown = true
end

function HomelandVisitClient:Dispose()
  self._minimapManager:Destroy()
  self._minimapManager = nil
  self._3duiManager:Dispose()
  self._petManager:Dispose()
  self._inputManager:Dispose()
  self._cameraManager:Dispose()
  self._characterManager:Dispose()
  self._buildManager:Dispose()
  self._interactPointManager:Dispose()
  self._sceneManager:Dispose()
  self._homelandSceneEffectManager:Dispose()
  self._homelandPetInviteManager:Dispose()
  LogWrapper.LogDebug("家园销毁")
end

function HomelandVisitClient:Update(curTick)
  local deltaTimeMS = curTick - self._lastTick
  self._lastTick = curTick
  self._inputManager:Update(deltaTimeMS)
  if self._mode == HomelandMode.Normal then
    self._characterManager:Update(deltaTimeMS)
    self._interactPointManager:Update(deltaTimeMS)
    self._petManager:Update(deltaTimeMS)
    self._cameraManager:Update(deltaTimeMS)
  elseif self._mode == HomelandMode.Build then
  end
  if self._minimapManager then
    self._minimapManager:Update(deltaTimeMS)
  end
  if self._homelandSceneEffectManager then
    self._homelandSceneEffectManager:Update(deltaTimeMS)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUpdatePerFrame)
end

function HomelandVisitClient:CurrentMode()
  return self._mode
end

function HomelandVisitClient:StartBuild()
  BuildLog("开始建造")
  Log.exception("拜访模式不可建造")
end

function HomelandVisitClient:FinishBuild()
  BuildLog("停止建造")
  Log.exception("拜访模式不可停止建造")
end

function HomelandVisitClient:BeginStory()
  Log.exception("拜访不可进入剧情模式")
end

function HomelandVisitClient:EndStory()
  Log.exception("拜访不可退出剧情模式")
end

function HomelandVisitClient:FishingManager()
  Log.exception("拜访模式不可访问FishingManager")
end

function HomelandVisitClient:SceneManager()
  return self._sceneManager
end

function HomelandVisitClient:CharacterManager()
  return self._characterManager
end

function HomelandVisitClient:CameraManager()
  return self._cameraManager
end

function HomelandVisitClient:InputManager()
  return self._inputManager
end

function HomelandVisitClient:InteractPointManager()
  return self._interactPointManager
end

function HomelandVisitClient:BuildManager()
  return self._buildManager
end

function HomelandVisitClient:PetManager()
  return self._petManager
end

function HomelandVisitClient:Home3DUIManager()
  return self._3duiManager
end

function HomelandTreasureManager:TreasureManager()
  Log.exception("拜访模式不可访问TreasureManager")
end

function HomelandVisitClient:TreeCuttingManager()
  Log.exception("拜访模式不可访问TreeCuttingManager")
end

function HomelandVisitClient:OpenPetInteract(pet)
  Log.exception("拜访模式不可与星灵交互")
end

function HomelandVisitClient:HomeEventManager()
  Log.exception("拜访模式不可访问HomeEventManager")
end

function HomelandVisitClient:FindTreasureManager()
  Log.exception("拜访模式不可访问FindTreasureManager")
end

function HomelandVisitClient:HomelandMiningManager()
  Log.exception("拜访模式不可访问HomelandMiningManager")
end

function HomelandVisitClient:IsVisit()
  return true
end

function HomelandVisitClient:GetMinimapManager()
  return self._minimapManager
end

function HomelandVisitClient:GetHomelandSceneEffectManager()
  return self._homelandSceneEffectManager
end

function HomelandVisitClient:GetHomelandTaskManager()
  return nil
end

function HomelandVisitClient:GetHomelandPetInviteManager()
  return self._homelandPetInviteManager
end
