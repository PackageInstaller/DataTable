local BattleDungeonNetworkCtrl = class("BattleDungeonNetworkCtrl", NetworkCtrlBase)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function BattleDungeonNetworkCtrl:ctor()
  self.sendChipSelect = {}
  self.sendEnterChapter = {
    formInfo = {}
  }
  self.sendEnterGroupChapter = {
    formInfo = {}
  }
  self.batlleFmtRefreshTab = {
    formInfo = {}
  }
  self.selectChipGroupTab = {}
  self.cstChangeTable = {}
  self.chipSelect = {}
  self._dailyDungeonQuick = {}
  self._dungeonQuickTab = {}
end

function BattleDungeonNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter, self, proto_csmsg.SC_BATTLE_NtfEnter, self.SC_BATTLE_NtfEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfWaveStep, self, proto_csmsg.SC_BATTLE_NtfWaveStep, self.SC_BATTLE_NtfWaveStep)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfOverRewards, self, proto_csmsg.SC_BATTLE_NtfOverRewards, self.SC_BATTLE_NtfOverRewards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfMonsterData, self, proto_csmsg.SC_BATTLE_NtfMonsterData, self.SC_BATTLE_NtfMonsterData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgData, self, proto_csmsg.SC_BATTLE_NtfAlgData, self.SC_BATTLE_NtfAlgData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgDiff, self, proto_csmsg.SC_BATTLE_NtfAlgDiff, self.SC_BATTLE_NtfAlgDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_BattleSettle, self, proto_csmsg.SC_BATTLE_BattleSettle, self.SC_BATTLE_BattleSettle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgSelect, self, proto_csmsg.SC_BATTLE_AlgSelect, self.SC_BATTLE_AlgSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_StartBattleWithForm, self, proto_csmsg.SC_BATTLE_StartBattleWithForm, self.SC_BATTLE_StartBattleWithForm)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Quit, self, proto_csmsg.SC_BATTLE_Quit, self.SC_BATTLE_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Restart, self, proto_csmsg.SC_BATTLE_Restart, self.SC_BATTLE_Restart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEON_STATIC_Detail, self, proto_csmsg.SC_DUNGEON_STATIC_Detail, self.SC_DUNGEON_STATIC_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_DungeonEnter, self, proto_csmsg.SC_BATTLE_DungeonEnter, self.SC_BATTLE_DungeonEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgGiveUp, self, proto_csmsg.SC_BATTLE_AlgGiveUp, self.SC_BATTLE_AlgGiveUp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEON_Dync_Detail, self, proto_csmsg.SC_DUNGEON_Dync_Detail, self.SC_DUNGEON_Dync_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_FormationFresh, self, proto_csmsg.SC_BATTLE_FormationFresh, self.SC_BATTLE_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_SelectChipGroup, self, proto_csmsg.SC_BATTLE_SelectChipGroup, self.SC_BATTLE_SelectChipGroup)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_OpeningAlgSelect, self, proto_csmsg.SC_BATTLE_OpeningAlgSelect, self.SC_BATTLE_OpeningAlgSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DailyDungeon_Quick, self, proto_csmsg.SC_DailyDungeon_Quick, self.SC_DailyDungeon_Quick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Dungeon_SyncData, self, proto_csmsg.SC_Dungeon_SyncData, self.SC_Dungeon_SyncData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Dungeon_Quick, self, proto_csmsg.SC_Dungeon_Quick, self.SC_Dungeon_Quick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Enter, self, proto_csmsg.SC_Activity_DungeonGroup_Enter, self.SC_Activity_DungeonGroup_Enter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Reset, self, proto_csmsg.SC_Activity_DungeonGroup_Reset, self.SC_Activity_DungeonGroup_Reset)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Restore, self, proto_csmsg.SC_Activity_DungeonGroup_Restore, self.SC_Activity_DungeonGroup_Restore)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfWaveStep(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  BattleDungeonManager:AddDungeonLogic(DungeonConst.LogicType.SceneStep, msg.wave)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfMonsterData(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  BattleDungeonManager:AddDungeonLogic(DungeonConst.LogicType.BattleStep, msg)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfOverRewards(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local getATH = {}
  if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.ath ~= nil then
    for key, sthEle in pairs(msg.syncUpdateDiff.ath.updateAth) do
      getATH[sthEle.uid] = sthEle.uid
    end
  end
  msg.getATH = getATH
  BattleDungeonManager:AddDungeonLogic(DungeonConst.LogicType.OverRewards, msg)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfAlgData(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  BattleDungeonManager:AddDungeonLogic(DungeonConst.LogicType.ChipStep, msg)
end

function BattleDungeonNetworkCtrl:CS_BATTLE_AlgSelect(idx, callBack)
  self.sendChipSelect.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgSelect, proto_csmsg.CS_BATTLE_AlgSelect, self.sendChipSelect)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgSelect, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgSelect)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_AlgSelect(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_AlgSelect error:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgSelect)
    return
  end
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfAlgDiff(msg)
  local diffData = msg.diff
  MsgCenter:Broadcast(eMsgEventId.OnChipDataDiff, diffData)
end

function BattleDungeonNetworkCtrl:CS_BATTLE_BattleSettle(sendMsg, callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_BattleSettle, proto_csmsg.CS_BATTLE_BattleSettle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_BattleSettle, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_BattleSettle, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfOverRewards)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_BattleSettle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_BattleSettle error:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_BattleSettle)
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_StartBattleWithForm(sendMsg, callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm, proto_csmsg.CS_BATTLE_StartBattleWithForm, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_StartBattleWithForm)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_StartBattleWithForm(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_StartBattleWithForm error:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm)
    return
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm, msg.seed)
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_Quit(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit, proto_csmsg.CS_BATTLE_Quit, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Quit)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_Quit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_Quit error:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit)
    return
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_Restart(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart, proto_csmsg.CS_BATTLE_Restart, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Restart)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_Restart(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_Restart error:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart)
    return
  end
end

function BattleDungeonNetworkCtrl:CS_DUNGEON_STATIC_Detail(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_STATIC_Detail, proto_csmsg.CS_DUNGEON_STATIC_Detail, {})
  if callBack ~= nil then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_STATIC_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEON_STATIC_Detail)
  end
end

function BattleDungeonNetworkCtrl:SC_DUNGEON_STATIC_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter:UpdateDungeonBattleTimes(msg)
  MsgCenter:Broadcast(eMsgEventId.OnBattleDungeonLimitChange)
  MsgCenter:Broadcast(eMsgEventId.OnBattleDungeonLimitInit)
end

function BattleDungeonNetworkCtrl:SC_Dungeon_SyncData(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter:UpdateDungeonBattleQuick(msg.quickChallengeModule)
end

function BattleDungeonNetworkCtrl:CS_DUNGEON_Dync_Detail(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_Dync_Detail, proto_csmsg.CS_DUNGEON_Dync_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_Dync_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEON_Dync_Detail)
end

function BattleDungeonNetworkCtrl:SC_DUNGEON_Dync_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter.dungeonDyncData:InitDungeonDyncData(msg.dungeonDync)
end

function BattleDungeonNetworkCtrl:SC_DUNGEON_Dync_SyncDiff(msg)
  PlayerDataCenter.dungeonDyncData:UpdDungeonDyncData(msg.update, msg.delete, true)
end

function BattleDungeonNetworkCtrl:CS_BATTLE_DungeonEnter(stageId, formationData, activateDrop, callBack, starting, substitute, decompose, interfaceData)
  self.sendEnterChapter.stageId = stageId
  self.sendEnterChapter.formInfo.formationId = formationData.id
  self.sendEnterChapter.formInfo.support = formationData:GetSupportHeroData()
  self.sendEnterChapter.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self.sendEnterChapter.activateDrop = activateDrop
  self.sendEnterChapter.starting = starting
  self.sendEnterChapter.substitute = substitute
  self.sendEnterChapter.autoDecoAth = decompose
  self.sendEnterChapter.challenge = nil
  if interfaceData then
    local stgChallengeData = interfaceData:GetDgInterfaceStgChallengeData()
    if stgChallengeData then
      self.sendEnterChapter.challenge = {
        chosenQuestIds = stgChallengeData:GetStgClgTaskOpenList()
      }
    end
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, proto_csmsg.CS_BATTLE_DungeonEnter, self.sendEnterChapter)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_DungeonEnter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_DungeonEnter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_DungeonEnter error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, {
    ab = msg.ab,
    astHeroId = msg.astHeroId
  })
end

function BattleDungeonNetworkCtrl:SC_BATTLE_NtfEnter(msg)
  local dungeonStageCfg = ConfigData.battle_dungeon[msg.dungeonId]
  if dungeonStageCfg == nil then
    error("dungeon stage cfg is null,id:" .. tostring(msg.dungeonId))
    return
  end
  local msgId = DungeonLevelEnum.DunModuleMsgProto[dungeonStageCfg.module_id]
  if msgId ~= nil then
    cs_WaitNetworkResponse:AddWaitData(msgId, msg)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, msg)
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_AlgGiveUp(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgGiveUp, proto_csmsg.CS_BATTLE_AlgGiveUp, {})
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgGiveUp, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgGiveUp)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_AlgGiveUp(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_AlgGiveUp error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgGiveUp)
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_FormationFresh(formationData, commandSkillChanged, heroChangedIdDic, callBack)
  self.batlleFmtRefreshTab.formInfo.formationId = formationData.id
  self.batlleFmtRefreshTab.formInfo.support = formationData:GetSupportHeroData()
  self.batlleFmtRefreshTab.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self.batlleFmtRefreshTab.commandSkillChanged = commandSkillChanged
  self.batlleFmtRefreshTab.heroChanged = heroChangedIdDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_FormationFresh, proto_csmsg.CS_BATTLE_FormationFresh, self.batlleFmtRefreshTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_FormationFresh, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_FormationFresh)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_FormationFresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_FormationFresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_FormationFresh)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_FormationFresh, msg)
end

function BattleDungeonNetworkCtrl:CS_BATTLE_SelectChipGroup(chipIdDic, callBack)
  self.selectChipGroupTab.selected = chipIdDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_SelectChipGroup, proto_csmsg.CS_BATTLE_SelectChipGroup, self.selectChipGroupTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_SelectChipGroup, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_SelectChipGroup)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_SelectChipGroup(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_SelectChipGroup error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_SelectChipGroup)
    return
  end
end

function BattleDungeonNetworkCtrl:CS_BATTLE_OpeningAlgSelect(chipId, callback)
  self.chipSelect.algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_OpeningAlgSelect, proto_csmsg.CS_BATTLE_OpeningAlgSelect, self.chipSelect)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_OpeningAlgSelect, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_OpeningAlgSelect)
end

function BattleDungeonNetworkCtrl:SC_BATTLE_OpeningAlgSelect(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_OpeningAlgSelect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_OpeningAlgSelect)
    return
  end
end

function BattleDungeonNetworkCtrl:CS_DailyDungeon_Quick(moduleId, callback)
  self._dailyDungeonQuick.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DailyDungeon_Quick, proto_csmsg.CS_DailyDungeon_Quick, self._dailyDungeonQuick)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DailyDungeon_Quick, callback, proto_csmsg_MSG_ID.MSG_SC_DailyDungeon_Quick)
end

function BattleDungeonNetworkCtrl:SC_DailyDungeon_Quick(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_DailyDungeon_Quick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DailyDungeon_Quick)
    return
  end
  MsgCenter:Broadcast(eMsgEventId.DailyDungeonOutOfData)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DailyDungeon_Quick, msg)
end

function BattleDungeonNetworkCtrl:CS_Dungeon_Quick(dungeonId, time, callback, activateDrop, autoDecoAth)
  self._dungeonQuickTab.dungeonId = dungeonId
  self._dungeonQuickTab.time = time
  self._dungeonQuickTab.activateDrop = activateDrop
  self._dungeonQuickTab.autoDecoAth = autoDecoAth
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Dungeon_Quick, proto_csmsg.CS_Dungeon_Quick, self._dungeonQuickTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Dungeon_Quick, callback, proto_csmsg_MSG_ID.MSG_SC_Dungeon_Quick)
end

function BattleDungeonNetworkCtrl:SC_Dungeon_Quick(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_Dungeon_Quick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Dungeon_Quick)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Dungeon_Quick, msg)
  MsgCenter:Broadcast(eMsgEventId.DungeonQuickBatteEnd)
end

function BattleDungeonNetworkCtrl:CS_Activity_DungeonGroup_Enter(actLongId, dungeonId, moduleId, formationData, callBack)
  self.sendEnterGroupChapter.actLongId = actLongId
  self.sendEnterGroupChapter.dungeonId = dungeonId
  self.sendEnterGroupChapter.moduleId = moduleId
  self.sendEnterGroupChapter.formInfo.formationId = formationData.id
  self.sendEnterGroupChapter.formInfo.support = formationData:GetSupportHeroData()
  self.sendEnterGroupChapter.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter, proto_csmsg.CS_Activity_DungeonGroup_Enter, self.sendEnterGroupChapter)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter, callBack, proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Enter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Enter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Enter error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Enter, msg)
end

function BattleDungeonNetworkCtrl:CS_Activity_DungeonGroup_Reset(actLongId, moduleId, callBack)
  local msg = {}
  msg.actLongId = actLongId
  msg.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Reset, proto_csmsg.CS_Activity_DungeonGroup_Reset, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Reset, callBack, proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Reset)
end

function BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Reset(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Reset error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Reset)
  end
end

function BattleDungeonNetworkCtrl:CS_Activity_DungeonGroup_Restore(actLongId, moduleId, callBack)
  local msg = {}
  msg.actLongId = actLongId
  msg.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Restore, proto_csmsg.CS_Activity_DungeonGroup_Restore, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Restore, callBack, proto_csmsg_MSG_ID.MSG_SC_Activity_DungeonGroup_Restore)
end

function BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Restore(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_Activity_DungeonGroup_Restore error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DungeonGroup_Restore)
  end
end

function BattleDungeonNetworkCtrl:Reset()
end

return BattleDungeonNetworkCtrl
