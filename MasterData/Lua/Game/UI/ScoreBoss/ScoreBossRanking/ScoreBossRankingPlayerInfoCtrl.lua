local ScoreBossRankingPlayerInfoCtrl = class("ScoreBossRankingPlayerInfoCtrl", BaseCtrl)
ScoreBossRankingPlayerInfoCtrl._mapNodeConfig = {
  imgHead = {sComponentName = "Image"},
  imgIconRank = {sComponentName = "Image"},
  TMPPlayerLevel = {sComponentName = "TMP_Text"},
  TMPPlayerLevelTitle = {sComponentName = "TMP_Text"},
  TMPPlayerName = {sComponentName = "TMP_Text"},
  TMPPlayerTitle = {sComponentName = "TMP_Text"},
  TMPRank = {sComponentName = "TMP_Text"},
  TMPScore = {sComponentName = "TMP_Text"},
  TMPScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Rank_Score"
  },
  rtEmpty = {},
  rtRankingInfo = {}
}
ScoreBossRankingPlayerInfoCtrl._mapEventConfig = {}
ScoreBossRankingPlayerInfoCtrl._mapRedDotConfig = {}

function ScoreBossRankingPlayerInfoCtrl:Awake()
end

function ScoreBossRankingPlayerInfoCtrl:FadeIn()
end

function ScoreBossRankingPlayerInfoCtrl:FadeOut()
end

function ScoreBossRankingPlayerInfoCtrl:OnEnable()
end

function ScoreBossRankingPlayerInfoCtrl:OnDisable()
end

function ScoreBossRankingPlayerInfoCtrl:OnDestroy()
end

function ScoreBossRankingPlayerInfoCtrl:OnRelease()
end

function ScoreBossRankingPlayerInfoCtrl:Refresh(mapSelfRanking)
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerName, PlayerData.Base:GetPlayerNickName())
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerLevel, tostring(PlayerData.Base:GetWorldClass()))
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
  if nPre ~= 0 and nSuf ~= 0 then
    local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", nPre).Desc, ConfigTable.GetData("Title", nSuf).Desc)
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, sTitle)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, "")
  end
  if mapSelfRanking == nil then
    self._mapNode.rtEmpty:SetActive(true)
    self._mapNode.rtRankingInfo:SetActive(false)
    return
  end
  self._mapNode.rtEmpty:SetActive(false)
  self._mapNode.rtRankingInfo:SetActive(true)
  local nRewardIdx = PlayerData.ScoreBoss:GetSelfBorderIndex()
  self:SetAtlasSprite(self._mapNode.imgIconRank, "12_rare", "bossrush_rank_" .. nRewardIdx)
  local mapRewardCfgData = ConfigTable.GetData("ScoreBossRank", nRewardIdx)
  if mapRewardCfgData == nil then
    return
  end
  local nRankingHigher = mapRewardCfgData.RankLower
  local nRankLower = 0
  if nRewardIdx ~= 1 and ConfigTable.GetData("ScoreBossRank", nRewardIdx - 1) ~= nil then
    nRankLower = ConfigTable.GetData("ScoreBossRank", nRewardIdx - 1).RankLower
  end
  if nRewardIdx == 1 then
    NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_CurSelf"), math.floor(nRankingHigher / 100)))
  elseif nRewardIdx == PlayerData.ScoreBoss.maxRankCount then
    NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_Lv_1Self"), math.floor(nRankLower / 100)))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPRank, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_LvSelf"), math.floor(nRankLower / 100), math.floor(nRankingHigher / 100)))
  end
  NovaAPI.SetTMPText(self._mapNode.TMPScore, mapSelfRanking.Score)
end

return ScoreBossRankingPlayerInfoCtrl
