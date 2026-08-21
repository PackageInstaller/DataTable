_class("UIActivityBattlePassN5MainTabQuest", UICustomWidget)
UIActivityBattlePassN5MainTabQuest = UIActivityBattlePassN5MainTabQuest

function UIActivityBattlePassN5MainTabQuest:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5MainTabQuest:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5MainTabQuest:_GetQuestComponentId(id)
  local id2cmptId = {
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
  }
  return id2cmptId[id]
end

function UIActivityBattlePassN5MainTabQuest:_GetQuestComponent(id)
  local cmptId = self:_GetQuestComponentId(id)
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassN5MainTabQuest:_GetQuestComponentInfo(id)
  local cmptId = self:_GetQuestComponentId(id)
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassN5MainTabQuest:_GetComponents()
  self._bottomObj = self:GetGameObject("bottom")
end

function UIActivityBattlePassN5MainTabQuest:SetData(campaign)
  self._campaign = campaign
  self:_GetComponents()
end

function UIActivityBattlePassN5MainTabQuest:OnShow(uiParams)
  self._isFirst = true
  self._isOpen = true
  self._canGetTb = {}
  self._index = 1
end

function UIActivityBattlePassN5MainTabQuest:OnHide()
end

function UIActivityBattlePassN5MainTabQuest:_ReLoadData(TT, res)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self:_SetQuestGroup()
  self:_SetDynamicList(false, false)
end

function UIActivityBattlePassN5MainTabQuest:_Refresh(resetPos, upgrade, anim_PlayIn, anim_ListItem)
  if self._isOpen then
    table.clear(self._canGetTb)
    self:_CheckQuestDailyReset()
    if upgrade and upgrade ~= 0 then
      self:_SetExpInfo(upgrade == 2)
    end
    self:_SetQuestGroup()
    self:_SetDynamicList(resetPos, anim_ListItem)
    if #self._canGetTb <= 0 then
      self._bottomObj:SetActive(false)
    else
      self._bottomObj:SetActive(true)
    end
    if anim_PlayIn then
      self:_PlayAnimIn()
    end
  end
end

function UIActivityBattlePassN5MainTabQuest:_SetExpInfo(upgrade)
  local componentInfo = self:_GetLVRewardComponentInfo()
  local expInfoPool = self:GetUIComponent("UISelectObjectPath", "expInfoPool")
  self._expInfoPool = expInfoPool:SpawnObject("UIActivityBattlePassN5ExpInfo")
  self._expInfoPool:SetData(self._campaign, componentInfo, upgrade)
end

function UIActivityBattlePassN5MainTabQuest:_CheckLvMax()
  local component = self:_GetLVRewardComponent()
  return component:CheckIsLevelMax()
end

function UIActivityBattlePassN5MainTabQuest:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local component = self:_GetQuestComponent(1)
  if not component then
    Log.inof("UIActivityBattlePassN5MainTabQuest:_CheckQuestDailyReset() component == nil")
    return
  end
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

function UIActivityBattlePassN5MainTabQuest:_SetQuestGroup()
  self._groupBtnInfoList = {}
  for i = 1, 3 do
    local component = self:_GetQuestComponent(i)
    local info = self:_GetQuestComponentInfo(i)
    if component and info then
      table.insert(self._groupBtnInfoList, self:_GetQuestComponentId(i))
    end
  end
  self._QuestCount = table.count(self._groupBtnInfoList)
  local sop = self:GetUIComponent("UISelectObjectPath", "questGroup")
  sop:SpawnObjects("UIActivityBattlePassN5QuestGroupBtn", self._QuestCount)
  self._groupBtnList = sop:GetAllSpawnList()
  for i, v in ipairs(self._groupBtnList) do
    v:SetData(i, self._QuestCount, self._campaign, self._groupBtnInfoList[i], function(index)
      self:OnGroupBtnClick(index)
    end)
    v:SetSelected(i == self._index)
  end
end

function UIActivityBattlePassN5MainTabQuest:OnGroupBtnClick(index)
  self._index = index
  self:_Refresh(true, 0, false, true)
  for i, v in ipairs(self._groupBtnList) do
    v:SetSelected(index == i)
  end
end

function UIActivityBattlePassN5MainTabQuest:_FlushQuestItems(anim)
  local showTab = self._dynamicList:GetVisibleItemIDsInScrollView()
  for index = 0, showTab.Count - 1 do
    local id = math.floor(showTab[index])
    local item = self._dynamicList:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    for i = 1, self._itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      if anim then
        listItem:PlayAnimationInSequence(itemIndex)
      end
    end
  end
end

function UIActivityBattlePassN5MainTabQuest:_SetDynamicListData()
  local component = self._campaign:GetComponent(self._groupBtnInfoList[self._index])
  self._dynamicListInfo = component:GetQuestInfo()
  self._questStatus = component:GetCampaignQuestStatus(self._dynamicListInfo)
  component:SortQuestInfoByCampaignQuestStatus(self._dynamicListInfo)
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassN5MainTabQuest:_SetDynamicList(resetPos, anim_ListItem)
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
  self:_FlushQuestItems(anim_ListItem)
end

function UIActivityBattlePassN5MainTabQuest:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UIActivityBattlePassN5MainTabQuest:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassN5QuestListItem", self._itemCountPerRow)
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

function UIActivityBattlePassN5MainTabQuest:_SetListItemData(listItem, index)
  local componentInfo = self._campaign:GetComponentInfo(self._groupBtnInfoList[self._index])
  local quest = self._dynamicListInfo[index]
  local status = self._questStatus[quest]
  local questInfo = quest:QuestInfo()
  if questInfo.status == QuestStatus.QUEST_Completed then
    table.insert(self._canGetTb, questInfo)
  end
  listItem:GetGameObject():SetActive(true)
  if quest ~= nil then
    listItem:SetData(index, self._campaign, quest, status, componentInfo, function(questInfo)
      self:ListItemOnClick(questInfo)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
    end)
  end
end

function UIActivityBattlePassN5MainTabQuest:ListItemOnClick(questInfo)
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

function UIActivityBattlePassN5MainTabQuest:_GetListItemReward(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityBattlePassN5MainTabQuest:_GetListItemRewardReq")
  self:StartTask(self._GetListItemRewardReq, self, id)
end

function UIActivityBattlePassN5MainTabQuest:_GetListItemRewardReq(TT, id)
  local component = self._campaign:GetComponent(self._groupBtnInfoList[self._index])
  if component then
    local res = AsyncRequestRes:New()
    local ret, rewards = component:HandleQuestTake(TT, res, id)
    self:UnLock("UIActivityBattlePassN5MainTabQuest:_GetListItemRewardReq")
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
        self:_Refresh(true, 0, true)
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
  end
end

function UIActivityBattlePassN5MainTabQuest:_PlayAnimIn()
  self.anim = self:GetUIComponent("Animation", "animation")
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimIn()"
    self:Lock(lockName)
    self.anim:Play("UIeff_UIActivityBattlePassN5MainTabQuest_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end, self)
end

function UIActivityBattlePassN5MainTabQuest:_PlayAnimOut(callback)
  if callback then
    callback()
  end
end

function UIActivityBattlePassN5MainTabQuest:AllGetBtnOnClick()
  self:Lock("UIActivityBattlePassN5MainTabQuest:_GetListItemRewardReq")
  self:StartTask(self._CheckGetAllReward, self)
end

function UIActivityBattlePassN5MainTabQuest:_CheckGetAllReward(TT)
  local component = self._campaign:GetComponent(self._groupBtnInfoList[self._index])
  if component then
    local res = AsyncRequestRes:New()
    local ret, rewards = component:HandleOneKeyTakeQuest(TT, res)
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      if self:_CheckLvMax() then
        ToastManager.ShowToast(StringTable.Get("str_activity_battlepass_buy_deluxe_notify_maxlv"))
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
      else
        local tmpRewards = {}
        local tmpTb = {}
        for i, reward in pairs(rewards) do
          local id = reward.assetid
          if tmpTb[id] then
            tmpTb[id] = tmpTb[id] + reward.count
          else
            tmpTb[id] = reward.count
          end
        end
        for i, v in pairs(tmpTb) do
          local roleAsset = RoleAsset:New()
          roleAsset.assetid = i
          roleAsset.count = v
          table.insert(tmpRewards, roleAsset)
        end
        UIActivityHelper.ShowUIGetRewards(tmpRewards)
      end
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh(true, 0, true)
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
    table.clear(self._canGetTb)
    self:UnLock("UIActivityBattlePassN5MainTabQuest:_GetListItemRewardReq")
  end
end
