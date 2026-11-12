local CharAttrDetailPropertyCtrl = class("CharAttrDetailPropertyCtrl", BaseCtrl)
CharAttrDetailPropertyCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtProperty = {sComponentName = "TMP_Text"},
  txtValue1 = {sComponentName = "TMP_Text"},
  txtValue2 = {sComponentName = "TMP_Text"},
  btnTip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tip"
  }
}
CharAttrDetailPropertyCtrl._mapEventConfig = {}

function CharAttrDetailPropertyCtrl:SetProperty(mapCharAttr, mapAttrData, bMain, bSimple)
  self._mapNode.imgIcon.gameObject:SetActive(bMain)
  local mapAttributeDesc = self:_GetAttributeDesc(mapCharAttr.sKey)
  if not mapAttributeDesc then
    return
  end
  local sValue, sValueAdd = "", ""
  local nBaseValue = mapAttrData.baseValue
  local nAddValue = mapAttrData.totalValue - mapAttrData.baseValue
  sValue = self:_TransValueFormat(nBaseValue, mapCharAttr.bPercent, mapAttributeDesc.Format)
  sValueAdd = self:_TransValueFormat(nAddValue, mapCharAttr.bPercent, mapAttributeDesc.Format, true)
  if nAddValue <= 0.01 then
    sValueAdd = ""
  end
  if bSimple then
    self:_RefreshContent(mapAttributeDesc.Icon, ConfigTable.GetUIText(mapCharAttr.sLanguageId_Simple), sValue, sValueAdd, mapAttributeDesc.WordID)
  else
    self:_RefreshContent(mapAttributeDesc.Icon, mapAttributeDesc.Desc, sValue, sValueAdd, mapAttributeDesc.WordID)
  end
end

function CharAttrDetailPropertyCtrl:_GetAttributeDesc(sKey)
  local mapAttributeDesc = CacheTable.GetData("_AttributeDesc", sKey)
  if mapAttributeDesc == nil then
    printError("EffectType未配置：" .. sKey)
    self:_RefreshContent(nil, "", "")
    return false
  else
    return mapAttributeDesc
  end
end

function CharAttrDetailPropertyCtrl:_RefreshContent(sIcon, sName, sValue1, sValue2, nWord)
  if sIcon and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.imgIcon, sIcon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtProperty, sName)
  if sValue2 and sValue2 ~= "" then
    self._mapNode.txtValue2.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtValue1, sValue1)
    NovaAPI.SetTMPText(self._mapNode.txtValue2, sValue2)
  else
    NovaAPI.SetTMPText(self._mapNode.txtValue1, sValue1)
    self._mapNode.txtValue2.gameObject:SetActive(false)
  end
  if nWord and nWord ~= 0 then
    self._mapNode.btnTip.gameObject:SetActive(true)
    self.sWord = tostring(nWord)
  else
    self._mapNode.btnTip.gameObject:SetActive(false)
  end
end

function CharAttrDetailPropertyCtrl:_TransValueFormat(nValue, bPercent, nFormat, bAdd)
  if bPercent then
    nValue = nValue / 100
  end
  local sValue = FormatEffectValue(nValue, bPercent, nFormat)
  if bAdd then
    sValue = "+" .. sValue
  end
  return sValue
end

function CharAttrDetailPropertyCtrl:OnBtnClick_Tip(btn)
  UTILS.ClickWordLink(btn, self.sWord)
end

return CharAttrDetailPropertyCtrl
