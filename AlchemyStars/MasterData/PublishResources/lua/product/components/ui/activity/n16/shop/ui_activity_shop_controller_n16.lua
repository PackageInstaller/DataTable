_class("UIActivityShopControllerN16", UIActivityShopControllerBase)
UIActivityShopControllerN16 = UIActivityShopControllerN16

function UIActivityShopControllerN16:DefaultBackFunc()
  self:SwitchState(UIStateType.UIActivityN16MainController)
end

function UIActivityShopControllerN16:_GetFormatString(stamp)
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = StringTable.Get("str_activity_n16_shop_close_at", timeStr)
  return showStr
end
