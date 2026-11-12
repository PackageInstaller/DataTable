local LoginSpRewardItemCtrl_01 = class("LoginSpRewardItemCtrl_01", BaseCtrl)
LoginSpRewardItemCtrl_01._mapNodeConfig = {
  imgCanReceiveBg = {},
  imgBg = {},
  imgPlusBg = {},
  imgDay = {nCount = 2, sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtItemCount = {sComponentName = "TMP_Text"},
  btnItem = {sComponentName = "UIButton"},
  txtItemName = {sComponentName = "TMP_Text"},
  goReceived = {},
  imgPlay = {},
  Select = {},
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
  txtReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Received"
  },
  goParticle = {sNodeName = "UIParticle"}
}
LoginSpRewardItemCtrl_01._mapEventConfig = {}
LoginSpRewardItemCtrl_01._mapRedDotConfig = {}

function LoginSpRewardItemCtrl_01:SetRewardItem(nDay, mapReward, bEnableSelect, bNextDay, bClickTips)
  self.nDay = nDay
  self._mapNode.imgCanReceiveBg.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.imgBg.gameObject:SetActive(not mapReward.DisRare)
  self._mapNode.imgPlusBg.gameObject:SetActive(mapReward.DisRare)
  for _, v in ipairs(self._mapNode.imgDay) do
    self:SetAtlasSprite(v, "05_number", "zs_activity_02_num_" .. nDay)
  end
  self:SetPngSprite(self._mapNode.imgIcon, mapReward.RewardIcon or "")
  NovaAPI.SetTMPText(self._mapNode.txtItemCount, orderedFormat(ConfigTable.GetUIText("LoginReward_Reward_Count"), mapReward.RewardCount))
  NovaAPI.SetTMPText(self._mapNode.txtItemName, mapReward.RewardDesc)
  self._mapNode.imgCanReceive.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.goReceived.gameObject:SetActive(mapReward.Status == 2)
  self._mapNode.imgNextReceive.gameObject:SetActive(bNextDay)
  self._mapNode.goParticle.gameObject:SetActive(mapReward.DisRare and mapReward.Status ~= 2)
  self:SetItemFxSate(mapReward.DisRare and mapReward.Status ~= 2)
  self._mapNode.imgPlay.gameObject:SetActive(mapReward.Status == 2 and bEnableSelect)
  self:SetSelect(false)
  self.tbRewardList = {}
  for i = 1, 3 do
    local nTid = mapReward["RewardId" .. i]
    local nCount = mapReward["Qty" .. i]
    if nTid ~= 0 then
      table.insert(self.tbRewardList, {nTid = nTid, nCount = nCount})
    end
  end
  if bClickTips then
    if self.handler then
      self:UnBindHandler()
    end
    self:BindHandler()
  end
end

function LoginSpRewardItemCtrl_01:SetSelect(bEnable)
  self._mapNode.Select.gameObject:SetActive(bEnable)
end

function LoginSpRewardItemCtrl_01:BindHandler()
  self.handler = {}
  local comp = self._mapNode.btnItem
  self.handler = ui_handler(self, self.OnBtnClick_Item, comp)
  comp.onClick:AddListener(self.handler)
end

function LoginSpRewardItemCtrl_01:UnBindHandler()
  local comp = self._mapNode.btnItem
  comp.onClick:RemoveListener(self.handler)
  self.handler = nil
end

function LoginSpRewardItemCtrl_01:OnBtnClick_Item(btn)
  local function callback()
    UTILS.ClickItemGridWithTips(self.tbRewardList[1].nTid, btn.transform, true, true, false)
  end
  
  EventManager.Hit("ClickLoginRewardTips", callback, self.nDay)
end

function LoginSpRewardItemCtrl_01:SetItemFxSate(bShowFx)
  local FX = self.gameObject.transform:Find("FX")
  if FX then
    FX.gameObject:SetActive(bShowFx)
  else
    return
  end
end

return LoginSpRewardItemCtrl_01
