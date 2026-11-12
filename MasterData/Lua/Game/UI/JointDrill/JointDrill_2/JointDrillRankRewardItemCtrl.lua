local JointDrillRankRewardItemCtrl = class("JointDrillRankRewardItemCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
JointDrillRankRewardItemCtrl._mapNodeConfig = {
  imgBg1 = {},
  imgBg2 = {},
  txtRanking = {sComponentName = "TMP_Text"},
  btnItem = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  goItem = {
    nCount = 3,
    sNodeName = "btnItem",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
JointDrillRankRewardItemCtrl._mapEventConfig = {}
JointDrillRankRewardItemCtrl._mapRedDotConfig = {}

function JointDrillRankRewardItemCtrl:RefreshItem(nIndex, nSelfRankSection)
  local nMaxRankCount = PlayerData.JointDrill_2:GetRankRewardCount()
  local mapCfg = ConfigTable.GetData("JointDrillRank", nIndex)
  if mapCfg == nil then
    return
  end
  local nRankingHigher = mapCfg.RankLower
  local nRankLower = 0
  if nIndex ~= 1 and ConfigTable.GetData("JointDrillRank", nIndex - 1) ~= nil then
    nRankLower = ConfigTable.GetData("JointDrillRank", nIndex - 1).RankLower
  end
  if nIndex == 1 then
    NovaAPI.SetTMPText(self._mapNode.txtRanking, orderedFormat(ConfigTable.GetUIText("JointDrill_Rank_Cur"), math.floor(nRankingHigher / 100)))
  elseif nIndex == nMaxRankCount then
    NovaAPI.SetTMPText(self._mapNode.txtRanking, orderedFormat(ConfigTable.GetUIText("JointDrill_Rank_Lv_1"), math.floor(nRankLower / 100)))
  else
    NovaAPI.SetTMPText(self._mapNode.txtRanking, orderedFormat(ConfigTable.GetUIText("JointDrill_Rank_Lv"), math.floor(nRankLower / 100), math.floor(nRankingHigher / 100)))
  end
  local bSelf = nSelfRankSection > nRankLower * ConfigData.IntFloatPrecision and nSelfRankSection <= nRankingHigher * ConfigData.IntFloatPrecision and nSelfRankSection ~= 0
  self._mapNode.imgBg1:SetActive(not bSelf)
  self._mapNode.imgBg2:SetActive(bSelf)
  self.tbReward = {}
  for i = 1, 3 do
    if mapCfg["AwardItemTid" .. i] ~= nil and mapCfg["AwardItemTid" .. i] ~= 0 then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      local nTid = mapCfg["AwardItemTid" .. i]
      local nCount = mapCfg["AwardItemNum" .. i]
      table.insert(self.tbReward, {nTid = nTid, nCount = nCount})
      self._mapNode.goItem[i]:SetItem(nTid, nil, nCount, nil, false, false, false, true, false, false)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function JointDrillRankRewardItemCtrl:Awake()
end

function JointDrillRankRewardItemCtrl:OnEnable()
end

function JointDrillRankRewardItemCtrl:OnDisable()
end

function JointDrillRankRewardItemCtrl:OnDestroy()
end

function JointDrillRankRewardItemCtrl:OnBtnClick_Item(btn, nIndex)
  local mapItem = self.tbReward[nIndex]
  if mapItem == nil then
    return
  end
  UTILS.ClickItemGridWithTips(mapItem.nTid, btn.transform, true, true, false)
end

return JointDrillRankRewardItemCtrl
