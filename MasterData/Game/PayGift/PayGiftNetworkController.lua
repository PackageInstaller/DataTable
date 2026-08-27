local PayGiftNetworkController = class("PayGiftNetworkController", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function PayGiftNetworkController:ctor()
  self._sendBuy = {}
end

function PayGiftNetworkController:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Gift_Buy, self, proto_csmsg.SC_Gift_Buy, self.SC_Gift_Buy)
end

function PayGiftNetworkController:CS_Gift_Buy(id, params, callback)
  self._sendBuy.giftId = id
  self._sendBuy.params = params
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Gift_Buy, proto_csmsg.CS_Gift_Buy, self._sendBuy)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Gift_Buy, callback, proto_csmsg_MSG_ID.MSG_SC_Gift_Buy)
end

function PayGiftNetworkController:SC_Gift_Buy(msg)
  if msg.ret ~= 0 then
    local err = "SC_Gift_Buy:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Gift_Buy)
  end
  if msg.rewards ~= nil and not table.IsEmptyTable(msg.rewards) then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local textMsg = ConfigData:GetTipContent(297)
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRTitle(textMsg)
      window:AddAndTryShowReward(CRData)
    end)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return PayGiftNetworkController
