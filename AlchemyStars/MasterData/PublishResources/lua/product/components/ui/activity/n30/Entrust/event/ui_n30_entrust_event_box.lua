local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventBox", N30EntrustEvent, EntrustEventType.EntrustEventType_Box)

function N30EntrustEventBox:Constructor()
end

function N30EntrustEventBox:DebugName()
  return "Box"
end

function N30EntrustEventBox:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon07"
  else
    return "n30_wt_ld_icon06"
  end
end

function N30EntrustEventBox:GetWidgetName()
  return "UIN30EntrustEventBox"
end

function N30EntrustEventBox:OnArrived(ui)
  if self:IsPass() then
    ToastManager.ShowToast(StringTable.Get("str_n30_entrust_event_box_popup"))
  else
    ui:ShowDialog("UIN30EntrustEvent", self)
  end
end

_class("UIN30EntrustEventBox", UIN30EntrustEventWidget)
UIN30EntrustEventBox = UIN30EntrustEventBox

function UIN30EntrustEventBox:Constructor()
end

function UIN30EntrustEventBox:OnShow(uiParams)
  self._contentFinishReward = self:GetUIComponent("UISelectObjectPath", "contentFinishReward")
end

function UIN30EntrustEventBox:OnHide()
end

function UIN30EntrustEventBox:BtnConfirmOnClick(go)
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

function UIN30EntrustEventBox:Refresh()
  local cfg = self._event:Cfg()
  local entrustData = self._event:EntrustData()
  local rewardFinish = entrustData:EventRewardList(cfg)
  local widgetFinish = self._contentFinishReward:SpawnObjects("UIN30EntrustStageReward", #rewardFinish)
  for k, v in pairs(rewardFinish) do
    local ui = widgetFinish[k]
    ui:Flush(v)
  end
end
