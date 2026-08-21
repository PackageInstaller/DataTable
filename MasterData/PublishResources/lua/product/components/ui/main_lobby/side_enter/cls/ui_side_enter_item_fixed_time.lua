require("ui_side_enter_item_base")
_class("UISideEnterItem_FixedTime", UISideEnterItem_Base)
UISideEnterItem_FixedTime = UISideEnterItem_FixedTime

function UISideEnterItem_FixedTime.CheckOpen(beginTime, endTime)
  if beginTime == nil or endTime == nil then
    Log.exception("UISideEnterItem_FixedTime.CheckOpen() time = nil", debug.traceback())
    return false
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = loginModule:GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if curTime >= beginTime and curTime < endTime then
    return true
  end
  return false
end

function UISideEnterItem_FixedTime.CheckServerTimeOpen(beginTime, endTime)
  if beginTime == nil or endTime == nil then
    Log.exception("UISideEnterItem_FixedTime.CheckOpen() time = nil", debug.traceback())
    return false
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  local endTime = loginModule:GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  if curTime >= beginTime and curTime < endTime then
    return true
  end
  return false
end

function UISideEnterItem_FixedTime:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
end

function UISideEnterItem_FixedTime:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
end

function UISideEnterItem_FixedTime:_CheckOpen(TT)
  local bg, ed = self._btnCfg.BeginTime, self._btnCfg.EndTime
  return UISideEnterItem_FixedTime.CheckOpen(bg, ed)
end

function UISideEnterItem_FixedTime:GetSideEnterRawImage()
  return self._btnCfg.SideEnterIcon
end

function UISideEnterItem_FixedTime:DoShow()
  UIWidgetHelper.SetRawImage(self, "bg", self:GetSideEnterRawImage())
end

function UISideEnterItem_FixedTime:_CalcNew()
  return false
end

function UISideEnterItem_FixedTime:_CalcRed()
  return false
end

function UISideEnterItem_FixedTime:_Refresh()
  local bg, ed = self._btnCfg.BeginTime, self._btnCfg.EndTime
  local isOpen = UISideEnterItem_FixedTime.CheckOpen(bg, ed)
  self._setShowCallback(isOpen)
  self:_CheckPoint()
end
