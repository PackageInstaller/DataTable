local TemplateExclusiveItemCtrl = class("TemplateExclusiveItemCtrl", BaseCtrl)
TemplateExclusiveItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgRare = {sComponentName = "Image"},
  imgSelect = {},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  imgMask = {sComponentName = "Image"}
}
TemplateExclusiveItemCtrl._mapEventConfig = {}

function TemplateExclusiveItemCtrl:SetPerk(nTid, nStar, nMaxStar, bHas)
  local mapCfg = ConfigTable.GetData_Item(nTid)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self._mapNode.goStar:SetStar(nStar, nMaxStar)
  self._mapNode.imgSelect:SetActive(false)
  local sPath = AllEnum.FrameType_New.ExclusivePerk .. AllEnum.FrameColor_New[mapCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
  if bHas == false then
    self._mapNode.imgMask.gameObject:SetActive(true)
    self:SetAtlasSprite(self._mapNode.imgMask, "12_rare", sPath)
  else
    self._mapNode.imgMask.gameObject:SetActive(false)
  end
end

function TemplateExclusiveItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return TemplateExclusiveItemCtrl
