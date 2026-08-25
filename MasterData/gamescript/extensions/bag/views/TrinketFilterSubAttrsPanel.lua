local TrinketFilterSubAttrsPanel, Super = System.NewClass("TrinketFilterSubAttrsPanel", TrinketFilterAttrsPanel)
local TrinketFilterState = CommonDefine.TrinketFilterState

function TrinketFilterSubAttrsPanel:ctor(filterSubAttrs, callabck)
  Super.ctor(self)
  self.selectAttrsId = table.clone(filterSubAttrs)
  self.selectStatus = {}
  for k, v in pairs(self.selectAttrsId) do
    if v == TrinketFilterState.FilterInclude then
      self.selectStatus[k] = {HaveOn = true, NoOn = false}
    elseif v == TrinketFilterState.FilterExclude then
      self.selectStatus[k] = {HaveOn = false, NoOn = true}
    else
      self.selectStatus[k] = {HaveOn = false, NoOn = false}
    end
  end
  self.callabck = callabck
end

function TrinketFilterSubAttrsPanel:_GetTitle()
  do return LT.Text end
  return LT.Text, "SelectTrinketSubAttr"
end

function TrinketFilterSubAttrsPanel:_FillCellToggles(uiRes, attrId)
  local isNoOn = self.selectStatus[attrId].NoOn
  local isHaveOn = self.selectStatus[attrId].HaveOn
  local toggleHaveComp = uiRes.Toggle_Have:GetComponent(typeof(CS.Z1Client.Z1Toggle))
  toggleHaveComp.onValueChanged:RemoveAllListeners()
  toggleHaveComp.isOn = isHaveOn and not isNoOn
  toggleHaveComp.onValueChanged:AddListener(function(isOn)
    self.selectStatus[attrId].HaveOn = isOn
    if isOn then
      self.selectStatus[attrId].NoOn = false
    end
    self.tableview:Refresh()
  end)
  local toggleNoComp = uiRes.Toggle_Not:GetComponent(typeof(CS.Z1Client.Z1Toggle))
  toggleNoComp.onValueChanged:RemoveAllListeners()
  toggleNoComp.isOn = isNoOn and not isHaveOn
  toggleNoComp.onValueChanged:AddListener(function(isOn)
    self.selectStatus[attrId].NoOn = isOn
    if isOn then
      self.selectStatus[attrId].HaveOn = false
    end
    self.tableview:Refresh()
  end)
end

function TrinketFilterSubAttrsPanel:SelectAttr(attrId, state)
  self.selectAttrsId[attrId] = state
end

function TrinketFilterSubAttrsPanel:OnClickConfirm()
  local callabck = self.callabck
  for k, v in pairs(self.selectStatus) do
    if v.HaveOn then
      self:SelectAttr(k, TrinketFilterState.FilterInclude)
    elseif v.NoOn then
      self:SelectAttr(k, TrinketFilterState.FilterExclude)
    else
      self:SelectAttr(k, TrinketFilterState.FilterDefault)
    end
  end
  self:Close()
  callabck(self.selectAttrsId)
end

return TrinketFilterSubAttrsPanel
