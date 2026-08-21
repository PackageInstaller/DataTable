_class("UIActivityBattlePassN5QuestListItem", UICustomWidget)
UIActivityBattlePassN5QuestListItem = UIActivityBattlePassN5QuestListItem

function UIActivityBattlePassN5QuestListItem:_GetComponents()
  self._anim = self:GetUIComponent("Animation", "animation")
  self._root = self:GetGameObject("root")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._desTex = self:GetUIComponent("UILocalizationText", "desTex")
  self._progressValueTex = self:GetUIComponent("UILocalizationText", "progressValueTex")
  self._progressSilder = self:GetUIComponent("Slider", "progress")
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
  self._line1 = self:GetGameObject("line1")
  self._taskTipParent = self:GetGameObject("taskTipParent")
  self._taskTipColor = self:GetUIComponent("Image", "taskTipParent")
  self._taskTip = self:GetUIComponent("UILocalizationText", "taskTip")
  self._obj1 = self:GetGameObject("obj1")
  self._bg = self:GetUIComponent("Image", "bg")
  self._mask = self:GetGameObject("mask")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "element")
  self._line1_extra = self:GetGameObject("line1_extra")
  self._taskTipParent_extra = self:GetGameObject("taskTipParent_extra")
  self._taskTipColor_extra = self:GetUIComponent("Image", "taskTipParent_extra")
  self._taskTip_extra = self:GetUIComponent("UILocalizationText", "taskTip_extra")
end

function UIActivityBattlePassN5QuestListItem:OnShow(uiParams)
  self:_GetComponents()
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] erro --> module is nil !")
    return
  end
  self._atlas = self:GetAsset("UIBattlePassN5.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityBattlePassN5QuestListItem:SetData(index, campaign, quest, status, info, callback, itemCallback)
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
  local layouts = self._line1:GetComponentsInChildren(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup), true)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._line1:GetComponent("RectTransform"))
end

function UIActivityBattlePassN5QuestListItem:OnHide(stamp)
  self._root = nil
end

function UIActivityBattlePassN5QuestListItem:_Refresh()
  self:_SetTitle()
  self:_SetProgress()
  self:_SetState(self._state)
  self:_SetRemainingTime()
  self:_SetDynamicList()
end

function UIActivityBattlePassN5QuestListItem:PlayAnimationInSequence(index)
  if not self._anim then
    return
  end
  local stamp = index * 30
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimationInSequence(" .. index .. ")"
    self:Lock(lockName)
    self:_ResetAnimation()
    self._root:SetActive(false)
    YIELD(TT, stamp)
    if self._root then
      self._root:SetActive(true)
      self._anim:Play("UIeff_UIActivityBattlePassN5QuestListItem_in")
      YIELD(TT, 500)
    end
    self:UnLock(lockName)
  end, self)
end

function UIActivityBattlePassN5QuestListItem:_ResetAnimation()
  if not self._anim then
    return
  end
  local state = self._anim:get_Item("UIeff_UIActivityBattlePassN5QuestListItem_in")
  state.normalizedTime = 0
  self._anim:Stop()
end

function UIActivityBattlePassN5QuestListItem:_SetTitle()
  self._desTex:SetText(StringTable.Get(self._quest.CondDesc))
  local questId = self._quest.quest_id
  local timeInfo = self._info.m_quest_time_param_map[questId]
  if self._state == CampaignQuestStatus.CQS_NotStart then
    self._taskTip_extra:SetText(StringTable.Get("str_activity_battlepass_n5_task_start_time"))
    self._taskTipColor_extra.color = Color(0.7450980392156863, 0.7450980392156863, 0.7450980392156863)
    self._taskTipParent_extra:SetActive(true)
    self._line1:SetActive(false)
    self._line1_extra:SetActive(true)
  elseif timeInfo.m_need_daily_reset then
    if self._state == CampaignQuestStatus.CQS_Taken then
      self._taskTip_extra:SetText(StringTable.Get("str_activity_battlepass_n5_task_refresh_time"))
      self._taskTipColor_extra.color = Color(1, 0.8627450980392157, 0.21568627450980393)
      self._taskTipParent_extra:SetActive(true)
      self._line1:SetActive(false)
      self._line1_extra:SetActive(true)
    else
      self._taskTip:SetText(StringTable.Get("str_activity_battlepass_n5_daily_task"))
      self._taskTipColor.color = Color(1, 0.8, 0.1843137254901961)
      self._line1:SetActive(true)
      self._line1_extra:SetActive(false)
    end
    self._taskTipParent:SetActive(true)
    self._obj1:SetActive(false)
  else
    self._taskTipParent:SetActive(false)
    self._obj1:SetActive(true)
    self._line1:SetActive(true)
    self._line1_extra:SetActive(false)
  end
end

function UIActivityBattlePassN5QuestListItem:_SetProgress()
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = string.format("%s<color=#ff0000>/</color><size=30>%s</size>", self._quest.cur_progress, self._quest.total_progress)
  end
  self._progressValueTex:SetText(progress)
  local rate = self._quest.cur_progress / self._quest.total_progress
  self._progressSilder.value = rate
end

function UIActivityBattlePassN5QuestListItem:_SetRemainingTime()
  local questId = self._quest.quest_id
  local timeInfo = self._info.m_quest_time_param_map[questId]
  local remainingTimeObj
  if self._state == CampaignQuestStatus.CQS_NotStart then
    remainingTimeObj = self:GetGameObject("RemainingTimePool_extra")
  elseif timeInfo.m_need_daily_reset then
    if self._state == CampaignQuestStatus.CQS_Taken then
      remainingTimeObj = self:GetGameObject("RemainingTimePool_extra")
    else
      remainingTimeObj = self:GetGameObject("remainingTimePool")
    end
  else
    remainingTimeObj = self:GetGameObject("remainingTimePool")
  end
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
  local iconSprite = self._atlas:GetSprite("pass_task_icon_time")
  local remainingTimePool = self:GetUIComponentDynamic("UISelectObjectPath", remainingTimeObj)
  self._remainingTime = remainingTimePool:SpawnObject("UIActivityCommonRemainingTime")
  self._remainingTime:SetCustomTimeStr({
    day = "str_activity_battlepass_day",
    hour = "str_activity_battlepass_hour",
    min = "str_activity_battlepass_minute",
    zero = "str_activity_battlepass_less_minute",
    over = "str_activity_battlepass_less_minute"
  })
  self._remainingTime:SetExtraSprite("icon", iconSprite)
  self._remainingTime:SetData(endTime, nil, nil)
end

function UIActivityBattlePassN5QuestListItem:_SetState(state)
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
  local bg = {
    "pass_task_list_bg1",
    "pass_task_list_bg",
    "pass_task_list_bg",
    "pass_task_list_bg1",
    "pass_task_list_bg1"
  }
  self._bg.sprite = self._atlas:GetSprite(bg[state])
  self._mask:SetActive(self._state == CampaignQuestStatus.CQS_NotStart or self._state == CampaignQuestStatus.CQS_Taken or self._state == CampaignQuestStatus.CQS_Over)
  local alpha = {
    0.5,
    1,
    1,
    0.5,
    0.5
  }
  self._canvasGroup.alpha = alpha[self._state]
end

function UIActivityBattlePassN5QuestListItem:_SetDynamicListData()
  self._dynamicListInfo = self._quest.rewards
  self._itemCountPerRow = 1
  self._dynamicListSize = math.floor((table.count(self._dynamicListInfo) - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassN5QuestListItem:_SetDynamicList()
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

function UIActivityBattlePassN5QuestListItem:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityBattlePassN5QuestListItem:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassN5ItemIconQuest", self._itemCountPerRow)
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

function UIActivityBattlePassN5QuestListItem:_SetListItemData(listItem, index)
  local info = self._dynamicListInfo[index]
  listItem:SetData(index, info, self._itemCallback)
end

function UIActivityBattlePassN5QuestListItem:state_AcceptedOnClick()
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

function UIActivityBattlePassN5QuestListItem:state_CompletedOnClick()
  if self._callback then
    self._callback(self._quest)
  end
end
