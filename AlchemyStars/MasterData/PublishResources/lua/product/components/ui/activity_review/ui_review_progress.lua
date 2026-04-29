_class("UIReviewProgress", UICustomWidget)
UIReviewProgress = UIReviewProgress

function UIReviewProgress:InitWidget()
  self.awardIcon = self:GetUIComponent("RawImageLoader", "awardIcon")
  self.selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self.progress = self:GetUIComponent("Image", "progress")
  self.percent = self:GetUIComponent("UILocalizationText", "percent")
  self.slider = self:GetGameObject("slider")
  self.collect = self:GetGameObject("Collect")
  self.collected = self:GetGameObject("Collected")
  self.cantCollect = self:GetGameObject("CantCollect")
end

function UIReviewProgress:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnUIChanged)
  self:InitWidget()
end

function UIReviewProgress:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnUIChanged)
end

function UIReviewProgress:SetData(data, cfg)
  self._cfg = cfg
  self._awardPrefabName = cfg and cfg.PrefabProgressAward or "UIReviewProgressAward.prefab"
  self._reviewData = data
  self._campaignType = data:ActivityType()
  self._campaign = self._reviewData:GetDetailInfo()
  self._progressCom = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_POINT_PROGRESS, 1)
  self._progressInfo = self._progressCom:GetComponentInfo()
  Log.debug("[Review] 当前进度为:", self._progressInfo.m_current_progress .. "/" .. self._progressInfo.m_total_progress)
  self:_Refresh(true)
end

function UIReviewProgress:_OnUIChanged()
  self:_Refresh()
end

function UIReviewProgress:_Refresh(playAnim)
  self._allAwards = {}
  for progress, award in pairs(self._progressInfo.m_progress_rewards) do
    if award[1] == nil then
      ReviewError("进度奖励配置错误，无奖励:", progress)
    end
    table.insert(self._allAwards, {
      Progress = progress,
      AwardID = award[1].assetid
    })
  end
  table.sort(self._allAwards, function(a, b)
    return a.Progress < b.Progress
  end)
  self._curAwardIdx = -1
  for idx, award in ipairs(self._allAwards) do
    if not table.icontains(self._progressInfo.m_received_progress, award.Progress) then
      self._curAwardIdx = idx
      break
    end
  end
  self.progress.fillAmount = self._reviewData:ProgressPercent() / 100
  self.percent:SetText(self._reviewData:ProgressPercent() .. "%")
  local uiAwards = UIWidgetHelper.SpawnObjects(self, "awards", "UIReviewProgressAward", #self._allAwards, self._awardPrefabName)
  
  local function checkFun(index)
    local received = false
    if table.icontains(self._progressInfo.m_received_progress, self._allAwards[index].Progress) then
      received = true
    end
    return received
  end
  
  for index, ui in ipairs(uiAwards) do
    ui:SetData(index, self._curAwardIdx, self._allAwards[index].Progress, self._reviewData:ProgressPercent(), checkFun(index))
    if playAnim and ui.PlayEnterAni then
      ui:PlayEnterAni(index)
    end
  end
  local isAllGet = self._curAwardIdx == -1
  self._curAwardIdx = isAllGet and #self._allAwards or self._curAwardIdx
  self._awardID = self._allAwards[self._curAwardIdx].AwardID
  self.awardIcon:LoadImage(Cfg.cfg_item[self._awardID].Icon)
  if isAllGet then
    self._canCollect = false
    self.collected:SetActive(true)
    self.collect:SetActive(false)
    self.cantCollect:SetActive(false)
  elseif self._reviewData:ProgressPercent() >= self._allAwards[self._curAwardIdx].Progress then
    self._canCollect = true
    self.collected:SetActive(false)
    self.collect:SetActive(true)
    self.cantCollect:SetActive(false)
  else
    self._canCollect = false
    self.collected:SetActive(false)
    self.collect:SetActive(false)
    self.cantCollect:SetActive(true)
  end
end

function UIReviewProgress:CollectOnClick(go)
  if not self._canCollect then
    return
  end
  self._progressCom:Start_HandleReceiveReward(self._allAwards[self._curAwardIdx].Progress, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UIReviewProgress:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:_Refresh()
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
    end)
  end
end

function UIReviewProgress:AwardIconOnClick(go)
  if not self.selectInfo then
    self.selectInfo = self.selectInfoPool:SpawnObject("UISelectInfo")
  end
  self.selectInfo:SetData(self._awardID, go.transform.position)
end

function UIReviewProgress:DetailBtnOnClick()
  self:ShowDialog("UIReviewProgressAwardDetail", self._campaignType, self._cfg)
end

function UIReviewProgress:BtnOnClick()
  self:ShowDialog("UIReviewProgressAwardDetail", self._campaignType, self._cfg)
end
