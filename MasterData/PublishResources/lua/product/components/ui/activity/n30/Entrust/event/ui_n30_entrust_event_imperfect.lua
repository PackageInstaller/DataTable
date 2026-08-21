local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventImperfect", N30EntrustEvent, EntrustEventType.EntrustEventType_Invalid)

function N30EntrustEventImperfect:Constructor()
end

function N30EntrustEventImperfect:DebugName()
  return "Imperfect"
end

function N30EntrustEventImperfect:GetWidgetName()
  return "UIN30EntrustEventImperfect"
end

_class("UIN30EntrustEventImperfect", UIN30EntrustEventWidget)
UIN30EntrustEventImperfect = UIN30EntrustEventImperfect

function UIN30EntrustEventImperfect:Constructor()
end

function UIN30EntrustEventImperfect:ShowClose()
  return true
end

function UIN30EntrustEventImperfect:GetTitle()
  return StringTable.Get("str_n30_entrust_finish_title")
end

function UIN30EntrustEventImperfect:OnShow(uiParams)
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UIN30EntrustEventImperfect:OnHide()
end

function UIN30EntrustEventImperfect:BtnExitOnClick(go)
  self:SwitchState(UIStateType.UIN30Entrust)
end

function UIN30EntrustEventImperfect:BtnConfirmOnClick(go)
  self:RootUIOwner():CloseDialogAnimation()
end

function UIN30EntrustEventImperfect:Refresh()
  local node = self._event:Node()
  local value = node:GetExplor() * 100
  local strExplor = string.format("<color=#f9f16e>%d%%%%</color>", math.floor(value))
  self._txtDesc:SetText(StringTable.Get("str_n30_entrust_finish_popup", strExplor))
end
