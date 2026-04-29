_class("UICN20N49SweepConditionTips", UIController)
UICN20N49SweepConditionTips = UICN20N49SweepConditionTips

function UICN20N49SweepConditionTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
end

function UICN20N49SweepConditionTips:bgOnClick()
  self:CloseDialog()
end
