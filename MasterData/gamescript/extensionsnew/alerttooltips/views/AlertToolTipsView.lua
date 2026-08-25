local AlertToolTipsView, Super = NewClass("AlertToolTipsView", BaseView)
AlertToolTipsView.uiResCls = UI_Common_Popup_Tips_5Resource

function AlertToolTipsView:ctor(data, rootGameObject)
  Super.ctor(self)
  self.data = data
  self.rootGameObject = rootGameObject
end

function AlertToolTipsView:OnBuildView()
  self.canvasGroup = self.ui.Image_Bg:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  self.canvasGroup.alpha = 0
  self:SetActive(self.ui.uiNode, false)
  self:_SetTitleAndDesc()
end

function AlertToolTipsView:RegisterEvents()
  self:_BindOutSideClick()
end

function AlertToolTipsView:OnEnterView()
  Super.OnEnterView(self)
  self.transform = self.ui.ScrollView.transform
  self:SetActive(self.ui.uiNode, true)
  self:BindTimer(0.01, 0, nil, function()
    self.canvasGroup.alpha = 1
    StrUtils.SetPreferredHeight(self.ui.Text_Copywriting)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Image_Bg)
    if self.data.worldPos then
      self:_AdjustByWorldPosition()
    else
      self:_AdjustPosition()
    end
  end)
end

function AlertToolTipsView:_SetTitleAndDesc()
  local title = AlertToolTipsUtils.GetTitle(self.data)
  self:SetText(self.ui.Text_Title, title)
  self:SetActive(self.ui.Text_Title, not string.isempty(title))
  self:SetText(self.ui.Text_Copywriting, AlertToolTipsUtils.GetDesc(self.data))
end

function AlertToolTipsView:_BindOutSideClick()
  self:AddUICustomInputlistener(self.ui.Image_Bg, function(hover)
    if not hover then
      self:Close()
    end
  end)
end

function AlertToolTipsView:_AdjustPosition()
  AlertToolTipsUtils.AdjustPosition(self.transform, self.rootGameObject, self.ui.Image_Bg:GetComponent(typeof(CS.UnityEngine.RectTransform)), self.ui.ScrollView, self.ui.Content and self.ui.Content.transform)
end

function AlertToolTipsView:_AdjustByWorldPosition()
  AlertToolTipsUtils.AdjustByWorldPosition(self.transform, self.data and self.data.worldPos)
end

return AlertToolTipsView
