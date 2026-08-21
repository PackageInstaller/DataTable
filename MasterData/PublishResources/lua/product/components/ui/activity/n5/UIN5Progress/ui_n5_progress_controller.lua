local UIActivityProgressRewardState = {
  STATE_LOCK = 0,
  STATE_UNLOCK = 1,
  STATE_RECEIVED = 2
}
_enum("UIActivityProgressRewardState", UIActivityProgressRewardState)
local UIN5ProgressCellType = {
  CELL_NPC_DETAIL = 0,
  CELL_SIMPLE = 1,
  CELL_PLAYER = 2
}
_enum("UIN5ProgressCellType", UIN5ProgressCellType)
_class("UIN5ProgressController", UIController)
UIN5ProgressController = UIN5ProgressController

function UIN5ProgressController:_GenActivityTypeSpecificData(activityType)
  if activityType == ECampaignType.CAMPAIGN_TYPE_N5 then
    return DActivityTaskSpecificData_N5:New()
  end
  return nil
end

function UIN5ProgressController:Constructor()
  self._cmptCloseTime = 0
  self._refreshTimeEvent = nil
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._PlayDragSound = false
end

function UIN5ProgressController:LoadDataOnEnter(TT, res, uiParams)
  if not self._specificData and uiParams and uiParams[1] then
    local campaignType = uiParams[1]
    self._specificData = self:_GenActivityTypeSpecificData(campaignType)
  end
  if not self._specificData then
    res:SetSucc(false)
    return
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._specificData:GetCampaignType(), self._specificData:GetProgressCmptId())
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(self._specificData:GetProgressCmptId())
    local campInfo = camp:GetComponentInfo()
    local openTime = campInfo.m_unlock_time
    local closeTime = campInfo.m_close_time
    self._cmptCloseTime = closeTime
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if openTime > now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    elseif closeTime < now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN5ProgressController:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._isFirst = true
  self._isOpen = true
  self:InitWidget()
  self:AttachEvents()
  self:_OnValue()
  self:_OnValueRemainingTime()
  CutsceneManager.ExcuteCutsceneOut()
end

function UIN5ProgressController:OnHide()
  self._isOpen = false
  if self._refreshTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._refreshTimeEvent)
    self._refreshTimeEvent = nil
  end
end

function UIN5ProgressController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:_Close()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self._progressItemIcon = self:GetUIComponent("RawImageLoader", "_progressItemIcon")
  self._progressItemNumText = self:GetUIComponent("UILocalizationText", "_progressItemNumText")
  self._progressList = self:GetUIComponent("UIDynamicScrollView", "_progressList")
  self._progressListScroll = self:GetGameObject("_progressList")
  self._restTimeText = self:GetUIComponent("UILocalizationText", "_restTimeText")
  self._restTimeAreaGo = self:GetGameObject("_restTimeArea")
  self._getAllRedPointAreaGo = self:GetGameObject("_getAllRedPointArea")
  self._getAllBtnCanvasGroup = self:GetUIComponent("CanvasGroup", "_getAllBtn")
  local s = self:GetUIComponent("UISelectObjectPath", "_itemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._progressListScroll), UIEvent.BeginDrag, function(pointData)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.N5ProgressScrollDragBegin)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._progressListScroll), UIEvent.Drag, function(pointData)
    self._PlayDragSound = true
  end)
end

function UIN5ProgressController:_OnValue()
  if self._isFirst then
    self:_InitProgressItemId()
    self:_FillUIData_Progress()
    self:_InitDynamicList_Progress()
    self:_RefreshProgressCurNumText()
    self:_SetDynamicListInitPos_Progress()
    self:_RefreshGetAllBtnArea()
    self._isFirst = false
  else
    self:_Refresh()
  end
end

function UIN5ProgressController:_Close()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN5, function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN5ProgressController:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._refreshTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._refreshTimeEvent)
    self._refreshTimeEvent = nil
  end
  self._refreshTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIN5ProgressController:_ShowRemainingTime()
  local stopTime = self._cmptCloseTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._refreshTimeEvent then
      GameGlobal.RealTimer():CancelEvent(self._refreshTimeEvent)
      self._refreshTimeEvent = nil
    end
    self._restTimeAreaGo:SetActive(false)
    remainingTime = 0
  else
    self._restTimeAreaGo:SetActive(true)
  end
  local timeStr = self:_GetRemainTime(remainingTime)
  local str = StringTable.Get("str_n5_reward_remaining_time")
  local formatStr = "%s%s"
  local showStr = string.format(formatStr, str, timeStr)
  self._restTimeText:SetText(showStr)
end

function UIN5ProgressController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = "<color=#E03D22>" .. day .. "</color>" .. StringTable.Get("str_activity_common_day") .. "<color=#E03D22>" .. hour .. "</color>" .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = "<color=#E03D22>" .. hour .. "</color>" .. StringTable.Get("str_activity_common_hour") .. "<color=#E03D22>" .. minute .. "</color>" .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = "<color=#E03D22>" .. minute .. "</color>" .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIN5ProgressController:_InitProgressItemId()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  self._progressItemId = componentInfo.m_item_id
end

function UIN5ProgressController:_Refresh()
  if self._isOpen then
    self:_FillUIData_Progress()
    self:_RefreshList(self._progressListInfo, self._progressList)
    self:_RefreshProgressCurNumText()
    self:_SetDynamicListInitPos_Progress()
    self:_RefreshGetAllBtnArea()
  end
end

function UIN5ProgressController:_RefreshList(info, list)
  local count = table.count(info)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIN5ProgressController:_MakeRankList()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  local playerScore = componentInfo.m_current_progress
  local cmptCfgId = component:GetComponentCfgId()
  local rankList = {}
  local cfgGroup = Cfg.cfg_activity_person_progress_extra_client({ComponentID = cmptCfgId})
  if cfgGroup and 0 < #cfgGroup then
    for index, value in ipairs(cfgGroup) do
      local npcNameCfg = value.NpcName
      if not string.isnullorempty(npcNameCfg) then
        local rankInfo = {}
        rankInfo.target = value.ItemCount
        table.insert(rankList, rankInfo)
      end
    end
  end
  local rankInfo = {}
  rankInfo.target = playerScore
  table.insert(rankList, rankInfo)
  table.sort(rankList, function(a, b)
    return a.target > b.target
  end)
end

function UIN5ProgressController:_FillUIData_Progress()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  local cmptCfgId = component:GetComponentCfgId()
  local playerScore = componentInfo.m_current_progress
  local listInfo = {}
  local lst = componentInfo.m_progress_rewards
  local spRewards = componentInfo.m_special_rewards
  local count = table.count(lst)
  local bInsertPlayer = false
  local showRank = 0
  local maxRank = 0
  local lastScore = -1
  local it = self:_SortPairsByKeys(lst)
  for k, v in it, nil, nil do
    local info = {}
    info.rank = -1
    info.cellType = UIN5ProgressCellType.CELL_SIMPLE
    info.target = k
    info.count = count
    local bIsSp = spRewards[k]
    info.bSpecial = bIsSp ~= nil
    local cfgGroup = Cfg.cfg_activity_person_progress_extra_client({ComponentID = cmptCfgId, ItemCount = k})
    if cfgGroup and 0 < #cfgGroup then
      local curCfg = cfgGroup[1]
      if playerScore < info.target and not bInsertPlayer then
        local playerInfo = {}
        playerInfo.target = playerScore
        playerInfo.count = 0
        playerInfo.cellType = UIN5ProgressCellType.CELL_PLAYER
        playerInfo.bSpecial = false
        showRank = showRank + 1
        lastScore = info.target
        playerInfo.rank = showRank
        table.insert(listInfo, playerInfo)
        bInsertPlayer = true
      end
      local npcNameCfg = curCfg.NpcName
      if not string.isnullorempty(npcNameCfg) then
        info.cellType = UIN5ProgressCellType.CELL_NPC_DETAIL
        showRank = showRank + 1
        lastScore = info.target
        info.rank = showRank
      end
    end
    table.insert(listInfo, info)
  end
  if not bInsertPlayer then
    local playerInfo = {}
    playerInfo.target = playerScore
    playerInfo.count = 0
    playerInfo.cellType = UIN5ProgressCellType.CELL_PLAYER
    playerInfo.bSpecial = false
    showRank = showRank + 1
    playerInfo.rank = showRank
    table.insert(listInfo, playerInfo)
    bInsertPlayer = true
  end
  maxRank = showRank
  for index, value in ipairs(listInfo) do
    if value.rank ~= -1 then
      value.rank = maxRank - value.rank + 1
    end
  end
  self._progressListInfo = listInfo
end

function UIN5ProgressController:_InitDynamicList_Progress()
  local count = table.count(self._progressListInfo)
  self._progressList:InitListView(count, function(scrollView, index)
    return self:_SpawnListItem_Progress(scrollView, index)
  end)
end

function UIN5ProgressController:_CalDynamicListInitPos_Progress()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  local tarPos = 0
  local curCell = 1
  local cur = componentInfo.m_current_progress
  local received = componentInfo.m_received_progress
  for index, value in ipairs(self._progressListInfo) do
    local state = UIActivityProgressRewardState.STATE_LOCK
    if cur >= value.target then
      state = UIActivityProgressRewardState.STATE_UNLOCK
      if value.cellType ~= UIN5ProgressCellType.CELL_PLAYER then
        for _, x in pairs(received) do
          if x == value.target then
            state = UIActivityProgressRewardState.STATE_RECEIVED
          end
        end
      end
    end
    if state == UIActivityProgressRewardState.STATE_UNLOCK then
      curCell = index
      break
    end
  end
  tarPos = curCell - 1
  return tarPos
end

function UIN5ProgressController:_SetDynamicListInitPos_Progress()
  local pos = self:_CalDynamicListInitPos_Progress()
  self._progressList:MovePanelToItemIndex(pos, 275)
end

function UIN5ProgressController:_SpawnListItem_Progress(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN5ProgressItemGen", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_SetListItemData_Progress(listItem, itemIndex)
  end
  return item
end

function UIN5ProgressController:_SetListItemData_Progress(listItem, index)
  listItem:GetGameObject():SetActive(true)
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local cmptCfgId = component:GetComponentCfgId()
  local componentInfo = component:GetComponentInfo()
  local count = table.count(self._progressListInfo)
  local rankIndex = -1
  if self._PlayDragSound then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5MilitaryExploitScrolling)
  end
  listItem:SetData(index, count, self._progressListInfo[index], componentInfo, function(idx)
    self:_ListItemClick_Progress(idx)
  end, function(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
  end, self._specificData, cmptCfgId)
end

function UIN5ProgressController:_ListItemClick_Progress(idx)
  self:_GetListItemReward_Progress(self._progressListInfo[idx].target)
end

function UIN5ProgressController:_GetListItemReward_Progress(param)
  self:Lock("UIN5ProgressController:_GetListItemReward_Progress")
  self:StartTask(self._GetListItemRewardReq_Progress, self, param)
end

function UIN5ProgressController:_GetListItemRewardReq_Progress(TT, param)
  local progress = param
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  if component then
    local res = AsyncRequestRes:New()
    local rewards = component:HandleReceiveReward(TT, res, progress)
    self:UnLock("UIN5ProgressController:_GetListItemReward_Progress")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      self:_ShowUIGetItemController(rewards)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh()
      end, function()
        self:CloseDialog()
      end)
    end
  end
end

function UIN5ProgressController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIN5ProgressController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN5ProgressController:OnUIGetItemCloseInQuest(type)
  self:_Refresh()
end

function UIN5ProgressController:_OnActivityQuestAwardItemClick(matid, pos)
  self:ShowItemInfo(matid, pos)
end

function UIN5ProgressController:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UIN5ProgressController:_ShowUIGetItemController(rewards)
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
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
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

function UIN5ProgressController:_RefreshProgressCurNumText()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  if not componentInfo then
    return
  end
  if self._progressItemIcon then
    local itemId = componentInfo.m_item_id
    local cfgItem = Cfg.cfg_item[itemId]
    if cfgItem then
      self._progressItemIcon:LoadImage(cfgItem.Icon)
    end
  end
  if self._progressItemNumText then
    self._progressItemNumText:SetText(self:_MakeCurProgressText(componentInfo.m_current_progress))
  end
end

function UIN5ProgressController:_MakeCurProgressText(cur)
  if cur then
    local tarNumDight = 6
    local retStr = UIActivityHelper.AddZeroFrontNum(6, cur)
    return retStr
  end
end

function UIN5ProgressController:_RefreshGetAllBtnArea()
  self._getAllShowRed = self._campaign:CheckComponentRed(self._specificData:GetProgressCmptId())
  self._getAllRedPointAreaGo:SetActive(self._getAllShowRed)
end

function UIN5ProgressController:GetAllBtnOnClick()
  if not self._getAllShowRed then
    return
  end
  self:Lock("UIN5ProgressController:GetAllBtnOnClick")
  self:StartTask(self._GetAllRewardReq_Progress, self)
end

function UIN5ProgressController:_GetAllRewardReq_Progress(TT)
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  if component then
    local res = AsyncRequestRes:New()
    local rewards = component:HandleOneKeyReceiveRewards(TT, res)
    self:UnLock("UIN5ProgressController:GetAllBtnOnClick")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      self:_ShowUIGetItemController(rewards)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh()
      end, function()
        self:CloseDialog()
      end)
    end
  end
end

function UIN5ProgressController:_SortPairsByKeys(t)
  local a = {}
  for n in pairs(t) do
    a[#a + 1] = n
  end
  table.sort(a)
  local i = 0
  return function()
    i = i + 1
    return a[i], t[a[i]]
  end
end
