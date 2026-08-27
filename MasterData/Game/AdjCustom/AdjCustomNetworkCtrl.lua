local AdjCustomNetworkCtrl = class("AdjCustomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function AdjCustomNetworkCtrl:ctor()
  self._renameTable = {}
  self._changeTable = {}
  self._modifyTable = {}
  self._delTable = {}
  self._randomTogTable = {}
  self._isHideTextTable = {}
end

function AdjCustomNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetUpdate, self, proto_csmsg.SC_MainInterface_PresetUpdate, self.SC_MainInterface_PresetUpdate)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetRename, self, proto_csmsg.SC_MainInterface_PresetRename, self.SC_MainInterface_PresetRename)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_Detail, self, proto_csmsg.SC_MainInterface_Detail, self.SC_MainInterface_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetChange, self, proto_csmsg.SC_MainInterface_PresetChange, self.SC_MainInterface_PresetChange)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetDel, self, proto_csmsg.SC_MainInterface_PresetDel, self.SC_MainInterface_PresetDel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_RandomTog, self, proto_csmsg.SC_MainInterface_RandomTog, self.SC_MainInterface_RandomTog)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MainInterface_Setting, self, proto_csmsg.SC_MainInterface_Setting, self.SC_MainInterface_Setting)
end

function AdjCustomNetworkCtrl:CS_MainInterface_PresetUpdate(data, callback)
  self._modifyTable.data = data
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetUpdate, proto_csmsg.CS_MainInterface_PresetUpdate, self._modifyTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetUpdate, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetUpdate)
end

function AdjCustomNetworkCtrl:SC_MainInterface_PresetUpdate(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_PresetUpdate error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  local data = self._modifyTable.data
  PlayerDataCenter.allAdjCustomData:SetAdjPresetData(data)
  MsgCenter:Broadcast(eMsgEventId.AdjCustomModify, data.id)
end

function AdjCustomNetworkCtrl:CS_MainInterface_PresetRename(id, name, callback)
  self._renameTable.id = id
  self._renameTable.name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetRename, proto_csmsg.CS_MainInterface_PresetRename, self._renameTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetRename, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetRename)
end

function AdjCustomNetworkCtrl:SC_MainInterface_PresetRename(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    return
  elseif msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_PresetRename error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:SetAdjPresetName(self._renameTable.id, self._renameTable.name)
end

function AdjCustomNetworkCtrl:CS_MainInterface_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_Detail, proto_csmsg.CS_MainInterface_Detail, table.emptytable)
end

function AdjCustomNetworkCtrl:SC_MainInterface_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:InitAdjCustonData(msg.data)
end

function AdjCustomNetworkCtrl:CS_MainInterface_PresetChange(id, callback)
  self._changeTable.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetChange, proto_csmsg.CS_MainInterface_PresetChange, self._changeTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetChange, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetChange)
end

function AdjCustomNetworkCtrl:SC_MainInterface_PresetChange(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_PresetChange error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:SetUsingAdjCustomPresetId(self._changeTable.id)
  MsgCenter:Broadcast(eMsgEventId.AdjCustomChange)
end

function AdjCustomNetworkCtrl:CS_MainInterface_PresetDel(id, callback)
  self._delTable.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetDel, proto_csmsg.CS_MainInterface_PresetDel, self._delTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_PresetDel, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_PresetDel)
end

function AdjCustomNetworkCtrl:SC_MainInterface_PresetDel(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_PresetDel error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:DelAdjPreset(self._delTable.id)
  MsgCenter:Broadcast(eMsgEventId.AdjCustomModify, self._delTable.id)
end

function AdjCustomNetworkCtrl:CS_MainInterface_RandomTog(isRandomMainPresent, callback)
  self._randomTogTable.tog = isRandomMainPresent
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_RandomTog, proto_csmsg.CS_MainInterface_RandomTog, self._randomTogTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_RandomTog, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_RandomTog)
end

function AdjCustomNetworkCtrl:SC_MainInterface_RandomTog(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_RandomTog error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:SetIsRandomMainPresent(self._randomTogTable.tog)
end

function AdjCustomNetworkCtrl:CS_MainInterface_Setting(isHideText, callback)
  self._isHideTextTable.hideText = isHideText
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MainInterface_Setting, proto_csmsg.CS_MainInterface_Setting, self._randomTogTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MainInterface_Setting, callback, proto_csmsg_MSG_ID.MSG_SC_MainInterface_Setting)
end

function AdjCustomNetworkCtrl:SC_MainInterface_Setting(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_MainInterface_Setting error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  PlayerDataCenter.allAdjCustomData:SetIsHideText(self._isHideTextTable.hideText)
end

return AdjCustomNetworkCtrl
