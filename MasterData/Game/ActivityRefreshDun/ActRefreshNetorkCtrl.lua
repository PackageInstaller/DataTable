local ActRefreshNetorkCtrl = class("ActRefreshNetorkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActRefreshNetorkCtrl:ctor()
  self._msg = {}
end

function ActRefreshNetorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay, self, proto_csmsg.SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay, self.SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_SyncDiff, self, proto_csmsg.SC_ACTIVITYSCTORII_SyncDiff, self.SC_ACTIVITYSCTORII_SyncDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh, self, proto_csmsg.SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh, self.SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh, self, proto_csmsg.SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh, self.SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon, self, proto_csmsg.SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon, self.SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon)
end

function ActRefreshNetorkCtrl:CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay, proto_csmsg.CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay)
end

function ActRefreshNetorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_REFRESHDUNGEON_FetchOverDay error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_FetchOverDay)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActRefreshNetorkCtrl:CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh(actId, callback)
  self._msg.act = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh, proto_csmsg.CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh)
end

function ActRefreshNetorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_PurchaseRefresh)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActRefreshNetorkCtrl:CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh(actId, dungeonId, callback)
  self._msg.act = actId
  self._msg.dungeonId = dungeonId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh, proto_csmsg.CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh)
end

function ActRefreshNetorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_REFRESHDUNGEON_SingleRefresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_SingleRefresh)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActRefreshNetorkCtrl:CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon(actId, dungeonId, formationData, callback, firstPower, benchPower)
  local msg = {}
  msg.actId = actId
  msg.dungeonId = dungeonId
  msg.formInfo = {}
  msg.formInfo.formationId = formationData.id
  msg.formInfo.fairyUid = formationData:GetFmtFairyUID()
  msg.startPower = firstPower
  msg.subPower = benchPower
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon, proto_csmsg.CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_REFRESHDUNGEON_EnterDungeon, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function ActRefreshNetorkCtrl:SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_REFRESHDUNGEON_EnterDungeon error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActRefreshNetorkCtrl:SC_ACTIVITYSCTORII_SyncDiff(msg)
  local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
  if refreshDunCtrl ~= nil then
    refreshDunCtrl:UpdataSingleRefreshDunActivity(msg)
  end
end

function ActRefreshNetorkCtrl:Reset()
end

return ActRefreshNetorkCtrl
