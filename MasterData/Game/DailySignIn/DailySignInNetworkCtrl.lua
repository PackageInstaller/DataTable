local DailySignInNetworkCtrl = class("DailySignInNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function DailySignInNetworkCtrl:ctor()
  self.monthCardMsg = {monthCardId = nil, payId = nil}
end

function DailySignInNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_Detail, self, proto_csmsg.SC_MONTH_CARD_Detail, self.SC_MONTH_CARD_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_Changed_Ntf, self, proto_csmsg.SC_MONTH_CARD_Changed_Ntf, self.SC_MONTH_CARD_Changed_Ntf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_BUY, self, proto_csmsg.SC_MONTH_CARD_BUY, self.SC_MONTH_CARD_BUY)
end

function DailySignInNetworkCtrl:CS_MONTH_CARD_BUY(monthCardId, id, callback)
  self.monthCardMsg.monthCardId = monthCardId
  self.monthCardMsg.payId = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_BUY, proto_csmsg.CS_MONTH_CARD_BUY, self.monthCardMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_BUY, callback, proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_BUY)
end

function DailySignInNetworkCtrl:SC_MONTH_CARD_BUY(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_MONTH_CARD_BUY error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(errorMsg)
    end
  end
  local dailySignInData = PlayerDataCenter.dailySignInData
  local isDiscount = dailySignInData:IsCardDiscount(self.monthCardMsg.monthCardId)
  local monthCard = ConfigData.month_card[self.monthCardMsg.monthCardId]
  local productId = monthCard.price
  if isDiscount then
    productId = monthCard.discount_price
  end
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay)
  payCtr:ReqPay(productId, 1)
end

function DailySignInNetworkCtrl:CS_MONTH_CARD_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_Detail, proto_csmsg.CS_MONTH_CARD_Detail, table.emptytable)
end

function DailySignInNetworkCtrl:SC_MONTH_CARD_Detail(msg)
  if msg == nil then
    local errorMsg = "DailySignInNetworkCtrl:SC_MONTH_CARD_Detail error"
    error(errorMsg)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(errorMsg)
    end
  end
  if msg.data ~= nil and msg.data.monthCards ~= nil then
    self:ApplyMonthCardDiff(msg.data.monthCards)
  end
end

function DailySignInNetworkCtrl:SC_MONTH_CARD_Changed_Ntf(msg)
  if msg == nil then
    local errorMsg = "DailySignInNetworkCtrl:SC_MONTH_CARD_Changed_Ntf error"
    error(errorMsg)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(errorMsg)
    end
  end
  if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack.updates ~= nil then
    local firstBuyReward = {}
    local isHaveReard
    for itemId, data in pairs(msg.syncUpdateDiff.resource.backpack.updates) do
      local addNum = data.count - PlayerDataCenter:GetItemCount(itemId)
      if 0 < addNum then
        firstBuyReward[itemId] = (firstBuyReward[itemId] or 0) + addNum
        isHaveReard = true
      end
    end
    if isHaveReard then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseDic(firstBuyReward):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRTitle(ConfigData:GetTipContent(14026))
        window:AddAndTryShowReward(CRData)
      end)
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function DailySignInNetworkCtrl:ApplyMonthCardDiff(diffMsgDic)
  PlayerDataCenter.dailySignInData:UpadteMonthCardData(diffMsgDic)
end

function DailySignInNetworkCtrl:Reset()
end

return DailySignInNetworkCtrl
