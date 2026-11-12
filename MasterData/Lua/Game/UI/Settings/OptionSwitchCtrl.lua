local OptionSwitchCtrl = class("OptionSwitchCtrl", BaseCtrl)
OptionSwitchCtrl._mapNodeConfig = {
  txtOptionTitle = {sComponentName = "TMP_Text"},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_ON_EN"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_OFF_EN"
  }
}
OptionSwitchCtrl._mapEventConfig = {}

function OptionSwitchCtrl:SetText(sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
end

function OptionSwitchCtrl:Init(callback, bOn, sGrayText)
  self.bEnable = true
  self.bOn = bOn
  self.callback = callback
  self.sGrayText = sGrayText
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bOn)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bOn)
end

function OptionSwitchCtrl:SetEnable(bOn)
  self.bEnable = bOn
end

function OptionSwitchCtrl:SetOn(bOn)
  self.bOn = bOn
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bOn)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bOn)
end

function OptionSwitchCtrl:OnBtnClick_Switch(btn, nIndex)
  if not self.bEnable then
    if self.sGrayText ~= nil then
      EventManager.Hit(EventId.OpenMessageBox, self.sGrayText)
    end
    return
  end
  self.bOn = not self.bOn
  self.callback(self.bOn)
  self._mapNode.btnSwitch[1].gameObject:SetActive(nIndex == 2)
  self._mapNode.btnSwitch[2].gameObject:SetActive(nIndex == 1)
end

return OptionSwitchCtrl
