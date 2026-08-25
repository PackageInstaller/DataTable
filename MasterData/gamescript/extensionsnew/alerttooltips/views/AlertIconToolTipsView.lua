local AlertIconToolTipsView, Super = NewClass("AlertIconToolTipsView", BaseView)
AlertIconToolTipsView.uiResCls = UI_Common_Popup_Tips_6Resource

function AlertIconToolTipsView:ctor(data, rootGameObject, isSchoolEffectTip)
  Super.ctor(self)
  self.data = data
  self.rootGameObject = rootGameObject
  self.isSchoolEffectTip = isSchoolEffectTip
end

function AlertIconToolTipsView:OnBuildView()
  self:SetActive(self.ui.Text_Desc_2, false)
  self:SetActive(self.ui.Text_Level, false)
  self:SetActive(self.ui.DescView, false)
  self:_SetTipsContent()
end

function AlertIconToolTipsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function AlertIconToolTipsView:OnEnterView()
  Super.OnEnterView(self)
  local canvasGroup = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 0
  self:SetActive(self.ui.uiNode, false)
  self.transform = self.ui.uiNode.transform
  self:SetActive(self.ui.uiNode, true)
  self:BindTimer(0.02, 0, nil, function()
    AlertToolTipsUtils.AdjustDescLayout(self.ui.Text_Desc_1, self.ui.Text_Desc, self.ui.DescView, self.ui.Group_Tip.transform)
  end)
  self:_ResetPos()
  self:BindTimer(0.02, 0, nil, function()
    canvasGroup.alpha = 1
  end)
end

function AlertIconToolTipsView:SetRendered(isRendered)
  Super.SetRendered(self, isRendered)
  if self.transform and isRendered then
    self:_ResetPos()
  end
end

function AlertIconToolTipsView:_SetTipsContent()
  self:SetText(self.ui.Text_Count, AlertToolTipsUtils.GetOwnText(self.data))
  self:SetText(self.ui.Text_Title, AlertToolTipsUtils.GetTitle(self.data))
  self:SetText(self.ui.Text_Desc_1, AlertToolTipsUtils.GetDesc(self.data))
  self:SetText(self.ui.Text_Desc, AlertToolTipsUtils.GetDesc(self.data))
  self:SetImage(self.ui.Icon_Article, AlertToolTipsUtils.GetIcon(self.data))
  self:SetImage(self.ui.Icon_Article_2, AlertToolTipsUtils.GetIcon(self.data))
  self:SetActive(self.ui.Group_Article, not self.isSchoolEffectTip)
  self:SetActive(self.ui.Group_Article2, self.isSchoolEffectTip)
end

function AlertIconToolTipsView:_ResetPos()
  if not self.isSchoolEffectTip then
    if self.data.worldPos then
      self:_AdjustByWorldPosition()
    else
      self:_AdjustPosition()
    end
  else
    self.ui.uiNode.transform.anchoredPosition = AlertToolTipsUtils.GetRootPosition(self.rootGameObject)
  end
end

function AlertIconToolTipsView:_AdjustPosition()
  AlertToolTipsUtils.AdjustIconPosition(self.transform, self.rootGameObject, self.ui.uiNode.transform)
end

function AlertIconToolTipsView:_AdjustByWorldPosition()
  AlertToolTipsUtils.AdjustByWorldPosition(self.transform, self.data and self.data.worldPos)
end

return AlertIconToolTipsView
