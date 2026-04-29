_class("UISendPetQuest", UIController)
UISendPetQuest = UISendPetQuest

function UISendPetQuest:GetQuestList()
  local comInfo = self._questCom:GetComponentInfo()
  local questList = comInfo.m_accept_cam_quest_list
  self._questList = {}
  for k, v in pairs(questList) do
    table.insert(self._questList, v)
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  table.sort(self._questList, function(a, b)
    local weiget_a = 0
    local weiget_b = 0
    local questInfo_a = self:GetQuestInfo(a)
    local questInfo_b = self:GetQuestInfo(b)
    local component_quest_a = Cfg.cfg_component_quest({
      QuestID = questInfo_a.quest_id
    })
    local component_quest_b = Cfg.cfg_component_quest({
      QuestID = questInfo_b.quest_id
    })
    local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
    local endTimeA = loginModule:GetTimeStampByTimeStr(component_quest_a[1].EndDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTimeB = loginModule:GetTimeStampByTimeStr(component_quest_b[1].EndDateTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local secEndA = nowTime - endTimeA
    local secEndB = nowTime - endTimeB
    if questInfo_a.status == QuestStatus.QUEST_Completed then
      weiget_a = 30
    elseif questInfo_a.status == QuestStatus.QUEST_Taken then
      weiget_a = 10
    else
      weiget_a = 20
    end
    if questInfo_b.status == QuestStatus.QUEST_Completed then
      weiget_b = 30
    elseif questInfo_b.status == QuestStatus.QUEST_Taken then
      weiget_b = 10
    else
      weiget_b = 20
    end
    if 0 < secEndA then
      weiget_a = 0
    end
    if 0 < secEndB then
      weiget_b = 0
    end
    if weiget_a == weiget_b then
      local cfg_com_quest_a = Cfg.cfg_component_quest({QuestID = a})[1]
      local cfg_com_quest_b = Cfg.cfg_component_quest({QuestID = b})[1]
      if cfg_com_quest_a.NeedReset == cfg_com_quest_b.NeedReset then
        return a < b
      else
        return not cfg_com_quest_b.NeedReset
      end
    else
      return weiget_a > weiget_b
    end
  end)
end

function UISendPetQuest:OnShow(uiParam)
  self._itemCountPerRow = 1
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._campaign = uiParam[1]
  self._questCom = uiParam[2]
  self.clickCallBack = uiParam[3]
  self.closeCallBack = uiParam[4]
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  local tipsPool = self:GetUIComponent("UISelectObjectPath", "tipsPool")
  self._tipsInfo = tipsPool:SpawnObject("UISelectInfo")
  self:SetBlur()
  self:GetComponents()
  self:OnRefresh()
  self:AttachEvents()
end

function UISendPetQuest:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:DetachEvents()
  self:UnLock("UISendPetQuest:RefreshQuestReq")
end

function UISendPetQuest:OnDestroy()
end

function UISendPetQuest:AttachEvents()
  self:AttachEvent(GameEventType.QuestUpdate, self.OnRefresh)
end

function UISendPetQuest:DetachEvents()
  self:DetachEvent(GameEventType.QuestUpdate, self.OnRefresh)
end

function UISendPetQuest:GetComponents()
  self._questScrollView = self:GetUIComponent("UIDynamicScrollView", "QuestList")
  self._contentRT = self:GetUIComponent("RectTransform", "Content")
  self._remaineTime = self:GetUIComponent("UILocalizationText", "remaineTime")
end

function UISendPetQuest:OnRefresh()
  self:ShowTimer()
  self:GetQuestList()
  self:OnValue()
end

function UISendPetQuest:OnValue()
  self:SetQuestList()
end

function UISendPetQuest:SetBlur()
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self._blur = self:GetUIComponent("H3DUIBlurHelper", "Blur")
  self._blur.OwnerCamera = bgCanvas.worldCamera
  self._blur:RefreshBlurTexture()
end

function UISendPetQuest:GetQuestInfo(id)
  return self._questModule:GetQuest(id):QuestInfo()
end

function UISendPetQuest:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local luaUnit = rowPool:SpawnObject("UISendPetQuestWidget")
  if luaUnit then
    local luaIdx = index + 1
    local questid = self._questList[luaIdx]
    local questInfo = self:GetQuestInfo(questid)
    luaUnit:SetData(luaIdx, self._campaign, questInfo, function(idx)
      self:QuestItemClick(idx)
    end, function(assetId, pos)
      self:AwardClick(assetId, pos)
    end)
  end
  return item
end

function UISendPetQuest:AwardClick(assetId, pos)
  if self._tipsInfo then
    self._tipsInfo:SetData(assetId, pos)
  end
end

function UISendPetQuest:SetQuestList()
  if self._questScrollViewInited then
    self._questScrollView:SetListItemCount(#self._questList)
    self._questScrollView:RefreshAllShownItem()
    self._questScrollView:MovePanelToItemIndex(0, 0)
  else
    self._questScrollView:InitListView(#self._questList, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._questScrollViewInited = true
  end
end

function UISendPetQuest:QuestItemClick(id)
  self:Lock("UISendPetQuest:QuestItemClick")
  GameGlobal.TaskManager():StartTask(self.OnQuestItemClick, self)
end

function UISendPetQuest:OnQuestItemClick(TT)
  local res = AsyncRequestRes:New()
  local ret, rewards = self._questCom:HandleOneKeyTakeQuest(TT, res)
  self:UnLock("UISendPetQuest:QuestItemClick")
  if res and res:GetSucc() then
    self:ShowUIGetItemController(rewards)
    self:GetQuestList()
    self:OnValue()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSendPetCardQuestGet)
    if self.clickCallBack then
      self.clickCallBack()
    end
  else
    Log.error("###[UISendPetQuest] HandleOneKeyTakeQuest fail! result:", res:GetResult())
  end
end

function UISendPetQuest:ShowUIGetItemController(rewards)
  if not rewards then
    return
  end
  self._petModule = GameGlobal.GetModule(PetModule)
  local tempPets = {}
  if 0 < #rewards then
    for i = 1, #rewards do
      local ispet = self._petModule:IsPetID(rewards[i].assetid)
      if ispet then
        table.insert(tempPets, rewards[i])
      end
    end
  end
  
  local function cbFunc()
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards, cbFunc)
    end)
  else
    self:ShowDialog("UIGetItemController", rewards, cbFunc)
  end
end

function UISendPetQuest:CloseBtnOnClick(go)
  if self.closeCallBack then
    self.closeCallBack()
  end
  self:CloseDialog()
end

function UISendPetQuest:ShowTimer()
  self._nextRefreshTime = self._loginModule:GetNextTimeStampByHMS(5, 0, 0)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTimeTex()
  end)
  self:ShowTimeTex()
end

function UISendPetQuest:ShowTimeTex()
  local nextTime = self._nextRefreshTime
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = nextTime - nowTime
  if 0 <= sec then
    local secStr = HelperProxy:GetInstance():Time2Tex(sec)
    self._remaineTime:SetText(StringTable.Get("str_activity_task_daily_desc", "  " .. secStr))
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self:Lock("UISendPetQuest:RefreshQuestReq")
    GameGlobal.TaskManager():StartTask(self.RefreshQuestReq, self)
  end
end

function UISendPetQuest:RefreshQuestReq(TT)
  local res = AsyncRequestRes:New()
  self._questCom:HandleCamQuestDailyReset(TT, res)
  self:UnLock("UISendPetQuest:RefreshQuestReq")
  self:OnRefresh()
end
