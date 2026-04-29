_class("UIMailItem", UICustomWidget)
UIMailItem = UIMailItem

function UIMailItem:OnShow(uiParams)
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._senderLabel = self:GetUIComponent("UILocalizationText", "Sender")
  self._sendTimeLabel = self:GetUIComponent("UILocalizationText", "SendTime")
  self._expireTimeLabel = self:GetUIComponent("UILocalizationText", "ExpireTime")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconPanel = self:GetGameObject("IconPanel")
  self._rewardGo = self:GetGameObject("Reward")
  local sop = self:GetUIComponent("UISelectObjectPath", "Reward")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._buttonGetGo = self:GetGameObject("ButtonGet")
  self._buttonDeleteGo = self:GetGameObject("ButtonDelete")
  self._defaultIconIconGo = self:GetGameObject("DefaultIcon")
  self._unGainIconGo = self:GetGameObject("UnGainIcon")
  self._hasReadIconGo = self:GetGameObject("HasReadIcon")
  self._newMailiconGo = self:GetGameObject("NewMailicon")
  self._newMailFrameGo = self:GetGameObject("NewMailFrame")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIMailItem")
  self._expireTimePanel = self:GetGameObject("ExpireTimePanel")
  self._Light = self:GetGameObject("Light")
  self._Scale = self:GetUIComponent("Transform", "UIMailItem")
  self._currentTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.OnOneMinusUpdate, self)
end

function UIMailItem:OnHide()
  if self._currentTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._currentTimeEvent)
    self._currentTimeEvent = nil
  end
end

function UIMailItem:OnOneMinusUpdate()
  self:_RefreshExpireTimeLabel()
end

function UIMailItem:_RefreshExpireTimeLabel()
  if not self._mailData then
    return
  end
  local remaindSeconds = self._mailData.remainSeconds
  if remaindSeconds <= 0 then
    self._expireTimeLabel.text = StringTable.Get("str_mail_expire")
    return
  end
  local days = math.floor(remaindSeconds / 86400)
  if 1 <= days then
    self._expireTimeLabel.text = string.format(StringTable.Get("str_mail_expire_day"), days)
  else
    local hours = math.floor(remaindSeconds / 3600)
    if 1 <= hours then
      self._expireTimeLabel.text = string.format(StringTable.Get("str_mail_expire_hour"), hours)
    else
      local minus = math.floor(remaindSeconds / 60)
      if 1 <= minus then
        self._expireTimeLabel.text = string.format(StringTable.Get("str_mail_expire_minus"), minus)
      else
        self._expireTimeLabel.text = StringTable.Get("str_mail_lower_mins")
      end
    end
  end
end

function UIMailItem:Refresh(mailController, mailData, isCollect)
  isCollect = isCollect or false
  self._expireTimePanel:SetActive(not isCollect)
  self._mailController = mailController
  self._mailData = mailData
  self:_RefreshMailInfo()
  self:_RefreshExpireTimeLabel()
  if not self._mailController.InitedMailList then
    local anim = self:GetUIComponent("Animation", "UIMailItem")
    anim:Play("uieff_MailItem_In")
  else
    local anim = self:GetUIComponent("Animation", "UIMailItem")
    anim:Play("uieff_MailItem_In")
    local state = anim:get_Item("uieff_MailItem_In")
    state.normalizedTime = 1
  end
end

function UIMailItem:_RefreshMailInfo()
  if not self._mailData then
    return
  end
  self._titleLabel.text = self._mailData.title
  self._senderLabel.text = self._mailData.senderName
  self._sendTimeLabel.text = self._mailData.createTime
  if self._mailData.mailIcon and self._mailData.mailIcon ~= "" then
    self._rewardGo:SetActive(false)
    self._iconPanel:SetActive(true)
    self._defaultIconIconGo:SetActive(false)
    self._iconLoader:LoadImage(self._mailData.mailIcon)
  elseif self._mailData.hasReward == true then
    self._rewardGo:SetActive(true)
    self._iconPanel:SetActive(false)
    self._defaultIconIconGo:SetActive(false)
    local reward = self._mailData.rewards[1]
    self:_RefreshRewardInfo(reward)
  else
    self._rewardGo:SetActive(false)
    self._iconPanel:SetActive(false)
    self._defaultIconIconGo:SetActive(true)
  end
  if self._mailData.isRead == false then
    self._newMailiconGo:SetActive(true)
    self._newMailFrameGo:SetActive(true)
    self._unGainIconGo:SetActive(false)
    self._hasReadIconGo:SetActive(false)
    self._canvasGroup.enabled = false
  elseif self._mailData.hasReward and self._mailData.isGain == false then
    self._newMailiconGo:SetActive(false)
    self._newMailFrameGo:SetActive(false)
    self._unGainIconGo:SetActive(true)
    self._hasReadIconGo:SetActive(false)
    self._canvasGroup.enabled = false
  else
    self._newMailiconGo:SetActive(false)
    self._newMailFrameGo:SetActive(false)
    self._unGainIconGo:SetActive(false)
    self._hasReadIconGo:SetActive(true)
    self._canvasGroup.enabled = true
  end
end

function UIMailItem:_RefreshRewardInfo(reward)
  if not reward then
    return
  end
  local templateData = Cfg.cfg_item[reward.assetid]
  if not templateData then
    return
  end
  local icon = templateData.Icon
  local itemId = reward.assetid
  local quality = templateData.Color
  local text1 = reward.count
  self.uiItem:SetData({
    icon = icon,
    itemId = itemId,
    quality = quality,
    text1 = text1
  })
end

function UIMailItem:ButtonGetOnClick(go)
  self._mailController:CollectedReward(self._mailData)
end

function UIMailItem:ButtonDeleteOnClick(go)
  self._mailController:DeleteMail(self._mailData)
end

function UIMailItem:ButtonReadOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self:Lock("UIMailItem:ButtonReadOnClick")
  self._Light:SetActive(true)
  local tween1 = self._Scale:DOScale(Vector3(0.95, 0.95, 1), 0.1):OnComplete(function()
    local tween2 = self._Scale:DOScale(Vector3(1, 1, 1), 0.13):OnComplete(function()
      self:UnLock("UIMailItem:ButtonReadOnClick")
      self._Light:SetActive(false)
      self._mailController:ReadMail(self._mailData)
    end)
  end)
end
