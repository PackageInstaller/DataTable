local SoldierStrategyCardItemCtrl = class("SoldierStrategyCardItemCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
local iconPath = "Icon/SoldierBuffCard/"
SoldierStrategyCardItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  txtName = {sComponentName = "TMP_Text"}
}
SoldierStrategyCardItemCtrl._mapEventConfig = {
  SoldierHandbookStrategyCard_Selected = "OnEvent_SoldierHandbookStrategyCard_Selected"
}
SoldierStrategyCardItemCtrl._mapRedDotConfig = {}

function SoldierStrategyCardItemCtrl:SetItemData(mapStrategyCardData, bSelected)
  self.mapStrategyCardData = mapStrategyCardData
  local rarity = self.mapStrategyCardData.Rarity
  self:SetPngSprite(self._mapNode.imgRare, RootPath .. AllEnum.SoldierStrategyCardRarityIcon[rarity] .. AllEnum.SoldierChessIconSurfix.M)
  self:SetPngSprite(self._mapNode.imgIcon, iconPath .. self.mapStrategyCardData.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapStrategyCardData.Name)
  self._mapNode.imgSelect:SetActive(bSelected)
end

function SoldierStrategyCardItemCtrl:OnEvent_SoldierHandbookStrategyCard_Selected(nStrategyCardId)
  if self.mapStrategyCardData.Id == nStrategyCardId then
    self._mapNode.imgSelect:SetActive(true)
  else
    self._mapNode.imgSelect:SetActive(false)
  end
end

return SoldierStrategyCardItemCtrl
