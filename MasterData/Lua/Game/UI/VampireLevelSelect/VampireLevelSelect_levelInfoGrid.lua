local VampireLevelSelect_levelInfoGrid = class("VampireLevelSelect_levelInfoGrid", BaseCtrl)
VampireLevelSelect_levelInfoGrid._mapNodeConfig = {
  TMPTitleZone = {sComponentName = "TMP_Text"},
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  txtBtnEnemyInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Instance_EnemyInfo"
  },
  imgLevelImg = {sComponentName = "Image"},
  tcChar = {nCount = 3},
  Monster = {
    sCtrlName = "Game.UI.TemplateEx.TemplateHeadCtrl",
    nCount = 4
  },
  rtEmpty = {},
  rtBuild = {},
  TMPBuildSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBoss_Manage_Title"
  },
  imgItemIcon = {sComponentName = "Image", nCount = 3},
  imgItemRare = {sComponentName = "Image", nCount = 3},
  txtRank = {sComponentName = "TMP_Text", nCount = 3},
  txtLv = {sComponentName = "TMP_Text", nCount = 3},
  TMPBuildRankTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_Score"
  },
  imgRankIcon = {sComponentName = "Image"},
  btnChangeBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeBuild"
  },
  btnSelectBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeBuild"
  },
  btnRemoveBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RemoveBuild"
  },
  btnExchangeBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ExchangeBuild"
  },
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  }
}
VampireLevelSelect_levelInfoGrid._mapEventConfig = {}
VampireLevelSelect_levelInfoGrid._mapRedDotConfig = {}

function VampireLevelSelect_levelInfoGrid:Awake()
end

function VampireLevelSelect_levelInfoGrid:FadeIn()
end

function VampireLevelSelect_levelInfoGrid:FadeOut()
end

function VampireLevelSelect_levelInfoGrid:OnEnable()
end

function VampireLevelSelect_levelInfoGrid:OnDisable()
end

function VampireLevelSelect_levelInfoGrid:OnDestroy()
end

function VampireLevelSelect_levelInfoGrid:OnRelease()
end

function VampireLevelSelect_levelInfoGrid:Refresh(mapLevelData, mapBuildData, bFirstHalf)
  self.bFirstHalf = bFirstHalf
  self.mapLevelData = mapLevelData
  local nPreviewMonsterGroupId = bFirstHalf and mapLevelData.FHPreviewMonsterGroupId or mapLevelData.SHPreviewMonsterGroupId
  self.nPreviewMonsterGroupId = nPreviewMonsterGroupId
  local sKey = bFirstHalf and "VampireTitle_FirstHalf" or "VampireTitle_SecondHalf"
  NovaAPI.SetTMPText(self._mapNode.TMPTitleZone, ConfigTable.GetUIText(sKey))
  local tbMonsterGroup
  if nPreviewMonsterGroupId ~= nil then
    local mapGroupCfgData = ConfigTable.GetData("PreviewMonsterGroup", nPreviewMonsterGroupId)
    if mapGroupCfgData ~= nil then
      tbMonsterGroup = mapGroupCfgData.MonsterIds
    end
  end
  if tbMonsterGroup == nil then
    tbMonsterGroup = {}
  end
  
  local function comp(a, b)
    local previewMonsterCfgA = ConfigTable.GetData("Monster", a)
    local previewMonsterCfgB = ConfigTable.GetData("Monster", b)
    if previewMonsterCfgA == nil or previewMonsterCfgB == nil then
      return a < b
    end
    if previewMonsterCfgA.EpicLv ~= previewMonsterCfgB.EpicLv then
      return previewMonsterCfgA.EpicLv < previewMonsterCfgB.EpicLv
    else
      return a < b
    end
  end
  
  table.sort(tbMonsterGroup, comp)
  for i = 1, 4 do
    if tbMonsterGroup[i] == nil then
      self._mapNode.Monster[i].gameObject:SetActive(false)
    else
      self._mapNode.Monster[i].gameObject:SetActive(true)
      self._mapNode.Monster[i]:SetMonsterHead(tbMonsterGroup[i])
    end
  end
  local tbEET = self.bFirstHalf and mapLevelData.EETScore1 or mapLevelData.EETScore2
  for i = 1, 3 do
    if tbEET == nil or tbEET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. tbEET[i])
    end
  end
  local sEpisode = self.bFirstHalf and self.mapLevelData.Episode or self.mapLevelData.Episode2
  self:SetPngSprite(self._mapNode.imgLevelImg, sEpisode)
  if mapBuildData == nil then
    self._mapNode.rtEmpty:SetActive(true)
    self._mapNode.rtBuild:SetActive(false)
  else
    self._mapNode.rtEmpty:SetActive(false)
    self._mapNode.rtBuild:SetActive(true)
    for i = 1, 3 do
      if mapBuildData.tbChar[i] ~= nil then
        self._mapNode.tcChar[i].gameObject:SetActive(true)
        local mapChar = ConfigTable.GetData_Character(mapBuildData.tbChar[i].nTid)
        local mapCharData
        if mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial then
          mapCharData = PlayerData.Char:GetLimitedTrialCharById(mapBuildData.tbChar[i].nTrialId)
        elseif mapBuildData.nBuildSource == AllEnum.BuildSource.Trial then
          mapCharData = PlayerData.Char:GetTrialCharById(mapBuildData.tbChar[i].nTrialId)
        else
          mapCharData = PlayerData.Char:GetCharDataByTid(mapBuildData.tbChar[i].nTid)
        end
        NovaAPI.SetTMPText(self._mapNode.txtRank[i], mapCharData.nLevel)
        local nCharSkinId = mapCharData.nSkinId
        local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
        self:SetPngSprite(self._mapNode.imgItemIcon[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
        local nRarity = mapChar.Grade
        local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[nRarity == GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity]
        self:SetAtlasSprite(self._mapNode.imgItemRare[i], "12_rare", sFrame, true)
      else
        self._mapNode.tcChar[i].gameObject:SetActive(false)
      end
    end
    local sScore = "Icon/BuildRank/BuildRank_" .. mapBuildData.mapRank.Id
    self:SetPngSprite(self._mapNode.imgRankIcon, sScore)
  end
end

function VampireLevelSelect_levelInfoGrid:OnBtnClick_ChangeBuild()
  local nIdx = self.bFirstHalf and 1 or 2
  EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossBuildBrief, 7, self.mapLevelData.Id, nIdx, {})
end

function VampireLevelSelect_levelInfoGrid:OnBtnClick_ExchangeBuild()
  PlayerData.VampireSurvivor:ExchangeBuild(self.mapLevelData.Id)
end

function VampireLevelSelect_levelInfoGrid:OnBtnClick_RemoveBuild()
  local nIdx = self.bFirstHalf and 1 or 2
  PlayerData.VampireSurvivor:CacheSelectedBuildId(self.mapLevelData.Id, nIdx, 0)
end

function VampireLevelSelect_levelInfoGrid:OnBtnClick_EnemyInfo()
  local tbOverrideWeakEET
  if self.mapLevelData.Type == GameEnum.vampireSurvivorType.Turn then
    tbOverrideWeakEET = self.bFirstHalf and self.mapLevelData.EETScore1 or self.mapLevelData.EETScore2
  end
  EventManager.Hit("OpenVampireMonsterInfo", self.nPreviewMonsterGroupId, tbOverrideWeakEET)
end

return VampireLevelSelect_levelInfoGrid
