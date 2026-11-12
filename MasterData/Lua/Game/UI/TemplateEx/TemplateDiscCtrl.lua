local TemplateDiscCtrl = class("TemplateDiscCtrl", BaseCtrl)
TemplateDiscCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgFrame = {sComponentName = "Image"},
  imgEET = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  imgDiscStar = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  redDotDisc = {}
}
TemplateDiscCtrl._mapEventConfig = {}

function TemplateDiscCtrl:Refresh(nId)
  self.nId = nId
  local mapCfg = ConfigTable.GetData("Disc", nId)
  local mapItem = ConfigTable.GetData_Item(nId)
  if not mapCfg or not mapItem then
    return
  end
  local mapData = PlayerData.Disc:GetDiscById(nId)
  self:SetPngSprite(self._mapNode.imgIcon, mapItem.Icon)
  self:SetSprite_FrameColor(self._mapNode.imgFrame, mapData.nRarity, AllEnum.FrameType_New.DiscList)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, mapData.nLevel)
  self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapData.nRarity] .. "_0" .. mapData.nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  local nStar = 6 - mapData.nRarity
  self._mapNode.goStar:SetStar(nStar, nStar)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapData.sName)
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgEET, "12_rare", sName)
  self:RegisterRedDot()
end

function TemplateDiscCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Disc_Item, self.nId, self._mapNode.redDotDisc)
end

function TemplateDiscCtrl:OnDisable()
end

return TemplateDiscCtrl
