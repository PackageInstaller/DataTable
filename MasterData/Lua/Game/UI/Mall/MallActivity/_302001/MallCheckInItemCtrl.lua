local MallCheckInItemCtrl = class("MallCheckInItemCtrl", BaseCtrl)
MallCheckInItemCtrl._mapNodeConfig = {
  imgCanReceiveBg = {},
  imgPlusReceiveBg = {},
  imgNormalBg = {},
  imgPlusBg = {},
  imgBgDb = {},
  imgPlusDb = {},
  txtDayNormal = {sComponentName = "TMP_Text"},
  txtDayPlus = {sComponentName = "TMP_Text"},
  btnItem = {nCount = 2, sComponentName = "UIButton"},
  goReceived = {},
  txtReceived = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Activity_CheckIn_Received"
  },
  imgCanReceive = {},
  txtCanReceive = {sComponentName = "TMP_Text"},
  txtPlusReceive = {sComponentName = "TMP_Text"},
  imgNextReceive = {},
  txtNextReceive = {sComponentName = "TMP_Text"},
  goParticle = {sNodeName = "UIParticle"}
}
MallCheckInItemCtrl._mapEventConfig = {}
MallCheckInItemCtrl._mapRedDotConfig = {}
local eState = {
  Received = 1,
  CanReceive = 2,
  NextDay = 3,
  Locked = 4
}
MallCheckInItemCtrl.eState = eState
local mapStateText = {
  [eState.Received] = "Mall_Activity_CheckIn_Received",
  [eState.NextDay] = "Mall_Activity_CheckIn_NextReceive",
  [eState.Locked] = "Mall_Activity_CheckIn_Lock"
}

local function GetState(mapReward, bActive, bNextDay)
  if not bActive then
    return eState.Locked
  end
  if mapReward.Status == 2 then
    return eState.Received
  end
  if mapReward.Status == 1 then
    return eState.CanReceive
  end
  if bNextDay then
    return eState.NextDay
  end
  return eState.Locked
end

local function GetItemNode(btn)
  local trAnimRoot = btn.transform:Find("AnimRoot")
  if trAnimRoot == nil then
    return nil
  end
  local trIcon = trAnimRoot:Find("imgIcon")
  local trCount = trAnimRoot:Find("txtItemCount")
  if trIcon == nil or trCount == nil then
    return nil
  end
  return {
    imgIcon = trIcon:GetComponent("Image"),
    txtItemCount = trCount:GetComponent("TMP_Text")
  }
end

function MallCheckInItemCtrl:Awake()
  self.mapReward = nil
  self.nState = eState.Locked
  self.tbRewardList = nil
  self.tbHandler = nil
  self.tbItemNode = {}
  for k, btn in ipairs(self._mapNode.btnItem) do
    self.tbItemNode[k] = GetItemNode(btn)
  end
end

function MallCheckInItemCtrl:OnDisable()
  self:UnBindHandler()
end

function MallCheckInItemCtrl:BindHandler()
  self.tbHandler = {}
  for k, btn in ipairs(self._mapNode.btnItem) do
    self.tbHandler[k] = ui_handler(self, self.OnBtnClick_Item, btn, k)
    btn.onClick:AddListener(self.tbHandler[k])
  end
end

function MallCheckInItemCtrl:UnBindHandler()
  local tbHandler = self.tbHandler
  if tbHandler == nil then
    return
  end
  local tbBtn = self._mapNode.btnItem
  for k, handler in ipairs(tbHandler) do
    if tbBtn[k] ~= nil then
      tbBtn[k].onClick:RemoveListener(handler)
    end
  end
  self.tbHandler = nil
end

function MallCheckInItemCtrl:SetItemNode(nIndex, sIcon, nCount)
  local btn = self._mapNode.btnItem[nIndex]
  if btn == nil then
    return
  end
  local mapItemNode = self.tbItemNode[nIndex]
  btn.gameObject:SetActive(sIcon ~= nil and sIcon ~= "" and mapItemNode ~= nil)
  if mapItemNode == nil or sIcon == nil or sIcon == "" then
    return
  end
  self:SetPngSprite(mapItemNode.imgIcon, sIcon)
  NovaAPI.SetTMPText(mapItemNode.txtItemCount, orderedFormat(ConfigTable.GetUIText("LoginReward_Reward_Count"), nCount))
end

function MallCheckInItemCtrl:SetItemClickable(bClickable)
  for _, btn in ipairs(self._mapNode.btnItem) do
    NovaAPI.SetRaycastTarget(btn.gameObject, bClickable)
  end
end

function MallCheckInItemCtrl:RefreshItemNode(mapReward)
  local sSumIcon = mapReward.RewardIcon
  local bUseSum = #self.tbRewardList <= 1 and sSumIcon ~= nil and sSumIcon ~= ""
  for nIndex = 1, #self._mapNode.btnItem do
    if bUseSum then
      self:SetItemNode(nIndex, nIndex == 1 and sSumIcon or nil, mapReward.RewardCount)
    else
      local mapItem = self.tbRewardList[nIndex]
      local mapItemCfg = mapItem ~= nil and ConfigTable.GetData_Item(mapItem.nTid) or nil
      self:SetItemNode(nIndex, mapItemCfg ~= nil and mapItemCfg.Icon or nil, mapItem ~= nil and mapItem.nCount or 0)
    end
  end
end

function MallCheckInItemCtrl:SetRewardItem(nDay, mapReward, bActive, bNextDay)
  self.mapReward = mapReward
  local nState = GetState(mapReward, bActive, bNextDay)
  self.nState = nState
  local bRare = mapReward.DisRare
  local bCanReceive = nState == eState.CanReceive
  local bReceived = nState == eState.Received
  self._mapNode.imgNormalBg.gameObject:SetActive(not bRare)
  self._mapNode.imgPlusBg.gameObject:SetActive(bRare)
  NovaAPI.SetTMPText(self._mapNode.txtDayNormal, tostring(nDay))
  NovaAPI.SetTMPText(self._mapNode.txtDayPlus, tostring(nDay))
  self._mapNode.imgCanReceiveBg.gameObject:SetActive(bCanReceive and not bRare)
  self._mapNode.imgPlusReceiveBg.gameObject:SetActive(bCanReceive and bRare)
  self._mapNode.imgBgDb.gameObject:SetActive(bCanReceive and not bRare)
  self._mapNode.imgPlusDb.gameObject:SetActive(bCanReceive and bRare)
  self._mapNode.imgCanReceive.gameObject:SetActive(bCanReceive)
  self._mapNode.txtCanReceive.gameObject:SetActive(bCanReceive and not bRare)
  self._mapNode.txtPlusReceive.gameObject:SetActive(bCanReceive and bRare)
  if bCanReceive then
    local sReceive = ConfigTable.GetUIText("Mall_Activity_CheckIn_Receive")
    NovaAPI.SetTMPText(self._mapNode.txtCanReceive, sReceive)
    NovaAPI.SetTMPText(self._mapNode.txtPlusReceive, sReceive)
  end
  self._mapNode.goReceived.gameObject:SetActive(bReceived)
  self._mapNode.imgNextReceive.gameObject:SetActive(not bCanReceive)
  if not bCanReceive then
    NovaAPI.SetTMPText(self._mapNode.txtNextReceive, ConfigTable.GetUIText(mapStateText[nState]))
  end
  self._mapNode.goParticle.gameObject:SetActive(bRare and not bReceived)
  self.tbRewardList = {}
  for i = 1, 3 do
    local nTid = mapReward["RewardId" .. i]
    local nCount = mapReward["Qty" .. i]
    if nTid ~= 0 then
      table.insert(self.tbRewardList, {nTid = nTid, nCount = nCount})
    end
  end
  self:RefreshItemNode(mapReward)
  self:SetItemClickable(not bCanReceive)
  self:UnBindHandler()
  self:BindHandler()
end

function MallCheckInItemCtrl:GetState()
  return self.nState
end

function MallCheckInItemCtrl:CheckCanReceive()
  return self.nState == eState.CanReceive
end

function MallCheckInItemCtrl:OnBtnClick_Item(btn, nIndex)
  if self.tbRewardList == nil or next(self.tbRewardList) == nil then
    return
  end
  UTILS.ClickItemGridWithTips(self.tbRewardList[nIndex].nTid, btn.gameObject.transform, true, true, false)
end

return MallCheckInItemCtrl
