_class("UIAircraftRoomInteractiveEventController", UIController)
UIAircraftRoomInteractiveEventController = UIAircraftRoomInteractiveEventController

function UIAircraftRoomInteractiveEventController:Constructor()
end

function UIAircraftRoomInteractiveEventController:OnShow(uiParams)
  self._petData = uiParams[1]
  self._eventInfo = self:_GetEventInfo(uiParams[2])
  self._closeCallback = uiParams[3]
  self._timer = 0
  self._remaindTime = 0
  self._rawImageLoaderHelper = RawImageLoaderHelper:New()
  self._rawImageLoaderHelper:Init(1)
  self._itemCountPerRow = 1
  self._petModeLoader = self:GetUIComponent("RawImageLoader", "PetModel")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._btnGotoGo = self:GetGameObject("ButtonGoto")
  self._btnGetRewardGo = self:GetGameObject("ButtonGetReward")
  self._affinityAddPanel = self:GetGameObject("AffinityAddPanel")
  self._affinityAddPetNameLabel = self:GetUIComponent("UILocalizationText", "AffinityAddPetName")
  self._affinityAddDesLabel = self:GetUIComponent("UILocalizationText", "AffinityAddDes")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "BackBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
    if self._closeCallback then
      self._closeCallback()
    end
  end, nil)
  self._backBtns:HideHomeBtn()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._eventDesLabel = self:GetUIComponent("UILocalizationText", "EventDes")
  self._eventConditionLabel = self:GetUIComponent("UIRichText", "EventCondition")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:_RefreshPetInfo()
  self:_RefreshEventInfo()
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIAircraftRoomInteractiveEventController:OnHide()
  self._scrollView = nil
  self:DetachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIAircraftRoomInteractiveEventController:OnUpdate(deltaTimeMS)
  if self._remaindTime and self._remaindTime > 0 then
    self._timer = self._timer + deltaTimeMS
    if self._timer >= 1000 then
      self._timer = self._timer - 1000
      self._remaindTime = self._remaindTime - 1
      self._timeLabel.text = StringTable.Get("str_aircraft_room_time_down") .. self:_GetTimeStr(self._remaindTime)
    end
  end
end

function UIAircraftRoomInteractiveEventController:_GetTimeStr(seconds)
  if seconds <= 0 then
    return "00:00:00"
  end
  local h = math.floor(seconds / 3600)
  seconds = seconds - h * 3600
  local m = math.floor(seconds / 60)
  seconds = seconds - m * 60
  local timeStr = ""
  if h < 10 then
    timeStr = timeStr .. "0"
  end
  timeStr = timeStr .. h .. ":"
  if m < 10 then
    timeStr = timeStr .. "0"
  end
  timeStr = timeStr .. m .. ":"
  if seconds < 10 then
    timeStr = timeStr .. "0"
  end
  timeStr = timeStr .. seconds
  return timeStr
end

function UIAircraftRoomInteractiveEventController:_ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIAircraftRoomInteractiveEventController:_RefreshPetInfo()
  local matName = self._petData:GetPetStaticBody(PetSkinEffectPath.BODY_AIRCRAFT_ROOM_INTERACT)
  local mat = self._rawImageLoaderHelper:GetMat(matName)
  self._petModeLoader:SetMat(matName, mat, false)
  self._nameLabel.text = StringTable.Get(self._petData:GetPetName())
  UICG.SetTransform(self._petModeLoader.transform, self:GetName(), matName)
end

function UIAircraftRoomInteractiveEventController:_GetEventInfo(info)
  if not info then
    return
  end
  local taskInfo = {}
  taskInfo.reward = info.reward
  taskInfo.taskId = info.m_pet_task_info.task_id
  taskInfo.remainTime = info.m_pet_task_info.end_time
  taskInfo.state = info.m_pet_task_info.state
  taskInfo.addAffinity = info.affinity
  taskInfo.uid = info.m_pet_task_info.uid
  local taskCfg = Cfg.cfg_pet_task[taskInfo.taskId]
  taskInfo.taskType = taskCfg.Type
  taskInfo.title = taskCfg.TaskTitle
  taskInfo.des = taskCfg.TaskDesc
  local taskContent = taskCfg.TaskContent
  if taskInfo.taskType == 1 then
    taskInfo.petTemplateId = taskContent[1]
    taskInfo.itemTemplateId = taskContent[2]
    taskInfo.itemCount = taskContent[3]
  elseif taskInfo.taskType == 2 then
    taskInfo.missionType = taskContent[1]
    taskInfo.missionId = taskContent[2]
    taskInfo.battleCount = taskContent[3]
    if taskInfo.missionType == 1 or taskInfo.missionType == 3 then
      taskInfo.missionId = info.m_pet_task_info.param2
    end
  end
  return taskInfo
end

function UIAircraftRoomInteractiveEventController:_RefreshEventInfo()
  if not self._eventInfo then
    return
  end
  if self._eventInfo.state == PetTaskState.PetTS_Finish then
    self._btnGotoGo:SetActive(false)
    self._btnGetRewardGo:SetActive(true)
  else
    self._btnGotoGo:SetActive(true)
    self._btnGetRewardGo:SetActive(false)
  end
  self._eventDesLabel.text = StringTable.Get(self._eventInfo.des)
  self._rewardCount = 0
  if self._eventInfo.reward then
    self._rewardCount = #self._eventInfo.reward
  end
  self._remaindTime = self._eventInfo.remainTime - self:GetServerTime()
  local conditionStr = ""
  local taskType = self._eventInfo.taskType
  if taskType == 1 then
    local petName = StringTable.Get(Cfg.cfg_pet[self._eventInfo.petTemplateId].Name)
    local count = self._eventInfo.itemCount
    local itemId = self._eventInfo.itemTemplateId
    if itemId or itemId == 0 then
      conditionStr = string.format(StringTable.Get(self._eventInfo.title), petName, count)
    else
      local giftName = StringTable.Get(Cfg.cfg_item[itemId].Name)
      conditionStr = string.format(StringTable.Get(self._eventInfo.title), petName, count, giftName)
    end
  elseif taskType == 2 then
    local petName = StringTable.Get(self._petData:GetPetName())
    local missionName
    local missionType = self._eventInfo.missionType
    local missionId = self._eventInfo.missionId
    if missionType == 1 then
      missionName = StringTable.Get(Cfg.cfg_mission[missionId].Title)
    elseif missionType == 2 then
      missionName = StringTable.Get(Cfg.cfg_extra_mission_task[missionId].TaskName)
    elseif missionType == 3 then
      missionName = StringTable.Get(Cfg.cfg_res_instance_detail[missionId].Name)
    elseif missionType == 4 then
    elseif missionType == 5 then
    end
    if missionName then
      conditionStr = string.format(StringTable.Get(self._eventInfo.title), petName, missionName)
    else
      conditionStr = string.format(StringTable.Get(self._eventInfo.title), petName)
    end
  end
  self._eventConditionLabel.text = conditionStr
  self._timeLabel.text = StringTable.Get("str_aircraft_room_time_down") .. self:_GetTimeStr(self._remaindTime)
  self._affinityAddPanel:SetActive(false)
  if self._eventInfo.addAffinity and 0 < self._eventInfo.addAffinity then
    self._affinityAddPanel:SetActive(true)
    self._affinityAddPetNameLabel.text = StringTable.Get(self._petData:GetPetName())
    self._affinityAddDesLabel.text = string.format(StringTable.Get("str_aircraft_room_affinity_add_value"), self._eventInfo.addAffinity)
  end
  self:_InitSrollView()
end

function UIAircraftRoomInteractiveEventController:GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond, nMilliSecond = math.modf(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function UIAircraftRoomInteractiveEventController:_InitSrollView()
  if self._scrollView == nil then
    return
  end
  self._scrollView:InitListView(self._rewardCount, function(scrollView, index)
    return self:_InitRewardListInfo(scrollView, index)
  end)
end

function UIAircraftRoomInteractiveEventController:_InitRewardListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIAircraftInteractiveEventRewardItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local itemWidget = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._rewardCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_ShowRewardItem(itemWidget, itemIndex)
    end
  end
  return item
end

function UIAircraftRoomInteractiveEventController:_ShowRewardItem(rewardItem, index)
  local id = self._eventInfo.reward[index].assetid
  local count = self._eventInfo.reward[index].count
  rewardItem:SetData(id, count)
end

function UIAircraftRoomInteractiveEventController:BtnGotoOnClick(go)
  local taskType = self._eventInfo.taskType
  if taskType == 1 then
    self:CloseDialog()
    if self._closeCallback then
      self._closeCallback()
    end
    self:ShowDialog("UIPetIntimacyMainController", self._petData, PetIntimacyWindowType.GiftPanel)
  elseif taskType == 2 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Room_Exit, "UI", self._eventInfo.missionType, self._eventInfo.missionId)
  end
end

function UIAircraftRoomInteractiveEventController:BtnGetRewardOnClick(go)
  self:Lock("BtnGetRewardOnClick")
  GameGlobal.TaskManager():StartTask(self.GetRewardProgress, self)
end

function UIAircraftRoomInteractiveEventController:GetRewardProgress(TT)
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local res, replyEvent = self._petModule:RequestCEventRequestPetTaskReward(TT, self._petData:GetPstID(), self._eventInfo.uid)
  self:UnLock("BtnGetRewardOnClick")
  self:CloseDialog()
  if self._closeCallback then
    self._closeCallback()
  end
  if res.m_result == 0 then
    self:_GetRewards(TT, replyEvent.reward, replyEvent.affinity)
  else
    Log.error("RequestCEventRequestPetTaskReward error")
  end
end

function UIAircraftRoomInteractiveEventController:_GetRewards(TT, reward, addedAffinity)
  if addedAffinity and 0 < addedAffinity then
    local info = ""
    local maxLevel = self._petData:GetPetAffinityMaxLevel()
    local level = self._petData:GetPetAffinityLevel()
    if level == maxLevel then
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
