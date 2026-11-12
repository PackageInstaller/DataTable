local SoldierCharCardShopPartnerItemCtrl = class("SoldierCharCardShopPartnerItemCtrl", BaseCtrl)
SoldierCharCardShopPartnerItemCtrl._mapNodeConfig = {
  txtPartnerName = {sComponentName = "TMP_Text"},
  imgPartnerIcon = {sComponentName = "Image"}
}
SoldierCharCardShopPartnerItemCtrl._mapEventConfig = {}
SoldierCharCardShopPartnerItemCtrl._mapRedDotConfig = {}

function SoldierCharCardShopPartnerItemCtrl:Awake()
  self._tbTimer = {}
end

function SoldierCharCardShopPartnerItemCtrl:OnRefresh(mapGroup)
  if mapGroup == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtPartnerName, mapGroup.Name or "")
  self:SetPngSprite(self._mapNode.imgPartnerIcon, "Icon/SoldierPartner/" .. mapGroup.Icon .. AllEnum.SoldierChessIconSurfix.M)
end

return SoldierCharCardShopPartnerItemCtrl
