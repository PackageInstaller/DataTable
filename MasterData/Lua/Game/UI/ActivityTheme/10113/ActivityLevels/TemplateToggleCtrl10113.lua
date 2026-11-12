local TemplateToggleCtrl10113 = class("TemplateToggleCtrl10113", BaseCtrl)
TemplateToggleCtrl10113._mapNodeConfig = {
  AnimSwitch = {sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  Select = {},
  unSelect = {}
}
TemplateToggleCtrl10113._mapEventConfig = {}

function TemplateToggleCtrl10113:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function TemplateToggleCtrl10113:SetDefault(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  NovaAPI.SetTMPColor(self._mapNode.txt_Select, White_Normal)
  NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, Blue_Normal)
end

function TemplateToggleCtrl10113:SetDefaultAct10101(bOn)
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

function TemplateToggleCtrl10113:SetDefaultActivity(bOn, colorSelect, colorUnSelect)
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
  self._mapNode.unSelect.transform:Find("SelectAni").gameObject:SetActive(false)
  if bOn then
    self._mapNode.AnimSwitch:Play("togType_in")
  else
    self._mapNode.AnimSwitch.enabled = false
    self._mapNode.AnimSwitch.enabled = true
  end
  if colorSelect ~= nil then
    NovaAPI.SetTMPColor(self._mapNode.txt_Select, colorSelect)
    NovaAPI.SetTMPColor(self._mapNode.txt_unSelect, colorUnSelect)
  end
end

function TemplateToggleCtrl10113:SetTrigger(bOn)
end

function TemplateToggleCtrl10113:ResetTrigger()
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  self._mapNode.AnimSwitch:ResetTrigger("tOff")
end

return TemplateToggleCtrl10113
