local PotentialListItemCtrl = class("PotentialListItemCtrl", BaseCtrl)
PotentialListItemCtrl._mapNodeConfig = {
  txtCharName = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtAll = {sComponentName = "TMP_Text"},
  imgHead = {sComponentName = "Image"},
  imgHeadFrame = {sComponentName = "Image"},
  rtPotential = {
    sComponentName = "RectTransform"
  }
}
PotentialListItemCtrl._mapEventConfig = {}
PotentialListItemCtrl._mapRedDotConfig = {}

function PotentialListItemCtrl:Awake()
  self.tbItemGrid = {}
  delChildren(self._mapNode.rtPotential)
end

function PotentialListItemCtrl:OnDisable()
  for k, v in ipairs(self.tbItemGrid) do
    local go = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(go)
    self.tbItemGrid[k] = nil
  end
  self.tbItemGrid = {}
end

function PotentialListItemCtrl:GetAllPotentialCount(nCharId, bMain)
  local nAllCount = 0
  local charPotentialCfg = ConfigTable.GetData("CharPotential", nCharId)
  for _, v in ipairs(charPotentialCfg.CommonPotentialIds) do
    nAllCount = nAllCount + 1
  end
  if bMain then
    for _, v in ipairs(charPotentialCfg.MasterSpecificPotentialIds) do
      nAllCount = nAllCount + 1
    end
    for _, v in ipairs(charPotentialCfg.MasterNormalPotentialIds) do
      nAllCount = nAllCount + 1
    end
  else
    for _, v in ipairs(charPotentialCfg.AssistSpecificPotentialIds) do
      nAllCount = nAllCount + 1
    end
    for _, v in ipairs(charPotentialCfg.AssistNormalPotentialIds) do
      nAllCount = nAllCount + 1
    end
  end
  return nAllCount
end

function PotentialListItemCtrl:Init(nCharId, nCount, tbPotential, goPotential, bMain, bRankPreview)
  self.nCharId = nCharId
  local charCfg = ConfigTable.GetData_Character(nCharId)
  local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  local charSkinCfg = ConfigTable.GetData_CharacterSkin(nCharSkinId)
  local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[charCfg.Grade]
  self:SetPngSprite(self._mapNode.imgHead, charSkinCfg.Icon, AllEnum.CharHeadIconSurfix.XXL)
  self:SetAtlasSprite(self._mapNode.imgHeadFrame, "12_rare", sFrame, true)
  NovaAPI.SetTMPText(self._mapNode.txtCharName, charCfg.Name)
  self.mapPotential = {}
  local nHas = 0
  local nHasAdd = 0
  local tbPotentialAdd = PlayerData.Char:GetCharEnhancedPotential(nCharId)
  for _, v in ipairs(tbPotential) do
    local nAddCount = 0
    if not bRankPreview then
      nAddCount = tbPotentialAdd[v.nPotentialId] and tbPotentialAdd[v.nPotentialId] or 0
    end
    if v.nLevel == 0 then
      nAddCount = 0
    end
    local itemCfg = ConfigTable.GetData_Item(v.nPotentialId)
    if itemCfg == nil then
      return
    end
    local nSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0
    nHas = nHas + v.nLevel
    nHasAdd = nHasAdd + nAddCount
    table.insert(self.mapPotential, {
      nId = v.nPotentialId,
      nLevel = v.nLevel,
      nPotentialAdd = nAddCount,
      nAllLevel = v.nLevel + nAddCount,
      nSpecial = nSpecial,
      nRarity = itemCfg.Rarity
    })
  end
  table.sort(self.mapPotential, function(a, b)
    if a.nSpecial == b.nSpecial then
      if a.nRarity == b.nRarity then
        if a.nAllLevel == b.nAllLevel then
          return a.nId < b.nId
        end
        return a.nAllLevel > b.nAllLevel
      end
      return a.nRarity < b.nRarity
    end
    return a.nSpecial > b.nSpecial
  end)
  for _, v in ipairs(self.tbItemGrid) do
    v.gameObject:SetActive(false)
  end
  for k, v in ipairs(self.mapPotential) do
    if nil == self.tbItemGrid[k] then
      local objItem = instantiate(goPotential, self._mapNode.rtPotential)
      objItem.gameObject:SetActive(true)
      local itemCtrl = self:BindCtrlByNode(objItem, "Game.UI.StarTower.Depot.DepotPotentialItemCtrl")
      itemCtrl:InitItem(v.nId, v.nLevel, v.nPotentialAdd, true, true)
      table.insert(self.tbItemGrid, itemCtrl)
    else
      self.tbItemGrid[k].gameObject:SetActive(true)
      self.tbItemGrid[k]:InitItem(v.nId, v.nLevel, v.nPotentialAdd, true, true)
    end
  end
  if 0 < nHasAdd then
    NovaAPI.SetTMPText(self._mapNode.txtHas, string.format("%s+%s", nHas, nHasAdd))
  else
    NovaAPI.SetTMPText(self._mapNode.txtHas, nHas)
  end
  self._mapNode.txtAll.gameObject:SetActive(false)
end

return PotentialListItemCtrl
