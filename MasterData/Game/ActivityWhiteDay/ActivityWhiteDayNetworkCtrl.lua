local ActivityWhiteDayNetworkCtrl = class("ActivityWhiteDayNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityWhiteDayNetworkCtrl:ctor()
  self.productMsg = {}
  self.collectMsg = {}
  self.accMsg = {}
  self._skinBuyTable = {}
  self._historyTable = {}
end

function ActivityWhiteDayNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Product, self, proto_csmsg.SC_Activity_Factory_Product, self.SC_Activity_Factory_Product)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Order_Speed, self, proto_csmsg.SC_Activity_Factory_Order_Speed, self.SC_Activity_Factory_Order_Speed)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Collect, self, proto_csmsg.SC_Activity_Factory_Collect, self.SC_Activity_Factory_Collect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_Lottery, self, proto_csmsg.SC_Activity_Polariod_Lottery, self.SC_Activity_Polariod_Lottery)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_SelfSelect, self, proto_csmsg.SC_Activity_Polariod_SelfSelect, self.SC_Activity_Polariod_SelfSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_History, self, proto_csmsg.SC_Activity_Polariod_History, self.SC_Activity_Polariod_History)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_Buy_Skin, self, proto_csmsg.SC_Activity_Polariod_Buy_Skin, self.SC_Activity_Polariod_Buy_Skin)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Factory_Product(actFrameId, lineId, orderId, heroId, callback)
  self.productMsg.actId = actFrameId
  self.productMsg.lineId = lineId
  self.productMsg.orderId = orderId
  self.productMsg.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Product, proto_csmsg.CS_Activity_Factory_Product, self.productMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Product, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Product)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Factory_Product(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Factory_Product error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Product)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Factory_Collect(actFrameId, lineId, callback)
  self.collectMsg.actId = actFrameId
  self.collectMsg.id = lineId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Collect, proto_csmsg.CS_Activity_Factory_Collect, self.collectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Collect, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Collect)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Factory_Collect(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Factory_Collect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Collect)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Collect, msg.rewards)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Factory_Order_Speed(actFrameId, lineId, itemId, itemNum, callback)
  self.accMsg.actId = actFrameId
  self.accMsg.lineId = lineId
  self.accMsg.itemId = itemId
  self.accMsg.itemNum = itemNum
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Order_Speed, proto_csmsg.CS_Activity_Factory_Order_Speed, self.accMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Order_Speed, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Factory_Order_Speed)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Factory_Order_Speed(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.ACTIVITY_ORDER_SPEED_ITEM_TO_MUCH then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7204))
    else
      local err = "SC_Activity_Factory_Order_Speed error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Factory_Order_Speed)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Polariod_Lottery(actFrameId, callback)
  local msg = {}
  msg.actId = actFrameId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Lottery, proto_csmsg.CS_Activity_Polariod_Lottery, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Lottery, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_Lottery)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Polariod_Lottery(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Polariod_Lottery error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Lottery)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Lottery, msg.photoId)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Polariod_SelfSelect(actFrameId, selectPhotoId, callback)
  local msg = {}
  msg.actId = actFrameId
  msg.selectId = selectPhotoId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_SelfSelect, proto_csmsg.CS_Activity_Polariod_SelfSelect, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_SelfSelect, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_SelfSelect)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Polariod_SelfSelect(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Polariod_SelfSelect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_SelfSelect)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Polariod_History(actId, callback)
  self._historyTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_History, proto_csmsg.CS_Activity_Polariod_History, self._historyTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_History, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_History)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Polariod_History(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Polariod_History error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_History)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_History, msg.data)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:CS_Activity_Polariod_Buy_Skin(actFrameId, photoId, callback)
  self._skinBuyTable.actLongId = actFrameId
  self._skinBuyTable.photoId = photoId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Buy_Skin, proto_csmsg.CS_Activity_Polariod_Buy_Skin, self._skinBuyTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Buy_Skin, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Polariod_Buy_Skin)
end

function ActivityWhiteDayNetworkCtrl:SC_Activity_Polariod_Buy_Skin(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Polariod_Buy_Skin error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Buy_Skin)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Polariod_Buy_Skin, msg.data)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityWhiteDayNetworkCtrl:Reset()
end

return ActivityWhiteDayNetworkCtrl
