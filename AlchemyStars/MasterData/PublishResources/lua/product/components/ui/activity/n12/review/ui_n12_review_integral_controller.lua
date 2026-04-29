_class("UIN12IntegralController_Review", UIController)
UIN12IntegralController_Review = UIN12IntegralController_Review

function UIN12IntegralController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N12)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not self._campaign then
    return
  end
  self._progressInfo = self._campaign:GetComponentInfo(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_POINT_PROGRESS)
  self._story_component = self._campaign:GetLocalProcess()._storyComponent
  self._storyInfo = self._campaign:GetComponentInfo(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_STORY)
  self._componentID = self._story_component:GetComponetCfgId(self._campaign._id, self._storyInfo.m_component_id)
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
end

function UIN12IntegralController_Review:OnShow(uiParams)
  self:_GetComponent()
  self:_SetValue(uiParams)
  self:_SetShow()
end

function UIN12IntegralController_Review:_GetComponent()
  self._surprised = self:GetGameObject("_surprised")
end

function UIN12IntegralController_Review:_SetValue(uiParams)
  self._photoCfg = Cfg.cfg_n12_photo_wall()
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
  self._commonTopBtn = nil
  self._wall = {}
  self._storyDate = {}
  self:_SetDate()
end

function UIN12IntegralController_Review:_SetDate()
  local storyCfg = Cfg.cfg_component_story[self._componentID]
  local storyidList = storyCfg.StoryID
  local storycountList = storyCfg.UnlockCount
  local lastid = 0
  for i = 1, #storyidList do
    local date = {}
    date.last = table.icontains(self._storyInfo.m_recieved_reward_story, lastid)
    date.storyid = storyidList[i]
    lastid = date.storyid
    date.needcount = storycountList and storycountList[i] or 0
    local photo = self._photoCfg[date.storyid]
    date.photo = photo
    if self._storyInfo.m_total_count >= date.needcount then
      date.lock = not date.photo.LockIcon == date.last
    else
      date.lock = true
    end
    if date.photo.Surprised then
      self._surprisedidx = i
    end
    table.insert(self._storyDate, date)
  end
end

function UIN12IntegralController_Review:_SetShow()
  self._surprised:SetActive(false)
  local backBtn = self:GetUIComponent("UISelectObjectPath", "_backbtn")
  self._commonTopBtn = backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    if self:CheckOpen() then
      return
    end
    self:SwitchState(UIStateType.UIN12MainController_Review)
  end)
  local wallRoot = self:GetGameObject("_wall").transform
  for i = 1, wallRoot.childCount do
    local item = wallRoot:GetChild(i - 1)
    local loader = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local wall = loader:SpawnObject("UIN12PhotoReviewItem")
    self._wall[#self._wall + 1] = wall
    local cfg = self._storyDate[i]
    wall:SetData(i, cfg, self._story_component, self._storyInfo, function(idx)
      self._wall[idx]:SetRed(false)
      local nextWall = self._wall[idx + 1]
      if nextWall and nextWall:GetsEnough() then
        nextWall:SetRed(true, false)
      end
      if self._wall[idx]:GetSurprised() then
        self._surprised:SetActive(true)
      end
    end, function()
      return self:CheckOpen()
    end)
  end
  local iteminfo = self:GetUIComponent("UISelectObjectPath", "_ItemInfo")
  self._iteminfo = iteminfo:SpawnObject("UISelectInfo")
  if self._wall[self._surprisedidx]:CheckStoryGotAwards() then
    self._surprised:SetActive(true)
  end
  self:_Roll2Target()
end

function UIN12IntegralController_Review:_GetState(idx)
end

function UIN12IntegralController_Review:_GetAllAward()
  self:StartTask(function(TT)
    local c = self._progress_component
    local res = AsyncRequestRes:New()
    local awards = c:HandleOneKeyReceiveRewards(TT, res)
    if awards and table.count(awards) > 0 then
      UIBlackFightReputationItem.ShowRewards(awards)
      self:_SetReputationsGot()
    end
  end, self)
end

function UIN12IntegralController_Review:_SetReputationsGot()
  if self._reputations and table.count(self._reputations) > 0 then
    for index, v in ipairs(self._reputations) do
      if v.gotState == N12IntegralState.CanGet then
        v.gotState = N12IntegralState.Got
      end
    end
  end
end

function UIN12IntegralController_Review:_Roll2Target()
  local reputations = self._reputations
  if not reputations then
    return
  end
  if table.count(reputations) <= 0 then
    return
  end
  local target
  for i, v in ipairs(reputations) do
    if v.gotState == N12IntegralState.CanGet then
      target = i
      break
    end
  end
  if not target then
    for i, v in ipairs(reputations) do
      if v.gotState == nil then
        target = i
        break
      end
    end
  end
end

function UIN12IntegralController_Review:CheckOpen()
  if not self._campaign:CheckComponentOpen(ECampaignReviewN12ComponentID.ECAMPAIGN_REVIEW_ReviewN12_POINT_PROGRESS) then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    self:SwitchState(UIStateType.UIMain)
    return true
  end
  return false
end

function UIN12IntegralController_Review:_InitReputation()
  self._curReputation = self._progressInfo.m_current_progress
  self._reputations = {}
  local receiveds = self._progressInfo.m_received_progress
  local progresses = self._progressInfo.m_progress_rewards
  local special = self._progressInfo.m_special_rewards
  if progresses and table.count(progresses) > 0 then
    for key, reward in pairs(progresses) do
      local rd = N12IntegralData:New()
      rd.reputation = key
      rd.awards = reward
      if special[key] then
        rd.isSpecial = true
      end
      local hasGot = false
      hasGot = self._progress_component:IsReceivedProgress(key)
      if key <= self._curReputation then
        if hasGot then
          rd.gotState = N12IntegralState.Got
        else
          rd.gotState = N12IntegralState.CanGet
        end
      else
        rd.gotState = nil
      end
      table.insert(self._reputations, rd)
    end
    table.sort(self._reputations, function(a, b)
      return a.reputation < b.reputation
    end)
  end
end
