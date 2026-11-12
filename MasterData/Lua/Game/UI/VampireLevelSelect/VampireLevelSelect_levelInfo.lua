local VampireLevelSelect_levelInfo = class("VampireLevelSelect_levelInfo", BaseCtrl)
VampireLevelSelect_levelInfo._mapNodeConfig = {
  imgBgLevel = {
    nCount = 3,
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_levelInfoGrid"
  },
  TMPLevelName = {sComponentName = "TMP_Text"},
  TMPOpenTime = {sComponentName = "TMP_Text"},
  imgTimeBg = {},
  txtRecommendLevel = {sComponentName = "TMP_Text"},
  TMPRecommendLevelTitleGrid = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  TMPRecommendBuildTitleGrid = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgReconmendBuildGrid = {sComponentName = "Image"},
  imgCardPackage = {sComponentName = "Image", nCount = 5},
  imgSubIcon = {
    sNodeName = "imgSubIcon_",
    sComponentName = "Image",
    nCount = 5
  },
  TMPRecPartTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Rank_Recommend_Level"
  },
  TMPFCPartTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_RoomInfo_FateCard"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  btnFateCardInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FateCardInfo"
  },
  TMPBtnPassQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Pass_QuestTitle"
  },
  TMPGoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_Btn_Challenge"
  },
  goRedDotQuestLevelInfo = {},
  rtQuest = {},
  TMPQuest = {sComponentName = "TMP_Text", nCount = 3},
  btnQuestStar = {sComponentName = "Button", nCount = 3}
}
VampireLevelSelect_levelInfo._mapEventConfig = {}
VampireLevelSelect_levelInfo._mapRedDotConfig = {
  [RedDotDefine.VampireQuest] = {
    sNodeName = "goRedDotQuestLevelInfo"
  }
}

function VampireLevelSelect_levelInfo:Awake()
end

function VampireLevelSelect_levelInfo:FadeIn()
end

function VampireLevelSelect_levelInfo:FadeOut()
end

function VampireLevelSelect_levelInfo:OnEnable()
end

function VampireLevelSelect_levelInfo:OnDisable()
end

function VampireLevelSelect_levelInfo:OnDestroy()
end

function VampireLevelSelect_levelInfo:OnRelease()
end

function VampireLevelSelect_levelInfo:Refresh(nLevelId, mapBuild1, mapBuild2)
  self.mapBuild1 = mapBuild1
  self.mapBuild2 = mapBuild2
  self.nLevelId = nLevelId
  local mapLevelData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapLevelData == nil then
    return
  end
  self.bSingle = mapLevelData.Mode == GameEnum.vampireSurvivorMode.Single
  self._mapNode.imgTimeBg:SetActive(mapLevelData.Type == GameEnum.vampireSurvivorType.Turn)
  self._mapNode.rtQuest:SetActive(mapLevelData.Type ~= GameEnum.vampireSurvivorType.Turn)
  if mapLevelData.Type ~= GameEnum.vampireSurvivorType.Turn then
    local tbQuestId = CacheTable.GetData("_VampireQuestGroup", mapLevelData.FirstQuestGroupId)
    if tbQuestId == nil then
      tbQuestId = {}
    end
    for i = 1, 3 do
      self._mapNode.TMPQuest[i].gameObject:SetActive(tbQuestId[i] ~= nil)
      self._mapNode.btnQuestStar[i].interactable = PlayerData.Quest:GetVampireQuestStatusById(tbQuestId[i]) > 0
      if tbQuestId[i] ~= nil then
        local mapQuestCfgData = ConfigTable.GetData("VampireSurvivorQuest", tbQuestId[i])
        if mapQuestCfgData == nil then
          self._mapNode.TMPQuest[i].gameObject:SetActive(false)
        else
          NovaAPI.SetTMPText(self._mapNode.TMPQuest[i], mapQuestCfgData.Title)
        end
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.TMPOpenTime, orderedFormat(ConfigTable.GetUIText("Vampire_LevelOpenTime"), PlayerData.VampireSurvivor:GetRefreshTiem()))
  NovaAPI.SetTMPText(self._mapNode.TMPLevelName, mapLevelData.Name)
  if self.bSingle then
    self._mapNode.imgBgLevel[3].gameObject:SetActive(true)
    self._mapNode.imgBgLevel[3]:Refresh(mapLevelData, self.mapBuild1, true)
    self._mapNode.imgBgLevel[1].gameObject:SetActive(false)
    self._mapNode.imgBgLevel[2].gameObject:SetActive(false)
  else
    self._mapNode.imgBgLevel[1].gameObject:SetActive(true)
    self._mapNode.imgBgLevel[2].gameObject:SetActive(true)
    self._mapNode.imgBgLevel[1]:Refresh(mapLevelData, self.mapBuild1, true)
    self._mapNode.imgBgLevel[2]:Refresh(mapLevelData, self.mapBuild2, false)
    self._mapNode.imgBgLevel[3].gameObject:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapLevelData.SuggestedPower)
  local rBuildRank = mapLevelData.RecommendBuildRank
  local sScore = "Icon/BuildRank/BuildRank_" .. rBuildRank
  self:SetPngSprite(self._mapNode.imgReconmendBuildGrid, sScore)
  local tbBunldle = {}
  if mapLevelData.Type == GameEnum.vampireSurvivorType.Turn then
    local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
    local mapSeason = ConfigTable.GetData("VampireRankSeason", nSeasonId)
    if mapSeason ~= nil then
      tbBunldle = mapSeason.FateCardBundle
    end
  else
    tbBunldle = mapLevelData.FateCardBundle
  end
  for i = 1, 5 do
    if tbBunldle[i] ~= nil then
      local mapBundleCfg = ConfigTable.GetData("StarTowerBookFateCardBundle", tbBunldle[i])
      if mapBundleCfg == nil then
        self._mapNode.imgCardPackage[i].gameObject:SetActive(false)
      else
        self._mapNode.imgCardPackage[i].gameObject:SetActive(true)
        self:SetPngSprite(self._mapNode.imgCardPackage[i], mapBundleCfg.Icon .. AllEnum.FateCardBundleIcon.S)
        self:SetAtlasSprite(self._mapNode.imgSubIcon[i], "05_language", mapBundleCfg.Text)
        NovaAPI.SetImageNativeSize(self._mapNode.imgSubIcon[i])
      end
    else
      self._mapNode.imgCardPackage[i].gameObject:SetActive(false)
    end
  end
end

function VampireLevelSelect_levelInfo:SetRefreshTime()
  NovaAPI.SetTMPText(self._mapNode.TMPOpenTime, orderedFormat(ConfigTable.GetUIText("Vampire_LevelOpenTime"), PlayerData.VampireSurvivor:GetRefreshTiem()))
end

function VampireLevelSelect_levelInfo:OnBtnClick_Go()
  if self.bSingle then
    if self.mapBuild1 == nil then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Vampire_SingleBuildHint"))
      return
    end
    PlayerData.VampireSurvivor:EnterVampireSurvivor(self.nLevelId, self.mapBuild1.nBuildId, -1)
  else
    if self.mapBuild1 == nil or self.mapBuild2 == nil then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("VampireBuild_Hint"))
      return
    end
    PlayerData.VampireSurvivor:EnterVampireSurvivor(self.nLevelId, self.mapBuild1.nBuildId, self.mapBuild2.nBuildId)
  end
  EventManager.Hit("EnterVampireSurvivor")
end

function VampireLevelSelect_levelInfo:OnBtnClick_FateCardInfo()
  EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorFateCardInfo, self.nLevelId)
end

return VampireLevelSelect_levelInfo
