local TemplateToggleCtrl10112 = class("TemplateToggleCtrl10112", BaseCtrl)
TemplateToggleCtrl10112._mapNodeConfig = {
  AnimSwitch = {sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  Select = {},
  unSelect = {},
  SelectLine = {}
}
TemplateToggleCtrl10112._mapEventConfig = {}

function TemplateToggleCtrl10112:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function TemplateToggleCtrl10112:SetDefault(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.SelectLine:SetActive(bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  NovaAPI.SetTMPColor(self._mapNode.txt_Select, White_Normal)
  NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, Blue_Normal)
end

function TemplateToggleCtrl10112:SetDefaultAct10101(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  NovaAPI.SetTMPColor(self._mapNode.txt_Select, Color(1, 1, 1, 1))
  NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, Color(0.2196078431372549, 0.1803921568627451, 0.1450980392156863, 1))
end

function TemplateToggleCtrl10112:SetDefaultActivity(bOn, colorSelect, colorUnSelect)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.SelectLine:SetActive(bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  if colorSelect ~= nil then
    NovaAPI.SetTMPColor(self._mapNode.txt_Select, colorSelect)
    NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, colorUnSelect)
  end
end

function TemplateToggleCtrl10112:SetTrigger(bOn)
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  if bOn then
    self._mapNode.AnimSwitch:SetTrigger("tOn")
  else
    self._mapNode.AnimSwitch:SetTrigger("tOff")
  end
end

function TemplateToggleCtrl10112:ResetTrigger()
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  self._mapNode.AnimSwitch:ResetTrigger("tOff")
end

return TemplateToggleCtrl10112
