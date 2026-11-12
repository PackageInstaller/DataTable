local SoldierCharItemCtrl = class("SoldierCharItemCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
SoldierCharItemCtrl._mapNodeConfig = {
  img_icon = {sComponentName = "Image"},
  img_rarity = {sComponentName = "Image"},
  imgInBattle = {},
  txtInBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_InBattle"
  },
  imgMask = {},
  Star = {nCount = 5},
  StarRoot = {}
}
SoldierCharItemCtrl._mapEventConfig = {}
SoldierCharItemCtrl._mapRedDotConfig = {}

function SoldierCharItemCtrl:SetItemData(soldierCharId)
  self.soldierCharId = soldierCharId
  local soldierCharConfig = ConfigTable.GetData("SoldierCharacter", self.soldierCharId)
  if soldierCharConfig == nil then
    return
  end
  local rarity = soldierCharConfig.Rarity
  self:SetPngSprite(self._mapNode.img_rarity, RootPath .. AllEnum.SoldierChessRarityIcon[rarity] .. AllEnum.SoldierChessIconSurfix.S)
  local skinId = soldierCharConfig.Skin
  local skinConfig = ConfigTable.GetData("SoldierSkin", skinId)
  if skinConfig == nil then
    return
  end
  self:SetPngSprite(self._mapNode.img_icon, skinConfig.Icon .. AllEnum.SoldierChessIconSurfix.S)
end

function SoldierCharItemCtrl:SetItemState(bInBattle, bNotOwned)
  self._mapNode.imgInBattle:SetActive(bInBattle)
  self._mapNode.imgMask:SetActive(bNotOwned)
end

function SoldierCharItemCtrl:SetCharItemBtnFunc(callback)
  local btnChar = self.gameObject:GetComponent("UIButton")
  if btnChar == nil then
    return
  end
  btnChar.onClick:RemoveAllListeners()
  btnChar.onClick:AddListener(callback)
end

function SoldierCharItemCtrl:SetCharLevel(nLevel)
  self._mapNode.StarRoot:SetActive(0 < nLevel)
  if 0 < nLevel then
    for i = 1, 5 do
      self._mapNode.Star[i]:SetActive(i <= nLevel)
    end
  end
end

return SoldierCharItemCtrl
