local TemplateDropdownCtrl = class("TemplateDropdownCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
TemplateDropdownCtrl._mapNodeConfig = {
  imgUp = {},
  imgDown = {},
  Dropdown = {
    sComponentName = "TMP_Dropdown",
    callback = "OnDD_Select"
  }
}
TemplateDropdownCtrl._mapEventConfig = {
  DropdownOpenState = "OnEvent_Open"
}

function TemplateDropdownCtrl:SetList(tbLanguageId, nDefualtValue, bText)
  self._mapNode.Dropdown:ClearOptions()
  local List_String = CS.System.Collections.Generic.List(CS.System.String)
  local lst = List_String()
  for _, value in pairs(tbLanguageId) do
    if not bText then
      lst:Add(ConfigTable.GetUIText(value))
    else
      lst:Add(value)
    end
  end
  self._mapNode.Dropdown:AddOptions(lst)
  self._mapNode.Dropdown.value = nDefualtValue or 0
end

function TemplateDropdownCtrl:GetValue()
  return self._mapNode.Dropdown.value
end

function TemplateDropdownCtrl:Awake()
  self._mapNode.imgUp:SetActive(true)
  self._mapNode.imgDown:SetActive(false)
end

function TemplateDropdownCtrl:OnEvent_Open(bOpen)
  self._mapNode.imgUp:SetActive(not bOpen)
  self._mapNode.imgDown:SetActive(bOpen)
  local sSound = bOpen and "ui_common_menu_open" or "ui_common_menu_close"
  CS.WwiseAudioManager.Instance:PlaySound(sSound)
end

function TemplateDropdownCtrl:OnDD_Select(dd)
  EventManager.Hit("SelectTemplateDD", self._mapNode.Dropdown.value)
end

return TemplateDropdownCtrl
