local SpecWeaponNetwork = class("SpecWeaponNetwork", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function SpecWeaponNetwork:ctor()
  self._sendTable = {}
  self._sendLvTable = {}
end

function SpecWeaponNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Unlock, self, proto_csmsg.SC_SpecWeapon_Unlock, self.SC_SpecWeapon_Unlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Step, self, proto_csmsg.SC_SpecWeapon_Step, self.SC_SpecWeapon_Step)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Upgrade, self, proto_csmsg.SC_SpecWeapon_Upgrade, self.SC_SpecWeapon_Upgrade)
end

function SpecWeaponNetwork:CS_SpecWeapon_Unlock(id, callback)
  self._sendTable.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Unlock, proto_csmsg.CS_SpecWeapon_Unlock, self._sendTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Unlock, callback, proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Unlock)
end

function SpecWeaponNetwork:SC_SpecWeapon_Unlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_SpecWeapon_Unlock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Unlock)
    return
  end
end

function SpecWeaponNetwork:CS_SpecWeapon_Step(id, callback)
  self._sendTable.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Step, proto_csmsg.CS_SpecWeapon_Step, self._sendTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Step, callback, proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Step)
end

function SpecWeaponNetwork:SC_SpecWeapon_Step(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_SpecWeapon_Step error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Step)
    return
  end
end

function SpecWeaponNetwork:CS_SpecWeapon_Upgrade(id, targetLevel, callback)
  self._sendLvTable.id = id
  self._sendLvTable.targetLv = targetLevel
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Upgrade, proto_csmsg.CS_SpecWeapon_Upgrade, self._sendLvTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_SpecWeapon_Upgrade)
end

function SpecWeaponNetwork:SC_SpecWeapon_Upgrade(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_SpecWeapon_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SpecWeapon_Upgrade)
    return
  end
end

return SpecWeaponNetwork
