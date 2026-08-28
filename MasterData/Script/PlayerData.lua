local PlayerData = {
  name = "\230\181\139\232\175\149\229\163\185\229\143\183",
  regTime = "20200716",
  platform = "oc",
  Items = {},
  LevelData = {},
  BattleInfo = {},
  currentSquad = {},
  ServerData = {
    roles = {},
    items = {},
    materials = {},
    equipments = {
      equips = {},
      forging_list = {}
    },
    mails = {},
    food_material = {}
  },
  serverTimeOffset = 0,
  TimeZone = 0,
  RemoteId = "",
  ChapterData = {
    chapterlist = {},
    levellist = {}
  },
  last_level = -1,
  online_time = 0,
  AdministrationsAddictionHolidays = false,
  ChooseChapterType = 1,
  BattleCallBackPage = "",
  EnumSideList = {},
  JobSideList = {},
  LevelChain = {},
  pollute_areas = {},
  cameraNodePath = "",
  gotWord = {},
  TempCache = {
    drinkBuff = nil,
    repLvUpCache = nil,
    playgroundLvUpCache = nil,
    AutoCompleteLevels = nil,
    AutoCompleteLevelsServerReward = nil,
    AutoUpdateLevels = nil,
    MainUIShowState = 0,
    GuideTriggerKey = nil,
    NPCTalkData = {},
    BeginDecorateTimeStamp = 0,
    GuideNoUpdateLimitData = {},
    MainUIOpenCamera = false,
    TrainRoadMsgId = 0,
    stationStoreBuff = {},
    ItemPromptBatchNum = 0,
    PromptCallbackStr = "",
    CacheStationAttachChildren = {},
    AutoQuestEvent = {},
    MonsterLevelAutoBattle = false,
    MonsterLevelPassedCache = true,
    CurPlaygroundId = -1,
    backSceneName = nil,
    ADPopInfo = {
      lvTrigger = {},
      questTrigger = {}
    },
    showQuest1 = -1,
    showQuest2 = -1
  },
  achieveList = {finishCnt = 0},
  MultiMissionRefreshAll = true,
  MultiMissionRefreshState = {},
  MultiMission = {},
  plot_paragraph = {},
  showPosterGirl = 1,
  attractionHistory = {},
  RoleSleepTime = {},
  polluteEffectList = {},
  SolicitData = {
    leafletNum = 0,
    copyLeafletNum = 0,
    stationSendPosList = {},
    magazineSendNum = 0,
    magazinePool = {},
    tvSendNum = 0,
    tvPool = {}
  },
  goodsOver = -1,
  CurrentBattleId = nil,
  CurrentMultiBattleIds = {},
  NoticeAddress = nil,
  CaptainSkinSystem = require("CaptainSkinSystem").New()
}
local ConcealList

function PlayerData:GetRoleRemainSleepTime(roleId)
  if self.RoleSleepTime[tostring(roleId)] then
    local time = self.RoleSleepTime[tostring(roleId)].sleepStart + self.RoleSleepTime[tostring(roleId)].sleepTime - os.time()
    if time < 0 then
      time = 0
    end
    return time
  end
  return 0
end

function PlayerData:SetRoleSleepTime(roleId, sleepTime)
  if sleepTime == 0 then
    self.RoleSleepTime[tostring(roleId)] = nil
  else
    self.RoleSleepTime[tostring(roleId)] = {
      sleepStart = os.time(),
      sleepTime = sleepTime
    }
  end
end

function PlayerData:RemoveRoleSleepTime(roleId)
  roleId = tostring(roleId)
  self.RoleSleepTime[roleId] = nil
end

function PlayerData:ResetRoleSleep()
  self.RoleSleepTime = {}
end

local function _initAchieveData()
  PlayerData.achieveList.finishCnt = 0
  for k, v in pairs(PlayerData.ServerData.quests.achieve_quests) do
    local status = 0
    if PlayerData:GetFactoryData(k) then
      local compValue = PlayerData:GetFactoryData(k).num
      if v.recv ~= 0 then
        status = 0
        PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
      elseif compValue <= v.pcnt then
        status = 2
        PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
        local achieveType = PlayerData:GetFactoryData(k).achieveList or 1
        local redName = "AchieveGroup" .. achieveType
        if not RedpointTree.NodeNames[redName] then
          RedpointTree.NodeNames[redName] = "Root|AchievementUI|Group" .. achieveType
          RedpointTree:InsertNode(RedpointTree.NodeNames[redName])
        end
        RedpointTree:InsertNode(RedpointTree.NodeNames["AchieveGroup" .. achieveType] .. "|" .. k)
        RedpointTree:ChangeRedpointCnt(RedpointTree.NodeNames["AchieveGroup" .. achieveType] .. "|" .. k, 1)
      else
        status = 1
      end
      PlayerData.achieveList[tonumber(k)] = {
        status = status,
        recvTime = v.recv,
        pcnt = v.pcnt,
        completed_ts = v.completed_ts
      }
    else
      print("\230\136\144\229\176\177\228\187\187\229\138\161\233\133\141\231\189\174\232\161\168\228\184\173\228\184\141\229\156\168\229\156\168\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129")
    end
  end
  local configID = PlayerData:GetFactoryData(99900041).achievePointList[1].id
  local pointList = PlayerData:GetFactoryData(configID).accumulateList
  local receive_list = {}
  for k, v in pairs(PlayerData.ServerData.quests.accumulate_rewards.accumulate_list) do
    receive_list[v + 1] = 1
  end
  for k, v in pairs(pointList) do
    local status = 0
    if receive_list[k] then
      status = 0
      PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
    elseif v.sumCount <= PlayerData.ServerData.quests.accumulate_rewards.sum_cnt then
      status = 2
      PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
      local achieveType = v.achieveList
      local nodeName = RedpointTree.NodeNames["AchieveGroup" .. achieveType] .. "|" .. v.id
      RedpointTree:InsertNode(nodeName)
      RedpointTree:ChangeRedpointCnt(nodeName, 1)
    else
      status = 1
    end
    PlayerData.achieveList[v.id] = {
      status = status,
      recvTime = 0,
      completed_ts = v.completed_ts
    }
  end
end

local function _initHomeSafeLevelRedPointData()
  for k, v in pairs(PlayerData.ServerData.security_levels) do
    local buildingId = k
    for k1, v1 in pairs(v) do
      local pondId = k1
      local pondCA = PlayerData:GetFactoryData(pondId)
      local canGetCount = 0
      for i, expelRewardInfo in pairs(pondCA.expelRewardList) do
        if v1.expel_num >= expelRewardInfo.expel then
          canGetCount = canGetCount + 1
        end
      end
      local rewards = v1.rewards or {}
      if 0 < canGetCount and #rewards ~= canGetCount then
        local nodeName = RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. buildingId .. "|" .. pondId
        RedpointTree:InsertNode(nodeName)
        RedpointTree:ChangeRedpointCnt(nodeName, 1)
        break
      end
    end
  end
  RedpointTree:InsertNode(RedPointNodeStr.RedPointNodeStr.RubbishStationLevel)
  local env_pro = PlayerData:GetHomeInfo().env_pro or {}
  local buildCfg = PlayerData:GetFactoryData(84400014)
  for k, v in pairs(buildCfg.integralRewardList) do
    if env_pro.env_points >= v.integral then
      local isRecived = false
      for k1, v1 in pairs(env_pro.reward) do
        if v1 == v.index - 1 then
          isRecived = true
        end
      end
      if isRecived == false then
        RedpointTree:ChangeRedpointCnt(RedPointNodeStr.RedPointNodeStr.RubbishStationLevel, 1)
        break
      end
    end
  end
end

local function _initQuestsRedPointData()
  local function AddQuestToRedPoint(questId)
    local questCA = PlayerData:GetFactoryData(questId)
    
    if not QuestProcess.CheckQuestShow(questId) or questCA.startLevel and questCA.startLevel > PlayerData:GetPlayerLevel() then
      return
    end
    local localSave = PlayerData:GetPlayerPrefs("int", "QuestRed" .. questId)
    if localSave == 0 then
      QuestTrace.AddRedNodeData(questId)
    end
  end
  
  for k, v in pairs(PlayerData.ServerData.quests) do
    if k == "branch_quests" or k == "mq_quests" then
      for questId, questInfo in pairs(v) do
        if questInfo.recv == 0 and questInfo.unlock == 1 then
          AddQuestToRedPoint(questId)
        end
      end
    elseif k == "mark_order" then
      for stationId, allQuests in pairs(v) do
        for i, questId in pairs(allQuests) do
          AddQuestToRedPoint(questId)
        end
      end
    end
  end
  local curTime = TimeUtil:GetServerTimeStamp()
  for k, v in pairs(PlayerData:GetHomeInfo().stations) do
    if v.quests then
      for questType, typeQuests in pairs(v.quests) do
        for questId, questInfo in pairs(typeQuests) do
          if questInfo.time ~= -1 then
            local endTime = 0
            local questCA = PlayerData:GetFactoryData(questId)
            if questCA.timeLimit ~= nil and questCA.timeLimit ~= -1 then
              endTime = questInfo.time + questCA.timeLimit * 3600
            end
            if endTime == 0 or curTime < endTime then
              AddQuestToRedPoint(questId)
            end
          end
        end
      end
    end
  end
  local anecdoteList = PlayerData:GetFactoryData(99900078).AnecdoteList
  for k, v in pairs(anecdoteList) do
    if TimeUtil:TimeStamp(v.startTime) <= TimeUtil.GetServerTimeStamp() then
      local status = PlayerData:GetPlayerPrefs("int", v.id)
      if status == 0 then
        RedpointTree:ChangeRedpointCnt(RedpointTree.NodeNames.Anecdote, 1)
        break
      end
    end
  end
end

local function _initCoreRedPointData()
  local coreIds = {
    85300004,
    85300005,
    85300006,
    85300002,
    85300001
  }
  for i, coreId in ipairs(coreIds) do
    local redName = RedpointTree.NodeNames.Core .. "|" .. coreId
    RedpointTree:InsertNode(redName)
    local cacheGet = {}
    local serverCore = PlayerData.ServerData.engines[tostring(coreId)]
    if serverCore and serverCore.lv_reward then
      for i1, lv in ipairs(serverCore.lv_reward) do
        cacheGet[lv] = 0
      end
    end
    local ca = PlayerData:GetFactoryData(coreId)
    for lv = 1, serverCore.lv do
      if not cacheGet[lv - 1] then
        local tempExpInfo = ca.coreExpList[lv]
        if tempExpInfo and 0 < tempExpInfo.id then
          local listCA = PlayerData:GetFactoryData(tempExpInfo.id)
          if 0 < #listCA.EngineRewardList then
            local childRedName = redName .. "|" .. lv
            RedpointTree:InsertNode(childRedName)
            RedpointTree:ChangeRedpointCnt(childRedName, 1)
          end
        end
      end
    end
  end
end

local function _initCacheStationAttachChildren()
  PlayerData.TempCache.CacheStationAttachChildren = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in ipairs(homeConfig.stationList) do
    local stationCA = PlayerData:GetFactoryData(v.id, "HomeStationFactory")
    if stationCA.attachedToCity > 0 then
      local t = PlayerData.TempCache.CacheStationAttachChildren[stationCA.attachedToCity]
      if t == nil then
        t = {}
        PlayerData.TempCache.CacheStationAttachChildren[stationCA.attachedToCity] = t
      end
      table.insert(t, v.id)
    end
  end
end

local function _initBarStoreShopRedPointData()
  local curTime = TimeUtil:GetServerTimeStamp()
  local shopId = 40300012
  local commodityIds = {40200293, 40200028}
  for idx, commodityId in ipairs(commodityIds) do
    if not (curTime < PlayerData:GetPlayerPrefs("int", "BarStoreShopRedPoint|" .. shopId .. "|" .. commodityId)) then
      if PlayerData.ServerData.shops and PlayerData.ServerData.shops[tostring(shopId)] then
        local shopInfo = PlayerData.ServerData.shops[tostring(shopId)]
        if shopInfo.items then
          for i, v in ipairs(shopInfo.items) do
            if tonumber(v.id) == commodityId then
              local commodityCA = PlayerData:GetFactoryData(commodityId)
              local StoreDataModel = require("UIStore/UIStoreDataModel")
              local maxNum = StoreDataModel:GetPurchaseNum(commodityCA)
              if maxNum >= v.py_cnt then
                goto lbl_87
              end
              break
            end
          end
        end
      end
      local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. shopId .. "|" .. commodityId
      RedpointTree:InsertNode(nodeName)
      RedpointTree:ChangeRedpointCnt(nodeName, 1)
    end
    ::lbl_87::
  end
end

local function _initADPopInfo()
  local adCA = PlayerData:GetFactoryData(99900075)
  PlayerData.TempCache.ADPopInfo = {}
  PlayerData.TempCache.ADPopInfo.lvTrigger = {}
  PlayerData.TempCache.ADPopInfo.questTrigger = {}
  PlayerData.TempCache.ADPopInfo.acceptQuestTrigger = {}
  PlayerData.TempCache.ADPopInfo.StopPop = false
  PlayerData.TempCache.ADPopInfo.StopOpen = false
  PlayerData.TempCache.ADPopInfo.CompleteIdxs = nil
  local curLv = PlayerData:GetPlayerLevel()
  for i, v in ipairs(adCA.adList) do
    local t = {}
    t.idx = i
    if curLv < v.lv then
      t.lvCheckOk = false
      if PlayerData.TempCache.ADPopInfo.lvTrigger[v.lv] == nil then
        PlayerData.TempCache.ADPopInfo.lvTrigger[v.lv] = {}
      end
      table.insert(PlayerData.TempCache.ADPopInfo.lvTrigger[v.lv], t)
    else
      t.lvCheckOk = true
    end
    if v.questType == "Complete" then
      if v.questId > 0 and not PlayerData.IsQuestComplete(v.questId) then
        t.questCheckOk = false
        if PlayerData.TempCache.ADPopInfo.questTrigger[v.questId] == nil then
          PlayerData.TempCache.ADPopInfo.questTrigger[v.questId] = {}
        end
        table.insert(PlayerData.TempCache.ADPopInfo.questTrigger[v.questId], t)
      else
        t.questCheckOk = true
      end
    elseif v.questType == "Accept" then
      local state = PlayerData.GetQuestState(v.questId, false)
      if v.questId > 0 and state == EnumDefine.EQuestState.Lock then
        t.questCheckOk = false
        if PlayerData.TempCache.ADPopInfo.acceptQuestTrigger[v.questId] == nil then
          PlayerData.TempCache.ADPopInfo.acceptQuestTrigger[v.questId] = {}
        end
        table.insert(PlayerData.TempCache.ADPopInfo.acceptQuestTrigger[v.questId], t)
      else
        t.questCheckOk = true
      end
    else
      t.questCheckOk = true
    end
  end
  ListenerManager.AddListener(ListenerManager.Enum.CompleteQuest, "ADPopInfo", function(ids)
    for i, questId in pairs(ids) do
      local numQuestId = tonumber(questId)
      local allInfo = PlayerData.TempCache.ADPopInfo.questTrigger[numQuestId]
      if allInfo then
        local count = #allInfo
        local idx = 1
        while count >= idx do
          local t = allInfo[idx]
          t.questCheckOk = true
          if t.lvCheckOk then
            if PlayerData.TempCache.ADPopInfo.CompleteIdxs == nil then
              PlayerData.TempCache.ADPopInfo.CompleteIdxs = {}
            end
            table.insert(PlayerData.TempCache.ADPopInfo.CompleteIdxs, t.idx)
            count = count - 1
            table.remove(allInfo, idx)
          else
            idx = idx + 1
          end
        end
        if #allInfo == 0 then
          PlayerData.TempCache.ADPopInfo.questTrigger[numQuestId] = nil
        end
      end
    end
  end)
  ListenerManager.AddListener(ListenerManager.Enum.AcceptQuest, "ADPopInfo", function(id)
    local numQuestId = tonumber(id)
    local allInfo = PlayerData.TempCache.ADPopInfo.acceptQuestTrigger[numQuestId]
    if allInfo then
      local count = #allInfo
      local idx = 1
      while count >= idx do
        local t = allInfo[idx]
        t.questCheckOk = true
        if t.lvCheckOk then
          if PlayerData.TempCache.ADPopInfo.CompleteIdxs == nil then
            PlayerData.TempCache.ADPopInfo.CompleteIdxs = {}
          end
          table.insert(PlayerData.TempCache.ADPopInfo.CompleteIdxs, t.idx)
          count = count - 1
          table.remove(allInfo, idx)
        else
          idx = idx + 1
        end
      end
      if #allInfo == 0 then
        PlayerData.TempCache.ADPopInfo.acceptQuestTrigger[numQuestId] = nil
      end
    end
  end)
end

function PlayerData:UpdateQuestData(data)
  if table.count(data) == 0 then
    return
  end
  local completeLevels = {}
  local pcntUpdateLevels = {}
  local newAcceptLevels = {}
  for k, v in pairs(data) do
    if k == "order_quests" then
      for k1, v1 in pairs(v.complete) do
        table.insert(completeLevels, v1)
        local questCA = PlayerData:GetFactoryData(v1, "QuestFactory")
        PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests[questCA.cocQuestType][tostring(v1)] = nil
        if questCA.cocQuestType == "Send" then
          for k2, v2 in pairs(questCA.goodsList) do
            if PlayerData.ServerData.user_home_info.warehouse[tostring(v2.id)] ~= nil then
              local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v2.id)].num
              PlayerData.ServerData.user_home_info.warehouse[tostring(v2.id)].num = num - v2.num
            end
          end
        end
      end
      for k1, v1 in pairs(v.incomplete) do
        local questCA = PlayerData:GetFactoryData(k1, "QuestFactory")
        PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests[questCA.cocQuestType][tostring(k1)].info = v1
      end
    elseif k == "multi_pass_weekly_quests" or k == "multi_pass_daily_quests" then
      for m, n in pairs(v) do
        for k1, v1 in pairs(n) do
          local serverData = PlayerData.ServerData.quests[k][m]
          if serverData == nil then
            serverData = {}
            PlayerData.ServerData.quests[k][m] = serverData
          end
          local oldData = serverData[k1]
          if (oldData == nil or oldData.unlock == 0 and oldData.recv == 0) and v1.unlock == 1 then
            local t = {}
            t.id = tonumber(k1)
            t.oldPcnt = 0
            t.newPcnt = v1.pcnt
            t.isNew = true
            table.insert(newAcceptLevels, t)
          end
          serverData[k1] = v1
          local questCA = PlayerData:GetFactoryData(k1, "QuestFactory")
          if questCA.questType ~= "ActivityAchieve" then
            if 0 < v1.recv then
              local completeShow = true
              if questCA.mod == "\230\180\187\229\138\168\228\187\187\229\138\161" and oldData and 0 < oldData.recv and oldData.unlock == 0 then
                completeShow = false
              end
              if completeShow then
                table.insert(completeLevels, k1)
              end
            elseif v1.unlock == 1 and oldData ~= nil and oldData.pcnt < v1.pcnt then
              local t = {}
              t.id = tonumber(k1)
              t.oldPcnt = oldData.pcnt
              t.newPcnt = v1.pcnt
              t.isNew = false
              table.insert(pcntUpdateLevels, t)
            end
          end
        end
      end
    elseif k ~= "achieve_quests" and k ~= "accumulate_rewards" then
      for k1, v1 in pairs(v) do
        local serverData = PlayerData.ServerData.quests[k]
        if serverData == nil then
          serverData = {}
          PlayerData.ServerData.quests[k] = serverData
        end
        local oldData = serverData[k1]
        if (oldData == nil or oldData.unlock == 0 and oldData.recv == 0) and v1.unlock == 1 then
          local t = {}
          t.id = tonumber(k1)
          t.oldPcnt = 0
          t.newPcnt = v1.pcnt
          t.isNew = true
          table.insert(newAcceptLevels, t)
        end
        serverData[k1] = v1
        local questCA = PlayerData:GetFactoryData(k1, "QuestFactory")
        if questCA.questType ~= "ActivityAchieve" then
          if 0 < v1.recv then
            local completeShow = true
            if questCA.mod == "\230\180\187\229\138\168\228\187\187\229\138\161" and oldData and 0 < oldData.recv and oldData.unlock == 0 then
              completeShow = false
            end
            if completeShow then
              table.insert(completeLevels, k1)
            end
          elseif v1.unlock == 1 and oldData ~= nil and oldData.pcnt < v1.pcnt then
            local t = {}
            t.id = tonumber(k1)
            t.oldPcnt = oldData.pcnt
            t.newPcnt = v1.pcnt
            t.isNew = false
            table.insert(pcntUpdateLevels, t)
          end
        end
      end
    end
  end
  if 0 < #completeLevels then
    if PlayerData.TempCache.AutoCompleteLevels == nil then
      PlayerData.TempCache.AutoCompleteLevels = completeLevels
    else
      for k, v in pairs(completeLevels) do
        table.insert(PlayerData.TempCache.AutoCompleteLevels, v)
      end
    end
    QuestTrace.CompleteQuest(completeLevels)
  end
  if 0 < #pcntUpdateLevels then
    if PlayerData.TempCache.AutoUpdateLevels == nil then
      PlayerData.TempCache.AutoUpdateLevels = pcntUpdateLevels
    else
      for k, v in pairs(pcntUpdateLevels) do
        table.insert(PlayerData.TempCache.AutoUpdateLevels, v)
      end
    end
  end
  if 0 < #newAcceptLevels then
    if PlayerData.TempCache.AutoUpdateLevels == nil then
      PlayerData.TempCache.AutoUpdateLevels = {}
    end
    for k, v in pairs(newAcceptLevels) do
      table.insert(PlayerData.TempCache.AutoUpdateLevels, v)
      QuestTrace.AcceptQuest(v.id)
    end
  end
end

function PlayerData:UpdateAchieveData(data)
  print_r("\229\143\152\229\138\168\231\154\132\230\136\144\229\176\177\230\149\176\230\141\174", data)
  local newAchieve = false
  local tipList = {count = 0, nowIndex = 1}
  for k, v in pairs(data) do
    if PlayerData:GetFactoryData(tonumber(k)) then
      PlayerData.ServerData.quests.achieve_quests[k] = v
      local id = tonumber(k)
      if PlayerData.achieveList[id] == nil then
        error("\230\150\176\229\162\158\230\136\144\229\176\177\230\149\176\230\141\174,\230\156\141\229\138\161\231\171\175\228\184\141\229\173\152\229\156\168,\230\136\144\229\176\177id\239\188\154" .. id .. "  (\233\156\128\232\166\129\230\156\141\229\138\161\229\153\168\229\136\183\230\150\176\230\136\144\229\176\177\230\149\176\230\141\174)")
        return
      end
      PlayerData.achieveList[id].recvTime = v.recv
      PlayerData.achieveList[id].pcnt = v.pcnt
      local compValue = PlayerData:GetFactoryData(id).num
      local status = 0
      if v.recv ~= 0 then
        status = 0
      elseif compValue <= v.pcnt then
        status = 2
        PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
        local achieveType = PlayerData:GetFactoryData(k).achieveList
        local redName = "AchieveGroup" .. achieveType
        if not RedpointTree.NodeNames[redName] then
          RedpointTree.NodeNames[redName] = "Root|AchievementUI|Group" .. achieveType
          RedpointTree:InsertNode(RedpointTree.NodeNames[redName])
        end
        local nodeName = RedpointTree.NodeNames["AchieveGroup" .. achieveType] .. "|" .. k
        local success = RedpointTree:InsertNode(nodeName)
        if success then
          RedpointTree:ChangeRedpointCnt(nodeName, 1)
          tipList.count = tipList.count + 1
          tipList["index" .. tipList.count] = k
          PlayerData.achieveList[id].completed_ts = v.completed_ts
        end
      else
        status = 1
      end
      PlayerData.achieveList[id].status = status
      if newAchieve == false then
        newAchieve = status == 2
      end
    else
      print("\230\136\144\229\176\177\228\187\187\229\138\161\233\133\141\231\189\174\232\161\168\228\184\173\228\184\141\229\156\168\229\156\168\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129\239\188\129")
    end
  end
  if newAchieve and tipList.count > 0 then
    print("---------------------\230\156\137\230\150\176\230\136\144\229\176\177\232\190\190\230\136\144")
    UIManager:OpenSpecialUI("UI/Achievement/AchievementGet", Json.encode(tipList))
  end
end

function PlayerData:HandleMainIndex()
  print_r(PlayerData.ServerData.chapter_level)
  RedpointTree:_init()
  if PlayerData.ServerData.roles ~= nil then
    for k, v in pairs(PlayerData.ServerData.roles) do
      v.id = k
    end
  end
  if PlayerData.ServerData.chapter_level ~= nil then
    for k, v in pairs(PlayerData.ServerData.chapter_level) do
      v.id = k
    end
  end
  if PlayerData.ServerData.resource_chapter ~= nil then
    for k, v in pairs(PlayerData.ServerData.resource_chapter) do
      v.id = k
    end
  end
  if PlayerData.ServerData.items ~= nil then
    for k, v in pairs(PlayerData.ServerData.items) do
      v.id = k
    end
  end
  if PlayerData.ServerData.materials ~= nil then
    for k, v in pairs(PlayerData.ServerData.materials) do
      v.id = k
    end
  end
  if PlayerData.ServerData.food_material ~= nil then
    for k, v in pairs(PlayerData.ServerData.food_material) do
      v.id = k
    end
  end
  if PlayerData.ServerData.mails ~= nil then
    for k, v in pairs(PlayerData.ServerData.mails) do
      v.id = k
    end
  end
  if PlayerData.ServerData.last_level ~= nil then
    PlayerData.last_level = tonumber(PlayerData.ServerData.last_level)
  end
  _initAchieveData()
  _initHomeSafeLevelRedPointData()
  _initQuestsRedPointData()
  _initCoreRedPointData()
  _initCacheStationAttachChildren()
  _initBarStoreShopRedPointData()
  _initADPopInfo()
  PlayerData.showPosterGirl = PlayerData:GetHomeInfo().station_info.is_arrived == 2 and 1 or -1
  TrainWeaponTag.CalTrainWeaponAllAttributes()
  HomeFurnitureCollection.Init()
end

function PlayerData:NewSquad(name, ...)
  if self.ServerData.squad == nil then
    self.ServerData.squad = {}
  end
  local squad = {
    name = name,
    role_list = {}
  }
  for key, value in pairs({
    ...
  }) do
    table.insert(squad.role_list, value)
  end
  table.insert(self.ServerData.squad, squad)
end

function PlayerData:NewLevelData(id, score)
  if self.ServerData.chapter_level == nil then
    self.ServerData.chapter_level = {}
  end
  self.ServerData.chapter_level[id] = {score = score}
end

function PlayerData:NewRole(id, portraitId, level, breakthrough, awake, resonanceStage, resonanceLevel, skill1Lv, skill2Lv, skill3Lv)
  local role = {
    id = id or 0,
    portrait_id = portraitId or 0,
    lv = level or 0,
    awake_lv = breakthrough % 6 or 1,
    resonance_lv = awake % 6 or 0,
    equips = {
      "",
      "",
      ""
    },
    skills = {
      {lv = skill1Lv},
      {lv = skill2Lv},
      {lv = skill3Lv}
    },
    exp = math.random(10, 100),
    re_stage = resonanceStage % 4 or 0,
    re_lv = resonanceLevel % 21 or 1,
    re_exp = math.random(0, 5)
  }
  local roleCA = self:GetFactoryData(id, "UnitFactory")
  local skills = {}
  for i, v in ipairs(roleCA.skillList) do
    skills[i] = {
      lv = i,
      id = v.skillId
    }
  end
  role.skills = skills
  self.ServerData.roles[tostring(id)] = role
end

function PlayerData:IsRoleFinalSkillUnlock(id)
  local role = self:GetRoleById(id)
  if next(role) == nil then
    return false
  end
  return self:IsRoleFinalSkillUnlockByData(role)
end

function PlayerData:IsRoleFinalSkillUnlockByData(role)
  if role.unlock_final_skill == nil then
    return false
  end
  return role.unlock_final_skill
end

function PlayerData:SetRoleFinalSKillUnlock(id)
  local role = self:GetRoleById(id)
  role.unlock_final_skill = true
end

function PlayerData:GetRoleResonanceSkillLevel(id, rIndex)
  rIndex = tostring(rIndex)
  local role = self:GetRoleById(id)
  return self:GetRoleResonanceSkillLevelByData(role, rIndex)
end

function PlayerData:GetRoleResonanceSkillLevelByData(role, rIndex)
  if role.skill_info == nil then
    role.skill_info = {}
  end
  if role.skill_info[rIndex] == nil then
    role.skill_info[rIndex] = 0
  end
  return role.skill_info[rIndex]
end

function PlayerData:AddRoleResonanceSkillLevel(id, rIndex)
  rIndex = tostring(rIndex)
  local role = self:GetRoleById(id)
  if role.skill_info == nil then
    role.skill_info = {}
  end
  if role.skill_info[rIndex] == nil then
    role.skill_info[rIndex] = 0
  end
  role.skill_info[rIndex] = role.skill_info[rIndex] + 1
end

function PlayerData:GetRoleResonanceAttributeLevel(id, rIndex, aIndex)
  local role = self:GetRoleById(id)
  return self:GetRoleResonanceAttributeLevelByData(role, rIndex, aIndex)
end

function PlayerData:GetRoleResonanceAttributeLevelByData(role, rIndex, aIndex)
  aIndex = tonumber(aIndex) - 1
  rIndex = tostring(rIndex)
  aIndex = tostring(aIndex)
  if role.attribute_info == nil then
    role.attribute_info = {}
  end
  if role.attribute_info[rIndex] == nil then
    role.attribute_info[rIndex] = {}
  end
  if role.attribute_info[rIndex][aIndex] == nil then
    role.attribute_info[rIndex][aIndex] = 0
  end
  return role.attribute_info[rIndex][aIndex]
end

function PlayerData:AddRoleResonanceAttributeLevel(id, rIndex, aIndex)
  aIndex = tonumber(aIndex) - 1
  rIndex = tostring(rIndex)
  aIndex = tostring(aIndex)
  local role = self:GetRoleById(id)
  if role.attribute_info == nil then
    role.attribute_info = {}
  end
  if role.attribute_info[rIndex] == nil then
    role.attribute_info[rIndex] = {}
  end
  if role.attribute_info[rIndex][aIndex] == nil then
    role.attribute_info[rIndex][aIndex] = 0
  end
  role.attribute_info[rIndex][aIndex] = role.attribute_info[rIndex][aIndex] + 1
end

function PlayerData:GetRoleById(id)
  if self.ServerData == nil or self.ServerData.roles == nil then
    return {}
  end
  return self.ServerData.roles[tostring(id)] or {}
end

function PlayerData:SetRoleResonanceLock(id, isLock, cb)
  Net:SendProto("hero.open_resonance", function(json)
    self:GetRoleById(id).resonance_ss = isLock
    cb()
  end, id, isLock)
end

function PlayerData:IsRoleResonanceLock(id)
  return tonumber(self:GetRoleById(id).resonance_ss) == 1
end

function PlayerData:SetRoleAwakeLock(id, isLock, cb)
  Net:SendProto("hero.open_awake", function(json)
    self:GetRoleById(id).awake_ss = isLock
    cb()
  end, id, isLock)
end

function PlayerData:IsRoleAwakeLock(id)
  return tonumber(self:GetRoleById(id).awake_ss) == 1
end

function PlayerData:GetEnemyById(id)
  if self.ServerData == nil or self.ServerData.books.enemies == nil then
    return {}
  end
  return self.ServerData.books.enemies[tostring(id)] or {}
end

function PlayerData:GetArmamentById(id)
  if self.ServerData == nil or self.ServerData.books.weapon == nil then
    return {}
  end
  return self.ServerData.books.weapon[tostring(id)] or {}
end

function PlayerData:GetEquipmentById(id)
  if self.ServerData == nil or self.ServerData.books.equip == nil then
    return {}
  end
  return self.ServerData.books.equip[tostring(id)] or {}
end

function PlayerData:RefreshRoles(roles)
  for k, v in pairs(roles) do
    v.id = k
    local updateHomeSkill = false
    local curRole = self.ServerData.roles[k]
    if curRole == nil then
      updateHomeSkill = true
    elseif v.resonance_lv > curRole.resonance_lv then
      updateHomeSkill = true
    else
      updateHomeSkill = false
    end
    self.ServerData.roles[k] = v
    if updateHomeSkill then
      PlayerData:HomeSkillLevelUp(tonumber(k))
    end
  end
end

function PlayerData:NewItem(id, Nnum)
  local item = {
    id = id or 0,
    num = num or 0
  }
  self.ServerData.items[tostring(item.id)] = item
end

function PlayerData:GetItems()
  return self.ServerData.items
end

function PlayerData:GetLimitedItems()
  return self.ServerData.limited_items
end

local function GetPassDataByKind(data, kind)
  if data == nil then
    return nil
  end
  local key = tostring(kind)
  if data[key] ~= nil then
    return data[key]
  end
  if data[kind] ~= nil then
    return data[kind]
  end
  for _, v in pairs(data) do
    if type(v) == "table" and (tonumber(v.kind) == tonumber(kind) or tonumber(v.passKind) == tonumber(kind)) then
      return v
    end
  end
  return nil
end

local function GetDefaultPassKind(kind)
  if kind == nil or kind == false then
    return 1
  end
  return tonumber(kind) or 1
end

function PlayerData:GetActiveBattlePassList()
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local passList = {}
  local configList = initConfig and initConfig.BattlePassList or nil
  if configList and table.count(configList) > 0 then
    for index, v in ipairs(configList) do
      if v.id ~= nil then
        local battlePass = PlayerData:GetFactoryData(v.id, "BattlePassFactory")
        if battlePass and TimeUtil:TimeIsActive(battlePass.PassStartTime, battlePass.PassEndTime) then
          table.insert(passList, {
            id = v.id,
            kind = tonumber(v.kind) or 1,
            count = tonumber(v.count) or index,
            index = index
          })
        end
      end
    end
  end
  table.sort(passList, function(a, b)
    if a.count == b.count then
      return a.index < b.index
    end
    return a.count < b.count
  end)
  return passList
end

function PlayerData:RefreshCurrentMultiBattleIds()
  self.CurrentMultiBattleIds = {}
  self.CurrentBattleId = nil
  for _, v in ipairs(self:GetActiveBattlePassList()) do
    self.CurrentMultiBattleIds[v.kind] = v.id
    if self.CurrentBattleId == nil then
      self.CurrentBattleId = v.id
    end
  end
end

function PlayerData:GetBattlePass(kind)
  local passKind = GetDefaultPassKind(kind)
  return GetPassDataByKind(self.ServerData.multi_battle_pass, passKind)
end

function PlayerData:GetQuestDaily(kind)
  local passKind = GetDefaultPassKind(kind)
  local quests = self.ServerData.quests or {}
  return GetPassDataByKind(quests.multi_pass_daily_quests, passKind) or {}
end

function PlayerData:GetActivityDaily()
  return self.ServerData.quests.activity_day_quests or {}
end

function PlayerData:GetQuestWeekly(kind)
  local passKind = GetDefaultPassKind(kind)
  local quests = self.ServerData.quests or {}
  return GetPassDataByKind(quests.multi_pass_weekly_quests, passKind) or {}
end

function PlayerData:GetStageQuest()
  return self.ServerData.quests.stage_quest_reward or {}
end

function PlayerData:GetAttributeById(id)
  local role = self.GetRoleById(self, id)
  return self.CountRoleAttributeById(self, id, role.skills[1].lv, role.skills[2].lv, role.skills[3].lv, role.lv, role.resonance_lv, role.awake_lv, role.re_stage, role.re_lv, role.equips[1], role.equips[2])
end

function PlayerData:CountRoleAttributeById(id, skill1Lv, skill2Lv, skill3Lv, lv, awakeLv, resonanceLevel, trustLv, isBook, equipDataList)
  local role = PlayerData:GetRoleById(id)
  local equips = role.equips
  if equips == nil or isBook then
    equips = {
      "",
      "",
      ""
    }
  end
  if equipDataList == nil then
    equipDataList = {}
    for i = 1, #equips do
      if equips[i] ~= "" and equips[i] ~= nil then
        equipDataList[i] = PlayerData:GetEquipById(equips[i])
      end
      if equipDataList[i] == nil then
        equipDataList[i] = {}
      end
    end
  end
  local exSkillStr = PlayerData:GetRoleResonanceExSkillStr(id)
  if isBook then
    exSkillStr = ""
  end
  local unitAttriStr = DataManager:GetUnitBaseAttributeLua(tonumber(id), skill1Lv, skill2Lv, skill3Lv, lv, awakeLv, resonanceLevel, trustLv, tonumber(equipDataList[1].id) or -1, equipDataList[1].lv or 1, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["0"] and tonumber(equipDataList[1].random_affix["0"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["0"] and -1 < equipDataList[1].random_affix["0"].value and equipDataList[1].random_affix["0"].value * 10000 or 0, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["1"] and tonumber(equipDataList[1].random_affix["1"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["1"] and -1 < equipDataList[1].random_affix["1"].value and equipDataList[1].random_affix["1"].value * 10000 or 0, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["2"] and tonumber(equipDataList[1].random_affix["2"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["2"] and -1 < equipDataList[1].random_affix["2"].value and equipDataList[1].random_affix["2"].value * 10000 or 0, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["3"] and tonumber(equipDataList[1].random_affix["3"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["3"] and -1 < equipDataList[1].random_affix["3"].value and equipDataList[1].random_affix["3"].value * 10000 or 0, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["4"] and tonumber(equipDataList[1].random_affix["4"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["4"] and -1 < equipDataList[1].random_affix["4"].value and equipDataList[1].random_affix["4"].value * 10000 or 0, equipDataList[1].random_affix ~= nil and equipDataList[1].random_affix["5"] and tonumber(equipDataList[1].random_affix["5"].id) or -1, equipDataList[1].random_affix and equipDataList[1].random_affix["5"] and -1 < equipDataList[1].random_affix["5"].value and equipDataList[1].random_affix["5"].value * 10000 or 0, tonumber(equipDataList[2].id) or -1, equipDataList[2].lv or 1, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["0"] and tonumber(equipDataList[2].random_affix["0"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["0"] and -1 < equipDataList[2].random_affix["0"].value and equipDataList[2].random_affix["0"].value * 10000 or 0, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["1"] and tonumber(equipDataList[2].random_affix["1"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["1"] and -1 < equipDataList[2].random_affix["1"].value and equipDataList[2].random_affix["1"].value * 10000 or 0, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["2"] and tonumber(equipDataList[2].random_affix["2"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["2"] and -1 < equipDataList[2].random_affix["2"].value and equipDataList[2].random_affix["2"].value * 10000 or 0, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["3"] and tonumber(equipDataList[2].random_affix["3"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["3"] and -1 < equipDataList[2].random_affix["3"].value and equipDataList[2].random_affix["3"].value * 10000 or 0, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["4"] and tonumber(equipDataList[2].random_affix["4"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["4"] and -1 < equipDataList[2].random_affix["4"].value and equipDataList[2].random_affix["4"].value * 10000 or 0, equipDataList[2].random_affix ~= nil and equipDataList[2].random_affix["5"] and tonumber(equipDataList[2].random_affix["5"].id) or -1, equipDataList[2].random_affix and equipDataList[2].random_affix["5"] and -1 < equipDataList[2].random_affix["5"].value and equipDataList[2].random_affix["5"].value * 10000 or 0, tonumber(equipDataList[3].id) or -1, equipDataList[3].lv or 1, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["0"] and tonumber(equipDataList[3].random_affix["0"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["0"] and -1 < equipDataList[3].random_affix["0"].value and equipDataList[3].random_affix["0"].value * 10000 or 0, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["1"] and tonumber(equipDataList[3].random_affix["1"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["1"] and -1 < equipDataList[3].random_affix["1"].value and equipDataList[3].random_affix["1"].value * 10000 or 0, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["2"] and tonumber(equipDataList[3].random_affix["2"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["2"] and -1 < equipDataList[3].random_affix["2"].value and equipDataList[3].random_affix["2"].value * 10000 or 0, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["3"] and tonumber(equipDataList[3].random_affix["3"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["3"] and -1 < equipDataList[3].random_affix["3"].value and equipDataList[3].random_affix["3"].value * 10000 or 0, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["4"] and tonumber(equipDataList[3].random_affix["4"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["4"] and -1 < equipDataList[3].random_affix["4"].value and equipDataList[3].random_affix["4"].value * 10000 or 0, equipDataList[3].random_affix ~= nil and equipDataList[3].random_affix["5"] and tonumber(equipDataList[3].random_affix["5"].id) or -1, equipDataList[3].random_affix and equipDataList[3].random_affix["5"] and -1 < equipDataList[3].random_affix["5"].value and equipDataList[3].random_affix["5"].value * 10000 or 0, exSkillStr)
  local unitBaseAttribute = Split(unitAttriStr, "#")
  local index = 1
  local petProp = PlayerData:GetRolePetProperty(id)
  local exNum = 0
  local eca = PlayerData:GetFactoryData(equipDataList[3].id)
  if eca then
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(eca, equipDataList[3].lv, 0, equipDataList[3].bk_lv or 0)
    exNum = curNum - lastNum
  end
  local tHp = LuaSafeMath.SafeNumToInt(tonumber(unitBaseAttribute[index])) + petProp.hp + exNum
  index = index + 1
  exNum = 0
  local eca = PlayerData:GetFactoryData(equipDataList[2].id)
  if eca then
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(eca, equipDataList[2].lv, 0, equipDataList[2].bk_lv or 0)
    exNum = curNum - lastNum
  end
  local tDef = LuaSafeMath.SafeNumToInt(tonumber(unitBaseAttribute[index])) + petProp.def + exNum
  index = index + 1
  exNum = 0
  local eca = PlayerData:GetFactoryData(equipDataList[1].id)
  if eca then
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(eca, equipDataList[1].lv, 0, equipDataList[1].bk_lv or 0)
    exNum = curNum - lastNum
  end
  local tAtk = LuaSafeMath.SafeNumToInt(tonumber(unitBaseAttribute[index])) + petProp.atk + exNum
  index = index + 1
  local tCri = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tCriDamage = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tSpeed = LuaSafeMath.SafeNumToInt(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tBlock = LuaSafeMath.SafeNumToInt(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tBlockRate = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tLuck = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tPDamageUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tMDamageUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tFReduce = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tGetPDamageDown = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tGetMDamageDown = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tGetFDamageDown = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tHealUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tShieldUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tGetHealedUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tSummonAtkUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  local tSummonFinalDamageUp = LuaSafeMath.SafeNumToFloat(tonumber(unitBaseAttribute[index]))
  index = index + 1
  return tHp, tDef, tAtk, tCri, tCriDamage, tSpeed, tBlock, tBlockRate, tPDamageUp, tMDamageUp, tFReduce, tGetPDamageDown, tGetMDamageDown, tGetFDamageDown, tHealUp, tShieldUp, tGetHealedUp, tSummonAtkUp, tSummonFinalDamageUp
end

function PlayerData:NewMaterial(id, num)
  local material = {
    id = id or 0,
    num = num or 0
  }
  self.ServerData.materials[tostring(material.id)] = material
end

function PlayerData:GetMaterialByIndex(index)
  return self.Materials[index]
end

function PlayerData:RefreshGoods(goods)
  if not self.ServerData.user_home_info.warehouse then
    self.ServerData.user_home_info.warehouse = goods
  end
  for k, v in pairs(goods) do
    v.id = k
    self.ServerData.user_home_info.warehouse[k] = v
  end
  print_r(self.ServerData.user_home_info.warehouse)
  print_r("self.ServerData.user_home_info.warehouseself.ServerData.user_home_info.warehouseself.ServerData.user_home_info.warehouse")
end

function PlayerData:RefreshMaterial(material)
  if not self.ServerData.materials then
    self.ServerData.materials = material
  end
  for k, v in pairs(material) do
    v.id = k
    self.ServerData.materials[k] = v
  end
end

function PlayerData:RefreshFridgeItems(fridgeItems)
  if not self.ServerData.fridgeItems then
    self.ServerData.fridgeItems = fridgeItems
  end
  for k, v in pairs(fridgeItems) do
    v.id = k
    self.ServerData.fridgeItems[k] = v
  end
end

function PlayerData:RefreshItemPersonalConstruction(activityId, num)
  if PlayerData.ServerData.all_activities.ing[tostring(activityId)] then
    PlayerData.ServerData.all_activities.ing[tostring(activityId)].cst_num = PlayerData:GetActivityPersonalConstructionCstNum(activityId) + num
  end
end

function PlayerData:RefreshItem(items)
  if not self.ServerData.items then
    self.ServerData.items = items
  end
  for k, v in pairs(items) do
    v.id = k
    self.ServerData.items[k] = v
  end
end

function PlayerData:RefreshChapterLevel(chapterLevel)
  if not self.ServerData.chapter_level then
    self.ServerData.chapter_level = chapterLevel or {}
  end
  for k, v in pairs(chapterLevel) do
    v.id = k
    self.ServerData.chapter_level[k] = v
  end
end

function PlayerData:GetMaterials()
  return self.ServerData.materials
end

function PlayerData:GetMaterialById(id)
  return self.ServerData.materials[tostring(id)] or {num = 0}
end

function PlayerData:GetFridgeItems()
  return self.ServerData.food_material
end

function PlayerData:GetGoodsById(id)
  local strId = tostring(id)
  local preThreeStrId = string.sub(strId, 1, 3)
  if preThreeStrId == "114" then
    local itemCA = PlayerData:GetFactoryData(id)
    if itemCA.limitedTime and itemCA.limitedTime > 0 then
      local num = 0
      local curTime = TimeUtil:GetServerTimeStamp()
      for k, v in pairs(self:GetLimitedItems()) do
        if v.id == strId and curTime < v.dead_line then
          num = num + 1
        end
      end
      return {num = num}
    elseif not string.nilorempty(itemCA.endTime) then
      local endTimeStamp = TimeUtil:TimeStamp(itemCA.endTime)
      local curTime = TimeUtil:GetServerTimeStamp()
      local t = {num = 0, endTime = endTimeStamp}
      if endTimeStamp >= curTime and self.ServerData.items[strId] then
        t = self.ServerData.items[strId]
        t.endTime = endTimeStamp
      end
      return t
    end
  end
  if preThreeStrId == "826" then
    local isHave, num = PlayerData:GetUserInfoAvatar(id)
    return {num = num}
  end
  if self.ServerData.furnitureCount and self.ServerData.furnitureCount[strId] then
    return {
      num = self.ServerData.furnitureCount[strId]
    }
  end
  if self.ServerData.items[strId] then
    return self.ServerData.items[strId]
  end
  if self.ServerData.materials[strId] then
    return self.ServerData.materials[strId]
  end
  if self.ServerData.food_material[strId] then
    return self.ServerData.food_material[strId]
  end
  if self.ServerData.books.card_pack[strId] then
    return self.ServerData.books.card_pack[strId]
  end
  if self.ServerData.user_home_info ~= nil and self.ServerData.user_home_info.warehouse[strId] then
    return self.ServerData.user_home_info.warehouse[strId]
  end
  if id == 11400001 then
    return {
      num = self:GetUserInfo().gold
    }
  end
  if id == 11400005 then
    return {
      num = self:GetUserInfo().bm_rock
    }
  end
  if id == 11400017 then
    return {
      num = self:GetUserInfo().medal
    }
  end
  if id == 11400020 then
    return {
      num = self:GetUserInfo().furniture_coins
    }
  end
  if id == 11400006 then
    return {
      num = self:GetUserInfo().energy
    }
  end
  if id == 11400039 then
    return {
      num = self:GetUserInfo().move_energy
    }
  end
  local idint = tonumber(id)
  local facName = DataManager:GetFactoryNameById(idint)
  if facName == "EquipmentFactory" then
    local num = 0
    local allEquips = PlayerData:GetEquips()
    for k, v in pairs(allEquips) do
      if v.id == strId then
        num = num + 1
      end
    end
    return {num = num}
  end
  return {num = 0}
end

function PlayerData:RefreshUseItems(items)
  for k, v in pairs(items) do
    if self.ServerData.limited_items[k] then
      self.ServerData.limited_items[k] = nil
      break
    end
    local item = self:GetGoodsById(tostring(k))
    item.num = item.num - v
  end
end

function PlayerData:RefreshGetItems(items)
  for k, v in pairs(items) do
    local id = tostring(k)
    local item = self:GetGoodsById(id)
    item.num = item.num + v
    self.ServerData.materials[id] = item
  end
end

function PlayerData:RefreshItems(items, type)
  type = type or "reduce"
  for i = 1, #PlayerData.Items do
    local item = PlayerData.Items[i]
    if items[item.id] then
      if type == "reduce" then
        item.num = item.num - items[item.id]
      elseif type == "add" then
        item.num = item.num + items[item.id]
      end
    end
  end
end

function PlayerData:RefreshMaterials(materials, type)
  type = type or "reduce"
  for i, v in pairs(materials) do
    if type == "reduce" then
      self.ServerData.materials[tostring(i)].num = self.ServerData.materials[tostring(i)].num - v
    elseif type == "add" then
      self.ServerData.materials[tostring(i)].num = self.ServerData.materials[tostring(i)].num + v
    end
  end
end

function PlayerData:GetItemByIndex(index)
  return self.Items[index]
end

function PlayerData:GetItemById(id)
  return self.ServerData.items[tostring(id)] or {num = 0}
end

function PlayerData:NewEquip(id, eid, skills)
  local t = {
    eid = eid or 0,
    id = id or 0,
    skills = skills or {}
  }
  self.ServerData.equipments.equips[tostring(eid)] = t
end

function PlayerData:GetEquipByIndex(index)
  return self.Equips[index]
end

function PlayerData:GetEquipById(id)
  for k, v in pairs(PlayerData.ServerData.equipments.equips) do
    if k == id then
      return v
    end
  end
end

function PlayerData:GetEquipByEid(eid)
  for i, v in pairs(PlayerData.ServerData.equipments.equips) do
    if eid == i then
      return v
    end
  end
end

function PlayerData:DeleteEquipById(eid)
  PlayerData.ServerData.equipments.equips[eid] = nil
end

function PlayerData:GetEquipListByType(type)
  if type == nil then
    return self.Equips
  end
  rt = {}
  for i, v in ipairs() do
    if type == PlayerData:GetFactoryData(v.id, "EquipmentFactory").type then
      table.insert(rt, v)
    end
  end
  return rt
end

function PlayerData:RefreshEquips(equips)
  if self.ServerData.equipments.equips then
    self.ServerData.equipments.equips = equips
  end
  for k, v in pairs(equips) do
    self.ServerData.equipments.equips[k] = v
  end
end

function PlayerData:GetEquips()
  return PlayerData.ServerData.equipments.equips or {}
end

function PlayerData:GetRoles()
  return self.ServerData.roles or {}
end

function PlayerData:GetFurniture()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.furniture = {}
  end
  return self.ServerData.user_home_info.furniture
end

function PlayerData:GetBattery()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.home_battery = {}
  end
  return self.ServerData.user_home_info.home_battery
end

function PlayerData:GetBatteryByID(id)
  if self.ServerData.user_home_info == nil or self.ServerData.user_home_info.home_battery == nil then
    return nil
  end
  for k, v in pairs(self.ServerData.user_home_info.home_battery) do
    if v.id == tostring(id) then
      return v
    end
  end
  return nil
end

function PlayerData:GetHomeCreature()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.creatures = {}
  end
  return self.ServerData.user_home_info.creatures
end

function PlayerData:GetHomePet()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.pet = {}
  end
  return self.ServerData.user_home_info.pet
end

function PlayerData:GetHomeCoachBag()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.coach_store = {}
  end
  return self.ServerData.user_home_info.coach_store
end

function PlayerData:GetGoods()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.warehouse = {}
  end
  return self.ServerData.user_home_info.warehouse
end

function PlayerData:GetTransitGoods()
  if self.ServerData.user_home_info == nil then
    self.ServerData.user_home_info = {}
    self.ServerData.user_home_info.warehouse_cache = {}
  end
  return self.ServerData.user_home_info.warehouse_cache
end

function PlayerData:GetMaxPassengerNum()
  local maxNum = 0
  local furCA, isCoachEquip
  for i, v in pairs(self:GetHomeInfo().furniture) do
    if v.u_cid then
      isCoachEquip = false
      for _, cid in pairs(self:GetHomeInfo().coach_template) do
        if cid == v.u_cid then
          isCoachEquip = true
          break
        end
      end
      if isCoachEquip then
        furCA = self:GetFactoryData(v.id, "HomeFurnitureFactory")
        if furCA and furCA.addPassengerCapacity and 0 < furCA.addPassengerCapacity then
          maxNum = maxNum + furCA.addPassengerCapacity
        end
      end
    end
  end
  maxNum = maxNum + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.PassengerNum, maxNum)
  return maxNum
end

function PlayerData:GetCurPassengerNum()
  local curNum = 0
  for destination, v in pairs(self:GetHomeInfo().passenger) do
    curNum = curNum + table.count(v)
  end
  return curNum
end

local comparison_table = {
  [1] = {
    cn = "\231\148\178",
    en = "S",
    num = 3
  },
  [2] = {
    cn = "\228\185\153",
    en = "A",
    num = 2
  },
  [3] = {
    cn = "\228\184\153",
    en = "B",
    num = 1
  },
  [4] = {
    cn = "\228\184\129",
    en = "C",
    num = 0
  },
  [5] = {
    cn = "\230\136\138",
    en = "D",
    num = 0
  }
}

function PlayerData:Score2Rank(scoreList, score)
  local count = table.count(scoreList)
  for i = 1, count do
    if score >= tonumber(scoreList[i].gradeLine) then
      return comparison_table[i]
    end
  end
  return comparison_table[count]
end

function PlayerData:GenItemInfo(id, num)
  local itemInfo = Clone(PlayerData:GetFactoryData(id))
  if num ~= nil then
    itemInfo.num = num
  end
  return itemInfo
end

function PlayerData:NewForgeDrawing(id)
  table.insert(self.ServerData.equipments.forging_list, id)
end

function PlayerData:GetSpecialCurrencyById(idOrKey)
  if type(idOrKey) == "string" then
    return self.ServerData.user_info[idOrKey]
  else
    return self:GetGoodsById(idOrKey).num
  end
end

function PlayerData:GetStoreInfo(id)
  local shop = self.Shops[tostring(id)] or {}
  return shop
end

function PlayerData:NewStore(shopid)
  local shop = PlayerData:GetStoreInfo(shopid)
  if table.count(shop) == 0 then
    local row = {}
    self.Shops[tostring(shopid)] = row
    row.refresh_num = 0
    row.items = {}
  end
end

function PlayerData:GetCommodity(id)
  local commodity = PlayerData:GetFactoryData(id, "CommodityFactory")
  return commodity
end

function PlayerData:NewCommodity(shopid, commodityid)
  self:NewStore(shopid)
  local items = self:GetStoreInfo(shopid).items
  table.insert(items, {
    is_first = false,
    id = commodityid,
    py_cnt = 1
  })
end

local item_sort = {
  role = 1,
  bm_rock = 2,
  equipment = 3,
  item = 4,
  limited_item = 4,
  material = 5,
  energy = 6,
  gold = 7,
  medal = 8,
  furniture = 9,
  battery = 10,
  avatar = 11,
  furniture_coins = 12,
  goods = 13,
  creature = 14,
  pet = 15,
  rep = 16,
  clientCustom = 99
}
local need_sort_key = {
  1,
  3,
  4,
  5
}
local DropSortList

function PlayerData:SortShowItem(itemList)
  if DropSortList == nil then
    local sortlist = {}
    for k, v in pairs(PlayerData:GetFactoryData(99900001).DropSortList) do
      sortlist[v.id] = table.count(PlayerData:GetFactoryData(99900001).DropSortList) - k
    end
    DropSortList = sortlist
  else
    DropSortList = DropSortList
  end
  local sortListCount = table.count(DropSortList)
  local sort_list = {}
  if itemList == nil or table.count(itemList) == 0 then
    return itemList
  end
  for k, v in pairs(itemList) do
    if type(v) == "table" then
      for c, d in pairs(v) do
        local isShow = true
        local row = {}
        if k == "equipment" then
          row.id = d.id
          row.ueid = c
          row.num = 1
        elseif k == "item" and c == "11400013" and c == "11400018" then
          isShow = false
        elseif k == "furniture" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "battery" then
          row.id = d.bid or d.id
          row.num = d.num or 1
        elseif k == "coach" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "clientCustom" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "pet" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "monthly_card" then
          isShow = false
        elseif k == "limited_item" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "dress" then
          row.id = d.id
          row.num = d.num or 1
        elseif k == "extra" then
          row.id = c
          row.num = d.num or 1
          row.extra = true
        elseif k == "leaflet" then
          row.id = c
          row.num = d.num or 1
        else
          row.id = c
          row.num = d.num or 1
        end
        row.index = 0
        row.server = d
        row.id = tonumber(row.id)
        if DropSortList[row.id] then
          row.index = DropSortList[row.id] * 100000
        else
          local ca = PlayerData:GetFactoryData(row.id)
          if ca then
            if k == "role" then
              row.index = (ca.qualityInt + sortListCount) * 1000
            elseif k == "furniture" then
              local quality = ca.rarityInt and ca.rarityInt or 0
              row.index = (quality + sortListCount) * 1000
            else
              if ca.quality == nil then
                row.index = (1 + sortListCount) * 1000
              else
                row.index = (ca.qualityInt + sortListCount) * 1000
              end
              if row.extra == true then
                row.index = row.index + 1
              end
            end
          end
        end
        if PlayerData:GetFactoryData(row.id) then
          local quality = PlayerData:GetFactoryData(row.id).qualityInt and PlayerData:GetFactoryData(row.id).qualityInt + 1 or 0
          if k == "furniture" then
            quality = PlayerData:GetFactoryData(row.id).rarityInt and PlayerData:GetFactoryData(row.id).rarityInt + 1 or 0
          end
          row.quality = quality or 1
          row.factoryName = PlayerData:GetFactoryData(row.id)
        end
        if isShow == true then
          table.insert(sort_list, row)
        end
      end
    end
  end
  local out_list = {}
  table.sort(sort_list, function(a, b)
    if a.index == b.index then
      return a.id < b.id
    end
    return a.index > b.index
  end)
  local count = 1
  for k, v in pairs(sort_list) do
    out_list[count] = v
    count = count + 1
  end
  print_r(itemList)
  print_r("out_list", out_list)
  print_r("\230\142\137\232\144\189\229\136\151\232\161\168-------}}}\227\128\145\227\128\145\227\128\145\227\128\145\227\128\145")
  return out_list
end

function PlayerData:SortRole(roleList, pluckList, isIncr, l, r)
  local function GenSortList(roleList, pluckList)
    local sortList = {}
    
    for i = 1, #roleList do
      table.insert(sortList, i, {})
      local idStr = roleList[i]
      for j = 1, #pluckList do
        if PlayerData.ServerData.roles[idStr][pluckList[j]] ~= nil then
          sortList[i][pluckList[j]] = PlayerData.ServerData.roles[idStr][pluckList[j]]
        else
          sortList[i][pluckList[j]] = PlayerData:GetFactoryData(idStr, "UnitFactory")[pluckList[j]]
        end
      end
    end
    return sortList
  end
  
  local function SortFunc(a, b)
    local _isIncr = isIncr
    for i = 1, #pluckList do
      if tonumber(a[pluckList[i]]) ~= tonumber(b[pluckList[i]]) then
        if _isIncr == true then
          return tonumber(a[pluckList[i]]) > tonumber(b[pluckList[i]])
        else
          return tonumber(a[pluckList[i]]) < tonumber(b[pluckList[i]])
        end
      end
    end
  end
  
  local sortList = GenSortList(roleList, pluckList)
  Sort.SoryByFuncion(sortList, SortFunc, l, r)
  local outputList = {}
  for i = 1, #sortList do
    table.insert(outputList, tostring(sortList[i].id))
  end
  return outputList
end

function PlayerData:RoleListToString(squadRoleList)
  local roleIdStr = ""
  for i = 1, #squadRoleList do
    local data = squadRoleList[i]
    if type(data) ~= "table" then
      roleIdStr = roleIdStr .. data
    elseif data.id ~= nil then
      roleIdStr = roleIdStr .. data.id
    elseif data.unitId ~= nil then
      roleIdStr = roleIdStr .. data.unitId
    end
    if i < #squadRoleList then
      roleIdStr = roleIdStr .. "&"
    end
  end
  return roleIdStr == nil and "" or roleIdStr
end

function PlayerData:RefreshUserInfo(user_info)
  if user_info == nil or self.ServerData == nil or self.ServerData.user_info == nil then
    return
  end
  for k, v in pairs(user_info) do
    self.ServerData.user_info[k] = v
  end
  if user_info.newbie_step ~= nil then
    GuideManager:SetGuideNO(user_info.newbie_step)
  end
  local allInfo = PlayerData.TempCache.ADPopInfo.lvTrigger[user_info.lv]
  if allInfo then
    local count = #allInfo
    local idx = 1
    while count >= idx do
      local t = allInfo[idx]
      t.lvCheckOk = true
      if t.questCheckOk then
        if PlayerData.TempCache.ADPopInfo.CompleteIdxs == nil then
          PlayerData.TempCache.ADPopInfo.CompleteIdxs = {}
        end
        table.insert(PlayerData.TempCache.ADPopInfo.CompleteIdxs, t.idx)
        count = count - 1
        table.remove(allInfo, idx)
      else
        idx = idx + 1
      end
    end
    if #allInfo == 0 then
      PlayerData.TempCache.ADPopInfo.lvTrigger[user_info.lv] = nil
    end
  end
end

function PlayerData:RefreshCards(cards)
  if self.ServerData.cards == nil then
    self.ServerData.cards = {}
  end
  for k, v in pairs(cards) do
    self.ServerData.cards[k] = v
  end
end

function PlayerData:RefreshMails(mails)
  if not mails then
    self.ServerData.mails = mails
  end
  for k, v in pairs(mails) do
    v.id = k
    self.ServerData.mails[k] = v
  end
end

function PlayerData:RefreshShops(shops)
  if self.ServerData.shops == nil then
    self.ServerData.shops = {}
  end
  for k, v in pairs(shops) do
    v.id = k
    self.ServerData.shops[k] = v
  end
end

function PlayerData:RefreshMusic(music)
  self.ServerData.music = music
end

function PlayerData:RefreshEnemies(enemies)
  print_r(self.ServerData.books.enemies, "old")
  if self.ServerData.books.enemies == nil then
    self.ServerData.books.enemies = {}
  end
  for k, v in pairs(enemies) do
    self.ServerData.books.enemies[k] = v
  end
  print_r(self.ServerData.books.enemies, "new")
end

function PlayerData:GetEnemies()
  return self.ServerData.books.enemies
end

local DatabaseDataModel = require("UIDatabase/UIDatabaseDataModel")

function PlayerData:GetNewRoleNum()
  local count = 0
  local count_new = 0
  for k, v in pairs(self:GetRoles()) do
    if k ~= "" then
      count = count + 1
      if v.read == 0 and DatabaseDataModel.CaheRoleData[k] then
        count_new = count_new + 1
      end
    end
  end
  return count_new, count
end

function PlayerData:GetNewEnemiesNum()
  local count = 0
  local count_new = 0
  for k, v in pairs(self:GetEnemies()) do
    if k ~= "" then
      count = count + 1
      if v.read == 0 and DatabaseDataModel.CaheEnemiesData[k] then
        count_new = count_new + 1
      end
    end
  end
  return count_new, count
end

function PlayerData:GetNewArmNum()
  local count = 0
  local count_new = 0
  for k, v in pairs(self.ServerData.books.weapon) do
    if k ~= "" then
      count = count + 1
      if v.read == 0 then
        count_new = count_new + 1
      end
    end
  end
  return count_new, count
end

function PlayerData:GetNewEquip()
  local count = 0
  local count_new = 0
  for k, v in pairs(self.ServerData.books.equip) do
    if k ~= "" then
      count = count + 1
      if v.read == 0 then
        count_new = count_new + 1
      end
    end
  end
  return count_new, count
end

function PlayerData:RefreshPictures(pictures)
  self.ServerData.pictures = pictures
end

function PlayerData:RefreshEnemy(enemy)
  self.ServerData.enemy = enemy
end

function PlayerData:RefreshPhoto(photo)
  self.ServerData.photo = photo
end

function PlayerData:RefreshVideo(video)
  self.ServerData.video = video
end

function PlayerData:RefreshSound(sound)
  self.ServerData.sound = sound
end

function PlayerData:RefreshCardPack(cardPack)
  self.ServerData.books.card_pack = cardPack
end

function PlayerData:RefreshWeapon(weapon)
  self.ServerData.books.weapon = weapon
end

function PlayerData:RefreshEquip(equip)
  self.ServerData.books.equip = equip
end

function PlayerData:RefreshConstruction(construction)
  if PlayerData:GetHomeInfo().station_info.stop_info[1] == nil then
    return
  end
  if PlayerData:GetHomeInfo().stations[tostring(PlayerData:GetHomeInfo().station_info.stop_info[1])] then
    PlayerData:GetHomeInfo().stations[tostring(PlayerData:GetHomeInfo().station_info.stop_info[1])].construction = construction
  end
end

function PlayerData:RefreshOrders(change_order)
  if PlayerData:GetHomeInfo().station_info.stop_info[1] == nil then
    return
  end
  if PlayerData:GetHomeInfo().stations[tostring(PlayerData:GetHomeInfo().station_info.stop_info[1])] then
    PlayerData:GetHomeInfo().stations[tostring(PlayerData:GetHomeInfo().station_info.stop_info[1])].orders = change_order
  end
end

function PlayerData:RefrshPolluteLines(pollute_areas)
  self.pollute_areas = pollute_areas
  self:RefreshPolluteData()
end

function PlayerData:GetDungeonNum(areaId, index)
  local num = 0
  areaId = tostring(areaId)
  index = tostring(index)
  if self:GetHomeInfo() and self:GetHomeInfo().areas and self:GetHomeInfo().areas[areaId] and self:GetHomeInfo().areas[areaId].dungeon and self:GetHomeInfo().areas[areaId].dungeon[index] then
    num = self:GetHomeInfo().areas[areaId].dungeon[index]
  end
  return num
end

function PlayerData:GetDungeonCompleteNum(eventId)
  local num = 0
  eventId = tostring(eventId)
  local curr = self:GetHomeInfo().completed_dungeon[eventId]
  if curr and curr.num then
    num = curr.num - curr.done
  end
  return num
end

function PlayerData:RefreshPolluteData()
  if PlayerData:GetHomeInfo().station_info.is_arrived > 0 then
    return
  end
  local clickEvent = {}
  local dungeonEvent = {}
  local residentEvent = {}
  for i, v in pairs(self.pollute_areas) do
    if v.click_level_events then
      table.insert(clickEvent, {
        areaId = i,
        click = v.click_level_events
      })
    end
    if v.click_dungeon_events then
      local t = {}
      for index, id in pairs(v.click_dungeon_events) do
        local num = self:GetDungeonNum(i, index)
        local event = PlayerData:GetFactoryData(id, "AFKEventFactory")
        if num < event.countMax then
          t[index] = {
            id = tonumber(id),
            num = num
          }
        end
      end
      table.insert(dungeonEvent, {areaId = i, click = t})
    end
    if v.click_resident_events and 0 < table.count(v.click_resident_events) then
      table.insert(residentEvent, {
        areaId = i,
        click = v.click_resident_events
      })
    end
  end
  TrainManager:SetResidentData(residentEvent)
  TrainManager:SetPolluteData(clickEvent)
  TrainManager:SetDungeonData(dungeonEvent)
  print_r("\230\137\147\229\141\176\230\177\161\230\159\147\231\155\184\229\133\179\230\149\176\230\141\174", "\231\130\185\229\135\187\230\177\161\230\159\147\228\186\139\228\187\182\230\149\176\230\141\174", clickEvent, "\231\130\185\229\135\187\230\177\161\230\159\147\228\186\139\228\187\182\229\137\175\230\156\172\230\149\176\230\141\174", dungeonEvent, "\229\184\184\233\169\187\231\130\185\229\135\187\228\186\139\228\187\182", residentEvent)
end

function PlayerData:RefreshGotWord(data)
  self.gotWord = data
end

function PlayerData:RefreshRechargeGoods(shopId, id, buyNum)
  local recharge = PlayerData.RechargeGoods[tostring(shopId)]
  local list = {}
  list.num = buyNum or 1
  if recharge then
    if recharge[tostring(id)] then
      local num = recharge[tostring(id)].num + 1
      list.num = num
      recharge[tostring(id)].num = num
    else
      recharge[tostring(id)] = list
    end
  else
    PlayerData.RechargeGoods[tostring(shopId)] = {}
    PlayerData.RechargeGoods[tostring(shopId)][tostring(id)] = list
  end
end

function PlayerData:RefreshReputation(reputation)
  PlayerData.TempCache.repLvUpCache = nil
  local stations = PlayerData:GetHomeInfo().stations
  if stations == nil then
    stations = {}
  end
  for k, v in pairs(reputation) do
    local station = stations[k]
    if station ~= nil then
      if station.rep_lv ~= v.rep_lv then
        PlayerData.TempCache.repLvUpCache = {}
        PlayerData.TempCache.repLvUpCache.preRepLv = station.rep_lv
        PlayerData.TempCache.repLvUpCache.repLv = v.rep_lv
        PlayerData.TempCache.repLvUpCache.stationId = tonumber(k)
      end
      station.rep_lv = v.rep_lv or 0
      station.rep_num = v.rep_num or 0
    end
  end
end

function PlayerData:RefreshRepList(data)
  for k, v in pairs(data) do
    PlayerData:RefreshRewardRep({
      {num = v}
    }, tonumber(k))
  end
end

function PlayerData:RefreshRewardRep(rewardRep, station)
  local curAdd = 0
  local curStationId
  for k, v in pairs(rewardRep) do
    curAdd = v.num
    curStationId = v.sid
    break
  end
  local stationId = station or curStationId
  if stationId == nil then
    local stop_info = PlayerData:GetHomeInfo().station_info.stop_info
    if stop_info and stop_info[2] == -1 then
      stationId = stop_info[1]
    end
  end
  if stationId then
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if 0 < stationCA.attachedToCity then
      stationId = stationCA.attachedToCity
      stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    end
    local serverData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    local curLv = serverData.rep_lv
    local oldLv = curLv
    local curNum = serverData.rep_num
    local repUpInfo = stationCA.repRewardList[curLv + 1]
    if repUpInfo then
      local upLvNum = repUpInfo.repNum
      curNum = curNum + curAdd
      local isLvUp = false
      while 0 < upLvNum and upLvNum <= curNum do
        isLvUp = true
        curNum = curNum - upLvNum
        curLv = curLv + 1
        repUpInfo = stationCA.repRewardList[curLv + 1]
        if repUpInfo then
          upLvNum = repUpInfo.repNum
        end
      end
      serverData.rep_lv = curLv
      serverData.rep_num = curNum
      if isLvUp then
        PlayerData.TempCache.repLvUpCache = {}
        PlayerData.TempCache.repLvUpCache.preRepLv = oldLv
        PlayerData.TempCache.repLvUpCache.repLv = curLv
        PlayerData.TempCache.repLvUpCache.stationId = tonumber(stationId)
      end
    end
  end
end

function PlayerData:RefreshStationState(change_city)
  local stations = PlayerData:GetHomeInfo().stations
  if stations == nil then
    stations = {}
  end
  for k, v in pairs(change_city) do
    local station = stations[k]
    if station == nil then
      station = {}
      stations[k] = station
    end
    station.state = v.state or 0
    ListenerManager.Broadcast(ListenerManager.Enum.StationStateChange, k, v.state)
  end
end

function PlayerData:RefreshStationsDriveNum(serverStations)
  local stations = PlayerData:GetHomeInfo().stations
  if stations == nil then
    stations = {}
  end
  for k, v in pairs(serverStations) do
    local station = stations[k]
    if station == nil then
      station = {}
      stations[k] = station
    end
    station.drive_num = v.drive_num and v.drive_num or 0
  end
end

function PlayerData:RefreshStationsFairyland(serverStations)
  local stations = self:GetHomeInfo().stations or {}
  for k, v in pairs(serverStations) do
    if not stations[k] then
      stations[k] = v
    else
      stations[k].fairyland = v.fairyland
    end
  end
end

function PlayerData:RefreshStationInfo(station_info)
  if BugLogReporter.SendTrainEvent == nil or TrainManager ~= nil and TrainManager.TrainCtrl ~= nil and TrainManager.TrainCtrl.CurrInfo == nil and station_info and station_info.line_events then
    BugLogReporter.SendTrainEvent = 1
    local NewDrive = {}
    for k, v in pairs(station_info.line_events) do
      NewDrive[k] = {}
      if v.events then
        for m, n in ipairs(v.events) do
          table.insert(NewDrive[k], n.id)
        end
      end
    end
    BugLogReporter:AddTable(BugLogReporter.ReportNames.TrainLineEvents, "\229\143\145\232\189\166\230\149\176\230\141\174", NewDrive)
    BugLogReporter:AddTable(BugLogReporter.ReportNames.TrainLineEvents, "arrive_status:", station_info.arrive_status)
  end
  PlayerData:GetHomeInfo().station_info = station_info
end

function PlayerData.RemoveLineEvent(targetID, id)
  if targetID == nil then
    return
  end
  local _targetID = tostring(targetID)
  local temp = PlayerData:GetHomeInfo().station_info
  if temp.line_events[_targetID] == nil then
    return
  end
  local events = temp.line_events[_targetID].events
  if events == nil then
    return
  end
  for k, v in ipairs(events) do
    if tostring(v.id) == tostring(id) then
      table.remove(PlayerData:GetHomeInfo().station_info.line_events[_targetID].events, k)
      BugLogReporter:AddTail(BugLogReporter.ReportNames.TrainLineEvents, "Lua\231\167\187\233\153\164\228\186\139\228\187\182" .. id)
      return
    end
  end
end

function PlayerData:GetBoxIdByDistance(sid, distance)
  local stationInfo = self:GetHomeInfo().station_info
  if stationInfo ~= nil and stationInfo.line_events ~= nil and stationInfo.line_events[sid] ~= nil and stationInfo.line_events[sid].box_events ~= nil then
    for i, v in ipairs(stationInfo.line_events[sid].box_events) do
      if v.distance == distance then
        return v.id, i
      end
    end
  end
  return nil
end

function PlayerData:GetBoxDistanceByIndex(sid, index)
  local stationInfo = self:GetHomeInfo().station_info
  if stationInfo ~= nil and stationInfo.line_events ~= nil and stationInfo.line_events[sid] ~= nil and stationInfo.line_events[sid].box_events ~= nil and stationInfo.line_events[sid].box_events[index] ~= nil then
    return stationInfo.line_events[sid].box_events[index].distance
  end
  return nil
end

function PlayerData:RefreshDisplayTrain(display_train)
  PlayerData:GetHomeInfo().display_train = display_train
end

function PlayerData:RefreshReadiness(readiness)
  for k, v in pairs(readiness) do
    PlayerData:GetHomeInfo().readiness[k] = v
  end
end

function PlayerData:RefreshDevDegree(dev_degree)
  local serverDevDegree = PlayerData:GetHomeInfo().dev_degree
  for k, v in pairs(dev_degree) do
    serverDevDegree[k] = v
  end
end

function PlayerData:GetRoleLv(id)
  if self.ServerData.roles[tostring(id)] then
    return tonumber(self.ServerData.roles[tostring(id)].lv)
  end
  return 1
end

function PlayerData:GetRoleSkill(roleid)
  if self.ServerData.roles[tostring(roleid)] and self.ServerData.roles[tostring(roleid)].skills then
    return self.ServerData.roles[tostring(roleid)].skills
  else
    return {}
  end
end

function PlayerData:GetRoleSkillLv(roleid, index)
  local skill = PlayerData:GetRoleSkill(roleid)
  local lv = 1
  if skill[index] then
    lv = skill[index].lv
  end
  return tonumber(lv)
end

function PlayerData:GetRoleSkillId(roleid, index)
  local skill = PlayerData:GetRoleSkill(roleid)
  local id = ""
  if skill[tonumber(index)] then
    id = skill[tonumber(index)].id
  end
  return id
end

function PlayerData:GetSkillFactory(id)
  return PlayerData:GetFactoryData(id, "SkillFactory")
end

function PlayerData:GetUnitSkillFactory(index, id)
  local id = self:GetFactoryData(id, "UnitFactory").skillLvUpList[tonumber(index)].id
  local skillLvup = self:GetFactoryData(id, "SkillLvUpFactory")
  local unitLevelList = skillLvup.unitLevelList
  local materialList = skillLvup.materialList
  local levelMax = skillLvup.levelMax
  return unitLevelList, materialList, levelMax
end

function PlayerData:GetNotSkillUpdate(roleid, index)
  local unitLevelList, materialList, levelMax = PlayerData:GetUnitSkillFactory(index, roleid)
  local updateLv = 0
  if 0 < table.count(unitLevelList) then
    if unitLevelList[PlayerData:GetRoleSkillLv(roleid, index)] then
      updateLv = tonumber(unitLevelList[PlayerData:GetRoleSkillLv(roleid, index)].level)
    end
    if updateLv <= PlayerData:GetRoleLv(roleid) and levelMax > PlayerData:GetRoleSkillLv(roleid, index) then
      return true, updateLv, levelMax
    else
      return false, updateLv, levelMax
    end
  end
  return true, 0, levelMax
end

function PlayerData:GetNnlockConditions(ShopID)
  local conf = self:GetFactoryData(ShopID, "StoreFactory")
  local unlockConditions = conf.unlockConditions
  local conditions = conf.conditions
  if unlockConditions == true then
    return unlockConditions, conditions
  end
  return false
end

function PlayerData:GetListFactory(id)
  return self:GetFactoryData(id, "ListFactory")
end

function PlayerData:GetSourceMaterialFactory(id)
  return self:GetFactoryData(id, "SourceMaterialFactory")
end

function PlayerData:GetItemViewFactory(id)
  return self:GetFactoryData(id, "ItemViewFactory")
end

local function Condition(config)
  local storeCondition = PlayerData.GetStoreConditionFactory(config.conditions)
  local userInfo = PlayerData:GetUserInfo()
  if config.unlockConditions and storeCondition.levelNum <= PlayerData:GetCustomsChapterNum() and storeCondition.playLv <= userInfo.lv then
    return true
  elseif config.unlockConditions == false then
    return true
  end
  return false
end

function PlayerData.GetInitStoreConfig()
  return PlayerData:GetFactoryData(99900001, "ConfigFactory").storeMainList
end

function PlayerData.GetStoreConfig(id)
  return PlayerData:GetFactoryData(id, "StoreFactory")
end

function PlayerData.GetStoreConditionFactory(id)
  return PlayerData:GetFactoryData(id, "StoreConditionFactory")
end

function PlayerData:OpenStoreCondition()
  local ConditionList = {}
  local InitSelectIndex = 1
  local ConditionTrueNum = 0
  for k, v in pairs(self.GetInitStoreConfig()) do
    local store = self.GetStoreConfig(tonumber(v.id))
    ConditionList[k] = {
      state = Condition(store),
      txt = store.TextLockId,
      storeid = v.id,
      showUI = store.showUI
    }
    if Condition(store) == true then
      ConditionTrueNum = ConditionTrueNum + 1
      InitSelectIndex = k
      if InitSelectIndex == ConditionTrueNum then
        InitSelectIndex = 1
      end
    end
  end
  if 1 < ConditionTrueNum then
    return true, ConditionList, InitSelectIndex, ConditionTrueNum
  end
  return false, ConditionList
end

function PlayerData:GetUserInfo()
  return self.ServerData.user_info
end

function PlayerData:GetHomeInfo()
  return self.ServerData.user_home_info
end

function PlayerData:GetEnergyMax()
  local lv = self:GetUserInfo().lv
  local expList = self:GetFactoryData(99900004, "ConfigFactory").expList[lv]
  if expList then
    return expList.EnergyMax
  else
    return
  end
end

function PlayerData:GetCustomsChapterNum()
  return table.count(self.ServerData.chapter_level) or 0
end

function PlayerData:GetMaxExp()
  return PlayerData:GetFactoryData(99900004, "ConfigFactory").expList[self:GetUserInfo().lv or 1].levelUpExp
end

local conf_type = {
  [110] = "SkinViewTips",
  [114] = "ItemTips",
  [117] = "ItemTips",
  [403] = "ItemTips",
  [118] = "EquipTips",
  [100] = "CharacterTips",
  [813] = "FurnitureTips",
  [831] = "HomeWeapon",
  [803] = "ItemTips",
  [708] = "ItemTips",
  [829] = "GoodsTips",
  [850] = "FridgeItemTips",
  [855] = "DressTips",
  [826] = "PhotoTips",
  [862] = "CardTips",
  [863] = "CardPackTips"
}

function PlayerData:GetRewardType(id)
  local index = tonumber(string.sub(id, 1, 3))
  if conf_type[index] then
    return conf_type[index]
  end
  return ""
end

function PlayerData:GetFactoryData(id, factoryName)
  if preloadAllFactoryData then
    factoryName = factoryName or DataManager:GetFactoryNameById(tonumber(id))
    return _data[factoryName][tonumber(id)]
  end
  return GetCA(id, factoryName)
end

function PlayerData:SetChapterLevelTable()
  local mainChapter = self:GetFactoryData(99900001, "ConfigFactory").mainChapter
  local chapter_list = {}
  local level_list = {}
  for k, v in pairs(mainChapter) do
    local stageInfoList = PlayerData:GetFactoryData(v.chapterId).stageInfoList
    chapter_list[v.chapterId] = {index = k}
    chapter_list[v.chapterId].count = table.count(stageInfoList)
    for c, d in pairs(stageInfoList) do
      level_list[d.levelId] = v.chapterId
    end
  end
  self.ChapterData.chapterlist = chapter_list
  self.ChapterData.levellist = level_list
end

function PlayerData:SetSortChapterLevelTable()
  local mainChapter = self:GetFactoryData(99900001, "ConfigFactory").mainChapter
  local chapterList = {}
  for i, v in ipairs(mainChapter) do
    local stageInfoList = PlayerData:GetFactoryData(v.chapterId).stageInfoList
    local t = {}
    t.chapterId = v.chapterId
    local stageInfoList1 = {}
    local maxCount = 0
    for index, value in ipairs(stageInfoList) do
      if 0 < value.index then
        maxCount = maxCount + 1
        stageInfoList1[value.index] = value.levelId
      end
    end
    stageInfoList1.count = maxCount
    t.levelList = stageInfoList1
    chapterList[i] = t
  end
  self.ChapterData.SortChapter = chapterList
end

function PlayerData:GetChpterCountMax(chapterId)
  return self.ChapterData.chapterlist[chapterId].count
end

function PlayerData:GetCustomsChapterLevelNum(chapterId)
  local count = 0
  for k, v in pairs(self.ServerData.chapter_level) do
    local Id = self.ChapterData.levellist[tonumber(k)]
    if Id ~= nil and Id == chapterId then
      count = count + 1
    end
  end
  return count
end

function PlayerData:GetLevelPass(levelid)
  if self.ServerData == nil or self.ServerData.chapter_level == nil then
    return false
  end
  if DataManager:GetFactoryNameById(tonumber(levelid)) == "AbyssFactory" then
    local abyssCA = PlayerData:GetFactoryData(levelid)
    local isPass = true
    for i = 1, #abyssCA.levelList do
      if PlayerData:GetLevelPass(abyssCA.levelList[i].id) ~= true then
        isPass = false
        break
      end
    end
    return isPass
  end
  if levelid and self.ServerData.chapter_level[tostring(levelid)] and self.ServerData.chapter_level[tostring(levelid)].received == 1 then
    return true
  end
  return false
end

function PlayerData:GetLevelPassBySelf(levelid)
  local isPass = PlayerData:GetLevelPass(levelid)
  if isPass == true and self.ServerData.chapter_level[tostring(levelid)].pass and self.ServerData.chapter_level[tostring(levelid)].pass == 0 then
    isPass = false
  end
  return isPass
end

function PlayerData:CheckLevelChainState()
  print_r(self.ServerData.chapter_level)
  return false
end

function PlayerData:GetLevelFirstRewardsReceived(levelId)
  if levelId == nil then
    return false
  end
  local level = self.ServerData.chapter_level[tostring(levelId)]
  if level ~= nil and level.received == 1 then
    return true
  end
  return false
end

function PlayerData:SetResourceLevelData(res)
  self.ServerData.resource_chapter = res.resource_chapter
  if self.ServerData.resource_chapter ~= nil then
    for k, v in pairs(self.ServerData.resource_chapter) do
      v.id = k
    end
  end
end

function PlayerData:GetResourceLevelData(chapterid)
  if chapterid and self.ServerData.resource_chapter[tostring(chapterid)] then
    return self.ServerData.resource_chapter[tostring(chapterid)].num
  end
  return nil
end

function PlayerData:GetTimePast(time)
  if not time then
    return false
  end
  if time <= self:GetSeverTime() then
    return true
  end
  return false
end

function PlayerData:GetUnreadMailNum()
  if table.count(self.ServerData.mails) == 0 then
    if self:GetUserInfo().mail_status ~= 0 then
      return "", true
    end
    return 0, false
  end
  local count = 0
  local a = 0
  for k, v in pairs(self.ServerData.mails) do
    a = a + 1
    if v.read == 0 then
      if not self:GetTimePast(v.deadline) then
        count = count + 1
      end
    elseif v.recv and v.recv == 0 and not self:GetTimePast(v.deadline) then
      count = count + 1
    end
  end
  return count, 0 < count
end

local function ChangeStampPoint(lv, point, interval, add)
  local new_point, new_lv
  local a, b = math.modf((point + add) / interval)
  local differ = point + add - a * interval
  new_lv = lv + a
  new_point = differ
  return new_point, new_lv
end

local function RefreshStamp(id, num)
  local ca = PlayerData:GetFactoryData(id)
  if ca.mod == "\233\128\154\232\161\140\232\175\129\233\129\147\229\133\183" then
    local passKind = tonumber(ca.battlePassKind) or 1
    local battlePassEXP = ca.battlePassEXP or 0
    local points = battlePassEXP * num
    local state, battlePassId = PlayerData:GetNowPassData(passKind)
    if state then
      local battlePass = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
      local intervalPoint = battlePass.Points
      local passData = PlayerData:GetBattlePass(passKind)
      if passData == nil then
        return
      end
      local now_lv = passData.pass_level or 0
      local now_point = passData.points or 0
      local a, b = ChangeStampPoint(now_lv, now_point, intervalPoint, points)
      passData.points = a
      passData.pass_level = b
      if b > battlePass.LevelLimit then
        passData.points = intervalPoint
        passData.pass_level = passData.pass_level
      end
    end
  end
end

local function RefreshRewardSever(list, add, protocolName)
  local gotWord = false
  for k, v in pairs(add) do
    if list[k] == nil then
      local ca = PlayerData:GetFactoryData(k)
      if ca.mod == "\232\181\132\230\150\153\233\129\147\229\133\183" then
        table.insert(PlayerData.gotWord, tostring(ca.dataDrop))
        gotWord = true
      elseif ca.mod == "\229\155\190\231\186\184\233\129\147\229\133\183" then
        PlayerData.ServerData.formula_items = PlayerData.ServerData.formula_items or {}
        table.insert(PlayerData.ServerData.formula_items, k)
      elseif ca.mod == "\229\187\186\232\174\190\232\191\155\229\186\166" then
        if ca.correspondingCity ~= "" and PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)] then
          if PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction then
            local ConstructMaxNum = 0
            local ConstructNowNum = 0
            local nowCityCA = PlayerData:GetFactoryData(ca.correspondingCity)
            local constructStageList = nowCityCA.constructStageList
            local nowStageIndex = 0
            for i = 1, #constructStageList do
              local row = constructStageList[i]
              local row_construction = PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction[i]
              ConstructMaxNum = ConstructMaxNum + row.constructNum
              ConstructNowNum = ConstructNowNum + row_construction.proportion
              if ConstructMaxNum > ConstructNowNum then
                nowStageIndex = i
                break
              elseif constructStageList[i + 1] then
                nowStageIndex = i + 1
                ConstructMaxNum = ConstructMaxNum + constructStageList[nowStageIndex].constructNum
                ConstructNowNum = ConstructNowNum + PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction[nowStageIndex].proportion
                break
              end
              nowStageIndex = i
            end
            if ConstructMaxNum > ConstructNowNum then
              local row_construction = PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction[nowStageIndex]
              row_construction.proportion = row_construction.proportion + v.num
              if constructStageList[nowStageIndex] and row_construction.proportion > constructStageList[nowStageIndex].constructNum then
                if constructStageList[nowStageIndex + 1] then
                  local last_row = PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction[nowStageIndex + 1]
                  last_row.proportion = row_construction.proportion - constructStageList[nowStageIndex].constructNum
                end
                row_construction.proportion = constructStageList[nowStageIndex].constructNum
              end
            end
          else
            local t_r = {}
            t_r.proportion = v.num
            t_r.rec_index = {}
            PlayerData:GetHomeInfo().stations[tostring(ca.correspondingCity)].construction = t_r
          end
        end
      elseif ca.mod == "\229\187\186\232\174\190\230\180\187\229\138\168" then
        PlayerData:RefreshItemPersonalConstruction(ca.correspondingActivity, v.num)
      elseif ca.mod == "\229\164\167\229\175\140\231\191\129\233\129\147\229\133\183" and ca.monopolyItemType == "coin" and protocolName ~= "monopoly.monopoly_map" then
        PlayerData.AddUserMonopolyExp(v.num)
        list[k] = Clone(v)
        list[k].id = k
      elseif ca.mod == "\230\184\184\228\185\144\229\156\186\231\187\143\233\170\140" then
        local itemCA = PlayerData:GetFactoryData(k)
        if itemCA.playgroundId and 0 < itemCA.playgroundId then
          local playgroundCA = PlayerData:GetFactoryData(itemCA.playgroundId)
          local curServerInfo = CommonCoachData.GetCurPlaygroundServerInfo(itemCA.playgroundId)
          local maxLv = #playgroundCA.expList
          local curLv = curServerInfo.lv
          if maxLv > curLv then
            PlayerData.TempCache.playgroundLvUpCache = {}
            PlayerData.TempCache.playgroundLvUpCache.preLevel = curLv
            local curExp = curServerInfo.exp + v.num
            for i = curLv, maxLv do
              local info = playgroundCA.expList[i]
              if curExp >= info.exp then
                curExp = curExp - info.exp
                curLv = curLv + 1
                if curLv == maxLv then
                  curExp = 0
                end
              else
                break
              end
            end
            curServerInfo.lv = curLv
            curServerInfo.exp = curExp
            if PlayerData.TempCache.playgroundLvUpCache.preLevel == curLv then
              PlayerData.TempCache.playgroundLvUpCache = nil
            else
              PlayerData.TempCache.playgroundLvUpCache.level = curLv
              PlayerData.TempCache.playgroundLvUpCache.casual = v.casual or {}
              if v.casual then
                PlayerData.RefreshVisitorData(itemCA.playgroundId, v.casual)
              end
            end
          end
        end
      elseif ca.mod == "\233\187\145\230\156\136\230\184\184\228\185\144\229\159\142\229\143\175\228\189\191\231\148\168\233\129\147\229\133\183" or ca.mod == "\233\187\145\230\156\136\230\184\184\228\185\144\229\159\142\233\129\147\229\133\183" then
        WitchData.RefreshRewardItemData(k, v)
      else
        list[k] = Clone(v)
        list[k].id = k
      end
    else
      if list[k].num then
        list[k].num = list[k].num + v.num
      end
      if list[k].month_time then
        list[k].month_time = v.month_time
      end
      local ca = PlayerData:GetFactoryData(k)
      if ca and ca.mod == "\229\164\167\229\175\140\231\191\129\233\129\147\229\133\183" and ca.monopolyItemType == "coin" and protocolName ~= "monopoly.monopoly_map" then
        PlayerData.AddUserMonopolyExp(v.num)
      end
    end
    if ConcealList == nil then
      ConcealList = {}
      local d_list = PlayerData:GetFactoryData(99900001).defaultConcealList
      for k, v in pairs(d_list) do
        ConcealList[tostring(v.id)] = true
      end
    end
    if ConcealList[k] == true then
      PlayerData.CurrentBattleId = nil
      PlayerData.CurrentMultiBattleIds = {}
    end
    RefreshStamp(k, v.num)
  end
  if gotWord then
    UIManager:Open("UI/Database/tips/DataTips")
  end
end

local function RefreshRewardLimitedItemServer(list, add)
  for k, v in pairs(add) do
    list[k] = Clone(v)
  end
end

local function RefreshRewardRoleSkinSever(list)
  local userInfo = PlayerData:GetUserInfo()
  if table.count(list) ~= 0 then
    for k, v in pairs(list) do
      local ca = PlayerData:GetFactoryData(k)
      if 0 < ca.profilePhotoID then
        table.insert(userInfo.avatar_list, tostring(ca.profilePhotoID))
      end
      if PlayerData.IsSkinHomeSkillOpen() and ca.homeSkill and 0 < ca.homeSkill then
        PlayerData:HomeSkillLevelUp(tonumber(k), true)
      end
      local roleServer = PlayerData:GetRoleById(ca.character)
      local skin_list = roleServer.skin_list or {}
      if skin_list[k] == nil then
        skin_list[k] = {}
      end
    end
  end
end

local function RefreshRewardRoleHead(add)
  local userInfo = PlayerData:GetUserInfo()
  for k, v in pairs(add) do
    local ca = PlayerData:GetFactoryData(k)
    local viewCa = PlayerData:GetFactoryData(ca.viewId)
    if viewCa.profilePhotoID > 0 then
      table.insert(userInfo.avatar_list, tostring(viewCa.profilePhotoID))
    end
  end
end

local function RefreshRewardRoleHomeSkillUpdate(add)
  for k, v in pairs(add) do
    PlayerData:HomeSkillLevelUp(tonumber(k))
  end
end

local function RefreshRewardEquiptSever(args)
  local list = args.list
  local add = args.add
  local protocolName = args.protocolName
  for k, v in pairs(add) do
    if list[k] == nil then
      list[k] = Clone(v)
    elseif list[k].num then
      list[k].num = list[k].num + v.num
    end
    local trackArgs = {}
    trackArgs.get_equip_from = protocolName
    trackArgs.equip_id = v.id
    SdkReporter.TrackGetEquip(trackArgs)
  end
end

local function RefreshRewardFurnitureSever(add)
  local home_info = PlayerData:GetHomeInfo()
  for k, v in pairs(add) do
    local ca = PlayerData:GetFactoryData(v.id)
    local t = CommonCoachData.GetFurData(ca.bag)
    if t then
      t[k] = Clone(v)
    end
    PlayerData.SetFurnitureCount(v.id, 1)
  end
  HomeFurnitureCollection.FurReward(add)
end

local function RefreshRewardBatterySever(list, add)
  for k, v in pairs(add) do
    list[k] = Clone(v)
  end
end

local function RefreshRewardCreatureSever(list, add)
  for k, v in pairs(add) do
    if list[k] == nil then
      list[k] = Clone(v)
    elseif list[k].num then
      list[k].num = list[k].num + v.num
    end
  end
end

local function RefreshRewardPetSever(list, add)
  for k, v in pairs(add) do
    list[k] = Clone(v)
  end
end

local function RefreshRewardCoachServer(list, add)
  for k, v in pairs(add) do
    list[k] = Clone(v)
  end
end

local function RefreshRewardGoodsServer(list, add)
  for k, v in pairs(add) do
    if list[k] == nil then
      list[k] = Clone(v)
    else
      list[k].avg_price = v.avg_price
      list[k].num = list[k].num + v.num
    end
  end
end

local function RefreshRewardFuelNum(list, add)
  for k, v in pairs(add) do
    list.fuel_num = list.fuel_num + v.num
  end
end

local function HandleAddRewardServer_bm_rock(args)
  local add = args.add
  local from = args.from
  local totalNum = 0
  for k, v in pairs(add) do
    totalNum = totalNum + v.num
  end
  SdkReporter.TrackGetDiamond({reason = from, amount = totalNum})
end

local function CheckBookData(key, value)
  if not key or not value then
    return
  end
  for index, reward in pairs(value) do
    if reward.id then
      PlayerData:CheckBookRead(key, reward.id)
    end
  end
end

function PlayerData:AddRewardSever(args)
  local row = args.reward
  local protocolName = args.protocolName
  for k, v in pairs(row) do
    if k == "item" then
      RefreshRewardSever(PlayerData:GetItems(), v, protocolName)
    end
    if k == "limited_item" then
      RefreshRewardLimitedItemServer(PlayerData:GetLimitedItems(), v)
    end
    if k == "material" then
      RefreshRewardSever(PlayerData:GetMaterials(), v)
      PlayerData:GetAllRoleAwakeRed()
    end
    if k == "equipment" then
      local equipArgs = {}
      equipArgs.list = PlayerData:GetEquips()
      equipArgs.add = v
      equipArgs.protocolName = protocolName
      RefreshRewardEquiptSever(equipArgs)
      CheckBookData(k, v)
    end
    if k == "role" then
      RefreshRewardSever(PlayerData:GetRoles(), v)
      RefreshRewardRoleHead(v)
      RefreshRewardRoleHomeSkillUpdate(v)
      PlayerData:GetAllRoleAwakeRed()
    end
    if k == "hero_skin" then
      RefreshRewardRoleSkinSever(v)
    end
    if k == "furniture" then
      RefreshRewardFurnitureSever(v)
    end
    if k == "battery" then
      RefreshRewardBatterySever(PlayerData:GetBattery(), v)
      CheckBookData(k, v)
    end
    if k == "creature" then
      RefreshRewardCreatureSever(PlayerData:GetHomeCreature(), v)
    end
    if k == "pet" then
      RefreshRewardPetSever(PlayerData:GetHomePet(), v)
    end
    if k == "coach" then
      RefreshRewardCoachServer(PlayerData:GetHomeCoachBag(), v)
    end
    if k == "goods" then
      RefreshRewardGoodsServer(PlayerData:GetGoods(), v)
    end
    if k == "monthly_card" then
      PlayerData.ServerData.monthly_card = v
    end
    if k == "fuel" then
      RefreshRewardFuelNum(PlayerData:GetHomeInfo().readiness.fuel, v)
    end
    if k == "food_material" then
      RefreshRewardSever(PlayerData:GetFridgeItems(), v)
    end
    if k == "leaflet" then
      for _, data in pairs(v) do
        PlayerData.SolicitData.leafletNum = PlayerData.SolicitData.leafletNum + data.num
      end
    end
    if k == "avatar" then
      for avatarId, num in pairs(v) do
        table.insert(PlayerData:GetUserInfo().avatar_list, tostring(avatarId))
      end
    end
    if k == "bm_rock" then
      HandleAddRewardServer_bm_rock({add = v, from = protocolName})
    end
    if k == "guka" then
      WitchData.RefreshGuKaData(v)
    end
    if k == "ws_coin" then
      WitchData.RefreshCoinData(v)
    end
  end
  PlayerData.CaptainSkinSystem:UpdateDressReward(row)
end

function PlayerData:CheckBookRead(type, id)
  if not type or not id then
    return
  end
  if type == "equipment" then
    if PlayerData.ServerData.books and PlayerData.ServerData.books.equip and not PlayerData.ServerData.books.equip[tostring(id)] then
      PlayerData.ServerData.books.equip[tostring(id)] = {read = 0}
    end
  elseif type == "battery" and PlayerData.ServerData.books and PlayerData.ServerData.books.weapon and not PlayerData.ServerData.books.weapon[tostring(id)] then
    PlayerData.ServerData.books.weapon[tostring(id)] = {read = 0}
  end
end

local function RemoveItemServer(list, reduce)
  for k, v in pairs(reduce) do
    if PlayerData:GetGoodsById(k).num then
      PlayerData:GetGoodsById(k).num = PlayerData:GetGoodsById(k).num - v.num
    end
  end
end

local function RemoveMaterialServer(list, reduce)
  for k, v in pairs(reduce) do
    if list[k].num then
      list[k].num = list[k].num - v.num
    end
  end
end

local function RemoveGoodsServer(list, reduce)
  for k, v in pairs(reduce) do
    list[k].avg_price = v.avg_price == nil and list[k].avg_price or v.avg_price
    list[k].num = list[k].num - v.num
  end
end

local function RemoveFuelNumServer(list, reduce)
  for k, v in pairs(reduce) do
    list.fuel_num = list.fuel_num - v.num
  end
end

function PlayerData:RemoveRewardServer(row)
  for k, v in pairs(row) do
    if k == "item" then
      RemoveItemServer(PlayerData:GetItems(), v)
    end
    if k == "goods" then
      RemoveGoodsServer(PlayerData:GetGoods(), v)
    end
    if k == "fuel" then
      RemoveFuelNumServer(PlayerData:GetHomeInfo().readiness.fuel, v)
    end
  end
end

function PlayerData:RemoveDepotServer(row)
  local config = {
    [114] = "item",
    [829] = "goods",
    [117] = "material"
  }
  for k, v in pairs(row) do
    local index = tonumber(string.sub(k, 1, 3))
    local type = config[index]
    if type == "item" then
      RemoveItemServer(PlayerData:GetItems(), v)
    end
    if type == "goods" then
      RemoveGoodsServer(PlayerData:GetGoods(), v)
    end
    if type == "material" then
      RemoveMaterialServer(PlayerData:GetMaterials(), v)
    end
  end
end

function PlayerData:SubQuestReward(totalReward, questReward)
  local subAllRecord = {}
  for k, v in pairs(questReward) do
    for k1, v1 in pairs(v) do
      if k == "furniture" or k == "battery" or k == "coach" or k == "pet" or k == "equipment" or k == "limited_item" then
        if not totalReward[k] then
          goto lbl_165
        end
        local recordClear = {}
        local numRecord = 0
        for uid, detailInfo in pairs(totalReward[k]) do
          if tonumber(detailInfo.id) == tonumber(k1) then
            table.insert(recordClear, uid)
            numRecord = numRecord + 1
            if numRecord == v1.num then
              break
            end
          end
        end
        for k2, v2 in pairs(recordClear) do
          totalReward[k][v2] = nil
        end
        if table.count(totalReward[k]) == 0 then
          totalReward[k] = nil
        end
      elseif totalReward[k] and totalReward[k][k1] then
        local totalNum = totalReward[k][k1].num or 0
        totalReward[k][k1].num = totalNum - (v1.num or 0)
        if 0 >= totalReward[k][k1].num then
          totalReward[k][k1] = nil
        end
        if next(totalReward[k]) == nil then
          table.insert(subAllRecord, k)
        end
      else
        local recordClear = {}
        for totalRewardKey, totalRewardValue in pairs(totalReward) do
          local numRecord = 0
          for uid, detailValue in pairs(totalRewardValue) do
            if detailValue.id == nil then
              break
            end
            if tonumber(detailValue.id) == tonumber(k1) then
              if recordClear[totalRewardKey] == nil then
                recordClear[totalRewardKey] = {}
              end
              table.insert(recordClear[totalRewardKey], uid)
              numRecord = numRecord + 1
              if numRecord == v1.num then
                break
              end
            end
          end
        end
        for rewardKey, uids in pairs(recordClear) do
          for i, uid in pairs(uids) do
            totalReward[rewardKey][uid] = nil
          end
          if table.count(totalReward[rewardKey]) == 0 then
            totalReward[rewardKey] = nil
          end
        end
      end
      ::lbl_165::
    end
  end
  for k, v in pairs(subAllRecord) do
    totalReward[v] = nil
  end
  if table.count(totalReward) == 0 then
    totalReward = nil
  end
end

function PlayerData:GetPid()
  return PlayerData.pid or -1
end

function PlayerData.IsLevelFinished(levelId)
  local info = PlayerData.ServerData.chapter_level[tostring(levelId)]
  return info ~= nil and info.received == 1
end

function PlayerData.IsCubeLevelFinished(levelId)
  if PlayerData.TempCache and PlayerData.TempCache.CubeRogueData and PlayerData.TempCache.CubeRogueData.levels then
    return PlayerData.TempCache.CubeRogueData.levels[tostring(levelId)] ~= nil
  end
  return false
end

function PlayerData.CubeLevelFinish(levelId)
  if PlayerData.TempCache then
    PlayerData.TempCache.CubeRogueData = PlayerData.TempCache.CubeRogueData or {}
    PlayerData.TempCache.CubeRogueData.levels = PlayerData.TempCache.CubeRogueData.levels or {}
    PlayerData.TempCache.CubeRogueData.levels[tostring(levelId)] = 1
  end
end

function PlayerData:GetPlayerLevel()
  return PlayerData.ServerData.user_info.lv
end

function PlayerData:GetDailyVitality()
  local num = 0
  if PlayerData.ServerData.items["11400013"] then
    return PlayerData.ServerData.items["11400013"].num
  end
  return num
end

function PlayerData:GetWeeklyVitality()
  local num = 0
  if PlayerData.ServerData.items["11400021"] then
    return PlayerData.ServerData.items["11400021"].num
  end
  return num
end

function PlayerData:GetSeverTime()
  return PlayerData.ServerData.server_now
end

function PlayerData.DelegateGetPlayerInfo(callback)
  callback(tostring(PlayerData:GetUserInfo().uid))
end

function PlayerData:GetRoleLvMax(roleId)
  local breakLv = 0
  if 0 < tonumber(roleId) then
    breakLv = PlayerData:GetRoleById(roleId).break_lv or 0
  end
  return math.min(PlayerData:GetUserInfo().lv + PlayerData:GetFactoryData(99900001).CharacterOverUserLevelMax, PlayerData:GetFactoryData(99900001).roleLevelMax + breakLv)
end

function PlayerData:RoleLvIsMax(id, level)
  local RoleCA = PlayerData:GetFactoryData(id)
  local resonance_lv = PlayerData:GetRoleById(id).resonance_lv or 0
  local roleid = RoleCA.awakeList[resonance_lv + 1] and RoleCA.awakeList[resonance_lv + 1].awakeId or RoleCA.awakeList[table.count(RoleCA.awakeList)].awakeId
  local levelMax = PlayerData:GetRoleLvMax(id)
  if level >= levelMax then
    return true
  end
  return false
end

function PlayerData:ChangeEquipmentType(type)
  local conf = {
    OneHandMeleeWeapon = "\229\141\149\230\137\139\232\191\145\230\136\152\229\133\181\232\163\133",
    TwoHandMeleeWeapon = "\229\143\140\230\137\139\232\191\145\230\136\152\229\133\181\232\163\133",
    LightShootWeapon = "\232\189\187\229\158\139\229\176\132\229\135\187\230\173\166\229\153\168",
    HeavyShootWeapon = "\233\135\141\229\158\139\229\176\132\229\135\187\230\173\166\229\153\168",
    AssaultMagicEquip = "\230\148\187\229\135\187\229\158\139\231\129\181\232\131\189\232\163\133\229\164\135",
    SupportMagicEquip = "\232\190\133\229\138\169\229\158\139\231\129\181\232\131\189\232\163\133\229\164\135",
    LightArmor = "\232\189\187\229\158\139\230\138\164\231\148\178",
    HeavyArmor = "\233\135\141\229\158\139\230\138\164\231\148\178",
    PortableSupportEquip = "\228\190\191\230\144\186\229\188\143\232\190\133\229\138\169\232\163\133\229\164\135",
    Ornaments = "\232\163\133\233\165\176\229\147\129"
  }
  local cn = conf[type] or ""
  return cn
end

function PlayerData:IsCheckYearOld(years)
  years = CS.IDCardInfoDecryptTool.DefineDecryptIdCard(years)
  local card_num = tostring(years)
  local dt = os.date("*t", PlayerData.ServerData.server_now)
  local year = tonumber(string.sub(card_num, 7, 10))
  local month = tonumber(string.sub(card_num, 11, 12))
  local day = tonumber(string.sub(card_num, 13, 14))
  if month < dt.month or month == dt.month and day <= dt.day then
    return dt.year - year
  else
    return dt.year - year - 1
  end
end

function PlayerData:SetPlayerPrefs(type, key, params, isPid)
  local pid = ""
  if PlayerData.pid ~= nil then
    pid = PlayerData.pid
  end
  if type == "int" then
    if isPid ~= nil and isPid == false then
      PlayerPrefs.SetInt(key, params)
    else
      PlayerPrefs.SetInt(pid .. key, params)
    end
  end
  if type == "string" then
    if isPid ~= nil and isPid == false then
      PlayerPrefs.SetString(key, params)
    else
      PlayerPrefs.SetString(pid .. key, params)
    end
  end
  if type == "float" then
    if isPid ~= nil and isPid == false then
      PlayerPrefs.SetFloat(key, params)
    else
      PlayerPrefs.SetFloat(pid .. key, params)
    end
  end
end

function PlayerData:GetPlayerPrefs(type, key, isPid)
  local pid = ""
  if PlayerData.pid ~= nil then
    pid = PlayerData.pid
  end
  if type == "int" then
    if isPid ~= nil and isPid == false then
      return PlayerPrefs.GetInt(key)
    end
    return PlayerPrefs.GetInt(pid .. key)
  end
  if type == "string" then
    if isPid ~= nil and isPid == false then
      return PlayerPrefs.GetString(key)
    end
    return PlayerPrefs.GetString(pid .. key)
  end
  if type == "float" then
    if isPid ~= nil and isPid == false then
      return PlayerPrefs.GetFloat(key)
    end
    return PlayerPrefs.GetFloat(pid .. key)
  end
  return 0
end

function PlayerData:DeletePlayerPrefs(key)
  local pid = PlayerData.pid
  if PlayerPrefs.HasKey(pid .. key) == true then
    PlayerPrefs.DeleteKey(pid .. key)
    return true
  end
  return false
end

function PlayerData:GetSaleItem(id, itemType)
  id = tostring(id)
  local data = {}
  local factoryName = "ItemFactory"
  local serverData
  if itemType == EnumDefine.Depot.Item then
    serverData = PlayerData:GetItems()[id]
  elseif itemType == EnumDefine.Depot.Material then
    factoryName = "SourceMaterialFactory"
    serverData = PlayerData:GetMaterials()[id]
  elseif itemType == EnumDefine.Depot.FridgeItem then
    factoryName = "FridgeItemFactory"
    serverData = PlayerData:GetFridgeItems()[id]
  else
    return data
  end
  id = tonumber(id)
  local factoryData = PlayerData:GetFactoryData(id, factoryName)
  if factoryData.saletypeInt == 1 then
    if serverData and serverData.num > 0 then
      table.insert(data, {
        server = serverData,
        factoryData = factoryData,
        id = id,
        isDue = false
      })
    end
  elseif factoryData.saletypeInt == 2 and serverData and serverData.dead_line ~= "" and serverData.num > 0 then
    local currentTime = TimeUtil:GetServerTimeStamp()
    local deadTime = TimeUtil:TimeStamp(serverData.dead_line)
    if currentTime > deadTime then
      table.insert(data, {
        server = serverData,
        factoryData = factoryData,
        id = id,
        isDue = true
      })
    end
  end
  table.sort(data, function(a, b)
    if a.data.qualityInt ~= b.data.qualityInt then
      return a.data.qualityInt < b.data.qualityInt
    end
    return a.data.sort < b.data.sort
  end)
  return data
end

function PlayerData:VerifyRealName(callback)
  GSDKManager:FetchServiceAntiAddictionStatus(function()
    ReportTrackEvent.Guide_flow(11)
    if callback then
      ReportTrackEvent.Guide_flow(13)
      callback()
    end
  end)
end

function PlayerData:RealName(callback, tip)
  local roleId = PlayerPrefs.GetString("username")
  Net:SendProto("main.verify_user", function(json)
    local need_parent_verified = json.need_parent_verified
    local age_type = json.age_type
    if age_type == -1 then
      if tip then
        tip("80600168", "80600068", "80600067", function()
          PlayerPrefs.SetInt("RealName", 0)
          MGameManager.WebView(GetText(80600168), "https://bsdk.snssdk.com/h5/personal_protection/verify?theme=purple&verify_status=1")
        end, function()
          CBus:Logout()
        end)
      else
        PlayerPrefs.SetInt("RealName", 0)
        MGameManager.WebView(GetText(80600168), "https://bsdk.snssdk.com/h5/personal_protection/verify?theme=purple&verify_status=1")
      end
    elseif age_type ~= 100 and need_parent_verified == 1 then
      if tip then
        tip("80600169", "80600068", "80600067", function()
          PlayerPrefs.SetInt("RealName", 0)
          MGameManager.WebView(GetText(80600169), "https://bsdk.snssdk.com/h5/personal_protection/verify?theme=purple&verify_status=4")
        end, function()
          CBus:Logout()
        end)
      else
        PlayerPrefs.SetInt("RealName", 0)
        MGameManager.WebView(GetText(80600169), "https://bsdk.snssdk.com/h5/personal_protection/verify?theme=purple&verify_status=4")
      end
    elseif age_type ~= -1 and need_parent_verified == 0 then
      if PlayerPrefs.HasKey("RealName") then
        PlayerPrefs.DeleteKey("RealName")
        ReportTrackEvent.Guide_flow(11)
      end
      if callback then
        ReportTrackEvent.Guide_flow(13)
        callback()
      end
    end
  end, PlayerPrefs.GetString(roleId .. "access_token"))
end

function PlayerData:GetUnlockChapter()
  local index = 1
  for i, v in ipairs(PlayerData.ChapterData.SortChapter) do
    index = i
    local lastLevel = v.levelList[v.levelList.count]
    local serverData = PlayerData.ServerData.chapter_level[tostring(lastLevel)]
    if serverData and serverData.score >= 0 then
    else
      break
    end
  end
  index = index > #PlayerData.ChapterData.SortChapter and #PlayerData.ChapterData.SortChapter or index
  return index
end

function PlayerData:GetGameUploadInfo()
  local userInfo = PlayerData:GetUserInfo()
  local info = {
    RoleName = "",
    RoleLevel = "",
    Balance = "",
    Chapter = ""
  }
  if userInfo ~= nil then
    info.RoleName = userInfo.role_name
    info.RoleLevel = tostring(userInfo.lv)
    info.Balance = tostring(userInfo.gold)
    local levelData = PlayerData:GetFactoryData(PlayerData.last_level, "LevelFactory")
    if levelData ~= nil then
      info.Chapter = levelData.levelChapter .. " " .. levelData.levelName
    end
  end
  return info
end

function PlayerData:Logout()
  if UseGSDK then
    local info = PlayerData:GetGameUploadInfo()
    GSDKManager:RoleExitUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
  end
  SafeReleaseScene(false)
  CBus:NewLogout()
  PlayerData:ResetCharacterFilter()
  PlayerData:ResetSuaqsFilter()
  PlayerData:ResetDepotFilter()
  PlayerData:ResetRoleSleep()
  WitchData.ResetData()
  MapNeedleData.ResetData()
  MapNeedleEventData.ResetData()
end

PlayerData.Notice = {}

function PlayerData.GetNotice(callback)
  if UseGSDK then
    local roleId = PlayerPrefs.GetString("username")
    MGameManager.FetchBulletins(6, function(bulletin)
      PlayerData.Notice = bulletin.BulletinItems
      if table.count(PlayerData.Notice) < 1 then
        if callback then
          callback()
        end
      else
        UIManager:Open("UI/Notice/Notice", nil, callback)
      end
    end, roleId, PlayerPrefs.GetString(roleId .. "openid"))
  elseif callback then
    callback()
  end
end

function PlayerData:SearchRoleCampInt(tagId)
  if table.count(PlayerData.EnumSideList) == 0 then
    PlayerData.EnumSideList = PlayerData:GetFactoryData(99900017).enumSideList
  end
  for k, v in pairs(PlayerData.EnumSideList) do
    if v.tagId == tagId then
      return k
    end
  end
  return 1
end

function PlayerData:SearchRoleJobInt(jobId)
  if table.count(PlayerData.JobSideList) == 0 then
    PlayerData.JobSideList = PlayerData:GetFactoryData(99900017).enumJobList
  end
  for k, v in pairs(PlayerData.JobSideList) do
    if v.tagId == jobId then
      return k
    end
  end
  return 1
end

function PlayerData:GetPreciseDecimalFloor(nNum, n)
  if type(nNum) ~= "number" then
    return nNum
  end
  local mult = 10 ^ (n or 0)
  local num = math.floor(nNum * mult + 0.5) / mult
  if n == 0 then
    local a, b = math.modf(num)
    return a
  else
    local a, b = math.modf(num)
    if b == 0 then
      return a
    end
    return num
  end
end

PlayerData.AttributeConfig = {
  {
    type = "tAtk",
    txt = "\230\148\187\229\135\187",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_attack"
  },
  {
    type = "tHp",
    txt = "\232\161\128\233\135\143",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_health"
  },
  {
    type = "tDef",
    txt = "\233\152\178\229\190\161",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_defense"
  },
  {
    type = "tCri",
    txt = "\230\154\180\229\135\187\231\142\135",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_cri"
  },
  {
    type = "tCriDamage",
    txt = "\230\154\180\229\135\187\228\188\164\229\174\179",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_cri_damage"
  },
  {
    type = "tSpeed",
    txt = "\230\148\187\229\135\187\233\128\159\229\186\166",
    sprite = "UI\\Common\\Characterinfo_icon_att_attackSpd"
  },
  {
    type = "tSpeedRange",
    txt = "\230\148\187\229\135\187\232\140\131\229\155\180",
    sprite = "UI\\Common\\Characterinfo_icon_att_attackRange"
  },
  {
    type = "tSpName",
    txt = "\231\137\185\230\174\138\230\138\128\232\131\189\229\144\141\231\167\176",
    sprite = "UI\\Common\\Characterinfo_icon_att_sp"
  }
}
local PercentConfig = {
  ["\230\154\180\229\135\187\231\142\135"] = "%",
  ["\230\154\180\229\135\187\228\188\164\229\174\179"] = "%",
  ["\231\137\169\231\144\134\229\135\143\228\188\164"] = "%",
  ["\232\180\159\232\131\189\229\135\143\228\188\164"] = "%"
}

function PlayerData:GetAttributeShow(name, num, n)
  if PercentConfig[name] then
    return PlayerData:GetPreciseDecimalFloor(num * 100, n) .. PercentConfig[name]
  end
  return PlayerData:GetPreciseDecimalFloor(num, n)
end

function PlayerData:GetSignInfo()
  return self.ServerData.user_info.sign_info
end

function PlayerData:GetLocalSignInfo()
  local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
  local activeList = ActivityMainDataModel:GetActivityCAList()
  local sign_ca
  for k, v in pairs(activeList) do
    local tagCA = PlayerData:GetFactoryData(v.tag)
    local activeCA = PlayerData:GetFactoryData(v.id)
    if tagCA.tagName == "\228\184\131\230\151\165\231\173\190\229\136\176" then
      sign_ca = PlayerData:GetFactoryData(activeCA.signinId)
      if PlayerData:GetSignInfo()[tostring(activeCA.signinId)] and sign_ca.startTime ~= "" and TimeUtil:IsActive(sign_ca.startTime, sign_ca.endTime) then
        return sign_ca
      end
    end
  end
  return nil
end

function PlayerData:GetActivityCABySignId(id)
  local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
  local activeList = ActivityMainDataModel:GetActivityCAList()
  local sign_ca
  for k, v in pairs(activeList) do
    local activeCA = PlayerData:GetFactoryData(v.id)
    if activeCA.signinId == tonumber(id) then
      if tonumber(v.tag) == 12601070 then
        sign_ca = PlayerData:GetFactoryData(activeCA.signinId)
        if PlayerData:GetSignInfo()[tostring(activeCA.signinId)] and sign_ca.startTime ~= "" and TimeUtil:IsActive(sign_ca.startTime, sign_ca.endTime) then
          return activeCA
        end
      elseif tonumber(v.tag) == 12601103 then
        sign_ca = PlayerData:GetFactoryData(activeCA.signinId)
        if PlayerData:GetSignInfo()[tostring(activeCA.signinId)] and activeCA.startTime ~= "" and TimeUtil:IsActive(activeCA.startTime, activeCA.rewardEndTime) then
          return activeCA
        end
      end
    end
  end
  return nil
end

function PlayerData:GetHasSquads(roleid)
  for k, v in pairs(self.ServerData.squad) do
    if table.count(v.role_list) > 0 then
      for c, d in pairs(v.role_list) do
        if tonumber(d) == tonumber(roleid) then
          return 1
        end
      end
    end
  end
  return 0
end

function PlayerData:ResetCharacterFilter()
  PlayerData.CharacterFilter = nil
  PlayerData.CharacterSort = nil
  PlayerData.CharacterSortName = nil
  PlayerData.CharacterSortAn = nil
end

function PlayerData:ResetSuaqsFilter()
  PlayerData.SuaqsFilter = nil
  PlayerData.SuaqsSort = nil
end

function PlayerData:ResetDepotFilter()
  PlayerData.DepotFilter = nil
  PlayerData.DepotSort = nil
  PlayerData.DepotSortState = nil
  PlayerData.DepotStengthFilter = nil
end

function PlayerData:ResetTempCache()
  PlayerData.TempCache = {}
  PlayerData.TempCache.MainUIShowState = 0
  PlayerData.TempCache.NPCTalkData = {}
  PlayerData.TempCache.BeginDecorateTimeStamp = 0
  PlayerData.TempCache.GuideNoUpdateLimitData = {}
  PlayerData.Last_Chapter_Parms = nil
  PlayerData.BattleCallBackPage = ""
  PlayerData.TempCache.FirstLogin = true
  PlayerData.TempCache.stationStoreBuff = {}
  PlayerData.TempCache.ItemPromptBatchNum = 0
  PlayerData.TempCache.AutoQuestEvent = {}
  PlayerData.TempCache.MonsterLevelPassedCache = true
  PlayerData.TempCache.ADPopInfo = {
    lvTrigger = {},
    questTrigger = {}
  }
end

function PlayerData.IsMale()
  local userInfo = PlayerData:GetUserInfo()
  local gender = userInfo and userInfo.gender or PlayerData:GetFactoryData(99900001).defaultGender
  return gender == 1
end

function PlayerData.SwitchGender(callback)
  local hint = "\229\136\135\230\141\162\230\128\167\229\136\171-\229\164\177\232\180\165!"
  local gender = 1
  local data = PlayerData.ServerData
  if data ~= nil and data.user_info ~= nil then
    if data.user_info.gender == 1 then
      gender = 0
    end
  else
    callback(hint)
    return
  end
  Net:SendProto("main.set_gender", function(json)
    if gender == 1 then
      hint = "\230\128\167\229\136\171\229\136\135\230\141\162-\231\148\183"
    else
      hint = "\230\128\167\229\136\171\229\136\135\230\141\162-\229\165\179"
    end
    callback(hint)
  end, gender)
end

function PlayerData:GetTypeInt(typeList, tagID)
  local index = 0
  for i, v in ipairs(PlayerData:GetFactoryData(99900017, "ConfigFactory")[typeList]) do
    if v.equipType == tagID then
      index = i
    end
  end
  return index
end

function PlayerData:GetRoleCardList(unitId)
  local roleCA = self:GetFactoryData(unitId)
  local skillList = roleCA.skillList
  local list = {}
  for k, v in pairs(skillList) do
    local skillCA = PlayerData:GetFactoryData(skillList[k].skillId)
    table.insert(list, {
      id = skillCA.cardID,
      num = v.num
    })
  end
  return list
end

function PlayerData:TransitionNum(Num)
  local num
  local len = string.len(Num)
  if 4 <= len and len <= 6 then
    num = math.modf(Num / 1000)
    return num .. "k"
  end
  if 7 <= len and len <= 9 then
    num = math.modf(Num / 1000000)
    return num .. "m"
  end
  if 10 <= len and len <= 12 then
    num = math.modf(Num / 1000000000)
    return num .. "b"
  end
  return Num
end

function PlayerData:SetQuestTrace(levelInfo)
  local t = PlayerData:GetQuestTrace()
  for k, v in pairs(t) do
    ListenerManager.Broadcast(ListenerManager.Enum.RemoveQuestTrace, v.id)
  end
  t = {}
  for k, v in pairs(levelInfo) do
    table.insert(t, v)
  end
  PlayerData:SetPlayerPrefs("string", "QuestTrace", Json.encode(t))
  ListenerManager.Broadcast(ListenerManager.Enum.SetQuestTrace, t[1].id)
end

function PlayerData:RemoveQuestTrace(levelIds)
  local t = PlayerData:GetQuestTrace()
  if #t == 0 then
    return
  end
  local isRemove = false
  if levelIds ~= nil then
    for k, v in pairs(levelIds) do
      for k1, v1 in pairs(t) do
        if v1.id == v then
          table.remove(t, k1)
          isRemove = true
          ListenerManager.Broadcast(ListenerManager.Enum.RemoveQuestTrace, v)
          break
        end
      end
    end
  else
    for k, v in pairs(t) do
      ListenerManager.Broadcast(ListenerManager.Enum.RemoveQuestTrace, v.id)
    end
    t = {}
    isRemove = true
  end
  if isRemove then
    PlayerData:SetPlayerPrefs("string", "QuestTrace", Json.encode(t))
  end
end

function PlayerData:GetQuestTrace()
  local t = PlayerData:GetPlayerPrefs("string", "QuestTrace")
  if t ~= nil and t ~= "" then
    return Json.decode(t)
  end
  return {}
end

function PlayerData:HomeSkillLevelUp(roleId, isSkin)
  local function addValue(t, ca)
    if t[ca.homeSkillType] == nil then
      t[ca.homeSkillType] = {}
    end
    if t[ca.homeSkillType].forever == nil then
      t[ca.homeSkillType].forever = {}
      t[ca.homeSkillType].forever.param = 0
    end
    local value1, value2 = math.modf(ca.param)
    local absValue2 = math.abs(value2)
    if absValue2 + 1.0E-4 >= 1 then
      if 0 < value2 then
        value1 = value1 + 1
      else
        value1 = value1 - 1
      end
    elseif 0 >= absValue2 - 1.0E-4 then
    else
      value1 = value1 + value2
    end
    t[ca.homeSkillType].forever.param = t[ca.homeSkillType].forever.param + value1
  end
  
  local homeSkillList = {}
  local lv = 0
  if isSkin then
    if not PlayerData.IsSkinHomeSkillOpen() then
      return
    end
    local ca = PlayerData:GetFactoryData(roleId)
    if ca.homeSkill and 0 < ca.homeSkill then
      homeSkillList = {
        {
          id = ca.homeSkill,
          resonanceLv = 0
        }
      }
      lv = 0
    end
  else
    local serverRole = PlayerData:GetRoleById(roleId)
    lv = serverRole.resonance_lv
    local unitCA = PlayerData:GetFactoryData(roleId, "unitFactory")
    homeSkillList = unitCA.homeSkillList
  end
  local skillsServerData = PlayerData.ServerData.home_skills
  for k, v in pairs(homeSkillList) do
    if lv == v.resonanceLv then
      local homeSkillCA = PlayerData:GetFactoryData(v.id, "HomeSkillFactory")
      if homeSkillCA.goodsList ~= nil and 0 < #homeSkillCA.goodsList then
        for k1, v1 in pairs(homeSkillCA.goodsList) do
          local goodsInfo = skillsServerData[tostring(v1.id)]
          if goodsInfo == nil then
            goodsInfo = {}
            skillsServerData[tostring(v1.id)] = goodsInfo
          end
          if homeSkillCA.city ~= nil and 0 < homeSkillCA.city then
            local cityInfo = goodsInfo[tostring(homeSkillCA.city)]
            if cityInfo == nil then
              cityInfo = {}
              goodsInfo[tostring(homeSkillCA.city)] = cityInfo
            end
            addValue(cityInfo, homeSkillCA)
          else
            addValue(goodsInfo, homeSkillCA)
          end
        end
      elseif homeSkillCA.city ~= nil and 0 < homeSkillCA.city then
        local cityInfo = skillsServerData[tostring(homeSkillCA.city)]
        if cityInfo == nil then
          cityInfo = {}
          skillsServerData[tostring(homeSkillCA.city)] = cityInfo
        end
        addValue(cityInfo, homeSkillCA)
      elseif homeSkillCA.tagId and 0 < homeSkillCA.tagId then
        local tagInfo = skillsServerData[tostring(homeSkillCA.tagId)]
        if tagInfo == nil then
          tagInfo = {}
          skillsServerData[tostring(homeSkillCA.tagId)] = tagInfo
        end
        addValue(tagInfo, homeSkillCA)
      else
        addValue(skillsServerData, homeSkillCA)
        if homeSkillCA.homeSkillType == EnumDefine.HomeSkillEnum.OneForAll then
          local drinkBuff = PlayerData:GetCurDrinkBuff()
          if drinkBuff ~= nil then
            local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
            local strBuffId = tostring(drinkBuff.id)
            drinkBuff.param = buffCA.intensifyParam
            if skillsServerData[buffCA.buffType] ~= nil and skillsServerData[buffCA.buffType].temp ~= nil and skillsServerData[buffCA.buffType].temp[strBuffId] then
              skillsServerData[buffCA.buffType].temp[strBuffId].param = buffCA.intensifyParam
            end
          end
        end
      end
    end
  end
end

function PlayerData:RefreshActivityBuffByServerQuest(server_quests, force)
  if server_quests == nil or table.count(server_quests) == 0 then
    PlayerData.ServerData.act_buff = {}
    PlayerData.ServerData.server_quests = {}
    return
  end
  local oldQuests = PlayerData.ServerData.server_quests or {}
  if force then
    oldQuests = {}
    PlayerData.ServerData.act_buff = {}
  end
  PlayerData.ServerData.server_quests = server_quests or {}
  local cloneQuest = Clone(PlayerData.ServerData.server_quests)
  if PlayerData.ServerData.act_buff == nil then
    PlayerData.ServerData.act_buff = {}
  end
  local skillsServerData = PlayerData.ServerData.act_buff
  for k, v in pairs(oldQuests) do
    local newQuestInfo = cloneQuest[k]
    if newQuestInfo ~= nil then
      if 0 < v.recv then
        cloneQuest[k] = nil
      elseif 0 >= newQuestInfo.recv then
        cloneQuest[k] = nil
      end
    end
  end
  if table.count(cloneQuest) == 0 then
    return
  end
  
  local function addValue(t, ca, questCA)
    if t[ca.buffType] == nil then
      t[ca.buffType] = {}
    end
    if t[ca.buffType].temp == nil then
      t[ca.buffType].temp = {}
    end
    local value1, value2 = math.modf(ca.param)
    local absValue2 = math.abs(value2)
    if absValue2 + 1.0E-4 >= 1 then
      if 0 < value2 then
        value1 = value1 + 1
      else
        value1 = value1 - 1
      end
    elseif absValue2 - 1.0E-4 <= 0 then
    else
      value1 = value1 + value2
    end
    local endTime = -1
    if questCA.correspondActivity and 0 < questCA.correspondActivity then
      local activityCA = PlayerData:GetFactoryData(questCA.correspondActivity)
      if activityCA.isTriggerTime and PlayerData:GetActivityAct(questCA.correspondActivity) then
        endTime = PlayerData:GetActivityData(questCA.correspondActivity).st + activityCA.buffContinueTime * 86400
      end
    end
    if endTime == -1 and ca.endTime ~= nil and ca.endTime ~= "" then
      endTime = TimeUtil:TimeStamp(ca.endTime)
    end
    if t[ca.buffType].temp[tostring(ca.id)] == nil then
      t[ca.buffType].temp[tostring(ca.id)] = {param = value1, deadline = endTime}
    else
      t[ca.buffType].temp[tostring(ca.id)].param = t[ca.buffType].temp[tostring(ca.id)].param
    end
  end
  
  for k, v in pairs(cloneQuest) do
    if v.recv > 0 then
      local questCA = PlayerData:GetFactoryData(k)
      if questCA.buffActivate and 0 < questCA.buffActivate then
        local homeSkillCA = PlayerData:GetFactoryData(questCA.buffActivate, "HomeSkillFactory")
        if homeSkillCA.goodsList ~= nil and 0 < #homeSkillCA.goodsList then
          for k1, v1 in pairs(homeSkillCA.goodsList) do
            local goodsInfo = skillsServerData[tostring(v1.id)]
            if goodsInfo == nil then
              goodsInfo = {}
              skillsServerData[tostring(v1.id)] = goodsInfo
            end
            if homeSkillCA.city ~= nil and 0 < homeSkillCA.city then
              local cityInfo = goodsInfo[tostring(homeSkillCA.city)]
              if cityInfo == nil then
                cityInfo = {}
                goodsInfo[tostring(homeSkillCA.city)] = cityInfo
              end
              addValue(cityInfo, homeSkillCA, questCA)
            else
              addValue(goodsInfo, homeSkillCA, questCA)
            end
          end
        elseif homeSkillCA.city ~= nil and 0 < homeSkillCA.city then
          local cityInfo = skillsServerData[tostring(homeSkillCA.city)]
          if cityInfo == nil then
            cityInfo = {}
            skillsServerData[tostring(homeSkillCA.city)] = cityInfo
          end
          addValue(cityInfo, homeSkillCA, questCA)
        else
          addValue(skillsServerData, homeSkillCA, questCA)
        end
      end
    end
  end
end

function PlayerData:GetHomeSkillIncrease(enum, confirmStationId, confirmGoodsId)
  local skillsServerData = PlayerData.ServerData.home_skills
  if enum == EnumDefine.HomeSkillEnum.AddQty or enum == EnumDefine.HomeSkillEnum.AddTypeQty then
    local goodsTable = {}
    for k, v in pairs(skillsServerData) do
      if k == enum then
        local curValue = 0
        if v.forever ~= nil then
          curValue = v.forever.param or 0
        end
        goodsTable.all = (goodsTable.all or 0) + curValue
      else
        local id = tonumber(k)
        if id ~= nil then
          local factoryName = DataManager:GetFactoryNameById(id)
          if factoryName == "HomeGoodsFactory" or factoryName == "TagFactory" then
            for k1, v1 in pairs(v) do
              if k1 == enum then
                if goodsTable[id] == nil then
                  goodsTable[id] = 0
                end
                goodsTable[id] = goodsTable[id] + v1.forever.param
              elseif tonumber(k1) == confirmStationId then
                local val = v1[enum]
                if val ~= nil then
                  if goodsTable[id] == nil then
                    goodsTable[id] = 0
                  end
                  goodsTable[id] = goodsTable[id] + (val.forever.param or 0)
                end
              end
            end
          elseif factoryName == "HomeStationFactory" and id == confirmStationId then
            local val = v[enum]
            if val ~= nil then
              goodsTable.all = (goodsTable.all or 0) + (val.forever.param or 0)
            end
          end
        end
      end
    end
    if confirmGoodsId ~= nil then
      local value1 = goodsTable.all or 0
      local value2 = goodsTable[confirmGoodsId] or 0
      return value1 + value2
    else
      return goodsTable
    end
  elseif enum == EnumDefine.HomeSkillEnum.AddSpecQty or enum == EnumDefine.HomeSkillEnum.AddRecycleReward then
    local allValue = 0
    local t = skillsServerData[enum]
    if t and t.forever then
      allValue = allValue + t.forever.param or 0
    end
    if confirmStationId then
      t = skillsServerData[tostring(confirmStationId)]
      if t and t[enum] and t[enum].forever then
        allValue = allValue + (t[enum].forever.param or 0)
      end
    end
    return allValue
  elseif enum == EnumDefine.HomeSkillEnum.TaxCuts then
    local cityTable = {}
    for k, v in pairs(skillsServerData) do
      if k == enum then
        local curValue = 0
        if v.forever ~= nil then
          curValue = v.forever.param or 0
        end
        cityTable.all = curValue
      else
        local id = tonumber(k)
        if id ~= nil then
          local factoryName = DataManager:GetFactoryNameById(id)
          if factoryName == "HomeStationFactory" then
            local val = v[enum]
            if val ~= nil then
              cityTable[id] = val.forever.param
            end
          end
        end
      end
    end
    if confirmStationId ~= nil then
      local value1 = cityTable.all or 0
      local value2 = cityTable[confirmStationId] or 0
      return value1 + value2
    else
      return cityTable
    end
  else
    local val = skillsServerData[enum]
    if val ~= nil and val.forever ~= nil then
      return val.forever.param or 0
    end
  end
  return 0
end

function PlayerData:GetActivityBuff(enum, confirmStationId, confirmGoodsId, returnTable)
  local skillsServerData = PlayerData.ServerData.act_buff
  if skillsServerData == nil then
    return 0
  end
  local curTime = TimeUtil:GetServerTimeStamp()
  
  local function getTempValue(temp)
    if temp == nil then
      return 0
    end
    local param = 0
    for k, v in pairs(temp) do
      if v.deadline == -1 or curTime < v.deadline then
        param = v.param + param
        if returnTable and v.deadline ~= -1 and (returnTable[1] == nil or v.deadline < returnTable[1]) then
          returnTable[1] = v.deadline
        end
      end
    end
    return param
  end
  
  if enum == EnumDefine.HomeSkillEnum.AddQty then
    local goodsTable = {}
    for k, v in pairs(skillsServerData) do
      if k == enum then
        goodsTable.all = (goodsTable.all or 0) + getTempValue(v.temp)
      else
        local id = tonumber(k)
        if id ~= nil then
          local factoryName = DataManager:GetFactoryNameById(id)
          if factoryName == "HomeGoodsFactory" then
            for k1, v1 in pairs(v) do
              if k1 == enum then
                if goodsTable[id] == nil then
                  goodsTable[id] = 0
                end
                goodsTable[id] = goodsTable[id] + getTempValue(v1.temp)
              elseif tonumber(k1) == confirmStationId then
                local val = v1[enum]
                if val ~= nil then
                  if goodsTable[id] == nil then
                    goodsTable[id] = 0
                  end
                  goodsTable[id] = goodsTable[id] + getTempValue(val.temp)
                end
              end
            end
          elseif factoryName == "HomeStationFactory" and id == confirmStationId then
            local val = v[enum]
            if val ~= nil then
              goodsTable.all = (goodsTable.all or 0) + getTempValue(val.temp)
            end
          end
        end
      end
    end
    if confirmGoodsId ~= nil then
      local value1 = goodsTable.all or 0
      local value2 = goodsTable[confirmGoodsId] or 0
      return value1 + value2
    else
      return goodsTable
    end
  elseif enum == EnumDefine.HomeSkillEnum.AddSpecQty then
    local allValue = 0
    local t = skillsServerData[enum]
    if t then
      allValue = allValue + getTempValue(t.temp)
    end
    if confirmStationId then
      t = skillsServerData[tostring(confirmStationId)]
      if t and t[enum] then
        allValue = allValue + getTempValue(t[enum].temp)
      end
    end
    return allValue
  elseif enum == EnumDefine.HomeSkillEnum.TaxCuts then
    local cityTable = {}
    for k, v in pairs(skillsServerData) do
      if k == enum then
        cityTable.all = getTempValue(v.temp)
      else
        local id = tonumber(k)
        if id ~= nil then
          local val = v[enum]
          if val ~= nil then
            cityTable[id] = getTempValue(val.temp)
          end
        end
      end
    end
    if confirmStationId ~= nil then
      local value1 = cityTable.all or 0
      local value2 = cityTable[confirmStationId] or 0
      return value1 + value2
    else
      return cityTable
    end
  else
    local val = skillsServerData[enum]
    if val ~= nil then
      return getTempValue(val.temp)
    end
  end
  return 0
end

function PlayerData:GetDrinkBuffIncrease(enum)
  local drinkBuff = self:GetCurDrinkBuff()
  if drinkBuff ~= nil then
    local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
    if buffCA.buffType == enum then
      return drinkBuff.param
    end
  end
  return 0
end

function PlayerData:GetCurDrinkBuff()
  if PlayerData.TempCache.drinkBuff ~= nil then
    if TimeUtil:GetServerTimeStamp() >= PlayerData.TempCache.drinkBuff.endTime then
      PlayerData.TempCache.drinkBuff = nil
    end
  else
    local serverData = PlayerData.ServerData.home_skills
    local isFind = false
    for k, v in pairs(serverData) do
      if v.temp ~= nil then
        local curTime = TimeUtil:GetServerTimeStamp()
        for k1, v1 in pairs(v.temp) do
          if v1 and v1.obtain == "drink" then
            if curTime >= v1.deadline then
              serverData[k].temp[k1] = nil
              break
            end
            isFind = true
            do
              local drinkBuff = {}
              drinkBuff.id = k1
              drinkBuff.endTime = v1.deadline
              drinkBuff.param = v1.param
              PlayerData.TempCache.drinkBuff = drinkBuff
            end
            break
          end
        end
        if isFind then
          break
        end
      end
    end
  end
  return PlayerData.TempCache.drinkBuff
end

function PlayerData:SetDrinkBuff(serverDrinkInfo)
  if serverDrinkInfo == nil then
    PlayerData.TempCache.drinkBuff = nil
    return
  end
  PlayerData.TempCache.drinkBuff = {}
  PlayerData.TempCache.drinkBuff.id = serverDrinkInfo.id
  PlayerData.TempCache.drinkBuff.endTime = serverDrinkInfo.deadline
  PlayerData.TempCache.drinkBuff.param = serverDrinkInfo.param
end

function PlayerData:GetCurStationStoreBuff(enum, enum2)
  local stationStoreBuff = PlayerData.TempCache.stationStoreBuff
  local curTime = TimeUtil:GetServerTimeStamp()
  local serverData = PlayerData.ServerData.home_skills
  if serverData[enum] == nil then
    return nil
  end
  if enum2 then
    if stationStoreBuff[enum] and stationStoreBuff[enum][enum2] then
      if curTime >= stationStoreBuff[enum][enum2].endTime then
        stationStoreBuff[enum][enum2].temp = nil
      end
    else
      local info = serverData[enum]
      if info and info[enum2] and info[enum2].temp then
        info = info[enum2]
        for k, v in pairs(info.temp) do
          if v.obtain == "food" then
            if curTime >= v.deadline then
              serverData[enum][enum2].temp = nil
            else
              local storeBuff = {}
              storeBuff.id = k
              storeBuff.endTime = v.deadline
              storeBuff.param = v.param
              if stationStoreBuff[enum] == nil then
                stationStoreBuff[enum] = {}
              end
              stationStoreBuff[enum][enum2] = storeBuff
            end
          end
        end
      end
    end
    if stationStoreBuff[enum] then
      return stationStoreBuff[enum][enum2]
    else
      return nil
    end
  else
    if stationStoreBuff[enum] then
      if curTime >= stationStoreBuff[enum].endTime then
        stationStoreBuff[enum] = nil
      end
    else
      local info = serverData[enum]
      if info and info.temp then
        for k, v in pairs(info.temp) do
          if v.obtain == "food" or v.obtain == "battle" then
            if curTime >= v.deadline then
              serverData[enum].temp[k] = nil
              break
            end
            do
              local storeBuff = {}
              storeBuff.id = k
              storeBuff.endTime = v.deadline
              storeBuff.param = v.param
              stationStoreBuff[enum] = storeBuff
            end
            break
          end
        end
      end
    end
    return stationStoreBuff[enum]
  end
end

function PlayerData:SetStationStoreBuff(serverDrinkInfo, buffKey)
  local stationStoreBuff = PlayerData.TempCache.stationStoreBuff
  if serverDrinkInfo == nil then
    stationStoreBuff[buffKey] = nil
    PlayerData:SetCurTrainBuffType(nil)
    return
  end
  if tonumber(buffKey) then
    for k, v in pairs(serverDrinkInfo) do
      for k1, v1 in pairs(v.temp) do
        if v1.obtain == "food" then
          local buffInfo = {}
          buffInfo.id = k1
          buffInfo.endTime = v1.deadline
          buffInfo.param = v1.param
          if stationStoreBuff[buffKey] == nil then
            stationStoreBuff[buffKey] = {}
          end
          stationStoreBuff[buffKey][k] = buffInfo
        end
      end
    end
  else
    for k, v in pairs(serverDrinkInfo.temp) do
      if v.obtain == "food" or v.obtain == "battle" then
        local buffInfo = {}
        buffInfo.id = k
        buffInfo.endTime = v.deadline
        buffInfo.param = v.param
        stationStoreBuff[buffKey] = buffInfo
      end
    end
  end
end

function PlayerData:SetCurTrainBuffType(buffType)
  PlayerData._curStationTrainBuffType = buffType
end

local TrainBuffTypeList = {
  EnumDefine.HomeSkillEnum.AddSpeedPercentage,
  EnumDefine.HomeSkillEnum.AccelerationBrakingPerformance
}

function PlayerData:GetCurTrainBuffType()
  if PlayerData._curStationTrainBuffType then
    return PlayerData._curStationTrainBuffType
  end
  for i = 1, #TrainBuffTypeList do
    if PlayerData:GetCurStationStoreBuff(TrainBuffTypeList[i]) ~= nil then
      PlayerData._curStationTrainBuffType = TrainBuffTypeList[i]
      return TrainBuffTypeList[i]
    end
  end
end

function PlayerData:GetRoleEquipProperty(equipCA, lv)
  local list = {}
  list.healthPoint_SN = UIConfig.AttributeType.CurrentHp
  list.attack_SN = UIConfig.AttributeType.Atk
  list.defence_SN = UIConfig.AttributeType.Def
  list.healthPoint_SN.name = GetText(80607459)
  list.attack_SN.name = GetText(80607458)
  list.defence_SN.name = GetText(80607460)
  local GrowthCA
  if equipCA then
    list.healthPoint_SN.num = PlayerData:GetPreciseDecimalFloor(equipCA.healthPoint_SN, 0)
    list.attack_SN.num = PlayerData:GetPreciseDecimalFloor(equipCA.attack_SN, 0)
    list.defence_SN.num = PlayerData:GetPreciseDecimalFloor(equipCA.defence_SN, 0)
    GrowthCA = PlayerData:GetFactoryData(equipCA.growthId)
  else
    list.healthPoint_SN.num = 0
    list.attack_SN.num = 0
    list.defence_SN.num = 0
  end
  if GrowthCA then
    list.healthPoint_SN.num = PlayerData:GetPreciseDecimalFloor(list.healthPoint_SN.num + GrowthCA.gHp_SN * (lv - 1), 0)
    list.attack_SN.num = PlayerData:GetPreciseDecimalFloor(list.attack_SN.num + GrowthCA.gAtk_SN * (lv - 1), 0)
    list.defence_SN.num = PlayerData:GetPreciseDecimalFloor(list.defence_SN.num + GrowthCA.gDef_SN * (lv - 1), 0)
  end
  return list
end

function PlayerData:IsHaveQuest(questId, checkType)
  local quests = PlayerData.ServerData.quests
  if checkType and type(checkType) == "table" then
    for k, v in pairs(checkType) do
      local server = quests[v] and quests[v][tostring(questId)] or nil
      if server and server.recv == 0 and server.unlock == 1 then
        return true
      end
    end
  else
    for k, v in pairs(quests) do
      local info = v[tostring(questId)]
      if info ~= nil then
        if info.recv == 0 and info.unlock == 1 then
          return true
        end
        break
      end
    end
  end
  return false
end

function PlayerData.IsQuestComplete(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  local serverKey = ""
  if questCA.questType == "Main" then
    serverKey = "mq_quests"
  elseif questCA.questType == "Side" then
    serverKey = "branch_quests"
  end
  if serverKey ~= "" then
    local serverData = PlayerData.ServerData.quests[serverKey]
    if serverData ~= nil and serverData[tostring(questId)] and serverData[tostring(questId)].recv > 0 then
      return true
    end
  end
  return false
end

function PlayerData.GetQuestState(questId, isCheckPreQuest)
  if isCheckPreQuest == nil then
    isCheckPreQuest = true
  end
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  local keyTable = {}
  if isCheckPreQuest and questCA.preQuest then
    for i, v in pairs(questCA.preQuest) do
      local preState = PlayerData.GetQuestState(v.id, false)
      if preState ~= EnumDefine.EQuestState.Receive then
        return EnumDefine.EQuestState.Lock, 0
      end
    end
  end
  if isCheckPreQuest and questCA.preQuestId and 0 < questCA.preQuestId then
    local preState = PlayerData.GetQuestState(questCA.preQuestId, false)
    if preState ~= EnumDefine.EQuestState.Receive then
      return EnumDefine.EQuestState.Lock, 0
    end
  end
  if questCA.preLevel then
    for i, v in pairs(questCA.preLevel) do
      if not PlayerData:GetLevelPass(v.id) then
        return EnumDefine.EQuestState.Lock, 0
      end
    end
  end
  if questCA.questType == "Activity" then
    table.insert(keyTable, "activity_quests")
    table.insert(keyTable, "server_quests")
  elseif questCA.questType == "ActivityAchieve" then
    table.insert(keyTable, "activity_achieve")
  elseif questCA.questType == "Main" then
    table.insert(keyTable, "mq_quests")
  elseif questCA.questType == "Side" then
    table.insert(keyTable, "branch_quests")
  elseif questCA.questType == "ActivityDay" then
    table.insert(keyTable, "activity_day_quests")
  end
  for i, key in pairs(keyTable) do
    if key == "server_quests" then
      local serverData = PlayerData.ServerData[key]
      if serverData and serverData[tostring(questId)] then
        if 0 < serverData[tostring(questId)].recv then
          local activityData = PlayerData:GetActivityData(questCA.correspondActivity)
          if activityData and activityData.ser_qid[tostring(questId)] and activityData.ser_qid[tostring(questId)] == 1 then
            return EnumDefine.EQuestState.Receive
          end
          return EnumDefine.EQuestState.Finish
        else
          return EnumDefine.EQuestState.UnFinish
        end
      end
    else
      local serverData = PlayerData.ServerData.quests[key]
      if serverData and serverData[tostring(questId)] then
        if serverData[tostring(questId)].unlock == 0 and serverData[tostring(questId)].recv == 0 then
          return EnumDefine.EQuestState.Lock, 0
        end
        if 0 < serverData[tostring(questId)].recv then
          return EnumDefine.EQuestState.Receive, serverData[tostring(questId)].pcnt
        end
        if serverData[tostring(questId)].pcnt >= questCA.num then
          return EnumDefine.EQuestState.Finish, questCA.num
        else
          return EnumDefine.EQuestState.UnFinish, serverData[tostring(questId)].pcnt
        end
      end
    end
  end
  return EnumDefine.EQuestState.Lock, 0
end

function PlayerData.RefreshServerQuests(serverData)
  if serverData then
    for k, v in pairs(serverData) do
      PlayerData.ServerData.server_quests[k] = v
    end
  end
end

function PlayerData:ClearLua(preName)
  TrainEffectHelper:Dispose()
  TrainManager:TravelOver()
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  TradeDataModel.InitModel()
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  MainDataModel.InitModel()
  QuestTrace.ClearQuestTraceInfo()
  QuestProcess.Clear()
  local DialogBoxDataModel = require("UIDialogBox_Tip/UIDialogBox_TipDataModel")
  DialogBoxDataModel.InitModel()
  ListenerManager.ClearAllListener()
  Net.ResetGuideNo()
  Net.ResetFirstGuideData()
end

function PlayerData:GetBattlePassRedState(kind)
  local passKind = kind
  if passKind == nil or passKind == false then
    local _, _, passInfo = PlayerData:GetNowPassData()
    passKind = passInfo and passInfo.kind or 1
  end
  passKind = GetDefaultPassKind(passKind)
  PlayerData.MultiMission = PlayerData.MultiMission or {}
  PlayerData.MultiMission[passKind] = PlayerData.MultiMission[passKind] or {}
  local row = PlayerData.MultiMission[passKind]
  PlayerData.MultiMissionRefreshAll = true
  if PlayerData.MultiMissionRefreshAll == true then
    PlayerData.MultiMissionRefreshState = PlayerData.MultiMissionRefreshState or {}
    for _, passInfo in ipairs(PlayerData:GetActiveBattlePassList()) do
      PlayerData.MultiMissionRefreshState[passInfo.kind] = true
    end
    PlayerData.MultiMissionRefreshAll = false
  end
  if PlayerData.MultiMissionRefreshState[passKind] == true then
    row.count_1 = false
    row.count_2 = false
    row.count_3 = false
    local state, battlePassId = PlayerData:GetNowPassData(passKind)
    local passData = PlayerData:GetBattlePass(passKind)
    if state == false or passData == nil then
      return row
    end
    local count_1_1 = table.count(passData.point_reward or {})
    local now_lv = passData.pass_level or 0
    local battlePass = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    local max_lv = battlePass.LevelLimit
    if count_1_1 < max_lv and 0 < count_1_1 then
      if count_1_1 < now_lv then
        row.count_1 = true
      else
        for k, v in pairs(passData.point_reward or {}) do
          if v.pay == nil and passData.pass_type ~= 0 then
            row.count_1 = true
            break
          end
        end
      end
    end
    for k, v in pairs(PlayerData:GetQuestDaily(passKind)) do
      local daily = {}
      daily = v
      daily.CA = PlayerData:GetFactoryData(k)
      if daily.recv == 0 and daily.pcnt >= daily.CA.num then
        row.count_2 = true
        break
      end
    end
    for k, v in pairs(PlayerData:GetQuestWeekly(passKind)) do
      local weekly = {}
      weekly = v
      weekly.CA = PlayerData:GetFactoryData(k)
      if weekly.recv == 0 and weekly.pcnt >= weekly.CA.num then
        row.count_3 = true
        break
      end
    end
    if now_lv >= max_lv then
      row.count_2 = false
      row.count_3 = false
    end
    PlayerData.MultiMissionRefreshState[passKind] = false
  end
  return row
end

function PlayerData:GetAllBattlePassRedState()
  for _, passInfo in ipairs(PlayerData:GetActiveBattlePassList()) do
    local row = PlayerData:GetBattlePassRedState(passInfo.kind)
    if row.count_1 == true or row.count_2 == true or row.count_3 == true then
      return true
    end
  end
  return false
end

function PlayerData:SetAutoAddRush()
  PlayerData:SetPlayerPrefs("int", "IsAutoAddRush", PlayerData:GetPlayerPrefs("int", "IsAutoAddRush") == 0 and 1 or 0)
end

function PlayerData:GetCardDes(id, isInit)
  local role = PlayerData:GetRoleById(id)
  local skill
  if isInit then
    skill = DataManager:GetUnitCard(id, 0, 0)
  else
    local awakeLv = role.awake_lv or 1
    local resonanceLv = role.resonance_lv or 1
    local roleCA = self:GetFactoryData(id)
    if roleCA.talentList ~= nil and resonanceLv == #roleCA.talentList and self:IsRoleResonanceLock(id) then
      resonanceLv = resonanceLv - 1
    end
    if roleCA.breakthroughList ~= nil and awakeLv == #roleCA.breakthroughList - 1 and self:IsRoleAwakeLock(id) then
      awakeLv = awakeLv - 1
    end
    skill = DataManager:GetUnitCard(id, awakeLv, resonanceLv)
  end
  local skillList = Json.decode(skill)
  return skillList.cards
end

function PlayerData:GetRoleEquipIndex(eid)
  local hid = PlayerData:GetEquipById(eid).hid
  if hid == "" then
    return nil
  end
  local role = PlayerData:GetRoleById(hid)
  local equips = role.equips
  for k, v in pairs(equips) do
    if eid == v then
      return k
    end
  end
  return nil
end

function PlayerData:RefreshPlot_paragraph(plot_paragraph)
  PlayerData.plot_paragraph = {}
  for i, v in pairs(plot_paragraph) do
    PlayerData.plot_paragraph[v] = v
  end
end

function PlayerData:TryPlayPlotByParagraphID(paragraphID)
  local isShowPlot = paragraphID ~= nil and 0 < paragraphID
  for k, v in pairs(PlayerData.plot_paragraph) do
    if tonumber(v) == paragraphID then
      isShowPlot = false
      break
    end
  end
  if isShowPlot then
    UIManager:Open(UIPath.UIDialog, Json.encode({id = paragraphID}))
  end
end

function PlayerData:SetPanelTriggerGuide()
  local recordGuideNos = {}
  for k, v in pairs(PlayerData.ServerData.first_guides) do
    recordGuideNos[v] = 0
  end
  local firstGuideConfig = PlayerData:GetFactoryData(99900049, "ConfigFactory")
  local ids = {}
  local uiNames = {}
  local guideIds = {}
  local idx = 1
  for k, v in pairs(firstGuideConfig.guideList) do
    if not recordGuideNos[v.id] then
      ids[idx] = v.id
      uiNames[idx] = v.ui
      guideIds[idx] = v.guideId
      idx = idx + 1
    end
  end
  if 0 < #ids then
    GuideManager:SetPanelTriggerGuideInfo(ids, uiNames, guideIds)
  end
end

function PlayerData.IsStationRepLvLimit(repLv)
  local stop_info = PlayerData:GetHomeInfo().station_info.stop_info
  if stop_info ~= nil and stop_info[2] == -1 then
    local stationId = stop_info[1]
    local serverData = PlayerData:GetHomeInfo().stations[stationId]
    local stationRep = serverData.rep_lv or 0
    return repLv > stationRep
  end
  return true
end

function PlayerData:AllBuyCommodity(id, num, callback)
  local moneyID = id
  if num > PlayerData:GetGoodsById(moneyID).num then
    local function callback_s()
      CommonTips.OpenStoreBuy()
    end
    
    if moneyID == 11400001 then
      CommonTips.OpenTips(80600129)
    end
    if moneyID == 11400005 then
      CommonTips.OnPrompt(80600147, nil, nil, callback_s)
    end
    if moneyID == 11400020 then
      CommonTips.OnPrompt(80600240)
    end
    if moneyID == 11400017 then
      CommonTips.OpenTips(80600464)
    end
    if moneyID == 11400100 then
      local ca = PlayerData:GetFactoryData(moneyID, DataManager:GetFactoryNameById(moneyID))
      CommonTips.OpenTips(string.format(GetText(80601070), ca.name))
    end
    return
  end
  if callback then
    callback()
  end
end

function PlayerData:SetNoPrompt(key, promptType, isOn, isPid)
  self:SetPlayerPrefs("int", key .. "_isOn", isOn and 1 or 0, isPid)
  if promptType == 1 then
    self:SetPlayerPrefs("string", key .. "_timeStamp", tostring(TimeUtil:GetFutureTime(0, 0)), isPid)
  elseif promptType == 2 then
    self:SetPlayerPrefs("string", key .. "_timeStamp", tostring(TimeUtil:GetNextWeekTime(1)), isPid)
  end
end

function PlayerData:GetNoPrompt(key, promptType, isPid)
  local isOn = self:GetPlayerPrefs("int", key .. "_isOn", isPid) == 1
  if promptType == 1 and (tonumber(self:GetPlayerPrefs("string", key .. "_timeStamp", isPid)) or 0) < TimeUtil:GetFutureTime(0, 0) then
    isOn = false
    self:SetPlayerPrefs("int", key .. "_isOn", 0, isPid)
  elseif promptType == 2 and (tonumber(self:GetPlayerPrefs("string", key .. "_timeStamp", isPid)) or 0) < TimeUtil:GetNextWeekTime(1) then
    isOn = false
    self:SetPlayerPrefs("int", key .. "_isOn", 0, isPid)
  end
  return isOn
end

function PlayerData:SetLoveBentoClicked(uid, isClicked)
  self:SetPlayerPrefs("int", uid .. "_isClick", isClicked and 1 or 0)
end

function PlayerData:GetLoveBentoClicked(uid)
  local isClicked = self:GetPlayerPrefs("int", uid .. "_isClick") == 1
  return isClicked
end

function PlayerData:ClearLoveBentoClicked(uid)
  self:DeletePlayerPrefs(uid .. "_isClick")
end

function PlayerData:ProtocolCallback(protocolName)
  QuestTrace.ProtocolCallback(protocolName)
end

function PlayerData:GetStoreBuyTipsConfig(id)
  local factoryName = DataManager:GetFactoryNameById(tonumber(id))
  local noRarityItem = PlayerData:GetFactoryData(99900017).noRarityItem
  for k, v in pairs(noRarityItem) do
    if factoryName == v.Factory then
      return true
    end
  end
  return false
end

function PlayerData:GetConstructionProportion(stationId)
  local count = 0
  local StationList = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  if StationList == nil then
    return count
  end
  for k, v in pairs(StationList.construction) do
    count = count + v.proportion
  end
  return count
end

function PlayerData.GetConstructionProportionByStage(stationId, stageIndex)
  local stationData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  if not stationData then
    return 0
  end
  local constructionData = stationData.construction[stageIndex]
  return constructionData and constructionData.proportion or 0
end

function PlayerData:SetAttractionTipShowed(id)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if homeConfig.isTipRepeat then
    return
  end
  Net:SendProto("plot.dialog", function(json)
    self.ServerData.dialog_paragraph[#self.ServerData.dialog_paragraph + 1] = tonumber(id)
  end, id)
end

function PlayerData:GetAttractionTipShowed(id)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if homeConfig.isTipRepeat then
    return false
  end
  local dialog_paragraph = self.ServerData.dialog_paragraph
  for i = 1, #dialog_paragraph do
    if tonumber(dialog_paragraph[i]) == tonumber(id) then
      return true
    end
  end
  return false
end

function PlayerData:SetAttractionTipId(id)
  self.attractionHistory.id = id
end

function PlayerData:SetAttractionTipIndex(index)
  self.attractionHistory.index = index
end

function PlayerData:SetAttractionTipRange(disMin, disMax)
  self.attractionHistory.disMin = disMin
  self.attractionHistory.disMax = disMax
end

function PlayerData:GetAttractionTipHistory()
  return self.attractionHistory
end

function PlayerData:ClearAttractionTipHistory()
  self.attractionHistory = {}
end

function PlayerData:GetCurrentDurable()
  return PlayerData:GetHomeInfo().readiness.repair.current_durable
end

function PlayerData:SetLevelDifficulty(levelId, difficulty)
  self:SetPlayerPrefs("int", levelId .. "_difficulty", difficulty or 1)
end

function PlayerData:GetLevelDifficulty(levelId)
  local difficulty = self:GetPlayerPrefs("int", levelId .. "_difficulty")
  if difficulty and type(difficulty) == "number" and 0 < difficulty then
    return difficulty
  end
  return 1
end

function PlayerData:GetPolluteTurntable(isForce)
  if isForce == nil and PlayerData:GetHomeInfo().station_info.is_arrived > 0 then
    return
  end
  local View = require("UIMainUI/UIMainUIView")
  local DataModel_main = require("UIMainUI/UIMainUIDataModel")
  local station_info = PlayerData:GetHomeInfo().station_info
  local line_events = station_info.line_events
  local allPollute = 0
  local count = 0
  if line_events and 0 < table.count(line_events) then
    for k, v in pairs(line_events) do
      local events = v.events
      if events and 0 < table.count(events) then
        for c, d in pairs(events) do
          local ca = PlayerData:GetFactoryData(d.id)
          if ca == nil then
            print_r("AFKEventFactory\230\178\161\230\156\137\230\173\164id\239\188\154" .. d.id .. "\233\133\141\231\189\174")
          else
            allPollute = allPollute + ca.difficultyIndex
          end
          count = count + 1
        end
      elseif View.Group_Common.Group_MB.Group_PollutionIndex.Img_Mask.Group_Color.self.transform.rotation.z == 0 then
        return
      end
    end
  end
  local average_value = math.ceil(allPollute / 3)
  average_value = 240 * (average_value / 12)
  View.self:SelectPlayAnim(View.Group_Common.Group_MB.Group_PollutionIndex.self, "Animation_Pollu", function()
    DataModel_main.average_value = average_value
    DataModel_main.aniGroupColor = true
  end)
end

function PlayerData.GetIndexCoachWeapon(idx)
  local t = {}
  local coachInfo = PlayerData:GetHomeInfo().coach[idx + 1]
  if coachInfo == nil then
    return {}
  end
  if idx < 1 and coachInfo.skin then
    local skinCfg = PlayerData:GetFactoryData(coachInfo.skin)
    if skinCfg then
      local defaultCfg = PlayerData:GetFactoryData(99900044)
      for k, v in pairs(defaultCfg.skinList) do
        if skinCfg.skinTag == v.tag then
          return {}
        end
      end
    end
  end
  for k, v in pairs(coachInfo.battery) do
    local id = 0
    if v ~= "" and PlayerData:GetBattery() and PlayerData:GetBattery()[v] then
      id = tonumber(PlayerData:GetBattery()[v].id)
    end
    table.insert(t, id)
  end
  return t
end

function PlayerData.GetDisplayTrainIndexCoachWeapon(playerIdx, coachIdx)
  local t = {}
  local playerInfo = PlayerData:GetHomeInfo().display_train[playerIdx]
  if playerInfo == nil then
    print_r(playerInfo)
    logError(string.format("display_info\231\154\132\231\172\172%d\228\184\170\231\142\169\229\174\182\230\149\176\230\141\174\228\184\186\231\169\186", playerIdx))
    return {}
  end
  local coachInfo = playerInfo.coach_info[coachIdx + 1]
  if coachInfo == nil then
    print_r(playerInfo, coachInfo)
    logError(string.format("display_info\231\154\132\231\172\172%d\228\184\170\231\142\169\229\174\182\231\154\132%d\232\189\166\229\142\162coach_info\228\184\186\231\169\186", playerIdx, coachIdx + 1))
    return {}
  end
  if coachIdx < 1 and coachInfo.skin and coachInfo.skin ~= "" then
    local skinCfg = PlayerData:GetFactoryData(coachInfo.skin)
    if skinCfg then
      local defaultCfg = PlayerData:GetFactoryData(99900044)
      for k, v in pairs(defaultCfg.skinList) do
        if skinCfg.skinTag == v.tag then
          return {}
        end
      end
    end
  end
  for k, v in pairs(coachInfo.battery) do
    local id = 0
    if v ~= "" then
      id = tonumber(v)
    end
    table.insert(t, id)
  end
  return t
end

function PlayerData.GetCoachSpeed()
  local home_info = PlayerData:GetHomeInfo()
  local curSpeed = home_info.speed
  local coachSpeedEffect = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local ca = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    coachSpeedEffect = coachSpeedEffect + ca.speedEffect
  end
  coachSpeedEffect = math.floor(coachSpeedEffect + 0.5)
  local weaponSpeedEffect = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed)
  local homeSkillSpeed = math.floor(PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local drinkBuffSpeed = math.floor(PlayerData:GetDrinkBuffIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local weightGoodsSpeed = PlayerData:GetUserInfo().space_info.now_train_goods_num / initConfig.goodsSlowDown
  weightGoodsSpeed = math.floor(weightGoodsSpeed + 0.5)
  local weightPassengerSpeed = PlayerData:GetCurPassengerNum() / initConfig.passengerSlowDown
  weightPassengerSpeed = math.floor(weightPassengerSpeed + 0.5)
  local maintenanceSpeed = 0
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local maxUpkeepDis = homeConfig.maintaindistance
  if maxUpkeepDis <= home_info.readiness.maintain.maintain_distance then
    maintenanceSpeed = math.floor(curSpeed * homeConfig.slowdown + 0.5)
  end
  return curSpeed + coachSpeedEffect + weaponSpeedEffect + homeSkillSpeed + drinkBuffSpeed - weightPassengerSpeed - weightGoodsSpeed - maintenanceSpeed
end

function PlayerData.GetCoachMaxSpeed()
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local speed = initConfig.trainSpeedInit
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local lv = PlayerData:GetHomeInfo().electric_lv + 1
  if lv > #electricConfig.electricList then
    lv = #electricConfig.electricList
  end
  local curElectricSpeed = electricConfig.electricList[lv].speed
  local slotNum = PlayerData:GetHomeInfo().slot_num
  for i = 1, slotNum do
    curElectricSpeed = curElectricSpeed + electricConfig.buyElectricList[i].addSpeed
  end
  return speed + curElectricSpeed
end

function PlayerData:GetLineInPollute(lineId)
  local is_Line = false
  if PlayerData.pollute_areas and table.count(PlayerData.pollute_areas) > 0 then
    for k, v in pairs(PlayerData.pollute_areas) do
      local homeLineCA = PlayerData:GetFactoryData(k)
      if homeLineCA.LineList and 0 < table.count(homeLineCA.LineList) then
        for c, d in pairs(homeLineCA.LineList) do
          if d.id == lineId then
            is_Line = true
          end
        end
      end
    end
  end
  return is_Line
end

PlayerData.polluteEffectList = {}

function PlayerData:ClearPollute()
  PlayerData.polluteEffectList = {}
  TrainManager:CleanPolluteEffect()
  local trainEffectManager = CBus:GetManager(CS.ManagerName.TrainEffectManager, true)
  trainEffectManager.TrainEffectDataDic:Clear()
end

function PlayerData:GetOpenMaoEffect()
  if PlayerData.pollute_areas == nil or table.count(PlayerData.pollute_areas) == 0 then
    return
  end
  for k, v in pairs(PlayerData.pollute_areas) do
    if v.po_curIndex ~= nil then
      local po_curIndex = math.ceil(v.po_curIndex)
      if 0 < po_curIndex then
        local homeLineCA = PlayerData:GetFactoryData(k)
        if homeLineCA.polluteWuqiList and 0 < table.count(homeLineCA.polluteWuqiList) then
          for k, v in pairs(homeLineCA.polluteWuqiList) do
            TrainManager:GetHomeLinePollutePathObj(v.name, tostring(homeLineCA.polluteWuqi), v.pos_x, v.pos_y, v.pos_z, v.distance)
            table.insert(PlayerData.polluteEffectList, v.name)
          end
        end
        if homeLineCA.MapEffectRSSList and 0 < table.count(homeLineCA.MapEffectRSSList) then
          for k, v in pairs(homeLineCA.MapEffectRSSList) do
            TrainManager:GetHomeLinePollutePathObj(v.name, tostring(homeLineCA.MapEffectRSS), v.pos_x, v.pos_y, v.pos_z, v.distance)
            table.insert(PlayerData.polluteEffectList, v.name)
          end
        end
      end
    end
  end
end

function PlayerData.GetMaxElectric(noIncrease)
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local lv = PlayerData:GetHomeInfo().electric_lv + 1
  if lv > #electricConfig.electricList then
    lv = #electricConfig.electricList
  end
  local curElectric = electricConfig.electricList[lv].electric
  local slotNum = PlayerData:GetHomeInfo().slot_num
  for i = 1, slotNum do
    curElectric = curElectric + electricConfig.buyElectricList[i].electric
  end
  if noIncrease == true then
    return curElectric
  end
  return math.floor(curElectric * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited)) + 0.5) + math.floor(PlayerData.GetFurSkillTrainByName("RiseElectricMax"))
end

function PlayerData.GetStationCurrentGoodsNum(stationId)
  local num = 0
  for k, v in pairs(PlayerData:GetGoods()) do
    if v.stations then
      num = num + (v.stations[tostring(stationId)] or 0)
    end
  end
  return num
end

function PlayerData.GetStationCurrentTransitGoodsNum(stationId)
  local num = 0
  local debugGoods = PlayerData:GetTransitGoods()
  if debugGoods ~= nil then
    local cacheGoods = PlayerData:GetTransitGoods()[tostring(stationId)]
    if cacheGoods then
      for k, goodsList in pairs(cacheGoods) do
        for id, data in pairs(goodsList) do
          num = num + data.num
        end
      end
    end
  end
  return num
end

function PlayerData:SetTargetFrameRate()
  if PlayerData:GetHomeInfo().station_info.is_arrived ~= 2 and CS.UnityEngine.Application.targetFrameRate ~= GameSetting.currentVisualTrainFPSNum then
    GraphicsSettingHelper.SetVisualFPS(GameSetting.currentVisualTrainFPS, false, true)
  else
    GraphicsSettingHelper.SetVisualFPS(GameSetting.currentVisualFPS)
  end
end

function PlayerData.GetFurtureStatusIcon(id)
  if UIManager:IsPanelOpened("UI/Playground/FriendIslandUpdate/FriendUI/FriendUI") then
    local UIFriendUIDataModel = require("UIFriendUI/UIFriendUIDataModel")
    return UIFriendUIDataModel.GetFurStatusIcon(id)
  end
  local path
  local f_cfg = PlayerData:GetFactoryData(id)
  if f_cfg.functionType == 12600474 then
    path = "UI/Common/HomeFurniture/hako"
    local path_bg = "UI/Common/HomeFurniture/bubble"
    local homeScene = MainManager.bgSceneName == "Home"
    if homeScene then
      local roomList = PlayerData:GetHomeInfo().coach_template
      local coach_store = PlayerData:GetHomeInfo().coach_store
      for k, v in pairs(roomList) do
        local cfgId = coach_store[v].id
        local coach_cfg = PlayerData:GetFactoryData(cfgId)
        local coachType = coach_cfg.coachType
        local tagCA = PlayerData:GetFactoryData(coachType)
        if not tagCA.stopCarriage then
          local collect_ts = coach_store[v].collect_ts or TimeUtil:GetServerTimeStamp() - 86400
          if math.floor(math.abs(TimeUtil:GetServerTimeStamp() - collect_ts) / 86400) >= 2 then
            path = "UI/Common/HomeFurniture/hakofull"
            path_bg = "UI/Common/HomeFurniture/fullbg"
            return string.format("1:%s:%s", path, path_bg)
          end
        end
      end
    else
      local coach_store = CommonCoachData.GetRoomData()
      local t = CommonCoachData.GetCurPlaygroundServerInfo()
      for k, v in pairs(coach_store) do
        local collect_ts = v.collect_ts or TimeUtil:GetServerTimeStamp() - 86400
        if collect_ts == "" then
          collect_ts = TimeUtil:GetServerTimeStamp() - 86400
        end
        if math.floor(math.abs(TimeUtil:GetServerTimeStamp() - collect_ts) / 86400) >= 2 then
          path = "UI/Common/HomeFurniture/hakofull"
          path_bg = "UI/Common/HomeFurniture/fullbg"
          return string.format("1:%s:%s", path, path_bg)
        end
      end
    end
    local rubbish_info = PlayerData:GetHomeInfo().rubbish_area or {}
    if not homeScene then
      rubbish_info = CommonCoachData.GetCurPlaygroundServerInfo().rubbish_area or {}
    end
    local rubbish_capaticy = f_cfg.StoreRubbish
    if rubbish_capaticy < rubbish_info.waste_block then
      path = "UI/Common/HomeFurniture/hakofull"
      path_bg = "UI/Common/HomeFurniture/fullbg"
      return string.format("1:%s:%s", path, path_bg)
    end
    local home_cfg = PlayerData:GetFactoryData(99900014)
    local compress_mincnt = home_cfg.CompressNum
    if rubbish_capaticy < rubbish_info.waste_block + rubbish_info.waste_num / compress_mincnt then
      local unit_cost_time = home_cfg.CompressTime
      local pass_time = TimeUtil:GetServerTimeStamp() - rubbish_info.compress_ts
      local channel = 1
      if f_cfg.Level < home_cfg.secondOpenLevel then
        channel = 1
      elseif f_cfg.Level >= home_cfg.secondOpenLevel and f_cfg.Level < home_cfg.thirdOpenLevel then
        channel = 2
      else
        channel = 3
      end
      local now_compress_num = math.floor(pass_time / unit_cost_time) * channel
      if rubbish_capaticy < rubbish_info.waste_block + now_compress_num then
        path = "UI/Common/HomeFurniture/hakofull"
        path_bg = "UI/Common/HomeFurniture/fullbg"
        return string.format("1:%s:%s", path, path_bg)
      end
    end
    return string.format("0:%s:%s", path, path_bg)
  end
  return nil
end

function PlayerData.ShowSpecialFurnitureStatus(ufid, obj)
  print_r(ufid, obj)
  print_r(PlayerData:GetFurniture()[ufid])
end

function PlayerData.RequestProductInfo(productList, accumulations, resultMessage)
  PlayerData.ProductList = nil
  if resultMessage == "" then
    PlayerData.ProductList = productList
  else
    CommonTips.OpenTips(resultMessage, true)
  end
end

function PlayerData.PayProduct(product, callback)
  local userInfo = PlayerData:GetUserInfo()
  GSDKManager:PayProduct(product, userInfo.uid, userInfo.role_name, userInfo.lv, 0, "", function(orderID, resultMessage)
    if resultMessage ~= "" then
      CommonTips.OpenTips(resultMessage, true)
    end
    if callback ~= nil then
      callback(orderID)
    end
  end)
end

function PlayerData:GetAllRoleAwakeRed()
  local count = 0
  PlayerData.RoleAwakeRedList = {}
  for k, v in pairs(self:GetRoles()) do
    local roleCA = PlayerData:GetFactoryData(k)
    local level = v.awake_lv
    local isFull = false
    if level < #roleCA.breakthroughList - 1 then
      local bkId = roleCA.breakthroughList[level + 1].breakthroughId
      local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
      for c, d in pairs(materialList) do
        local needNum = d.num
        local haveNum = PlayerData:GetGoodsById(d.itemId).num
        if needNum <= haveNum then
          count = count + 1
          isFull = true
        end
      end
    end
    PlayerData.RoleAwakeRedList[k] = isFull
  end
  PlayerData.isAwakeRed = false
  if 0 < count then
    PlayerData.isAwakeRed = true
  end
end

function PlayerData:GetAllRoleAwakeRedID(id)
  if PlayerData.RoleAwakeRedList[tostring(id)] == nil then
    return false
  end
  return PlayerData.RoleAwakeRedList[tostring(id)]
end

function PlayerData:GetAwakeEquipRed()
  local count = 0
  if PlayerData.ServerData and PlayerData.ServerData.squad then
    for i = 1, 4 do
      local squad = PlayerData.ServerData.squad[i]
      if 0 < table.count(squad.role_list) then
        for k, v in pairs(squad.role_list) do
          if v.id and PlayerData:GetAllRoleAwakeRedID(v.id) == true then
            count = count + 1
          end
        end
      end
    end
  end
  PlayerData.isSquadAwakeRed = false
  if 0 < count then
    PlayerData.isSquadAwakeRed = true
  end
end

function PlayerData:GetRoleLevelRed(id)
  local role = self:GetRoleById(id)
  if role == nil or role.lv == nil then
    return false
  end
  if role.lv >= self:GetUserInfo().lv then
    return false
  end
  local matList = PlayerData:GetFactoryData(99900001, "ConfigFactory").expSourceMaterialList
  local num = 0
  for i = 1, #matList do
    num = num + PlayerData:GetGoodsById(matList[i].id).num
  end
  return 0 < num
end

function PlayerData:GetRoleResonaceRed(id)
  local role = self:GetRoleById(id)
  if role == nil or role.resonance_lv == nil or role.lv == nil then
    return false
  end
  local roleCA = self:GetFactoryData(id)
  if role.resonance_lv >= #roleCA.awakeList - 1 then
    return false
  end
  local awakeId = roleCA.awakeList[role.resonance_lv + 1].awakeId
  local rData = self:GetFactoryData(awakeId, "AwakeFactory")
  local materialList = rData.materialList
  if role.lv < rData.level then
    return false
  end
  for i = 1, #materialList do
    local itemId = materialList[i].itemId
    local needNum = materialList[i].num
    local haveNum = PlayerData:GetGoodsById(itemId).num
    if needNum > haveNum then
      return false
    end
  end
  return true
end

function PlayerData:RestData()
  PlayerData.pollute_areas = nil
  PlayerData.cameraNodePath = ""
  PlayerData.BattleInfo = {}
end

function PlayerData:GetCurFestivalIndex()
  local index = -1
  local ca = self:GetFactoryData(99900015, "ConfigFactory")
  if ca then
    local festivalList = ca.FestivalRewardList
    local rewardData = self.ServerData.ft_reward
    for i = 1, #festivalList do
      local startDate = self.GetTimeByString(festivalList[i].StartDate)
      local endDate = self.GetTimeByString(festivalList[i].EndDate)
      local curTime = TimeUtil:GetServerTimeStamp()
      if startDate <= curTime and endDate >= curTime and rewardData[i] == nil then
        index = i
        break
      end
    end
  end
  return index
end

function PlayerData.GetTimeByString(timeStr)
  local year = tonumber(string.sub(timeStr, 1, 4))
  local month = tonumber(string.sub(timeStr, 6, 7))
  local day = tonumber(string.sub(timeStr, 9, 10))
  local hour = tonumber(string.sub(timeStr, 12, 13))
  local min = tonumber(string.sub(timeStr, 15, 16))
  local sec = tonumber(string.sub(timeStr, 18, 19))
  return os.time({
    year = year,
    month = month,
    day = day,
    hour = hour,
    minute = min,
    second = sec
  })
end

function PlayerData:GetFestivalRewards(roleIndex, index)
  Net:SendProto("main.festival_reward", function(json)
    local reward = json.reward
    local roleId = self.ServerData.user_info.receptionist_id[roleIndex]
    local name = self:GetFactoryData(roleId, "UnitFactory").name
    local festival = self:GetFactoryData(99900015, "ConfigFactory").FestivalRewardList[index].Festival
    local text = GetText(80601875)
    CommonTips.OpenShowItem(reward, nil, string.format(text, name, festival))
    self.ServerData.ft_reward[index] = 0
  end, index - 1)
end

function PlayerData.IsEnergyEnough()
  local currEnergy = PlayerData:GetUserInfo().move_energy
  local homeCommon = require("Common/HomeCommon")
  local maxEnergy = homeCommon.GetMaxHomeEnergy()
  return currEnergy < maxEnergy
end

function PlayerData.RemoveStrike(uid)
  local all = PlayerData:GetBattery()
  if all and all[uid] then
    all[uid] = nil
  end
  PlayerData:GetHomeInfo().coach[1].battery[1] = ""
  if TrainManager and TrainManager.TrainCtrl and TrainManager.TrainCtrl.FirstTrain then
    TrainManager.TrainCtrl:LoadStrikeBasic(0, "")
    TrainManager.TrainCtrl.FirstTrain.Strike = nil
    if TrainManager.TrainCtrl.FirstTrain.Skin then
      CS.FRef.setProperty(TrainManager.TrainCtrl.FirstTrain.Skin, "_strike", nil)
      TrainManager.TrainCtrl.FirstTrain.Skin:RemoveWeapon(0)
    end
  end
end

function PlayerData.GetTotalFashion()
  return PlayerData:GetUserInfo().fashion
end

function PlayerData.GetStrike()
  local t = {}
  if PlayerData:GetBattery() then
    for i, v in pairs(PlayerData:GetBattery()) do
      if v.u_cid ~= "" then
        local cfg = PlayerData:GetFactoryData(v.id)
        if cfg.mod == "\232\189\166\229\142\162\230\146\158\232\167\146" then
          t = {
            id = v.id,
            u_bid = i
          }
        end
      end
    end
  end
  return t
end

function PlayerData.GetWeapon()
  local t
  if PlayerData:GetBattery() then
    for i, v in pairs(PlayerData:GetBattery()) do
      if v.u_cid ~= "" then
        local cfg = PlayerData:GetFactoryData(v.id)
        if cfg.mod == "\232\189\166\229\142\162\230\173\166\229\153\168" then
          t = {
            id = v.id,
            u_bid = i
          }
        end
      end
    end
  end
  return t
end

function PlayerData:IsStoreOpen(storeId)
  local ca = self:GetFactoryData(storeId, "StoreFactory")
  if not ca.isTime then
    return true
  end
  local startTime = self.GetTimeByString(ca.startTime)
  local endTime = self.GetTimeByString(ca.endTime)
  local curTime = TimeUtil:GetServerTimeStamp()
  return startTime <= curTime and endTime >= curTime, endTime - curTime
end

function PlayerData:SetAutoDialog(isAuto, speed)
  self:SetPlayerPrefs("int", "_isAutoDialog", isAuto and 1 or 0)
  self:SetPlayerPrefs("int", "_isAutoDialogSpeed", speed)
end

function PlayerData:GetAutoDialog()
  local isAuto = self:GetPlayerPrefs("int", "_isAutoDialog") == 1
  local speed = self:GetPlayerPrefs("int", "_isAutoDialogSpeed") or 1
  return isAuto, speed
end

function PlayerData:IsHighRecycleClicked(stationId)
  local clickTime = self:GetPlayerPrefs("string", stationId .. "_ClickTime")
  local time = TimeUtil:GetFutureTime(0, 5)
  return time ~= tonumber(clickTime)
end

function PlayerData:SaveHighRecycleClickTime(stationId)
  local time = TimeUtil:GetFutureTime(0, 5)
  self:SetPlayerPrefs("string", stationId .. "_ClickTime", tostring(time))
end

function PlayerData.IsInStation()
  if PlayerData and PlayerData.ServerData and PlayerData.ServerData.user_home_info and PlayerData.ServerData.user_home_info.station_info and PlayerData.ServerData.user_home_info.station_info.is_arrived then
    return PlayerData:GetHomeInfo().station_info.is_arrived == 2
  end
  return true
end

function PlayerData.GetCoachMaxDurability()
  local durability = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local ca = PlayerData:GetFactoryData(v.id)
    durability = durability + ca.carriagedurability
  end
  local maxDurable = durability + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseDurabilityLimited, durability) + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseDurabilityLimited)
  return maxDurable
end

PlayerData.counter = 0

function PlayerData.ShowCMD(key)
  if key == "903907" then
    PlayerData.counter = PlayerData.counter + 1
    if PlayerData.counter >= 6 then
      PlayerData.counter = 0
      ExternEdenConsole.Show()
      return true
    end
  end
  return false
end

function PlayerData.GetMaxFuelNum()
  local fuelNum = PlayerData:GetHomeInfo().readiness.fuel.max_fuel_num or 0
  return fuelNum + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushLimited, fuelNum) + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseRushLimited)
end

function PlayerData.GetMaxTrainGoodsNum()
  local maxNum = PlayerData:GetUserInfo().space_info.max_train_goods_num or 0
  return maxNum + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseSpaceLimited, maxNum) + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseSpaceLimited)
end

function PlayerData.GetOverMaxTrainGoodsNum()
  if PlayerData.goodsOver == nil or PlayerData.goodsOver == -1 then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    PlayerData.goodsOver = homeConfig.goodsOver
  end
  local maxNum = PlayerData:GetUserInfo().space_info.max_train_goods_num or 0
  local over = #PlayerData:GetHomeInfo().coach * (PlayerData.goodsOver or 8) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.GoodsOverVal, 0)
  return maxNum + over + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseSpaceLimited, maxNum) + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseSpaceLimited)
end

function PlayerData.GetMaxTrailerNum()
  local maxNum = PlayerData:GetHomeInfo().max_req_back_num or 0
  return maxNum
end

function PlayerData.GetRoleInCoachSkinPath(characterId, state)
  if characterId == 70000067 or characterId == 70000063 then
    return ""
  end
  local unitCA, roles
  if PlayerData.visitMode then
    roles = PlayerData.visitInfo.roles
  else
    roles = PlayerData.ServerData.roles
  end
  for roleId, v in pairs(roles) do
    unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
    if unitCA.homeCharacter == characterId then
      if v.current_skin[1] then
        return PlayerData:GetFactoryData(v.current_skin[1], "UnitViewFactory").HomeresDir
      else
        return ""
      end
    end
  end
  return ""
end

function PlayerData.RefreshRoleInCoachSkin(roleId)
  local roleData = PlayerData.ServerData.roles[tostring(roleId)]
  if roleData and roleData.current_skin then
    local resPath = PlayerData:GetFactoryData(roleData.current_skin[1], "UnitViewFactory").HomeresDir
    if resPath and resPath ~= "" then
      local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
      HomeCharacterManager:RefreshRoleInCoachSkin(unitCA.homeCharacter, PlayerData:GetFactoryData(roleData.current_skin[1], "UnitViewFactory").HomeresDir)
    else
      local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
      local characterCA = PlayerData:GetFactoryData(unitCA.homeCharacter, "HomeCharacterFactory")
      HomeCharacterManager:RefreshRoleInCoachSkin(unitCA.homeCharacter, characterCA.resDir)
    end
  end
end

function PlayerData.FormatNumThousands(num)
  local k = 0
  while true do
    num, k = string.gsub(num, "^(-?%d+)(%d%d%d)", "%1,%2")
    if k == 0 then
      break
    end
  end
  return num
end

function PlayerData.RefreshPolluteLines()
  local MapController = require("UIHome/UIHomeMapController")
  Net:SendProto("unification.world_pollute", function()
    MapController:SetPolluteLines()
  end)
end

function PlayerData:CheckoutPurchase(params)
  if SdkHelper.IsChannelBilibili() then
    return true
  end
  if not GameSetting.AdministrationsAddictionFeature then
    return true
  end
  local payAmount = 0
  if params.payAmount then
    payAmount = params.payAmount
  end
  local CNY = PlayerData:GetUserInfo().CNY
  local grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
  if grow <= 8 then
    CommonTips.OpenAntiAddiction({index = 7})
    return false
  end
  if 8 < grow and grow <= 16 and 50 < payAmount then
    CommonTips.OpenAntiAddiction({index = 8})
    return false
  end
  if 8 < grow and grow <= 16 and 200 < payAmount + CNY then
    CommonTips.OpenAntiAddiction({index = 9})
    return false
  end
  return true
end

local SoundList = {
  [0] = -80,
  [1] = -17,
  [2] = -15,
  [3] = -13,
  [4] = -11,
  [5] = -9,
  [6] = -7,
  [7] = -5,
  [8] = -3,
  [9] = -1,
  [10] = 0
}

function PlayerData:SetSound()
  local Now_Bg
  local isFirstBg = PlayerPrefs.GetInt("bgFirst")
  if isFirstBg == 0 then
    Now_Bg = 50
    PlayerPrefs.SetInt("bgFirst", 1)
    PlayerPrefs.SetInt("bg", Now_Bg)
  else
    Now_Bg = PlayerPrefs.GetInt("bg")
  end
  local Now_Music
  local isFirstMusic = PlayerPrefs.GetInt("musicFirst")
  if isFirstMusic == 0 then
    Now_Music = 50
    PlayerPrefs.SetInt("musicFirst", 1)
    PlayerPrefs.SetInt("music", Now_Music)
  else
    Now_Music = PlayerPrefs.GetInt("music")
  end
  local Now_RoleCV
  local isFirstRoleCV = PlayerPrefs.GetInt("roleCvFirst")
  if isFirstRoleCV == 0 then
    Now_RoleCV = 50
    PlayerPrefs.SetInt("roleCvFirst", 1)
    PlayerPrefs.SetInt("roleCV", Now_RoleCV)
  else
    Now_RoleCV = PlayerPrefs.GetInt("roleCV")
  end
  SoundManager:SetBGMVolumePercent(SoundList[Now_Bg] or 0)
  SoundManager:SetSoundVolumePercent(SoundList[Now_Music] or 0)
  SoundManager:SetRoleVolumePercent(SoundList[Now_RoleCV] or 0)
end

function PlayerData.GetDisplayTrainSpeedDec(playerIdx)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetHomeInfo().display_train[playerIdx] == nil then
    return 1
  end
  local speedReduceLv = PlayerData:GetHomeInfo().display_train[playerIdx].brake_lv or 1
  local dec = math.floor(homeConfig.slowDownList[speedReduceLv].Num + 0.5) / homeConfig.speedRatio
  return dec
end

function PlayerData.GetDisplayTrainSpeedAdd(playerIdx)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetHomeInfo().display_train[playerIdx] == nil then
    return 1
  end
  local speedAddLv = PlayerData:GetHomeInfo().display_train[playerIdx].expedite_lv or 1
  local add = math.floor(homeConfig.speedUpList[speedAddLv].Num + 0.5) / homeConfig.speedRatio
  return add
end

function PlayerData.GetIsTest()
  return PlayerData.TempCache.IsTest
end

function PlayerData.SetIsTest(isTest)
  PlayerData.TempCache.IsTest = isTest
end

function PlayerData.IsPassageFunOpen()
  local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  local user_lv = PlayerData:GetUserInfo().lv
  if user_lv >= config.passageOpen then
    return true
  end
  return false
end

function PlayerData.IsSolicitFunOpen()
  local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  local user_lv = PlayerData:GetUserInfo().lv
  if user_lv >= config.solicitOpen then
    if config.solicitQuestOpen > 0 then
      local quest = PlayerData.ServerData.quests.mq_quests[tostring(config.solicitQuestOpen)]
      return quest and quest.recv ~= 0
    else
      return true
    end
  end
  return false
end

function PlayerData.IsFlierFunOpen()
  local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  local user_lv = PlayerData:GetUserInfo().lv
  if user_lv >= config.advertiseOpen then
    if config.advertiseQuestOpen > 0 then
      local quest = PlayerData.ServerData.quests.mq_quests[tostring(config.advertiseQuestOpen)]
      return quest and quest.recv ~= 0
    else
      return true
    end
  end
  return false
end

function PlayerData.IsMagazineFunOpen(stationId)
  local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  local user_lv = PlayerData:GetUserInfo().lv
  if user_lv >= config.magazineOpen then
    local stationData
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if stationCA.attachedToCity > 0 then
      stationData = PlayerData:GetHomeInfo().stations[tostring(stationCA.attachedToCity)]
    else
      stationData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    end
    if stationData.rep_lv >= config.magazineFameOpen then
      return true
    end
  end
  return false
end

function PlayerData.IsChannelFunOpen(stationId)
  local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
  local user_lv = PlayerData:GetUserInfo().lv
  if user_lv >= config.channelOpen then
    local stationData
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if stationCA.attachedToCity > 0 then
      stationData = PlayerData:GetHomeInfo().stations[tostring(stationCA.attachedToCity)]
    else
      stationData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    end
    if stationData.rep_lv >= config.channelFameOpen then
      return true
    end
  end
  return false
end

function PlayerData.RefreshSolicitData(serverData)
  PlayerData.SolicitData.leafletNum = serverData.own_leaflet
  PlayerData.SolicitData.copyLeafletNum = serverData.add_leaflet
  for i, v in pairs(serverData.leaflet_location) do
    PlayerData.SolicitData.stationSendPosList[v] = v
  end
  PlayerData.SolicitData.magazineSendNum = serverData.mgz_num
  PlayerData.SolicitData.magazinePool = serverData.mgz_pool
  PlayerData.SolicitData.tvSendNum = serverData.tv_num
  PlayerData.SolicitData.tvPool = serverData.tv_pool
end

function PlayerData.GetLeafLetNum()
  return PlayerData.SolicitData.leafletNum
end

function PlayerData.GetRemainCopyLeafLetNum()
  local maxCopyNum = PlayerData:GetFactoryData(99900061, "ConfigFactory").leafletAddMax
  return maxCopyNum - PlayerData.SolicitData.copyLeafletNum
end

function PlayerData:CheckTrainWeaponCondition(weaponTag, params)
  if weaponTag == "\230\177\161\230\159\147\229\140\186\231\148\159\230\149\136" then
    return self.pollute_areas[tostring(params.areaId)] ~= nil
  elseif weaponTag == "\229\137\141\229\190\128\230\159\144\232\189\166\231\171\153\231\148\159\230\149\136" then
    return params.isToStation
  elseif weaponTag == "\230\159\144\228\186\155\231\186\191\232\183\175\231\148\159\230\149\136" then
    return params.isAtLine
  else
    return true
  end
end

function PlayerData:GetEnemyHpGrade(value)
  local grade = "D"
  if 600000 <= value then
    grade = "SSS"
  elseif 200000 <= value then
    grade = "SS"
  elseif 100000 <= value then
    grade = "S"
  elseif 20000 <= value then
    grade = "A"
  elseif 15000 <= value then
    grade = "B"
  elseif 10000 <= value then
    grade = "C"
  else
    grade = "D"
  end
  return grade
end

function PlayerData:GetEnemyDefGrade(value)
  local grade = "D"
  if 110 <= value then
    grade = "SSS"
  elseif 85 <= value then
    grade = "SS"
  elseif 75 <= value then
    grade = "S"
  elseif 65 <= value then
    grade = "A"
  elseif 60 <= value then
    grade = "B"
  elseif 55 <= value then
    grade = "C"
  else
    grade = "D"
  end
  return grade
end

function PlayerData:GetEnemyAtkGrade(value)
  local grade = "D"
  if 110 <= value then
    grade = "SSS"
  elseif 86 <= value then
    grade = "SS"
  elseif 76 <= value then
    grade = "S"
  elseif 68 <= value then
    grade = "A"
  elseif 61 <= value then
    grade = "B"
  elseif 55 <= value then
    grade = "C"
  else
    grade = "D"
  end
  return grade
end

function PlayerData:SetAutoTrailerIds()
  local isHide = PlayerData:GetPlayerPrefs("int", "HideTailer") == 1
  local station_info = PlayerData:GetHomeInfo().station_info
  if not isHide and station_info.npc_index then
    local currIndex = station_info.npc_index + 1
    local trailer = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerList[currIndex]
    local trailerTrain = PlayerData:GetFactoryData(trailer.trainId, "ListFactory")
    local trains = trailerTrain.trainLook
    local trainSkins = {}
    for _, v in ipairs(trains) do
      table.insert(trainSkins, v.id)
    end
    TrainManager:SetAutoTrailerIds(trainSkins)
  else
    TrainManager:SetAutoTrailerIds({})
  end
end

function PlayerData:GetLevelDropList(levelCA, difficulty, waveList)
  difficulty = difficulty or 1
  local dropTableList = levelCA.dropTableList
  local dropList = {}
  if 0 < #dropTableList then
    local dropListCA = PlayerData:GetFactoryData(dropTableList[difficulty].listId, "ListFactory")
    dropList = Clone(dropListCA.leveldropList)
  end
  
  local function ContainsItem(list, item)
    for i = 1, #list do
      if list[i].id == item.id then
        return true
      end
    end
    return false
  end
  
  waveList = waveList or {}
  for i = 1, #levelCA.enemyWaveList do
    waveList[#waveList + 1] = levelCA.enemyWaveList[i]
  end
  local wDrop = {}
  for i = 1, #waveList do
    local waveCA = PlayerData:GetFactoryData(waveList[i].enemyWaveId)
    local waveDropList = waveCA.dropTableList
    for j = 1, #waveDropList do
      local dropCA = PlayerData:GetFactoryData(waveDropList[j].listId)
      for k = 1, #dropCA.leveldropList do
        if not ContainsItem(wDrop, dropCA.leveldropList[k]) then
          wDrop[#wDrop + 1] = dropCA.leveldropList[k]
        end
      end
    end
  end
  table.sort(wDrop, function(a, b)
    local aCA = PlayerData:GetFactoryData(a.id)
    local bCA = PlayerData:GetFactoryData(b.id)
    if aCA.qualityInt == bCA.qualityInt then
      return a.id > b.id
    end
    return aCA.qualityInt > bCA.qualityInt
  end)
  for i = 1, #wDrop do
    if not ContainsItem(dropList, wDrop[i]) then
      dropList[#dropList + 1] = wDrop[i]
    end
  end
  return dropList
end

function PlayerData.IsSendPassengerOver(endId)
  local t = PlayerData:GetHomeInfo().passenger[tostring(endId)]
  return t and table.count(t) > 0
end

function PlayerData:NumToFormatString(Num, precision)
  local num1, num2, formatStr
  precision = precision or 0
  local len = string.len(Num)
  if 4 <= len and len <= 6 then
    num1, num2 = math.modf(Num / 1000)
    if 0 < precision and 0 < num2 then
      return string.format("%." .. precision .. "f", num1 + num2) .. "k"
    else
      return string.format("%d", num1) .. "k"
    end
  end
  if 7 <= len and len <= 9 then
    num1, num2 = math.modf(Num / 1000000)
    if 0 < precision and 0 < num2 then
      return string.format("%." .. precision .. "f", num1 + num2) .. "m"
    else
      return string.format("%d", num1) .. "m"
    end
  end
  if 10 <= len and len <= 12 then
    num1, num2 = math.modf(Num / 1000000000)
    if 0 < precision and 0 < num2 then
      return string.format("%." .. precision .. "f", num1 + num2) .. "b"
    else
      return string.format("%d", num1) .. "b"
    end
  end
  return Num
end

function PlayerData:RefreshCompleteDungeon(completed_dungeon)
  self:GetHomeInfo().completed_dungeon = completed_dungeon
end

function PlayerData:RefreshChapterSeverData()
  local levelId = self.BattleInfo.battleStageId
  local levelCA = self:GetFactoryData(levelId, "LevelFactory")
  if levelCA and levelCA.chapterId > 0 then
    local characterCA = PlayerData:GetFactoryData(levelCA.chapterId, "ChapterFactory")
    self.ServerData.schedule_chapter = self.ServerData.schedule_chapter or {}
    local serverData = self.ServerData.schedule_chapter[tostring(levelCA.chapterId)]
    if not serverData then
      self.ServerData.schedule_chapter[tostring(levelCA.chapterId)] = {}
      serverData = self.ServerData.schedule_chapter[tostring(levelCA.chapterId)]
    end
    if characterCA.saveProgress then
      table.insert(serverData, levelId)
    else
      for i, v in pairs(serverData) do
        if v == levelId then
          table.remove(serverData, i)
          break
        end
      end
    end
  end
end

function PlayerData:GetActivityAct(activityId)
  if activityId and PlayerData.ServerData.all_activities.ing and PlayerData.ServerData.all_activities.ing[tostring(activityId)] then
    return PlayerData.ServerData.all_activities.ing[tostring(activityId)].act == 1
  end
  return false
end

function PlayerData:RefreshActivityData(activityId, activityData)
  if PlayerData.ServerData.all_activities and PlayerData.ServerData.all_activities.ing then
    PlayerData.ServerData.all_activities.ing[tostring(activityId)] = activityData
  end
end

function PlayerData:GetActivityData(activityId)
  if PlayerData.ServerData.all_activities and PlayerData.ServerData.all_activities.ing then
    return PlayerData.ServerData.all_activities.ing[tostring(activityId)]
  end
  return nil
end

function PlayerData.RefreshCardsData(serverData)
  local data = serverData and serverData.card_pack
  if not data then
    return
  end
  for k, v in pairs(data) do
    PlayerData.ServerData.books.card_pack[k] = v
  end
end

function PlayerData:GetSignInfoRedState()
  local SignInfo = PlayerData:GetLocalSignInfo()
  if SignInfo ~= nil then
    local totalDays = SignInfo.totalDays
    local id = SignInfo.id
    local severData = PlayerData:GetSignInfo()[tostring(id)]
    if severData then
      if severData.count == totalDays then
        return false, true
      end
      if severData.status == 0 then
        return true, false
      end
      return false, false
    end
    return false, false
  end
  return false, false
end

function PlayerData.GetFurSkillCarriage(u_cid)
  local info = {}
  local skillsData = PlayerData.ServerData.user_home_info.f_skills or {}
  for skillName, data in pairs(skillsData) do
    local skills = data[u_cid]
    if skills then
      for skillId, num in pairs(skills) do
        if 0 < num then
          local addParam = info[skillName] or 0
          local skillCA = PlayerData:GetFactoryData(skillId, "HomeFurnitureSkillFactory")
          if skillCA.isOnly then
            addParam = addParam + skillCA.param
          else
            addParam = addParam + skillCA.param * num
          end
          info[skillName] = addParam
        end
      end
    end
  end
  return info
end

function PlayerData.GetFurSkillFur(furId)
  local info = {}
  local furCA = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
  if furCA.FurnitureSkillList then
    for i, v in pairs(furCA.FurnitureSkillList) do
      local skillCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureSkillFactory")
      if skillCA.SkillRange == "Furniture" then
        local addNum = info[skillCA.SkillType] or 0
        addNum = addNum + skillCA.param
        info[skillCA.SkillType] = addNum
      end
    end
  end
  return info
end

function PlayerData.GetFurSkillTrain()
  local info = {}
  local skillsData = PlayerData.ServerData.user_home_info.f_skills or {}
  for skillName, data in pairs(skillsData) do
    local skills = data.train or {}
    if skills then
      for skillId, num in pairs(skills) do
        if 0 < num then
          local addParam = info[skillName] or 0
          local skillCA = PlayerData:GetFactoryData(skillId, "HomeFurnitureSkillFactory")
          if skillCA.isOnly then
            addParam = addParam + skillCA.param
          else
            addParam = addParam + skillCA.param * num
          end
          info[skillName] = addParam
        end
      end
    end
  end
  return info
end

function PlayerData.GetFurSkillTrainByName(skillName)
  local addNum = 0
  local skillsData = PlayerData.ServerData.user_home_info.f_skills or {}
  local data = skillsData[skillName] or {}
  local skills = data.train or {}
  for skillId, num in pairs(skills) do
    if 0 < num then
      local skillCA = PlayerData:GetFactoryData(skillId, "HomeFurnitureSkillFactory")
      if skillCA.isOnly then
        addNum = addNum + skillCA.param
      else
        addNum = addNum + skillCA.param * num
      end
    end
  end
  return addNum
end

function PlayerData.GetFurSkillPg()
  local info = {}
  local fac_skills = PlayerData.ServerData.user_home_info.fac_skills or {}
  local skillsData = fac_skills["12601231"] or {}
  for skillName, data in pairs(skillsData) do
    local skills = data.Playground or {}
    if skills then
      for skillId, num in pairs(skills) do
        if 0 < num then
          local addParam = info[skillName] or 0
          local skillCA = PlayerData:GetFactoryData(skillId, "HomeFurnitureSkillFactory")
          if skillCA.isOnly then
            addParam = addParam + skillCA.param
          else
            addParam = addParam + skillCA.param * num
          end
          info[skillName] = addParam
        end
      end
    end
  end
  return info
end

function PlayerData.GetFurSkillPgByName(skillName)
  local addNum = 0
  local fac_skills = PlayerData.ServerData.user_home_info.fac_skills or {}
  local data = fac_skills["12601231"] or {}
  local skills = data[skillName] and data[skillName].Playground or {}
  for skillId, num in pairs(skills) do
    if 0 < num then
      local skillCA = PlayerData:GetFactoryData(skillId, "HomeFurnitureSkillFactory")
      if skillCA.isOnly then
        addNum = addNum + skillCA.param
      else
        addNum = addNum + skillCA.param * num
      end
    end
  end
  return addNum
end

local ScoreBuffName = {
  pet = "AddPetScores",
  fish = "AddFishScores",
  comfort = "AddComfort",
  plant = "AddPlantScores",
  food = "AddFoodScores",
  play = "AddPlayScores",
  medical = "AddMedicalScores"
}
local ScoreProperty = {
  pet = "petScores",
  fish = "fishScores",
  comfort = "comfort",
  plant = "plantScores",
  food = "foodScores",
  play = "playScores",
  medical = "medicalScores"
}

function PlayerData.GetTrainFurScore(ufid)
  local scoreInfo = {
    pet = 0,
    fish = 0,
    comfort = 0,
    plant = 0,
    food = 0,
    play = 0,
    medical = 0
  }
  local furData = ufid and PlayerData:GetHomeInfo().furniture[tostring(ufid)]
  if furData then
    local furBuff = PlayerData.GetFurSkillFur(furData.id)
    local carriageBuff = PlayerData.GetFurSkillCarriage(furData.u_cid)
    local trainBuff = PlayerData.GetFurSkillTrain()
    local furCA = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
    for scoreType, property in pairs(ScoreProperty) do
      local furScore = furCA[property] or 0
      local buffName = ScoreBuffName[scoreType]
      local furBuffAdd = furBuff[buffName] or 0
      local carriageBuffAdd = carriageBuff[buffName] or 0
      local trainBuffAdd = trainBuff[buffName] or 0
      local homeBuffAdd = PlayerData:GetHomeSkillIncrease(buffName)
      local furBasicScore = MathEx.roundToDecimalPlaces(furScore * (1 + furBuffAdd + carriageBuffAdd + trainBuffAdd + homeBuffAdd), 1)
      if property == ScoreProperty.pet then
        local creaturePetScores = 0
        if furData.house and furData.house.pets then
          local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")
          for k, v in pairs(furData.house.pets) do
            local petInfo = PlayerData:GetHomeInfo().pet[v]
            if petInfo then
              creaturePetScores = creaturePetScores + PetInfoData.CalPetScores(petInfo)
            end
          end
        end
        furBasicScore = furBasicScore + MathEx.roundToDecimalPlaces(creaturePetScores, 1)
      elseif property == ScoreProperty.fish then
        local creatureFishScores = 0
        if furData.water and furData.water.fishes then
          for k, v in pairs(furData.water.fishes) do
            local ca = PlayerData:GetFactoryData(k)
            local fishScores = ca.fishScores * (1 + furBuffAdd + carriageBuffAdd + trainBuffAdd + homeBuffAdd)
            creatureFishScores = creatureFishScores + fishScores * v
          end
        end
        furBasicScore = furBasicScore + MathEx.roundToDecimalPlaces(creatureFishScores, 1)
      elseif property == ScoreProperty.medical then
        local medicalRoleScores = 0
        if furData.id == "81300034" and furData.roles and furData.roles[1] and furData.roles[1] ~= "" then
          local unitCA = PlayerData:GetFactoryData(furData.roles[1], "UnitFactory")
          medicalRoleScores = unitCA.medicalPoint * (1 + furBuffAdd + carriageBuffAdd + trainBuffAdd + homeBuffAdd)
        end
        furBasicScore = furBasicScore + MathEx.roundToDecimalPlaces(medicalRoleScores, 1)
      end
      scoreInfo[scoreType] = ClearFollowZero(furBasicScore)
    end
  end
  return scoreInfo
end

function PlayerData.GetPgFurScore(ufid)
  local scoreInfo = {
    pet = 0,
    fish = 0,
    comfort = 0,
    plant = 0,
    food = 0,
    play = 0,
    medical = 0
  }
  local furDataList = PlayerData:GetHomeInfo().facility["12601231"] or {}
  local furData = ufid and furDataList[tostring(ufid)]
  if furData then
    local furBuff = PlayerData.GetFurSkillFur(furData.id)
    local pgBuff = PlayerData.GetFurSkillPg()
    local furCA = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
    for scoreType, property in pairs(ScoreProperty) do
      local furScore = furCA[property] or 0
      local buffName = ScoreBuffName[scoreType]
      local furBuffAdd = furBuff[buffName] or 0
      local pgBuffAdd = pgBuff[buffName] or 0
      local homeBuffAdd = PlayerData:GetHomeSkillIncrease(buffName)
      local furBasicScore = MathEx.roundToDecimalPlaces(furScore * (1 + furBuffAdd + pgBuffAdd + homeBuffAdd), 1)
      if property == ScoreProperty.fish then
        local creatureFishScores = 0
        if furData.water and furData.water.fishes then
          for k, v in pairs(furData.water.fishes) do
            local ca = PlayerData:GetFactoryData(k)
            local fishScores = ca.fishScores * (1 + furBuffAdd + pgBuffAdd + homeBuffAdd)
            creatureFishScores = creatureFishScores + fishScores * v
          end
        end
        furBasicScore = furBasicScore + MathEx.roundToDecimalPlaces(creatureFishScores, 1)
      end
      scoreInfo[scoreType] = ClearFollowZero(furBasicScore)
    end
  end
  return scoreInfo
end

function PlayerData.GetFurScoreWithAllBuff(ufid, coachBagTagId)
  if tonumber(coachBagTagId) == 12601230 then
    return PlayerData.GetTrainFurScore(ufid)
  elseif tonumber(coachBagTagId) == 12601231 then
    return PlayerData.GetPgFurScore(ufid)
  end
  return {
    pet = 0,
    fish = 0,
    comfort = 0,
    plant = 0,
    food = 0,
    play = 0,
    medical = 0
  }
end

function PlayerData.RefreshFurSkillData(furData, remove)
  PlayerData.ServerData.user_home_info.f_skills = PlayerData.ServerData.user_home_info.f_skills or {}
  PlayerData.ServerData.user_home_info.fac_skills = PlayerData.ServerData.user_home_info.fac_skills or {}
  local furCA = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
  if furCA.FurnitureSkillList then
    for i, v in pairs(furCA.FurnitureSkillList) do
      local skillCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureSkillFactory")
      local skillType = skillCA.SkillType
      local skillRange = skillCA.SkillRange
      local data
      if skillRange == "Train" then
        local skillData = PlayerData.ServerData.user_home_info.f_skills
        skillData[skillType] = skillData[skillType] or {}
        skillData[skillType].train = skillData[skillType].train or {}
        data = skillData[skillType].train
      elseif skillRange == "Carriage" then
        local skillData = PlayerData.ServerData.user_home_info.f_skills
        skillData[skillType] = skillData[skillType] or {}
        skillData[skillType][furData.u_cid] = skillData[skillType][furData.u_cid] or {}
        data = skillData[skillType][furData.u_cid]
      elseif skillRange == "Playground" then
        local skillData = PlayerData.ServerData.user_home_info.fac_skills
        skillData[tostring(furCA.bag)] = skillData[tostring(furCA.bag)] or {}
        skillData[tostring(furCA.bag)][skillType] = skillData[tostring(furCA.bag)][skillType] or {}
        skillData[tostring(furCA.bag)][skillType].Playground = skillData[tostring(furCA.bag)][skillType].Playground or {}
        data = skillData[tostring(furCA.bag)][skillType].Playground
      end
      if data then
        if skillCA.isOnly then
          if remove then
            data[tostring(v.id)] = 0
          else
            data[tostring(v.id)] = 1
          end
        elseif remove then
          local skillNum = data[tostring(v.id)] or 0
          if 0 < skillNum then
            data[tostring(v.id)] = skillNum - 1
          end
        else
          local skillNum = data[tostring(v.id)] or 0
          data[tostring(v.id)] = skillNum + 1
        end
      end
    end
  end
end

function PlayerData:GetRolePetProperty(roleId)
  local pet = PlayerData:GetRoleById(roleId).u_pet
  local petAtk = 0
  local petDef = 0
  local petHP = 0
  if pet ~= nil and pet ~= "" then
    local petInfo = PlayerData:GetHomeInfo().pet[pet]
    if petInfo and petInfo.role_id ~= "" then
      for i = 1, #petInfo.buff_list do
        local buffCA = PlayerData:GetFactoryData(petInfo.buff_list[i])
        if buffCA ~= nil then
          petAtk = petAtk + buffCA.atkNum
          petDef = petDef + buffCA.defNum
          petHP = petHP + buffCA.hpNum
        end
      end
    end
  end
  local addTieVal = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddTieVal)
  petAtk = petAtk * (1 + addTieVal)
  petDef = petDef * (1 + addTieVal)
  petHP = petHP * (1 + addTieVal)
  return {
    atk = petAtk,
    def = petDef,
    hp = petHP
  }
end

function PlayerData:GetRoleResonanceProperty(roleId)
  local roleCA = self:GetFactoryData(roleId)
  local prop = {}
  for i = 1, #roleCA.talentList do
    local talentCA = self:GetFactoryData(roleCA.talentList[i].talentId)
    for j = 1, #talentCA.attributeIntensify do
      local listCA = self:GetFactoryData(talentCA.attributeIntensify[j].id)
      local attrLv = self:GetRoleResonanceAttributeLevel(roleId, i, j)
      if 0 < attrLv then
        local attrCA = PlayerData:GetFactoryData(listCA.attributeGradeList[attrLv].id)
        local skillVal = attrCA.attributeList[1].value_SN
        prop[attrCA.attributeList[1].attributeType .. "_" .. attrCA.attributeList[1].numberType] = (prop[attrCA.attributeList[1].attributeType .. "_" .. attrCA.attributeList[1].numberType] or 0) + skillVal
      end
    end
  end
  return prop
end

function PlayerData:GetRoleResonanceFinalSkillProperty(roleId)
  local prop = {}
  local isFinalSkillUnlock = self:IsRoleFinalSkillUnlock(roleId)
  if isFinalSkillUnlock then
    local roleCA = self:GetFactoryData(roleId)
    local skillCA = self:GetFactoryData(roleCA.finalSkill)
    if skillCA ~= nil then
      local buffCA = self:GetFactoryData(skillCA.buffId)
      if buffCA ~= nil then
        local attributeList = buffCA.attributeChangeList
        for i = 1, #attributeList do
          prop[attributeList[i].attributeType] = attributeList[i].value_SN
        end
      end
    end
  end
  return prop
end

function PlayerData:GetRoleSkillLevel(roleId)
  local roleData
  if type(roleId) == "table" then
    roleData = roleId
    roleId = roleData.id
  end
  local roleCA = self:GetFactoryData(roleId)
  local skill = {}
  for i = 1, #roleCA.talentList do
    local talentCA = self:GetFactoryData(roleCA.talentList[i].talentId)
    local skillLv
    if roleData then
      skillLv = self:GetRoleResonanceSkillLevelByData(roleData, i)
    else
      skillLv = self:GetRoleResonanceSkillLevel(roleId, i)
    end
    if 0 < skillLv then
      local skillList = talentCA.skillActiveUpgrade
      for i = 1, #skillList do
        skill[tostring(skillList[i].id)] = skillLv + 1
      end
    end
  end
  return skill
end

function PlayerData:GetRoleResonanceExSkillStr(roleId)
  local roleData
  if type(roleId) == "table" then
    roleData = roleId
    roleId = roleData.id
  end
  local roleCA = self:GetFactoryData(roleId)
  local str = ""
  for i = 1, #roleCA.talentList do
    local talentCA = self:GetFactoryData(roleCA.talentList[i].talentId)
    for j = 1, #talentCA.attributeIntensify do
      local listCA = self:GetFactoryData(talentCA.attributeIntensify[j].id)
      local attrLv
      if roleData then
        attrLv = self:GetRoleResonanceAttributeLevelByData(roleData, i, j)
      else
        attrLv = self:GetRoleResonanceAttributeLevel(roleId, i, j)
      end
      if 0 < attrLv then
        if str ~= "" then
          str = str .. "|"
        end
        str = str .. listCA.attributeGradeList[attrLv].id
      end
    end
    local skillLv
    if roleData then
      skillLv = self:GetRoleResonanceSkillLevelByData(roleData, i)
    else
      skillLv = self:GetRoleResonanceSkillLevel(roleId, i)
    end
    local skillList = talentCA.skillActiveUpgrade
    if 0 < skillLv and #skillList <= 0 then
      local skillCA = PlayerData:GetFactoryData(talentCA.skillIntensify)
      local skillVal = skillCA.minAttrSN + (skillLv - 1) * skillCA.digitSN
      if str ~= "" then
        str = str .. "|"
      end
      str = str .. skillCA.id .. "," .. skillCA.tagName .. "," .. skillVal
    end
  end
  local isFinalSkillUnlock
  if roleData then
    isFinalSkillUnlock = self:IsRoleFinalSkillUnlockByData(roleData)
  else
    isFinalSkillUnlock = self:IsRoleFinalSkillUnlock(roleId)
  end
  if isFinalSkillUnlock then
    if str ~= "" then
      str = str .. "|"
    end
    str = str .. roleCA.finalSkill
  end
  return str
end

function PlayerData:GetActivityServerConstruction(activityId)
  if self.ServerData ~= nil and self.ServerData.server_construction ~= nil and self.ServerData.server_construction[tostring(activityId)] then
    return self.ServerData.server_construction[tostring(activityId)]
  end
  return nil
end

function PlayerData:RefreshActivityServerConstruction(constructionList)
  if self.ServerData.server_construction == nil then
    self.ServerData.server_construction = {}
  end
  for k, v in pairs(constructionList) do
    self.ServerData.server_construction[k] = v
  end
end

function PlayerData:GetActivityServerConstructionCstNum(activityId)
  local cst_num = 0
  if self.ServerData ~= nil and self.ServerData.server_construction ~= nil and PlayerData:GetActivityServerConstruction(activityId) then
    cst_num = PlayerData:GetActivityServerConstruction(activityId).cst_num or 0
  end
  return cst_num
end

function PlayerData:GetActivityPersonalConstructionCstNum(activityId)
  local cst_num = 0
  if PlayerData:GetActivityData(activityId) then
    cst_num = PlayerData:GetActivityData(activityId).cst_num or 0
  end
  return cst_num
end

function PlayerData:GetActivityServerConstructionPerRewardState(activityId, index)
  local isRecv = false
  if PlayerData:GetActivityData(activityId) then
    for k, v in pairs(PlayerData:GetActivityData(activityId).ser_reward) do
      if v == index then
        isRecv = true
        break
      end
    end
  end
  return isRecv
end

function PlayerData:GetActivityPersonalConstructionPerRewardState(activityId, index)
  local isRecv = false
  if PlayerData:GetActivityData(activityId) then
    for k, v in pairs(PlayerData:GetActivityData(activityId).per_reward) do
      if v == index then
        isRecv = true
        break
      end
    end
  end
  return isRecv
end

function PlayerData:GetNowPassData(kind)
  local passList = PlayerData:GetActiveBattlePassList()
  if kind == nil or kind == false then
    local passInfo = passList[1]
    if passInfo then
      return true, passInfo.id, passInfo
    end
    return false
  end
  local passKind = GetDefaultPassKind(kind)
  for _, v in ipairs(passList) do
    if v.kind == passKind then
      return true, v.id, v
    end
  end
  return false
end

function PlayerData.CheckExceedCapacityLimit(rewardList, isShowTip)
  local addNum = {}
  for i, v in ipairs(rewardList) do
    local factoryName = DataManager:GetFactoryNameById(v.id)
    if factoryName and factoryName ~= "" then
      if addNum[factoryName] == nil then
        addNum[factoryName] = 0
      end
      addNum[factoryName] = addNum[factoryName] + v.num
    end
  end
  local tipId
  for k, num in pairs(addNum) do
    if k == "HomeGoodsFactory" then
      if num + PlayerData:GetUserInfo().space_info.now_train_goods_num > PlayerData.GetMaxTrainGoodsNum() then
        tipId = 80607024
        break
      end
    elseif k == "FridgeItemFactory" and num + PlayerData:GetUserInfo().space_info.now_food_material_num > PlayerData:GetUserInfo().space_info.max_food_material_num then
      tipId = 80601477
      break
    end
  end
  if tipId then
    if isShowTip then
      CommonTips.OpenTips(tipId)
    end
    return true
  end
  return false
end

function PlayerData:SetConstructStageRecIndex(StationId, TabIndex, Index)
  if PlayerData:GetHomeInfo().stations[tostring(StationId)] == nil then
    return
  end
  if PlayerData:GetHomeInfo().stations[tostring(StationId)].construction[TabIndex] == nil then
    return
  end
  local rec_index = PlayerData:GetHomeInfo().stations[tostring(StationId)].construction[TabIndex].rec_index
  table.insert(rec_index, Index)
end

function PlayerData:GetConstructStageRewardState(stationId)
  if stationId == nil then
    return false
  end
  local stationCA = PlayerData:GetFactoryData(stationId)
  local constructStageList = stationCA.constructStageList
  local nowStageIndex = 0
  for i = 1, #constructStageList do
    local row = constructStageList[i]
    local construction = PlayerData:GetHomeInfo().stations[tostring(stationId)].construction[i]
    local proportion = construction.proportion
    local rec_index = construction.rec_index
    local stageRewardList = PlayerData:GetFactoryData(row.id).stageRewardList
    for k, v in pairs(stageRewardList) do
      if proportion >= v.construct and rec_index[k] == nil then
        nowStageIndex = nowStageIndex + 1
      end
    end
  end
  if 0 < nowStageIndex then
    return true
  end
  return false
end

function PlayerData.OpenToPlayground(params)
  local function cb()
    local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
    
    if SliceSceneManager ~= nil then
      SliceSceneManager.loadedScene:Clear()
    end
    local playgroundCA = PlayerData:GetFactoryData(params.playgroundId)
    PlayerData.TempCache.CurPlaygroundId = params.playgroundId
    CBus:ChangeScene(playgroundCA.sceneName, function()
      local t = {}
      t.playgroundId = params.playgroundId
      t.stationId = params.stationId
      t.backSceneName = params.backSceneName
      t.backUI = params.backUI
      t.backParams = params.backParams
      UIManager:Open("UI/Playground/Playground", Json.encode(t))
    end)
    GameSetting:LoadPlayerSetting()
    PlayerData:ResetCharacterFilter()
    PlayerData:ResetSuaqsFilter()
    PlayerData:ResetDepotFilter()
  end
  
  local playgroundCA = PlayerData:GetFactoryData(params.playgroundId)
  local randomNum = math.random(1, #playgroundCA.loadingList)
  CommonTips.OpenLoading(nil, "", playgroundCA.loadingList[randomNum].imagePath, cb)
end

function PlayerData.GetCurPlaygroundId()
  return PlayerData.TempCache.CurPlaygroundId or -1
end

function PlayerData:SaveLevelRoleCaptain(levelId, roleId)
  self:SetPlayerPrefs("string", levelId .. "_LevelRoleCaptain", tostring(roleId))
end

function PlayerData:GetLevelRoleCaptain(levelId)
  local roleId = self:GetPlayerPrefs("string", levelId .. "_LevelRoleCaptain")
  if roleId == nil or roleId == "" then
    return ""
  end
  return roleId
end

function PlayerData:SaveAbyssTeam(abyssId, roleStr)
  self:SetPlayerPrefs("string", abyssId .. "_roleList", roleStr)
end

function PlayerData:GetAbyssTeam(abyssId)
  local roleStr = self:GetPlayerPrefs("string", abyssId .. "_roleList")
  if roleStr == nil or roleStr == "" then
    roleStr = "-1,-1,-1,-1,-1;-1,-1,-1,-1,-1"
  end
  return roleStr
end

function PlayerData:GetAbyssRedPoint()
  local periodId
  local abyssCA = PlayerData:GetFactoryData(86600001)
  local starFlag = false
  local rewardFlag = false
  for i = 1, #abyssCA.abyssPeriodList do
    local periodCA = PlayerData:GetFactoryData(abyssCA.abyssPeriodList[i].id)
    if TimeUtil:IsActive(periodCA.startTime, periodCA.endTime) then
      periodId = periodCA.id
      break
    end
  end
  if periodId == nil then
    return starFlag, rewardFlag
  end
  local starNum = 0
  local periodCA = PlayerData:GetFactoryData(periodId)
  if periodCA.openLv > PlayerData:GetUserInfo().lv then
    return starFlag, rewardFlag
  end
  for i = 1, #periodCA.abyssList do
    local abyssId = tostring(periodCA.abyssList[i].id)
    if PlayerData.ServerData.abyss_level[abyssId] ~= nil and PlayerData.ServerData.abyss_level[abyssId].stars ~= nil then
      for j = 1, #PlayerData.ServerData.abyss_level[abyssId].stars do
        if PlayerData.ServerData.abyss_level[abyssId].stars[j] ~= 0 then
          starNum = starNum + 1
        end
      end
    end
  end
  local claimedNum = 0
  local claimData = PlayerData.ServerData.abyss_period[tostring(periodId)]
  if claimData ~= nil and claimData.reward ~= nil then
    claimedNum = #claimData.reward
  end
  local claimableNum = 0
  for i = 1, #periodCA.starReward do
    local rewardData = periodCA.starReward[i]
    if starNum >= rewardData.star then
      claimableNum = claimableNum + 1
    end
  end
  if claimedNum < claimableNum then
    rewardFlag = true
  end
  if starNum >= #periodCA.abyssList * 3 then
    starFlag = false
  else
    starFlag = true
  end
  local enterTime = self:GetPlayerPrefs("string", "EnterAbyssTimeStamp") or "0"
  if (tonumber(enterTime) or 0) >= TimeUtil:GetFutureTime(0, 0) then
    starFlag = false
  end
  return starFlag, rewardFlag
end

function PlayerData:SaveAbyssTime()
  self:SetPlayerPrefs("string", "EnterAbyssTimeStamp", TimeUtil:GetServerTimeStamp())
end

function PlayerData.UIReplace(uiBase, caId)
  local uiReplaceCA = PlayerData:GetFactoryData(caId)
  if uiReplaceCA then
    local replaceId = uiReplaceCA.defaultId
    local curPgId = CommonCoachData.GetPlaygroundId()
    if curPgId and 0 < curPgId then
      for i, v in ipairs(uiReplaceCA.replaceList) do
        if curPgId == v.pgId then
          replaceId = v.reId
        end
      end
    end
    local toReplaceCA = PlayerData:GetFactoryData(replaceId)
    if toReplaceCA.replaceType == "TXT" then
      if uiBase.SetColor and uiBase.SetTxtFontSize then
        if not string.nilorempty(toReplaceCA.color) then
          uiBase:SetColor(toReplaceCA.color)
        end
        if 0 < toReplaceCA.size then
          uiBase:SetTxtFontSize(toReplaceCA.size)
        end
      else
        local txtComponent = uiBase:GetComponent(typeof(UI.Text))
        if txtComponent then
          if not string.nilorempty(toReplaceCA.color) then
            local success, color = CS.UnityEngine.ColorUtility.TryParseHtmlString(toReplaceCA.color)
            if success then
              txtComponent.color = color
            end
          end
          if 0 < toReplaceCA.size then
            txtComponent.fontSize = toReplaceCA.size
          end
        end
      end
    elseif toReplaceCA.replaceType == "IMG" and uiBase.SetSprite then
      if not string.nilorempty(toReplaceCA.imgPath) then
        uiBase:SetSprite(toReplaceCA.imgPath)
      end
      if not string.nilorempty(toReplaceCA.imgColor) then
        uiBase:SetColor(toReplaceCA.imgColor)
      end
    end
  end
end

function PlayerData.GetPlaygroundData(playgroundId)
  return PlayerData:GetHomeInfo().playground and PlayerData:GetHomeInfo().playground[tostring(playgroundId)]
end

function PlayerData.GetVisitorsData(playgroundId)
  return PlayerData:GetHomeInfo().visitors and PlayerData:GetHomeInfo().visitors[tostring(playgroundId)]
end

function PlayerData.RefreshVisitorData(playgroundId, addVisitor)
  local visitorData = PlayerData.GetVisitorsData(playgroundId)
  local playGroundData = PlayerData.GetPlaygroundData(playgroundId)
  for k, v in pairs(addVisitor) do
    local addNum = 0
    for _, num in pairs(v.vt_info) do
      addNum = addNum + num
    end
    if v.source == "pub" then
      playGroundData.pub.people = playGroundData.pub.people + addNum
    elseif v.source == "casual" then
      playGroundData.casual.people = playGroundData.casual.people + addNum
    end
    visitorData[k] = v
  end
end

function PlayerData.GetVisitorsNum(playgroundId)
  local visitors = {}
  local visitorsData = PlayerData.GetVisitorsData(playgroundId)
  if visitorsData then
    for _, v in pairs(visitorsData) do
      for k, num in pairs(v.vt_info) do
        local data = visitors[k]
        if not data then
          visitors[k] = num
        else
          visitors[k] = visitors[k] + num
        end
      end
    end
  end
  local num = 0
  for _, v in pairs(visitors) do
    num = num + v
  end
  return num
end

function PlayerData.GetMaxVisitorsNum(playgroundId)
  local num = 0
  local playgroundData = PlayerData.GetPlaygroundData(playgroundId)
  if playgroundData then
    local playgroundCA = PlayerData:GetFactoryData(playgroundId, "PlaygroundFactory")
    num = playgroundCA.visitorNum * table.count(playgroundData.block)
  end
  return num
end

function PlayerData.IsEntrustShowRed()
  if PlayerData.ServerData.entrust then
    local entrustDataModel = require("UIEntrust/UIEntrustDataModel")
    local maxCount = entrustDataModel.GetEntrustMaxCount()
    if maxCount > table.count(PlayerData.ServerData.entrust) then
      return true
    end
    local curTime = TimeUtil:GetServerTimeStamp()
    for k, v in pairs(PlayerData.ServerData.entrust) do
      if curTime >= v.end_ts then
        return true
      end
    end
  end
  return false
end

function PlayerData:GetCardGacha()
  return PlayerData.ServerData.banners or {}
end

function PlayerData:RefreshCardGacha(banners)
  if banners == nil or self.ServerData == nil or self.ServerData.banners == nil then
    return
  end
  for k, v in pairs(banners) do
    self.ServerData.banners[k] = v
  end
end

function PlayerData:RefreshStageQuestReward(stage_quest_reward)
  if stage_quest_reward == nil or self.ServerData == nil or self.ServerData.quests.stage_quest_reward == nil then
    return
  end
  for k, v in pairs(stage_quest_reward) do
    self.ServerData.quests.stage_quest_reward[k] = v
  end
end

function PlayerData:SetNoShowRewardList(list)
  local row = {}
  if list == nil or table.count(list) == 0 then
    return row
  end
  if ConcealList == nil then
    ConcealList = {}
    local d_list = PlayerData:GetFactoryData(99900001).defaultConcealList
    for k, v in pairs(d_list) do
      ConcealList[tostring(v.id)] = true
    end
  end
  for k, v in pairs(list) do
    if ConcealList[v.id] == nil then
      table.insert(row, v)
    end
  end
  return row
end

function PlayerData.GetTrainSpeed()
  local home_info = PlayerData:GetHomeInfo()
  local curSpeed = home_info.speed
  local homeSkillSpeed = math.floor(PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local drinkBuffSpeed = math.floor(PlayerData:GetDrinkBuffIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local weightGoodsSpeed = PlayerData:GetUserInfo().space_info.now_train_goods_num / initConfig.goodsSlowDown
  weightGoodsSpeed = math.floor(weightGoodsSpeed + 0.5)
  local weightPassengerSpeed = PlayerData:GetCurPassengerNum() / initConfig.passengerSlowDown
  weightPassengerSpeed = math.floor(weightPassengerSpeed + 0.5)
  local maintenanceSpeed = 0
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local maxUpkeepDis = homeConfig.maintaindistance
  if maxUpkeepDis <= home_info.readiness.maintain.maintain_distance then
    maintenanceSpeed = math.floor(curSpeed * homeConfig.slowdown + 0.5)
  end
  local coachSpeedAffect = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    coachSpeedAffect = coachSpeedAffect + coachCA.speedEffect
  end
  coachSpeedAffect = coachSpeedAffect + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "coach")
  coachSpeedAffect = math.floor(coachSpeedAffect + 0.5)
  local trainAccessoriesSpeed = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "accessories")
  trainAccessoriesSpeed = trainAccessoriesSpeed + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "pendant")
  local result = curSpeed + trainAccessoriesSpeed + coachSpeedAffect + homeSkillSpeed + drinkBuffSpeed - weightPassengerSpeed - weightGoodsSpeed - maintenanceSpeed
  return result
end

function PlayerData.RefreshTrainSpecialEffect(isTrainScene)
  local isHide = PlayerData:GetPlayerPrefs("int", "HideSpeedEffect") == 1
  if isTrainScene then
    local trains = CS.FRef.getProperty(TrainManager.TrainCtrl, "_innerTrains")
    if trains and trains.Count > 0 and trains[0] and trains[0].Skin then
      local skin = trains[0].Skin
      local skinCA = GetCA(skin.ca.id, "HomeCoachSkinFactory")
      local view = skin.view
      if view and skinCA and skinCA.specialEffect ~= nil and skinCA.specialEffect ~= "" then
        local root = view.transform:Find(skinCA.specialEffect)
        if root then
          root.gameObject:SetActive(not isHide)
        end
      end
    end
  else
    local train = HomeTrainManager:GetTrainByIndex(0)
    if train then
      local view = train.view
      local skinCA = GetCA(train.ca.id, "HomeCoachSkinFactory")
      if view and skinCA and skinCA.specialEffect ~= nil and skinCA.specialEffect ~= "" then
        local root = view.transform:Find(skinCA.specialEffect)
        if root then
          root.gameObject:SetActive(not isHide)
        end
      end
    end
  end
end

function PlayerData:GetUserInfoAvatar(id)
  if id == nil then
    return false, 0
  end
  local userInfo = PlayerData:GetUserInfo()
  if userInfo == nil then
    return false, 0
  end
  for k, v in pairs(userInfo.avatar_list) do
    if v == tostring(id) then
      return true, 1
    end
  end
  return false, 0
end

function PlayerData.RefreshStriker(isTrainScene, force)
  local stationInfo = PlayerData:GetHomeInfo().station_info
  local isHide = false
  local isSpeicalSkin = PlayerData.CurTrainSkinIsSpecial()
  if isSpeicalSkin or stationInfo.npc_index and stationInfo.npc_speed then
    isHide = true
  else
    isHide = PlayerData:GetPlayerPrefs("int", "HideCoachWeaponStrike") == 1
  end
  if force or isHide then
    if isTrainScene then
      local innerManager = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
      local trains = CS.FRef.getProperty(innerManager.InnerTrainCtrl, "_innerTrains")
      if trains and trains.Count > 0 then
        local train = trains[0]
        if train then
          local skin = train.Skin
          if skin and skin.Strike then
            local view = CS.FRef.getProperty(skin.Strike, "_view")
            if view then
              view:SetActive(not isHide)
            end
          end
        end
      end
    else
      local train = HomeTrainManager:GetTrainByIndex(0)
      if train and train.Strike then
        local view = CS.FRef.getProperty(train.Strike, "_view")
        if view then
          view:SetActive(not isHide)
        end
      end
    end
  end
  PlayerData.RefreshTrainSpecialEffect(isTrainScene)
end

function PlayerData.GetGiveLikeNum()
  local configCA = PlayerData:GetFactoryData(99900112, "ConfigFactory")
  local maxNum = configCA.dailyFrequency
  local currTime = TimeUtil:GetServerTimeStamp()
  local monthCard = configCA.timesAdd[1]
  if monthCard then
    local monthCardData = PlayerData.ServerData.monthly_card or {}
    local data = monthCardData[tostring(monthCard.id)]
    if data and currTime <= data.deadline then
      maxNum = maxNum + monthCard.timesNum
    end
    local activityData = PlayerData:GetActivityData(86000069)
    if activityData and activityData.rec_today and TimeUtil:GetServerTimeStamp() <= activityData.rec_today then
      maxNum = maxNum + monthCard.timesNum
    end
  end
  local userInfo = PlayerData:GetUserInfo()
  local num = 0
  if userInfo.give_like_list then
    num = table.count(userInfo.give_like_list)
  end
  if maxNum < num then
    num = maxNum
  end
  return num, maxNum
end

function PlayerData.IsGiveLike(otherUid)
  local userInfo = PlayerData:GetUserInfo()
  if userInfo.give_like_list then
    for i, v in pairs(userInfo.give_like_list) do
      if v == otherUid then
        return true
      end
    end
  end
  return false
end

function PlayerData.IsGiveLikeMax()
  local num, maxNum = PlayerData.GetGiveLikeNum()
  return maxNum <= num
end

function PlayerData.GiveLive(otherUid, likeType, callback)
  Net:SendProto("main.give_like", function(json)
    if callback then
      callback(json)
    end
  end, otherUid, likeType)
end

function PlayerData.IsSkinHomeSkillOpen()
  if PlayerData.TempCache.isSkinSkill == nil then
    local config = PlayerData:GetFactoryData(99900001)
    PlayerData.TempCache.isSkinSkill = config.isSkinSkill
  end
  return PlayerData.TempCache.isSkinSkill == true
end

function PlayerData.SetUserMonopolyData(user_monopoly)
  if not user_monopoly then
    return
  end
  PlayerData.ServerData = PlayerData.ServerData or {}
  PlayerData.ServerData.user_monopoly = user_monopoly
end

function PlayerData.GetUserMonopolyId()
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    return PlayerData.ServerData.user_monopoly.monopoly_id or 0
  end
  return 0
end

function PlayerData.GetUserMonopolyPeriodTime()
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    return PlayerData.ServerData.user_monopoly.period_times or 0
  end
  return 0
end

function PlayerData.GetUserMonopolyExp()
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    return PlayerData.ServerData.user_monopoly.mpy_exp or 0
  end
  return 0
end

function PlayerData.SetUserMonopolyExp(num)
  if PlayerData.ServerData then
    PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
    PlayerData.ServerData.user_monopoly.mpy_exp = num
  end
end

function PlayerData.AddUserMonopolyExp(num)
  if not PlayerData.ServerData then
    return
  end
  num = num or 0
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.mpy_exp = PlayerData.ServerData.user_monopoly.mpy_exp or 0
  PlayerData.ServerData.user_monopoly.mpy_exp = PlayerData.ServerData.user_monopoly.mpy_exp + num
end

function PlayerData.GetUserMonopolyLv()
  PlayerData.GetMonopolySignMpy()
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    return PlayerData.ServerData.user_monopoly.mpy_lv or 0
  end
  return 0
end

function PlayerData.SetUserMonopolyLv(lv)
  if PlayerData.ServerData then
    PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
    PlayerData.ServerData.user_monopoly.mpy_lv = lv
  end
end

function PlayerData.GetUserMonopolyRankRec()
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    return PlayerData.ServerData.user_monopoly.mpy_rank_recv or 0
  end
  return 0
end

function PlayerData.SetUserMonopolyRankRec(rank_recv)
  if PlayerData.ServerData and PlayerData.ServerData.user_monopoly then
    PlayerData.ServerData.user_monopoly.mpy_rank_recv = rank_recv
  end
end

function PlayerData.GetLvIndexRewardInGotList(index)
  if not PlayerData.ServerData then
    return false
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.lv_reward = PlayerData.ServerData.user_monopoly.lv_reward or {}
  return table.contains(PlayerData.ServerData.user_monopoly.lv_reward, index)
end

function PlayerData.SetLvIndexRewardToGotList(index)
  if not PlayerData.ServerData then
    return
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.lv_reward = PlayerData.ServerData.user_monopoly.lv_reward or {}
  table.insert(PlayerData.ServerData.user_monopoly.lv_reward, index)
end

function PlayerData.ResetLvIndexRewardGetList()
  if not PlayerData.ServerData then
    return
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.lv_reward = {}
end

function PlayerData.GetMonopolyIsEnd()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return false
  end
  return PlayerData.ServerData.user_monopoly.end_mpy == 1
end

function PlayerData.GetMonopolySignStart()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return nil
  end
  return PlayerData.ServerData.user_monopoly.sign_start
end

function PlayerData.GetMonopolySignEnd()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return nil
  end
  return PlayerData.ServerData.user_monopoly.sign_end
end

function PlayerData.GetMonopolyCurrentSign()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return false
  end
  return PlayerData.ServerData.user_monopoly.current_sign == 1
end

function PlayerData.SetMonopolyCurrentSign(current_sign)
  if not PlayerData.ServerData then
    return
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.current_sign = current_sign
end

function PlayerData.GetMonopolySignMpy()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return false
  end
  local isSignMpy = PlayerData.ServerData.user_monopoly.sign_mpy == 1
  local isEndMpy = PlayerData.GetMonopolyIsEnd()
  if not isSignMpy and not isEndMpy then
    PlayerData.SetUserMonopolyLv(1)
    PlayerData.SetUserMonopolyExp(0)
    PlayerData.ResetLvIndexRewardGetList()
  end
  return isSignMpy
end

function PlayerData.SetMonopolySignMpy(sign_mpy)
  if not PlayerData.ServerData then
    return
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.sign_mpy = sign_mpy
end

function PlayerData.GetMonopolyNextSign()
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return false
  end
  return PlayerData.ServerData.user_monopoly.next_sign == 1
end

function PlayerData.SetMonopolyNextSign(next_sign)
  if not PlayerData.ServerData or not PlayerData.ServerData.user_monopoly then
    return
  end
  PlayerData.ServerData.user_monopoly = PlayerData.ServerData.user_monopoly or {}
  PlayerData.ServerData.user_monopoly.next_sign = next_sign
end

function PlayerData.GetMonopolyControlId()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  if defaultConfig then
    return defaultConfig.monopolyControl or 0
  end
  return 0
end

function PlayerData.OpenKabSettlelemt(activityId, initIndex, uiPath)
  uiPath = uiPath or "UI/Kabaneri/KabaneriSettlement"
  UIManager:Open(uiPath, Json.encode({activityId = activityId, initIndex = initIndex}))
end

function PlayerData:GetLevelDropListNew(levelId)
  local levelCA = PlayerData:GetFactoryData(levelId)
  local dropList = {}
  local isReceived = PlayerData:GetLevelFirstRewardsReceived(levelCA.id)
  local firstPassAward = levelCA.firstPassAward
  for i = 1, #firstPassAward do
    table.insert(dropList, {
      num = firstPassAward[i].num,
      id = firstPassAward[i].itemId,
      type = 1,
      isFinish = isReceived,
      index = #dropList
    })
  end
  local dropListNew = PlayerData:GetLevelDropList(levelCA)
  for i = 1, #dropListNew do
    table.insert(dropList, {
      num = dropListNew[i].num,
      id = dropListNew[i].id,
      type = 2,
      index = #dropList
    })
  end
  if isReceived == true then
    table.sort(dropList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type > b.type
    end)
  else
    table.sort(dropList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type < b.type
    end)
  end
  return dropList
end

function PlayerData.GetCubeRoleLv()
  local cubeCA = PlayerData:GetFactoryData(89400002)
  return cubeCA.characterLv or 1
end

function PlayerData:SetStationIsNotFirst(buildId)
  if PlayerData:GetHomeInfo() and PlayerData:GetHomeInfo().stations and PlayerData:GetHomeInfo().stations[tostring(buildId)] then
    PlayerData:GetHomeInfo().stations[tostring(buildId)].is_first = 0
  end
end

function PlayerData.SetCapsuleData(netData)
  PlayerData.ServerData.Capsule = netData
end

function PlayerData.SetSingleCapsuleData(id, data)
  PlayerData.ServerData.Capsule = PlayerData.ServerData.Capsule or {}
  PlayerData.ServerData.Capsule[tostring(id)] = data
end

function PlayerData.GetCapsuleRedDot(capsuleId)
  if PlayerData.ServerData.Capsule == nil then
    return false, 0
  end
  for k, v in pairs(PlayerData.ServerData.Capsule) do
    if tostring(k) == tostring(capsuleId) then
      local pool = v.capsule
      local goodsNum = 0
      for m, n in pairs(pool) do
        goodsNum = goodsNum + n
      end
      local poolCa = PlayerData:GetFactoryData(capsuleId)
      local totle = 0
      for m, n in pairs(poolCa.capsuleList) do
        totle = totle + n.limitNum
      end
      local alreadyPick = totle - goodsNum
      if not v.max_num then
        return false, goodsNum
      end
      if alreadyPick < v.max_num then
        return true, goodsNum
      else
        return false, goodsNum
      end
    end
  end
  return false, 0
end

function PlayerData.ConvertActivityItem(activityId)
  local activityCA = PlayerData:GetFactoryData(activityId, "ActivityFactory")
  local convertList = activityCA.itemConvert
  if not convertList or #convertList == 0 then
    return
  end
  for i, v in ipairs(convertList) do
    local itemData = PlayerData:GetItemById(v.oldItemId)
    if 0 < itemData.num then
      PlayerData.ServerData.items[tostring(v.oldItemId)] = nil
      itemData.num = itemData.num * v.ratio
      itemData.id = tostring(v.newItemId)
      PlayerData.ServerData.items[tostring(v.newItemId)] = itemData
    end
  end
end

function PlayerData.GetWorldBossRedDotState(id)
  local data = PlayerData.ServerData.all_activities.ing[tostring(id)]
  if not data then
    return false
  end
  local bossData = data.world_bosses or data.boss
  if not bossData then
    return false
  end
  local allRecv = true
  for k, v in pairs(bossData) do
    local bossCfg = PlayerData:GetFactoryData(k)
    local maxRewardCount = #bossCfg.bossRewardList
    local canRecvCount = 0
    local curBossHpPercent = v.hp / bossCfg.bossHp
    for i = 1, maxRewardCount do
      if curBossHpPercent <= bossCfg.bossRewardList[i].ratio then
        canRecvCount = i
      end
    end
    local hasRecv = maxRewardCount
    if v.received then
      hasRecv = #v.received
    elseif data.boss and data.boss[k] and data.boss[k].received then
      hasRecv = #data.boss[k].received
    end
    if canRecvCount > hasRecv then
      return true
    end
    if maxRewardCount > hasRecv then
      allRecv = false
    end
  end
  if allRecv then
    return false
  end
  return 0 < data.times
end

function PlayerData.IsExistRewardForGuideAsset()
  local config = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  return GameSetting.IsGuideAsset ~= nil and config ~= nil and PlayerData:GetUserInfo().add_time ~= nil and tonumber(PlayerData:GetUserInfo().add_time) >= tonumber(TimeUtil:TimeStamp(config.packageRegisterTime)) and PlayerData:GetUserInfo().reward_package ~= nil and tonumber(PlayerData:GetUserInfo().reward_package) < 1
end

function PlayerData.GetSpecialTrainTailSkin(skinTag, skinId)
  local defaultCfg = PlayerData:GetFactoryData(99900044)
  local tempData
  for k, v in pairs(defaultCfg.skinList) do
    if v.tag == skinTag then
      tempData = v
      break
    end
  end
  if not tempData then
    return skinId
  end
  return tempData.trainTail
end

function PlayerData.CurTrainSkinIsSpecial()
  if PlayerData:GetHomeInfo() == nil or PlayerData:GetHomeInfo().coach_template == nil or PlayerData:GetHomeInfo().coach_template[1] == nil then
    return nil
  end
  local uid = PlayerData:GetHomeInfo().coach_template[1]
  if PlayerData:GetHomeInfo().coach_store == nil or PlayerData:GetHomeInfo().coach_store[uid] == nil then
    return nil
  end
  local defaultCfg = PlayerData:GetFactoryData(99900044)
  local serverCoach = PlayerData:GetHomeInfo().coach_store[uid]
  local skinCA = PlayerData:GetFactoryData(serverCoach.skin)
  for k, v in pairs(defaultCfg.skinList) do
    if v.tag == skinCA.skinTag then
      return v.tag
    end
  end
  return nil
end

function PlayerData:IsUnitLevelCapBreakUnlock()
  return self:GetUserInfo().lv >= PlayerData:GetFactoryData(99900235).userLevelReq
end

function PlayerData:GetMaxUnitLevelCapBreak()
  return PlayerData:GetFactoryData(99900235).roleLevelMaxPro
end

function PlayerData:GetRoleLevelCapBreak(roleId)
  return self:GetRoleById(roleId).break_lv or 0
end

function PlayerData.GetFurnitureTotleCount(id)
  if PlayerData.ServerData.furnitureCount == nil then
    return 0
  end
  return PlayerData.ServerData.furnitureCount[tostring(id)] or 0
end

function PlayerData.SetFurnitureCount(id, num)
  if PlayerData.ServerData.furnitureCount == nil then
    return
  end
  local curCount = PlayerData.ServerData.furnitureCount[tostring(id)] or 0
  curCount = curCount + num
  if 0 < curCount then
    PlayerData.ServerData.furnitureCount[tostring(id)] = curCount
  end
end

function PlayerData:GetBreakMainAttr(equipCA, lv, lastBkLv, bkLv)
  if bkLv == nil then
    bkLv = 0
  end
  local equipConfig = PlayerData:GetFactoryData(99900027)
  local extraLv = 0
  local lastLv = 0
  local extraAttr = 0
  local lastAttr = 0
  local extraSkill = 0
  local lastSkill = 0
  local mainSkillUp = false
  local weaponBreakEffect
  if equipCA.quality == "Orange" then
    weaponBreakEffect = equipConfig.URWeaponBreakCost
  elseif equipCA.quality == "Golden" then
    weaponBreakEffect = equipConfig.SSRWeaponBreakCost
  elseif equipCA.quality == "Purple" then
    weaponBreakEffect = equipConfig.SRWeaponBreakCost
  elseif equipCA.quality == "Blue" then
    weaponBreakEffect = equipConfig.RWeaponBreakCost
  end
  for i = 1, #weaponBreakEffect do
    if i <= bkLv then
      extraLv = extraLv + weaponBreakEffect[i].lvCapBreak
      if weaponBreakEffect[i].effect == "MainAttrUp" then
        extraAttr = extraAttr + weaponBreakEffect[i].addVal
      end
      if weaponBreakEffect[i].effect == "AddRandomSkill" then
        extraSkill = extraSkill + weaponBreakEffect[i].addVal
      end
      if lastBkLv < i - 1 and weaponBreakEffect[i].effect == "UpMainSkill" then
        mainSkillUp = true
      end
    end
    if i <= lastBkLv then
      lastLv = lastLv + weaponBreakEffect[i].lvCapBreak
      if weaponBreakEffect[i].effect == "MainAttrUp" then
        lastAttr = lastAttr + weaponBreakEffect[i].addVal
      end
      if weaponBreakEffect[i].effect == "AddRandomSkill" then
        lastSkill = lastSkill + weaponBreakEffect[i].addVal
      end
    end
  end
  local propertyList = PlayerData:GetRoleEquipProperty(equipCA, lv)
  local pro = {}
  for k, v in pairs(propertyList) do
    if v.num ~= 0 then
      pro = v
    end
  end
  local lastNum = PlayerData:GetPreciseDecimalFloor(pro.num * (1 + lastAttr))
  local curNum = PlayerData:GetPreciseDecimalFloor(pro.num * (1 + extraAttr))
  return pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp
end

return PlayerData
