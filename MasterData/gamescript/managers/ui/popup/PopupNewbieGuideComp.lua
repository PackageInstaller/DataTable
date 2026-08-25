local PopupNewbieGuideComp = System.NewClass("PopupNewbieGuideComp", PopupBaseComp)

function PopupNewbieGuideComp:ctor()
end

function PopupNewbieGuideComp:OnBind(binder)
  self.binder = binder
end

function PopupNewbieGuideComp:Clear()
end

function PopupNewbieGuideComp:CheckPopup()
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  local isPreHaveGuideStep = NewbieGuideManager.Instance:IsHaveGuideStep()
  NewbieGuideManager.Instance:SetEnabled(true, "PopupQueManager Check Guide")
  NewbieGuideManager.Instance:CheckToGuide()
  local isNowHaveGuideStep = NewbieGuideManager.Instance:IsHaveGuideStep()
  if not isPreHaveGuideStep and isNowHaveGuideStep then
    self.binder:BindTimer(0.5, 0, nil, function()
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
  if not isNowHaveGuideStep then
    NewbieGuideManager.Instance:SetEnabled(false, "PopupQueManager No Guide")
  end
end

return PopupNewbieGuideComp
