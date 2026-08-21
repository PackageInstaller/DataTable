require("ui_side_enter_item_base")
_class("UISideEnterItem_EliminateWorldBoss", UISideEnterItem_Base)
UISideEnterItem_EliminateWorldBoss = UISideEnterItem_EliminateWorldBoss

function UISideEnterItem_EliminateWorldBoss:Constructor()
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  self._newKey = "EliminateWorldBossNew_" .. pstID
end

function UISideEnterItem_EliminateWorldBoss:_CheckOpen(TT)
  return true
end

function UISideEnterItem_EliminateWorldBoss:GetSideEnterRawImage()
  return self._btnCfg.SideEnterIcon
end

function UISideEnterItem_EliminateWorldBoss:DoShow()
  self:AttachEvent(GameEventType.OnShowEliminateWorldBoss, self._CancelNew)
  self:AttachEvent(GameEventType.OnEliminateWorldBossClosed, self._OnClose)
end

function UISideEnterItem_EliminateWorldBoss:_CalcNew()
  return LocalDB.GetInt(self._newKey, 0) == 0
end

function UISideEnterItem_EliminateWorldBoss:_CalcRed()
  return false
end

function UISideEnterItem_EliminateWorldBoss:_CancelNew()
  if self:_CalcNew() then
    LocalDB.SetInt(self._newKey, 1)
    local new = self:_CalcNew()
    local red = self:_CalcRed()
    UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  end
end

function UISideEnterItem_EliminateWorldBoss:_OnClose()
  ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  self._setShowCallback(false)
end
