require("ui_side_enter_item_base")
_class("UIVigorousRewardEnter", UISideEnterItem_Base)
UIVigorousRewardEnter = UIVigorousRewardEnter

function UIVigorousRewardEnter.GetOpenCfg()
  local cfgs = Cfg.cfg_quest_daily_extra_activity()
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    local st, ed = cfg.StartTime, cfg.EndTime
    if cfg.TimeTransform == 0 then
      local isOpen = UISideEnterItem_FixedTime.CheckOpen(st, ed)
      if isOpen then
        return cfg
      end
    elseif cfg.TimeTransform == 1 then
      local isOpen = UISideEnterItem_FixedTime.CheckServerTimeOpen(st, ed)
      if isOpen then
        return cfg
      end
    end
  end
end

function UIVigorousRewardEnter:OnShow()
end

function UIVigorousRewardEnter:OnHide()
  self:_DetachEvents()
end

function UIVigorousRewardEnter:_CheckOpen(TT)
  self._cfg = UIVigorousRewardEnter.GetOpenCfg()
  local functionId = 14
  local functionLockCfg = Cfg.cfg_module_unlock[functionId]
  if not functionLockCfg then
    Log.debug("don't have function config")
    return false
  end
  local module = GameGlobal.GetModule(RoleModule)
  local ispass = module:CheckModuleUnlock(functionId)
  if not self._cfg or not ispass then
    Log.fatal("###[UIVigorousRewardEnter] cfg is nil ! id --> ", 1)
    return false
  end
  return true
end

function UIVigorousRewardEnter:GetSideEnterRawImage()
  return self._cfg.MainSideIcon
end

function UIVigorousRewardEnter:DoShow()
  UIWidgetHelper.SetLocalizationText(self, "title", StringTable.Get(self._cfg.MainSideStr))
  UIWidgetHelper.SetRawImage(self, "bg", self:GetSideEnterRawImage())
  self:_AttachEvents()
  self:_CheckNew()
end

function UIVigorousRewardEnter:_CalcNew()
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  return LocalDB.GetInt("UIVigorousRewardEnter_New" .. pstID, 0) == 0 and 1 or 0
end

function UIVigorousRewardEnter:_AttachEvents()
  self:AttachEvent(GameEventType.SideEnterTabRefresh, self._CheckNew)
end

function UIVigorousRewardEnter:_DetachEvents()
  self:DetachEvent(GameEventType.SideEnterTabRefresh, self._CheckNew)
end

function UIVigorousRewardEnter:_CalcRed()
  return false
end

function UIVigorousRewardEnter:_CheckNew()
  UIWidgetHelper.SetNewAndReds(self, self:_CalcNew(), self:_CalcRed(), "_new", "red")
  self:_Refresh()
end

function UIVigorousRewardEnter:_Refresh()
  local isOpen = self:_CheckOpen()
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    self._setShowCallback(isOpen)
  end
end
