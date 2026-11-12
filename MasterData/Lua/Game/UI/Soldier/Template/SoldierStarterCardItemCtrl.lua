local SoldierStarterCardItemCtrl = class("SoldierStarterCardItemCtrl", BaseCtrl)
local RootPath = "Icon/SoldierBuffCard/"
SoldierStarterCardItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  txtName = {sComponentName = "TMP_Text"}
}
SoldierStarterCardItemCtrl._mapEventConfig = {
  SoldierHandbookStarterCard_Selected = "OnEvent_SoldierHandbookStarterCard_Selected"
}
SoldierStarterCardItemCtrl._mapRedDotConfig = {}

function SoldierStarterCardItemCtrl:SetItemData(mapStarterCardData, bSelected)
  self.mapStarterCardData = mapStarterCardData
  local starterCardConfig = ConfigTable.GetData("SoldierStarterCard", mapStarterCardData.Id)
  if starterCardConfig == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgIcon, RootPath .. starterCardConfig.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, starterCardConfig.Name)
  self._mapNode.imgSelect:SetActive(false)
  self._mapNode.imgSelect:SetActive(bSelected)
end

function SoldierStarterCardItemCtrl:OnEvent_SoldierHandbookStarterCard_Selected(nStarterCardId)
  if self.mapStarterCardData.Id == nStarterCardId then
    self._mapNode.imgSelect:SetActive(true)
  else
    self._mapNode.imgSelect:SetActive(false)
  end
end

return SoldierStarterCardItemCtrl
