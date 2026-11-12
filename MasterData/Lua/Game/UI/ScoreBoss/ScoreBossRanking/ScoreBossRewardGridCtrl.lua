local ScoreBossRewardGridCtrl = class("ScoreBossRewardGridCtrl", BaseCtrl)
ScoreBossRewardGridCtrl._mapNodeConfig = {
  imgBg1 = {},
  imgBg2 = {},
  TMPRanking = {sComponentName = "TMP_Text"},
  tcItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  btnItem = {sComponentName = "UIButton", nCount = 3}
}
ScoreBossRewardGridCtrl._mapEventConfig = {}
ScoreBossRewardGridCtrl._mapRedDotConfig = {}

function ScoreBossRewardGridCtrl:Awake()
end

function ScoreBossRewardGridCtrl:FadeIn()
end

function ScoreBossRewardGridCtrl:FadeOut()
end

function ScoreBossRewardGridCtrl:OnEnable()
end

function ScoreBossRewardGridCtrl:OnDisable()
end

function ScoreBossRewardGridCtrl:OnDestroy()
end

function ScoreBossRewardGridCtrl:OnRelease()
end

function ScoreBossRewardGridCtrl:Refresh(nIdx, nSelfIdx)
  if self.mapRewardCfgData == nil then
    self.mapRewardCfgData = {}
  end
  local nControlId = PlayerData.ScoreBoss.ControlId or 1
  
  local function foreachItem(mapData)
    if mapData.SeasonId == nControlId then
      table.insert(self.mapRewardCfgData, mapData)
    end
  end
  
  if #self.mapRewardCfgData == 0 then
    ForEachTableLine(ConfigTable.Get("ScoreBossRank"), foreachItem)
  end
  if self.mapRewardCfgData[nIdx] == nil then
    return
  end
  local nRankingHigher = self.mapRewardCfgData[nIdx].RankLower
  local nRankLower = 0
  if nIdx ~= 1 and self.mapRewardCfgData[nIdx - 1] ~= nil then
    nRankLower = self.mapRewardCfgData[nIdx - 1].RankLower
  end
  self._mapNode.imgBg1:SetActive(nSelfIdx <= nRankingHigher and nSelfIdx > nRankLower)
  self._mapNode.imgBg2:SetActive(nSelfIdx > nRankingHigher or nSelfIdx <= nRankLower)
  if nIdx == 1 then
    NovaAPI.SetTMPText(self._mapNode.TMPRanking, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_Cur"), math.floor(nRankingHigher / 100)))
  elseif nIdx == PlayerData.ScoreBoss.maxRankCount then
    NovaAPI.SetTMPText(self._mapNode.TMPRanking, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_Lv_1"), math.floor(nRankLower / 100)))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPRanking, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Rank_Lv"), math.floor(nRankLower / 100), math.floor(nRankingHigher / 100)))
  end
  for i = 1, 3 do
    if self.mapRewardCfgData[nIdx]["AwardItemTid" .. i] ~= nil and 0 < self.mapRewardCfgData[nIdx]["AwardItemNum" .. i] then
      self._mapNode.tcItem[i]:SetItem(self.mapRewardCfgData[nIdx]["AwardItemTid" .. i], nil, self.mapRewardCfgData[nIdx]["AwardItemNum" .. i], nil, false, false, false, true, false, false)
      self._mapNode.btnItem[i].onClick:RemoveAllListeners()
      self._mapNode.btnItem[i].onClick:AddListener(function()
        self:OnBtn_ClickItem(self._mapNode.btnItem[i], self.mapRewardCfgData[nIdx]["AwardItemTid" .. i])
      end)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function ScoreBossRewardGridCtrl:OnBtn_ClickItem(btn, itemId)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, true, true, false)
end

return ScoreBossRewardGridCtrl
