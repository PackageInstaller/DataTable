local ArithmeticNetwork = class("ArithmeticNetwork", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ArithmeticNetwork:ctor()
  self.__athDetailTab = {}
  self.__athInstallTab = {}
  self.__athUninstallTab = {}
  self.__athMoveTab = {}
  self.__slotUpdateTab = {}
  self.__athOptimizeTab = {}
  self.__athLockTab = {}
  self.__athDecoTab = {}
  self.__athAutoDecoTab = {}
  self.__oneKeyInstallTab = {}
  self.__onekeyUninstallTab = {}
  self.__recoExecTab = {}
  self.__recoSaveTab = {}
  self.__recoDropTab = {}
  self.__affixLockTab = {}
  self.__statTab = nil
end

function ArithmeticNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Detail, self, proto_csmsg.SC_ATH_Detail, self.SC_ATH_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_DetailBatch, self, proto_csmsg.SC_ATH_DetailBatch, self.SC_ATH_DetailBatch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff, self, proto_csmsg.SC_ATH_SyncUpdateDiff, self.SC_ATH_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthRefillOp, self, proto_csmsg.SC_ATH_AthRefillOp, self.SC_ATH_AthRefillOp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthUninstall, self, proto_csmsg.SC_ATH_AthUninstall, self.SC_ATH_AthUninstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Move, self, proto_csmsg.SC_ATH_Move, self.SC_ATH_Move)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_SlotUpgrade, self, proto_csmsg.SC_ATH_SlotUpgrade, self.SC_ATH_SlotUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthOptimize, self, proto_csmsg.SC_ATH_AthOptimize, self.SC_ATH_AthOptimize)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthLock, self, proto_csmsg.SC_ATH_AthLock, self.SC_ATH_AthLock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyDeco, self, proto_csmsg.SC_ATH_OneKeyDeco, self.SC_ATH_OneKeyDeco)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Ath_AutoDecoSetting, self, proto_csmsg.SC_Ath_AutoDecoSetting, self.SC_Ath_AutoDecoSetting)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyInstall, self, proto_csmsg.SC_ATH_OneKeyInstall, self.SC_ATH_OneKeyInstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyUninstall, self, proto_csmsg.SC_ATH_OneKeyUninstall, self.SC_ATH_OneKeyUninstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionExec, self, proto_csmsg.SC_ATH_ReconsitutionExec, self.SC_ATH_ReconsitutionExec)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AffixLockUnlock, self, proto_csmsg.SC_ATH_AffixLockUnlock, self.SC_ATH_AffixLockUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionSave, self, proto_csmsg.SC_ATH_ReconsitutionSave, self.SC_ATH_ReconsitutionSave)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionDrop, self, proto_csmsg.SC_ATH_ReconsitutionDrop, self.SC_ATH_ReconsitutionDrop)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Stat, self, proto_csmsg.SC_ATH_Stat, self.SC_ATH_Stat)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Sign, self, proto_csmsg.SC_ATH_Sign, self.SC_ATH_Sign)
end

function ArithmeticNetwork:CS_ATH_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Detail, proto_csmsg.CS_ATH_Detail, self.__athDetailTab)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Detail, proto_csmsg_MSG_ID.MSG_SC_ATH_Detail)
end

function ArithmeticNetwork:SC_ATH_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  self.__detailBatchSize = msg.batchSize
  self.__curDetailBatchCount = 0
  if self.__detailBatchSize ~= 0 then
    cs_WaitNetworkResponse:StartWait(eCustomWaitType.WaitAthDetailBatch, eCustomWaitType.WaitAthDetailBatch)
  end
  PlayerDataCenter.allAthData:InitAllAthData(msg)
end

function ArithmeticNetwork:SC_ATH_DetailBatch(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.allAthData:InitBatchAllAthData(msg)
  self.__curDetailBatchCount = self.__curDetailBatchCount + 1
  if self.__curDetailBatchCount >= self.__detailBatchSize then
    cs_WaitNetworkResponse:RemoveWait(eCustomWaitType.WaitAthDetailBatch)
  end
end

function ArithmeticNetwork:SC_ATH_SyncUpdateDiff(msg)
  local updateHeroIdDic = {}
  for uid, v in pairs(msg.updateAth) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    if athData ~= nil and athData.bindInfo ~= nil then
      updateHeroIdDic[athData.bindInfo.id] = true
    end
    if v.bindInfo ~= nil then
      updateHeroIdDic[v.bindInfo.id] = true
    end
  end
  PlayerDataCenter.allAthData:SyncAthDiff(msg)
  MsgCenter:Broadcast(eMsgEventId.OnAthDataUpdate, msg.updateAth, msg.heroSlot, msg.deleteAth, updateHeroIdDic)
  MsgCenter:Broadcast(eMsgEventId.OnAthDataUpdate1, msg.updateAth, msg.heroSlot, msg.deleteAth, updateHeroIdDic)
end

function ArithmeticNetwork:CS_ATH_AthRefillOp(heroId, slotIdx, uid, gridId, oldMove, op, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athInstallTab.heroId = heroId
  self.__athInstallTab.slotIdx = slotIdx
  self.__athInstallTab.uid = uid
  self.__athInstallTab.gridId = gridId
  self.__athInstallTab.oldMove = oldMove
  self.__athInstallTab.op = op
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, proto_csmsg.CS_ATH_AthRefillOp, self.__athInstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthRefillOp)
end

function ArithmeticNetwork:SC_ATH_AthRefillOp(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthRefillOp error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp)
  end
end

function ArithmeticNetwork:CS_ATH_AthUninstall(uid, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athUninstallTab.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall, proto_csmsg.CS_ATH_AthUninstall, self.__athUninstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthUninstall)
end

function ArithmeticNetwork:SC_ATH_AthUninstall(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthUninstall error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall)
  end
end

function ArithmeticNetwork:CS_ATH_Move(uid, gridId, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athMoveTab.uid = uid
  self.__athMoveTab.gridId = gridId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Move, proto_csmsg.CS_ATH_Move, self.__athMoveTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Move, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_Move)
end

function ArithmeticNetwork:SC_ATH_Move(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_Move error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Move)
  end
end

function ArithmeticNetwork:CS_ATH_SlotUpgrade(heroId, itemDic, athDic, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__slotUpdateTab.heroId = heroId
  self.__slotUpdateTab.item = itemDic
  self.__slotUpdateTab.ath = athDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_SlotUpgrade, proto_csmsg.CS_ATH_SlotUpgrade, self.__slotUpdateTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_SlotUpgrade, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_SlotUpgrade)
end

function ArithmeticNetwork:SC_ATH_SlotUpgrade(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_SlotUpgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_SlotUpgrade)
  end
end

function ArithmeticNetwork:CS_ATH_AthOptimize(uid, idx, sect, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athOptimizeTab.uid = uid
  self.__athOptimizeTab.idx = idx
  self.__athOptimizeTab.sect = sect
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, proto_csmsg.CS_ATH_AthOptimize, self.__athOptimizeTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthOptimize)
end

function ArithmeticNetwork:SC_ATH_AthOptimize(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthOptimize error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize)
    return
  end
  PlayerDataCenter.allAthData:UpdateAthFalure(msg.failure)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, msg.result)
  if not msg.result then
    cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize)
  end
end

function ArithmeticNetwork:CS_ATH_AthLock(uid, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athLockTab.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock, proto_csmsg.CS_ATH_AthLock, self.__athLockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthLock)
end

function ArithmeticNetwork:SC_ATH_AthLock(msg)
  MsgCenter:Broadcast(eMsgEventId.OnAthLockPre, self.__athLockTab.uid)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthLock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock)
    return
  end
end

function ArithmeticNetwork:CS_ATH_OneKeyDeco(DecoDic, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athDecoTab.uids = DecoDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco, proto_csmsg.CS_ATH_OneKeyDeco, self.__athDecoTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyDeco)
end

function ArithmeticNetwork:SC_ATH_OneKeyDeco(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyDeco error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco, msg.data)
  end
end

function ArithmeticNetwork:CS_Ath_AutoDecoSetting(autoDecoConfig, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__athAutoDecoTab.setting = autoDecoConfig
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting, proto_csmsg.CS_Ath_AutoDecoSetting, self.__athAutoDecoTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting, callBack, proto_csmsg_MSG_ID.MSG_SC_Ath_AutoDecoSetting)
end

function ArithmeticNetwork:SC_Ath_AutoDecoSetting(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Ath_AutoDecoSetting error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting)
  end
end

function ArithmeticNetwork:CS_ATH_OneKeyInstall(heroId, slots, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__oneKeyInstallTab.heroId = heroId
  self.__oneKeyInstallTab.slots = slots
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall, proto_csmsg.CS_ATH_OneKeyInstall, self.__oneKeyInstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyInstall)
end

function ArithmeticNetwork:SC_ATH_OneKeyInstall(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyInstall error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall)
  end
end

function ArithmeticNetwork:CS_ATH_OneKeyUninstall(heroId, slotIds, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__onekeyUninstallTab.heroId = heroId
  self.__onekeyUninstallTab.slotIds = slotIds
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall, proto_csmsg.CS_ATH_OneKeyUninstall, self.__onekeyUninstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyUninstall)
end

function ArithmeticNetwork:SC_ATH_OneKeyUninstall(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyUninstall error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall)
  end
end

function ArithmeticNetwork:CS_ATH_ReconsitutionExec(uid, dogFoodUidList, totalTimes, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__recoExecTab.aimUid = uid
  self.__recoExecTab.dogFoodUid = dogFoodUidList
  self.__recoExecTab.totalTimes = totalTimes
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionExec, proto_csmsg.CS_ATH_ReconsitutionExec, self.__recoExecTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionExec, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionExec)
end

function ArithmeticNetwork:SC_ATH_ReconsitutionExec(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_ReconsitutionExec error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionExec)
  else
    PlayerDataCenter.allAthData:UpdateAthReconsitutionData(msg.reconsitution)
  end
end

function ArithmeticNetwork:CS_ATH_ReconsitutionSave(idx, callBack)
  self.__recoSaveTab.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionSave, proto_csmsg.CS_ATH_ReconsitutionSave, self.__recoSaveTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionSave, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionSave)
end

function ArithmeticNetwork:SC_ATH_ReconsitutionSave(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_ReconsitutionSave error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionSave)
  else
    PlayerDataCenter.allAthData:UpdateAthReconsitutionData(table.emptytable)
  end
end

function ArithmeticNetwork:CS_ATH_ReconsitutionDrop(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionDrop, proto_csmsg.CS_ATH_ReconsitutionDrop, self.__recoDropTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionDrop, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_ReconsitutionDrop)
end

function ArithmeticNetwork:SC_ATH_ReconsitutionDrop(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ReconsitutionDrop error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_ReconsitutionDrop)
  else
    PlayerDataCenter.allAthData:UpdateAthReconsitutionData(table.emptytable)
  end
end

function ArithmeticNetwork:CS_ATH_AffixLockUnlock(uid, affixIdx, callBack)
  if self:_HasReconsitution() then
    return
  end
  self.__affixLockTab.uid = uid
  self.__affixLockTab.affixIdx = affixIdx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AffixLockUnlock, proto_csmsg.CS_ATH_AffixLockUnlock, self.__affixLockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AffixLockUnlock, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AffixLockUnlock)
end

function ArithmeticNetwork:SC_ATH_AffixLockUnlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AffixLockUnlock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AffixLockUnlock)
  end
end

function ArithmeticNetwork:CS_ATH_Stat(heroId, callBack)
  self.__statTab = self.__statTab or {}
  self.__statTab.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Stat, proto_csmsg.CS_ATH_Stat, self.__statTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Stat, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_Stat)
end

function ArithmeticNetwork:SC_ATH_Stat(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_Stat error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Stat)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ATH_Stat, msg)
end

function ArithmeticNetwork:CS_ATH_Sign(athUid, heroId, affixIdx, callBack)
  self.__signTab = self.__signTab or {}
  self.__signTab.uid = athUid
  self.__signTab.heroId = heroId
  self.__signTab.affixIdx = affixIdx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Sign, proto_csmsg.CS_ATH_Sign, self.__signTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Sign, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_Sign)
end

function ArithmeticNetwork:SC_ATH_Sign(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_Sign error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Sign)
  end
end

function ArithmeticNetwork:_HasReconsitution()
  if #PlayerDataCenter.allAthData.athReconsitutionDataList > 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(204))
    return true
  end
  return false
end

function ArithmeticNetwork:Reset()
end

return ArithmeticNetwork
