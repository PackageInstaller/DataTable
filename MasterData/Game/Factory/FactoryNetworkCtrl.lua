local FactoryNetworkCtrl = class("FactoryNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function FactoryNetworkCtrl:ctor()
  self.sendDataFactoryInstall = {}
  self.sendDataFactoryDestruct = {}
  self.sendDataFactoryRewardPick = {}
  self.ProductMsg = {}
  self.cancleOrderMsg = {}
end

function FactoryNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail, self, proto_csmsg.SC_FACTORY_Detail, self.SC_FACTORY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct, self, proto_csmsg.SC_FACTORY_WorkshopProduct, self.SC_FACTORY_WorkshopProduct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_ConsumeTimeProduct, self, proto_csmsg.SC_FACTORY_ConsumeTimeProduct, self.SC_FACTORY_ConsumeTimeProduct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_CancelOrder, self, proto_csmsg.SC_FACTORY_CancelOrder, self.SC_FACTORY_CancelOrder)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_ImmediatelyComplete, self, proto_csmsg.SC_FACTORY_ImmediatelyComplete, self.SC_FACTORY_ImmediatelyComplete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_Collect, self, proto_csmsg.SC_FACTORY_Collect, self.SC_FACTORY_Collect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_OneKeyCollect, self, proto_csmsg.SC_FACTORY_OneKeyCollect, self.SC_FACTORY_OneKeyCollect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FACTORY_MultProduct, self, proto_csmsg.SC_FACTORY_MultProduct, self.SC_FACTORY_MultProduct)
end

function FactoryNetworkCtrl:CS_FACTORY_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, proto_csmsg.CS_FACTORY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_Detail)
end

function FactoryNetworkCtrl:SC_FACTORY_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Detail)
  else
    ControllerManager:GetController(ControllerTypeId.Factory, false):OnRecRoomHeroList(msg.detail.workshopGroup)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:FactoryCommonDiff(msg)
  ControllerManager:GetController(ControllerTypeId.Factory, false):HandleFactoryDiff(msg)
end

function FactoryNetworkCtrl:CS_FACTORY_WorkshopProduct(Order4SendData, callback)
  self.ProductMsg.id = Order4SendData.lineIndex
  self.ProductMsg.order = Order4SendData.curOrderId
  self.ProductMsg.orderNum = Order4SendData.curOrderNum
  self.ProductMsg.assistOrders = Order4SendData.assistOrderDic
  self.ProductMsg.helpList = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, proto_csmsg.CS_FACTORY_WorkshopProduct, self.ProductMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_WorkshopProduct)
end

function FactoryNetworkCtrl:SC_FACTORY_WorkshopProduct(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_WorkshopProduct error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_WorkshopProduct)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_ConsumeTimeProduct(Order4SendData, callback)
  self.ProductMsg.id = Order4SendData.lineIndex
  self.ProductMsg.order = Order4SendData.curOrderId
  self.ProductMsg.orderNum = Order4SendData.curOrderNum
  self.ProductMsg.assistOrders = Order4SendData.assistOrderDic
  self.ProductMsg.isMax = Order4SendData.isOrderMax
  self.ProductMsg.helpList = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct, proto_csmsg.CS_FACTORY_ConsumeTimeProduct, self.ProductMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_ConsumeTimeProduct)
end

function FactoryNetworkCtrl:SC_FACTORY_ConsumeTimeProduct(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_ConsumeTimeProduct error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ConsumeTimeProduct)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_CancelOrder(roomIndex, uid, callback)
  self.cancleOrderMsg.workshopId = roomIndex
  self.cancleOrderMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder, proto_csmsg.CS_FACTORY_CancelOrder, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_CancelOrder)
end

function FactoryNetworkCtrl:SC_FACTORY_CancelOrder(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_CancelOrder error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_CancelOrder)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_ImmediatelyComplete(roomIndex, uid, callback)
  self.cancleOrderMsg.workshopId = roomIndex
  self.cancleOrderMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete, proto_csmsg.CS_FACTORY_ImmediatelyComplete, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_ImmediatelyComplete)
end

function FactoryNetworkCtrl:SC_FACTORY_ImmediatelyComplete(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_ImmediatelyComplete error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_ImmediatelyComplete)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_Collect(roomIndex, uid, callback)
  self.cancleOrderMsg.workshopId = roomIndex
  self.cancleOrderMsg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect, proto_csmsg.CS_FACTORY_Collect, self.cancleOrderMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_Collect)
end

function FactoryNetworkCtrl:SC_FACTORY_Collect(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_Collect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_Collect)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_OneKeyCollect(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_OneKeyCollect, proto_csmsg.CS_FACTORY_OneKeyCollect, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_OneKeyCollect, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_OneKeyCollect)
end

function FactoryNetworkCtrl:SC_FACTORY_OneKeyCollect(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_OneKeyCollect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_OneKeyCollect)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:CS_FACTORY_MultProduct(orders, callback)
  local sendMsg = {}
  sendMsg.orders = orders
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FACTORY_MultProduct, proto_csmsg.CS_FACTORY_MultProduct, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_MultProduct, callback, proto_csmsg_MSG_ID.MSG_SC_FACTORY_MultProduct)
end

function FactoryNetworkCtrl:SC_FACTORY_MultProduct(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FactoryNetworkCtrl:SC_FACTORY_MultProduct error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FACTORY_MultProduct)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FactoryNetworkCtrl:Reset()
end

return FactoryNetworkCtrl
