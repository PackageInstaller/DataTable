local CharPotentialListCtrl = class("CharPotentialListCtrl", BaseCtrl)
CharPotentialListCtrl._mapNodeConfig = {
  txtCharName = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtAll = {sComponentName = "TMP_Text"},
  imgHead = {sComponentName = "Image"},
  imgHeadFrame = {sComponentName = "Image"},
  rtPotential = {
    sComponentName = "RectTransform"
  }
}
CharPotentialListCtrl._mapEventConfig = {}
CharPotentialListCtrl._mapRedDotConfig = {}

function CharPotentialListCtrl:RefreshPotential(nCharId, mapPotentialOrigin, mapPotentialAfter, mapAddLevel, goPotentialItem)
  self:ClearAllGrid()
  self.mapPotentialOrigin = mapPotentialOrigin
  self.mapPotentialAfter = mapPotentialAfter
  self.mapPotentialAddLevel = mapAddLevel
  local charCfg = ConfigTable.GetData_Character(nCharId)
  if nil ~= charCfg then
    NovaAPI.SetTMPText(self._mapNode.txtCharName, charCfg.Name)
    local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    local skinCfg = ConfigTable.GetData_CharacterSkin(nSkinId)
    self:SetPngSprite(self._mapNode.imgHead, skinCfg.Icon, AllEnum.CharHeadIconSurfix.XXL)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[charCfg.Grade]
    self:SetAtlasSprite(self._mapNode.imgHeadFrame, "12_rare", sFrame)
  end
  self.tbPotential = {}
  for nPotentialId, nCount in pairs(self.mapPotentialOrigin) do
    table.insert(self.tbPotential, nPotentialId)
  end
  self.mapSortData = {}
  for _, v in ipairs(self.tbPotential) do
    local itemCfg = ConfigTable.GetData_Item(v)
    if itemCfg == nil then
      return
    end
    local nLevel = mapPotentialOrigin[v]
    local nSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0
    local nAddLevel = self.mapPotentialAddLevel[v] or 0
    self.mapSortData[v] = {
      nId = v,
      nLevel = nLevel,
      nAllLevel = nLevel + nAddLevel,
      nSpecial = nSpecial,
      nRarity = itemCfg.Rarity
    }
  end
  
  local function sort(a, b)
    local mapDataA = self.mapSortData[a]
    local mapDataB = self.mapSortData[b]
    if mapDataA.nSpecial == mapDataB.nSpecial then
      if mapDataA.nRarity == mapDataB.nRarity then
        if mapDataA.nAllLevel == mapDataB.nAllLevel then
          return mapDataA.nId < mapDataB.nId
        end
        return mapDataA.nAllLevel > mapDataB.nAllLevel
      end
      return mapDataA.nRarity < mapDataB.nRarity
    end
    return mapDataA.nSpecial > mapDataB.nSpecial
  end
  
  table.sort(self.tbPotential, sort)
  local nAllCount = #self.tbPotential
  NovaAPI.SetTMPText(self._mapNode.txtAll, string.format("/%s", nAllCount))
  self.nHasCount = 0
  local nPotentialCount = 1
  if #self.tbPotential > 0 then
    for k, v in ipairs(self.tbPotential) do
      local nOriginCount = self.mapPotentialOrigin[v]
      local nAfterCount = self.mapPotentialAfter[v]
      local nAddLevel = self.mapPotentialAddLevel[v] or 0
      if nil == self.tbPotentialItemCtrl[nPotentialCount] then
        local itemObj = instantiate(goPotentialItem, self._mapNode.rtPotential)
        itemObj.gameObject:SetActive(true)
        local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.BuildModifier.Potential.PotentialItemCtrl")
        table.insert(self.tbPotentialItemCtrl, itemCtrl)
        self.mapPotentialCtrl[v] = itemCtrl
        itemCtrl:InitItem(v, nOriginCount + nAddLevel, nAfterCount + nAddLevel)
      else
        self.tbPotentialItemCtrl[nPotentialCount]:InitItem(v, nOriginCount + nAddLevel, nAfterCount + nAddLevel)
        self.mapPotentialCtrl[v.nId] = self.tbPotentialItemCtrl[nPotentialCount]
      end
      self.nHasCount = self.nHasCount + nAfterCount
      nPotentialCount = nPotentialCount + 1
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtHas, self.nHasCount)
end

function CharPotentialListCtrl:RefreshPotentialCount(mapPotentialOrigin, mapPotentialAfter, nTotalCount)
  self.mapPotentialOrigin = mapPotentialOrigin
  self.mapPotentialAfter = mapPotentialAfter
  for k, v in ipairs(self.tbPotential) do
    local nOriginCount = self.mapPotentialOrigin[v]
    local nAfterCount = self.mapPotentialAfter[v]
    local nAddLevel = self.mapPotentialAddLevel[v] or 0
    if nil ~= self.mapPotentialCtrl[v] then
      self.mapPotentialCtrl[v]:SetPotentialLevel(nOriginCount + nAddLevel, nAfterCount + nAddLevel)
    end
  end
  self.nHasCount = nTotalCount
  NovaAPI.SetTMPText(self._mapNode.txtHas, nTotalCount)
end

function CharPotentialListCtrl:SetPotentialBuildName(nCharId, bMaster)
end

function CharPotentialListCtrl:RefreshPotentialLevel(nPotentialId, nLevel, nLastLevel)
end

function CharPotentialListCtrl:ShowAllCount(bShowAll)
  self._mapNode.txtAll.gameObject:SetActive(bShowAll)
end

function CharPotentialListCtrl:ClearAllGrid()
  for nInstanceId, objCtrl in pairs(self.tbPotentialItemCtrl) do
    local obj = objCtrl.gameObject
    self:UnbindCtrlByNode(objCtrl)
    destroy(obj)
  end
  self.tbPotentialItemCtrl = {}
  self.mapPotentialCtrl = {}
end

function CharPotentialListCtrl:Awake()
  self.tbPotentialItemCtrl = {}
  self.mapPotentialCtrl = {}
end

function CharPotentialListCtrl:OnEnable()
  NovaAPI.SetTMPText(self._mapNode.txtAll, "")
end

function CharPotentialListCtrl:OnDisable()
  self:ClearAllGrid()
end

function CharPotentialListCtrl:OnDestroy()
end

return CharPotentialListCtrl
