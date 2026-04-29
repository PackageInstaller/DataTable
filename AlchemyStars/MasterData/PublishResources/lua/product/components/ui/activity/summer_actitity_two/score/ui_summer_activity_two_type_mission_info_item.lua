_class("UISummerActivityTwoTypeMissionInfoItem", UICustomWidget)
UISummerActivityTwoTypeMissionInfoItem = UISummerActivityTwoTypeMissionInfoItem

function UISummerActivityTwoTypeMissionInfoItem:OnShow()
  self._yieldGapTime = 30
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "UISummerActivityTwoTypeMisisonInfoItem")
end

function UISummerActivityTwoTypeMissionInfoItem:Refresh(idx, typeMissionData, itemIcon)
  local score = typeMissionData:GetMaxScore()
  local name = typeMissionData:GetName()
  self._nameLabel:SetText(name)
  self._scoreLabel:SetText(score)
  self._icon:LoadImage(itemIcon)
  local yieldTime = (idx - 1) * self._yieldGapTime
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._anim:Play("uieff_Summer2_Score_InfoItem_In")
  end)
end

function UISummerActivityTwoTypeMissionInfoItem:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UISummerActivityTwoTypeMissionInfoItem:SetVisible(isVisible)
  self._go:SetActive(isVisible)
end
