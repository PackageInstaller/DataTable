local SoldierPotentialItemCtrl = class("SoldierPotentialItemCtrl", BaseCtrl)
SoldierPotentialItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  iconStar = {nCount = 4},
  goLock = {},
  iconLockStar = {nCount = 4},
  listStar = {}
}
SoldierPotentialItemCtrl._mapEventConfig = {}
SoldierPotentialItemCtrl._mapRedDotConfig = {}

function SoldierPotentialItemCtrl:SetItemData(nPotentialId, nStar)
  nStar = nStar or 0
  local potentialConfig = ConfigTable.GetData("SoldierPotential", nPotentialId)
  if potentialConfig == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgIcon, potentialConfig.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, potentialConfig.Name)
  for i = 1, 4 do
    self._mapNode.iconStar[i]:SetActive(nStar >= i)
  end
  self._mapNode.goLock:SetActive(false)
  self._mapNode.listStar:SetActive(true)
end

function SoldierPotentialItemCtrl:SetItemLockData(nPotentialId, nStar)
  nStar = nStar or 0
  local potentialConfig = ConfigTable.GetData("SoldierPotential", nPotentialId)
  if potentialConfig == nil then
    return
  end
  self._mapNode.goLock:SetActive(true)
  for i = 1, 4 do
    self._mapNode.iconLockStar[i]:SetActive(i <= nStar)
  end
  for i = 1, 4 do
    self._mapNode.iconStar[i]:SetActive(false)
  end
  self._mapNode.listStar:SetActive(false)
end

return SoldierPotentialItemCtrl
