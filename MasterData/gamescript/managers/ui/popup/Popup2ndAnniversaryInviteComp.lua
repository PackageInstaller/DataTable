local Popup2ndAnniversaryInviteComp = System.NewClass("Popup2ndAnniversaryInviteComp", PopupBaseComp)

function Popup2ndAnniversaryInviteComp:ctor()
end

function Popup2ndAnniversaryInviteComp:OnBind(binder)
  self.binder = binder
end

function Popup2ndAnniversaryInviteComp:Clear()
end

function Popup2ndAnniversaryInviteComp:CheckPopup()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return
  end
  local targetActivityTid = DT.GetConstant("Aniversary2ndTaskActivityTid")
  if ClientDataUtils.GetData(cd.ClientDataMainKey.Aniversary2ndInviteTips, targetActivityTid) then
    return
  end
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  local displayActivityTidMap = ActivityManager.Instance.model.displayTidMap
  for activityTid, _ in pairs(displayActivityTidMap) do
    if activityTid == targetActivityTid then
      self.binder:BindTimer(0.1, 0, nil, function()
        self._safeCheckUrl = Urls.Activity2ndAnniversaryInviteView
        UIManager.Instance:Reopen(Urls.Activity2ndAnniversaryInviteView, function()
          self:SetBusy(false)
        end, true)
      end)
      self:SetBusy(true)
      return
    end
  end
end

return Popup2ndAnniversaryInviteComp
