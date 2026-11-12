local TowerDefensePotentialIconCtrl = class("TowerDefensePotentialIconCtrl", BaseCtrl)
TowerDefensePotentialIconCtrl._mapNodeConfig = {
  imgIcon = {nCount = 3, sComponentName = "Image"}
}
TowerDefensePotentialIconCtrl._mapEventConfig = {}
TowerDefensePotentialIconCtrl._mapRedDotConfig = {}

function TowerDefensePotentialIconCtrl:SetIcon(nId)
  local potentialCfg = ConfigTable.GetData("TowerDefensePotential", nId)
  if nil == potentialCfg then
    return
  end
  local _, color = ColorUtility.TryParseHtmlString(AllEnum.PotentialRarityCfg[potentialCfg.Rarity].sColor)
  self._mapNode.imgIcon[1].gameObject:SetActive(false)
  self._mapNode.imgIcon[2].gameObject:SetActive(false)
  self:SetPngSprite(self._mapNode.imgIcon[3], potentialCfg.Icon .. AllEnum.PotentialIconSurfix.A)
end

return TowerDefensePotentialIconCtrl
