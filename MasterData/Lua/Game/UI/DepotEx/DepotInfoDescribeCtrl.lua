local DepotInfoDescribeCtrl = class("DepotInfoDescribeCtrl", BaseCtrl)
DepotInfoDescribeCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Info_Describe"
  },
  txtDesc = {sComponentName = "TMP_Text"}
}
DepotInfoDescribeCtrl._mapEventConfig = {}

function DepotInfoDescribeCtrl:SetDesc(nId)
  if ConfigTable.GetData_Item(nId).Desc and ConfigTable.GetData_Item(nId).Desc ~= "" then
    if ConfigTable.GetData_Item(nId).Literary and ConfigTable.GetData_Item(nId).Literary ~= "" then
      NovaAPI.SetTMPText(self._mapNode.txtDesc, ConfigTable.GetData_Item(nId).Desc .. [[

<color=#5E89B4>]] .. ConfigTable.GetData_Item(nId).Literary .. "</color>")
    else
      NovaAPI.SetTMPText(self._mapNode.txtDesc, ConfigTable.GetData_Item(nId).Desc)
    end
  elseif ConfigTable.GetData_Item(nId).Literary and ConfigTable.GetData_Item(nId).Literary ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtDesc, ConfigTable.GetData_Item(nId).Literary)
  else
    NovaAPI.SetTMPText(self._mapNode.txtDesc, "")
  end
end

return DepotInfoDescribeCtrl
