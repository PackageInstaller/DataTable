local ScoreBossRankingGridCtrl = class("ScoreBossRankingGridCtrl", BaseCtrl)
ScoreBossRankingGridCtrl._mapNodeConfig = {
  imgRankIcon = {sComponentName = "Image"},
  TMPRank = {sComponentName = "TMP_Text"},
  TMPScore = {sComponentName = "TMP_Text"},
  imgHead = {sComponentName = "Image"},
  TMPPlayerName = {sComponentName = "TMP_Text"},
  TMPPlayerTitle = {sComponentName = "TMP_Text"},
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TitleTag"
  },
  goHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  btnTeamDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TeamDetail"
  },
  TMPScoreEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_EnemyInfo_None"
  },
  TMPRankEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBossRankingEmpty"
  },
  imgScoreBgEmpty = {},
  imgScoreBg = {},
  imgBtnMask = {}
}
ScoreBossRankingGridCtrl._mapEventConfig = {}
ScoreBossRankingGridCtrl._mapRedDotConfig = {}

function ScoreBossRankingGridCtrl:RefreshHonorTitle(tbHonors)
  for i = 1, 3 do
    self._mapNode.goHonorTitle[i].gameObject:SetActive(false)
  end
  for k, v in pairs(tbHonors) do
    if v ~= nil and v.Id > 0 then
      local honorData = ConfigTable.GetData("Honor", v.Id)
      self._mapNode.goHonorTitle[k]:SetHonotTitle(honorData.Id, k == 1, v.AffinityLV)
      self._mapNode.goHonorTitle[k].gameObject:SetActive(true)
    end
  end
end

function ScoreBossRankingGridCtrl:Refresh(nIdx, bFixed)
  local mapRanking = PlayerData.ScoreBoss:GetPlayerRankMsg(nIdx)
  self.nIdx = nIdx
  if bFixed then
    mapRanking = PlayerData.ScoreBoss:GetRankSelfMsg()
    self.bSelf = true
    if mapRanking ~= nil then
      self.nIdx = mapRanking.Rank
    end
  end
  if mapRanking == nil and not bFixed then
    self.gameObject:SetActive(false)
    return
  elseif mapRanking == nil and bFixed then
    self._mapNode.imgRankIcon.gameObject:SetActive(false)
    self._mapNode.TMPRankEmpty.gameObject:SetActive(true)
    self._mapNode.TMPRank.gameObject:SetActive(false)
    self._mapNode.imgScoreBgEmpty:SetActive(true)
    self._mapNode.imgScoreBg:SetActive(false)
    self._mapNode.imgBtnMask:SetActive(true)
    local curHononData = PlayerData.Base:GetPlayerHonorTitle() or {}
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerName, PlayerData.Base:GetPlayerNickName())
    local mapHeadCfg = ConfigTable.GetData("PlayerHead", PlayerData.Base:GetPlayerHeadId())
    if mapHeadCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgHead, mapHeadCfg.Icon)
    end
    local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
    if nPre == 0 or nSuf == 0 then
      NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, "")
    else
      local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", nPre).Desc, ConfigTable.GetData("Title", nSuf).Desc)
      NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, sTitle)
    end
    self:RefreshHonorTitle(curHononData)
    return
  end
  self._mapNode.imgScoreBgEmpty:SetActive(false)
  self._mapNode.imgScoreBg:SetActive(true)
  self._mapNode.TMPRankEmpty.gameObject:SetActive(false)
  self._mapNode.TMPRank.gameObject:SetActive(true)
  self._mapNode.imgBtnMask:SetActive(false)
  if mapRanking.Rank <= 3 then
    self:SetPngSprite(self._mapNode.imgRankIcon, "Icon/ZZZOther/bossrush_rank_" .. mapRanking.Rank)
    self._mapNode.imgRankIcon.gameObject:SetActive(true)
    self._mapNode.TMPRank.gameObject:SetActive(false)
  else
    self._mapNode.imgRankIcon.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPRank, mapRanking.Rank)
    self._mapNode.TMPRank.gameObject:SetActive(true)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPScore, string.formatnumberthousands(mapRanking.Score))
  NovaAPI.SetTMPText(self._mapNode.TMPPlayerName, mapRanking.NickName)
  if mapRanking.TitlePrefix == 0 or mapRanking.TitleSuffix == 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, "")
  else
    local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", mapRanking.TitlePrefix).Desc, ConfigTable.GetData("Title", mapRanking.TitleSuffix).Desc)
    NovaAPI.SetTMPText(self._mapNode.TMPPlayerTitle, sTitle)
  end
  local mapCfg = ConfigTable.GetData("PlayerHead", mapRanking.HeadIcon)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  self:RefreshHonorTitle(mapRanking.Honors)
end

function ScoreBossRankingGridCtrl:OnBtnClick_TeamDetail()
  local mapRanking = PlayerData.ScoreBoss:GetPlayerRankMsg(self.nIdx)
  if self.bSelf then
    mapRanking = PlayerData.ScoreBoss:GetRankSelfMsg()
  end
  if mapRanking == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Rank_Detail_Empty"))
    return
  end
  EventManager.Hit("ShowTeamDetail", mapRanking)
end

return ScoreBossRankingGridCtrl
