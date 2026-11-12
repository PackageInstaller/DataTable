local FollowSocialMediaActCtrl = class("FollowSocialMediaActCtrl", BaseCtrl)
local SDKManager = CS.SDKManager.Instance
FollowSocialMediaActCtrl._mapNodeConfig = {
  btnEntrance = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Entrance"
  }
}
FollowSocialMediaActCtrl._mapEventConfig = {}
FollowSocialMediaActCtrl._mapRedDotConfig = {}

function FollowSocialMediaActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.config = ConfigTable.GetData("FollowSocialMediaControl", self.nActId)
  if self.config == nil then
    return
  end
  for _, v in ipairs(self._mapNode.btnEntrance) do
    v.gameObject:SetActive(false)
  end
  self.tbEntrance = self.config.LinkList
  for i, v in ipairs(self.tbEntrance) do
    if i > #self._mapNode.btnEntrance then
      break
    end
    local btn = self._mapNode.btnEntrance[i]
    self:InitEntrance(btn, v)
  end
end

function FollowSocialMediaActCtrl:InitEntrance(btn, nlinkConfigId)
  local linkConfig = ConfigTable.GetData("FollowSocialMediaLinkConfig", nlinkConfigId)
  if linkConfig == nil then
    return
  end
  local imgIcon = btn.transform:Find("AnimRoot/grpBg/imgIcon"):GetComponent("Image")
  local txtTitle1 = btn.transform:Find("AnimRoot/grpBg/txtTitle1"):GetComponent("TMP_Text")
  local imgReward1 = btn.transform:Find("AnimRoot/grpBg/imgItem/imgReward1"):GetComponent("Image")
  local imgReward2 = btn.transform:Find("AnimRoot/grpBg/imgItem/imgReward2"):GetComponent("Image")
  local txtCount = btn.transform:Find("AnimRoot/grpBg/txtCount"):GetComponent("TMP_Text")
  local imgItem = btn.transform:Find("AnimRoot/grpBg/imgItem").gameObject
  self:SetPngSprite(imgIcon, linkConfig.Icon)
  NovaAPI.SetTMPText(txtTitle1, linkConfig.Name)
  local itemCfg = ConfigTable.GetData("Item", linkConfig.RewardId)
  if itemCfg == nil then
    return
  end
  self:SetPngSprite(imgReward1, itemCfg.Icon)
  self:SetPngSprite(imgReward2, itemCfg.Icon)
  NovaAPI.SetTMPText(txtCount, linkConfig.RewardCount)
  btn.gameObject:SetActive(true)
  local bReceived = self.actData:GetRewardData(nlinkConfigId)
  local UIParticle1 = btn.transform:Find("AnimRoot/grpBg/imgItem/UIParticle1")
  local UIParticle2 = btn.transform:Find("AnimRoot/grpBg/imgItem/UIParticle2")
  imgReward2.gameObject:SetActive(bReceived)
  imgReward1.gameObject:SetActive(not bReceived)
  UIParticle1.gameObject:SetActive(not bReceived)
  UIParticle2.gameObject:SetActive(not bReceived)
  imgItem.gameObject:SetActive(not bReceived)
  txtCount.gameObject:SetActive(not bReceived)
end

function FollowSocialMediaActCtrl:OnBtnClick_Entrance(btn, nIndex)
  if self.tbEntrance[nIndex] == nil then
    return
  end
  local linkConfig = ConfigTable.GetData("FollowSocialMediaLinkConfig", self.tbEntrance[nIndex])
  if linkConfig == nil then
    return
  end
  if SDKManager:IsSDKInit() then
    if NovaAPI.IsMobilePlatform() then
      SDKManager:ShowWebView(false, "", linkConfig.DeepLink, 1, 1, true)
    else
      SDKManager:ShowWebView(false, "", linkConfig.URL, 1, 1, true)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
  local bReceived = self.actData:GetRewardData(self.tbEntrance[nIndex])
  if not bReceived then
    local function callback()
      self:InitEntrance(btn, self.tbEntrance[nIndex])
    end
    
    self.actData:SendRewardReceive(self.tbEntrance[nIndex], callback)
  end
end

return FollowSocialMediaActCtrl
