local TemplateDiscPreviewItemCtrl = class("TemplateDiscPreviewItemCtrl", BaseCtrl)
TemplateDiscPreviewItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  imgDiscStar = {sComponentName = "Image"},
  txtDiscHas = {sComponentName = "TMP_Text", sLanguageId = "Disc_Has"},
  goHas = {},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  Select = {},
  imgEET = {sComponentName = "Image"},
  imgRareBg = {sComponentName = "Image"}
}
TemplateDiscPreviewItemCtrl._mapEventConfig = {}

function TemplateDiscPreviewItemCtrl:Refresh(nId, nLevel)
  local mapCfg = ConfigTable.GetData("Disc", nId)
  local mapItem = ConfigTable.GetData_Item(nId)
  if not mapCfg or not mapItem then
    return
  end
  self:SetAtlasSprite(self._mapNode.imgRareBg, "12_rare", AllEnum.FrameType_New.DiscFrameS .. AllEnum.FrameColor_New[mapItem.Rarity])
  local nStar = 6 - mapItem.Rarity
  self._mapNode.goStar:SetStar(nStar, nStar)
  self:SetPngSprite(self._mapNode.imgIcon, mapItem.Icon .. AllEnum.OutfitIconSurfix.OutInfo)
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgEET, "12_rare", sName)
  self._mapNode.txtLevel.gameObject:SetActive(nLevel)
  if nLevel then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
  end
  local mapData = PlayerData.Disc:GetDiscById(nId)
  self._mapNode.goHas:SetActive(mapData)
  if mapData then
    self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapData.nRarity] .. "_0" .. mapData.nStar + 1)
    NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  end
end

function TemplateDiscPreviewItemCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

function TemplateDiscPreviewItemCtrl:Awake()
  self._mapNode.Select:SetActive(false)
end

return TemplateDiscPreviewItemCtrl
