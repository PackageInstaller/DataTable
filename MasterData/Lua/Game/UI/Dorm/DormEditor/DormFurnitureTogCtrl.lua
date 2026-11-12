local DormFurnitureTogCtrl = class("DormFurnitureTogCtrl", BaseCtrl)
DormFurnitureTogCtrl._mapNodeConfig = {
  AnimSwitch = {sComponentName = "Animator"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  imgIcon_Slc = {sComponentName = "Image"},
  imgIcon_UnSlc = {sComponentName = "Image"},
  Select = {},
  unSelect = {}
}
DormFurnitureTogCtrl._mapEventConfig = {}

function DormFurnitureTogCtrl:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txt_Select, sText)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, sText)
end

function DormFurnitureTogCtrl:SetIconSel(sPath)
  self:SetSprite(self._mapNode.imgIcon_Slc, sPath)
end

function DormFurnitureTogCtrl:SetIconUnSel(sPath)
  self:SetSprite(self._mapNode.imgIcon_UnSlc, sPath)
end

function DormFurnitureTogCtrl:SetDefault(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
end

function DormFurnitureTogCtrl:SetDefaultDorm(bOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  self._mapNode.Select:SetActive(bOn)
  self._mapNode.unSelect:SetActive(not bOn)
  self._mapNode.txt_Select.gameObject:SetActive(bOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not bOn)
end

function DormFurnitureTogCtrl:SetTrigger(bOn)
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  if bOn then
    self._mapNode.AnimSwitch:SetTrigger("tOn")
  else
    self._mapNode.AnimSwitch:SetTrigger("tOff")
  end
end

function DormFurnitureTogCtrl:ResetTrigger()
  if self._mapNode.AnimSwitch.enabled == false then
    self._mapNode.AnimSwitch.enabled = true
  end
  self._mapNode.AnimSwitch:ResetTrigger("tOff")
end

return DormFurnitureTogCtrl
