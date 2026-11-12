local TravelerDuelRewardGridCtrl = class("TravelerDuelRewardGridCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
TravelerDuelRewardGridCtrl._mapNodeConfig = {
  imgBg1 = {},
  imgBg2 = {},
  imgRankingIcon = {sComponentName = "Image"},
  TMPRanking = {sComponentName = "TMP_Text"},
  tcItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  btnItem = {sComponentName = "UIButton", nCount = 2}
}
TravelerDuelRewardGridCtrl._mapEventConfig = {}
TravelerDuelRewardGridCtrl._mapRedDotConfig = {}

function TravelerDuelRewardGridCtrl:Awake()
end

function TravelerDuelRewardGridCtrl:FadeIn()
end

function TravelerDuelRewardGridCtrl:FadeOut()
end

function TravelerDuelRewardGridCtrl:OnEnable()
end

function TravelerDuelRewardGridCtrl:OnDisable()
end

function TravelerDuelRewardGridCtrl:OnDestroy()
end

function TravelerDuelRewardGridCtrl:OnRelease()
end

function TravelerDuelRewardGridCtrl:Refresh(nIdx, bSelfIdx)
  self._mapNode.imgBg1:SetActive(bSelfIdx == nIdx)
  self._mapNode.imgBg2:SetActive(bSelfIdx ~= nIdx)
  local mapRewardCfgData = ConfigTable.GetData("TravelerDuelChallengeRankReward", nIdx)
  if mapRewardCfgData == nil then
    return
  end
  self:SetAtlasSprite(self._mapNode.imgRankingIcon, "12_rare", "travelerduel_rank_" .. nIdx)
  local nRankingHigher = mapRewardCfgData.RankUpper * ConfigData.IntFloatPrecision
  local nRankLower = 1
  if ConfigTable.GetData("TravelerDuelChallengeRankReward", nIdx + 1) ~= nil then
    nRankLower = ConfigTable.GetData("TravelerDuelChallengeRankReward", nIdx + 1).RankLower * ConfigData.IntFloatPrecision
  end
  if nIdx == 4 then
    NovaAPI.SetTMPText(self._mapNode.TMPRanking, orderedFormat(ConfigTable.GetUIText("TravelerDuel_RankRewardTitle2"), nRankingHigher))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPRanking, orderedFormat(ConfigTable.GetUIText("TravelerDuel_RankRewardTitle3"), nRankingHigher, nRankLower))
  end
  self._mapNode.tcItem[1]:SetItem(mapRewardCfgData.AwardItemTid1, nil, mapRewardCfgData.AwardItemNum1, nil, false, false, false, true, false, false)
  self._mapNode.tcItem[2]:SetItem(mapRewardCfgData.AwardItemTid2, nil, mapRewardCfgData.AwardItemNum2, nil, false, false, false, true, false, false)
  self._mapNode.btnItem[1].onClick:RemoveAllListeners()
  self._mapNode.btnItem[2].onClick:RemoveAllListeners()
  self._mapNode.btnItem[1].onClick:AddListener(function()
    self:OnBtn_ClickItem(self._mapNode.btnItem[1], mapRewardCfgData.AwardItemTid1)
  end)
  self._mapNode.btnItem[2].onClick:AddListener(function()
    self:OnBtn_ClickItem(self._mapNode.btnItem[2], mapRewardCfgData.AwardItemTid2)
  end)
end

function TravelerDuelRewardGridCtrl:OnBtn_ClickItem(btn, itemId)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, true, true, false)
end

return TravelerDuelRewardGridCtrl
