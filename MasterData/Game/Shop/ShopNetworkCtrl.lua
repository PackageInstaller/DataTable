local ShopNetworkCtrl = class("ShopNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ShopNetworkCtrl:ctor()
  self.rechargeTab = {}
  self.refreshTable = {}
  self._reqShopTable = {}
  self._reqFntBatchTable = {}
end

function ShopNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STORE_Detail, self, proto_csmsg.SC_STORE_Detail, self.SC_STORE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STORE_Purchase, self, proto_csmsg.SC_STORE_Purchase, self.SC_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STORE_Fresh, self, proto_csmsg.SC_STORE_Fresh, self.SC_STORE_Fresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STORE_Recharge, self, proto_csmsg.SC_STORE_Recharge, self.SC_STORE_Recharge)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Store_Recharge_Ntf, self, proto_csmsg.SC_Store_Recharge_Ntf, self.SC_Store_Recharge_Ntf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_PickAstPoint, self, proto_csmsg.SC_ASSISTANT_PickAstPoint, self.SC_ASSISTANT_PickAstPoint)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STORE_Purchase_Batch, self, proto_csmsg.SC_STORE_Purchase_Batch, self.SC_STORE_Purchase_Batch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_Exchange, self, proto_csmsg.SC_BACKPACK_Exchange, self.SC_BACKPACK_Exchange)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Hero_Fragment_Redeem, self, proto_csmsg.SC_Hero_Fragment_Redeem, self.SC_Hero_Fragment_Redeem)
end

function ShopNetworkCtrl:CS_STORE_Detail(storeId, callback)
  self._reqShopTable.storeId = storeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STORE_Detail, proto_csmsg.CS_STORE_Detail, self._reqShopTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_STORE_Detail)
end

function ShopNetworkCtrl:SC_STORE_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_STORE_Detail error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_STORE_Detail, msg.data)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ShopNetworkCtrl:CS_STORE_Purchase_Batch(storeId, shelf2Cnt, callback)
  self._reqFntBatchTable.storeId = storeId
  self._reqFntBatchTable.shelf2Cnt = shelf2Cnt
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase_Batch, proto_csmsg.CS_STORE_Purchase_Batch, self._reqFntBatchTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase_Batch, callback, proto_csmsg_MSG_ID.MSG_SC_STORE_Purchase_Batch)
end

function ShopNetworkCtrl:SC_STORE_Purchase_Batch(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_ITEM_OVERFLOW then
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase_Batch)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      return
    end
    local err = "SC_STORE_Purchase_Batch error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase_Batch)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase_Batch, msg.data)
  end
end

function ShopNetworkCtrl:CS_STORE_Purchase(storeId, shelfId, cnt, callback)
  local msg = {}
  msg.storeId = storeId
  msg.shelfId = shelfId
  msg.cnt = cnt
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase, proto_csmsg.CS_STORE_Purchase, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase, callback, proto_csmsg_MSG_ID.MSG_SC_STORE_Purchase)
end

function ShopNetworkCtrl:SC_STORE_Purchase(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_ITEM_OVERFLOW then
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      return
    end
    local err = "SC_STORE_Purchase error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase, msg.data)
  end
  if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack ~= nil then
    local addInfo = {}
    local isHaveAddInfo = false
    local randomPackage = msg.syncUpdateDiff.resource.backpack.randomPackage
    if randomPackage ~= nil then
      isHaveAddInfo = true
      addInfo.purchase_randomPackage = randomPackage
    end
    local overflow = msg.syncUpdateDiff.resource.backpack.overflow
    if overflow ~= nil then
      isHaveAddInfo = true
      addInfo.purchase_overflowInfo = overflow
    end
    if isHaveAddInfo then
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_STORE_Purchase, addInfo)
    end
  end
end

function ShopNetworkCtrl:CS_BACKPACK_Exchange(toId, num, callback)
  local msg = {}
  msg.toId = toId
  msg.num = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_Exchange, proto_csmsg.CS_BACKPACK_Exchange, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_Exchange, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_Exchange)
end

function ShopNetworkCtrl:SC_BACKPACK_Exchange(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BACKPACK_Exchange error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_Exchange)
  else
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ShopNetworkCtrl:CS_STORE_Fresh(storeId, callback)
  self.refreshTable.storeId = storeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STORE_Fresh, proto_csmsg.CS_STORE_Fresh, self.refreshTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Fresh, callback, proto_csmsg_MSG_ID.MSG_SC_STORE_Fresh)
end

function ShopNetworkCtrl:SC_STORE_Fresh(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_STORE_Fresh error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Fresh)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_STORE_Fresh, msg.data)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ShopNetworkCtrl:CS_STORE_Recharge(payId, callback)
  self.rechargeTab.payId = payId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STORE_Recharge, proto_csmsg.CS_STORE_Recharge, self.rechargeTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Recharge, callback, proto_csmsg_MSG_ID.MSG_SC_STORE_Recharge)
end

function ShopNetworkCtrl:SC_STORE_Recharge(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_STORE_Recharge error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STORE_Recharge)
  end
end

function ShopNetworkCtrl:SC_Store_Recharge_Ntf(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.data ~= nil then
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
    if shopCtrl ~= nil then
      shopCtrl:AfterShopRechargeComplete(msg.data)
    end
  end
end

function ShopNetworkCtrl:CS_ASSISTANT_PickAstPoint(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_PickAstPoint, proto_csmsg.CS_ASSISTANT_PickAstPoint, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_PickAstPoint, callback, proto_csmsg_MSG_ID.MSG_SC_ASSISTANT_PickAstPoint)
end

function ShopNetworkCtrl:SC_ASSISTANT_PickAstPoint(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ASSISTANT_PickAstPoint error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_PickAstPoint)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ASSISTANT_PickAstPoint, msg.total)
  end
end

function ShopNetworkCtrl:CS_Hero_Fragment_Redeem(selectedFragDic, callback)
  local msg = {}
  msg.data = selectedFragDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Hero_Fragment_Redeem, proto_csmsg.CS_Hero_Fragment_Redeem, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Hero_Fragment_Redeem, callback, proto_csmsg_MSG_ID.MSG_SC_Hero_Fragment_Redeem)
end

function ShopNetworkCtrl:SC_Hero_Fragment_Redeem(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Hero_Fragment_Redeem error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Hero_Fragment_Redeem)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Hero_Fragment_Redeem, msg.rewards)
  end
end

function ShopNetworkCtrl:Reset()
end

return ShopNetworkCtrl
