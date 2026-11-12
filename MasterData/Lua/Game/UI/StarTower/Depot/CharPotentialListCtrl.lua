local CharPotentialListCtrl = class("CharPotentialListCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
CharPotentialListCtrl._mapNodeConfig = {
  txtCharName = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtAll = {sComponentName = "TMP_Text"},
  imgHead = {sComponentName = "Image"},
  imgHeadFrame = {sComponentName = "Image"},
  PotentialStyle = {nCount = 3},
  txtPotentialTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtPotentialTitle3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Build_Common"
  },
  rtPotential = {
    nCount = 3,
    sComponentName = "RectTransform"
  }
}
CharPotentialListCtrl._mapEventConfig = {}
CharPotentialListCtrl._mapRedDotConfig = {}

function CharPotentialListCtrl:RefreshPotential(nCharId, mapPotential, bShowAll, goPotentialItem, bMaster)
  self.mapPotential = mapPotential
  local charCfg = ConfigTable.GetData_Character(nCharId)
  if nil ~= charCfg then
    NovaAPI.SetTMPText(self._mapNode.txtCharName, charCfg.Name)
    local nSkinId = PlayerData.Char:GetCharUsedSkinId(nCharId)
    local skinCfg = ConfigTable.GetData_CharacterSkin(nSkinId)
    self:SetPngSprite(self._mapNode.imgHead, skinCfg.Icon, AllEnum.CharHeadIconSurfix.XXL)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[charCfg.Grade]
    self:SetAtlasSprite(self._mapNode.imgHeadFrame, "12_rare", sFrame)
  end
  local tbPotential = mapPotential
  local tbBuild1 = tbPotential[GameEnum.potentialBuild.PotentialBuild1] or {}
  local tbBuild2 = tbPotential[GameEnum.potentialBuild.PotentialBuild2] or {}
  local tbBuildCommon = tbPotential[GameEnum.potentialBuild.PotentialBuildCommon] or {}
  self._mapNode.PotentialStyle[1]:SetActive(0 < #tbBuild1)
  self._mapNode.PotentialStyle[2]:SetActive(0 < #tbBuild2)
  self._mapNode.PotentialStyle[3]:SetActive(0 < #tbBuildCommon)
  local nAllCount = #tbBuild1 + #tbBuild2 + #tbBuildCommon
  NovaAPI.SetTMPText(self._mapNode.txtAll, string.format("/%s", nAllCount))
  self.nHasCount = 0
  local nPotentialCount = 1
  self:RefreshRecommendPotential()
  
  local function createPotentialItem(tbPotential, rtContent)
    if 0 < #tbPotential then
      for k, v in ipairs(tbPotential) do
        if nil == self.tbPotentialItemCtrl[nPotentialCount] then
          local itemObj = instantiate(goPotentialItem, rtContent)
          itemObj.gameObject:SetActive(true)
          local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotPotentialItemCtrl")
          itemCtrl:InitItem(v.nId, v.nLevel, v.nPotentialAdd, true, nil, self:GetRecommendPotentialLevel(v.nId))
          table.insert(self.tbPotentialItemCtrl, itemCtrl)
        else
          self.tbPotentialItemCtrl[nPotentialCount]:InitItem(v.nId, v.nLevel, v.nPotentialAdd, true, nil, self:GetRecommendPotentialLevel(v.nId))
        end
        self.nHasCount = self.nHasCount + v.nUnlock
        nPotentialCount = nPotentialCount + 1
      end
    end
  end
  
  createPotentialItem(tbBuild1, self._mapNode.rtPotential[1])
  createPotentialItem(tbBuild2, self._mapNode.rtPotential[2])
  createPotentialItem(tbBuildCommon, self._mapNode.rtPotential[3])
  NovaAPI.SetTMPText(self._mapNode.txtHas, self.nHasCount)
  self:SwitchPotentialAll(bShowAll)
  self:SetPotentialBuildName(nCharId, bMaster)
end

function CharPotentialListCtrl:OnSwitchPotentialRecommendChange(showRecomm)
  for _, listItem in ipairs(self.tbPotentialItemCtrl) do
    if showRecomm then
      listItem:RefreshRecommend(self:GetRecommendPotentialLevel(listItem:GetPotentialID()))
    else
      listItem:RefreshRecommend(-1)
    end
  end
end

function CharPotentialListCtrl:GetRecommendPotentialLevel(nId)
  if not self.recommendList then
    self:RefreshRecommendPotential()
  end
  if not self.recommendList then
    return -1
  end
  for _, tb in ipairs(self.recommendList) do
    if tb.nId == nId then
      return tb.nLevel
    end
  end
  return -1
end

function CharPotentialListCtrl:GetPotenRecommendStatus()
  return PlayerData.StarTower:GetPotenRecommendStatus(self._panel.nStarTowerId)
end

function CharPotentialListCtrl:RefreshRecommendPotential()
  self.bPotentialRecommend, self.ispreSelect = self:GetPotenRecommendStatus()
  if not self.ispreSelect then
    self.recommendList = nil
    return
  end
  if not self.bPotentialRecommend then
    self.recommendList = nil
    return
  end
  local potemtilalList = {}
  for _, v in ipairs(self.mapPotential) do
    for _, tb in ipairs(v) do
      table.insert(potemtilalList, tb.nId)
    end
  end
  self.recommendList = PlayerData.StarTower:GetRecommendList(self._panel.nStarTowerId, self._panel.tbTeam, potemtilalList)
end

function CharPotentialListCtrl:SwitchPotentialAll(bShowAll)
  local nPotentialIndex = 1
  for nStyle, tbSubMap in ipairs(self.mapPotential) do
    local bShowStyle = false
    for k, v in ipairs(tbSubMap) do
      if bShowAll then
        bShowStyle = true
        self.tbPotentialItemCtrl[nPotentialIndex].gameObject:SetActive(true)
      else
        local bShow = v.nUnlock > 0
        self.tbPotentialItemCtrl[nPotentialIndex].gameObject:SetActive(bShow)
        if bShow then
          bShowStyle = true
        end
      end
      nPotentialIndex = nPotentialIndex + 1
    end
    self._mapNode.PotentialStyle[nStyle]:SetActive(bShowStyle)
  end
  self.gameObject:SetActive(bShowAll or 0 < self.nHasCount)
end

function CharPotentialListCtrl:SetPotentialBuildName(nCharId, bMaster)
  local charDescCfg = ConfigTable.GetData("CharacterDes", nCharId)
  if charDescCfg ~= nil then
    for i = 1, 2 do
      NovaAPI.SetTMPText(self._mapNode.txtPotentialTitle[i], bMaster and charDescCfg["PotentialMain" .. i] or charDescCfg["PotentialAssistant" .. i])
    end
  end
end

function CharPotentialListCtrl:Awake()
  self.tbPotentialItemCtrl = {}
  self.mapPotential = {}
end

function CharPotentialListCtrl:OnEnable()
end

function CharPotentialListCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbPotentialItemCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbPotentialItemCtrl[nInstanceId] = nil
  end
  self.tbPotentialItemCtrl = {}
end

function CharPotentialListCtrl:OnDestroy()
end

return CharPotentialListCtrl
