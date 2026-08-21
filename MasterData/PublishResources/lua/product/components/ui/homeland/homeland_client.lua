_class("HomelandClient", Object)
HomelandClient = HomelandClient

function HomelandClient:Constructor()
  LogWrapper.LogDebug("家园初始化")
  self._minimapManager = UIHomelandMinimapManager:New()
  self._sceneManager = HomelandSceneManager:New()
  self._interactPointManager = InteractPointManager:New()
  self._buildManager = HomeBuildManager:New()
  self._characterManager = HomelandCharacterManager:New()
  self._cameraManager = HomelandCameraManager:New()
  self._inputManager = HomelandInputManager:New()
  self._petManager = HomelandPetManager:New()
  self._eventManager = HomelandEventManager:New()
  self._3duiManager = Home3DUIManager:New()
  self._homelandFishingManager = HomelandFishingManager:New()
  self._treeCuttingManager = HomelandTreeCuttingManager:New()
  self._homelandTrasureManager = HomelandTreasureManager:New()
  self._homelandFindTreasureManager = nil
  self._homelandMiningManager = HomelandMiningManager:New()
  self._homelandTaskManager = HomelandTaskManager:New()
  self._homelandTraceManager = HomelandTraceManager:New()
  self._homePetFollowManager = HomePetFollowManager:New()
  self._homelandLODManager = HomelandLODManager:New()
  self._mode = HomelandMode.Normal
  self._homelandSceneEffectManager = HomelandSceneEffectManager:New()
  self._homelandPetInviteManager = HomelandPetInviteManager:New()
end

function HomelandClient:Init(TT)
  self._lastTick = GameGlobal:GetInstance():GetLastTimeMS()
  Log.debug("[homeland loading] HomelandClient:Init _sceneManager:Init start")
  self._sceneManager:Init()
  Log.debug("[homeland loading] HomelandClient:Init interactPointManager:Init start")
  self._interactPointManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init buildManager:Init start")
  self._buildManager:Init(TT, self)
  Log.debug("[homeland loading] HomelandClient:Init characterManager:Init start")
  self._characterManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init cameraManager:Init start")
  self._cameraManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init inputManager:Init start")
  self._inputManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init petManager:Init start")
  self._petManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init _homelandTaskManager:Init start")
  self._homelandTaskManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init _homelandTraceManager:Init start")
  self._homelandTraceManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init homelandPetInviteManager:Init start")
  self._homelandPetInviteManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init eventManager:Init start")
  self._eventManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init 3duiManager:Init start")
  self._3duiManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init homelandFishingManager:Init start")
  self._homelandFishingManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init treeCuttingManager:Init start")
  self._treeCuttingManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init homelandTrasureManager:Init start")
  self._homelandTrasureManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init _homelandFindTreasureManager:Init start")
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaigns = campaignModule:GetAllOpenCampaignCompInfo(TT, res)
  if campaigns then
    for i = 1, #campaigns do
      local campaignId = campaigns[i]
      local cfg = Cfg.cfg_campaign[campaignId]
      if cfg then
        local campaignType = cfg.CampaignType
        if campaignType == ECampaignType.CAMPAIGN_TYPE_N21 then
          self._homelandFindTreasureManager = HomelandFindTreasureConst.InitHomelandFindTreausre(TT, self, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
          break
        end
        if campaignType == ECampaignType.CAMPAIGN_TYPE_N18 then
          self._homelandFindTreasureManager = HomelandFindTreasureConst.InitHomelandFindTreausre(TT, self, ECampaignType.CAMPAIGN_TYPE_N18, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
          break
        end
        if campaignType == ECampaignType.CAMPAIGN_TYPE_N17 then
          self._homelandFindTreasureManager = HomelandFindTreasureConst.InitHomelandFindTreausre(TT, self, ECampaignType.CAMPAIGN_TYPE_N17, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME)
          break
        end
      end
    end
  end
  Log.debug("[homeland loading] HomelandClient:Init homelandMiningManager:Init start")
  self._homelandMiningManager:Init(self)
  Log.debug("[homeland loading] HomelandClient:Init _homelandSceneEffectManager:Init start")
  self._homelandSceneEffectManager:Init(self)
  self._homelandLODManager:Init(self)
  self:PlayHomelandBgm()
  Log.debug("[homeland loading] HomelandClient:Init end")
end

function HomelandClient:OnEnterHomeland()
  self._homelandTrasureManager:OnEnterHomeland()
end

function HomelandClient:AfterHomelandUIShow()
  if self._isMainUIShown then
    return
  end
  self._isMainUIShown = true
  if not self:IsVisit() then
    local module = GameGlobal.GetModule(HomelandModule)
    if module:IsPopDormitoryTips() then
      local info = module:GetHomelandInfo().dormitory_info
      local petID
      local count = 0
      for i = 1, 4 do
        local room = info.list[i]
        if room and room.bBulid then
          for _, pstid in pairs(room.hasAddFaPetList) do
            if 0 < pstid then
              petID = petID or pstid
              count = count + 1
            end
          end
        end
      end
      if not petID then
        Log.exception("获取不到增加了好感度的星灵")
      end
      local pet = GameGlobal.GetModule(PetModule):GetPet(petID)
      local icon = HelperProxy:GetInstance():HomeGetBody(petID)
      local name = StringTable.Get(pet:GetPetName())
      local param = {
        icon,
        StringTable.Get("str_homeland_domitory_affinity_is_added", name, tostring(count)),
        true
      }
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomeEventTips, UIHomeEventTipsType.PetBody, param)
    end
    self._eventManager:SendStoryEventTip()
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    uiModule:ShowStartDialog()
  end
end

function HomelandClient:Dispose()
  HomelandWishingConst.Destroy()
  self._homelandLODManager:Dispose()
  self._minimapManager:Destroy()
  self._minimapManager = nil
  self._homelandMiningManager:Dispose()
  if self._homelandFindTreasureManager then
    self._homelandFindTreasureManager:Destroy()
  end
  self._homelandTrasureManager:Dispose()
  self._treeCuttingManager:Dispose()
  self._homelandFishingManager:Dispose()
  self._3duiManager:Dispose()
  self._eventManager:Dispose()
  self._petManager:Dispose()
  self._inputManager:Dispose()
  self._cameraManager:Dispose()
  self._characterManager:Dispose()
  self._buildManager:Dispose()
  self._interactPointManager:Dispose()
  self._sceneManager:Dispose()
  self._homelandTaskManager:Dispose()
  self._homelandTraceManager:Dispose()
  self._homelandSceneEffectManager:Dispose()
  self._homePetFollowManager:Dispose()
  self._homelandPetInviteManager:Dispose()
  LogWrapper.LogDebug("家园销毁")
end

function HomelandClient:Update(curTick)
  local deltaTimeMS = curTick - self._lastTick
  self._lastTick = curTick
  self._inputManager:Update(deltaTimeMS)
  if self._mode == HomelandMode.Normal then
    self._characterManager:Update(deltaTimeMS)
    self._interactPointManager:Update(deltaTimeMS)
    self._petManager:Update(deltaTimeMS)
    self._cameraManager:Update(deltaTimeMS)
    self._buildManager:Update(deltaTimeMS)
  elseif self._mode == HomelandMode.Build then
    self._buildManager:Update(deltaTimeMS)
  end
  self._homelandFishingManager:Update(deltaTimeMS)
  if self._minimapManager then
    self._minimapManager:Update(deltaTimeMS)
  end
  if self._homelandTaskManager then
    self._homelandTaskManager:Update(deltaTimeMS)
  end
  if self._homelandTraceManager then
    self._homelandTraceManager:Update(deltaTimeMS)
  end
  if self._homelandSceneEffectManager then
    self._homelandSceneEffectManager:Update(deltaTimeMS)
  end
  if self._homelandPetInviteManager then
    self._homelandPetInviteManager:Update(deltaTimeMS)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUpdatePerFrame)
end

function HomelandClient:CurrentMode()
  return self._mode
end

function HomelandClient:LastMode()
  return self._lastMode
end

function HomelandClient:StartBuild()
  BuildLog("开始建造")
  self._lastMode = self._mode
  self._mode = HomelandMode.Build
  self._inputManager:OnModeChanged(self._mode)
  self._cameraManager:OnModeChanged(self._mode)
  self._petManager:OnModeChanged(self._mode)
  self._characterManager:OnModeChanged(nil, self._mode)
  self._buildManager:OnModeChanged(nil, self._mode)
  self._homelandTraceManager:OnModeChanged(self._mode)
  self._homelandTaskManager:OnModeChanged(self._mode)
end

function HomelandClient:FinishBuild(TT)
  BuildLog("停止建造")
  self._lastMode = self._mode
  self._mode = HomelandMode.Normal
  self._buildManager:OnModeChanged(TT, self._mode)
  self._inputManager:OnModeChanged(self._mode)
  self._cameraManager:OnModeChanged(self._mode)
  self._petManager:OnModeChanged(self._mode)
  self._characterManager:OnModeChanged(TT, self._mode)
  self._homelandTraceManager:OnModeChanged(self._mode)
  self._homelandTaskManager:OnModeChanged(self._mode)
end

function HomelandClient:BeginStory()
  self._lastMode = self._mode
  self._mode = HomelandMode.Story
  GameGlobal.TaskManager():StartTask(self._OnChangeMode, self)
end

function HomelandClient:_OnChangeMode(TT)
  self._buildManager:OnModeChanged(TT, self._mode)
  self._inputManager:OnModeChanged(self._mode)
  self._cameraManager:OnModeChanged(self._mode)
  self._petManager:OnModeChanged(self._mode)
  self._characterManager:OnModeChanged(TT, self._mode)
  self._homelandTaskManager:OnModeChanged(self._mode)
  self._homelandTraceManager:OnModeChanged(self._mode)
  self._homelandPetInviteManager:OnModeChanged(self._mode)
end

function HomelandClient:EndStory()
  self._lastMode = self._mode
  self._mode = HomelandMode.Normal
  GameGlobal.TaskManager():StartTask(self._OnChangeMode, self)
end

function HomelandClient:FishingManager()
  return self._homelandFishingManager
end

function HomelandClient:SceneManager()
  return self._sceneManager
end

function HomelandClient:CharacterManager()
  return self._characterManager
end

function HomelandClient:CameraManager()
  return self._cameraManager
end

function HomelandClient:InputManager()
  return self._inputManager
end

function HomelandClient:InteractPointManager()
  return self._interactPointManager
end

function HomelandClient:BuildManager()
  return self._buildManager
end

function HomelandClient:PetManager()
  return self._petManager
end

function HomelandClient:Home3DUIManager()
  return self._3duiManager
end

function HomelandClient:TreasureManager()
  return self._homelandTrasureManager
end

function HomelandClient:TreeCuttingManager()
  return self._treeCuttingManager
end

function HomelandClient:OpenPetInteract(pet)
  GameGlobal.UIStateManager():ShowDialog("UIHomePetInteract", pet)
  self._inputManager:GetControllerChar():SetActive(false)
end

function HomelandClient:HomeEventManager()
  return self._eventManager
end

function HomelandClient:FindTreasureManager()
  return self._homelandFindTreasureManager
end

function HomelandClient:HomelandMiningManager()
  return self._homelandMiningManager
end

function HomelandClient:IsVisit()
  return false
end

function HomelandClient:GetMinimapManager()
  return self._minimapManager
end

function HomelandClient:GetHomelandTaskManager()
  return self._homelandTaskManager
end

function HomelandClient:GetHomelandTraceManager()
  return self._homelandTraceManager
end

function HomelandClient:GetHomelandSceneEffectManager()
  return self._homelandSceneEffectManager
end

function HomelandClient:GetHomelandPetInviteManager()
  return self._homelandPetInviteManager
end

function HomelandClient:HomePetFollowManager()
  return self._homePetFollowManager
end

function HomelandClient:PlayHomelandBgm()
  local module = GameGlobal.GetModule(RoleModule)
  local id = module:UI_GetMusic(EnumBgmType.E_Bgm_Homeland)
  if id == 0 then
    id = CriAudioIDConst.BGMEnterHomeland
  else
    local cfg = Cfg.cfg_role_music[id]
    if cfg then
      id = cfg.AudioID
    else
      id = CriAudioIDConst.BGMEnterHomeland
    end
  end
  AudioHelperController.PlayBGM(id, AudioConstValue.BGMCrossFadeTime)
end

function HomelandClient:SetLockGlobalCamera(lock)
  self._cameraManager:SetGlobalCameraLock(lock)
end
