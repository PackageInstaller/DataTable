_class("UIActivityBattlePassQuestListItem", UICustomWidget)
UIActivityBattlePassQuestListItem = UIActivityBattlePassQuestListItem

function UIActivityBattlePassQuestListItem:_GetComponents()
  self._anim = self:GetUIComponent("Animation", "ani")
  self._root = self:GetGameObject("root")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._desTex = self:GetUIComponent("UILocalizationText", "desTex")
  self._progressValueImg = self:GetUIComponent("Image", "progressValueImg")
  self._progressValueTex = self:GetUIComponent("UILocalizationText", "progressValueTex")
  self._stateObj = {
    self:GetGameObject("state_NotStart"),
    self:GetGameObject("state_Accepted"),
    self:GetGameObject("state_Completed"),
    self:GetGameObject("state_Taken"),
    self:GetGameObject("state_Over")
  }
  self._stateTxt = {
    self:GetUIComponent("UILocalizationText", "state_NotStartTxt"),
    self:GetUIComponent("UILocalizationText", "state_AcceptedTxt"),
    self:GetUIComponent("UILocalizationText", "state_CompletedTxt"),
    self:GetUIComponent("UILocalizationText", "state_TakenTxt"),
    self:GetUIComponent("UILocalizationText", "state_OverTxt")
  }
end

function UIActivityBattlePassQuestListItem:OnShow(uiParams)
  self:_GetComponents()
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] erro --> module is nil !")
    return
  end
  self._atlas = self:GetAsset("UIBattlePass.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityBattlePassQuestListItem:SetData(index, campaign, quest, status, info, callback, itemCallback)
  self._index = index
  self._campaign = campaign
  self._quest = quest:QuestInfo()
  self._state = status or CampaignQuestStatus.CQS_Over
  self._info = info
  self._callback = callback
  self._itemCallback = itemCallback
  self:_Refresh()
  local trans = self:GetUIComponent("RectTransform", "root")
  trans.anchoredPosition = Vector2(0, trans.anchoredPosition.y)
end

function UIActivityBattlePassQuestListItem:OnHide(stamp)
  self._root = nil
end

function UIActivityBattlePassQuestListItem:_Refresh()
  self:_SetTitle()
  self:_SetProgress()
  self:_SetState(self._state)
  self:_SetRemainingTime()
  self:_SetDynamicList()
end

function UIActivityBattlePassQuestListItem:PlayAnimationInSequence(index)
  local stamp = index * 30
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimationInSequence(" .. index .. ")"
    self:Lock(lockName)
    self:_ResetAnimation()
    self._root:SetActive(false)
    YIELD(TT, stamp)
    if self._root then
      self._root:SetActive(true)
      if self._anim then
        self._anim:Play("uieff_UIActivityBattlePassQuestListItem_In")
        YIELD(TT, 500)
      end
    end
    self:UnLock(lockName)
  end, self)
end

function UIActivityBattlePassQuestListItem:_ResetAnimation()
  if self._anim then
    local state = self._anim:get_Item("uieff_UIActivityBattlePassQuestListItem_In")
    state.normalizedTime = 0
    self._anim:Stop()
  end
end

function UIActivityBattlePassQuestListItem:_SetTitle()
  self._desTex:SetText(StringTable.Get(self._quest.CondDesc))
end

function UIActivityBattlePassQuestListItem:_SetProgress()
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  end
  self._progressValueTex:SetText(progress)
  local rate = self._quest.cur_progress / self._quest.total_progress
  self._progressValueImg.fillAmount = rate
end

function UIActivityBattlePassQuestListItem:_SetRemainingTime()
  local remainingTimeObj = self:GetGameObject("remainingTimePool")
  local questId = self._quest.quest_id
  local timeInfo = self._info.m_quest_time_param_map[questId]
  local state2time = {
    [CampaignQuestStatus.CQS_NotStart] = timeInfo.m_open_time,
    [CampaignQuestStatus.CQS_Accepted] = timeInfo.m_end_time,
    [CampaignQuestStatus.CQS_Completed] = timeInfo.m_end_time
  }
  if timeInfo.m_need_daily_reset then
    state2time[CampaignQuestStatus.CQS_Taken] = timeInfo.m_end_time
  end
  local endTime = state2time[self._state]
  if endTime and endTime ~= 0 then
    remainingTimeObj:SetActive(true)
  else
    remainingTimeObj:SetActive(false)
    return
  end
  local state2icon = {
    [CampaignQuestStatus.CQS_NotStart] = "pass_renwu_icon1",
    [CampaignQuestStatus.CQS_Accepted] = "pass_renwu_icon2",
    [CampaignQuestStatus.CQS_Completed] = "pass_renwu_icon2",
    [CampaignQuestStatus.CQS_Taken] = "pass_renwu_icon1"
  }
  local iconId = state2icon[self._state]
  local iconSprite = self._atlas:GetSprite(iconId)
  local state2color = {
    [CampaignQuestStatus.CQS_NotStart] = "47D3E6",
    [CampaignQuestStatus.CQS_Accepted] = "FFFFFF",
    [CampaignQuestStatus.CQS_Completed] = "FFFFFF",
    [CampaignQuestStatus.CQS_Taken] = "47D3E6"
  }
  local color = state2color[self._state]
  local remainingTimePool = self:GetUIComponent("UISelectObjectPath", "remainingTimePool")
  self._remainingTime = remainingTimePool:SpawnObject("UIActivityCommonRemainingTime")
  self._remainingTime:SetCustomTimeStr({
    day = "str_activity_battlepass_day",
    hour = "str_activity_battlepass_hour",
    min = "str_activity_battlepass_minute",
    zero = "str_activity_battlepass_less_minute",
    over = "str_activity_battlepass_less_minute"
  })
  self._remainingTime:SetExtraSprite("icon", iconSprite)
  self._remainingTime:SetTimeColor(color)
  self._remainingTime:SetData(endTime, nil, nil)
end

function UIActivityBattlePassQuestListItem:_SetState(state)
  for i, v in ipairs(self._stateObj) do
    v:SetActive(i == state)
  end
  local state2id = {
    "str_activity_battlepass_tab_quest_notstart",
    "str_activity_battlepass_tab_quest_accepted",
    "str_activity_battlepass_tab_quest_completed",
    "str_activity_battlepass_tab_guest_taken",
    "str_activity_battlepass_tab_quest_over"
  }
  self._stateTxt[state]:SetText(StringTable.Get(state2id[state]))
end

function UIActivityBattlePassQuestListItem:_SetDynamicListData()
  self._dynamicListInfo = self._quest.rewards
  self._itemCountPerRow = 1
  self._dynamicListSize = math.floor((table.count(self._dynamicListInfo) - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassQuestListItem:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListSize, self._dynamicList)
  end
end

function UIActivityBattlePassQuestListItem:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityBattlePassQuestListItem:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassItemIconReward", self._itemCountPerRow)
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

function UIActivityBattlePassQuestListItem:_SetListItemData(listItem, index)
  local info = self._dynamicListInfo[index]
  listItem:SetData(index, info, self._itemCallback)
end

function UIActivityBattlePassQuestListItem:state_AcceptedOnClick()
  self._module = GameGlobal.GetModule(QuestModule)
  local jumpModule = self._module.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Daily)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._quest.JumpID
  local jumpParams = self._quest.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UIActivityBattlePassQuestListItem:state_CompletedOnClick()
  if self._callback then
    self._callback(self._quest)
  end
end
