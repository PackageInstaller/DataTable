require("ui_side_enter_item_base")
_class("UISideEnterItem_EventTrailer", UISideEnterItem_Base)
UISideEnterItem_EventTrailer = UISideEnterItem_EventTrailer

function UISideEnterItem_EventTrailer:Constructor()
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  self._newKey = "UISideEnterItem_EventTrailer_New" .. pstID
end

function UISideEnterItem_EventTrailer:_CheckOpen(TT)
  return true
end

function UISideEnterItem_EventTrailer:GetSideEnterRawImage()
  return self._btnCfg.SideEnterIcon
end

function UISideEnterItem_EventTrailer:DoShow()
  self:AttachEvent(GameEventType.OnShowEliminateWorldBoss, self._CancelNew)
  self:AttachEvent(GameEventType.OnEliminateWorldBossClosed, self._OnClose)
end

function UISideEnterItem_EventTrailer:_CalcNew()
  return LocalDB.GetInt(self._newKey, 0) == 0
end

function UISideEnterItem_EventTrailer:_CalcRed()
  return false
end

function UISideEnterItem_EventTrailer:_CancelNew()
  if self:_CalcNew() then
    LocalDB.SetInt(self._newKey, 1)
    local new = self:_CalcNew()
    local red = self:_CalcRed()
    UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  end
end

function UISideEnterItem_EventTrailer:_OnClose()
  ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  self._setShowCallback(false)
end
