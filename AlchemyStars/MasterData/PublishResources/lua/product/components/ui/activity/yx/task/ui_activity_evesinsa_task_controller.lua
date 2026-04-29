_class("UIActivityEveSinsaTaskController", UIController)
UIActivityEveSinsaTaskController = UIActivityEveSinsaTaskController

function UIActivityEveSinsaTaskController:_GenActivityTypeSpecificData(activityType)
  if activityType == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
    return DActivityTaskSpecificData_EveSinsa:New()
  elseif activityType == ECampaignType.CAMPAIGN_TYPE_HIIRO then
    return DActivityTaskSpecificData_Sakura:New()
  end
  return nil
end

function UIActivityEveSinsaTaskController:_GetComponents()
  self._questList = self:GetUIComponent("UIDynamicScrollView", "_taskList")
  self._progressList = self:GetUIComponent("UIDynamicScrollView", "_progressList")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialogWithAnim()
  end, nil)
  self._progressItemIcon = self:GetUIComponent("RawImageLoader", "_progressItemIcon")
  self._progressItemNumText = self:GetUIComponent("UILocalizationText", "_progressItemNumText")
  local s = self:GetUIComponent("UISelectObjectPath", "_itemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self._progressNumText = self:GetUIComponent("UILocalizationText", "_progressNumText")
  self._bgAnim = self:GetUIComponent("Animation", "_BGCanvas")
  self._uiAnim = self:GetUIComponent("Animation", "_uianim")
end

function UIActivityEveSinsaTaskController:LoadDataOnEnter(TT, res, uiParams)
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
  self._campaign:LoadCampaignInfo(TT, res, self._specificData:GetCampaignType(), self._specificData:GetProgressCmptId(), self._specificData:GetQuestCmptId())
  if res and res:GetSucc() then
    self._phase = UIActivityEveSinsaHelper.CheckTimePhase(self._campaign)
    if self._phase ~= EActivityEveSinsaTimePhase.EPhase_Over and not self._campaign:CheckComponentOpen(self._specificData:GetProgressCmptId(), self._specificData:GetQuestCmptId()) then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityEveSinsaTaskController:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._isFirst = true
  self._isOpen = true
  self._questModule = GameGlobal.GetModule(QuestModule)
  self:AttachEvents()
  self:_GetComponents()
  self:_OnValue()
end

function UIActivityEveSinsaTaskController:CloseDialogWithAnim()
  if self._specificData:IsCloseWithAnim() then
    self:Lock("UIActivityEveSinsaTaskController:CloseDialogWithAnim")
    local animTb = self._specificData:GetCloseAnimTb()
    if animTb then
      if self._bgAnim and animTb.bgCloseAnim then
        self._bgAnim:Play(animTb.bgCloseAnim)
      end
      if self._uiAnim and animTb.uiCloseAnim then
        self._uiAnim:Play(animTb.uiCloseAnim)
      end
    end
    self:StartTask(function(TT)
      YIELD(TT, 700)
      self:UnLock("UIActivityEveSinsaTaskController:CloseDialogWithAnim")
      self:CloseDialog()
    end, self)
  else
    self:CloseDialog()
  end
end

function UIActivityEveSinsaTaskController:OnClose()
  self._isOpen = false
end

function UIActivityEveSinsaTaskController:OnHide()
  if self._surTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._surTimeEvent)
    self._surTimeEvent = nil
  end
  self:RemoveEvents()
end

function UIActivityEveSinsaTaskController:_OnValue()
  if self._isFirst then
    self:_InitProgressItemId()
    self:_FillUIData_Quest()
    self:_FillUIData_Progress()
    self:_InitDynamicList_Quest()
    self:_InitDynamicList_Progress()
    self:_RefreshProgressCurNumText()
    self._isFirst = false
  else
    self:_Refresh()
  end
end

function UIActivityEveSinsaTaskController:_InitProgressItemId()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  self._progressItemId = componentInfo.m_item_id
end

function UIActivityEveSinsaTaskController:_Refresh()
  if self._isOpen then
    self:_FillUIData_Quest()
    self:_FillUIData_Progress()
    self:_RefreshList(self._questListInfo, self._questList)
    self:_RefreshList(self._progressListInfo, self._progressList)
    self:_RefreshProgressCurNumText()
  end
end

function UIActivityEveSinsaTaskController:_RefreshList(info, list)
  local count = table.count(info)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityEveSinsaTaskController:_FillUIData_Quest()
  local cmptId = self._specificData:GetQuestCmptId()
  local component = self._campaign:GetComponent(cmptId)
  self._questListInfo = component:GetQuestInfo()
  for i = 1, #self._questListInfo do
    self._questListInfo[i]._defaultIndex = i
  end
  table.sort(self._questListInfo, function(a, b)
    local val = {}
    val[QuestStatus.QUEST_Completed] = 0
    val[QuestStatus.QUEST_Accepted] = 1
    val[QuestStatus.QUEST_NotStart] = 1
    val[QuestStatus.QUEST_Taken] = 2
    local qa = a:QuestInfo()
    local qb = b:QuestInfo()
    if val[qa.status] == val[qb.status] then
      return a._defaultIndex < b._defaultIndex
    end
    return val[qa.status] < val[qb.status]
  end)
  self._questCount = table.count(self._questListInfo)
end

function UIActivityEveSinsaTaskController:_FillUIData_Progress()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  local listInfo = {}
  local lst = componentInfo.m_progress_rewards
  local count = table.count(lst)
  local index = 1
  local prev = 0
  local it = UIActivityEveSinsaTaskController:_SortPairsByKeys(lst)
  for k, v in it, nil, nil do
    local info = {}
    info.prev = prev
    info.target = k
    info.count = count
    table.insert(listInfo, info)
    index = index + 1
    prev = k
  end
  self._progressListInfo = listInfo
end

function UIActivityEveSinsaTaskController:_InitDynamicList_Quest()
  self._questList:InitListView(self._questCount, function(scrollView, index)
    return self:_SpawnListItem_Task(scrollView, index)
  end)
end

function UIActivityEveSinsaTaskController:_SpawnListItem_Task(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityEveSinsaTaskQuestListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_SetListItemData_Task(listItem, itemIndex)
  end
  return item
end

function UIActivityEveSinsaTaskController:_SetListItemData_Task(listItem, index)
  local quest = self._questListInfo[index]
  self:_RemoveProgressItemInQuestInfo(quest)
  listItem:GetGameObject():SetActive(true)
  if quest ~= nil then
    listItem:SetData(index, quest, function(questInfo)
      self:ListItemClick_Task(questInfo)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
    end, self._specificData:GetQuestGotStr(), self._specificData:GetQuestCanGetStr(), self._specificData:GetQuestBgNotFinish(), self._specificData:GetQuestBgFinish())
  end
end

function UIActivityEveSinsaTaskController:_RemoveProgressItemInQuestInfo(quest)
  if not self._progressItemId then
    self:_InitProgressItemId()
  end
  local questInfo = quest:QuestInfo()
  local newRewards = {}
  local rewards = questInfo.rewards
  for index, value in ipairs(rewards) do
    if value.assetid ~= self._progressItemId then
      table.insert(newRewards, value)
    end
  end
  questInfo.rewards = newRewards
end

function UIActivityEveSinsaTaskController:_RemoveProgressItemInGetItems(getRewards)
  if not self._progressItemId then
    self:_InitProgressItemId()
  end
  local newRewards = {}
  for index, value in ipairs(getRewards) do
    if value.assetid ~= self._progressItemId then
      table.insert(newRewards, value)
    end
  end
  return newRewards
end

function UIActivityEveSinsaTaskController:ListItemClick_Task(questInfo)
  if questInfo.status <= QuestStatus.QUEST_Accepted then
    local jumpModule = self._questModule.uiModule
    if jumpModule == nil then
      Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
      return
    end
    local fromParam = {}
    table.insert(fromParam, QuestType.QT_Daily)
    jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
    local jumpType = questInfo.JumpID
    local jumpParams = questInfo.JumpParam
    jumpModule:SetJumpUIData(jumpType, jumpParams)
    jumpModule:Jump()
  elseif questInfo.status == QuestStatus.QUEST_Completed then
    self:_GetListItemReward_Task(questInfo.quest_id)
  end
end

function UIActivityEveSinsaTaskController:_GetListItemReward_Task(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityEveSinsaTaskController:_GetListItemRewardReq_Task")
  self:StartTask(self._GetListItemRewardReq_Task, self, id)
end

function UIActivityEveSinsaTaskController:_GetListItemRewardReq_Task(TT, id)
  local cmptId = self._specificData:GetQuestCmptId()
  local component = self._campaign:GetComponent(cmptId)
  if component then
    local res = AsyncRequestRes:New()
    local ret, rewards = component:HandleQuestTake(TT, res, id)
    self:UnLock("UIActivityEveSinsaTaskController:_GetListItemRewardReq_Task")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      rewards = self:_RemoveProgressItemInGetItems(rewards)
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

function UIActivityEveSinsaTaskController:_InitDynamicList_Progress()
  local count = table.count(self._progressListInfo)
  self._progressList:InitListView(count, function(scrollView, index)
    return self:_SpawnListItem_Progress(scrollView, index)
  end)
end

function UIActivityEveSinsaTaskController:_SpawnListItem_Progress(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityEveSinsaTaskProgressItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_SetListItemData_Progress(listItem, itemIndex)
  end
  return item
end

function UIActivityEveSinsaTaskController:_SetListItemData_Progress(listItem, index)
  listItem:GetGameObject():SetActive(true)
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  local count = table.count(self._progressListInfo)
  listItem:SetData(index, count, self._progressListInfo[index], componentInfo, function(idx)
    self:_ListItemClick_Progress(idx)
  end, function(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
  end, self._specificData)
end

function UIActivityEveSinsaTaskController:_ListItemClick_Progress(idx)
  self:_GetListItemReward_Progress(self._progressListInfo[idx].target)
end

function UIActivityEveSinsaTaskController:_GetListItemReward_Progress(param)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityEveSinsaTaskController:_GetListItemReward_Progress")
  self:StartTask(self._GetListItemRewardReq_Progress, self, param)
end

function UIActivityEveSinsaTaskController:_GetListItemRewardReq_Progress(TT, param)
  local progress = param
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  if component then
    local res = AsyncRequestRes:New()
    local rewards = component:HandleReceiveReward(TT, res, progress)
    self:UnLock("UIActivityEveSinsaTaskController:_GetListItemReward_Progress")
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

function UIActivityEveSinsaTaskController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIActivityEveSinsaTaskController:RemoveEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIActivityEveSinsaTaskController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityEveSinsaTaskController:OnUIGetItemCloseInQuest(type)
  self:_Refresh()
end

function UIActivityEveSinsaTaskController:_OnActivityQuestAwardItemClick(matid, pos)
  self:ShowItemInfo(matid, pos)
end

function UIActivityEveSinsaTaskController:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UIActivityEveSinsaTaskController:_ShowUIGetItemController(rewards)
  self:ShowDialog("UIGetItemController", rewards, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end)
end

function UIActivityEveSinsaTaskController:_RefreshProgressCurNumText()
  local cmptId = self._specificData:GetProgressCmptId()
  local component = self._campaign:GetComponent(cmptId)
  local componentInfo = component:GetComponentInfo()
  if not componentInfo then
    return
  end
  if self._progressNumText then
    local curNum = componentInfo.m_current_progress
    self._progressNumText:SetText(StringTable.Get("str_sakura_task_finish_num") .. curNum)
  end
  if self._progressItemIcon then
    local itemId = componentInfo.m_item_id
    local cfgItem = Cfg.cfg_item[itemId]
    if cfgItem then
      self._progressItemIcon:LoadImage(cfgItem.Icon)
    end
  end
  if self._progressItemNumText then
    self._progressItemNumText:SetText(componentInfo.m_current_progress)
  end
end

function UIActivityEveSinsaTaskController:_SortPairsByKeys(t)
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
