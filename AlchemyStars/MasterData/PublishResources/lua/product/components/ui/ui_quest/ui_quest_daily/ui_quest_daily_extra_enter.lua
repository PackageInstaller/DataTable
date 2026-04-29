require("ui_side_enter_item_base")
_class("UIQuestDailyExtraEnter", UISideEnterItem_Base)
UIQuestDailyExtraEnter = UIQuestDailyExtraEnter

function UIQuestDailyExtraEnter.GetOpenCfg()
  local cfgs = Cfg.cfg_quest_daily_extra_activity()
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    local st, ed = cfg.StartTime, cfg.EndTime
    local isOpen = UISideEnterItem_FixedTime.CheckOpen(st, ed)
    if isOpen then
      return cfg
    end
  end
end

function UIQuestDailyExtraEnter:OnShow()
end

function UIQuestDailyExtraEnter:OnHide()
end

function UIQuestDailyExtraEnter:_CheckOpen(TT)
  self._cfg = UIQuestDailyExtraEnter.GetOpenCfg()
  if not self._cfg then
    Log.fatal("###[UIQuestDailyExtraEnter] cfg is nil ! id --> ", 1)
    return false
  end
  return true
end

function UIQuestDailyExtraEnter:GetSideEnterRawImage()
  return self._cfg.MainSideIcon
end

function UIQuestDailyExtraEnter:DoShow()
  UIWidgetHelper.SetLocalizationText(self, "title", StringTable.Get(self._cfg.MainSideStr))
  UIWidgetHelper.SetRawImage(self, "bg", self:GetSideEnterRawImage())
end

function UIQuestDailyExtraEnter:_CalcNew()
  return false
end

function UIQuestDailyExtraEnter:_CalcRed()
  return false
end

function UIQuestDailyExtraEnter:BtnOnClick(go)
  if UIQuestDailyExtraEnter.GetOpenCfg() then
    self:ShowDialog("UIQuestDailyExtraInfoController")
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
end
