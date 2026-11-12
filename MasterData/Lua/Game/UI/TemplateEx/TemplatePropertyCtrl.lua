local TemplatePropertyCtrl = class("TemplatePropertyCtrl", BaseCtrl)
local ValueColor = {
  up = Color(0.5490196078431373, 0.6745098039215687, 0.34901960784313724, 1),
  down = Color(0.3764705882352941, 0.6901960784313725, 0.050980392156862744, 1),
  black = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764, 1)
}
TemplatePropertyCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtProperty = {sComponentName = "TMP_Text"},
  txtValue1 = {sComponentName = "TMP_Text"},
  imgUp = {},
  imgDown = {},
  txtValue2 = {sComponentName = "TMP_Text"}
}
TemplatePropertyCtrl._mapEventConfig = {}

function TemplatePropertyCtrl:SetItemProperty(sKey, nValue, nValueAfter, bAdditionDesc)
  local mapAttributeDesc = self:_GetAttributeDesc(sKey)
  if not mapAttributeDesc then
    return
  end
  NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.black)
  self._mapNode.imgUp:SetActive(false)
  self._mapNode.imgDown:SetActive(false)
  local sValue, sValueAfter = "", ""
  sValue = self:_TransValueFormat(nValue, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
  if nValueAfter then
    sValueAfter = self:_TransValueFormat(nValueAfter, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
    if nValueAfter < nValue then
      NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.down)
      self._mapNode.imgDown:SetActive(true)
    elseif nValue < nValueAfter then
      NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.up)
      self._mapNode.imgUp:SetActive(true)
    end
  end
  if bAdditionDesc then
    self:_RefreshContent(mapAttributeDesc.Icon, mapAttributeDesc.RandomAttrDesc, sValue, sValueAfter)
  else
    self:_RefreshContent(mapAttributeDesc.Icon, mapAttributeDesc.Desc, sValue, sValueAfter)
  end
end

function TemplatePropertyCtrl:SetCharProperty(mapCharAttr, mapAttrData, bSimple, nMaxVal)
  local mapAttributeDesc = self:_GetAttributeDesc(mapCharAttr.sKey)
  if not mapAttributeDesc then
    return
  end
  local sValue, sValueAdd = "", ""
  if bSimple then
    sValue = self:_TransValueFormat(mapAttrData.totalValue, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
    self:_RefreshContent(mapAttributeDesc.Icon, ConfigTable.GetUIText(mapCharAttr.sLanguageId_Simple), sValue)
  else
    local nBaseValue = mapAttrData.baseValue
    local nAddValue = mapAttrData.totalValue - mapAttrData.baseValue
    sValue = self:_TransValueFormat(nBaseValue, mapCharAttr.bPercent, mapAttributeDesc.Format)
    sValueAdd = self:_TransValueFormat(nAddValue, mapCharAttr.bPercent, mapAttributeDesc.Format, true)
    if nAddValue <= 0 then
      sValueAdd = ""
    end
    self:_RefreshContent(mapAttributeDesc.Icon, mapAttributeDesc.Desc, sValue, sValueAdd)
  end
  if nMaxVal and nMaxVal ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtValue2, NovaAPI.GetTMPText(self._mapNode.txtValue2) .. "/" .. nMaxVal)
  end
end

function TemplatePropertyCtrl:SetNote(nNoteId, nLevel1, nLevel2, bShowArrow)
  self._mapNode.imgUp:SetActive(false)
  self._mapNode.imgDown:SetActive(false)
  self:SetPngSprite(self._mapNode.imgIcon, "Icon/ZZZOther/icon_common_chainfo_note")
  local mapNote = ConfigTable.GetData("SubNoteSkill", nNoteId)
  if mapNote then
    NovaAPI.SetTMPText(self._mapNode.txtProperty, orderedFormat(ConfigTable.GetUIText("Disc_Advance_NoteSkill_UpDesc"), mapNote.Name))
  end
  if nLevel2 then
    self._mapNode.txtValue1.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtValue1, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLevel1))
    NovaAPI.SetTMPText(self._mapNode.txtValue2, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLevel2))
    NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.up)
    if bShowArrow then
      self._mapNode.imgUp:SetActive(true)
    end
  else
    NovaAPI.SetTMPText(self._mapNode.txtValue2, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLevel1))
    NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.black)
    self._mapNode.txtValue1.gameObject:SetActive(false)
  end
end

function TemplatePropertyCtrl:SetSoldierAttr(mapAttrData)
  local mapAttributeDesc = self:_GetAttributeDesc(mapAttrData.sKey)
  if not mapAttributeDesc then
    return
  end
  local sValue = self:_TransValueFormat(mapAttrData.nValue, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
  if mapAttrData.sLanguageId ~= nil then
    self:_RefreshContent(mapAttributeDesc.Icon, ConfigTable.GetUIText(mapAttrData.sLanguageId), sValue)
  else
    self:_RefreshContent(mapAttributeDesc.Icon, mapAttributeDesc.Desc, sValue)
  end
end

function TemplatePropertyCtrl:_GetAttributeDesc(sKey)
  local mapAttributeDesc = CacheTable.GetData("_AttributeDesc", sKey)
  if mapAttributeDesc == nil then
    printError("EffectType未配置：" .. sKey)
    self:_RefreshContent(nil, "", "")
    return false
  else
    return mapAttributeDesc
  end
end

function TemplatePropertyCtrl:_RefreshContent(sIcon, sName, sValue1, sValue2)
  if sIcon then
    self:SetPngSprite(self._mapNode.imgIcon, sIcon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtProperty, sName)
  if sValue2 and sValue2 ~= "" then
    self._mapNode.txtValue1.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtValue1, sValue1)
    NovaAPI.SetTMPText(self._mapNode.txtValue2, sValue2)
  else
    NovaAPI.SetTMPText(self._mapNode.txtValue2, sValue1)
    NovaAPI.SetTMPColor(self._mapNode.txtValue2, ValueColor.black)
    self._mapNode.txtValue1.gameObject:SetActive(false)
  end
end

function TemplatePropertyCtrl:_TransValueFormat(nValue, bPercent, nFormat, bAdd)
  if bPercent then
    nValue = nValue / 100
  end
  local sValue = FormatEffectValue(nValue, bPercent, nFormat)
  if bAdd then
    sValue = "+" .. sValue
  end
  return sValue
end

return TemplatePropertyCtrl
