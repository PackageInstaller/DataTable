local FateCardBookItemCtrl = class("FateCardBookItemCtrl", BaseCtrl)
FateCardBookItemCtrl._mapNodeConfig = {
  goLock = {},
  goNormal = {},
  imgFateCard = {sComponentName = "Image"},
  txtFateCardName = {sComponentName = "TMP_Text"},
  imgCollect = {},
  imgUnCollect = {},
  imgUnlock = {},
  txtCollect = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect"
  },
  txtUnCollect = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_UnCollect"
  },
  txtUnlock = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Lock"
  },
  imgMask = {},
  redDotCard = {},
  animCard = {sNodeName = "goNormal", sComponentName = "Animator"}
}
FateCardBookItemCtrl._mapEventConfig = {}
FateCardBookItemCtrl._mapRedDotConfig = {}

function FateCardBookItemCtrl:InitItem(nId, nStatus)
  self.nId = nId
  local itemCfg = ConfigTable.GetData_Item(nId)
  local fateCardCfg = ConfigTable.GetData("FateCard", nId)
  if fateCardCfg == nil or itemCfg == nil then
    return
  end
  local fateCardBookCfg = ConfigTable.GetData("StarTowerBookFateCard", nId)
  if fateCardBookCfg == nil then
    return
  end
  local sFrame = AllEnum.FrameType_New.StarTowerFateCard .. AllEnum.FrameColor_New[itemCfg.Rarity]
  self:SetPngSprite(self._mapNode.imgFateCard, string.gsub(itemCfg.Icon, "_L_", "_S_"))
  NovaAPI.SetTMPText(self._mapNode.txtFateCardName, fateCardCfg.Name)
  self._mapNode.imgCollect.gameObject:SetActive(nStatus == AllEnum.FateCardBookStatus.Collect)
  self._mapNode.imgUnCollect.gameObject:SetActive(nStatus == AllEnum.FateCardBookStatus.UnLock)
  self._mapNode.imgUnlock.gameObject:SetActive(nStatus == AllEnum.FateCardBookStatus.Lock)
  self._mapNode.goLock.gameObject:SetActive(nStatus == AllEnum.FateCardBookStatus.Lock)
  self._mapNode.goNormal.gameObject:SetActive(nStatus ~= AllEnum.FateCardBookStatus.Lock)
  self._mapNode.imgMask.gameObject:SetActive(nStatus == AllEnum.FateCardBookStatus.UnLock)
end

function FateCardBookItemCtrl:RegisterRedDot()
  if self.nId then
    RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_FateCard_New, self.nId, self._mapNode.redDotCard)
  end
end

function FateCardBookItemCtrl:PlayClickAnim(bClick)
  if bClick then
    self._mapNode.animCard:Play("CardBookItem_in")
  else
    self._mapNode.animCard:Play("CardBookItem_out")
  end
end

return FateCardBookItemCtrl
