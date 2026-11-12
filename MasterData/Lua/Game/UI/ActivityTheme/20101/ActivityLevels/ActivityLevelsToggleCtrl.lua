local ActivityLevelsToggleCtrl = class("ActivityLevelsToggleCtrl", BaseCtrl)
ActivityLevelsToggleCtrl._mapNodeConfig = {
  AnimSwitch = {sNodeName = "Select", sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  Select = {},
  unSelect = {},
  txt_SelectCount = {sComponentName = "TMP_Text"},
  txt_unSelectCount = {sComponentName = "TMP_Text"},
  lock = {},
  lockSelect = {}
}
ActivityLevelsToggleCtrl._mapEventConfig = {}

function ActivityLevelsToggleCtrl:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function ActivityLevelsToggleCtrl:SetCount(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_SelectCount, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelectCount, sText)
end

function ActivityLevelsToggleCtrl:SetTogIsOpen(isOpen)
  self._mapNode.Select.transform:Find("countBg").gameObject:SetActive(isOpen)
  self._mapNode.unSelect.transform:Find("countBg").gameObject:SetActive(isOpen)
end

function ActivityLevelsToggleCtrl:ShowTogLock(isShowLock, isShowLockSelect)
  self._mapNode.lock:SetActive(isShowLock)
  self._mapNode.lockSelect:SetActive(isShowLockSelect)
end

function ActivityLevelsToggleCtrl:SetDefaultActivity(bOn)
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
end

function ActivityLevelsToggleCtrl:SetTrigger(bOn)
end

return ActivityLevelsToggleCtrl
