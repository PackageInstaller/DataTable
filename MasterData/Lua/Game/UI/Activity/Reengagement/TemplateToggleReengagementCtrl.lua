local TemplateToggleReengagementCtrl = class("TemplateToggleReengagementCtrl", BaseCtrl)
TemplateToggleReengagementCtrl._mapNodeConfig = {
  AnimSwitch = {sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  Select = {},
  unSelect = {},
  reddotTog = {}
}
TemplateToggleReengagementCtrl._mapEventConfig = {}

function TemplateToggleReengagementCtrl:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function TemplateToggleReengagementCtrl:SetDefault(bOn)
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

function TemplateToggleReengagementCtrl:SetDefaultDorm(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
end

function TemplateToggleReengagementCtrl:SetDefaultAct10101(bOn)
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

function TemplateToggleReengagementCtrl:SetDefaultActivity(bOn, colorSelect, colorUnSelect)
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
end

function TemplateToggleReengagementCtrl:SetTrigger(bOn)
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  if bOn then
    self._mapNode.AnimSwitch:SetTrigger("tOn")
  else
    self._mapNode.AnimSwitch:SetTrigger("tOff")
  end
end

function TemplateToggleReengagementCtrl:ResetTrigger()
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  self._mapNode.AnimSwitch:ResetTrigger("tOff")
end

function TemplateToggleReengagementCtrl:SetReddot(sKey, param)
  self:UnRegisterReddot()
  if sKey == nil then
    return
  end
  self.sReddotKey = sKey
  self.mapReddotParam = param
  RedDotManager.RegisterNode(sKey, param, self._mapNode.reddotTog)
end

function TemplateToggleReengagementCtrl:UnRegisterReddot()
  if self.sReddotKey ~= nil then
    RedDotManager.UnRegisterNode(self.sReddotKey, self.mapReddotParam, self._mapNode.reddotTog)
  end
  self.sReddotKey = nil
  self.mapReddotParam = nil
end

function TemplateToggleReengagementCtrl:OnEnable()
  self._mapNode.reddotTog:SetActive(false)
end

return TemplateToggleReengagementCtrl
