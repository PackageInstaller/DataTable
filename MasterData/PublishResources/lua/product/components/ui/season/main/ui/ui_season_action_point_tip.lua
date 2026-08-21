_class("UISeasonActionPointTip", UIController)
UISeasonActionPointTip = UISeasonActionPointTip

function UISeasonActionPointTip:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonActionPointTip:OnShow(uiParams)
  self:InitWidget()
  self._cpt = uiParams[1]
  local pos = uiParams[2]
  self.root.anchoredPosition = pos + Vector2(-3, 7)
  self._targetTime = self._cpt:GetRegainEndTime() + 1
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_Countdown()
  end)
  self:_Countdown()
  local itemID = self._cpt:GetItemId()
  local tipCfg = Cfg.cfg_top_tips[itemID]
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.icon.sprite = atlas:GetSprite(tipCfg.Icon)
  self.itemName:SetText(StringTable.Get(tipCfg.Title))
  self.desText:SetText(StringTable.Get(tipCfg.Intr))
end

function UISeasonActionPointTip:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UISeasonActionPointTip:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.itemName = self:GetUIComponent("UILocalizationText", "ItemName")
  self.countdown = self:GetGameObject("Countdown")
  self.desText = self:GetUIComponent("UILocalizationText", "DesText")
  self.time = self:GetUIComponent("UILocalizationText", "Time")
  self.root = self:GetUIComponent("RectTransform", "Root")
end

function UISeasonActionPointTip:BgOnClick(go)
  self:CloseDialog()
end

function UISeasonActionPointTip:_Countdown()
  local now = GetSvrTimeNow()
  local time = self._targetTime - now
  local timeStr = HelperProxy:GetInstance():FormatTime(time)
  self.time:SetText(timeStr)
  if time <= 0 then
    self:StartTask(self._ReqFlush, self)
  end
end

function UISeasonActionPointTip:_ReqFlush(TT)
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
