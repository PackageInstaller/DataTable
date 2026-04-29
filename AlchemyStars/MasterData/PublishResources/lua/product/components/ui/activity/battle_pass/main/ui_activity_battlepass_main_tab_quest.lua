_class("UIActivityBattlePassMainTabQuest", UICustomWidget)
UIActivityBattlePassMainTabQuest = UIActivityBattlePassMainTabQuest

function UIActivityBattlePassMainTabQuest:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassMainTabQuest:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassMainTabQuest:_GetQuestComponent(id)
  local id2cmptId = {
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
  }
  local cmptId = id2cmptId[id]
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassMainTabQuest:_GetQuestComponentInfo(id)
  local id2cmptId = {
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
  }
  local cmptId = id2cmptId[id]
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassMainTabQuest:_GetComponents()
end

function UIActivityBattlePassMainTabQuest:SetData(campaign)
  self._campaign = campaign
  self:_GetComponents()
end

function UIActivityBattlePassMainTabQuest:OnShow(uiParams)
  self._isFirst = true
  self._isOpen = true
  self._QuestCount = 3
  self._index = 1
end

function UIActivityBattlePassMainTabQuest:OnHide()
end

function UIActivityBattlePassMainTabQuest:_ReLoadData(TT, res)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self:_SetQuestGroup()
  self:_SetDynamicList(false)
end

function UIActivityBattlePassMainTabQuest:_Refresh(resetPos, upgrade)
  if self._isOpen then
    self:_CheckQuestDailyReset()
    self:_SetExpInfo(upgrade)
    self:_SetQuestGroup()
    self:_SetDynamicList(resetPos)
  end
end

function UIActivityBattlePassMainTabQuest:_SetExpInfo(upgrade)
  local componentInfo = self:_GetLVRewardComponentInfo()
  local expInfoPool = self:GetUIComponent("UISelectObjectPath", "expInfoPool")
  self._expInfoPool = expInfoPool:SpawnObject("UIActivityBattlePassExpInfo")
  self._expInfoPool:SetData(componentInfo, upgrade)
end

function UIActivityBattlePassMainTabQuest:_CheckLvMax()
  local component = self:_GetLVRewardComponent()
  return component:CheckIsLevelMax()
end

function UIActivityBattlePassMainTabQuest:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local component = self:_GetQuestComponent(1)
  local nextTime = component:GetEarliestEndTimeInDailyQuest()
  local stamp = nextTime - curTime
  if 0 <= stamp then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    component:HandleCamQuestDailyReset(TT, res)
    if res:GetSucc() then
      self:_ReLoadData(TT, res)
    end
  end, self)
end

function UIActivityBattlePassMainTabQuest:_SetQuestGroup()
  local sop = self:GetUIComponent("UISelectObjectPath", "questGroup")
  sop:SpawnObjects("UIActivityBattlePassQuestGroupBtn", self._QuestCount)
  self._groupBtnList = sop:GetAllSpawnList()
  for i, v in ipairs(self._groupBtnList) do
    v:SetData(i, self._campaign, self:_GetQuestComponentInfo(i), function(index)
      self:OnGroupBtnClick(index)
    end)
    v:SetSelected(i == self._index)
  end
end

function UIActivityBattlePassMainTabQuest:OnGroupBtnClick(index)
  self._index = index
  self:_Refresh(true, false)
  for i, v in ipairs(self._groupBtnList) do
    v:SetSelected(index == i)
  end
end

function UIActivityBattlePassMainTabQuest:_FlushQuestItems()
  local showTab = self._dynamicList:GetVisibleItemIDsInScrollView()
  for index = 0, showTab.Count - 1 do
    local id = math.floor(showTab[index])
    local item = self._dynamicList:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    for i = 1, self._itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      listItem:PlayAnimationInSequence(itemIndex)
    end
  end
end

function UIActivityBattlePassMainTabQuest:_SetDynamicListData()
  local component = self:_GetQuestComponent(self._index)
  self._dynamicListInfo = component:GetQuestInfo()
  self._questStatus = component:GetCampaignQuestStatus(self._dynamicListInfo)
  component:SortQuestInfoByCampaignQuestStatus(self._dynamicListInfo)
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassMainTabQuest:_SetDynamicList(resetPos)
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList, resetPos)
  end
  self:_FlushQuestItems()
end

function UIActivityBattlePassMainTabQuest:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UIActivityBattlePassMainTabQuest:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassQuestListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIActivityBattlePassMainTabQuest:_SetListItemData(listItem, index)
  local componentInfo = self:_GetQuestComponentInfo(self._index)
  local quest = self._dynamicListInfo[index]
  local status = self._questStatus[quest]
  listItem:GetGameObject():SetActive(true)
  if quest ~= nil then
    listItem:SetData(index, self._campaign, quest, status, componentInfo, function(questInfo)
      self:ListItemOnClick(questInfo)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
    end)
  end
end

function UIActivityBattlePassMainTabQuest:ListItemOnClick(questInfo)
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
    self:_GetListItemReward(questInfo.quest_id)
  end
end

function UIActivityBattlePassMainTabQuest:_GetListItemReward(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityBattlePassMainTabQuest:_GetListItemRewardReq")
  self:StartTask(self._GetListItemRewardReq, self, id)
end

function UIActivityBattlePassMainTabQuest:_GetListItemRewardReq(TT, id)
  local component = self:_GetQuestComponent(self._index)
  if component then
    local res = AsyncRequestRes:New()
    local ret, rewards = component:HandleQuestTake(TT, res, id)
    self:UnLock("UIActivityBattlePassMainTabQuest:_GetListItemRewardReq")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      if self:_CheckLvMax() then
        ToastManager.ShowToast(StringTable.Get("str_activity_battlepass_buy_deluxe_notify_maxlv"))
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
      else
        UIActivityHelper.ShowUIGetRewards(rewards)
      end
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh(true, false)
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
  end
end
