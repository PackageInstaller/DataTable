_class("UIAircraftRoomEnterInteractiveItem", UICustomWidget)
UIAircraftRoomEnterInteractiveItem = UIAircraftRoomEnterInteractiveItem

function UIAircraftRoomEnterInteractiveItem:OnShow(uiParams)
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._levelBarImg1 = self:GetUIComponent("Image", "LevelBar1")
  self._levelBarImg2 = self:GetUIComponent("Image", "LevelBar2")
  self._favorableLabel = self:GetUIComponent("UILocalizationText", "Favorable")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._logoImg = self:GetUIComponent("RawImageLoader", "Logo")
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.FavorableChanged)
end

function UIAircraftRoomEnterInteractiveItem:OnHide()
  self:DetachEvent(GameEventType.PetDataChangeEvent, self.FavorableChanged)
end

function UIAircraftRoomEnterInteractiveItem:FavorableChanged()
  self:_RefreshFavorable()
end

function UIAircraftRoomEnterInteractiveItem:Refresh(uiAircraftController, room, targetPet)
  self._targetPet = targetPet
  self._petData = targetPet:GetPetData()
  self._room = room
  self._uiAircraftController = uiAircraftController
  self:_RefreshPetInfo()
  self:_RefreshButtonStatus()
end

function UIAircraftRoomEnterInteractiveItem:_RefreshPetInfo()
  if self._petData == nil then
    return
  end
  self:_RefreshFavorable()
  self._nameLabel.text = StringTable.Get(self._petData:GetPetName())
  self._logoImg:LoadImage(self._petData:GetPetLogo())
end

function UIAircraftRoomEnterInteractiveItem:_RefreshFavorable()
  if self._petData == nil then
    return
  end
  self._maxLevel = self._petData:GetPetAffinityMaxLevel()
  local level = self._petData:GetPetAffinityLevel()
  local currentFavorable = self._petData:GetPetAffinityExp() - Cfg.cfg_pet_affinity_exp[level].NeedAffintyExp
  local maxFavorable = self._petData:GetPetAffinityMaxExp(level)
  local percent = currentFavorable / maxFavorable
  self._levelLabel.text = level
  local expText
  if level == self._maxLevel then
    expText = "MAX"
    percent = 1
  else
    expText = currentFavorable .. "/" .. maxFavorable
  end
  self._levelBarImg1.fillAmount = percent
  self._levelBarImg2.fillAmount = percent
  self._favorableLabel.text = expText
end

function UIAircraftRoomEnterInteractiveItem:_RefreshButtonStatus()
  local communicationBtnGo = self:GetGameObject("CommunicationButton")
  local eventBtnGo = self:GetGameObject("EventButton")
  local plotBtnGo = self:GetGameObject("PlotButton")
  local taskId = self._petData:GetTriggeredTaskId()
  local storyId = self._petData:GetTriggeredStoryId()
  local hasPlot = storyId and storyId ~= 0
  local hasEvent = taskId and taskId ~= 0
  if hasPlot then
    eventBtnGo:SetActive(false)
    plotBtnGo:SetActive(true)
  elseif hasEvent then
    plotBtnGo:SetActive(false)
    eventBtnGo:SetActive(true)
  else
    plotBtnGo:SetActive(false)
    eventBtnGo:SetActive(false)
  end
  communicationBtnGo:SetActive(true)
end

function UIAircraftRoomEnterInteractiveItem:BtnCommunicationOnClick(go)
  self:GetGameObject():SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchToInteractiveView, self._room, self._targetPet)
end

function UIAircraftRoomEnterInteractiveItem:BtnEventOnClick(go)
  self:Lock("BtnEventOnClick")
  GameGlobal.TaskManager():StartTask(self.HandleEvent, self)
end

function UIAircraftRoomEnterInteractiveItem:HandleEvent(TT)
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local res, storyId = self._petModule:RequestPetViewTriggeredTask(TT, self._petData:GetPstID())
  self:UnLock("BtnEventOnClick")
  if res.m_result == 0 then
    self._uiAircraftController:GetGameObject():SetActive(false)
    if storyId and 0 < storyId then
      self:ShowDialog("UIStoryBanner", storyId, StoryBannerShowType.HalfPortrait, function()
        GameGlobal.TaskManager():StartTask(self.AcceptTask, self)
      end)
    else
      GameGlobal.TaskManager():StartTask(self.AcceptTask, self)
    end
  else
    self:GetGameObject():SetActive(false)
    self._targetPet:ExitSelectedState()
  end
end

function UIAircraftRoomEnterInteractiveItem:AcceptTask(TT)
  self:Lock("BtnEventOnClick")
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local res, replyEvent = self._petModule:RequestPetAcceptTriggeredTask(TT, self._petData:GetPstID())
  self:GetGameObject():SetActive(false)
  self._targetPet:ExitSelectedState()
  if res.m_result == 0 then
    self:ShowDialog("UIAircraftRoomInteractiveEventController", self._petData, replyEvent, function()
      self._uiAircraftController:GetGameObject():SetActive(true)
    end)
  else
    Log.fatal("RequestPetAcceptTriggeredTask err:", replyEvent.m_result)
  end
  self:UnLock("BtnEventOnClick")
end

function UIAircraftRoomEnterInteractiveItem:BtnPlotOnClick(go)
  self:Lock("BtnPlotOnClick")
  GameGlobal.TaskManager():StartTask(self.PlayPlotProcess, self)
end

function UIAircraftRoomEnterInteractiveItem:PlayPlotProcess(TT)
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local res, storyId = self._petModule:RequestPetViewTriggeredStory(TT, self._petData:GetPstID())
  self:UnLock("BtnPlotOnClick")
  self:GetGameObject():SetActive(false)
  if res.m_result == 0 then
    self:ShowDialog("UIStoryController", storyId, function()
      GameGlobal.TaskManager():StartTask(self.FinishPlotProcess, self)
    end)
  else
    self._targetPet:ExitSelectedState()
  end
end

function UIAircraftRoomEnterInteractiveItem:FinishPlotProcess(TT)
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  self:Lock(self:GetName())
  local res, replay = self._petModule:RequestPetFinishTriggeredStory(TT, self._petData:GetPstID())
  self:UnLock(self:GetName())
  if res.m_result == 0 then
    self._uiAircraftController:Get3dManager():CameraManager():SetActive(false)
    local anim = AircraftAffinityAnim:New(self._targetPet:GameObject(), self._uiAircraftController:GetMainCamera(), function()
      self._targetPet:ExitSelectedState()
      self._uiAircraftController:Get3dManager():CameraManager():SetActive(true)
      self:_GetRewards(TT, replay.reward, replay.affinity)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
    end)
    anim:Play()
  end
end

function UIAircraftRoomEnterInteractiveItem:_GetRewards(TT, reward, addedAffinity)
  if addedAffinity and 0 < addedAffinity then
    local info = ""
    local maxLevel = self._petData:GetPetAffinityMaxLevel()
    local level = self._petData:GetPetAffinityLevel()
    if level == self._maxLevel then
      info = StringTable.Get("str_aircraft_room_affinity_add_value_max")
    else
      local petName = StringTable.Get(self._petData:GetPetName())
      info = string.format(StringTable.Get("str_aircraft_room_pet_affinity_add_value"), petName, addedAffinity)
    end
    ToastManager.ShowToast(info)
    YIELD(TT, 1500)
  end
  self:ShowDialog("UIGetItemController", reward)
end

function UIAircraftRoomEnterInteractiveItem:UnlockFiles()
  local affinity = self._petData:GetPetAffinityLevel()
  local petID = self._petData:GetTemplateID()
  local cfg = Cfg.pet_intimacy_condition({ConditionType = 3, Value = affinity})
  local condID = cfg[1].ID
  local fileCfg = Cfg.pet_intimacy_files[petID]
  for i = 1, 6 do
    local cond = fileCfg["Condition" .. i]
    if cond == condID then
      return true
    end
  end
  return false
end

function UIAircraftRoomEnterInteractiveItem:BtnMaskOnClick(go)
  self:GetGameObject():SetActive(false)
  self._targetPet:ExitSelectedState()
end
