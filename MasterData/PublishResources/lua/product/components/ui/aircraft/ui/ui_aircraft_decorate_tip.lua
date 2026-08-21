_class("UIAircraftDecorateTip", UIController)
UIAircraftDecorateTip = UIAircraftDecorateTip

function UIAircraftDecorateTip:OnShow(uiParams)
  GameGlobal.UIStateManager():SetDepthRaycast(self:GetDepth(), false)
  local defaultArea = uiParams[1]
  local onBack = uiParams[2]
  self:InitWidget()
  self.topButtonWidget = self.buttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    if onBack then
      onBack()
    end
    self:CloseDialog()
  end, nil, nil, true)
  self._boxes = {}
  local roomParent = self:GetUIComponent("Transform", "Room")
  for i = 1, AircraftConst.DecorateAreaCount do
    local ui = roomParent:GetChild(i - 1)
    self._boxes[i] = ui:GetComponent(typeof(UnityEngine.Animation))
  end
  self:AttachEvent(GameEventType.AircraftSelectDecorateArea, self.OnSelect)
  if defaultArea then
    self:OnSelect(defaultArea)
  end
end

function UIAircraftDecorateTip:InitWidget()
  self.buttons = self:GetUIComponent("UISelectObjectPath", "buttons")
end

function UIAircraftDecorateTip:OnSelect(area)
  if self._curArea then
    if self._curArea ~= area then
      self._boxes[self._curArea]:Play("uieff_AircraftDecorate_Tip_Close")
      self._curArea = area
      self._boxes[self._curArea]:Play("uieff_AircraftDecorate_Tip_BreathChoose")
    end
  else
    for i, anim in ipairs(self._boxes) do
      if i == area then
        anim:Play("uieff_AircraftDecorate_Tip_BreathChoose")
      else
        anim:Play("uieff_AircraftDecorate_Tip_Close")
      end
    end
    self._curArea = area
  end
end

function UIAircraftDecorateTip:OnHide()
  GameGlobal.UIStateManager():SetDepthRaycast(self:GetDepth(), true)
end
