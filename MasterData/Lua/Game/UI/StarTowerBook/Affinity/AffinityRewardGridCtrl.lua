local AffinityRewardGridCtrl = class("AffinityRewardGridCtrl", BaseCtrl)
AffinityRewardGridCtrl._mapNodeConfig = {
  rt_item = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  rtUnlock = {},
  rtLock = {},
  imgHead = {sComponentName = "Image"},
  TMPUnreceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "NPCAffinity_Received"
  },
  TMPReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "NPCAffinity_Unreceived"
  },
  txtLevelName = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "Dating_Affinity_Level"
  },
  txtLevel = {sComponentName = "TMP_Text", nCount = 2},
  btnItem = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_RewardItem"
  }
}
AffinityRewardGridCtrl._mapEventConfig = {}
AffinityRewardGridCtrl._mapRedDotConfig = {}

function AffinityRewardGridCtrl:Awake()
end

function AffinityRewardGridCtrl:FadeIn()
end

function AffinityRewardGridCtrl:FadeOut()
end

function AffinityRewardGridCtrl:OnEnable()
end

function AffinityRewardGridCtrl:OnDisable()
end

function AffinityRewardGridCtrl:OnDestroy()
end

function AffinityRewardGridCtrl:OnRelease()
end

function AffinityRewardGridCtrl:Refresh(mapCfgData, mapAffinity)
  NovaAPI.SetTMPText(self._mapNode.txtLevel[1], mapCfgData.Level)
  NovaAPI.SetTMPText(self._mapNode.txtLevel[2], mapCfgData.Level)
  self:SetPngSprite(self._mapNode.imgHead, mapCfgData.Icon)
  local mapReward = decodeJson(mapCfgData.Reward)
  local tbReward = {}
  for nTid, nCount in pairs(mapReward) do
    table.insert(tbReward, {
      tonumber(nTid),
      tonumber(nCount)
    })
  end
  
  local function sort(a, b)
    return a[1] < b[1]
  end
  
  table.sort(tbReward, sort)
  self.tbReward = tbReward
  for i = 1, 3 do
    if tbReward[i] ~= nil then
      self._mapNode.rt_item[i].gameObject:SetActive(true)
      self._mapNode.rt_item[i]:SetItem(tbReward[i][1], nil, tbReward[i][2], nil, false, false, false, true, false)
    else
      self._mapNode.rt_item[i].gameObject:SetActive(false)
    end
  end
  self._mapNode.rtUnlock:SetActive(mapCfgData.Level <= mapAffinity.Level)
  self._mapNode.rtLock:SetActive(mapCfgData.Level > mapAffinity.Level)
end

function AffinityRewardGridCtrl:OnBtnClick_RewardItem(btn, nIdx)
  UTILS.ClickItemGridWithTips(self.tbReward[nIdx][1], btn.gameObject, true, true, true)
end

return AffinityRewardGridCtrl
