local AchivLevelNetworkCtrl = class("AchivLevelNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function AchivLevelNetworkCtrl:ctor()
end

function AchivLevelNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail, self, proto_csmsg.SC_ACHIEVEMENT_Detail, self.OnRecv_ACHIEVEMENT_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward, self, proto_csmsg.SC_ACHIEVEMENT_LevelReward, self.OnRecv_ACHIEVEMENT_LevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_OneKeyPick, self, proto_csmsg.SC_ACHIEVEMENT_OneKeyPick, self.OnRecvACHIEVEMENT_OneKeyPick)
end

function AchivLevelNetworkCtrl:Send_ACHIEVEMENT_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg.CS_ACHIEVEMENT_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_Detail)
end

function AchivLevelNetworkCtrl:OnRecv_ACHIEVEMENT_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecv_ACHIEVEMENT_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_Detail)
    return
  end
  if msg.data ~= nil then
    PlayerDataCenter.achivLevelData:InitPickedLevels(msg.data.levelRewradsPicked)
    PlayerDataCenter.achivLevelData:InitPickedAchivs(msg.data.questFinishedRecords)
  else
    PlayerDataCenter.achivLevelData:InitPickedLevels(nil)
    PlayerDataCenter.achivLevelData:InitPickedAchivs(nil)
  end
end

function AchivLevelNetworkCtrl:Send_ACHIEVEMENT_LevelReward(level)
  if self.__isGettingReward then
    return
  end
  self.__isGettingReward = true
  local tabMsg = {lv = level}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward, proto_csmsg.CS_ACHIEVEMENT_LevelReward, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_LevelReward, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
end

function AchivLevelNetworkCtrl:OnRecv_ACHIEVEMENT_LevelReward(msg)
  self.__isGettingReward = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecv_ACHIEVEMENT_LevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
    return
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
  MsgCenter:Broadcast(eMsgEventId.GetAchivLevelRewardComplete, msg.rewards)
end

function AchivLevelNetworkCtrl:SendACHIEVEMENT_OneKeyPick(levels, backAction)
  local tabMsg = {lvs = levels}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_OneKeyPick, proto_csmsg.CS_ACHIEVEMENT_OneKeyPick, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACHIEVEMENT_OneKeyPick, backAction, proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_OneKeyPick)
end

function AchivLevelNetworkCtrl:OnRecvACHIEVEMENT_OneKeyPick(msg)
  local items = {}
  for itemId, num in pairs(msg.rewards) do
    local itemCfg = ConfigData.item[itemId]
    if not itemCfg.is_shielded then
      table.insert(items, {
        id = itemId,
        warehouse_order = itemCfg.warehouse_order,
        count = num
      })
    end
  end
  table.sort(items, function(a, b)
    if a.warehouse_order == b.warehouse_order then
      return a.id < b.id
    else
      return a.warehouse_order < b.warehouse_order
    end
  end)
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(items) do
    table.insert(rewardIds, v.id)
    table.insert(rewardNums, v.count)
  end
  if 0 < #rewardIds then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true)
      window:AddAndTryShowReward(CRData)
    end)
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "OnRecvACHIEVEMENT_OneKeyPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACHIEVEMENT_LevelReward)
    return
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function AchivLevelNetworkCtrl:AchieveLevelCommonDiff(diffMsg)
  if diffMsg.levelRewradsPicked ~= nil then
    PlayerDataCenter.achivLevelData:AddPickedLevel(diffMsg.levelRewradsPicked)
  end
  if diffMsg.questFinishedRecords ~= nil then
    PlayerDataCenter.achivLevelData:AddPickedAchivs(diffMsg.questFinishedRecords)
  end
end

function AchivLevelNetworkCtrl:Reset()
end

return AchivLevelNetworkCtrl
