_class("UISeasonFinalPlotEnter", UICustomWidget)
UISeasonFinalPlotEnter = UISeasonFinalPlotEnter

function UISeasonFinalPlotEnter:OnShow(uiParams)
  self.rootGo = self:GetGameObject("Root")
  self.rootGo:SetActive(false)
  self.baseGo = self:GetGameObject("BaseImage")
  self.canTakeGo = self:GetGameObject("CanTakeImage")
  self.firstShowGo = self:GetGameObject("FirstShowImage")
  self:AttachEvents()
end

function UISeasonFinalPlotEnter:OnHide()
  if self._firstShowTask then
    GameGlobal.TaskManager():KillTask(self._firstShowTask)
    self._firstShowTask = nil
  end
end

function UISeasonFinalPlotEnter:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UISeasonFinalPlotEnter:SetData(obj)
  self._seasonObj = obj
  self._story = 0
  self.seasonId = self._seasonObj:GetSeasonID()
  local cfg = Cfg.cfg_season_campaign_client[self.seasonId]
  if cfg then
    self._story = cfg.FinalStoryID
  else
    self.rootGo:SetActive(false)
    return
  end
  self.questCmpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST_STORY)
  self:Refresh()
end

function UISeasonFinalPlotEnter:OnUIGetItemCloseInQuest(type)
  self:Refresh()
  if self._finalPlotCg then
    self:_OnCollectAwardFinish()
  end
end

function UISeasonFinalPlotEnter:BtnGoOnClick()
  self:EnterPlot()
end

function UISeasonFinalPlotEnter:EnterPlot()
  if not self._story then
    return
  end
  if self._story == 0 then
    return
  end
  if self._firstShowTask then
    GameGlobal.TaskManager():KillTask(self._firstShowTask)
    self._firstShowTask = nil
  end
  UISeasonLocalDBHelper.SeasonFinalPlotBtnShowed_Set(self.seasonId)
  self:Refresh()
  
  local function cb()
    self:OnPlotEnd()
  end
  
  UISeasonHelper.PlayStoryInSeasonScence(self._story, cb)
end

function UISeasonFinalPlotEnter:OnPlotEndTmp()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local rewards = {}
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = 7000110
  roleAsset.count = 1
  table.insert(rewards, roleAsset)
  self:_OnRecvRewardsWithAnim(res, rewards)
end

function UISeasonFinalPlotEnter:OnPlotEnd()
  if not self.questCmpt then
    return
  end
  local questStatus = self.questCmpt:CheckCampaignQuestStatus(self._quest._questInfo)
  if questStatus == CampaignQuestStatus.CQS_Completed then
    self:ReqTakeAwards(self._quest._questInfo)
  else
    self:Refresh()
  end
end

function UISeasonFinalPlotEnter:_RefreshByQuestStatus(questStatus)
  if questStatus == CampaignQuestStatus.CQS_Completed then
    self.rootGo:SetActive(true)
    self.baseGo:SetActive(true)
  elseif questStatus == CampaignQuestStatus.CQS_Taken then
    self.rootGo:SetActive(false)
  else
    self.rootGo:SetActive(false)
  end
end

function UISeasonFinalPlotEnter:Refresh()
  if not self.questCmpt then
    return
  end
  if self.questCmpt then
    self._questList = self.questCmpt:GetQuestInfo()
    local seasonId = self._seasonObj:GetSeasonID()
    local finalStoryQuestId
    local seasonClientCfg = Cfg.cfg_season_campaign_client[seasonId]
    if seasonClientCfg then
      finalStoryQuestId = seasonClientCfg.FinalStoryQuestID
    end
    for i, quest in ipairs(self._questList) do
      if quest:ID() == finalStoryQuestId then
        self._quest = quest
        break
      end
    end
  end
  if not self._quest then
    return
  end
  local questStatus = self.questCmpt:CheckCampaignQuestStatus(self._quest._questInfo)
  self:_RefreshByQuestStatus(questStatus)
end

function UISeasonFinalPlotEnter:ReqTakeAwards(questInfo)
  self.questCmpt:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
    self:_OnRecvRewardsWithAnim(res, rewards)
  end)
end

function UISeasonFinalPlotEnter:_OnRecvRewardsWithAnim(res, rewards)
  if not self.view then
    return
  end
  if res and res:GetSucc() then
    local cfg = Cfg.cfg_season_campaign_client[self.seasonId]
    if cfg.FinalStoryCg then
      self._finalPlotCg = true
    end
    UISeasonHelper.ShowUIGetRewards(rewards)
    self:Refresh()
  else
    self._seasonObj:CheckErrorCode(res.m_result, function()
      self:Refresh()
    end, function()
    end)
  end
end

function UISeasonFinalPlotEnter:_OnCollectAwardFinish()
  self:ShowDialog("UISeasonFinalPlotShare", self.seasonId, self._seasonObj:GetComponent(ECCampaignSeasonComponentID.STORY), function()
    self:_OnShareFinish()
  end)
end

function UISeasonFinalPlotEnter:_OnShareFinish()
  self._finalPlotCg = false
end
