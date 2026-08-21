_class("UIBuildCollectCoinItem", UICustomWidget)
UIBuildCollectCoinItem = UIBuildCollectCoinItem

function UIBuildCollectCoinItem:Constructor()
  self._wishingPlot = {}
  self:ClearWishingPlot()
end

function UIBuildCollectCoinItem:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._selectGo = self:GetGameObject("Select")
  self._canCollectGo = self:GetGameObject("CanCollect")
  self._canCollectLable = self:GetGameObject("CanCollectLable")
  self._canCollectText = self:GetUIComponent("UILocalizationText", "CanCollectText")
  self:AttachEvent(GameEventType.HomeLandEventChange, self.OnHomeLandEventChanged)
end

function UIBuildCollectCoinItem:Refresh(collectCoin, coinData)
  self._coinData = coinData
  self._collectCoin = collectCoin
  self._nameLabel:SetText(self._coinData:GetName())
  self._canCollectText:SetText(StringTable.Get("str_homeland_throw_coin"))
  self._iconLoader:LoadImage(self._coinData:GetIcon())
  if self._coinData:HasCollect() then
    self._canCollectGo:SetActive(false)
    self._canCollectLable:SetActive(false)
  else
    self._canCollectGo:SetActive(HomelandWishingConst.CanCollectCoin(self._coinData:GetCoinId()))
    self._canCollectLable:SetActive(HomelandWishingConst.CanCollectCoin(self._coinData:GetCoinId()))
  end
  self._selectGo:SetActive(self._collectCoin:GetCurrentSelectCoinData() == self._coinData)
end

function UIBuildCollectCoinItem:GetCoinData()
  return self._coinData
end

function UIBuildCollectCoinItem:SetSelectStatus(selected)
  self._selectGo:SetActive(selected)
end

function UIBuildCollectCoinItem:BtnOnClick()
  if not self._coinData:HasCollect() and HomelandWishingConst.CanCollectCoin(self._coinData:GetCoinId()) then
    GameGlobal.TaskManager():StartTask(self.CollectCoro, self)
    return
  end
  self._collectCoin:SelectItem(self)
end

function UIBuildCollectCoinItem:CollectCoro(TT)
  self._wishingPlot.recvEvent = true
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioThrowCoin)
  self:Lock("UIBuildCollectCoinItem_CollectCoro")
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local ret = homelandModule:ApplyCollectItem(TT, self._coinData:GetCoinId())
  self:UnLock("UIBuildCollectCoinItem_CollectCoro")
  if ret:GetSucc() then
    self._collectCoin:SetStatus(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, false, true)
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    local homelandClient = homeLandModule:GetClient()
    local characterController = homelandClient:CharacterManager():MainCharacterController()
    characterController:SetAnimatorTrigger("throw_coins")
    local effect1 = self:AttachModel(self._coinData:GetEffect1(), self._coinData:GetEffect1AttachPath())
    local effect2 = self:AttachModel(self._coinData:GetEffect2(), self._coinData:GetEffect2AttachPath())
    YIELD(TT, 1430)
    if effect1 then
      effect1:Dispose()
      effect1 = nil
    end
    YIELD(TT, 1600)
    if effect2 then
      effect2:Dispose()
      effect2 = nil
    end
    
    local function func()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandMainUI, true, true)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.WishingAddCollectCoin, self._coinData:GetCoinId())
      self._collectCoin:SelectItem(self)
      self._collectCoin:SetStatus(true)
      self._collectCoin:RefershData()
      self._collectCoin:RefreshUI()
      self:CollectCoroCheckStory(TT, homelandModule)
    end
    
    local collectRewards = self._collectCoin:GetCollectCoinRewards()
    local currentTask = collectRewards:GetCurrentTask()
    if currentTask and currentTask:GetWishingCoinCount() <= HomelandWishingConst.GetCollectCoinCounts() then
      local currentRewards = currentTask:GetRewards()
      local rewards = {}
      for i = 1, #currentRewards do
        local roleAsset = RoleAsset:New()
        rewards[#rewards + 1] = roleAsset
        roleAsset.assetid = currentRewards[i][1]
        roleAsset.count = currentRewards[i][2]
      end
      self:ShowDialog("UIHomeShowAwards", rewards, function()
        func()
      end)
    else
      func()
    end
  else
    self:ClearWishingPlot()
    Log.error("投放许愿币错误", ret:GetResult())
  end
end

function UIBuildCollectCoinItem:CollectCoroCheckStory(TT, homelandModule)
  local cfg
  local playStory = self._wishingPlot.playStory
  if playStory then
    local cfgEvents = Cfg.cfg_homeland_event({})
    cfg = cfgEvents[self._wishingPlot.eventID]
  end
  if cfg then
    local eventID = self._wishingPlot.eventID
    local homelandModule = homelandModule.uiModule
    local homelandClient = homelandModule:GetClient()
    
    local function fnFinishEvent()
      local wishBuilding
      local buildManager = homelandClient:BuildManager()
      local buildings = buildManager:GetBuildings()
      for k, v in pairs(buildings) do
        if v:GetBuildType() == ArchitectureSubType.Wishing_Pool then
          wishBuilding = v
          break
        end
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowInteractUI)
      GameGlobal.UIStateManager():ShowDialog("UIBuildCollectCoin", wishBuilding)
    end
    
    local function fnStoryEnd()
      local homelandEventMgr = homelandClient:HomeEventManager()
      homelandEventMgr:SetFinishStoryEvent(fnFinishEvent)
    end
    
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeStoryController, eventID, fnStoryEnd)
    end)
  end
  self:ClearWishingPlot()
end

function UIBuildCollectCoinItem:OnHomeLandEventChanged(erase_event_id, trigger_immediately_event)
  if self._wishingPlot.recvEvent and trigger_immediately_event ~= 0 then
    self._wishingPlot.recvEvent = false
    self._wishingPlot.playStory = true
    self._wishingPlot.eventID = trigger_immediately_event
  end
end

function UIBuildCollectCoinItem:ClearWishingPlot()
  self._wishingPlot.recvEvent = false
  self._wishingPlot.playStory = false
  self._wishingPlot.eventID = 0
end

function UIBuildCollectCoinItem:AttachModel(res, transPath)
  local attachedModel = ResourceManager:GetInstance():SyncLoadAsset(res, LoadType.GameObject)
  if not attachedModel or not attachedModel.Obj then
    Log.error("加载资源失败:" .. res)
    return nil
  end
  local go = attachedModel.Obj
  go:SetActive(true)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  local playerTran = characterManager:GetCharacterTransform()
  local parent = playerTran:Find(transPath)
  local modelTrans = go.transform
  modelTrans:SetParent(parent, false)
  modelTrans.localPosition = Vector3(0, 0, 0)
  modelTrans.localRotation = Quaternion.identity
  return attachedModel
end

function UIBuildCollectCoinItem:ReleaseAttachedModel()
end
