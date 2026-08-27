local HeroEnterNetworkCtrl = class("HeroEnterNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local heroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")

function HeroEnterNetworkCtrl:ctor()
end

function HeroEnterNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Detail, self, proto_csmsg.SC_STATION_Detail, self.SC_STATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Install, self, proto_csmsg.SC_STATION_Install, self.SC_STATION_Install)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Uninstall, self, proto_csmsg.SC_STATION_Uninstall, self.SC_STATION_Uninstall)
end

function HeroEnterNetworkCtrl:CS_STATION_Detail(isAddAttr)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Detail, proto_csmsg.CS_STATION_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Detail, function()
    if isAddAttr then
      heroEnterDataUtil:InitBuff(PlayerDataCenter.allEnterData)
      heroEnterDataUtil:InitMsgListern()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_STATION_Detail)
end

function HeroEnterNetworkCtrl:SC_STATION_Detail(msg)
  PlayerDataCenter.allEnterData = msg.data.data
  MsgCenter:Broadcast(eMsgEventId.OnHeroEnterDataUpdate)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroEnterNetworkCtrl:CS_STATION_Install(heroId, buildingId, callBack)
  local msgTable = {heroId = heroId, buildingId = buildingId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Install, proto_csmsg.CS_STATION_Install, msgTable)
  self:CS_STATION_Detail()
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, function()
    if callBack ~= nil then
      callBack()
    end
    heroEnterDataUtil:AddBuff(heroId, buildingId)
    PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
  end, proto_csmsg_MSG_ID.MSG_SC_STATION_Install)
end

function HeroEnterNetworkCtrl:SC_STATION_Install(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_STATION_Install error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroEnterNetworkCtrl:CS_STATION_Uninstall(heroId, callBack)
  local msgTable = {heroId = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall, proto_csmsg.CS_STATION_Uninstall, msgTable)
  self:CS_STATION_Detail()
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall, function()
    if callBack ~= nil then
      callBack()
    end
    heroEnterDataUtil:RemoveBuff(heroId)
    PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
  end, proto_csmsg_MSG_ID.MSG_SC_STATION_Uninstall)
end

function HeroEnterNetworkCtrl:SC_STATION_Uninstall(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_STATION_Uninstall error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroEnterNetworkCtrl:Reset()
end

return HeroEnterNetworkCtrl
