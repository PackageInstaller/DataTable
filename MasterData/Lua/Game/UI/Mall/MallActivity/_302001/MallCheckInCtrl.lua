local MallCheckInCtrl = class("MallCheckInCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
MallCheckInCtrl._mapNodeConfig = {
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  txtActivityTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Activity_CheckIn_LeftTimeTitle"
  },
  txtActivityTimeDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Activity_CheckIn_ReceiveTips"
  },
  goRewardItem = {
    nCount = 5,
    sCtrlName = "Game.UI.Mall.MallActivity._302001.MallCheckInItemCtrl"
  },
  btnRewardItem = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnBuyDisable = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyDisable"
  },
  txtBtnBuyDisable = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Activity_CheckIn_Btn_Done"
  },
  txtBtnBuy = {sComponentName = "TMP_Text"}
}
MallCheckInCtrl._mapEventConfig = {}

function MallCheckInCtrl:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    if self.remainTimer then
      TimerManager.Remove(self.remainTimer)
      self.remainTimer = nil
    end
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, sTimeStr)
end

function MallCheckInCtrl:RefreshRewardList()
  local actData = self.actData
  local tbRewardList = actData:GetActLoginRewardList()
  local nNextDay = actData:GetCanReceive() + 1
  local bPurchased = self.bPurchased
  for k, itemCtrl in ipairs(self._mapNode.goRewardItem) do
    local mapReward = tbRewardList[k]
    self._mapNode.btnRewardItem[k].gameObject:SetActive(mapReward ~= nil)
    if mapReward ~= nil then
      itemCtrl:SetRewardItem(k, mapReward, bPurchased, k == nNextDay)
    end
  end
end

function MallCheckInCtrl:RefreshDetail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local bEmpty = mapActCfg.DesText == ""
  self._mapNode.btnDetail.gameObject:SetActive(not bEmpty)
end

function MallCheckInCtrl:RefreshBuy()
  self.mapProductCfg = PlayerData.Mall:GetMallActivityCfgByActId(self.nActId)
  local actData = self.actData
  local bActive = actData:GetActive() or self.mapProductCfg ~= nil and PlayerData.Mall:CheckMallActivityPurchased(self.mapProductCfg.Id)
  self.bPurchased = bActive
  if self.mapProductCfg == nil then
    self._mapNode.btnBuy.gameObject:SetActive(false)
    self._mapNode.btnBuyDisable.gameObject:SetActive(false)
    return
  end
  self._mapNode.btnBuy.gameObject:SetActive(not bActive)
  self._mapNode.btnBuyDisable.gameObject:SetActive(bActive)
  if bActive then
    NovaAPI.SetTMPText(self._mapNode.txtBtnBuyDisable, ConfigTable.GetUIText("Mall_Package_SoldOut"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnBuy, tostring(self.mapProductCfg.ShowPrice))
  end
end

function MallCheckInCtrl:CheckBuySucTip()
  local actData = self.actData
  if not self.bPurchased or actData:GetReceived() > 0 then
    return
  end
  local sKey = "Mall_CheckIn_BuySucTip_" .. self.nActId
  if LocalData.GetPlayerLocalData(sKey) then
    return
  end
  LocalData.SetPlayerLocalData(sKey, true)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mall_Activity_CheckIn_BuySuc"))
end

function MallCheckInCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshBuy()
  self:RefreshRewardList()
  self:RefreshDetail()
  self:CheckBuySucTip()
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
    end
  end
end

function MallCheckInCtrl:ReceiveReward()
  local function callback()
    self:RefreshBuy()
    
    self:RefreshRewardList()
  end
  
  PlayerData.Activity:SendReceiveMallLoginRewardMsg(self.nActId, callback)
end

function MallCheckInCtrl:Awake()
  self.actData = nil
  self.mapProductCfg = nil
  self.bPurchased = false
end

function MallCheckInCtrl:OnEnable()
end

function MallCheckInCtrl:OnDisable()
end

function MallCheckInCtrl:OnDestroy()
end

function MallCheckInCtrl:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function MallCheckInCtrl:OnBtnClick_Item(btn, nIndex)
  local itemCtrl = self._mapNode.goRewardItem[nIndex]
  if itemCtrl == nil then
    return
  end
  if not self.actData:CheckCanReceive() or not itemCtrl:CheckCanReceive() then
    return
  end
  self:ReceiveReward()
end

function MallCheckInCtrl:OnBtnClick_Buy()
  local mapProductCfg = self.mapProductCfg
  if mapProductCfg == nil then
    return
  end
  if self.bPurchased then
    self:RefreshBuy()
    return
  end
  PlayerData.Mall:BuyMallActivity(mapProductCfg.Id, mapProductCfg.StatisticalGroup)
end

function MallCheckInCtrl:OnBtnClick_BuyDisable()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_GoodsEmpty"))
end

return MallCheckInCtrl
