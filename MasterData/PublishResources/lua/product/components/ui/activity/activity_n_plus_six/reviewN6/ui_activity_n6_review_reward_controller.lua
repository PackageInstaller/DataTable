_class("UIActivityN6ReviewRewardController", UIController)
UIActivityN6ReviewRewardController = UIActivityN6ReviewRewardController

function UIActivityN6ReviewRewardController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N6, ECampaignReviewN6ComponentID.QUEST)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._questComponent = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.QUEST)
  self._questComponentInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.QUEST)
  self:RefreshData()
end

function UIActivityN6ReviewRewardController:RefreshData()
  self._questInfoList = self._questComponent:GetQuestInfo()
  self._questComponent:SortQuestInfoByCampaignQuestStatus(self._questInfoList)
  local onePageCount = 6
  self._pageCount = math.ceil(#self._questInfoList / onePageCount)
  if self._pageCount <= 0 then
    self._pageCount = 1
  end
  self._pageDatas = {}
  for i = 1, self._pageCount do
    local pageData = {}
    for j = 1, onePageCount do
      local data = self._questInfoList[(i - 1) * onePageCount + j]
      if data then
        pageData[#pageData + 1] = data
      end
    end
    self._pageDatas[#self._pageDatas + 1] = pageData
  end
end

function UIActivityN6ReviewRewardController:OnShow(uiParams)
  self._currentPage = 1
  self._showBtn = self:GetGameObject("ShowBtn")
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._showBtn:SetActive(false)
  self._btnPanel:SetActive(true)
  self._buildingDatas = uiParams[1]
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingMainRefresh)
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._leftBtnGo = self:GetGameObject("LeftBtn")
  self._leftRedPoint = self:GetGameObject("LeftRedPoint")
  self._rightBtnGo = self:GetGameObject("RightBtn")
  self._rightRedPoint = self:GetGameObject("RightRedPoint")
  self._rewardRedPoint = self:GetGameObject("RewardRedPoint")
  self._pageLabel = self:GetUIComponent("UILocalizationText", "Page")
  self._buildingIcon = self:GetGameObject("BuildingIcon")
  self._buildingIconLoader = self:GetUIComponent("RawImageLoader", "BuildingIcon")
  self._buildingIcon:SetActive(false)
  self._currentSelectQuest = nil
  self:RefreshUI()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:AttachEvent(GameEventType.NPlusSixBuildingRewardGet, self.Refresh)
end

function UIActivityN6ReviewRewardController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.NPlusSixBuildingRewardGet, self.Refresh)
end

function UIActivityN6ReviewRewardController:CloseCoro(TT)
  self:Lock("UIActivityNPlusSixMainController_CloseCoro")
  self:CloseDialog()
  self:UnLock("UIActivityNPlusSixMainController_CloseCoro")
end

function UIActivityN6ReviewRewardController:ShowBtnOnClick()
  self._showBtn:SetActive(false)
  self._btnPanel:SetActive(true)
end

function UIActivityN6ReviewRewardController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIActivityN6ReviewRewardController:Refresh()
  self:RefreshData()
  self:RefreshUI()
end

function UIActivityN6ReviewRewardController:RefreshUI()
  if self._currentPage <= 1 then
    self._leftBtnGo:SetActive(false)
  else
    self._leftBtnGo:SetActive(true)
  end
  if self._currentPage >= self._pageCount then
    self._rightBtnGo:SetActive(false)
  else
    self._rightBtnGo:SetActive(true)
  end
  self._pageLabel:SetText(self._currentPage .. "/" .. self._pageCount)
  self:RefreshRedPoint()
  local pageData = self._pageDatas[self._currentPage]
  local contents = self:GetUIComponent("UISelectObjectPath", "Content")
  contents:SpawnObjects("UIActivityNPlusSixRewardInfoItem", #pageData)
  self._rewardItems = contents:GetAllSpawnList()
  if not self._rewardItems then
    return
  end
  for i = 1, #pageData do
    self._rewardItems[i]:Refresh(pageData[i], self._questComponent, self)
  end
  self:RefreshSelectItem()
end

function UIActivityN6ReviewRewardController:RefreshRedPoint()
  if self._currentPage <= 1 then
    self._leftRedPoint:SetActive(false)
  else
    local hasRed = false
    for i = 1, self._currentPage - 1 do
      local pageData = self._pageDatas[i]
      for j = 1, #pageData do
        local data = pageData[j]
        local status = data:Status()
        if status == QuestStatus.QUEST_Completed then
          hasRed = true
          break
        end
      end
      if hasRed then
        break
      end
    end
    self._leftRedPoint:SetActive(hasRed)
  end
  if self._currentPage >= self._pageCount then
    self._rightRedPoint:SetActive(false)
  else
    local hasRed = false
    for i = self._currentPage + 1, self._pageCount do
      local pageData = self._pageDatas[i]
      for j = 1, #pageData do
        local data = pageData[j]
        local status = data:Status()
        if status == QuestStatus.QUEST_Completed then
          hasRed = true
          break
        end
      end
      if hasRed then
        break
      end
    end
    self._rightRedPoint:SetActive(hasRed)
  end
  local hasRed = false
  for i = 1, #self._questInfoList do
    local status = self._questInfoList[i]:Status()
    if status == QuestStatus.QUEST_Completed then
      hasRed = true
      break
    end
  end
  self._rewardRedPoint:SetActive(hasRed)
end

function UIActivityN6ReviewRewardController:SelectRewardItem(quest)
  self._currentSelectQuest = quest
  self:RefreshSelectItem()
end

function UIActivityN6ReviewRewardController:RefreshSelectItem()
  if not self._rewardItems then
    return
  end
  for i = 1, #self._rewardItems do
    if self._rewardItems[i]:GetQuest() == self._currentSelectQuest then
      self._rewardItems[i]:SetSelectStatus(true)
    else
      self._rewardItems[i]:SetSelectStatus(false)
    end
  end
  if self._currentSelectQuest then
    self._buildingIcon:SetActive(false)
    local questInfo = self._currentSelectQuest:QuestInfo()
    self._buildingIconLoader:LoadImage(questInfo.Icon)
  else
    self._buildingIcon:SetActive(false)
  end
end

function UIActivityN6ReviewRewardController:LeftBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6PageTurn)
  if self._currentPage <= 1 then
    return
  end
  self:SetLastPageInfo()
  self._currentPage = self._currentPage - 1
  self:RefreshUI()
  self:PlayPageAnimation()
end

function UIActivityN6ReviewRewardController:RightBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6PageTurn)
  if self._currentPage >= self._pageCount then
    return
  end
  self:SetLastPageInfo()
  self._currentPage = self._currentPage + 1
  self:RefreshUI()
  self:PlayPageAnimation()
end

function UIActivityN6ReviewRewardController:SetLastPageInfo()
  local lastPageLabel = self:GetUIComponent("UILocalizationText", "LastPage")
  lastPageLabel:SetText(self._currentPage .. "/" .. self._pageCount)
  local pageData = self._pageDatas[self._currentPage]
  local contents = self:GetUIComponent("UISelectObjectPath", "LastContent")
  contents:SpawnObjects("UIActivityNPlusSixRewardInfoItem", #pageData)
  local rewardItems = contents:GetAllSpawnList()
  if not rewardItems then
    return
  end
  for i = 1, #pageData do
    rewardItems[i]:Refresh(pageData[i], self._questComponent, self)
  end
end

function UIActivityN6ReviewRewardController:PlayPageAnimation()
  GameGlobal.TaskManager():StartTask(function(TT)
    self:Lock("UIActivityN6ReviewRewardController_PlayPageAnimation")
    local animation = self:GetUIComponent("Animation", "Anim")
    animation:Play("uieff_N6_reward_Switch")
    YIELD(TT, 500)
    self:UnLock("UIActivityN6ReviewRewardController_PlayPageAnimation")
  end, self)
end

function UIActivityN6ReviewRewardController:GetRewardBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.GetRewards, self)
end

function UIActivityN6ReviewRewardController:GetRewards(TT)
  local questList = {}
  for i = 1, #self._questInfoList do
    local status = self._questInfoList[i]:Status()
    if status == QuestStatus.QUEST_Completed then
      questList[#questList + 1] = self._questInfoList[i]
    end
  end
  if #questList <= 0 then
    return
  end
  self:Lock("UIActivityN6ReviewRewardController_GetRewards")
  local rewards = {}
  local ret = 0
  for i = 1, #questList do
    local res = AsyncRequestRes:New()
    local tmpRet, tmpRewards = self._questComponent:HandleQuestTake(TT, res, questList[i]:ID())
    if tmpRet ~= 0 then
      ret = tmpRet
      break
    end
    if tmpRewards then
      for i = 1, #tmpRewards do
        rewards[#rewards + 1] = tmpRewards[i]
      end
    end
  end
  if ret == 0 then
    self:ShowRewards(rewards)
  else
    Log.error("GetRewards error")
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingRewardGet)
  self:UnLock("UIActivityN6ReviewRewardController_GetRewards")
end

function UIActivityN6ReviewRewardController:ShowRewards(rewards)
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

function UIActivityN6ReviewRewardController:ReviewBtnOnClick()
  local storyIds = self._buildingDatas:GetCanReviewStory()
  if storyIds == nil or table.count(storyIds) <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_can_review_plot"))
    return
  end
  local canReviewStages = {}
  local cfgs = Cfg.cfg_component_n_plus_six_plot_review({})
  if cfgs then
    for i = 1, #storyIds do
      local cfg = cfgs[storyIds[i]]
      local curStage = DiscoveryStage:New()
      curStage.id = cfg.ID
      curStage.longDesc = StringTable.Get(cfg.Des)
      curStage.name = StringTable.Get(cfg.Name)
      curStage.stageIdx = StringTable.Get(cfg.StageIndexTitle)
      curStage.fullname = StringTable.Get(cfg.FullName)
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg.ID
      local storyListCfg = cfg.StoryList
      for i = 1, #storyListCfg do
        local story = DiscoveryStory:New()
        story:Init(storyListCfg[i][1], storyListCfg[i][2])
        table.insert(slist, story)
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, false, true, StringTable.Get("str_n_plus_six_plot_review_stage_title"))
end
