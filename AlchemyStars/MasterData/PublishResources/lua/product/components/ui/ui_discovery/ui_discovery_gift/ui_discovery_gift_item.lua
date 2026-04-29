_class("UIDiscoveryGiftItem", UICustomWidget)
UIDiscoveryGiftItem = UIDiscoveryGiftItem

function UIDiscoveryGiftItem:Constructor()
end

function UIDiscoveryGiftItem:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._timerTex = self:GetUIComponent("UILocalizationText", "timer")
  self._timerTex2 = self:GetUIComponent("UILocalizationText", "timer2")
  self._redGo = self:GetGameObject("red")
  self:AttachEvent(GameEventType.OnDisGiftCheckRed, self.CheckRed)
end

function UIDiscoveryGiftItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIDiscoveryGiftItem:SetData(good, cfgv, refreshCallback)
  self._good = good
  self._cfgv = cfgv
  self._refreshCallback = refreshCallback
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:CheckRed()
  self:CheckTimeTex()
end

function UIDiscoveryGiftItem:CheckRed()
  if self._good then
    local gidtid = self._good.gift_id
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local key = "UIDiscoveryGiftItem" .. pstid .. gidtid
    local val = LocalDB.GetInt(key, 0)
    if val == 0 then
      self._redGo:SetActive(true)
    else
      self._redGo:SetActive(false)
    end
  else
    self._redGo:SetActive(false)
  end
end

function UIDiscoveryGiftItem:CheckTimeTex()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTimeTex()
  end)
  self:ShowTimeTex()
end

function UIDiscoveryGiftItem:ShowTimeTex()
  local endTime = self._good.deadline_time
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local gap = math.floor(endTime - nowTime)
  if 0 < gap then
    local timeStr = HelperProxy:GetInstance():Time2Tex(gap)
    self._timerTex:SetText(timeStr)
    self._timerTex2:SetText(timeStr)
  else
    if self._refreshCallback then
      self._refreshCallback()
    end
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
  end
end

function UIDiscoveryGiftItem:BgOnClick(go)
  self:ShowDialog("UIDiscoveryGiftController", self._good, self._cfgv)
end
