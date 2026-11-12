local TravelerDuelRankingGrid = class("TravelerDuelRankingGrid", BaseCtrl)
TravelerDuelRankingGrid._mapNodeConfig = {
  imgTitleBg1 = {},
  imgTitleBg2 = {},
  imgRankIcon = {sComponentName = "Image"},
  TMPRank = {sComponentName = "TMP_Text"},
  TMPScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_RankScoreTitle"
  },
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_RankNameTitle"
  },
  TMPScore = {sComponentName = "TMP_Text"},
  imgItemIcon = {sComponentName = "Image", nCount = 3},
  imgItemRare = {sComponentName = "Image", nCount = 3},
  txtRank = {sComponentName = "TMP_Text", nCount = 3},
  imgHead = {sComponentName = "Image"},
  TMPPlayerLevel = {sComponentName = "TMP_Text"},
  TMPPlayerLevelTitle = {sComponentName = "TMP_Text"},
  TMPPlayerName = {sComponentName = "TMP_Text"},
  TMPPlayerTitle = {sComponentName = "TMP_Text"},
  TMPBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_RankBuildTitle"
  },
  imgScoreIcon = {sComponentName = "Image"},
  goHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  }
}
TravelerDuelRankingGrid._mapEventConfig = {}
TravelerDuelRankingGrid._mapRedDotConfig = {}

function TravelerDuelRankingGrid:Awake()
end

function TravelerDuelRankingGrid:FadeIn()
end

function TravelerDuelRankingGrid:FadeOut()
end

function TravelerDuelRankingGrid:OnEnable()
end

function TravelerDuelRankingGrid:OnDisable()
end

function TravelerDuelRankingGrid:OnDestroy()
end

function TravelerDuelRankingGrid:OnRelease()
end

function TravelerDuelRankingGrid:Refresh(mapRanking)
  self._mapNode.imgTitleBg1:SetActive(mapRanking.bSelf == true)
  self._mapNode.imgTitleBg2:SetActive(mapRanking.bSelf ~= true)
  self:SetAtlasSprite(self._mapNode.imgRankIcon, "12_rare", "travelerduel_rank_" .. mapRanking.nRewardIdx)
  NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("TravelerDuel_RankTitle"), mapRanking.Rank))
  NovaAPI.SetTMPText(self._mapNode.TMPScore, string.formatnumberthousands(mapRanking.Score))
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerName, mapRanking.NickName)
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerLevel, mapRanking.WorldClass)
  local sScore = "Icon/BuildRank/BuildRank_" .. mapRanking.nBuildRank
  self:SetPngSprite(self._mapNode.imgScoreIcon, sScore)
  if mapRanking.TitlePrefix == 0 or mapRanking.TitleSuffix == 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, "")
  else
    local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", mapRanking.TitlePrefix).Desc, ConfigTable.GetData("Title", mapRanking.TitleSuffix).Desc)
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, sTitle)
  end
  local tbOwnHonorData = PlayerData.Base:GetPlayerHonorTitleList() or {}
  local mapCfg = ConfigTable.GetData("PlayerHead", mapRanking.HeadIcon)
  self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  for i = 1, 3 do
    local nCharId = mapRanking.Chars[i].Id
    local mapChar = ConfigTable.GetData_Character(nCharId)
    NovaAPI.SetTMPText(self._mapNode.txtRank[i], mapRanking.Chars[i].Level)
    local nCharSkinId = mapChar.DefaultSkinId
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    self:SetPngSprite(self._mapNode.imgItemIcon[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
    local nRarity = mapChar.Grade
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity]
    self:SetAtlasSprite(self._mapNode.imgItemRare[i], "12_rare", sFrame, true)
    local tbhonorTitle = mapRanking.Honors
    if tbhonorTitle ~= nil and tbhonorTitle[i] ~= nil and tbhonorTitle[i].Id ~= nil and 0 < tbhonorTitle[i].Id then
      local honorData = ConfigTable.GetData("Honor", tbhonorTitle[i].Id)
      local level
      if honorData.Type == GameEnum.honorType.Character then
        local affinityData = PlayerData.Char:GetCharAffinityData(honorData.Params[1])
        level = affinityData.Level
      elseif honorData.Type == GameEnum.honorType.Levels then
        for k, v in pairs(tbOwnHonorData) do
          if v.Id == honorData.Id then
            level = v.Lv or 1
            break
          end
        end
      elseif honorData.Type == GameEnum.honorType.Dorm then
        level = PlayerData.PlayerDormData:GetHonorTitleLevel()
      end
      self._mapNode.goHonorTitle[i]:SetHonotTitle(honorData.Id, i == 1, level)
    end
    self._mapNode.goHonorTitle[i].gameObject:SetActive(tbhonorTitle ~= nil and tbhonorTitle[i] ~= nil and tbhonorTitle[i].Id ~= nil and 0 < tbhonorTitle[i].Id)
  end
end

return TravelerDuelRankingGrid
