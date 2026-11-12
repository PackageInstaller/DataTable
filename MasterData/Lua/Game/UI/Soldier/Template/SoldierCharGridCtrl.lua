local SoldierCharGridCtrl = class("SoldierCharGridCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
SoldierCharGridCtrl._mapNodeConfig = {
  img_rarity = {sComponentName = "Image"},
  img_icon = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  imgInBattle = {},
  imgMask = {},
  txtInBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_InBattle"
  },
  StarRoot = {},
  Star = {nCount = 5}
}
SoldierCharGridCtrl._mapEventConfig = {}
SoldierCharGridCtrl._mapRedDotConfig = {}

function SoldierCharGridCtrl:SetItem(nRarity, nCount, sIcon, nStar, bMask, bInBattle)
  self:SetPngSprite(self._mapNode.img_rarity, RootPath .. AllEnum.SoldierChessRarityIcon[nRarity] .. AllEnum.SoldierChessIconSurfix.S)
  if sIcon ~= nil and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.img_icon, sIcon)
  end
  if 0 < nCount then
    self._mapNode.txtCount.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
  else
    self._mapNode.txtCount.gameObject:SetActive(false)
  end
  self._mapNode.imgInBattle:SetActive(bInBattle)
  self._mapNode.imgMask:SetActive(bMask)
  if nStar ~= nil and 0 < nStar then
    self._mapNode.StarRoot.gameObject:SetActive(true)
    for i = 1, #self._mapNode.Star do
      local star = self._mapNode.Star[i]
      star.gameObject:SetActive(nStar >= i)
    end
  else
    self._mapNode.StarRoot.gameObject:SetActive(false)
  end
end

return SoldierCharGridCtrl
