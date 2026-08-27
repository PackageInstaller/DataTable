local ActivitySectorINetworkCtrl = class("ActivitySectorINetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySectorINetworkCtrl:ctor()
  self._purchaseAdditionalTable = {}
  self._execLotteryTab = {}
  self._nextLotteryRoundTab = {}
end

function ActivitySectorINetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_Detail, self, proto_csmsg.SC_ACTIVITYSECTORI_Detail, self.SC_ACTIVITYSECTORI_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_PurchaseAdditionalTimes, self, proto_csmsg.SC_ACTIVITYSECTORI_PurchaseAdditionalTimes, self.SC_ACTIVITYSECTORI_PurchaseAdditionalTimes)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_ExecLottery, self, proto_csmsg.SC_ACTIVITYSECTORI_ExecLottery, self.SC_ACTIVITYSECTORI_ExecLottery)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_NextLotteryRound, self, proto_csmsg.SC_ACTIVITYSECTORI_NextLotteryRound, self.SC_ACTIVITYSECTORI_NextLotteryRound)
end

function ActivitySectorINetworkCtrl:CS_ACTIVITYSECTORI_Detail_NOWait()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_Detail, proto_csmsg.CS_ACTIVITYSECTORI_Detail, table.emptytable)
end

function ActivitySectorINetworkCtrl:CS_ACTIVITYSECTORI_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_Detail, proto_csmsg.CS_ACTIVITYSECTORI_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_Detail)
end

function ActivitySectorINetworkCtrl:SC_ACTIVITYSECTORI_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.allActivitySectorIData:UpdateSectorIMsg(msg.data)
end

function ActivitySectorINetworkCtrl:CS_ACTIVITYSECTORI_PurchaseAdditionalTimes(actId, callBack)
  self._purchaseAdditionalTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_PurchaseAdditionalTimes, proto_csmsg.CS_ACTIVITYSECTORI_PurchaseAdditionalTimes, self._purchaseAdditionalTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_PurchaseAdditionalTimes, callBack, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_PurchaseAdditionalTimes)
end

function ActivitySectorINetworkCtrl:SC_ACTIVITYSECTORI_PurchaseAdditionalTimes(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSECTORI_PurchaseAdditionalTimes error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivitySectorINetworkCtrl:SC_ACTIVITYSECTORI_SyncDiff(msg)
  PlayerDataCenter.allActivitySectorIData:UpdateSectorIMsg(msg.data)
end

function ActivitySectorINetworkCtrl:CS_ACTIVITYSECTORI_ExecLottery(actId, num, callBack)
  self._execLotteryTab.actId = actId
  self._execLotteryTab.num = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_ExecLottery, proto_csmsg.CS_ACTIVITYSECTORI_ExecLottery, self._execLotteryTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_ExecLottery, callBack, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_ExecLottery)
end

function ActivitySectorINetworkCtrl:SC_ACTIVITYSECTORI_ExecLottery(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSECTORI_ExecLottery error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_ExecLottery)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_ExecLottery, msg)
end

function ActivitySectorINetworkCtrl:CS_ACTIVITYSECTORI_NextLotteryRound(actId, callBack)
  self._nextLotteryRoundTab.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_NextLotteryRound, proto_csmsg.CS_ACTIVITYSECTORI_NextLotteryRound, self._nextLotteryRoundTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_NextLotteryRound, callBack, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_NextLotteryRound)
end

function ActivitySectorINetworkCtrl:SC_ACTIVITYSECTORI_NextLotteryRound(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSECTORI_NextLotteryRound error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSECTORI_NextLotteryRound)
  end
end

return ActivitySectorINetworkCtrl
