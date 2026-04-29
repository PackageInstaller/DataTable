_class("UIN26MovieItem", UICustomWidget)
UIN26MovieItem = UIN26MovieItem

function UIN26MovieItem:Constructor()
  self._assestData = nil
end

function UIN26MovieItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN26MovieItem:OnHide()
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIN26MovieItem:InitWidget()
  self._countDownObj = self:GetGameObject("countDown")
  self._countDownText = self:GetUIComponent("UILocalizationText", "countDownText")
  self._unlockObj = self:GetGameObject("unlock")
  self._unlockText = self:GetUIComponent("UILocalizationText", "unlockText")
  self._lockObj = self:GetGameObject("lock")
  self._filmItem = self:GetUIComponent("RawImageLoader", "filmItem")
  self._unlockText:SetText(StringTable.Get("str_movie_item_text_1"))
end

function UIN26MovieItem:SetData(data)
  self._assestData = data
  self:InitData()
  self:_SetTimer()
end

function UIN26MovieItem:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    local str = self:_SetTimeStr()
    if str then
      self._countDownText:SetText(str)
    else
      self._lockObj:SetActive(false)
      self._unlockObj:SetActive(true)
      self._countDownObj:SetActive(false)
    end
  end)
end

function UIN26MovieItem:_SetTimeStr()
  local id = self._assestData.anonymousId
  self._movieDataHelper = MovieDataHelper:New()
  local countdown = self._movieDataHelper:GetAnonymousCountdownTimeById(id)
  if countdown < 0 then
    return nil
  else
    local str = self._movieDataHelper:GetFormatTimerStr(countdown)
    return str
  end
end

function UIN26MovieItem:SetLock(isShow)
  self._lockObj:SetActive(isShow)
end

function UIN26MovieItem:InitData()
  self._filmItem:LoadImage(self._assestData.icon)
end

function UIN26MovieItem:FilmItemOnClick(go)
  local itemId = self._assestData.item
  if itemId then
    self:ShowDialog("UIItemTipsHomeland", itemId, go)
  else
    Log.fatal("未配置剧本物品item信息")
  end
end
