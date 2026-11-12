local TravelerDuelRankingPlayerInfoCtrl = class("TravelerDuelRankingPlayerInfoCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
TravelerDuelRankingPlayerInfoCtrl._mapNodeConfig = {
  imgHead = {sComponentName = "Image"},
  imgIconRank = {sComponentName = "Image"},
  TMPPlayerLevel = {sComponentName = "TMP_Text"},
  TMPPlayerLevelTitle = {sComponentName = "TMP_Text"},
  TMPPlayerName = {sComponentName = "TMP_Text"},
  TMPPlayerTitle = {sComponentName = "TMP_Text"},
  TMPRank = {sComponentName = "TMP_Text"},
  TMPScore = {sComponentName = "TMP_Text"},
  rtEmpty = {},
  rtRankingInfo = {}
}
TravelerDuelRankingPlayerInfoCtrl._mapEventConfig = {}
TravelerDuelRankingPlayerInfoCtrl._mapRedDotConfig = {}

function TravelerDuelRankingPlayerInfoCtrl:Awake()
end

function TravelerDuelRankingPlayerInfoCtrl:FadeIn()
end

function TravelerDuelRankingPlayerInfoCtrl:FadeOut()
end

function TravelerDuelRankingPlayerInfoCtrl:OnEnable()
end

function TravelerDuelRankingPlayerInfoCtrl:OnDisable()
end

function TravelerDuelRankingPlayerInfoCtrl:OnDestroy()
end

function TravelerDuelRankingPlayerInfoCtrl:OnRelease()
end

function TravelerDuelRankingPlayerInfoCtrl:Refresh(mapSelfRanking)
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerName, PlayerData.Base:GetPlayerNickName())
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerLevel, tostring(PlayerData.Base:GetWorldClass()))
  local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
  if nPre == 0 or nSuf == 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, "")
    return
  end
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", nPre).Desc, ConfigTable.GetData("Title", nSuf).Desc)
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, sTitle)
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  if mapSelfRanking == nil then
    self._mapNode.rtEmpty:SetActive(true)
    self._mapNode.rtRankingInfo:SetActive(false)
    return
  end
  self._mapNode.rtEmpty:SetActive(false)
  self._mapNode.rtRankingInfo:SetActive(true)
  self:SetAtlasSprite(self._mapNode.imgIconRank, "12_rare", "travelerduel_rank_" .. mapSelfRanking.nRewardIdx)
  if mapSelfRanking.nRewardIdx == 4 then
    local nRanking = ConfigTable.GetData("TravelerDuelChallengeRankReward", 4).RankUpper * ConfigData.IntFloatPrecision
    NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("TravelerDuel_ChallengeRankTitle1"), nRanking))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("TravelerDuel_RankRewardTitle4"), mapSelfRanking.Rank))
  end
  NovaAPI.SetTMPText(self._mapNode.TMPScore, mapSelfRanking.Score)
end

return TravelerDuelRankingPlayerInfoCtrl
