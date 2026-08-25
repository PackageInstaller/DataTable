local typeof = _ENV.typeof
local TrinketAutoRefineSuccessView, Super = NewClass("TrinketAutoRefineSuccessView", BaseView)
TrinketAutoRefineSuccessView.uiResCls = UI_Common_Popup_Tip_5Resource

function TrinketAutoRefineSuccessView:ctor(title, desc)
  Super.ctor(self)
  self._titleText = title
  self._descText = desc
end

function TrinketAutoRefineSuccessView:OnBuildView()
  self._uiRoot = UI_Common_Popup_Tip_2Resource(self.ui.UI_Common_Popup_Tip_2)
end

function TrinketAutoRefineSuccessView:RegisterNotifications()
end

function TrinketAutoRefineSuccessView:RegisterEvents()
end

function TrinketAutoRefineSuccessView:OnEnterView()
  Super.OnEnterView(self)
  local animController = self._uiRoot.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  animController:PlayState("UI_Common_Popup_Tip_2_OpenLong", function()
    self:Close()
  end)
  self:SetText(self._uiRoot.Text_Title, self._titleText)
  self:SetText(self._uiRoot.Text_Title_fangda, self._titleText)
  self:SetText(self._uiRoot.Text_Title_Eng, self._descText)
end

function TrinketAutoRefineSuccessView:OnExitView()
  Super.OnExitView(self)
end

return TrinketAutoRefineSuccessView
