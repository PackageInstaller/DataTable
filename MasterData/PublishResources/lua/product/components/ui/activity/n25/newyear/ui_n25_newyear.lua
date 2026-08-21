_class("UIN25NewYear", UIController)
UIN25NewYear = UIN25NewYear

function UIN25NewYear:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._loginModule = self:GetModule(LoginModule)
end

function UIN25NewYear:LoadDataOnEnter(TT, res, uiParams)
  self._autoPop = uiParams[1]
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR, ECampaignN25NewYearComponentID.CUMULATIVE_LOGIN, ECampaignN25NewYearComponentID.TIME_REWARD)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    return
  end
  self._storyID = nil
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
  self._timeRewardComponent = self._localProcess:GetComponent(ECampaignN25NewYearComponentID.TIME_REWARD)
  self._timeRewardComponentInfo = self._timeRewardComponent:GetComponentInfo()
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN25NewYearComponentID.CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:GetComponentInfo()
  if not self:_CheckAutoPop() then
    res:SetResult(-1)
    return res
  end
end

function UIN25NewYear:OnShow(uiParams)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:_GetComponents()
  self:_OnValue()
end

function UIN25NewYear:OnHide()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
end

function UIN25NewYear:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizedTMP", "RemainTime")
  self._bigAwardBtnGo = self:GetGameObject("BigAwardBtn")
  self._bigAwardGotGo = self:GetGameObject("BigAwardGot")
  self._bigAwardUnlockTimedGo = self:GetGameObject("BigAwardUnlockTime")
  self._unlockTime = self:GetUIComponent("UILocalizationText", "UnlockTime")
  self._wishesText = self:GetUIComponent("UILocalizationText", "WishesText")
  self._authorText = self:GetUIComponent("UILocalizationText", "AuthorText")
  self._awardItem = self:GetUIComponent("UISelectObjectPath", "AwardItem")
  self._awardText = self:GetUIComponent("UILocalizationText", "AwardText")
  self._remainSignTimes = self:GetUIComponent("UILocalizationText", "RemainSignTimes")
  self._rePlayGo = self:GetGameObject("RePlay")
  self._rePlayAnimation = self:GetUIComponent("Animation", "RePlay")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UIN25NewYearItemTips")
  self._remainSignGo = self:GetGameObject("RemainSign")
  self._signBtnGo = self:GetGameObject("SignBtn")
  self._signCDGo = self:GetGameObject("SignCD")
  self._signCDText = self:GetUIComponent("UILocalizedTMP", "SignCDText")
end

function UIN25NewYear:_OnValue()
  local curtime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._campaign:GetSample().end_time
  local remainTime = endTime - curtime
  self._remainTime:SetText(UIN25NewYearToolFunctions.GetRemainTime(remainTime))
  local bigTimeRewardInfo
  self._bigAwardID = nil
  if self._timeRewardComponentInfo.m_reward_info then
    for id, timeRewardInfo in pairs(self._timeRewardComponentInfo.m_reward_info) do
      bigTimeRewardInfo = bigTimeRewardInfo or timeRewardInfo
      if not self._bigAwardID then
        self._bigAwardID = id
      end
      break
    end
  end
  self._bigAwardLock = false
  local bigAwardGot = false
  if bigTimeRewardInfo then
    if bigTimeRewardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_LOCK then
      remainTime = bigTimeRewardInfo.unlock_time - curtime
      self._bigAwardLock = true
      self._unlockTime:SetText(UIN25NewYearToolFunctions.GetRemainTime(remainTime))
      self._bigAwardBtnGo:SetActive(false)
      self._bigAwardGotGo:SetActive(false)
    elseif bigTimeRewardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV then
      self._bigAwardBtnGo:SetActive(true)
      self._bigAwardGotGo:SetActive(false)
    elseif bigTimeRewardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_RECVED then
      self._bigAwardBtnGo:SetActive(false)
      self._bigAwardGotGo:SetActive(true)
      bigAwardGot = true
    end
  end
  self._bigAwardUnlockTimedGo:SetActive(self._bigAwardLock)
  self._rePlayGo:SetActive(bigAwardGot)
  if bigAwardGot then
    self._rePlayAnimation:Play("uieff_UIN25NewYear01_in")
  end
  self:_SetWishesText()
  self:_SetSignInfo()
  local SignAward = self:GetTodayAward()
  if SignAward and SignAward[1] then
    local award = SignAward[1]
    local awardItem = self._awardItem:SpawnObject("UIN25NewYearAwardItem")
    awardItem:SetData(award, function(roleAsset, position)
      self:_ShowTips(roleAsset, position)
    end)
    self._awardText:SetText(StringTable.Get("str_n25_newyear_sign_award", award.count))
  end
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
end

function UIN25NewYear:CountDown()
  if not tolua.isnull(self._remainTime) then
    self:_SetSignInfo()
  else
    return
  end
end

function UIN25NewYear:_SetWishesText()
  local index = 1
  local strTable = {}
  while true do
    local key = "str_n25_newyear_wishes_" .. index
    local str = StringTable.Has(key)
    if str then
      strTable[index] = {}
      strTable[index].text = HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(key))
      strTable[index].author = StringTable.Get("str_n25_newyear_author_" .. index)
      index = index + 1
    else
      break
    end
  end
  if #strTable < 1 then
    Log.fatal("N25 New Year message is not configured.")
    return
  end
  local wishesStrTable = strTable[1]
  if self._autoPop then
    local index = math.random(1, #strTable)
    wishesStrTable = strTable[index]
    UIN25NewYearToolFunctions.SetLocalDBInt("UIN25NewYearWishIndex", index)
  else
    local index = UIN25NewYearToolFunctions.GetLocalDBInt("UIN25NewYearWishIndex", 1)
    wishesStrTable = strTable[index]
    wishesStrTable = wishesStrTable or strTable[1]
  end
  self._wishesText:SetText(wishesStrTable.text)
  self._authorText:SetText("-- " .. wishesStrTable.author)
end

function UIN25NewYear:_SetSignInfo()
  local CumulativeLoginRewardInfos = self._cumulativeLoginComponentInfo.m_cumulative_info
  local remainSignCount = 0
  self._day = 0
  local nextLockAward
  for _, info in pairs(CumulativeLoginRewardInfos) do
    if info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK or info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      remainSignCount = remainSignCount + 1
    end
    if info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV and self._day == 0 then
      self._day = info.m_login_days
    end
    if not nextLockAward and info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK then
      nextLockAward = info
    end
  end
  if 0 < self._day then
    self._canSign = true
    self._signBtnGo:SetActive(true)
    self._signCDGo:SetActive(false)
  else
    if remainSignCount <= 0 then
      self._signCDText:SetText(StringTable.Get("str_n25_newyear_sign_done"))
    else
      local curTime = self._svrTimeModule:GetServerTime() * 0.001
      local unlockTime = self._cumulativeLoginComponentInfo.m_unlock_time
      local nextRefreshTime = self._loginModule:GetCampaignRefreshTime()
      if curTime >= unlockTime then
        if nextLockAward then
          local awardUnlockTime = nextLockAward.m_login_unlock_time
          self._signCDText:SetText(UIN25NewYearToolFunctions.GetRemainTime(awardUnlockTime - curTime))
          if curTime > nextLockAward.m_login_unlock_time then
            self:StartTask(function(TT)
              local res = AsyncRequestRes:New()
              self._campaign:ReLoadCampaignInfo_Force(TT, res)
            end)
          end
        else
          self._signCDText:SetText(UIN25NewYearToolFunctions.GetRemainTime(nextRefreshTime - curTime))
        end
      else
        self._signCDText:SetText(UIN25NewYearToolFunctions.GetRemainTime(unlockTime - curTime))
      end
    end
    self._canSign = false
    self._signBtnGo:SetActive(false)
    self._signCDGo:SetActive(true)
  end
  if 0 < remainSignCount then
    local str = string.format("<color=#FDE06C>%s</color>", remainSignCount)
    self._remainSignTimes:SetText(StringTable.Get("str_n25_newyear_remain_sign", str))
  end
  self._remainSignGo:SetActive(0 < remainSignCount)
end

function UIN25NewYear:GetTodayAward()
  local CumulativeLoginRewardInfos = self._cumulativeLoginComponentInfo.m_cumulative_info
  local SignAward
  for _, info in pairs(CumulativeLoginRewardInfos) do
    SignAward = SignAward or info.m_rewards
  end
  return SignAward
end

function UIN25NewYear:PreViewAwardBtnOnClick(go)
  local curtime = self._svrTimeModule:GetServerTime() * 0.001
  local sample = self._campaign:GetSample()
  if not sample or curtime > sample.end_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIN25NewYearAwards", self._timeRewardComponentInfo.m_reward_info)
end

function UIN25NewYear:BigAwardBtnOnClick(go)
  local curtime = self._svrTimeModule:GetServerTime() * 0.001
  local sample = self._campaign:GetSample()
  if not sample or curtime > sample.end_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._bigAwardLock then
    self._timeRewardComponent:Start_HandleTakeTimeRewardReward(self._bigAwardID, function(res, rewards)
      if res:GetSucc() then
        if self._storyID then
          self:ShowDialog("UIStoryController", self._storyID, function()
            self:ShowDialog("UIGetItemController", rewards)
            self._autoPop = false
            self:StartTask(function(TT)
              self._campaign:ReLoadCampaignInfo_Force(TT, res)
              if res:GetSucc() then
                self:_OnValue()
                local petIdList = {}
                local petModule = GameGlobal.GetModule(PetModule)
                for _, reward in pairs(rewards) do
                  if petModule:IsPetID(reward.assetid) then
                    table.insert(petIdList, reward)
                  end
                end
                if #petIdList == 0 then
                  return
                end
                self:ShowDialog("UIPetObtain", petIdList, function()
                  GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
                end)
              end
            end)
          end)
        else
          self:ShowDialog("UIGetItemController", rewards)
          self._autoPop = false
          self:StartTask(function(TT)
            self._campaign:ReLoadCampaignInfo_Force(TT, res)
            if res:GetSucc() then
              self:_OnValue()
              local petIdList = {}
              local petModule = GameGlobal.GetModule(PetModule)
              for _, reward in pairs(rewards) do
                if petModule:IsPetID(reward.assetid) then
                  table.insert(petIdList, reward)
                end
              end
              if #petIdList == 0 then
                return
              end
              self:ShowDialog("UIPetObtain", petIdList, function()
                GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
              end)
            end
          end)
        end
      end
    end)
  end
end

function UIN25NewYear:SignBtnOnClick(go)
  local curtime = self._svrTimeModule:GetServerTime() * 0.001
  local sample = self._campaign:GetSample()
  if not sample or curtime > sample.end_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._canSign then
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local rewards = self._cumulativeLoginComponent:HandleReceiveCumulativeLoginReward(TT, res, self._day)
      if res:GetSucc() then
        self:ShowDialog("UIGetItemController", rewards)
        self._autoPop = false
        self._campaign:ReLoadCampaignInfo_Force(TT, res)
        if res:GetSucc() then
          self:_OnValue()
        end
      end
    end, self)
  end
end

function UIN25NewYear:RePlayBtnOnClick(go)
  local curtime = self._svrTimeModule:GetServerTime() * 0.001
  local sample = self._campaign:GetSample()
  if not sample or curtime > sample.end_time then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._storyID then
    self:ShowDialog("UIStoryController", self._storyID)
  end
end

function UIN25NewYear:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIN25NewYear:_ShowTips(roleAsset, position)
  self._tips:SetData(roleAsset, position)
end

function UIN25NewYear:_CheckAutoPop()
  local remainSignCount = 0
  local CumulativeLoginRewardInfos = self._cumulativeLoginComponentInfo.m_cumulative_info
  for _, info in pairs(CumulativeLoginRewardInfos) do
    if info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK or info.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      remainSignCount = remainSignCount + 1
    end
  end
  local bigAwardGot = false
  local timeRewardInfos = self._timeRewardComponentInfo.m_reward_info
  for _, timeRewardInfo in pairs(timeRewardInfos) do
    if timeRewardInfo then
      bigAwardGot = timeRewardInfo.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_RECVED
    end
    break
  end
  if bigAwardGot and remainSignCount <= 0 and self._autoPop then
    return false
  end
  return true
end
