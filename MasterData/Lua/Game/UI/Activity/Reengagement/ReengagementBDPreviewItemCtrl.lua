local ReengagementBDPreviewItemCtrl = class("ReengagementBDPreviewItemCtrl", BaseCtrl)
ReengagementBDPreviewItemCtrl._mapNodeConfig = {
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnClickItem"
  },
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Sub"
  },
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtRating = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_Score"
  }
}
ReengagementBDPreviewItemCtrl._mapEventConfig = {}

function ReengagementBDPreviewItemCtrl:Refresh(nTrialBuildId)
  self.mapBuildData = PlayerData.Build:GetTrialBuild(nTrialBuildId)
  if self.mapBuildData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self:RefreshInfo()
  self:RefreshChar()
end

function ReengagementBDPreviewItemCtrl:RefreshInfo()
  local mapRank = self.mapBuildData.mapRank
  if mapRank == nil then
    mapRank = PlayerData.Build:CalBuildRank(self.mapBuildData.nScore or 0)
    self.mapBuildData.mapRank = mapRank
  end
  if mapRank ~= nil then
    local sScore = "Icon/BuildRank/BuildRank_" .. mapRank.Id
    self:SetPngSprite(self._mapNode.imgIcon, sScore)
  end
end

function ReengagementBDPreviewItemCtrl:RefreshChar()
  for i = 1, 3 do
    local mapCharData = self.mapBuildData.tbChar[i]
    local nCharTid = mapCharData ~= nil and mapCharData.nTid or 0
    local mapCharCfg = 0 < nCharTid and ConfigTable.GetData_Character(nCharTid) or nil
    local nCharSkinId = 0 < nCharTid and PlayerData.Char:GetCharSkinId(nCharTid) or 0
    local mapCharSkin = 0 < nCharSkinId and ConfigTable.GetData_CharacterSkin(nCharSkinId) or nil
    local bShowChar = mapCharCfg ~= nil and mapCharSkin ~= nil
    self._mapNode.imgCharIcon[i].gameObject:SetActive(bShowChar)
    self._mapNode.imgCharFrame[i].gameObject:SetActive(bShowChar)
    self._mapNode.txtPotentialCount[i].gameObject:SetActive(bShowChar)
    self._mapNode.imgCharElement[i].gameObject:SetActive(bShowChar)
    if bShowChar then
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
      self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
      self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
      NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[i], mapCharData.nPotentialCount or 0)
      self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
    end
  end
end

function ReengagementBDPreviewItemCtrl:OnClickItem()
  if self.mapBuildData == nil then
    return
  end
  self.mapBuildData = PlayerData.Build:GetTrialBuild(self.mapBuildData.nBuildId)
  if self.mapBuildData == nil then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildDetailPreview, self.mapBuildData)
end

return ReengagementBDPreviewItemCtrl
