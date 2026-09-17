local this = {}
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()

function this:init()
  this.super.init(self)
  self.data = {
    multiDungeonInfoDic = {},
    curMultiDungeonInfo = {},
    matchTeamSyncReason = 0,
    matchTeamData = {},
    matchTeamInviteData = {},
    matchedReadyData = {},
    inviteWaitDic = {}
  }
end

function this:getMultiDungeonInfo(dungeonId)
  return self.data.multiDungeonInfoDic[dungeonId] or {}
end

function this:getMultiDungeonPassRank(levelId)
  local dungeonId = _dungeonCrisisCrusadeTpl:getTplById(levelId).dungeonId
  local dungeonInfo = self:getMultiDungeonInfo(dungeonId)
  if not table.isEmpty(dungeonInfo) then
    return dungeonInfo.star
  end
  return 0
end

function this:getMultiDungeonPassScore(levelId)
  local dungeonId = _dungeonCrisisCrusadeTpl:getTplById(levelId).dungeonId
  local dungeonInfo = self:getMultiDungeonInfo(dungeonId)
  if not table.isEmpty(dungeonInfo) then
    return dungeonInfo.score and dungeonInfo.score or 0
  end
  return 0
end

function this:getLevelIdByDungeonId(dungeonId)
  return _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
end

function this:getMultiDungeonIsPassed(levelId)
  local dungeonId = _dungeonCrisisCrusadeTpl:getTplById(levelId).dungeonId
  local dungeonInfo = self:getMultiDungeonInfo(dungeonId)
  if not table.isEmpty(dungeonInfo) then
    return dungeonInfo.status == L_Const.CampaignStatusType.CST_WIN
  end
  return false
end

function this:getMultiDungeonIsUnlock(levelId)
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonCrisisCrusadeTpl:getTaskUnlock(cfg))
  if not isComplete then
    local results = L_ConditionManager:getDescs(_dungeonCrisisCrusadeTpl:getTaskUnlock(cfg))
    return isComplete, results[lockIndex]
  end
  return isComplete
end

function this:getMultiDungeonIsShown(levelId)
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonCrisisCrusadeTpl:getTaskShow(cfg))
  return isComplete
end

function this:getCurMultiDungeonInfo()
  return self.data.curMultiDungeonInfo
end

function this:getCurMultiDungeonId()
  return self.data.curMultiDungeonInfo.dungeon_id
end

function this:getCurMultiEndTime()
  return self.data.curMultiDungeonInfo.end_time
end

function this:getUseTime(info)
  return info.end_time - info.start_time
end

function this:getDungeonStar(info)
  if not table.isEmpty(info) then
    return L_CommonUtil.numberToBool(info.star)
  end
  return {}
end

function this:getMatchTeamData()
  return self.data.matchTeamData
end

function this:getMatchTeamDataMembers()
  return self.data.matchTeamData.members or {}
end

function this:getMatchTeamDataMemberByPid(playerUid)
  local members = self:getMatchTeamDataMembers()
  for i, v in ipairs(members) do
    if v.pid == playerUid then
      return v
    end
  end
end

function this:getMatchTeamMemberByPos(pos)
  local members = self:getMatchTeamDataMembers()
  for i, v in ipairs(members) do
    if v.position == pos then
      return v.pid
    end
  end
end

function this:getMatchTeamDataSyncReason()
  return self.data.matchTeamSyncReason
end

function this:getMatchTeamInviteData()
  return self.data.matchTeamInviteData
end

function this:getMatchedReadyData()
  return self.data.matchedReadyData
end

function this:getMatchedReadyDataMembers()
  return self.data.matchedReadyData.members or {}
end

function this:getMatchedReadyMemberByPid(pid)
  local members = self:getMatchedReadyDataMembers()
  for i, v in pairs(members) do
    if v.pid == pid then
      return v
    end
  end
  return {}
end

function this:getInviteWaitDic()
  local toRemove = {}
  for i, v in pairs(self.data.inviteWaitDic) do
    if v.start_time + L_GameConstTpl:getData("MULIT_DUNGEON_FRIEND_READYTIME", L_Const.GameTplType.int) <= L_TimeUtil.getServerTime() then
      table.insert(toRemove, i)
    else
      local node, index = table.ipairsFind(self:getMatchTeamDataMembers(), function(item)
        return item.pid == v.pid
      end)
      if index then
        table.insert(toRemove, i)
      end
    end
  end
  for i, v in ipairs(toRemove) do
    self.data.inviteWaitDic[v] = nil
  end
  return self.data.inviteWaitDic
end

function this:getInviteWaitByPid(playerUid)
  local members = self:getInviteWaitDic()
  for i, v in pairs(members) do
    if v.pid == playerUid then
      return v
    end
  end
end

function this:getMatchStatus()
  local teamData = self:getMatchTeamData()
  local readyData = self:getMatchedReadyData()
  if not math.isEmpty(readyData.matched_time) then
    return L_MultiDungeonConst.MatchStatus.Matched
  elseif math.isEmpty(readyData.matched_time) and not math.isEmpty(teamData.match_start_time) then
    return L_MultiDungeonConst.MatchStatus.Matching
  elseif not table.isEmpty(teamData) then
    return L_MultiDungeonConst.MatchStatus.Prepare
  else
    return L_MultiDungeonConst.MatchStatus.None
  end
end

function this:checkDungeonGetReward(_staminaChestId, rewardTimes, pauseTimeStart, pageName, isAutoGetReward)
  pauseTimeStart = pauseTimeStart or 0
  if pauseTimeStart <= 0 then
    pauseTimeStart = L_TimeUtil.getServerTime()
  end
  local _staminaChestTpl = L_GameTpl:getStaminaChestDropTpl()
  local tpl = _staminaChestTpl:getTplById(_staminaChestId)
  local lastTime = _staminaChestTpl:getTime(tpl)
  local serverData = AzurWorld.StaminaChestMgr:GetStaminaChestData(_staminaChestId)
  local chestPauseTime = L_TimeUtil.getServerTime() - pauseTimeStart
  local totalPauseTime = serverData.totalPauseTime + chestPauseTime
  local filter = _staminaChestTpl:getWorldFilter(tpl)[1]
  if AzurWorldInstance.IsMulitPlayerOnlineMode or filter == L_Const.StaminaBoxSystemType.SBST_WORLD_ENEMY then
    totalPauseTime = 0
  end
  if L_TimeUtil.getServerTime() >= serverData.finishTime + totalPauseTime + lastTime then
    L_FlyMsgManager:showNormalMsgByKey("ui_pageStaminaReward_02")
    if pageName then
      L_UI:close(pageName)
    end
    return
  end
  local needCostList = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl))
  local isWeekDungeon = self:needWeeklyCount(needCostList)
  if isWeekDungeon and 0 >= L_ItemTplManager:getItemNum(L_Const.resType.currency, L_Const.currencyType.weeklyDungeonCount) then
    L_FlyMsgManager:showNormalMsgByKey("ui_notice_dungeon_weekly_time_limit")
    return
  end
  local needCost = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl))[1]
  local count = L_ItemTplManager:getItemNum(needCost.itemType, needCost.itemId)
  if isAutoGetReward then
    if isWeekDungeon then
      rewardTimes = 1
    else
      local rate = math.floor(count / needCost.itemNum)
      rate = math.max(1, rate)
      rewardTimes = math.min(rewardTimes, rate)
    end
  end
  if count < needCost.itemNum * rewardTimes then
    if needCost.itemId == L_Const.currencyType.stamina then
      L_FlyMsgManager:showNormalMsg(L_GameUtil.getStrByKey("notice_dungeon_lackenergy"))
      L_UI:open("pageStamina")
    elseif needCost.itemId == L_Const.currencyType.crystalKeyStone or needCost.itemId == L_Const.currencyType.specialCrystalKeyStone then
      local currencyConfigData = L_ItemTplManager:getCurrencyItem(needCost.itemId)
      local msg = currencyConfigData.name .. L_WordsTpl:getValue("notice_pageMultiDungeonMatching_03")
      L_FlyMsgManager:showNormalMsg(msg)
    end
    return
  end
  if pageName then
    L_UI:close(pageName)
  end
  local list = C_VarList:Get()
  list:AddInt(rewardTimes)
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnOpenChestStart, list)
end

function this:needWeeklyCount(needCostList)
  for _, v in ipairs(needCostList) do
    if v.itemId == L_Const.currencyType.weeklyDungeonCount and v.itemType == L_Const.resType.currency then
      return true
    end
  end
  return false
end

return this
