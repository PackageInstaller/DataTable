local PotentialBookItemCtrl = class("PotentialBookItemCtrl", BaseCtrl)
PotentialBookItemCtrl._mapNodeConfig = {
  goNormal = {},
  imgRare = {sComponentName = "Image"},
  goIcon = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialIconCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  goSpecial = {},
  imgSpIcon = {sComponentName = "Image"},
  txtSpName = {sComponentName = "TMP_Text"},
  imgMask = {},
  imgUnCollect = {},
  txtUnCollect = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_UnCollect"
  },
  imgCollect = {},
  txtCollect = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect"
  },
  imgCollectLevel = {},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect_Level"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  redDotCard = {},
  animCard = {sNodeName = "CardRoot", sComponentName = "Animator"}
}
PotentialBookItemCtrl._mapEventConfig = {}
PotentialBookItemCtrl._mapRedDotConfig = {}

function PotentialBookItemCtrl:InitItem(nPotentialId, nLevel)
  self.nId = nPotentialId
  local itemCfg = ConfigTable.GetData_Item(nPotentialId)
  local potentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if potentialCfg == nil or itemCfg == nil then
    return
  end
  local bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  self._mapNode.goNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goSpecial.gameObject:SetActive(bSpecial)
  if not bSpecial then
    self:SetNormalPotential(itemCfg, potentialCfg)
  else
    self:SetSpecialPotential(itemCfg, potentialCfg)
  end
  self._mapNode.imgUnCollect.gameObject:SetActive(nLevel == 0)
  self._mapNode.imgCollect.gameObject:SetActive(0 < nLevel and bSpecial)
  self._mapNode.imgCollectLevel.gameObject:SetActive(0 < nLevel and not bSpecial)
  self._mapNode.imgMask.gameObject:SetActive(nLevel == 0)
  if 0 < nLevel and not bSpecial then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
  end
end

function PotentialBookItemCtrl:SetNormalPotential(itemCfg, potentialCfg)
  local sFrame = AllEnum.FrameType_New.PotentialS .. (AllEnum.FrameColor_New[itemCfg.Rarity] + 4 | 0)
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.goIcon:SetIcon(potentialCfg.Id)
  NovaAPI.SetTMPText(self._mapNode.txtName, itemCfg.Title)
end

function PotentialBookItemCtrl:SetSpecialPotential(itemCfg, potentialCfg)
  NovaAPI.SetTMPText(self._mapNode.txtSpName, itemCfg.Title)
  self:SetPngSprite(self._mapNode.imgSpIcon, itemCfg.Icon .. AllEnum.PotentialIconSurfix.A)
end

function PotentialBookItemCtrl:RegisterRedDot()
  if self.nId ~= nil then
    RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Potential_New, self.nId, self._mapNode.redDotCard)
  end
end

function PotentialBookItemCtrl:PlayClickAnim(bClick)
  if bClick then
    self._mapNode.animCard:Play("CardBookItem_in")
  else
    self._mapNode.animCard:Play("CardBookItem_out")
  end
end

return PotentialBookItemCtrl
