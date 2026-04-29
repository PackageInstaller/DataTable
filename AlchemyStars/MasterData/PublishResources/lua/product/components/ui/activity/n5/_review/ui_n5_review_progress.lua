_class("UIN5ReviewProgress", UICustomWidget)
UIN5ReviewProgress = UIN5ReviewProgress

function UIN5ReviewProgress:OnShow(uiParams)
  self:InitWidget()
end

function UIN5ReviewProgress:InitWidget()
  self.awardIcon = self:GetUIComponent("RawImageLoader", "awardIcon")
  self.selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self.progress = self:GetUIComponent("Image", "progress")
  self.percent = self:GetUIComponent("UILocalizationText", "percent")
  self.slider = self:GetGameObject("slider")
  self.collect = self:GetGameObject("Collect")
  self.collected = self:GetGameObject("Collected")
  self.cantCollect = self:GetGameObject("CantCollect")
  self.awards = self:GetUIComponent("UISelectObjectPath", "awards")
end

function UIN5ReviewProgress:SetData(data)
  self._reviewData = data
  self._campaign = self._reviewData:GetDetailInfo()
  self._progressCom = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_POINT_PROGRESS, 1)
  self._progressInfo = self._progressCom:GetComponentInfo()
  Log.debug("[Review] 当前进度为:", self._progressInfo.m_current_progress .. "/" .. self._progressInfo.m_total_progress)
  local currentProgress = self._progressInfo.m_current_progress
  local totalProgress = self._progressInfo.m_total_progress
  local process = currentProgress / totalProgress
  
  local function isProgressGet(p)
    for i = 1, #self._progressInfo.m_received_progress do
      if self._progressInfo.m_received_progress[i] == p then
        return true
      end
    end
    return false
  end
  
  self._allAwards = {}
  local hasRewards = false
  for progress, award in pairs(self._progressInfo.m_progress_rewards) do
    if award[1] == nil then
      ReviewError("进度奖励配置错误，无奖励:", progress)
    end
    local data = {}
    data.progress = progress
    data.rewards = award
    data.status = 0
    if progress <= process * 100 then
      if not isProgressGet(progress) then
        hasRewards = true
        data.status = 2
      else
        data.status = 1
      end
    else
      data.status = 3
    end
    table.insert(self._allAwards, {
      Progress = progress,
      AwardID = award[1].assetid,
      Status = data.status
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
  local uiAwards = self.awards:SpawnObjects("UIN5ReviewProgressAward", #self._allAwards)
  local delay = 410
  for index, ui in ipairs(uiAwards) do
    ui:SetData(index, self._curAwardIdx, self._allAwards[index].Progress, self._reviewData:ProgressPercent(), self._allAwards[index].Status)
    ui:PlayEnterAni(delay)
    delay = delay + 30
  end
  if self._curAwardIdx == -1 then
    self._canCollect = false
    self.collected:SetActive(true)
    self.collect:SetActive(false)
    self.cantCollect:SetActive(false)
    self.awardIcon:LoadImage(Cfg.cfg_item[self._allAwards[#self._allAwards].AwardID].Icon)
  else
    self._awardID = self._allAwards[self._curAwardIdx].AwardID
    self.awardIcon:LoadImage(Cfg.cfg_item[self._awardID].Icon)
    if self._reviewData:ProgressPercent() >= self._allAwards[self._curAwardIdx].Progress then
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
  self:StartTask(function(TT)
    local lockName = "UIN5ReviewProgressEnterAni"
    self:Lock(lockName)
    YIELD(TT, delay)
    self:UnLock(lockName)
  end, self)
end

function UIN5ReviewProgress:CollectOnClick(go)
  if not self._canCollect then
    return
  end
  self:StartTask(self.ReqGetAward, self)
end

function UIN5ReviewProgress:ReqGetAward(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  self:Lock("UIN5ReviewProgress:Collect")
  local assets = self._progressCom:HandleReceiveReward(TT, res, self._allAwards[self._curAwardIdx].Progress)
  self:UnLock("UIN5ReviewProgress:Collect")
  if res:GetSucc() then
    self._canCollect = false
    local petIdList = {}
    local petModule = GameGlobal.GetModule(PetModule)
    for _, reward in pairs(assets) do
      if petModule:IsPetID(reward.assetid) then
        table.insert(petIdList, reward)
      end
    end
    if table.count(petIdList) > 0 then
      self:ShowDialog("UIPetObtain", petIdList, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        self:ShowDialog("UIGetItemController", assets, function()
          self:SetData(self._reviewData)
        end)
      end)
    else
      self:ShowDialog("UIGetItemController", assets, function()
        self:SetData(self._reviewData)
      end)
    end
  else
    Log.fatal("Collect final award failed:", res:GetResult())
  end
end

function UIN5ReviewProgress:AwardIconOnClick(go)
  if not self.selectInfo then
    self.selectInfo = self.selectInfoPool:SpawnObject("UISelectInfo")
  end
  self.selectInfo:SetData(self._awardID, go.transform.position)
end

function UIN5ReviewProgress:DetailBtnOnClick()
  self:ShowDialog("UIN5ReviewProgressAwardDetail", function()
    self:SetData(self._reviewData)
  end)
end

function UIN5ReviewProgress:BtnOnClick()
  self:ShowDialog("UIN5ReviewProgressAwardDetail", function()
    self:SetData(self._reviewData)
  end)
end
