local LotteryNetworkCtrl = class("LotteryNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function LotteryNetworkCtrl:ctor()
  self.onceTab = {}
  self.tenTab = {}
  self.onceSpecialTab = {}
  self.pickPtTab = {}
  self.indepChoiceTab = {}
  self.customLtrTab = {}
  self.selectPoolTab = {}
  self._customTab = {}
end

function LotteryNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce, self, proto_csmsg.SC_LOTTERY_ExecOnce, self.OnRecvExecOnce)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen, self, proto_csmsg.SC_LOTTERY_ExecTen, self.OnRecvExecTen)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnceSpecial, self, proto_csmsg.SC_LOTTERY_ExecOnceSpecial, self.SC_LOTTERY_ExecOnceSpecial)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail, self, proto_csmsg.SC_LOTTERY_Detail, self.SC_LOTTERY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_PickPt, self, proto_csmsg.SC_LOTTERY_PickPt, self.SC_LOTTERY_PickPt)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_IndepChoice, self, proto_csmsg.SC_LOTTERY_IndepChoice, self.SC_LOTTERY_IndepChoice)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_CustomisedQtt, self, proto_csmsg.SC_LOTTERY_CustomisedQtt, self.SC_LOTTERY_CustomisedQtt)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_SelectPool, self, proto_csmsg.SC_LOTTERY_SelectPool, self.SC_LOTTERY_SelectPool)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_LOTTERY_CUSTOM, self, proto_csmsg.SC_LOTTERY_CUSTOM, self.SC_LOTTERY_CUSTOM)
end

function LotteryNetworkCtrl:SC_LOTTERY_SyncDiff(msg)
  PlayerDataCenter.allLtrData:UpdAllLtrPoolData(msg.update)
  PlayerDataCenter.allLtrData:UpdSpecialAndRecordsData(msg.specialMissFixUpdate, msg.recordUpdates)
end

function LotteryNetworkCtrl:SendExecuteOnce(pool, callBack)
  self.onceTab.pool = pool
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, proto_csmsg.CS_LOTTERY_ExecOnce, self.onceTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnce)
end

function LotteryNetworkCtrl:SendExecuteTen(pool, callBack)
  self.tenTab.pool = pool
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, proto_csmsg.CS_LOTTERY_ExecTen, self.tenTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecTen)
end

function LotteryNetworkCtrl:OnRecvExecOnce(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, {
      msg.elem
    })
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce, msg.syncUpdateDiff)
  else
    local err = "OnRecvExecOnce error:" .. tostring(msg.ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnce)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function LotteryNetworkCtrl:OnRecvExecTen(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, msg.elem)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen, msg.syncUpdateDiff)
  else
    local err = "HeroNetworkCtrl:OnRecvExecTen error:" .. tostring(msg.ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecTen)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function LotteryNetworkCtrl:CS_LOTTERY_ExecOnceSpecial(poolId, callBack)
  self.onceSpecialTab.poolId = poolId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, proto_csmsg.CS_LOTTERY_ExecOnceSpecial, self.onceSpecialTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_ExecOnceSpecial)
end

function LotteryNetworkCtrl:SC_LOTTERY_ExecOnceSpecial(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_ExecOnceSpecial error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_ExecOnceSpecial, {
    msg.elem
  })
end

function LotteryNetworkCtrl:CS_LOTTERY_Detail(callBack)
  if cs_WaitNetworkResponse:ContainWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail) then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, proto_csmsg.CS_LOTTERY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_Detail)
end

function LotteryNetworkCtrl:SC_LOTTERY_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.allLtrData:UpdAllLtrPoolData(msg.detail)
  PlayerDataCenter.allLtrData:UpdSpecialAndRecordsData(msg.specialMissFix, msg.records)
  PlayerDataCenter.allLtrData:SetDrawHeroRankCount(msg.drawHeroRankCount)
  PlayerDataCenter.allLtrData:UpdGroupSelectTagData(msg.selectedPoolId)
end

function LotteryNetworkCtrl:CS_LOTTERY_PickPt(poolId, pickKey, callBack)
  self.pickPtTab.poolId = poolId
  self.pickPtTab.pickKey = pickKey
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt, proto_csmsg.CS_LOTTERY_PickPt, self.pickPtTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_PickPt)
end

function LotteryNetworkCtrl:SC_LOTTERY_PickPt(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_PickPt error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_PickPt)
    return
  end
end

function LotteryNetworkCtrl:CS_LOTTERY_IndepChoice(poolId, itemId, callBack)
  self.indepChoiceTab.poolId = poolId
  self.indepChoiceTab.itemId = itemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_IndepChoice, proto_csmsg.CS_LOTTERY_IndepChoice, self.indepChoiceTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_IndepChoice, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_IndepChoice)
end

function LotteryNetworkCtrl:SC_LOTTERY_IndepChoice(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_IndepChoice error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_IndepChoice)
    return
  end
end

function LotteryNetworkCtrl:CS_LOTTERY_CustomisedQtt(poolId, num, callBack)
  self.customLtrTab.poolId = poolId
  self.customLtrTab.quantities = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CustomisedQtt, proto_csmsg.CS_LOTTERY_CustomisedQtt, self.customLtrTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CustomisedQtt, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_CustomisedQtt)
end

function LotteryNetworkCtrl:SC_LOTTERY_CustomisedQtt(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_CustomisedQtt error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CustomisedQtt)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CustomisedQtt, msg.elem)
end

function LotteryNetworkCtrl:CS_LOTTERY_SelectPool(poolGroupId, poolId, callBack)
  self.selectPoolTab.poolGroupId = poolGroupId
  self.selectPoolTab.poolId = poolId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_SelectPool, proto_csmsg.CS_LOTTERY_SelectPool, self.selectPoolTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_SelectPool, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_SelectPool)
end

function LotteryNetworkCtrl:SC_LOTTERY_SelectPool(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_SelectPool error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_SelectPool)
    return
  end
end

function LotteryNetworkCtrl:CS_LOTTERY_CUSTOM(poolId, rewardType, itemIdList, callBack)
  self._customTab.poolId = poolId
  self._customTab.rewardType = rewardType
  self._customTab.custom = {itemReward = itemIdList}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CUSTOM, proto_csmsg.CS_LOTTERY_CUSTOM, self._customTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CUSTOM, callBack, proto_csmsg_MSG_ID.MSG_SC_LOTTERY_CUSTOM)
end

function LotteryNetworkCtrl:SC_LOTTERY_CUSTOM(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_LOTTERY_CUSTOM error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_LOTTERY_CUSTOM)
    return
  end
end

function LotteryNetworkCtrl:Reset()
end

return LotteryNetworkCtrl
