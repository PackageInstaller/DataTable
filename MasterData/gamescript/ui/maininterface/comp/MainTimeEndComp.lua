local MainTimeEndComp, Super = System.NewComponent("MainTimeEndComp")

function MainTimeEndComp:ctor(uiNode, getTimeFunc, params)
  Super.ctor(self)
  self.ui = UI_Main_Item_Time_EndResource(uiNode)
  assert(getTimeFunc, "MainTimeEndComp have no getTimeFunc!!!")
  self.getTimeFunc = getTimeFunc
  params = params or {}
  self.noColor = params.noColor or false
  self.showOutDated = params.showOutDated or false
  self.hideSevenDays = params.hideSevenDays or params.hideSevenDays == nil
  self.isShort = params.isShort
  self.dayLessWithMinute = params.dayLessWithMinute or false
  self.onEndCallback = params.onEndCallback
end

function MainTimeEndComp:OnBind(binder)
  self.binder = binder
  self:RefreshTime()
  self.binder:BindTimer(1, -1, function()
    self:RefreshTime()
  end)
end

function MainTimeEndComp:RefreshTime()
  local timeStamp = self.getTimeFunc()
  if not self.showOutDated and timeStamp and timeStamp < TimeUtils.GetServerTime() then
    timeStamp = nil
  end
  if timeStamp then
    local leftTime = timeStamp - TimeUtils.GetServerTime()
    local days, _, _ = TimeUtils.ShopItemFormat(leftTime)
    if self.hideSevenDays and days >= 7 then
      timeStamp = nil
    end
  end
  if self._lastTimeStamp and not timeStamp and self.onEndCallback then
    self.onEndCallback()
  end
  self._lastTimeStamp = timeStamp
  self.binder:SetActive(self.ui.uiNode, timeStamp)
  if timeStamp then
    self:SetTimeColorStr(timeStamp)
  end
end

function MainTimeEndComp:SetTimeColorStr(timeStamp)
  local timeColor, timeIcon
  local timeStr = MainShopDataUtils.GetNextFreshTime(timeStamp)
  local leftTime = timeStamp - TimeUtils.GetServerTime()
  local days, _, _ = TimeUtils.ShopItemFormat(leftTime)
  if self.isShort and (not self.dayLessWithMinute or not (days < 1)) then
    local countDown = timeStamp - TimeUtils.GetServerTime()
    timeStr = TimeUtils.GetShortCountDownDisplayFormat(countDown)
  end
  if self.showOutDated and timeStamp and timeStamp < TimeUtils.GetServerTime() then
    timeColor = self.colorRed
    timeStr = LT.Text("ActivityTimeExpired")
  elseif days < 1 then
    timeColor = cd.TimeEndShowColor.Near
    timeIcon = CommonRes.HourglassIcon.Near
  elseif days < 7 then
    timeColor = cd.TimeEndShowColor.Middle
    timeIcon = CommonRes.HourglassIcon.Middle
  else
    timeColor = cd.TimeEndShowColor.Far
    timeIcon = CommonRes.HourglassIcon.Far
  end
  if self.noColor then
    timeColor = cd.TimeEndShowColor.Far
  end
  self.binder:SetText(self.ui.Text_Time, timeStr)
  self.binder:SetTextColorByHtml(self.ui.Text_Time, timeColor)
  self.binder:SetImage(self.ui.Image_HourGlass, timeIcon)
end

return MainTimeEndComp
