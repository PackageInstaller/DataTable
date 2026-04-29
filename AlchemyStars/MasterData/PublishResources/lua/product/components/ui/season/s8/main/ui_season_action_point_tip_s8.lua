_class("UISeasonActionPointTipS8", UIController)
UISeasonActionPointTipS8 = UISeasonActionPointTipS8

function UISeasonActionPointTipS8:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonActionPointTipS8:OnShow(uiParams)
  self:InitWidget()
  self._cpt = uiParams[1]
  local pos = uiParams[2]
  self._onHide = uiParams[3]
  self.root.anchoredPosition = pos + Vector2(-20, 0)
  local remainTime = self._cpt:GetRegainEndTime()
  if remainTime <= 0 then
    self._countdownStop = true
  end
  if not self._countdownStop then
    self._targetTime = remainTime + 1
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_Countdown()
    end)
  end
  self:_Countdown()
  local itemID = self._cpt:GetItemId()
  local tipCfg = Cfg.cfg_top_tips[itemID]
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.icon.sprite = atlas:GetSprite(tipCfg.Icon)
  self.itemName:SetText(StringTable.Get(tipCfg.Title))
  self.desText:SetText(StringTable.Get(tipCfg.Intr))
end

function UISeasonActionPointTipS8:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self._onHide then
    self._onHide()
  end
end

function UISeasonActionPointTipS8:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.itemName = self:GetUIComponent("UILocalizationText", "ItemName")
  self.countdown = self:GetGameObject("Countdown")
  self.desText = self:GetUIComponent("UILocalizationText", "DesText")
  self.time = self:GetUIComponent("UILocalizationText", "Time")
  self.root = self:GetUIComponent("RectTransform", "Root")
end

function UISeasonActionPointTipS8:BgOnClick(go)
  self:CloseDialog()
end

function UISeasonActionPointTipS8:_Countdown()
  if self._countdownStop then
    self.time:SetText("--:--:--")
    return
  end
  local now = GetSvrTimeNow()
  local time = self._targetTime - now
  local timeStr = HelperProxy:GetInstance():FormatTime(time)
  self.time:SetText(timeStr)
  if time <= 0 then
    self:StartTask(self._ReqFlush, self)
  end
end

function UISeasonActionPointTipS8:_ReqFlush(TT)
  local res = AsyncRequestRes:New()
  self._cpt:HandleActionPointData(TT, res)
  if res:GetSucc() then
    self:DispatchEvent(GameEventType.OnSeasonActionPointChanged)
  else
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    Log.error("请求刷新行动点失败:", res:GetResult())
    self:GetModule(SeasonModule):CheckSeasonClose(res)
  end
end
