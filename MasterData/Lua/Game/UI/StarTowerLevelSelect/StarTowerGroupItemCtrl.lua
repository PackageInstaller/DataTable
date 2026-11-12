local StarTowerGroupItemCtrl = class("StarTowerGroupItemCtrl", BaseCtrl)
StarTowerGroupItemCtrl._mapNodeConfig = {
  imgLevelImage = {sComponentName = "Image"},
  goTimeLimit = {},
  TMPRogelikeName = {nCount = 2, sComponentName = "TMP_Text"},
  goNormal = {},
  TMPRecommendInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend"
  },
  imgTime = {},
  txtOpenTime = {sComponentName = "TMP_Text"},
  rtRecommend = {},
  imgElement = {nCount = 3, sComponentName = "Image"},
  goMask = {},
  txtLock = {sComponentName = "TMP_Text"},
  imgChoose = {}
}
StarTowerGroupItemCtrl._mapEventConfig = {}
StarTowerGroupItemCtrl._mapRedDotConfig = {}

function StarTowerGroupItemCtrl:SetStarTowerGroup(mapGroupData)
  local nGroupId = mapGroupData.nGroupId
  local mapGroupCfg = ConfigTable.GetData("StarTowerGroup", nGroupId)
  self.GroupTheme = mapGroupCfg.GroupTheme
  self._mapNode.goNormal.gameObject:SetActive(true)
  self._mapNode.goTimeLimit.gameObject:SetActive(false)
  for _, v in ipairs(self._mapNode.TMPRogelikeName) do
    NovaAPI.SetTMPText(v, mapGroupCfg.Name)
  end
  self:SetPngSprite(self._mapNode.imgLevelImage, mapGroupCfg.Episode)
  if mapGroupCfg.EET == nil or next(mapGroupCfg.EET) == nil then
    self._mapNode.rtRecommend.gameObject:SetActive(false)
    for i = 1, 3 do
      self._mapNode.imgElement[i].gameObject:SetActive(false)
    end
  else
    self._mapNode.rtRecommend.gameObject:SetActive(true)
    for i = 1, 3 do
      if mapGroupCfg.EET == nil or mapGroupCfg.EET[i] == nil then
        self._mapNode.imgElement[i].gameObject:SetActive(false)
      else
        self._mapNode.imgElement[i].gameObject:SetActive(true)
        self:SetAtlasSprite(self._mapNode.imgElement[i], "12_rare", AllEnum.ElementIconType.Icon .. mapGroupCfg.EET[i])
      end
    end
  end
  local nStarTowerId = CacheTable.GetData("_StarTowerGroupDifficulty", nGroupId)[GameEnum.diffculty.Diffculty_1].Id
  local bLock, sTip = PlayerData.StarTower:IsStarTowerUnlock(nStarTowerId)
  if not bLock then
    if sTip == nil then
      NovaAPI.SetTMPText(self._mapNode.txtLock, ConfigTable.GetUIText("LevelSelect_NotOpen"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtLock, sTip)
    end
  end
  self._mapNode.goMask:SetActive(not bLock)
  self._mapNode.imgTime.gameObject:SetActive(false)
end

function StarTowerGroupItemCtrl:SetSelect(bSelect)
  self._mapNode.imgChoose.gameObject:SetActive(bSelect)
end

function StarTowerGroupItemCtrl:GetGroupTheme()
  return self.GroupTheme or 0
end

function StarTowerGroupItemCtrl:Awake()
  self._mapNode.imgChoose.gameObject:SetActive(false)
end

function StarTowerGroupItemCtrl:OnEnable()
end

function StarTowerGroupItemCtrl:OnDisable()
end

function StarTowerGroupItemCtrl:OnDestroy()
end

return StarTowerGroupItemCtrl
