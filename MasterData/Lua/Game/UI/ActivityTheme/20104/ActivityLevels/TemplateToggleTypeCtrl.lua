local TemplateToggleTypeCtrl = class("TemplateToggleTypeCtrl", BaseCtrl)
TemplateToggleTypeCtrl._mapNodeConfig = {
  AnimSwitch = {sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  Select = {},
  unSelect = {},
  lockSel = {},
  lockUnSel = {}
}
TemplateToggleTypeCtrl._mapEventConfig = {}

function TemplateToggleTypeCtrl:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function TemplateToggleTypeCtrl:SetDefaultActivity(bOn, colorSelect, colorUnSelect, isOpen)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  if colorSelect ~= nil then
    NovaAPI.SetTMPColor(self._mapNode.txt_Select, colorSelect)
    NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, colorUnSelect)
  end
  self._mapNode.txt_Select.gameObject.transform.localScale = isOpen == true and Vector3.one or Vector3.zero
  self._mapNode.txt_unSelect.gameObject.transform.localScale = isOpen == true and Vector3.one or Vector3.zero
  local imgTxtSelect = self._mapNode.Select.transform:Find("imgTxt").gameObject
  local imgTxtUnSelect = self._mapNode.unSelect.transform:Find("imgTxt").gameObject
  imgTxtSelect:SetActive(isOpen)
  imgTxtUnSelect:SetActive(isOpen)
  self._mapNode.lockSel:SetActive(not isOpen)
  self._mapNode.lockUnSel:SetActive(not isOpen)
  self._mapNode.Select:GetComponent("Image").enabled = isOpen
  self._mapNode.unSelect:GetComponent("Image").enabled = isOpen
end

function TemplateToggleTypeCtrl:SetTrigger(bOn)
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  if bOn then
    self._mapNode.AnimSwitch:SetTrigger("tOn")
  else
    self._mapNode.AnimSwitch:SetTrigger("tOff")
  end
end

return TemplateToggleTypeCtrl
