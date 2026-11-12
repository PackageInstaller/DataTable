local VampireLevelSelect_levelGridCtrl = class("VampireLevelSelect_levelGridCtrl", BaseCtrl)
VampireLevelSelect_levelGridCtrl._mapNodeConfig = {
  TMPLevelName = {sComponentName = "TMP_Text", nCount = 2},
  imgLevelImg = {sComponentName = "Image"},
  rtRankRoot = {},
  imgTimeBg = {},
  TMPRemainTime = {sComponentName = "TMP_Text"},
  txtRecommendLevel = {sComponentName = "TMP_Text"},
  TMPUnlockCond = {sComponentName = "TMP_Text"},
  rtNormalRoot = {},
  imgLock = {},
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  TMPRecommendBuildTitleChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgReconmendBuildChallenge = {sComponentName = "Image"},
  btnStar = {nCount = 3, sComponentName = "Button"}
}
VampireLevelSelect_levelGridCtrl._mapEventConfig = {}
VampireLevelSelect_levelGridCtrl._mapRedDotConfig = {}

function VampireLevelSelect_levelGridCtrl:Refresh(mapLevelData)
  if mapLevelData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.mapData = mapLevelData
  NovaAPI.SetTMPText(self._mapNode.TMPLevelName[1], mapLevelData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPLevelName[2], mapLevelData.Name)
  if mapLevelData.Type == GameEnum.vampireSurvivorType.Turn then
    self._mapNode.rtRankRoot:SetActive(true)
    self._mapNode.rtNormalRoot:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPRemainTime, PlayerData.VampireSurvivor:GetRefreshTiem())
    self._mapNode.imgTimeBg:SetActive(false)
  else
    self._mapNode.rtRankRoot:SetActive(false)
    self._mapNode.rtNormalRoot:SetActive(true)
    self._mapNode.imgTimeBg:SetActive(false)
    local tbQuestId = CacheTable.GetData("_VampireQuestGroup", mapLevelData.FirstQuestGroupId)
    if tbQuestId == nil then
      tbQuestId = {}
    end
    for i = 1, 3 do
      self._mapNode.btnStar[i].gameObject:SetActive(tbQuestId[i] ~= nil)
      self._mapNode.btnStar[i].interactable = PlayerData.Quest:GetVampireQuestStatusById(tbQuestId[i]) > 0
    end
  end
  for i = 1, 3 do
    if mapLevelData.EET == nil or mapLevelData.EET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. mapLevelData.EET[i])
    end
  end
  local sPath = self.mapData.CoverEpisode == nil and self.mapData.Episode or self.mapData.CoverEpisode
  self:SetPngSprite(self._mapNode.imgLevelImg, sPath)
  local bUnLock, nType, content = PlayerData.VampireSurvivor:CheckLevelUnlock(mapLevelData.Id)
  if not bUnLock then
    self._mapNode.imgLock:SetActive(true)
    local sKey = "VampireTalent_LockCond" .. nType
    NovaAPI.SetTMPText(self._mapNode.TMPUnlockCond, orderedFormat(ConfigTable.GetUIText(sKey), content))
  else
    self._mapNode.imgLock:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapLevelData.SuggestedPower)
  local rBuildRank = mapLevelData.RecommendBuildRank
  local sScore = "Icon/BuildRank/BuildRank_" .. rBuildRank
  self:SetPngSprite(self._mapNode.imgReconmendBuildChallenge, sScore)
end

return VampireLevelSelect_levelGridCtrl
