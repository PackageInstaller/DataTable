_class("UIN12IntegralController", UIController)
UIN12IntegralController = UIN12IntegralController

function UIN12IntegralController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_STORY, ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE)
  local componentId = ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE
  if not self._campaign:CheckComponentOpen(componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(componentId) or res.m_result
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
  self._story_component = self._campaign:GetLocalProcess()._storyComponent
  self._progress_component = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE)
  self._storyInfo = self._campaign:GetComponentInfo(ECampaignN12ComponentID.ECAMPAIGN_N12_STORY)
  self._componentID = self._story_component:GetComponetCfgId(self._campaign._id, self._storyInfo.m_component_id)
  self._progressInfo = self._campaign:GetComponentInfo(ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE)
end

function UIN12IntegralController:OnShow(uiParams)
  self:_GetComponent()
  self:_SetValue(uiParams)
  self:_InitReputation()
  self:_SetShow()
end

function UIN12IntegralController:_GetComponent()
  self._getbtn = self:GetGameObject("_getbtn")
  self._surprised = self:GetGameObject("_surprised")
  self._integral = self:GetUIComponent("UILocalizationText", "_integral")
  self._rtContent = self:GetUIComponent("RectTransform", "_rtContent")
end

function UIN12IntegralController:_SetValue(uiParams)
  self._photoCfg = Cfg.cfg_n12_photo_wall()
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
  self._commonTopBtn = nil
  self._wall = {}
  self._awards = {}
  self._storyDate = {}
  self:_SetDate()
end

function UIN12IntegralController:_SetDate()
  local storyCfg = Cfg.cfg_component_story[self._componentID]
  local storyidList = storyCfg.StoryID
  local storycountList = storyCfg.UnlockCount
  local lastid = 0
  for i = 1, #storyidList do
    local date = {}
    date.last = table.icontains(self._storyInfo.m_recieved_reward_story, lastid)
    date.storyid = storyidList[i]
    lastid = date.storyid
    date.needcount = storycountList[i]
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

function UIN12IntegralController:_SetShow()
  if not self._progress_component:HasCanGetReward() then
    self._getbtn:SetActive(false)
  end
  self._surprised:SetActive(false)
  local backBtn = self:GetUIComponent("UISelectObjectPath", "_backbtn")
  self._commonTopBtn = backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    if self:CheckOpen() then
      return
    end
    self:SwitchState(UIStateType.UIN12MainController)
  end)
  local wallRoot = self:GetGameObject("_wall").transform
  for i = 1, wallRoot.childCount do
    local item = wallRoot:GetChild(i - 1)
    local loader = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local wall = loader:SpawnObject("UIN12PhotoItem")
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
  local awards = self:GetUIComponent("UISelectObjectPath", "_awards")
  awards:SpawnObjects("UIN12IntegralItem", #self._reputations)
  self._awards = awards:GetAllSpawnList()
  for idx, value in ipairs(self._awards) do
    value:SetData(self._progress_component, idx, self._reputations[idx], function(matid, pos)
      self._iteminfo:SetData(matid, pos)
    end, self._curReputation, function()
      if not self._progress_component:HasCanGetReward() then
        self._getbtn:SetActive(false)
      end
    end, function()
      return self:CheckOpen()
    end)
  end
  if self._wall[self._surprisedidx]:CheckStoryGotAwards() then
    self._surprised:SetActive(true)
  end
  self._integral:SetText(self._curReputation)
  self:_Roll2Target()
end

function UIN12IntegralController:_GetState(idx)
end

function UIN12IntegralController:_GetAllAward()
  self:StartTask(function(TT)
    local c = self._progress_component
    local res = AsyncRequestRes:New()
    local awards = c:HandleOneKeyReceiveRewards(TT, res)
    if awards and table.count(awards) > 0 then
      UIBlackFightReputationItem.ShowRewards(awards)
      self:_SetReputationsGot()
      self:_SetItemDate()
      self._getbtn:SetActive(false)
    end
  end, self)
end

function UIN12IntegralController:_SetItemDate()
  for idx, value in ipairs(self._awards) do
    value:SetData(self._progress_component, idx, self._reputations[idx], function(matid, pos)
      self._iteminfo:SetData(matid, pos)
    end, self._curReputation)
  end
end

function UIN12IntegralController:_SetReputationsGot()
  if self._reputations and table.count(self._reputations) > 0 then
    for index, v in ipairs(self._reputations) do
      if v.gotState == N12IntegralState.CanGet then
        v.gotState = N12IntegralState.Got
      end
    end
  end
end

function UIN12IntegralController:_Roll2Target()
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
  local uis = self._awards
  if uis then
    target = target or table.count(uis)
    local ui = uis[target]
    local rt = ui:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
    UnityEngine.Canvas.ForceUpdateCanvases()
    local v3 = self._rtContent.transform:InverseTransformPoint(self._rtContent.position) - self._rtContent.transform:InverseTransformPoint(rt.position)
    self._rtContent.anchoredPosition = Vector2(0, v3.y - rt.rect.height * 0.5)
  end
end

function UIN12IntegralController:CheckOpen()
  if not self._campaign:CheckComponentOpen(ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE) then
    ToastManager.ShowToast(StringTable.Get("str_n12_activity_over"))
    self:SwitchState(UIStateType.UIMain)
    return true
  end
  return false
end

function UIN12IntegralController:getbtnOnClick()
  if self:CheckOpen() then
    return
  end
  self:_GetAllAward()
end

function UIN12IntegralController:_InitReputation()
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

_class("N12IntegralData", Object)
N12IntegralData = N12IntegralData

function N12IntegralData:Constructor()
  self.reputation = 0
  self.awards = {}
  self.isSpecial = false
  self.gotState = nil
end

local N12IntegralState = {CanGet = 1, Got = 2}
_enum("N12IntegralState", N12IntegralState)
