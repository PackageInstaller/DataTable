_class("UIBattlePassCN1QuestMain", UICustomWidget)
UIBattlePassCN1QuestMain = UIBattlePassCN1QuestMain

function UIBattlePassCN1QuestMain:_SetCurComponent(index)
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_Quest(self._campaign, index)
end

function UIBattlePassCN1QuestMain:OnShow(uiParams)
  self._index = 1
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIBattlePassCN1QuestMain:OnHide()
end

function UIBattlePassCN1QuestMain:SetData(campaign, tipsCallback)
  self._campaign = campaign
  self._tipsCallback = tipsCallback
  self:_SetCurComponent(self._index)
end

function UIBattlePassCN1QuestMain:Refresh_ByParams(params)
  if not self.view then
    return
  end
  params = params or {}
  if params.expData == true then
    self:_SetExpInfo(params.expUpgrade)
  end
  self:_SetTabBtns()
  self:_SetDynamicList()
  if params.resetPos then
    self._dynamicListHelper:MovePanelToItemIndex(0, 0)
  end
  if params.anim_ListItem then
    self:_DynamicListPlayAnimation()
  end
  if params.anim_PlayIn then
    self:_PlayAnimIn()
  end
end

function UIBattlePassCN1QuestMain:_ReLoadData(TT, res, callback)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  callback()
end

function UIBattlePassCN1QuestMain:_CheckQuestDailyReset(callback)
  local dailyIndex = 1
  if self._index == dailyIndex and self._component:Check_CamQuestDailyReset() then
    self._component:Start_HandleCamQuestDailyReset(function(TT, res)
      if res:GetSucc() then
        self:_ReLoadData(TT, res, callback)
      else
        callback()
      end
    end)
    return
  end
  callback()
end

function UIBattlePassCN1QuestMain:_SetExpInfo(upgrade)
  self._expInfoPool = UIWidgetHelper.SpawnObject(self, "expInfoPool", "UIBattlePassCN1ExpInfo")
  self._expInfoPool:SetData(2, self._campaign, upgrade, function()
    self:Refresh_ByParams({
      resetPos = false,
      expData = true,
      expUpgrade = true,
      anim_PlayIn = false,
      anim_ListItem = false
    })
  end)
end

function UIBattlePassCN1QuestMain:_SetTabBtns()
  self._tabBtnIds = {}
  for i = 1, 3 do
    local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_Quest(self._campaign, i)
    if component and componentInfo then
      table.insert(self._tabBtnIds, i)
    end
  end
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIBattlePassCN1QuestTabBtn", #self._tabBtnIds)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(self._tabBtnIds[i], self._campaign, function(index)
      self:_SetTabSelect(index)
    end)
    v:Refresh(self._index == self._tabBtnIds[i])
  end
end

function UIBattlePassCN1QuestMain:_SetTabSelect(index)
  self._index = index
  self:_SetCurComponent(self._index)
  self:_CheckQuestDailyReset(function()
    self:Refresh_ByParams({
      resetPos = true,
      expData = false,
      expUpgrade = false,
      anim_PlayIn = false,
      anim_ListItem = true
    })
  end)
end

function UIBattlePassCN1QuestMain:_SetDynamicListData()
  self._dynamicListInfo = self._component:GetQuestInfo()
  self._questStatus = self._component:GetCampaignQuestStatus(self._dynamicListInfo)
  self:_SetFilterDynamicList()
  self._component:SortQuestInfoByCampaignQuestStatus(self._dynamicListInfo)
  self:SortQuestInfoByCampaignQuestStatus()
end

function UIBattlePassCN1QuestMain:_SetFilterDynamicList()
  local dynamicListInfo = {}
  for _, dynamicInfo in pairs(self._dynamicListInfo) do
    local cfgInfo = Cfg.cfg_quest[dynamicInfo._questInfo.quest_id]
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local status = self._component:CheckCampaignQuestStatus(dynamicInfo._questInfo)
    local timeInfo = self._componentInfo.m_quest_time_param_map[dynamicInfo._questInfo.quest_id]
    if cfgInfo.DateType and cfgInfo.DateType > 0 and cfgInfo.IsNotShowBeforStartTime and status == CampaignQuestStatus.CQS_NotStart then
    elseif cfgInfo.DateType and cfgInfo.DateType > 0 and status == CampaignQuestStatus.CQS_Over then
    elseif timeInfo.m_end_time ~= 0 and curTime > timeInfo.m_end_time then
    else
      table.insert(dynamicListInfo, dynamicInfo)
    end
  end
  self._dynamicListInfo = dynamicListInfo
end

function UIBattlePassCN1QuestMain:SortQuestInfoByCampaignQuestStatus()
  local defaultIndex = {}
  for k, v in ipairs(self._dynamicListInfo) do
    defaultIndex[v] = k
  end
  local val = {}
  val[CampaignQuestStatus.CQS_Completed] = 0
  val[CampaignQuestStatus.CQS_Accepted] = 1
  val[CampaignQuestStatus.CQS_Taken] = 2
  val[CampaignQuestStatus.CQS_NotStart] = 3
  val[CampaignQuestStatus.CQS_Over] = 4
  table.sort(self._dynamicListInfo, function(a, b)
    local statusA = self._component:CheckCampaignQuestStatus(a._questInfo)
    local statusB = self._component:CheckCampaignQuestStatus(b._questInfo)
    if val[statusA] ~= val[statusB] then
      return val[statusA] < val[statusB]
    end
    local daily_resetA = self._componentInfo.m_quest_time_param_map[a._questInfo.quest_id].m_need_daily_reset and 1 or 0
    local daily_resetB = self._componentInfo.m_quest_time_param_map[b._questInfo.quest_id].m_need_daily_reset and 1 or 0
    if daily_resetA ~= daily_resetB then
      return daily_resetA > daily_resetB
    end
    local dateTypeA = Cfg.cfg_quest[a._questInfo.quest_id].DateType or 0
    local dateTypeB = Cfg.cfg_quest[b._questInfo.quest_id].DateType or 0
    if dateTypeA ~= dateTypeB then
      return dateTypeA > dateTypeB
    end
    return defaultIndex[a] < defaultIndex[b]
  end)
end

function UIBattlePassCN1QuestMain:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIBattlePassCN1QuestCell", function(listItem, itemIndex)
      self:_SetCellData(listItem, itemIndex)
    end)
  end
  local itemCount = #self._dynamicListInfo
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIBattlePassCN1QuestMain:_SetCellData(listItem, index, rightItem)
  local quest = self._dynamicListInfo[index]
  local status = self._questStatus[quest]
  local questInfo = quest:QuestInfo()
  if quest ~= nil then
    listItem:SetData(index, self._campaign, quest, status, self._componentInfo, function(questInfo)
      self._component:Start_HandleOneKeyTakeQuest(function(res, rewards)
        self:_OnGetRewards(res, rewards)
      end)
    end, self._tipsCallback)
  end
end

function UIBattlePassCN1QuestMain:_DynamicListPlayAnimation()
  local tb = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(tb) do
    v.item:PlayAnimationInSequence(v.index)
  end
end

function UIBattlePassCN1QuestMain:_OnGetRewards(res, rewards)
  if res:GetSucc() then
    local lvMax = UIActivityBattlePassHelper.CheckIsLevelMax(self._campaign)
    if lvMax then
      ToastManager.ShowToast(StringTable.Get("str_activity_battlepass_buy_deluxe_notify_maxlv"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
    else
      UIActivityHelper.ShowUIGetRewards(rewards)
    end
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:Refresh_ByParams({
        resetPos = true,
        expData = false,
        expUpgrade = false,
        anim_PlayIn = true,
        anim_ListItem = true
      })
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end

function UIBattlePassCN1QuestMain:_PlayAnimIn()
  for i, v in ipairs(self._tabBtns) do
    v:PlayAnimationInSequence(i)
  end
end

function UIBattlePassCN1QuestMain:_OnQuestUpdate(quests)
  if not self.view or not self._component then
    return
  end
  quests = quests or {}
  local isContain = self._component:IsContainQuest(quests)
  if not isContain then
    return
  end
  self:Refresh_ByParams({
    resetPos = false,
    expData = false,
    expUpgrade = false,
    anim_PlayIn = false,
    anim_ListItem = false
  })
end
