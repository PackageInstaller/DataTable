_class("UICN20N49TreeInfoDesc", UICustomWidget)
UICN20N49TreeInfoDesc = UICN20N49TreeInfoDesc

function UICN20N49TreeInfoDesc:OnShow()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UICN20N49TreeInfoDesc:SetData(desc)
  self._desc:SetText(desc)
end
