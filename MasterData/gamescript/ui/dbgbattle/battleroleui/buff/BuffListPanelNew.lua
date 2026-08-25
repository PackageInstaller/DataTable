local BuffListPanelNew, Super = System.NewClass("BuffListPanelNew", UIBasePanel)
BuffListPanelNew.uiResCls = UI_Battle_Popup_AffixInfoResource

function BuffListPanelNew:ctor(descGroup)
  Super.ctor(self)
  self.descGroup = descGroup
end

function BuffListPanelNew:OnBind(binder)
  binder:BindComponent(CommonEffectDescGroup(self.ui.CardKeyWordItem_New, self.descGroup))
  binder:BindButtonClick(self.ui.Mask, function()
    self:Close()
  end)
  local oldPos = self.ui.uiNode.transform.localPosition
  self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(9999, 9999, 9999)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      self.ui.uiNode.transform.localPosition = oldPos
    end
  end)
end

return BuffListPanelNew
