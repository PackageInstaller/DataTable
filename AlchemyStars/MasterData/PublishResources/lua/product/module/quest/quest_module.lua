require("quest_info")
_class("QuestModule", GameModule)
QuestModule = QuestModule

function QuestModule:Constructor()
  self.questDict = {}
  self.m_tmGrowthUnlockTime = 0
  self.m_growth_points = 0
  self.m_growth_reward_state = 0
  self.m_quest_daily_refresh_time = 0
  self.m_quest_week_refresh_time = 0
  self.m_is_request_daily_refresh_time = false
  self.m_growth_stage2_points = 0
  self.m_growth_stage2_reward_state = 0
  self.m_force_cal = false
  self.m_LastGetQuestListTime = 0
  self.m_LastRetList = {}
end

function QuestModule:Init()
  self.caller:RegisterPushHandler(CEventPushQuestUpdate, self.HandleQuestUpdate, self)
  self.caller:RegisterPushHandler(CEventPushRecentAchieve, self.HandleRecentAchieve, self)
  self.caller:RegisterPushHandler(CEventPushResetDailyQuest, self.HandleDayliReset, self)
  self.caller:RegisterPushHandler(CEventPushQuestStateParamUpdate, self.HandleQuestStateUpdate, self)
  self.caller:RegisterPushHandler(CEventPushUnlockChapterQuest, self.HandleUnlockChapterQuest, self)
  self.caller:RegisterPushHandler(CEventPushResetWeekQuest, self.HandleWeekRewardReset, self)
  self.caller:RegisterPushHandler(CEventPushWorldBossReset, self.HandleWorldBossRest, self)
end

function QuestModule:SetCfgQuestData(data)
  local cli_cfg = GameGlobal.GetZoneCfgTable("cfg_quest", data.quest_id)
  if cli_cfg == nil then
    Log.error("[quest module] QuestModule:SetMobileQuestData error --> cfg_quest == nil ,id=", data.quest_id)
  else
    if cli_cfg.ChapterID ~= nil then
      data.ChapterID = cli_cfg.ChapterID
    end
    if cli_cfg.CondDesc ~= nil then
      data.CondDesc = cli_cfg.CondDesc
    end
    if cli_cfg.DayGroup ~= nil then
      data.DayGroup = cli_cfg.DayGroup
    end
    if cli_cfg.Icon ~= nil then
      data.Icon = cli_cfg.Icon
    end
    if cli_cfg.JumpID ~= nil then
      data.JumpID = cli_cfg.JumpID
    end
    if cli_cfg.JumpParam ~= nil then
      data.JumpParam = cli_cfg.JumpParam
    end
    if cli_cfg.QuestName ~= nil then
      data.QuestName = cli_cfg.QuestName
    end
    if cli_cfg.QuestDesc ~= nil then
      data.QuestDesc = cli_cfg.QuestDesc
    end
    if cli_cfg.ShowType ~= nil then
      data.ShowType = cli_cfg.ShowType
    end
  end
end

function QuestModule:SetMobileQuestData(data)
  local mMission = self:GetModule(MissionModule)
  local discoveryData = mMission:GetDiscoveryData()
  for qid, qinfo in pairs(data.quest_dict) do
    local b = true
    self:SetCfgQuestData(qinfo)
    if qinfo.JumpID == 1 then
      local stageId = qinfo.JumpParam[1]
      if stageId and stageId ~= 1 then
        local chapter = discoveryData:GetChapterByStageId(stageId)
        if not chapter then
          b = false
        end
      end
    end
    if b then
      local quest = self.questDict[qid]
      if quest then
        quest:Update(qinfo)
      else
        self.questDict[qid] = Quest:New(qinfo)
      end
    end
  end
  self.complete_set = data.complete_set
  self.recent_complete_achieves = data.recent_complete_achieves
  self.m_tmGrowthUnlockTime = data.growth_quest_unlock_time
  self.m_growth_points = data.growth_points
  self.m_growth_reward_state = data.growth_reward_state
  self.m_growth_stage2_points = data.growth_stage2_points
  self.m_growth_stage2_reward_state = data.growth_stage2_reward_state
  self._redPoint = nil
end

function QuestModule:GetQuest(id)
  return self.questDict[id]
end

function QuestModule:GetGrowthQuestCurDay()
  local md = self:GetModule(RoleModule)
  return md.m_char_info.growth_quest_days
end

function QuestModule:GetGrowthQuestCount()
  local finish = 0
  local total = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Growth)
  for _, quest in ipairs(quests) do
    if quest:Status() == QuestStatus.QUEST_Completed then
      finish = finish + 1
    end
    total = total + 1
  end
  return finish, total
end

function QuestModule:GetFinishQuestNumByType(eQuestType)
  local nRet = 0
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  for qid, quest in pairs(self.questDict) do
    local qinfo = quest:QuestInfo()
    if (0 >= qinfo.BeginCountersTime or tmNowTime >= qinfo.BeginCountersTime) and qinfo.QuestType == eQuestType then
      nRet = nRet + 1
    end
  end
  return nRet
end

function QuestModule:GetDailyQuestVigorous()
  local md = self:GetModule(RoleModule)
  return md.m_char_info.daily_vig_point
end

function QuestModule:GetAchPoint()
  local md = self:GetModule(RoleModule)
  return md.m_char_info.ach_point
end

function QuestModule:IsGotVigorousReward(reward_id)
  local md = self:GetModule(RoleModule)
  local st = md.m_char_info.vig_reward_state
  local flag = FlagValue:New(st)
  return flag:CheckFlag(reward_id)
end

function QuestModule:GetUnReceivedVigorouRewardsBoxNum()
  local l_cfg_vigorous_reward = Cfg.cfg_vigorous_reward({})
  if l_cfg_vigorous_reward == nil then
    Log.fatal("[quest module] function QuestModule:GetUnReceivedVigorouRewardsBoxNum() error --> l_cfg_vigorous_reward is nil ! name --> cfg_vigorous_reward")
    return 0
  end
  local md = self:GetModule(RoleModule)
  local st = md.m_char_info.vig_reward_state
  local flag = FlagValue:New(st)
  local nCurVal = self:GetDailyQuestVigorous()
  local nRewardCount = table.count(l_cfg_vigorous_reward)
  local nUnRecvBoxNum = 0
  for i = 1, nRewardCount do
    local nTarVal = l_cfg_vigorous_reward[i].VigPoint
    if nCurVal >= nTarVal then
      if not flag:CheckFlag(i) then
        nUnRecvBoxNum = nUnRecvBoxNum + 1
      end
    else
      break
    end
  end
  return nUnRecvBoxNum
end

function QuestModule:GetUnreceivedWeekRewardsBoxNum()
  local nUnRecvBoxNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Week)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      nUnRecvBoxNum = nUnRecvBoxNum + 1
    end
  end
  return nUnRecvBoxNum
end

function QuestModule:IsGotAchPointReward(reward_id)
  local md = self:GetModule(RoleModule)
  local st = md.m_char_info.ach_reward_state
  local flag = FlagValue:New(st)
  return flag:CheckFlag(reward_id)
end

function QuestModule:GetUnReceivedAchRewardsBoxNum()
  local l_cfg_achieve_reward = Cfg.cfg_achieve_reward({})
  if l_cfg_achieve_reward == nil then
    Log.fatal("[quest module] function QuestModule:GetUnReceivedAchRewardsBoxNum() error --> l_cfg_achieve_reward is nil ! name --> cfg_achieve_reward")
    return 0
  end
  local md = self:GetModule(RoleModule)
  local st = md.m_char_info.ach_reward_state
  local flag = FlagValue:New(st)
  local nCurVal = self:GetAchPoint()
  local nRewardCount = table.count(l_cfg_achieve_reward)
  local nUnRecvBoxNum = 0
  for i = 1, nRewardCount do
    local nTarVal = l_cfg_achieve_reward[i].AchPoint
    if nCurVal >= nTarVal then
      if not flag:CheckFlag(i) then
        nUnRecvBoxNum = nUnRecvBoxNum + 1
      end
    else
      break
    end
  end
  return nUnRecvBoxNum
end

function QuestModule:SetSortDirty(type)
  if self.m_LastRetList and self.m_LastRetList[type] then
    self.m_LastRetList[type].isSort = false
  end
end

function QuestModule:GetQuestByQuestType(type)
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local l_curTime = time_mod:GetServerTime()
  if l_curTime - self.m_LastGetQuestListTime < 1000 and self.m_LastRetList[type] ~= nil and self.m_LastRetList[type].ret ~= nil then
    if not self.m_LastRetList[type].isSort then
      self.m_LastRetList[type].ret = QuestSorter.Sort(self.m_LastRetList[type].ret, {
        QuestSortParam:New(QuestSortType.Status),
        QuestSortParam:New(QuestSortType.ID)
      })
      self.m_LastRetList[type].isSort = true
    end
    return self.m_LastRetList[type].ret
  end
  self.m_LastRetList = {}
  self.m_LastRetList[type] = {}
  self.m_LastRetList[type].ret = {}
  self.m_LastRetList[type].isSort = false
  local tmNowTime = math.modf(l_curTime / 1000)
  for qid, quest in pairs(self.questDict) do
    local qinfo = quest:QuestInfo()
    if qinfo.BeginCountersTime <= 0 or tmNowTime >= qinfo.BeginCountersTime then
      if not self.m_LastRetList[qinfo.QuestType] then
        self.m_LastRetList[qinfo.QuestType] = {}
        self.m_LastRetList[qinfo.QuestType].ret = {}
        self.m_LastRetList[qinfo.QuestType].isSort = false
      end
      local l_ret = self.m_LastRetList[qinfo.QuestType].ret
      l_ret[#l_ret + 1] = quest
    end
  end
  self.m_LastRetList[type].ret = QuestSorter.Sort(self.m_LastRetList[type].ret, {
    QuestSortParam:New(QuestSortType.Status),
    QuestSortParam:New(QuestSortType.ID)
  })
  self.m_LastGetQuestListTime = l_curTime
  self.m_LastRetList[type].isSort = true
  return self.m_LastRetList[type].ret
end

function QuestModule:GetQuestByQuestTypeChapter(type, chapterId)
  local ret = {}
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  for qid, quest in pairs(self.questDict) do
    local qinfo = quest:QuestInfo()
    if (qinfo.BeginCountersTime <= 0 or tmNowTime >= qinfo.BeginCountersTime) and qinfo.QuestType == type and qinfo.ChapterID == chapterId then
      ret[#ret + 1] = quest
    end
  end
  ret = QuestSorter.Sort(ret, {
    QuestSortParam:New(QuestSortType.Status),
    QuestSortParam:New(QuestSortType.ID)
  })
  return ret
end

function QuestModule:GetQuestByDayIndex(dayIndex)
  local cfgs = Cfg.cfg_quest_growth_day({})
  local day = cfgs[dayIndex] and cfgs[dayIndex].Day
  return self:GetQuestByDay(day)
end

function QuestModule:GetQuestByDay(day)
  local ret = {}
  for qid, quest in pairs(self.questDict) do
    local qinfo = quest:QuestInfo()
    if qinfo.QuestType == QuestType.QT_Growth and qinfo.Day == day then
      ret[qinfo.LayoutIdx] = quest
    end
  end
  return ret
end

function QuestModule:GetQuestIIByStage(stage)
  local tb = {}
  local ret = {}
  for qid, quest in pairs(self.questDict) do
    local qinfo = quest:QuestInfo()
    if qinfo.QuestType == QuestType.QT_Growth and qinfo.GrowthStage == stage then
      ret[qinfo.LayoutIdx] = quest
      tb[qinfo.LayoutIdx] = qinfo.quest_id
    end
  end
  return ret
end

function QuestModule:IsGrowthQuestAllTaken(isFirstStage)
  local quests = self:GetQuestByQuestType(QuestType.QT_Growth)
  for _, quest in ipairs(quests) do
    local first_stage = true
    if quest:GrowthStage() > 0 then
      first_stage = false
    end
    if isFirstStage then
      if first_stage and quest:Status() ~= QuestStatus.QUEST_Taken then
        return false
      end
    elseif not first_stage and quest:Status() ~= QuestStatus.QUEST_Taken then
      return false
    end
  end
  return true
end

function QuestModule:GetRecentCompletedAchiveID()
  local questList = {}
  for i = 1, table.count(self.recent_complete_achieves) do
    table.insert(questList, self:GetQuest(self.recent_complete_achieves[i]))
  end
  QuestSorter.Sort(questList, {
    QuestSortParam:New(QuestSortType.Status),
    QuestSortParam:New(QuestSortType.CompletedTime, QuestSortOrder.Descending),
    QuestSortParam:New(QuestSortType.ID)
  })
  local questIdList = {}
  for i = 1, table.count(questList) do
    table.insert(questIdList, questList[i]:QuestInfo().quest_id)
  end
  return questIdList
end

function QuestModule:GetMainRedPoint()
  local chapterIds = {}
  local quests = self:GetQuestByQuestType(QuestType.QT_Main)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed and not table.icontains(chapterIds, qinfo.ChapterID) then
      table.insert(chapterIds, qinfo.ChapterID)
    end
  end
  return chapterIds
end

function QuestModule:IsTakeStatus(quest_id, status)
  local quest = self:GetQuest(quest_id)
  if not quest then
    return false
  end
  local qinfo = quest:QuestInfo()
  if qinfo.status == status then
    return true
  else
    return false
  end
end

function QuestModule:IsTakeQuest(quest_id)
  local quest = self:GetQuest(quest_id)
  if not quest then
    return false
  end
  local qinfo = quest:QuestInfo()
  if qinfo.status == QuestStatus.QUEST_Taken then
    return true
  else
    return false
  end
end

function QuestModule:GetMainRedPointNum()
  local nTotalNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Main)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      nTotalNum = nTotalNum + 1
    end
  end
  return nTotalNum
end

function QuestModule:GetDailyRedPoint()
  if self:GetUnReceivedVigorouRewardsBoxNum() > 0 then
    return true
  end
  if 0 < self:GetUnreceivedWeekRewardsBoxNum() then
    return true
  end
  local check = self:GetVigorouAndSignIn()
  if check then
    local quests = self:GetQuestByQuestType(QuestType.QT_Daily)
    for _, quest in ipairs(quests) do
      local qinfo = quest:QuestInfo()
      if qinfo.status == QuestStatus.QUEST_Completed then
        return true
      end
    end
  end
  return false
end

function QuestModule:GetVigorouAndSignIn()
  local signModule = self:GetModule(SignInModule)
  local needSignInAgain = signModule:NeedReSignInToday()
  local nCurVigPoint = self:GetDailyQuestVigorous()
  local check = true
  if nCurVigPoint <= 100 then
    check = true
  elseif 100 < nCurVigPoint and nCurVigPoint <= 120 then
    if needSignInAgain then
      check = true
    else
      check = false
    end
  else
    check = false
  end
  return check
end

function QuestModule:GetDailyRedPointNum()
  if self:CheckQuestTypeUnlock(QuestType.QT_Daily) == false then
    return 0
  end
  local nTotalNum = 0
  local check = self:GetVigorouAndSignIn()
  if check then
    local quests = self:GetQuestByQuestType(QuestType.QT_Daily)
    for _, quest in ipairs(quests) do
      local qinfo = quest:QuestInfo()
      if qinfo.status == QuestStatus.QUEST_Completed then
        nTotalNum = nTotalNum + 1
      end
    end
  end
  return nTotalNum
end

function QuestModule:GetBranchRedPoint()
  local quests = self:GetQuestByQuestType(QuestType.QT_Branch)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      return true
    end
  end
  return false
end

function QuestModule:GetBranchRedPointNum()
  local nTotalNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Branch)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      nTotalNum = nTotalNum + 1
    end
  end
  return nTotalNum
end

function QuestModule:GetGrowthRedPoint()
  local quests = self:GetQuestByQuestType(QuestType.QT_Growth)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      return true
    end
  end
  return self:StatisticsGrowthRedPointNum(true, false) or self:StatisticsGrowthRedPointNum(true, true)
end

function QuestModule:StatisticsGrowthRedPointNum(bReturn, bIsGrowthStageFirst)
  local quest_stage = QuestStage.QUEST_STAGE_FIRST
  if not bIsGrowthStageFirst then
    quest_stage = QuestStage.QUEST_STAGE_SECOND
  end
  local cfg_quest_growth_feather = Cfg.cfg_quest_growth_feather({QuestStage = quest_stage})
  local l_num = 0
  if cfg_quest_growth_feather and 0 < #cfg_quest_growth_feather then
    local currFeather = 0
    for i = 1, #cfg_quest_growth_feather do
      local isGot = true
      if bIsGrowthStageFirst then
        isGot = self:CheckGrowthFeatherState(cfg_quest_growth_feather[i].ID)
        currFeather = self:GetFeatherCount()
      else
        isGot = self:CheckStage2GrowthFeatherState(cfg_quest_growth_feather[i].ID)
        currFeather = self:GetStage2FeatherCount()
      end
      if not isGot and currFeather >= cfg_quest_growth_feather[i].NeedCount then
        if bReturn then
          return true
        end
        l_num = l_num + 1
      end
    end
  end
  if bReturn then
    return false
  else
    return l_num
  end
end

function QuestModule:GetGrowthNewPoint()
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    return false
  end
  local key = "QuestModule_GrowthNewPoint_"
  key = UIActivityHelper.GetLocalDBKeyWithPstId(key)
  local new = not LocalDB.HasKey(key)
  local show = self:IsGrowthVisible()
  return show and new
end

function QuestModule:SetGrowthNewPoint()
  local key = "QuestModule_GrowthNewPoint_"
  key = UIActivityHelper.GetLocalDBKeyWithPstId(key)
  LocalDB.SetInt(key, 1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
end

function QuestModule:GetGrowthRedPointNum(day)
  if self:CheckQuestTypeUnlock(QuestType.QT_Growth) == false then
    return 0
  end
  local nTotalNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Growth)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      if day and day == qinfo.Day then
        nTotalNum = nTotalNum + 1
      elseif not day and 0 >= qinfo.GrowthStage then
        nTotalNum = nTotalNum + 1
      end
    end
  end
  return nTotalNum
end

function QuestModule:GetStage2GrowthRedPointNum(GrowthStage)
  if self:CheckQuestTypeUnlock(QuestType.QT_Growth) == false then
    return 0
  end
  local nTotalNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Growth)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      if GrowthStage and GrowthStage == qinfo.GrowthStage then
        nTotalNum = nTotalNum + 1
      elseif not GrowthStage and 0 < qinfo.GrowthStage then
        nTotalNum = nTotalNum + 1
      end
    end
  end
  return nTotalNum
end

function QuestModule:GetGrowthRedPointNumWithFeather(day)
  local nTotalNum = self:GetGrowthRedPointNum(day)
  nTotalNum = nTotalNum + self:StatisticsGrowthRedPointNum(false, true)
  return nTotalNum
end

function QuestModule:GetStage2GrowthRedPointNumWithFeather(GrowthStage)
  local nTotalNum = self:GetStage2GrowthRedPointNum(GrowthStage)
  nTotalNum = nTotalNum + self:StatisticsGrowthRedPointNum(false, false)
  return nTotalNum
end

function QuestModule:GetAchRedPoint()
  local redpoint = {}
  local quests = self:GetQuestByQuestType(QuestType.QT_Achieve)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed and not table.icontains(redpoint, qinfo.AchieveType) then
      table.insert(redpoint, qinfo.AchieveType)
    end
  end
  local mainRP = {}
  if next(redpoint) or self:GetUnReceivedAchRewardsBoxNum() > 0 then
    table.insert(mainRP, AchieveType.AT_All)
  end
  for _, subtype in ipairs(redpoint) do
    local mainType = self:AchiveSubType2AchieveType(subtype)
    if not table.icontains(mainRP, mainType) then
      mainRP[#mainRP + 1] = mainType
    end
  end
  table.appendArray(redpoint, mainRP)
  return redpoint
end

function QuestModule:GetSeasonRedPoint()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local curSample = seasonModule:GetCurSeasonSample()
  if curSample then
    local questRed = curSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_SEASONQUEST_REWARD)
    if questRed then
      return true
    end
  end
  return false
end

function QuestModule:GetSeasonRedPointNum()
  local num = self:GetSeasonRedPoint() and 1 or 0
  return num
end

function QuestModule:CanOneKeyGetReward()
  local quests = self:GetQuestByQuestType(QuestType.QT_Achieve)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      return true
    end
  end
  return false
end

function QuestModule:GetAchRedPointNum()
  if self:CheckQuestTypeUnlock(QuestType.QT_Achieve) == false then
    return 0
  end
  local nTotalNum = 0
  local quests = self:GetQuestByQuestType(QuestType.QT_Achieve)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      nTotalNum = nTotalNum + 1
    end
  end
  return nTotalNum
end

function QuestModule:AchiveSubType2AchieveType(subtype)
  return subtype // 100 * 100
end

function QuestModule:GetNewPoint(enum)
  local tb = self:CalcNewPoint()
  if not self._newPoint then
    self._newPoint = self:CalcNewPoint()
  end
  if enum and tb[enum] ~= nil then
    return tb[enum]
  end
  for _, v in pairs(tb) do
    if v then
      return true
    end
  end
  return false
end

function QuestModule:CalcNewPoint()
  local tb = {}
  tb[QuestType.QT_Main] = false
  tb[QuestType.QT_Daily] = false
  tb[QuestType.QT_Branch] = false
  tb[QuestType.QT_Growth] = false
  tb[QuestType.QT_Achieve] = false
  tb[ClientQuestType.QT_Season] = self:GetSeasonNew()
  return tb
end

function QuestModule:GetSeasonNew()
  local curSample = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  if curSample and curSample.is_open then
    local openid = GameGlobal.GetModule(RoleModule):GetPstId()
    local campid = curSample.id
    local key = "QuestSeasonKey" .. openid .. campid
    local val = LocalDB.GetInt(key, 0)
    return val == 0
  end
  return false
end

function QuestModule:SetSeasonNew()
  local curSample = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  if curSample and curSample.is_open then
    local openid = GameGlobal.GetModule(RoleModule):GetPstId()
    local campid = curSample.id
    local key = "QuestSeasonKey" .. openid .. campid
    LocalDB.SetInt(key, 1)
  end
end

function QuestModule:GetRedPoint()
  if self._redPoint then
    return self._redPoint
  end
  self:CalcRedPoint()
  return self._redPoint
end

function QuestModule:CalcRedPoint()
  local redpoint = {}
  redpoint[QuestType.QT_Main] = self:GetMainRedPoint()
  redpoint[QuestType.QT_Daily] = self:GetDailyRedPoint()
  redpoint[QuestType.QT_Branch] = self:GetBranchRedPoint()
  redpoint[QuestType.QT_Growth] = self:GetGrowthRedPoint()
  redpoint[QuestType.QT_Achieve] = self:GetAchRedPoint()
  redpoint[ClientQuestType.QT_Season] = self:GetSeasonRedPoint()
  self._redPoint = redpoint
end

function QuestModule:GetRedPointNum()
  local l_num = 0
  l_num = l_num + self:GetDailyRedPointNum()
  l_num = l_num + self:GetUnReceivedVigorouRewardsBoxNum()
  l_num = l_num + self:GetUnreceivedWeekRewardsBoxNum()
  l_num = l_num + self:GetBranchRedPointNum()
  if self:IsGrowthOpen() then
    l_num = l_num + self:GetGrowthRedPointNum()
    l_num = l_num + self:StatisticsGrowthRedPointNum(false, true)
    l_num = l_num + self:GetStage2GrowthRedPointNum()
    l_num = l_num + self:StatisticsGrowthRedPointNum(false, false)
  end
  l_num = l_num + self:GetAchRedPointNum()
  l_num = l_num + self:GetUnReceivedAchRewardsBoxNum()
  l_num = l_num + self:GetMainRedPointNum()
  l_num = l_num + self:GetSeasonRedPointNum()
  return l_num
end

function QuestModule:GetMainQuestChapterID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local discoveryData = missionModule:GetDiscoveryData()
  local quests = self:GetQuestByQuestType(QuestType.QT_Main)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Accepted or qinfo.status == QuestStatus.QUEST_Completed then
      local chapterId = qinfo.ChapterID
      if discoveryData:IsChapterReachUnlockTime(chapterId) then
        return chapterId
      end
    end
  end
end

function QuestModule:GetChapterQuests(chapterId)
  local qs = {}
  local quests = self:GetQuestByQuestType(QuestType.QT_Main)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.ChapterID == chapterId then
      qs[#qs + 1] = quest
    end
  end
  return qs
end

function QuestModule:GetChapterQuestsFinish(chapterId)
  local quests = self:GetQuestByQuestTypeChapter(QuestType.QT_Main, chapterId)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status ~= QuestStatus.QUEST_Taken then
      return false
    end
  end
  return true
end

function QuestModule:GetAchieveCount(achType)
  local quests = self:GetQuestByQuestType(QuestType.QT_Achieve)
  local finished = 0
  local total = 0
  local taken = 0
  for _, quest in ipairs(quests) do
    local info = quest:QuestInfo()
    if achType == AchieveType.AT_All or info.AchieveType == achType then
      local achPoint = 0
      for _, reward in ipairs(info.rewards) do
        if reward.assetid == RoleAssetID.RoleAssetAchPoint then
          achPoint = reward.count
          break
        end
      end
      total = total + achPoint
      if info.status >= QuestStatus.QUEST_Completed then
        finished = finished + achPoint
      end
      if info.status == QuestStatus.QUEST_Taken then
        taken = taken + achPoint
      end
    end
  end
  return finished, total, taken
end

function QuestModule:CheckQuestTypeUnlock(qt)
  local role = GameGlobal.GetModule(RoleModule)
  if qt == QuestType.QT_Achieve then
    return role:CheckModuleUnlock(GameModuleID.MD_QuestAchieve)
  elseif qt == QuestType.QT_Branch then
    return #self:GetQuestByQuestType(qt) > 0
  elseif qt == QuestType.QT_Daily then
    return role:CheckModuleUnlock(GameModuleID.MD_QuestDaily)
  elseif qt == QuestType.QT_Growth then
    return role:CheckModuleUnlock(GameModuleID.MD_QuestGrowth)
  elseif qt == QuestType.QT_Main then
    return role:CheckModuleUnlock(GameModuleID.MD_QuestMain)
  end
  return false
end

function QuestModule:TakeQuestReward(TT, id)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestTake)
  request.id = id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventQuestTakeResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  end
  return res, reply.msg
end

function QuestModule:GetQuestDailyRefreshTime(svrTime)
  if self.m_is_request_daily_refresh_time then
    return svrTime
  end
  if self.m_quest_daily_refresh_time <= 0 or svrTime > self.m_quest_daily_refresh_time then
    self.m_is_request_daily_refresh_time = true
    GameGlobal.TaskManager():StartTask(self.ReqQuestDailyRefreshTime, self)
    return svrTime
  else
    return self.m_quest_daily_refresh_time
  end
end

function QuestModule:CalReqQuestDailyRefreshTime(TT)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if self.m_is_request_daily_refresh_time then
    return
  end
  if self.m_quest_daily_refresh_time <= 0 or svrTime > self.m_quest_daily_refresh_time then
    self.m_is_request_daily_refresh_time = true
    self:ReqQuestDailyRefreshTime(TT)
    return
  else
    return
  end
end

function QuestModule:GetWeekRefreshTime()
  return self.m_quest_week_refresh_time
end

function QuestModule:ReqQuestDailyRefreshTime(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestDailyRefreshTime)
  local reply = self:Call(TT, request)
  self.m_is_request_daily_refresh_time = false
  if not reply:Succ() then
    Log.fatal(" CEventQuestDailyRefreshTime Failed 1")
    return
  end
  local replyEvent = CEventQuestDailyRefreshTimeResult(reply.msg)
  if replyEvent == nil then
    Log.fatal(" CEventQuestDailyRefreshTime Failed 2")
    return
  end
  self.m_quest_daily_refresh_time = replyEvent.next_refresh_time
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIQuestDailyVigorous)
  self.m_quest_week_refresh_time = replyEvent.week_next_refresh_time
  return
end

function QuestModule:TakeOneKeyReward(TT, quest_type, custom_quest_array)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventOneKeyTake)
  request.quest_type = quest_type
  if custom_quest_array == nil then
    custom_quest_array = {}
  end
  request.custom_quest = custom_quest_array
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventOneKeyTakeResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  else
    self:CalcRedPoint()
  end
  return res, reply.msg
end

function QuestModule:TakeVigReward(TT, id)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestGetVigReward)
  request.reward_id = id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventQuestGetVigRewardResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  end
  return res, reply.msg
end

function QuestModule:TakeAchReward(TT, id)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestGetAchReward)
  request.reward_id = id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventQuestGetAchRewardResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  else
    self:CalcRedPoint()
  end
  return res, reply.msg
end

function QuestModule:HandleQuestUpdate(msg)
  local calc_red_point = false
  local quests = {}
  local season_task_update = false
  for _, quest in ipairs(msg.update_list) do
    self:SetCfgQuestData(quest)
    local q = self:GetQuest(quest.quest_id)
    if not q then
      self.questDict[quest.quest_id] = Quest:New(quest)
    else
      if (quest.QuestType == QuestType.QT_SeasonTaskLine or quest.QuestType == QuestType.QT_SeasonTaskRand) and (self.questDict[quest.quest_id]:Status() == QuestStatus.QUEST_Accepted or self.questDict[quest.quest_id]:Status() == QuestStatus.QUEST_Completed) and quest.status == QuestStatus.QUEST_Taken then
        season_task_update = true
      end
      if self.questDict[quest.quest_id]:Status() == QuestStatus.QUEST_Completed and quest.status == QuestStatus.QUEST_Taken then
        calc_red_point = true
      end
      self.questDict[quest.quest_id]:Update(quest)
    end
    table.insert(quests, self.questDict[quest.quest_id])
    if quest.status == QuestStatus.QUEST_Taken and quest.QuestType == QuestType.QT_Branch then
      self.questDict[quest.quest_id] = nil
    end
    if quest.status == QuestStatus.QUEST_Completed or self.m_force_cal then
      calc_red_point = true
      self.m_force_cal = false
    end
  end
  if calc_red_point then
    self:CalcRedPoint()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate, quests)
  if season_task_update then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonSubTaskRefresh)
  end
end

function QuestModule:HandleWorldBossRest(msg)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIQuestWorldBossRest)
end

function QuestModule:HandleDayliReset()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIQuestDailyReset)
  self.m_force_cal = true
end

function QuestModule:HandleWeekRewardReset()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnWeekRewardChanged)
end

function QuestModule:HandleQuestStateUpdate(msg)
  self.m_tmGrowthUnlockTime = msg.growth_quest_unlock_time
  self.m_growth_points = msg.growth_points
  self.m_growth_reward_state = msg.growth_reward_state
  self.m_growth_stage2_points = msg.growth_stage2_points
  self.m_growth_stage2_reward_state = msg.growth_stage2_reward_state
end

function QuestModule:HandleRecentAchieve(msg)
  self.recent_complete_achieves = msg.recent_achieves
end

function QuestModule:IsGrowthFeatherAwardAllGot(bIsGrowthStageFirst)
  local cfg_quest_growth_feather = Cfg.cfg_quest_growth_feather({})
  if cfg_quest_growth_feather and 0 < #cfg_quest_growth_feather then
    for i = 1, #cfg_quest_growth_feather do
      local isGot = true
      if bIsGrowthStageFirst then
        if cfg_quest_growth_feather[i].QuestStage == 1 then
          isGot = self:CheckGrowthFeatherState(i)
        end
      elseif cfg_quest_growth_feather[i].QuestStage == 2 then
        isGot = self:CheckStage2GrowthFeatherState(i)
      end
      if not isGot then
        return false
      end
    end
    return true
  else
    Log.fatal("can not find cfg_quest_growth_feather")
    return true
  end
end

function QuestModule:CheckGrowthFeatherState(idx)
  local st = self.m_growth_reward_state
  local flag = FlagValue:New(st)
  return flag:CheckFlag(idx)
end

function QuestModule:CheckStage2GrowthFeatherState(idx)
  local st = self.m_growth_stage2_reward_state
  local flag = FlagValue:New(st)
  return flag:CheckFlag(idx)
end

function QuestModule:RequestGetGrowthFeatherAward(TT, idx)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventQuestGrowthFeatherReward)
  request.reward_id = idx
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventQuestGrowthFeatherRewardResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  else
    self:CalcRedPoint()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ItemCountChanged)
  return res, reply.msg
end

function QuestModule:GetFeatherCount()
  return self.m_growth_points
end

function QuestModule:GetStage2FeatherCount()
  return self.m_growth_stage2_points
end

function QuestModule:GetGrowthTime()
  if self.m_tmGrowthUnlockTime <= 0 then
    return 0
  end
  local l_growth_quest_time = Cfg.cfg_global.GrowthQuestSec.IntValue
  return self.m_tmGrowthUnlockTime + l_growth_quest_time
end

function QuestModule:IsGrowthVisible()
  if not self:IsGrowthOpen() then
    return false
  end
  return self:IsGrowth1Visible() or self:IsGrowth2Visible()
end

function QuestModule:IsGrowth1Visible()
  if self:IsGrowthQuestAllTaken(true) then
    return not self:IsGrowthFeatherAwardAllGot(true)
  else
    return true
  end
end

function QuestModule:IsGrowth2Visible()
  if self:IsGrowthQuestAllTaken(false) then
    return not self:IsGrowthFeatherAwardAllGot(false)
  else
    return true
  end
end

function QuestModule:IsGrowthOpen()
  if self:CheckQuestTypeUnlock(QuestType.QT_Growth) == false then
    return false
  end
  local l_now_time = self:_GetServerTime()
  local l_end_time = self:GetGrowthTime()
  if l_end_time == 0 then
    return false
  end
  if l_now_time >= l_end_time then
    return false
  end
  return true
end

function QuestModule:_GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond = math.floor(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function QuestModule:GetErrorMsg(nErrorCode)
  local vecErrorMsg = {
    [QuestErrorCode.QuestEC_Succ] = StringTable.Get("str_help_pet_error_Succ"),
    [QuestErrorCode.QuestEC_SendRewardError] = StringTable.Get("str_physicalpower_error_phy_add_full")
  }
  return vecErrorMsg[nErrorCode]
end

function QuestModule:ToastUITips(ret)
  local stErrorMsg = self:GetErrorMsg(ret)
  if stErrorMsg then
    ToastManager.ShowToast(stErrorMsg)
  end
end

function QuestModule:GetLatestIndex_QuestGrowthTab()
  local lock = self:CheckQuestIILock(1)
  return lock and 1 or 2
end

function QuestModule:GetLatestIndex_QuestGrowthDay()
  local cfgs = Cfg.cfg_quest_growth_day({})
  local index = 1
  for i, v in ipairs(cfgs) do
    index = self:CheckQuestLock(i) and index or i
  end
  return index
end

function QuestModule:GetLatestIndex_QuestGrowthGoal()
  local cfgs = Cfg.cfg_quest_growth_goal({})
  local index = 1
  for i, v in ipairs(cfgs) do
    index = self:CheckQuestIILock(i) and index or i
  end
  return index
end

function QuestModule:CheckQuestLock(index)
  local curDay = self:GetGrowthQuestCurDay()
  local cfg = Cfg.cfg_quest_growth_day[index]
  return not cfg or curDay < cfg.Day
end

function QuestModule:CheckQuestIILock(index)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    return true
  end
  local list = self:GetQuestIIByStage(index)
  if list and #list ~= 0 then
    local quest = list[1]
    return quest:Status() == QuestStatus.QUEST_NotStart
  end
  return true
end

function QuestModule:HomeLandTaskRedPoint()
  local taskType = {
    QuestType.QT_Homeland_Group_Rookie,
    QuestType.QT_Homeland_Stage,
    QuestType.QT_Homeland_Stage_Num,
    QuestType.QT_Homeland_Common,
    QuestType.QT_Homeland_Change
  }
  for _, _type in pairs(taskType) do
    local allQuest = self:GetQuestByQuestType(_type)
    for _, quest in pairs(allQuest) do
      if quest:QuestInfo().status == QuestStatus.QUEST_Completed then
        return true, _type
      end
    end
  end
  return false, nil
end

function QuestModule:HandleUnlockChapterQuest(msg)
  local unlock_chapter = msg.chapter_index
  LocalDB.SetInt("ChapterQuestIndex", unlock_chapter)
end

function QuestModule:GetLocalChapterQuestIndex()
  return LocalDB.GetInt("ChapterQuestIndex", 0)
end

function QuestModule:HandleClientProcess(TT, quest_id, num)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientProcess)
  request.quest_id = quest_id
  request.num = num == nil and 1 or num
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventClientProcessResult(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  if QuestErrorCode.QuestEC_Succ ~= replyEvent.ret then
    self:ToastUITips(reply.msg.ret)
  end
  return res, replyEvent.rewards
end
