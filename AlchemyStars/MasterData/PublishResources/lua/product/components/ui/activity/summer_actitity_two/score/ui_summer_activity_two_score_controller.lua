_class("UISummerActivityTwoScoreController", UIController)
UISummerActivityTwoScoreController = UISummerActivityTwoScoreController

function UISummerActivityTwoScoreController:LoadDataOnEnter(TT, res, uiParams)
  self._yieldGapTime = 70
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_STORY, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._personProgress1CompInfo = self._localProcess:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  self._personProgress1Component = self._localProcess:GetComponent(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1)
  self._scoreDatas = UISummerActivityTwoScoreData:New(self._personProgress1CompInfo)
  self._missionComInfo = self._localProcess:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  self._current_value = self._personProgress1CompInfo.m_current_progress
  self._item_id = self._personProgress1CompInfo.m_item_id
  local levelDatas = campaignModule:GetSummerTwoLevelData(TT)
  self._levelDatas = levelDatas:GetEntryLevelData()
  self._rewardItemCount = 0
  self._rewardDatas = {}
end

function UISummerActivityTwoScoreController:SortRewardDatas()
  table.sort(self._rewardDatas, function(a, b)
    return a:GetPriority() < b:GetPriority()
  end)
end

function UISummerActivityTwoScoreController:RefreshScoreData()
  self._rewardDatas = self._scoreDatas:GetRewardDatas()
  if not self._rewardDatas then
    self._rewardDatas = {}
  end
  self._rewardItemCount = #self._rewardDatas
  self:SortRewardDatas()
end

function UISummerActivityTwoScoreController:OnShow(uiParams)
  self._inited = false
  self._scoreIcon = self:GetUIComponent("RawImageLoader", "scoreIcon")
  self._currentValueTex = self:GetUIComponent("UILocalizationText", "currentValue")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, true)
  self._currentValueTex:SetText(self._current_value)
  local cfg_item = Cfg.cfg_item[self._item_id]
  self._itemIcon = ""
  if cfg_item then
    self._itemIcon = cfg_item.Icon
  else
    Log.error("###[UISummerActivityTwoScoreController] cfg_item is nil ! id --> ", self._item_id)
  end
  self._scoreIcon:LoadImage(cfg_item.Icon)
  self:InitTypeMissionInfo()
  self:InitRewardList()
end

function UISummerActivityTwoScoreController:CloseCoro(TT)
  self:CloseDialog()
end

function UISummerActivityTwoScoreController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISummerActivityTwoScoreController:InitTypeMissionInfo()
  local loader = self:GetUIComponent("UISelectObjectPath", "ScoreInfo")
  loader:SpawnObjects("UISummerActivityTwoTypeMissionInfoItem", 6)
  local list = loader:GetAllSpawnList()
  for i = 1, #list do
    list[i]:Refresh(i, self._levelDatas[i], self._itemIcon)
  end
end

function UISummerActivityTwoScoreController:InitRewardList()
  self:RefreshScoreData()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "RewardList")
  self._scrollView:InitListView(self._rewardItemCount, function(scrollview, index)
    return self:OnGetRewardItem(scrollview, index)
  end)
  self._inited = true
end

function UISummerActivityTwoScoreController:OnGetRewardItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISummerActivityTwoScoreItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._rewardItemCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:RefreshRewardItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UISummerActivityTwoScoreController:RefreshRewardItemInfo(itemWidget, index)
  local anim = not self._inited
  local yieldTime = (index - 1) * self._yieldGapTime
  itemWidget:Refresh(index, self._rewardDatas[index], self._itemIcon, function(idx)
    self:CanGet(idx)
  end, function(itemId, pos)
    self:ShowTips(itemId, pos)
  end, anim, yieldTime)
end

function UISummerActivityTwoScoreController:CanGet(idx)
  Log.debug("###[UISummerActivityTwoScoreController] CanGet idx --> ", idx)
  GameGlobal.TaskManager():StartTask(self.GetReward, self, idx)
end

function UISummerActivityTwoScoreController:GetReward(TT, idx)
  self:Lock("UISummerActivityTwoScoreItem_GetRewarda")
  local res = AsyncRequestRes:New()
  self._personProgress1Component:HandleReceiveReward(TT, res, self._rewardDatas[idx]:GetScoreValue())
  if res:GetSucc() then
    local rewards = self._rewardDatas[idx]:GetRewards()
    self._rewardDatas[idx]:SetStatus(UISummerActivityTwoScoreRewardStatus.HasGet)
    self:SortRewardDatas()
    self._scrollView:RefreshAllShownItem()
    self:ShowRewards(rewards, idx)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SummerTwoRewardRefresh, idx)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result)
  end
  self:UnLock("UISummerActivityTwoScoreItem_GetRewarda")
end

function UISummerActivityTwoScoreController:ShowRewards(rewards, idx)
  local petIdList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if petModule:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    self:ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards)
    end)
    return
  end
  self:ShowDialog("UIGetItemController", rewards)
end
