local ReinforceNetCtrl = class("ReinforceNetCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ReinforceNetCtrl:ctor()
  self._cardUpTab = {}
  self._cardUpMaxTab = {}
  self.rfStartList = {}
  self.rfGetStartList = {}
  self.reinforceDrawcardTable = {}
  self.reinforceGroupRenameTable = {}
  self.setAssisFactorCardsTable = {}
end

function ReinforceNetCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ReinforceCard_Upgrade, self, proto_csmsg.SC_ReinforceCard_Upgrade, self.SC_ReinforceCard_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ReinforceCard_UpgradeMax, self, proto_csmsg.SC_ReinforceCard_UpgradeMax, self.SC_ReinforceCard_UpgradeMax)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GetFactorCards, self, proto_csmsg.SC_GetFactorCards, self.SC_GetFactorCards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FactorCard_SaveFresh, self, proto_csmsg.SC_FactorCard_SaveFresh, self.SC_FactorCard_SaveFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Quest_Reinforce_Over, self, proto_csmsg.SC_Quest_Reinforce_Over, self.SC_Quest_Reinforce_Over)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Reinforce_StartList, self, proto_csmsg.SC_Reinforce_StartList, self.SC_Reinforce_StartList)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GetReinforce_StartList, self, proto_csmsg.SC_GetReinforce_StartList, self.SC_GetReinforce_StartList)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Reinforce_Drawcards, self, proto_csmsg.SC_Reinforce_Drawcards, self.SC_Reinforce_Drawcards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HighExploration_Reward, self, proto_csmsg.SC_HighExploration_Reward, self.SC_HighExploration_Reward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Reinforce_ListReName, self, proto_csmsg.SC_Reinforce_ListReName, self.SC_Reinforce_ListReName)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SetAssisFactorCards, self, proto_csmsg.SC_SetAssisFactorCards, self.SC_SetAssisFactorCards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AssisFactorReward, self, proto_csmsg.SC_AssisFactorReward, self.SC_AssisFactorReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityAnniv24_LastHistoryData, self, proto_csmsg.SC_ActivityAnniv24_LastHistoryData, self.SC_ActivityAnniv24_LastHistoryData)
end

function ReinforceNetCtrl:CS_ReinforceCard_Upgrade(cardId, callback)
  self._cardUpTab.itemId = cardId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_Upgrade, proto_csmsg.CS_ReinforceCard_Upgrade, self._cardUpTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_ReinforceCard_Upgrade)
end

function ReinforceNetCtrl:SC_ReinforceCard_Upgrade(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ReinforceCard_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_Upgrade)
    return
  end
end

function ReinforceNetCtrl:CS_ReinforceCard_UpgradeMax(cardIdList, callback)
  self._cardUpMaxTab.itemId = cardIdList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_UpgradeMax, proto_csmsg.CS_ReinforceCard_UpgradeMax, self._cardUpMaxTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_UpgradeMax, callback, proto_csmsg_MSG_ID.MSG_SC_ReinforceCard_UpgradeMax)
end

function ReinforceNetCtrl:SC_ReinforceCard_UpgradeMax(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ReinforceCard_UpgradeMax error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ReinforceCard_UpgradeMax)
    return
  end
end

function ReinforceNetCtrl:CS_GetFactorCards(activityId, callback)
  self._GetFacCardsTab = self._GetFacCardsTab or {}
  self._GetFacCardsTab.activityId = activityId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GetFactorCards, proto_csmsg.CS_GetFactorCards, self._GetFacCardsTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_GetFactorCards, callback, proto_csmsg_MSG_ID.MSG_SC_GetFactorCards)
end

function ReinforceNetCtrl:SC_GetFactorCards(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_GetFactorCards error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_GetFactorCards)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_GetFactorCards, msg)
end

function ReinforceNetCtrl:CS_Quest_Reinforce_Over(position, callback)
  self._ReqFacFmtTab = self._ReqFacFmtTab or {}
  self._ReqFacFmtTab.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Quest_Reinforce_Over, proto_csmsg.CS_Quest_Reinforce_Over, self._ReqFacFmtTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Quest_Reinforce_Over, callback, proto_csmsg_MSG_ID.MSG_SC_Quest_Reinforce_Over)
end

function ReinforceNetCtrl:SC_Quest_Reinforce_Over(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Quest_Reinforce_Over error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Quest_Reinforce_Over)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Quest_Reinforce_Over, msg)
end

function ReinforceNetCtrl:CS_FactorCard_SaveFresh(activityId, isSave, replaceCardId, callback)
  self._SaveFacTab = self._SaveFacTab or {}
  self._SaveFacTab.activityId = activityId
  self._SaveFacTab.isSave = isSave
  self._SaveFacTab.replaceCardId = replaceCardId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FactorCard_SaveFresh, proto_csmsg.CS_FactorCard_SaveFresh, self._SaveFacTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FactorCard_SaveFresh, callback, proto_csmsg_MSG_ID.MSG_SC_FactorCard_SaveFresh)
end

function ReinforceNetCtrl:SC_FactorCard_SaveFresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_FactorCard_SaveFresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FactorCard_SaveFresh)
    return
  end
end

function ReinforceNetCtrl:CS_Reinforce_StartList(activityId, factorCardStartData, callback)
  self.rfStartList.activityId = activityId
  self.rfStartList.factorCardStartData = factorCardStartData
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Reinforce_StartList, proto_csmsg.CS_Reinforce_StartList, self.rfStartList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_StartList, callback, proto_csmsg_MSG_ID.MSG_SC_Reinforce_StartList)
end

function ReinforceNetCtrl:SC_Reinforce_StartList(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Reinforce_StartList error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_StartList)
    return
  end
end

function ReinforceNetCtrl:CS_GetReinforce_StartList(activityId, callback)
  self.rfGetStartList.activityId = activityId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GetReinforce_StartList, proto_csmsg.CS_GetReinforce_StartList, self.rfGetStartList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_GetReinforce_StartList, callback, proto_csmsg_MSG_ID.MSG_SC_GetReinforce_StartList)
end

function ReinforceNetCtrl:SC_GetReinforce_StartList(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_GetReinforce_StartList error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_GetReinforce_StartList)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_GetReinforce_StartList, msg)
end

function ReinforceNetCtrl:CS_HighExploration_Reward(activityId, stageId, drawAll, rewardStageScore, rewardStageLayer, callback)
  local msg = {
    activityId = activityId,
    stageId = stageId,
    drawAll = drawAll,
    rewardStageScore = rewardStageScore,
    rewardStageLayer = rewardStageLayer
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HighExploration_Reward, proto_csmsg.CS_HighExploration_Reward, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HighExploration_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_HighExploration_Reward)
end

function ReinforceNetCtrl:SC_HighExploration_Reward(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_HighExploration_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HighExploration_Reward)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HighExploration_Reward, msg)
end

function ReinforceNetCtrl:CS_Reinforce_Drawcards(activityId, packageId, drawcardsNum, callback)
  self.reinforceDrawcardTable.activityId = activityId
  self.reinforceDrawcardTable.packageId = packageId
  self.reinforceDrawcardTable.drawcardsNum = drawcardsNum
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Reinforce_Drawcards, proto_csmsg.CS_Reinforce_Drawcards, self.reinforceDrawcardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_Drawcards, callback, proto_csmsg_MSG_ID.MSG_SC_Reinforce_Drawcards)
end

function ReinforceNetCtrl:SC_Reinforce_Drawcards(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Reinforce_Drawcards error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_Drawcards)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Reinforce_Drawcards, msg)
end

function ReinforceNetCtrl:CS_Reinforce_ListReName(activityId, groupId, name, callback)
  self.reinforceGroupRenameTable.activityId = activityId
  self.reinforceGroupRenameTable.groupId = groupId
  self.reinforceGroupRenameTable.name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Reinforce_ListReName, proto_csmsg.CS_Reinforce_ListReName, self.reinforceGroupRenameTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_ListReName, callback, proto_csmsg_MSG_ID.MSG_SC_Reinforce_ListReName)
end

function ReinforceNetCtrl:SC_Reinforce_ListReName(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_ListReName)
    local cardSetUI = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardSet)
    if cardSetUI ~= nil then
      cardSetUI:OnEditGroupNameError()
    end
  else
    local errorMsg = "SC_Reinforce_ListReName error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_ListReName)
    local cardSetUI = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardSet)
    if cardSetUI ~= nil then
      cardSetUI:OnEditGroupNameError()
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ReinforceNetCtrl:CS_SetAssisFactorCards(activityId, cardIds, idxs, callback)
  self.setAssisFactorCardsTable.activityId = activityId
  self.setAssisFactorCardsTable.cardId = cardIds
  self.setAssisFactorCardsTable.idx = idxs
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SetAssisFactorCards, proto_csmsg.CS_SetAssisFactorCards, self.setAssisFactorCardsTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SetAssisFactorCards, callback, proto_csmsg_MSG_ID.MSG_SC_SetAssisFactorCards)
end

function ReinforceNetCtrl:SC_SetAssisFactorCards(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Reinforce_ListReName)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ReinforceNetCtrl:CS_AssisFactorReward(activityId, callback)
  self.setAssisFactorCardsTable.activityId = activityId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AssisFactorReward, proto_csmsg.CS_AssisFactorReward, self.setAssisFactorCardsTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_AssisFactorReward, callback, proto_csmsg_MSG_ID.MSG_SC_AssisFactorReward)
end

function ReinforceNetCtrl:SC_AssisFactorReward(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_AssisFactorReward)
    return
  end
  local rewardDic = {}
  if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack.updates ~= nil then
    for itemId, data in pairs(msg.syncUpdateDiff.resource.backpack.updates) do
      local addNum = data.count - PlayerDataCenter:GetItemCount(itemId)
      if 0 < addNum then
        rewardDic[itemId] = addNum
      end
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AssisFactorReward, rewardDic)
end

function ReinforceNetCtrl:CS_ActivityAnniv24_LastHistoryData(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityAnniv24_LastHistoryData, proto_csmsg.CS_ActivityAnniv24_LastHistoryData, {})
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityAnniv24_LastHistoryData, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityAnniv24_LastHistoryData)
end

function ReinforceNetCtrl:SC_ActivityAnniv24_LastHistoryData(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActivityAnniv24_LastHistoryData, msg)
end

return ReinforceNetCtrl
