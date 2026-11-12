local LoginRewardItemCtrl_01 = class("LoginRewardItemCtrl_01", BaseCtrl)
LoginRewardItemCtrl_01._mapNodeConfig = {
  imgCanReceiveBg = {},
  imgBg = {},
  imgPlusBg = {},
  imgDay = {nCount = 2, sComponentName = "Image"},
  item = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItem = {nCount = 2, sComponentName = "UIButton"},
  txtItemName = {sComponentName = "TMP_Text"},
  goReceived = {},
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
  goParticle = {sNodeName = "UIParticle"}
}
LoginRewardItemCtrl_01._mapEventConfig = {}
LoginRewardItemCtrl_01._mapRedDotConfig = {}

function LoginRewardItemCtrl_01:SetRewardItem(nDay, mapReward, bEnableSelect, bNextDay, bClickTips)
  self.nDay = nDay
  self._mapNode.imgCanReceiveBg.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.imgBg.gameObject:SetActive(not mapReward.DisRare)
  self._mapNode.imgPlusBg.gameObject:SetActive(mapReward.DisRare)
  for _, v in ipairs(self._mapNode.imgDay) do
    self:SetAtlasSprite(v, "05_number", "zs_activity_02_num_" .. nDay)
  end
  self._mapNode.btnItem[1].gameObject:SetActive(mapReward.RewardId1 > 0)
  if mapReward.RewardId1 > 0 then
    self._mapNode.item[1]:SetItem(mapReward.RewardId1, nil, mapReward.Qty1, nil, mapReward.Status == 2)
  end
  self._mapNode.btnItem[2].gameObject:SetActive(0 < mapReward.RewardId2)
  if 0 < mapReward.RewardId2 then
    self._mapNode.item[2]:SetItem(mapReward.RewardId2, nil, mapReward.Qty2, nil, mapReward.Status == 2)
  end
  NovaAPI.SetTMPText(self._mapNode.txtItemName, mapReward.RewardDesc)
  self._mapNode.imgCanReceive.gameObject:SetActive(mapReward.Status == 1)
  self._mapNode.goReceived.gameObject:SetActive(mapReward.Status == 2)
  self._mapNode.imgNextReceive.gameObject:SetActive(bNextDay)
  self._mapNode.goParticle.gameObject:SetActive(mapReward.DisRare and mapReward.Status ~= 2)
  self:SetItemFxSate(mapReward.DisRare and mapReward.Status ~= 2)
  self:SetImgPlaySate(mapReward.Status == 2 and bEnableSelect)
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

function LoginRewardItemCtrl_01:SetSelect(bEnable)
  self._mapNode.Select.gameObject:SetActive(bEnable)
end

function LoginRewardItemCtrl_01:BindHandler()
  self.handler = {}
  for i = 1, 2 do
    local comp = self._mapNode.btnItem[i]
    self.handler[i] = ui_handler(self, self.OnBtnClick_Item, comp, i)
    comp.onClick:AddListener(self.handler[i])
  end
end

function LoginRewardItemCtrl_01:UnBindHandler()
  for i = 1, 2 do
    local comp = self._mapNode.btnItem[i]
    comp.onClick:RemoveListener(self.handler[i])
  end
  self.handler = nil
end

function LoginRewardItemCtrl_01:OnBtnClick_Item(btn, index)
  local function callback()
    UTILS.ClickItemGridWithTips(self.tbRewardList[index].nTid, btn.transform, true, true, false)
  end
  
  EventManager.Hit("ClickLoginRewardTips", callback, self.nDay)
end

function LoginRewardItemCtrl_01:SetItemFxSate(bShowFx)
  local FX = self.gameObject.transform:Find("FX")
  if FX then
    FX.gameObject:SetActive(bShowFx)
  else
    return
  end
end

function LoginRewardItemCtrl_01:SetImgPlaySate(bShowImgPlay)
  local ImgPlay = self.gameObject.transform:Find("imgPlay")
  if ImgPlay then
    ImgPlay.gameObject:SetActive(bShowImgPlay)
  else
    return
  end
end

return LoginRewardItemCtrl_01
