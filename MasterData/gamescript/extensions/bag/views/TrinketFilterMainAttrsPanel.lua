local TrinketFilterMainAttrsPanel, Super = System.NewClass("TrinketFilterMainAttrsPanel", TrinketFilterAttrsPanel)
local TrinketFilterState = CommonDefine.TrinketFilterState

function TrinketFilterMainAttrsPanel:ctor(filterMainAttrs, callabck)
  Super.ctor(self)
  self.selectAttrsId = table.clone(filterMainAttrs)
  self.callabck = callabck
end

function TrinketFilterMainAttrsPanel:_GetTitle()
  do return LT.Text end
  return LT.Text, "SelectTrinketMainAttr"
end

function TrinketFilterMainAttrsPanel:_FillCellToggles(uiRes, attrId)
  local isSelected = self.selectAttrsId[attrId] == TrinketFilterState.FilterInclude
  uiRes.Toggle_Have:SetActive(false)
  uiRes.Text_C_Have:SetActive(false)
  uiRes.Text_C_Not:SetActive(false)
  local toggleNoComp = uiRes.Toggle_Not:GetComponent(typeof(CS.Z1Client.Z1Toggle))
  toggleNoComp.onValueChanged:RemoveAllListeners()
  toggleNoComp.isOn = isSelected
  toggleNoComp.onValueChanged:AddListener(function(isOn)
    self:SelectAttr(attrId, isOn)
    self.tableview:Refresh()
  end)
end

function TrinketFilterMainAttrsPanel:OnClickConfirm()
  local callabck = self.callabck
  self:Close()
  callabck(self.selectAttrsId)
end

return TrinketFilterMainAttrsPanel
