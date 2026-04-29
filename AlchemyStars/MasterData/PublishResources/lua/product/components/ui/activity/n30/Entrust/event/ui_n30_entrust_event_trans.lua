local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventTrans", N30EntrustEvent, EntrustEventType.EntrustEventType_Transfer)

function N30EntrustEventTrans:Constructor()
end

function N30EntrustEventTrans:DebugName()
  return "Trans"
end

function N30EntrustEventTrans:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon11"
  else
    return "n30_wt_ld_icon11"
  end
end

function N30EntrustEventTrans:GetWidgetName()
  return "UIN30EntrustEventTrans"
end

function N30EntrustEventTrans:OnArrived(ui)
  if self:IsPass() then
    ui:CallUIMethod("UIN30EntrustLine", "OnEventTrans", self)
  else
    ui:ShowDialog("UIN30EntrustEvent", self)
  end
end

_class("UIN30EntrustEventTrans", UIN30EntrustEventWidget)
UIN30EntrustEventTrans = UIN30EntrustEventTrans

function UIN30EntrustEventTrans:Constructor()
end

function UIN30EntrustEventTrans:OnShow(uiParams)
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UIN30EntrustEventTrans:OnHide()
end

function UIN30EntrustEventTrans:BtnExitOnClick(go)
  self:RootUIOwner():CloseDialogAnimation()
end

function UIN30EntrustEventTrans:BtnConfirmOnClick(go)
  self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", self._event:ID(), function()
    local cfg = self._event:Cfg()
    self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", cfg.TargetID, function()
      self:RootUIOwner():CloseDialogAnimation(function()
        self:CallUIMethod("UIN30EntrustLine", "OnEventFinish", {
          self._event:ID(),
          cfg.TargetID
        })
      end)
    end)
  end)
end

function UIN30EntrustEventTrans:Refresh()
  local descValue = self._event:ParamDesc()
  if descValue == nil then
    descValue = ""
  else
    descValue = StringTable.Get(descValue)
  end
  self._txtDesc:SetText(descValue)
end
