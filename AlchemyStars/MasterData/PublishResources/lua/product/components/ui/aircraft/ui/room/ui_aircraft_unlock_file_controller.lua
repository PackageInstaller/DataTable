_class("UIAircraftUnlockFileController", UIController)
UIAircraftUnlockFileController = UIAircraftUnlockFileController

function UIAircraftUnlockFileController:OnShow(uiParams)
  self:InitWidget()
  self._title:SetText(uiParams[1])
  self._title_en:SetText(uiParams[2])
  self._autoHide = uiParams[3]
  if self._autoHide then
    GameGlobal.Timer():AddEvent(2600, function()
      self:CloseDialog()
    end)
  end
end

function UIAircraftUnlockFileController:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._title_en = self:GetUIComponent("UILocalizationText", "title_en")
end
