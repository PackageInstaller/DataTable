local ActivityCollectFortuneNetworkCtrl = class("ActivityCollectFortuneNetworkCtrl", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityCollectFortuneNetworkCtrl:ctor()
  self._drawTable = {}
end

function ActivityCollectFortuneNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActCollectFortune_Draw, self, proto_csmsg.SC_ActCollectFortune_Draw, self.SC_ActCollectFortune_Draw)
end

function ActivityCollectFortuneNetworkCtrl:CS_ActCollectFortune_Draw(actId, itemTable, callback)
  self._drawTable.actId = actId
  self._drawTable.item1 = itemTable[1]
  self._drawTable.item2 = itemTable[2]
  self._drawTable.item3 = itemTable[3]
  self._drawTable.item4 = itemTable[4]
  self._drawTable.item5 = itemTable[5]
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActCollectFortune_Draw, proto_csmsg.CS_ActCollectFortune_Draw, self._drawTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActCollectFortune_Draw, callback, proto_csmsg_MSG_ID.MSG_SC_ActCollectFortune_Draw)
end

function ActivityCollectFortuneNetworkCtrl:SC_ActCollectFortune_Draw(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.err ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActCollectFortune_Draw error:" .. tostring(msg.err)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActCollectFortune_Draw)
    return
  end
  local collectFortuneCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune, true)
  local data = collectFortuneCtrl:GetCollectFortuneData()
  local showOverFunc
  if data ~= nil then
    data:UpdateActCollectFortuneRewardGot(msg.actData.rewardGot)
    local poolId = data:GetActCollectFortunePoolId()
    if poolId ~= msg.actData.poolId then
      function showOverFunc()
        cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50008))
      end
    end
    data:UpdateActCollectFortunePoolId(msg.actData.poolId)
  end
  UIUtil.ShowCommonReward(msg.rewards, nil, showOverFunc)
end

return ActivityCollectFortuneNetworkCtrl
