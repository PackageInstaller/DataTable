local GMNetworkCtrl = class("GMNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function GMNetworkCtrl:ctor()
  self.gmOperationTab = {}
  self.gmMonnsterData = {}
end

function GMNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_GMOperation, self, proto_csmsg.SC_GM_GMOperation, self.SC_GM_GMOperation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_GM_COMPLETE, self, proto_csmsg.SC_EXPLORATION_GM_COMPLETE, self.SC_EXPLORATION_GM_COMPLETE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_ShieldGuide, self, proto_csmsg.SC_GM_ShieldGuide, self.SC_GM_ShieldGuide)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_WarChessStart, self, proto_csmsg.SC_GM_WarChessStart, self.SC_GM_WarChessStart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TOOLS_EXPLORATION_MONSTER_DATA, self, proto_csmsg.SC_TOOLS_EXPLORATION_MONSTER_DATA, self.SC_TOOLS_EXPLORATION_MONSTER_DATA)
end

function GMNetworkCtrl:CS_GM_GMOperation(id, param)
  self._lastGmId = id
  self.gmOperationTab.id = id
  self.gmOperationTab.param = param
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GM_GMOperation, proto_csmsg.CS_GM_GMOperation, self.gmOperationTab)
end

function GMNetworkCtrl:SC_GM_GMOperation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "GMNetworkCtrl:SC_GM_GMOperation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  else
    print("GM Success")
    if self._lastGmId == proto_csmsg_GMType.GMTypeSuperman then
      local msg = "使用了GM SuperMan，需要重开游戏，否则可能会有未知问题。"
      warn(msg)
      CS.MessageCommon.ShowMessageBox(msg, function()
        if isEditorMode then
          CS.UnityEditor.EditorApplication.isPlaying = false
        else
          CS.UnityEngine.Application.Quit()
        end
      end, nil)
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.userMemory then
    print("[Server Memory]" .. serpent.block(msg.userMemory))
  end
end

function GMNetworkCtrl:SC_EXPLORATION_GM_COMPLETE(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  NetworkManager:GetNetwork(NetworkTypeID.Exploration):CS_EXPLORATION_Detail()
  if ExplorationManager:IsInExploration() then
    ExplorationManager:ExitExploration(nil, nil, true)
  end
end

function GMNetworkCtrl:SC_GM_ShieldGuide()
  GuideManager:SetGMSkipGuide(true)
  GuideManager:SkipGuide()
end

function GMNetworkCtrl:SC_GM_WarChessStart(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_GM_WarChessStart error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  local warChessMsg = msg.warChess
  WarChessManager:InitWarchessCtrl()
  WarChessManager.wcLevelId = warChessMsg.configId
  WarChessManager.wcLevelCfg = ConfigData.warchess_level[WarChessManager.wcLevelId]
  WarChessManager:CleanOrtherWhenEnter()
  WarChessManager.__wcCtrl:EnterWarChessByMsg(warChessMsg)
end

function GMNetworkCtrl:CS_TOOLS_EXPLORATION_MONSTER_DATA(monsterId, monsterLv, monsterType, monsterGrade, callback)
  self.gmMonnsterData.monsterId = monsterId
  self.gmMonnsterData.monsterLv = monsterLv
  self.gmMonnsterData.monsterType = monsterType
  self.gmMonnsterData.monsterGrade = monsterGrade
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TOOLS_EXPLORATION_MONSTER_DATA, proto_csmsg.CS_TOOLS_EXPLORATION_MONSTER_DATA, self.gmMonnsterData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TOOLS_EXPLORATION_MONSTER_DATA, callback, proto_csmsg_MSG_ID.MSG_SC_TOOLS_EXPLORATION_MONSTER_DATA)
end

function GMNetworkCtrl:SC_TOOLS_EXPLORATION_MONSTER_DATA(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "GMNetworkCtrl:SC_TOOLS_EXPLORATION_MONSTER_DATA error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TOOLS_EXPLORATION_MONSTER_DATA)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TOOLS_EXPLORATION_MONSTER_DATA, msg)
  end
end

function GMNetworkCtrl:Reset()
end

return GMNetworkCtrl
