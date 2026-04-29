local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventStart", N30EntrustEvent, EntrustEventType.EntrustEventType_Start)

function N30EntrustEventStart:Constructor()
end

function N30EntrustEventStart:DebugName()
  return "Start"
end

function N30EntrustEventStart:GetIconBgName()
  return "n30_wt_ld_ico001"
end

function N30EntrustEventStart:GetIconName()
  if self._isPass then
    return "n30_wt_ld_ico01"
  else
    return "n30_wt_ld_ico01"
  end
end

function N30EntrustEventStart:GetWidgetName()
  return nil
end

function N30EntrustEventStart:OnArrived(ui)
  return nil
end
