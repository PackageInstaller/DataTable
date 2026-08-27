local PayNetworkCtrl = class("PayNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MicaSDKManager = CS.MicaSDKManager

function PayNetworkCtrl:ctor()
  self._fakeRechargeTab = {}
  self._rechargeFreeTab = {}
end

function PayNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards, self, proto_csmsg.SC_RECHARGE_ConfirmRewards, self.SC_RECHARGE_ConfirmRewards)
end

function PayNetworkCtrl:CS_RECHARGE_FakeRecharge(goodId, amount, callBack)
  self._fakeRechargeTab.goodId = goodId
  self._fakeRechargeTab.amount = amount
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_FakeRecharge, proto_csmsg.CS_RECHARGE_FakeRecharge, self._fakeRechargeTab)
  cs_WaitNetworkResponse:StartWait(eCustomWaitType.WaitPayFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards)
end

function PayNetworkCtrl:SC_RECHARGE_ConfirmRewards(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_rechargeState.rechargeStateNone then
    if cs_WaitNetworkResponse:ContainWait(eCustomWaitType.WaitPayFinish) then
      cs_WaitNetworkResponse:AddWaitData(eCustomWaitType.WaitPayFinish, msg.rb)
    else
      ControllerManager:GetController(ControllerTypeId.Pay, true):ShowPayReward(msg.rb)
    end
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.WaitPayFinish)
    if not cs_MicaSDKManager.Instance:IsUseSdk() then
      cs_MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(10005), nil)
    end
  end
end

function PayNetworkCtrl:CS_RECHARGE_ConfirmRewards()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_ConfirmRewards, proto_csmsg.CS_RECHARGE_ConfirmRewards, table.emptytable)
end

function PayNetworkCtrl:CS_RECHARGE_RechargeFree(goodId, callBack)
  self._rechargeFreeTab.goodId = goodId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_RechargeFree, proto_csmsg.CS_RECHARGE_RechargeFree, self._rechargeFreeTab)
  cs_WaitNetworkResponse:StartWait(eCustomWaitType.WaitPayFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards)
end

function PayNetworkCtrl:Reset()
end

return PayNetworkCtrl
