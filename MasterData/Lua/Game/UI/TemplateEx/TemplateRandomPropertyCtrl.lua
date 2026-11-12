local TemplateRandomPropertyCtrl = class("TemplateRandomPropertyCtrl", BaseCtrl)
local ValueColor = {
  up = Color(0.5490196078431373, 0.6745098039215687, 0.34901960784313724, 1),
  down = Color(0.3764705882352941, 0.6901960784313725, 0.050980392156862744, 1),
  black = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764, 1)
}
TemplateRandomPropertyCtrl._mapNodeConfig = {
  imgBg = {sComponentName = "Image"},
  imgUp = {},
  txtTag = {sComponentName = "TMP_Text"},
  txtProperty = {sComponentName = "TMP_Text"},
  txtPropertyValue = {sComponentName = "TMP_Text"},
  txtPropertyValueBefore = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtProperty",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  }
}
TemplateRandomPropertyCtrl._mapEventConfig = {}

function TemplateRandomPropertyCtrl:SetProperty(nAttrId, nCharId, bLock, nAddCount, bShowBefore)
  self.nCharId = nCharId
  self.mapCfg = nil
  if nAddCount and 0 < nAddCount then
    local mapCfg = ConfigTable.GetData("CharGemAttrValue", nAttrId)
    if mapCfg then
      local nId = mapCfg.TypeId * 100 + nAddCount + mapCfg.Level
      self.mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
    end
  else
    self.mapCfg = ConfigTable.GetData("CharGemAttrValue", nAttrId)
  end
  if not self.mapCfg then
    return
  end
  local mapAttributeDesc = self:_GetAttributeDesc()
  if not mapAttributeDesc then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtTag, ConfigTable.GetUIText("Equipment_AttrTag_" .. self.mapCfg.Tag))
  local sValue = ""
  sValue = self:_TransValueFormat(tonumber(self.mapCfg.Value), mapAttributeDesc.isPercent, mapAttributeDesc.Format, self.mapCfg.Tag ~= GameEnum.CharGemAttrTag.ATTR)
  NovaAPI.SetTMPText(self._mapNode.txtProperty, UTILS.SubDesc(mapAttributeDesc.RandomAttrDesc, nil, nil, {nCharId = nCharId}))
  NovaAPI.SetTMPText(self._mapNode.txtPropertyValue, sValue)
  NovaAPI.SetTMPColor(self._mapNode.txtPropertyValue, ValueColor.black)
  self:SetAttrLock(bLock)
  self._mapNode.imgUp:SetActive(nAddCount and 0 < nAddCount)
  self._mapNode.txtPropertyValueBefore.gameObject:SetActive(false)
  if bShowBefore then
    local mapBeforeCfg = ConfigTable.GetData("CharGemAttrValue", nAttrId)
    if nAddCount and 1 < nAddCount then
      local nId = self.mapCfg.TypeId * 100 + self.mapCfg.Level - 1
      mapBeforeCfg = ConfigTable.GetData("CharGemAttrValue", nId)
    end
    if mapBeforeCfg then
      self._mapNode.txtPropertyValueBefore.gameObject:SetActive(true)
      local sValue = ""
      sValue = self:_TransValueFormat(tonumber(mapBeforeCfg.Value), mapAttributeDesc.isPercent, mapAttributeDesc.Format, self.mapCfg.Tag ~= GameEnum.CharGemAttrTag.ATTR)
      NovaAPI.SetTMPText(self._mapNode.txtPropertyValueBefore, sValue)
      NovaAPI.SetTMPColor(self._mapNode.txtPropertyValue, ValueColor.up)
    end
  end
end

function TemplateRandomPropertyCtrl:PlayUpgradeAni(nAttrId, nCharId, bLock, nAddCount)
  self.gameObject.transform:Find("AnimRoot"):GetComponent("Animator"):Play("tc_random_property_1_in", 0, 0)
  self:AddTimer(1, 0.1, function()
    self:SetProperty(nAttrId, nCharId, bLock, nAddCount, true)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
end

function TemplateRandomPropertyCtrl:SetAttrLock(bLock)
  if bLock then
    self:SetSprite_FrameColor(self._mapNode.imgBg, self.mapCfg.Rarity, AllEnum.FrameType_New.RandomPropertyLock)
  else
    self:SetSprite_FrameColor(self._mapNode.imgBg, self.mapCfg.Rarity, AllEnum.FrameType_New.RandomProperty)
  end
end

function TemplateRandomPropertyCtrl:_GetAttributeDesc()
  local attrType = self.mapCfg.AttrType
  local attrSubType1 = self.mapCfg.AttrTypeFirstSubtype
  local attrSubType2 = self.mapCfg.AttrTypeSecondSubtype
  local nEffectDescId = self:GetEffectDescId(attrType, attrSubType1, attrSubType2)
  local mapAttributeDesc = ConfigTable.GetData("EffectDesc", nEffectDescId)
  if mapAttributeDesc == nil then
    printError("找不到EffectDesc对应配置，id = " .. nEffectDescId)
    return false
  else
    return mapAttributeDesc
  end
end

function TemplateRandomPropertyCtrl:_TransValueFormat(nValue, bPercent, nFormat, bAdd)
  local sValue = ""
  if bAdd then
    sValue = orderedFormat(ConfigTable.GetUIText("Equipment_AttrDesc_PlusLevel"), nValue)
  else
    sValue = FormatEffectValue(nValue, bPercent, nFormat)
  end
  return sValue
end

function TemplateRandomPropertyCtrl:GetEffectDescId(attrType, attrSubType1, attrSubType2)
  return attrType * 10000 + attrSubType1 * 10 + attrSubType2
end

function TemplateRandomPropertyCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId, {
    nCharId = self.nCharId,
    nLevel = 1,
    nAddLv = tonumber(self.mapCfg.Value)
  })
end

return TemplateRandomPropertyCtrl
