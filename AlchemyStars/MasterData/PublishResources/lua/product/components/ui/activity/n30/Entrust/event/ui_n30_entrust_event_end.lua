local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventEnd", N30EntrustEvent, EntrustEventType.EntrustEventType_End)

function N30EntrustEventEnd:Constructor()
end

function N30EntrustEventEnd:DebugName()
  return "End"
end

function N30EntrustEventEnd:GetIconBgName()
  return "n30_wt_ld_ico002"
end

function N30EntrustEventEnd:GetIconName()
  if self._isPass then
    return "n30_wt_ld_ico02"
  else
    return "n30_wt_ld_ico02"
  end
end

function N30EntrustEventEnd:GetWidgetName()
  return "UIN30EntrustEventEnd"
end

function N30EntrustEventEnd:OnArrived(ui)
  if not self:IsPass() then
    ui:ShowDialog("UIN30EntrustEvent", self)
  end
end

_class("UIN30EntrustEventEnd", UIN30EntrustEventWidget)
UIN30EntrustEventEnd = UIN30EntrustEventEnd

function UIN30EntrustEventEnd:Constructor()
end

function UIN30EntrustEventEnd:GetTitle()
  return StringTable.Get("str_n30_entrust_event_end_title")
end

function UIN30EntrustEventEnd:OnShow(uiParams)
  self._contentFinishReward = self:GetUIComponent("UISelectObjectPath", "contentFinishReward")
end

function UIN30EntrustEventEnd:OnHide()
end

function UIN30EntrustEventEnd:BtnConfirmOnClick(go)
  self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", self._event:ID(), function()
    self:RootUIOwner():CloseDialogAnimation(function()
      local entrustData = self._event:EntrustData()
      local rewards = entrustData:EventRewardList(self._event:Cfg())
      self:ShowDialog("UIGetItemController", rewards, function()
        self:CallUIMethod("UIN30EntrustLine", "OnEventFinish", {
          self._event:ID()
        })
      end)
    end)
  end)
end

function UIN30EntrustEventEnd:Refresh()
  local cfg = self._event:Cfg()
  local entrustData = self._event:EntrustData()
  local rewardFinish = entrustData:EventRewardList(cfg)
  local widgetFinish = self._contentFinishReward:SpawnObjects("UIN30EntrustStageReward", #rewardFinish)
  for k, v in pairs(rewardFinish) do
    local ui = widgetFinish[k]
    ui:Flush(v)
  end
end
