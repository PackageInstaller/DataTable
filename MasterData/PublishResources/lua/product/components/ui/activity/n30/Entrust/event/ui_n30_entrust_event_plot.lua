local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventPlot", N30EntrustEvent, EntrustEventType.EntrustEventType_Story)

function N30EntrustEventPlot:Constructor()
end

function N30EntrustEventPlot:DebugName()
  return "Plot"
end

function N30EntrustEventPlot:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon04"
  else
    return "n30_wt_ld_icon03"
  end
end

function N30EntrustEventPlot:GetWidgetName()
  return "UIN30EntrustEventPlot"
end

_class("UIN30EntrustEventPlot", UIN30EntrustEventWidget)
UIN30EntrustEventPlot = UIN30EntrustEventPlot

function UIN30EntrustEventPlot:Constructor()
end

function UIN30EntrustEventPlot:OnShow(uiParams)
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtConfirm = self:GetUIComponent("UILocalizationText", "txtConfirm")
end

function UIN30EntrustEventPlot:OnHide()
end

function UIN30EntrustEventPlot:BtnConfirmOnClick(go)
  if self._event:IsPass() then
    self:ShowDialog("UIStoryController", self._event:ParamStoryID(), function()
      self:RootUIOwner():CloseDialog()
    end)
  else
    self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", self._event:ID(), function()
      self:ShowDialog("UIStoryController", self._event:ParamStoryID(), function()
        self:RootUIOwner():CloseDialog()
        self:CallUIMethod("UIN30EntrustLine", "OnEventFinish", {
          self._event:ID()
        })
      end)
    end)
  end
end

function UIN30EntrustEventPlot:GetIcon()
  return "n30_wt_playicon"
end

function UIN30EntrustEventPlot:Refresh()
  local txtKey
  if self._event:IsPass() then
    txtKey = "str_n30_entrust_event_plot_again_btn"
  else
    txtKey = "str_n30_entrust_event_plot_btn"
  end
  self._txtConfirm:SetText(StringTable.Get(txtKey))
  local descKey = self._event:ParamDesc()
  if descKey ~= nil then
    self._txtDesc.gameObject:SetActive(true)
    self._txtDesc:SetText(StringTable.Get(descKey))
  else
    self._txtDesc.gameObject:SetActive(false)
  end
end
