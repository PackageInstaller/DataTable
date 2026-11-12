local TemplateSkinCtrl = class("TemplateSkinCtrl", BaseCtrl)
TemplateSkinCtrl._mapNodeConfig = {
  imgChose = {},
  imgItemIcon = {sComponentName = "Image"},
  imgFavorite = {},
  goChoseTop = {},
  txtChooseTxt = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skin_Choose"
  },
  goLock = {},
  goAccessChannel = {},
  imgShopBg = {},
  imgActivityBg = {},
  imgAdvanceBg = {},
  txtChannel = {sComponentName = "TMP_Text"},
  imgSelect = {},
  img3D = {},
  imgCG = {},
  imgMusic = {},
  img2D = {},
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnItemClick"
  }
}
TemplateSkinCtrl._mapEventConfig = {
  [EventId.CharacterSkinChange] = "OnCharacterSkinChange"
}

function TemplateSkinCtrl:SetSkinData(skinData, bShowFavorite, bPreview)
  local skinCfg = skinData:GetCfgData()
  self.nCharId = skinData:GetCharId()
  self.nSkinId = skinData:GetId()
  self:RefreshChoseSkin()
  self._mapNode.imgSelect.gameObject:SetActive(false)
  self._mapNode.imgFavorite.gameObject:SetActive(bShowFavorite and skinData:CheckUnlock() and skinData:CheckFavorCG())
  self:SetPngSprite(self._mapNode.imgItemIcon, skinCfg.Icon .. AllEnum.CharHeadIconSurfix.SK)
  self._mapNode.goLock.gameObject:SetActive(not skinData:CheckUnlock() and not bPreview)
  self._mapNode.imgShopBg.gameObject:SetActive(skinCfg.SourceDesc == GameEnum.skinSourceType.TIMELIMIT or skinCfg.SourceDesc == GameEnum.skinSourceType.BATTLEPASS)
  self._mapNode.imgActivityBg.gameObject:SetActive(skinCfg.SourceDesc == GameEnum.skinSourceType.ACTIVITY)
  self._mapNode.imgAdvanceBg.gameObject:SetActive(skinCfg.SourceDesc == GameEnum.skinSourceType.ADVANCE)
  local sText = AllEnum.CharSkinSource[skinCfg.SourceDesc]
  if sText ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtChannel, ConfigTable.GetUIText(sText))
  end
  local tbSkinTags = skinData:GetSkinExtraTags()
  for k, v in pairs(tbSkinTags) do
    if v == GameEnum.skinExtraTag.MODEL then
      self._mapNode.img3D:SetActive(true)
    elseif v == GameEnum.skinExtraTag.IMAGE then
      self._mapNode.imgCG:SetActive(true)
    elseif v == GameEnum.skinExtraTag.MUSIC then
      self._mapNode.imgMusic:SetActive(true)
    elseif v == GameEnum.skinExtraTag.TWOD then
      self._mapNode.img2D:SetActive(true)
    end
  end
end

function TemplateSkinCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function TemplateSkinCtrl:RefreshChoseSkin(usingSkinId)
  if nil == usingSkinId then
    usingSkinId = PlayerData.Char:GetCharUsedSkinId(self.nCharId)
  end
  self._mapNode.imgChose.gameObject:SetActive(self.nSkinId == usingSkinId)
  self._mapNode.goChoseTop.gameObject:SetActive(self.nSkinId == usingSkinId)
end

function TemplateSkinCtrl:OnCharacterSkinChange()
  self:RefreshChoseSkin()
end

function TemplateSkinCtrl:OnBtnItemClick()
end

return TemplateSkinCtrl
