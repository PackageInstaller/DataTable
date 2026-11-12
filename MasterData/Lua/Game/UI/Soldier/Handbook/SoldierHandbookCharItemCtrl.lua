local SoldierHandbookCharItemCtrl = class("SoldierHandbookCharItemCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
SoldierHandbookCharItemCtrl._mapNodeConfig = {
  imgSelect = {},
  imageRarity = {sComponentName = "Image"},
  imageIcon = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"}
}
SoldierHandbookCharItemCtrl._mapEventConfig = {
  SoldierHandbookChar_Selected = "OnEvent_SoldierHandbookChar_Selected"
}
SoldierHandbookCharItemCtrl._mapRedDotConfig = {}

function SoldierHandbookCharItemCtrl:Awake()
end

function SoldierHandbookCharItemCtrl:SetItemData(mapCharData, bSelect)
  self.mapCharData = mapCharData
  local skinData = ConfigTable.GetData("SoldierSkin", mapCharData.Skin)
  if skinData == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imageIcon, skinData.Icon .. AllEnum.SoldierChessIconSurfix.M)
  NovaAPI.SetTMPText(self._mapNode.txtCharName, skinData.Name)
  self:SetPngSprite(self._mapNode.imageRarity, RootPath .. AllEnum.SoldierChessRarityIcon[mapCharData.Rarity] .. AllEnum.SoldierChessIconSurfix.L)
  self._mapNode.imgSelect.gameObject:SetActive(bSelect)
end

function SoldierHandbookCharItemCtrl:OnEvent_SoldierHandbookChar_Selected(nCharId)
  if self.mapCharData.Id == nCharId then
    self._mapNode.imgSelect.gameObject:SetActive(true)
  else
    self._mapNode.imgSelect.gameObject:SetActive(false)
  end
end

return SoldierHandbookCharItemCtrl
