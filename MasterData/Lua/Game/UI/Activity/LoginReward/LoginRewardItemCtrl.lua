local LoginRewardItemCtrl = class("LoginRewardItemCtrl", BaseCtrl)
LoginRewardItemCtrl._mapNodeConfig = {
  imgCanReceiveBg = {},
  imgBg = {},
  imgPlusBg = {},
  imgIcon = {sComponentName = "Image"},
  txtItemCount = {sComponentName = "TMP_Text"},
  imgDay = {nCount = 2, sComponentName = "Image"},
  txtItemName = {sComponentName = "TMP_Text"},
  goReceived = {},
  txtReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Received"
  },
  imgCanReceive = {},
  txtCanReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Can_Receive"
  },
  imgNextReceive = {},
  txtNextReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Next_Receive"
  },
  goParticle = {sNodeName = "UIParticle"}
}
LoginRewardItemCtrl._mapEventConfig = {}
LoginRewardItemCtrl._mapRedDotConfig = {}

function LoginRewardItemCtrl:SetRewardItem(nDay, mapReward, bFinalDay, bNextDay, sNumName)
  self.mapReward = mapReward
  for _, v in ipairs(self._mapNode.imgDay) do
    if sNumName then
      self:SetAtlasSprite(v, "05_number", sNumName .. nDay)
    else
      self:SetAtlasSprite(v, "05_number", "zs_activity_02_num_" .. nDay)
    end
  end
  self:SetPngSprite(self._mapNode.imgIcon, mapReward.RewardIcon or "")
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, orderedFormat(ConfigTable.GetUIText("LoginReward_Reward_Count"), mapReward.RewardCount))
  NovaAPI.SetTMPText(self._mapNode.txtItemName, mapReward.RewardDesc)
  self._mapNode.imgCanReceive.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.imgCanReceiveBg.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.goReceived.gameObject:SetActive(mapReward.Status == 2)
  self._mapNode.imgNextReceive.gameObject:SetActive(bNextDay)
  self._mapNode.imgPlusBg.gameObject:SetActive(mapReward.DisRare)
  self._mapNode.goParticle.gameObject:SetActive(mapReward.DisRare and mapReward.Status ~= 2)
  self._mapNode.imgBg.gameObject:SetActive(not mapReward.DisRare)
  self.tbRewardList = {}
  for i = 1, 3 do
    local nTid = mapReward["RewardId" .. i]
    local nCount = mapReward["Qty" .. i]
    if nTid ~= 0 then
      table.insert(self.tbRewardList, {nTid = nTid, nCount = nCount})
    end
  end
end

return LoginRewardItemCtrl
