_class("UICN13PerfectPuzzleIntroItem", UICustomWidget)
UICN13PerfectPuzzleIntroItem = UICN13PerfectPuzzleIntroItem

function UICN13PerfectPuzzleIntroItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN13PerfectPuzzleIntroItem:InitWidget()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UICN13PerfectPuzzleIntroItem:SetData()
end
