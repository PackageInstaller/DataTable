_class("UISakuraController", UIController)
UISakuraController = UISakuraController

function UISakuraController:Constructor()
  self._storyData = {}
  self._cellList = {}
  self._cellBgList = {}
  self._cellCountPerRow = 1
  self._cellCountPerColumn = 1
  self._cellCount = 0
  self._currentIndex = 0
  self._playCloseAnimation = false
  self._animations = {
    bg_show = "uieff_UISakuraController_b_in",
    bg_hide = "uieff_UISakuraController_b_out",
    show = "uieff_UISakuraController_u_in",
    hide = "uieff_UISakuraController_u_out",
    refresh = "uieff_UISakuraController_u_t"
  }
end

function UISakuraController:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_HIIRO, ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_STORY)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._story_component = self._campaign:GetLocalProcess()._storyComponent
  self._story_componentinfo = self._campaign:GetLocalProcess()._storyComponentInfo
end

function UISakuraController:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UISakuraController:_GetComponents()
  self._uiBgCanvasGroup = self:GetUIComponent("CanvasGroup", "BGCanvas")
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, true)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._sakuraPoint = self:GetUIComponent("UILocalizationText", "SakuraPoint")
  self._activityTitle = self:GetUIComponent("UILocalizationText", "ActivityTitle")
  self._activityDescription = self:GetUIComponent("UILocalizationText", "ActivityDescription")
  self._unLockReward = self:GetUIComponent("UILocalizationText", "UnLockReward")
  self._rewardsContent = self:GetUIComponent("UISelectObjectPath", "RewardsContent")
  self._openStoryBtn = self:GetGameObject("OpenStoryBtn")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._rewardGot = self:GetGameObject("RewardGot")
  self._redPoint = self:GetGameObject("RedPoint")
  self._redPointSpine = self:GetUIComponent("SpineLoader", "RedPoint")
  self._promptBg = self:GetGameObject("PromptBg")
  self._sakuraCost = self:GetGameObject("SakuraCost")
  self._richCost = self:GetUIComponent("UIRichText", "RichCost")
  self._openStoryBtnText = self:GetUIComponent("UILocalizationText", "StoryText")
  self._openStoryBtnTextUs = self:GetUIComponent("UILocalizationText", "StoryTextUs")
  self._mark = self:GetGameObject("Mark")
  self._bgAnimation = self:GetUIComponent("Animation", "BGAnimation")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UISakuraController:_OnValue()
  self._sakuraPoint:SetText(self._story_component:GetCampaignCount())
  self._bgAnimation:Play(self._animations.bg_show)
  self._animation:Play(self._animations.show)
  self:_InitStoryData()
  self:_InitScrollView()
  self:Lock("UISakuraController:OnShow")
  self:StartTask(function(TT)
    YIELD(TT, 1133)
    self:UnLock("UISakuraController:OnShow")
  end)
end

function UISakuraController:_SetCellCountPerColumn()
  self._cellCountPerColumn = math.ceil(table.count(self._storyData) / self._cellCountPerRow)
end

function UISakuraController:_InitScrollView()
  self:_SetCellCountPerColumn()
  self._scrollView:InitListView(self._cellCountPerColumn, function(scrollView, index)
    return self:_InitListView(scrollView, index)
  end)
  self:_ShowDefault()
end

function UISakuraController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local rowItem = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", rowItem.gameObject)
  if rowItem.IsInitHandlerCalled == false then
    rowItem.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISakuraItem", self._cellCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._cellCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self._cellCountPerRow + i
    self._cellList[itemIndex] = item
    self._cellBgList[itemIndex] = item:GetUIComponent("RawImage", "BackGround")
    self:_SetItemInfo(item, itemIndex)
  end
  return rowItem
end

function UISakuraController:_SetItemInfo(item, index)
  local itemdata = self:_GetItemDataByIndex(index)
  if itemdata == nil then
    return
  end
  item:SetData(itemdata, index, self:_GetStoryState(itemdata, index), function(index)
    self:_OnClickItem(index)
  end)
end

function UISakuraController:_ShowDefault()
  local index = self:_GetUnLockPlayableIndex()
  self._scrollView:MovePanelToItemIndex(index - 1, 0)
  self:_OnClickItem(index)
end

function UISakuraController:_OnClickItem(index)
  if self._currentIndex == index then
    return
  end
  self:_RefreshMark(self._currentIndex, index)
  self._currentIndex = index
  self:_RefreshUIInfo(self._currentIndex)
  self._animation:Play(self._animations.refresh)
end

function UISakuraController:_RefreshMark(pre_index, cur_index)
  if 0 < pre_index then
    local pre_cellbg = self._cellBgList[pre_index]
    pre_cellbg.enabled = true
  end
  local cur_cellbg = self._cellBgList[cur_index]
  cur_cellbg.enabled = false
  local gameObject = self._cellList[cur_index]._backGround.gameObject
  self._mark.transform.position = gameObject.transform.position
end

function UISakuraController:_RefreshUIInfo(index)
  local itemdata = self:_GetItemDataByIndex(index)
  if itemdata ~= nil then
    local config = Cfg.cfg_campaign_story[itemdata.storyid]
    if config == nil then
      Log.fatal("cfg_campaign_story config is nil.", itemdata.storyid)
      return
    end
    self._activityTitle:SetText(StringTable.Get(config.Title))
    self._activityDescription:SetText(StringTable.Get(config.Des))
    self:_RefreshRewards()
    self:_RefreshState(itemdata, self:_GetStoryState(itemdata, index))
  end
end

function UISakuraController:_RefreshState(storydata, state)
  self._rewardGot:SetActive(state == SakuraStoryState.Played)
  self._promptBg:SetActive(state == SakuraStoryState.UnLockCantPlay)
  self._sakuraCost:SetActive(state == SakuraStoryState.Lock)
  if state == SakuraStoryState.Lock then
    local costStr = storydata.unlockcount .. "<sprite=legend_zhangjie_icon4 size=100 />"
    local fontSize = 36
    local str = StringTable.Get("str_sakura_to_unlock_story", fontSize, costStr)
    if self._richCost then
      self._richCost:SetText(str)
    end
  end
  self._openStoryBtn:SetActive(state == SakuraStoryState.UnLockCanPlay or state == SakuraStoryState.Played)
  if state == SakuraStoryState.UnLockCanPlay then
    self._openStoryBtnText:SetText(StringTable.Get("str_sakura_openstory"))
    self._openStoryBtnTextUs:SetText(StringTable.Get("str_sakura_openstoryus"))
  elseif state == SakuraStoryState.Played then
    self._openStoryBtnText:SetText(StringTable.Get("str_sakura_reopenstory"))
    self._openStoryBtnTextUs:SetText(StringTable.Get("str_sakura_reopenstoryus"))
  end
  self._redPoint:SetActive(state == SakuraStoryState.UnLockCanPlay)
  if state == SakuraStoryState.UnLockCanPlay and self._redPointSpine then
    self._redPointSpine:SetAnimation(0, "appear", false)
    GameGlobal.Timer():AddEvent(433, function()
      self._redPointSpine:SetAnimation(0, "idle", true)
    end)
  end
end

function UISakuraController:_RefreshUIInfoWhenPlayOver()
  local itemdata = self:_GetItemDataByIndex(self._currentIndex)
  if itemdata ~= nil then
    local state = self:_GetStoryState(itemdata, self._currentIndex)
    self._cellList[self._currentIndex]:RefreshItemInfo(state)
    self:_RefreshState(itemdata, state)
    local nextindex = self._currentIndex + 1
    if nextindex <= table.count(self._storyData) then
      local nextitemdata = self:_GetItemDataByIndex(nextindex)
      if nextitemdata ~= nil then
        self._cellList[nextindex]:RefreshItemInfo(self:_GetStoryState(nextitemdata, nextindex))
      end
    end
  end
end

function UISakuraController:_RefreshRewards()
  local rewards = self:_GetStoryRewards()
  local count = table.count(rewards)
  if 0 < count then
    self._rewardsContent:SpawnObjects("UISakuraRewardItem", count)
    local items = self._rewardsContent:GetAllSpawnList()
    for i = 1, #items do
      items[i]:SetData(rewards[i], function(id, pos)
        self:_ShowRewardTips(id, pos)
      end)
    end
  end
end

function UISakuraController:_ShowRewardTips(id, pos)
  self._tips:SetData(id, pos)
end

function UISakuraController:_GetItemDataByIndex(index)
  if index <= table.count(self._storyData) then
    return self._storyData[index]
  end
  return nil
end

function UISakuraController:OpenStoryBtnOnClick(go)
  local itemdata = self:_GetItemDataByIndex(self._currentIndex)
  if itemdata then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SakuraCommonClick)
    GameGlobal.GetModule(StoryModule):StartStory(itemdata.storyid, function()
      self:_StoryPlayEnd(itemdata.storyid)
    end, true)
  end
end

function UISakuraController:_StoryPlayEnd(storyid)
  if self:_CheckStoryPlayed(storyid) then
    return
  end
  self:StartTask(function(TT)
    local request = AsyncRequestRes:New()
    local rewards = self._story_component:HandleStoryTake(TT, request, storyid)
    if request:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards)
      self:_RefreshUIInfoWhenPlayOver()
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(request.m_result, self._campaign._id, self:_Close())
    end
  end, self)
end

function UISakuraController:_InitStoryData()
  local cfgid = self._story_component:GetComponetCfgId(self._campaign._id, self._story_componentinfo.m_component_id)
  local config = Cfg.cfg_component_story[cfgid]
  local config_campaign_story = Cfg.cfg_campaign_story
  if config ~= nil then
    local length = table.count(config.UnlockCount)
    for i = 1, table.count(config.StoryID) do
      local _data = {}
      _data.storyid = config.StoryID[i]
      _data.unlockitemid = config.UnlockItemID
      if i <= length then
        _data.unlockcount = config.UnlockCount[i]
      else
        _data.unlockcount = 0
      end
      local campaignstory = config_campaign_story[_data.storyid]
      if campaignstory ~= nil then
        _data.title = campaignstory.Title
      else
        _data.title = ""
      end
      table.insert(self._storyData, _data)
    end
  end
end

function UISakuraController:_GetStoryRewards()
  local config = Cfg.cfg_campaign_story[self._storyData[self._currentIndex].storyid]
  local rewards = {}
  if config ~= nil then
    for i = 1, table.count(config.RewardList) do
      local _data = {}
      _data.id = config.RewardList[i][1]
      _data.count = config.RewardList[i][2]
      table.insert(rewards, _data)
    end
  end
  return rewards
end

function UISakuraController:_CheckStoryPlayed(storyid)
  local playedstory = self._story_component:GetAlreadyReceivedStoryIdList()
  return table.icontains(playedstory, storyid)
end

function UISakuraController:_CheckStoryUnLockCost(storydata)
  if storydata == nil then
    return false
  end
  local totalpoint = self._story_component:GetCampaignCount()
  return totalpoint >= storydata.unlockcount
end

function UISakuraController:_CheckUnLockPlayable(storydata, index)
  return self:_CheckStoryUnLockCost(storydata) and not self:_CheckStoryPlayed(storydata.storyid) and self:_CheckPreStoryPlayed(index)
end

function UISakuraController:_CheckPreStoryPlayed(index)
  if index == 1 then
    return true
  end
  local pre_index = index - 1
  if pre_index > table.count(self._storyData) then
    return false
  end
  local pre_storydata = self._storyData[pre_index]
  return self:_CheckStoryPlayed(pre_storydata.storyid)
end

function UISakuraController:_GetUnLockPlayableIndex()
  for i = 1, table.count(self._storyData) do
    local storydata = self._storyData[i]
    if self:_CheckUnLockPlayable(self._storyData[i], i) then
      return i
    end
  end
  return 1
end

function UISakuraController:OnUpdate()
  if self._playCloseAnimation then
    if self._redPointSpine then
      self._redPointSpine.CurrentSkeleton.color = Color(1, 1, 1, self._uiBgCanvasGroup.alpha)
      self._redPointSpine.CurrentSkeleton.Skeleton.A = self._uiBgCanvasGroup.alpha
    end
    for index, value in ipairs(self._cellList) do
      value:OnUpdate(self._uiBgCanvasGroup.alpha)
    end
  end
end

function UISakuraController:_Close()
  self:Lock("UISakuraController:OnHide")
  self._bgAnimation:Play(self._animations.bg_hide)
  self._animation:Play(self._animations.hide)
  self._playCloseAnimation = true
  self:StartTask(function(TT)
    YIELD(TT, 700)
    self:UnLock("UISakuraController:OnHide")
    self._playCloseAnimation = false
    self:CloseDialog()
  end, self)
end

local SakuraStoryState = {
  Lock = 1,
  UnLockCanPlay = 2,
  UnLockCantPlay = 3,
  Played = 4
}
_enum("SakuraStoryState", SakuraStoryState)

function UISakuraController:_GetStoryState(storydata, index)
  if self:_CheckStoryPlayed(storydata.storyid) then
    return SakuraStoryState.Played
  end
  if not self:_CheckStoryUnLockCost(storydata) then
    return SakuraStoryState.Lock
  end
  if self:_CheckPreStoryPlayed(index) then
    return SakuraStoryState.UnLockCanPlay
  else
    return SakuraStoryState.UnLockCantPlay
  end
end
