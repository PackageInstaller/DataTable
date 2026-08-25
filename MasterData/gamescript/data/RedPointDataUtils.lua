local SummonPoolType = CommonDefine.SummonPoolType
local Vue = require("Vue.Vue")
local RedPointDataUtils = {}
RedPointDataUtils.RedAttrType = {
  Red = "red",
  IsNew = "isNew",
  Num = "num"
}
RedPointDataUtils.RedAttrTypeLv = {
  RedPointDataUtils.RedAttrType.IsNew,
  RedPointDataUtils.RedAttrType.Num,
  RedPointDataUtils.RedAttrType.Red
}
RedPointDataUtils.RedType = {
  Awaker = "awaker",
  AwakerPotency = "AwakerPotency",
  AwakerLevel = "AwakerLevel",
  AwakerBreakthrough = "AwakerBreakthrough",
  AwakerSkill = "AwakerSkill",
  AwakerTrinket = "AwakerTrinket",
  AwakerNew = "AwakerNew",
  AwakerSpecialSkill = "AwakerSpecialSkill",
  MoneyDungeonsAward = "red_moneycollect",
  SummonNormalOne = "red_drawcard_one",
  SummonUpPoolRed = "red_new_drawcard_up",
  ArenaAward = "red_arenacollect",
  MoneyDungeonsNew = "red_open_moneylevel",
  ArenaNew = "red_open_arena",
  ResCopyNew = "red_open_rescopy",
  TrinketCopyNew = "red_open_trinketcopy",
  MainShop = "MainShop",
  TrinketCopy = "red_open_trinketcopy_stage",
  Task = "task",
  Technology = "red_technology",
  BuildingPrize = "red_build_prize",
  Item = "Item",
  DailyCopyNew = "DailyCopyNew",
  WeekCopyNew = "red_weekchallenge_new",
  Mail = "red_mail",
  TreasureMail = "red_collect_mail",
  ComposeNew = "ComposeNew",
  DecomposeNew = "DecomposeNew",
  RecastNew = "RecastNew",
  ExchangeNew = "ExchangeNew",
  MainStageGetAward = "red_stage_group_star",
  AchivementCanGain = "AchivementCanGain",
  NewStageUnlock = "new_stage_unlock",
  NewStageGroupUnlock = "new_stage_group_unlock",
  NewVoice = "NewVoice",
  NewStory = "NewStory",
  MainStageResonance = "red_resonance_upgrade",
  BattlePass = "BattlePass",
  ItemConversion = "ItemConversion",
  WeekBossChallenge = "WeekBossChallenge",
  DailyChallengeWeekReward = "red_daily_challenge_week_prize",
  DailyChallengeWeekAchieveReward = "red_daily_challenge_exp_prize",
  MonthCardExpire = "MonthCardExpire",
  PVPRankReward = "PvpRankReward",
  Tutorial = "Tutorial",
  EnergyCardExpire = "EnergyCardExpire",
  DrawCardChooseCareer = "DrawCardChooseCareer",
  AlternationSchoolTower = "AlternationSchoolTower",
  MockCopy = "MockCopy",
  Shop = "Shop",
  AbyssChallengeScorePrize = "AbyssChallengeScorePrize",
  AbyssChallenge = "AbyssChallenge",
  NewLotteryOpen = "NewLotteryOpen",
  EmojiNew = "EmojiNew",
  AwakerFreeTrial = "AwakerFreeTrial",
  Collection = "Collection",
  InvitationCode = "InvitationCode"
}

function RedPointDataUtils.AddRedpointDataByServerNotice(dat)
  if not dat then
    return
  end
  if dat.Shop then
    dat.Shop[cd.PVPShopID] = nil
  end
  local redPointData = DataCenter.redPointData
  for redType, v in pairs(dat) do
    local curData = redPointData[redType]
    if not curData then
      redPointData[redType] = {}
      curData = redPointData[redType]
    end
    for tid, redList in pairs(v) do
      local showNew = true
      if type(tid) == "string" then
        curData[tid] = redList
      elseif 0 == tid then
        table.mergeTable(curData, redList)
      else
        if not curData[tid] or not curData[tid].isNew then
          if redType == RedPointDataUtils.RedType.Item then
            showNew = false
          end
          curData[tid] = {}
        end
        table.mergeTable(curData[tid], redList)
      end
      if redType == RedPointDataUtils.RedType.Awaker then
        local AwakerDataUtils = require("Data.AwakerDataUtils")
        if AwakerDataUtils.HasOwnedAwaker(tid) then
          RedPointDataUtils.UpdateAwakerRed(AwakerDataUtils.GetAwakerData(tid))
        end
      end
      if redType == RedPointDataUtils.RedType.Item then
        local itemData = ItemDataUtils.GetItemByUid(tid)
        if itemData and (ItemDataUtils.IsMaterialItem(itemData.tid) or ItemDataUtils.IsBagSpecialItem(itemData.tid)) then
          local num = ItemDataUtils.GetItemNum(itemData.tid) or 0
          if not showNew and num > 1 then
            RedPointDataUtils.ReqRemoveItemNew(tid)
          end
        end
      end
    end
    if redType == RedPointDataUtils.RedType.Item then
      RedPointDataUtils.UpdateEmojiNew()
    end
  end
  SocialRedUtils.UpdateAvatarRed()
end

function RedPointDataUtils.ReqRemoveData(redType, attrType, tid)
  if tid and tid > 0 then
    if DataCenter.redPointData[redType] and DataCenter.redPointData[redType][tid] and DataCenter.redPointData[redType][tid][attrType] then
      RedDotController.Instance:OnRemoveRedPoint(redType, tid, attrType)
      RedPointDataUtils.RemoveData(redType, tid, attrType)
    end
  elseif DataCenter.redPointData[redType] and DataCenter.redPointData[redType][attrType] then
    RedDotController.Instance:OnRemoveRedPoint(redType, 0, attrType)
    RedPointDataUtils.RemoveData(redType, nil, attrType)
  end
end

function RedPointDataUtils.ReqRemoveItemNew(uid)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
end

function RedPointDataUtils.SetRedData(redType, subKey, value)
  local curData = DataCenter.redPointData[redType]
  if not curData then
    curData = {}
    DataCenter.redPointData[redType] = curData
  end
  curData[subKey] = value
end

function RedPointDataUtils.RemoveData(redType, tid, attrType)
  if tid and tid > 0 then
    local curData = DataCenter.redPointData[redType]
    if curData and curData[tid] then
      if not attrType then
        curData[tid] = nil
      else
        curData[tid][attrType] = nil
        if not next(curData[tid]) then
          curData[tid] = nil
        end
      end
    end
  elseif not attrType then
    DataCenter.redPointData[redType] = nil
  else
    DataCenter.redPointData[redType][attrType] = nil
  end
  GlobalDispatcher:Dispatch(NotifyId.OnRemoveRedData, redType, tid, attrType)
end

function RedPointDataUtils.AddSpecialSkillRedData(awakerTid, specialSkillTid)
  if not awakerTid or not specialSkillTid then
    return
  end
  local redData = DataCenter.redPointData
  local redType = RedPointDataUtils.RedType.AwakerSpecialSkill
  if not redData[redType] then
    redData[redType] = {}
  end
  if not redData[redType][specialSkillTid] then
    redData[redType][specialSkillTid] = {}
  end
  local red = {isNew = 1}
  redData[redType][specialSkillTid][awakerTid] = red
  local specialSkillData = {tid = specialSkillTid, awaker = awakerTid}
  RedPointDataUtils.SetSpecialSkillLocalRed({specialSkillData}, true)
end

local function _ParseSpecialSkillLocalRedString(str)
  if not str then
    return
  end
  local spSkillGroupStrs = string.split(str, "|")
  if not spSkillGroupStrs then
    return
  end
  local redMap = {}
  for i = 1, #spSkillGroupStrs do
    local groupStr = spSkillGroupStrs[i]
    if "" == groupStr then
    else
      local strArr = string.split(groupStr, ":")
      if strArr and #strArr > 1 then
        local spSkillTid = strArr[1] and tonumber(strArr[1])
        if strArr[2] then
          local tids = string.split(strArr[2], ",")
          if tids and #tids > 0 then
            for j = 1, #tids do
              local awakerTid = tids[j] and tonumber(tids[j])
              if awakerTid then
                if not redMap[spSkillTid] then
                  redMap[spSkillTid] = {}
                end
                table.insert(redMap[spSkillTid], awakerTid)
              end
            end
          end
        end
      end
    end
  end
  return redMap
end

local function _WriteSpecialSkillLocalRedString(redTable)
  if not redTable then
    return ""
  end
  local value = ""
  for spSkillTid, awakerTidList in pairs(redTable) do
    if awakerTidList and #awakerTidList > 0 then
      if "" ~= value then
        value = value .. "|"
      end
      value = value .. spSkillTid .. ":"
      for index, tid in ipairs(awakerTidList) do
        value = value .. tid
        if index < #awakerTidList then
          value = value .. ","
        end
      end
    end
  end
  if "" ~= value then
    value = value .. "|"
  end
  return value
end

function RedPointDataUtils.SetSpecialSkillLocalRed(specialSkillDataList, state)
  if not specialSkillDataList or #specialSkillDataList <= 0 then
    return
  end
  local redType = RedPointDataUtils.RedType.AwakerSpecialSkill
  local key = cd.LocalSaveKey.RedPoint .. "_" .. redType
  local localValue = MobileFileDataManager.Instance:GetPlayerFileValue(key)
  local redTable = {}
  if localValue then
    redTable = _ParseSpecialSkillLocalRedString(localValue)
  end
  for _, data in pairs(specialSkillDataList) do
    if not data then
    elseif state then
      if not redTable[data.tid] then
        redTable[data.tid] = {
          data.awaker
        }
      elseif not table.contains(redTable[data.tid], data.awaker) then
        table.insert(redTable[data.tid], data.awaker)
      end
    elseif not redTable[data.tid] then
    else
      for k, v in pairs(redTable[data.tid]) do
        if v == data.awaker then
          redTable[data.tid][k] = nil
          break
        end
      end
    end
  end
  local value = _WriteSpecialSkillLocalRedString(redTable)
  MobileFileDataManager.Instance:SetPlayerFileValue(key, value)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function RedPointDataUtils.InitSpecialSkillRedByLocalData()
  local redType = RedPointDataUtils.RedType.AwakerSpecialSkill
  local key = cd.LocalSaveKey.RedPoint .. "_" .. redType
  local localValue = MobileFileDataManager.Instance:GetPlayerFileValue(key)
  local redTable = {}
  if localValue then
    redTable = _ParseSpecialSkillLocalRedString(localValue)
  end
  local redData = DataCenter.redPointData
  if not redData[redType] then
    redData[redType] = {}
  end
  local red = {isNew = 1}
  for spSkillTid, awakerTidList in pairs(redTable) do
    if spSkillTid and awakerTidList and #awakerTidList > 0 then
      for _, awakerTid in ipairs(awakerTidList) do
        if awakerTid then
          if not redData[redType][spSkillTid] then
            redData[redType][spSkillTid] = {}
          end
          redData[redType][spSkillTid][awakerTid] = red
        end
      end
    end
  end
end

function RedPointDataUtils.IsShowStageGroupAchievementReward(stageGroupId)
  local MainCopyDataUtils = require("Data.MainCopyDataUtils")
  for _, stageData in ipairs(MainCopyDataUtils.GetStageList(stageGroupId)) do
    if not stageData.achivement or not table.next(stageData.achivement) then
    else
      for stageId, achieveState in pairs(stageData.achivement) do
        if achieveState == cd.MainCopyAchieveState.IsFinish then
          return RedPointDataUtils.RedAttrType.Red
        end
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowSpecialSkillNew()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.AwakerSpecialSkill)
  return ret
end

function RedPointDataUtils.GetRedData(redType)
  return DataCenter.redPointData[redType]
end

function RedPointDataUtils.GetRedDataByTid(redType, tid)
  local d = RedPointDataUtils.GetRedData(redType)
  if d then
    return d[tid]
  end
end

function RedPointDataUtils.GetSchoolKeeperRedPoint(schoolId)
  local skillTidList = KeeperSkillUtils.GetSortedSkillList()
  for i = #skillTidList, 1, -1 do
    local itemId = KeeperSkillUtils.GetItemIdBySkill(skillTidList[i])
    if ItemDataUtils.GetItemNum(itemId) > 0 and (not KeeperSkillDefine.ToggleList[schoolId].classify or DT.Item[itemId].ClassificationParam and DT.Item[itemId].ClassificationParam[1] == KeeperSkillDefine.ToggleList[schoolId].classify) then
      local tmpRed = RedPointDataUtils.GetKeeperRedPoint(itemId)
      if tmpRed then
        return tmpRed
      end
    end
  end
  return false
end

function RedPointDataUtils.GetKeeperRedPoint(keeperSkillItemId)
  local redType = RedPointDataUtils.RedType.Item
  local data = RedPointDataUtils.GetRedData(redType) or {}
  local itemMap
  if keeperSkillItemId then
    itemMap = {
      [keeperSkillItemId] = true
    }
  else
    itemMap = DataCenter.itemData.Item2KeeperSkill
  end
  for itemId, _ in pairs(itemMap) do
    local uidMap = ItemDataUtils.GetItemUidMap(itemId)
    if KeeperSkillUtils.CheckSkillItemIsPvpOnly(itemId) then
    else
      for uid, _ in pairs(uidMap or {}) do
        if data[uid] and data[uid].isNew then
          return true
        end
      end
    end
  end
end

function RedPointDataUtils.HasAwakerAffectionRedShow(awakerId)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return false
  end
  for _, state in pairs(awaker.likeReward) do
    if state == cd.AffectionRewardState.CanGain then
      return true
    end
  end
  return false
end

function RedPointDataUtils.IsAwakerAffectionBreakthroughRedShow(awakerId, lv)
  local breakthroughLv = AwakerFavorabilityCfgUtils.GetBreakthroughLevel(awakerId)
  local maxLv = AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(awakerId)
  if breakthroughLv >= maxLv then
    return false
  end
  local seenLevel = ClientDataUtils.GetData("AwakerAffectionBreakthroughSeen", awakerId, 0)
  if breakthroughLv < seenLevel then
    return false
  end
  if lv then
    local canBreak = AwakerFavorabilityCfgUtils.HasBreakoutCost(awakerId, lv) and AwakerFavorabilityCfgUtils.IsLikeExpFull(awakerId) and AwakerFavorabilityCfgUtils.CanBreakthrough(awakerId, lv)
    if not canBreak then
      return false
    end
    do return AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems, awakerId end
    return AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems, awakerId, lv
  end
  local likeLevel = AwakerFavorabilityCfgUtils.GetAwkerLikeLevel(awakerId)
  if breakthroughLv > likeLevel then
    return false
  end
  local enoughItems = AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems(awakerId, breakthroughLv + 1)
  return enoughItems
end

function RedPointDataUtils.MarkAwakerAffectionBreakthroughSeen(awakerId)
  local nextBreakthroughLv = AwakerFavorabilityCfgUtils.GetBreakthroughLevel(awakerId) + 1
  ClientDataUtils.SetData("AwakerAffectionBreakthroughSeen", awakerId, nextBreakthroughLv)
end

function RedPointDataUtils.CanUnlock_OriAwaker(awakerId)
  local hasAwaker = AwakerDataUtils.HasOwnedAwaker(awakerId)
  if not hasAwaker then
    return false
  end
  if AwakerDataUtils.IsUnlockedOriginType(awakerId) then
    return false
  end
  local awakerCfg = DT.AwakerConfig[awakerId]
  local unlockItemList = awakerCfg.UnlockOriginalFormItem
  if unlockItemList then
    for i = 1, #unlockItemList, 2 do
      local itemId = unlockItemList[i]
      local costCnt = unlockItemList[i + 1]
      local hasNum = ItemDataUtils.GetItemNum(itemId)
      if costCnt > hasNum then
        return false
      end
    end
    return true
  else
    return false
  end
end

function RedPointDataUtils.IsAwakerAffectionRedShow(awakerId, lv)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return false
  end
  local state = awaker.likeReward[lv]
  if not state then
    return false
  end
  local canGet = state == cd.AffectionRewardState.CanGain
  local unlock = lv <= awaker.likeLevel
  return unlock and canGet
end

function RedPointDataUtils.IsShowAwakerTalentRed(awakerTid)
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return false
  end
  if AwakerDataUtils.IsMocking() then
    return false
  end
  local allTalentCfgList = AwakerTalentExtModel.Instance:GetTalentCfgList(awakerTid)
  for _, talentCfg in ipairs(allTalentCfgList) do
    local talentTid = talentCfg.ID
    if RedPointDataUtils.IsShowTalentRed(talentTid) then
      return true
    end
  end
end

function RedPointDataUtils.GetActivityKarenRewardEntryRed()
  local activityData = ActivityManager.Instance:GetActivityDataByType(ActivityDefine.ActivityType.GoldenWeekActivity)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) ~= TaskDefine.CompleteCond.ActivityStatCount then
    else
      local taskData = TaskDataUtils.GetTaskData(tid)
      if taskData.state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  end
  return false
end

local KarenTaskCompleteTypeList = {
  TaskDefine.CompleteCond.TaskLoginDays,
  TaskDefine.CompleteCond.ActivityStatCount
}

function RedPointDataUtils.GetActivityKarenTaskEntryRed()
  local activityData = ActivityManager.Instance:GetActivityDataByType(ActivityDefine.ActivityType.GoldenWeekActivity)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    if table.contains(KarenTaskCompleteTypeList, TaskCfgUtils.GetCfgField("CompleteCond", tid)) then
    else
      local taskData = TaskDataUtils.GetTaskData(tid)
      if taskData.state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.GetActivityKarenSignEntryRed()
  do return RedPointDataUtils._GetActivitySignEntryRed end
  return RedPointDataUtils._GetActivitySignEntryRed, ActivityDefine.ActivityType.GoldenWeekActivity
end

function RedPointDataUtils.GetSummerChapter1SignEntryRed()
  do return RedPointDataUtils._GetActivitySignEntryRed end
  return RedPointDataUtils._GetActivitySignEntryRed, ActivityDefine.ActivityType.SummerChapter1Activity
end

function RedPointDataUtils._GetActivitySignEntryRed(activityType)
  local activityData = ActivityManager.Instance:GetActivityDataByType(activityType)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) ~= TaskDefine.CompleteCond.TaskLoginDays then
    else
      local taskData = TaskDataUtils.GetTaskData(tid)
      if taskData.state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.GetSecondAnniversarySignEntryRed()
  local activityData = ActivityManager.Instance:GetActivityDataByType(ActivityDefine.ActivityType.SecondAnniversarySign)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) ~= TaskDefine.CompleteCond.TaskLoginDays or not TaskCfgUtils.GetCfgField("BelongTaskGroup", tid) then
    else
      local taskData = TaskDataUtils.GetTaskData(tid)
      if taskData.state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowTalentRed(talentTid)
  local talentCfg = AwakerTalentExtModel.Instance:GetTalentCfg(talentTid)
  local awakerTid = talentCfg.AwakerID
  if not awakerTid or not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return false
  end
  if AwakerDataUtils.IsMocking() then
    return false
  end
  local requireItems = AwakerTalentExtModel.Instance:GetTalentUpdateItems(talentTid)
  if not AwakerTalentExtModel.Instance:IsUnlocked(talentTid) then
    return false
  end
  do return RedPointDataUtils.IsItemEnoughRedShow end
  return RedPointDataUtils.IsItemEnoughRedShow, requireItems, talentTid
end

function RedPointDataUtils.IsItemEnoughRedShow(itemList)
  itemList = itemList or {}
  local isShowRed = #itemList > 0
  for itemTid, needNum in table.iteraDouble(itemList) do
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    if needNum > ownNum then
      isShowRed = ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(itemList, true)
      break
    end
  end
  return isShowRed
end

function RedPointDataUtils.ShowRedPointState(dat)
  if type(dat) ~= "table" then
    return
  end
  for _, attrType in ipairs(RedPointDataUtils.RedAttrTypeLv) do
    if dat[attrType] and dat[attrType] > 0 then
      if attrType == RedPointDataUtils.RedAttrType.Num then
        return dat[attrType]
      else
        return attrType
      end
    end
  end
  local state = {}
  for _, v in pairs(dat) do
    local ret = RedPointDataUtils.ShowRedPointState(v)
    if ret then
      if type(ret) == "number" then
        state[RedPointDataUtils.RedAttrType.Num] = ret
      else
        state[ret] = 1
        if ret == RedPointDataUtils.RedAttrTypeLv[1] then
          return ret
        end
      end
    end
  end
  for _, attrType in ipairs(RedPointDataUtils.RedAttrTypeLv) do
    if state[attrType] and state[attrType] > 0 then
      if attrType == RedPointDataUtils.RedAttrType.Num then
        return state[attrType]
      else
        return attrType
      end
    end
  end
  return
end

function RedPointDataUtils.FixRedPointStateResult(redType, oriData)
  if nil == oriData then
    return
  end
  if redType == RedPointDataUtils.RedType.Shop then
    local data = table.deepclone(oriData)
    local rechargeKey = MainShopDataUtils.GetShopRealType(cd.MainShopTypeTag.Recharge)
    if data[rechargeKey] then
      data[rechargeKey].isNew = 0
    end
    local passKey = MainShopDataUtils.GetShopRealType(cd.MainShopTypeTag.BattlePassReview)
    if data[passKey] then
      data[passKey].isNew = 0
    end
    for shopKey, _ in pairs(data) do
      local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Shop, shopKey)
      if not unlocked then
        data[shopKey].isNew = 0
      end
    end
    oriData = data
  elseif redType == RedPointDataUtils.RedType.Collection then
    local data = table.deepclone(oriData)
    local serverTime = TimeUtils.GetServerTime()
    for collectId, redData in pairs(data) do
      local cfg = DT.CollectionHall[collectId]
      if cfg then
        local featureCfgId = cfg.CollectionType
        local featureCfg = DT.FeatureUnlock[featureCfgId]
        local featureType = featureCfg.Feature
        local key = featureCfg.Key or PlayerDataUtils.GetFeatureMainTypeKey()
        local _, unlocked = PlayerDataUtils.IsFeatureUnlock(featureType, key)
        if not unlocked then
          redData.isNew = 0
        end
        if cfg.CollectionDisplayDate and serverTime < cfg.CollectionDisplayDate then
          redData.isNew = 0
        end
      end
    end
    oriData = data
  end
  return oriData
end

function RedPointDataUtils.GetRedPointState(redType, args)
  if RedPointDataUtils.IsBanRedPoint(redType) then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(redType)
  local fixData = RedPointDataUtils.FixRedPointStateResult(redType, dat)
  local redStatus = RedPointDataUtils.GetRedPointStateByRedData(fixData, args)
  return redStatus
end

function RedPointDataUtils.GetRedPointStateByRedData(dat, args)
  if not dat or not table.next(dat) then
    return false
  end
  if args then
    for _, arg in ipairs(args) do
      if not dat[arg] then
        return false
      end
      dat = dat[arg]
    end
    local ret = RedPointDataUtils.ShowRedPointState(dat)
    return ret
  else
    do return RedPointDataUtils.ShowRedPointState end
    return RedPointDataUtils.ShowRedPointState, dat, ipairs(args)
  end
end

function RedPointDataUtils.GetMainHeadRed()
  local SocialSubType = RedTypeDefine.SocialSubType
  local ret = SocialRedUtils.GetSocialRed({
    SocialSubType.Avatar
  }) or SocialRedUtils.GetSocialRed({
    SocialSubType.AvatarFrame
  })
  if ret then
    return ret
  end
  ret = SocialRedUtils.GetSocialRed({
    SocialSubType.AssistReward
  })
  return ret
end

function RedPointDataUtils.GetSocialRed()
  local SocialSubType = RedTypeDefine.SocialSubType
  local inviteRed = RedPointDataUtils.IsShowSocialInviteRed()
  if inviteRed then
    return inviteRed
  end
  local communityRed = RedPointDataUtils.GetCommunityRed()
  if communityRed then
    return communityRed
  end
  do return SocialRedUtils.GetSocialRed end
  return SocialRedUtils.GetSocialRed, {
    SocialSubType.NewFans
  }, SocialSubType.NewFans
end

function RedPointDataUtils.ShowMainAwaker()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.Awaker)
  if nil == ret then
    local AwakerDataUtils = require("Data.AwakerDataUtils")
    local list = AwakerDataUtils.GetOwnedAwakerList()
    for _, awaker in ipairs(list) do
      local awakerTid = awaker.tid
      local breakthroughRedData = AwakerRedUtils.GetBreakthroughRedData(awakerTid)
      if breakthroughRedData and breakthroughRedData.red and breakthroughRedData.red >= 1 then
        return RedPointDataUtils.ShowRedPointState(breakthroughRedData)
      end
      local isChargeFormHasNewSkin = false
      local chargeForm = AwakerDataUtils.GetChangerForm(awakerTid)
      if 0 ~= chargeForm and AwakerSkinUtils.IsAwakerHasNewSkin(chargeForm) then
        isChargeFormHasNewSkin = true
      end
      if AwakerSkinUtils.IsAwakerHasNewSkin(awakerTid) or isChargeFormHasNewSkin then
        ret = RedPointDataUtils.RedAttrType.IsNew
        break
      end
      if RedPointDataUtils.HasAwakerAffectionRedShow(awakerTid) then
        ret = "red"
        break
      end
    end
  end
  return ret
end

function RedPointDataUtils.IsHasNewAwakerSkins()
  for tid, awakerData in pairs(DataCenter.awakerData.awakerMap) do
    if 0 == awakerData.show and AwakerSkinUtils.IsAwakerHasNewSkin(tid) then
      return true
    end
  end
  return false
end

function RedPointDataUtils.IsBanRedPoint(redType)
  return redType == RedPointDataUtils.RedType.AwakerLevel and SettingManager.Instance:GetBoolSettingData(cd.SettingUniqueName.AwakerLevelUpConfirm)
end

function RedPointDataUtils.BeginPoolRedFunc(poolId)
  if not poolId then
    return false
  end
  local SummonDataUtils = require("Data.SummonDataUtils")
  if SummonDataUtils.GetBeginPoolIsFree(poolId) then
    return RedPointDataUtils.RedAttrType.Red
  end
  local costItemId, costItemNum = SummonDataUtils.Get10TimesPrice(poolId)
  local ownedNum = ItemDataUtils.GetItemNum(costItemId)
  if costItemNum <= ownedNum then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

local UnShowNewPools = {
  cd.SummonPoolType.NormalWeapon,
  cd.SummonPoolType.NormalAwaker
}

function RedPointDataUtils.IsShowSummonIsNew(poolIds)
  if not poolIds or type(poolIds) ~= "table" or 0 == #poolIds then
    return false
  end
  local sendPools = {}
  for _, poolId in pairs(poolIds) do
    local cfg = DT.Summon[poolId]
    if not table.contains(UnShowNewPools, cfg.Type) then
      table.insert(sendPools, poolId)
    end
  end
  if 0 == #sendPools then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.SummonUpPoolRed)
  local rst = false
  for _, checkPoolId in pairs(sendPools) do
    if dat[checkPoolId] and dat[checkPoolId].isNew and dat[checkPoolId].isNew >= 1 then
      rst = RedPointDataUtils.RedAttrType.IsNew
      break
    end
  end
  return rst
end

function RedPointDataUtils.CheckSummonRed(poolId)
  local redReturnGroup = {}
  local rst = RedPointDataUtils.IsShowSummonIsNew({poolId})
  if rst then
    table.insert(redReturnGroup, rst)
  end
  rst = RedPointDataUtils.IsShowNormalWeaponPoolTargetedRed(poolId)
  if rst then
    table.insert(redReturnGroup, rst)
  end
  rst = RedPointDataUtils.IsShowPoolCurrencyEnough(poolId)
  if rst then
    table.insert(redReturnGroup, rst)
  end
  local summonPoolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if summonPoolCfg and summonPoolCfg.SummonTask and TaskDataUtils.IsCanGetRward(summonPoolCfg.SummonTask) then
    table.insert(redReturnGroup, RedPointDataUtils.RedAttrType.Red)
  end
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, RedPointDataUtils.RedAttrType.Red
end

function RedPointDataUtils.IsShowPoolsCurrencyEnough()
  local rst = false
  for tid, _ in pairs(DataCenter.summonData.summonPoolData) do
    rst = RedPointDataUtils.IsShowPoolCurrencyEnough(tid)
    if rst then
      break
    end
  end
  return rst
end

function RedPointDataUtils.IsShowPoolCurrencyEnough(poolId)
  if SummonDataUtils.IsSummonPoolHaveFree(poolId) > 0 then
    return RedPointDataUtils.RedAttrType.Red
  end
  local cfg = DT.Summon[poolId]
  if cfg.Type == CommonDefine.SummonPoolType.TripleLuckyBag and SummonCfgUtils.IsPoolTentimesCurrencyEnough(poolId) then
    return RedPointDataUtils.RedAttrType.Red
  end
  local isLevelOverLimit = PlayerDataUtils.GetLevel() >= DT.GetConstant("ReddotAccountLvLimit")
  if isLevelOverLimit then
    return false
  end
  if table.contains(DT.GetOriginalConstant("ReddotSummonType"), cfg.Type) and SummonCfgUtils.IsPoolTentimesCurrencyEnough(poolId) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function RedPointDataUtils.IsShowNormalWeaponPoolTargetedRed(poolId)
  if not SummonDataUtils.CheckPoolType(poolId, SummonPoolType.NormalWeapon) then
    return false
  end
  return not SummonDataUtils.GetChooseUpMapByType(SummonPoolType.NormalWeapon) and RedPointDataUtils.RedAttrType.Red or false
end

function RedPointDataUtils.IsShowSummonRecommend()
  local redDataGroup = {}
  for _, poolData in pairs(SummonDataUtils.GetSortedPoolList()) do
    table.insert(redDataGroup, RedPointDataUtils.GetRedPointState(SummonDataUtils.GetRedTypeByPoolId(poolData.tid)))
  end
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redDataGroup, pairs(SummonDataUtils.GetSortedPoolList())
end

function RedPointDataUtils.IsShowSummon()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DrawCard, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local sendPools = {}
  local redReturnGroup = {}
  for _, poolData in pairs(SummonDataUtils.GetSortedPoolList()) do
    table.insert(sendPools, poolData.tid)
    local red = RedPointDataUtils.CheckSummonRed(poolData.tid)
    if red then
      table.insert(redReturnGroup, red)
    end
  end
  local ret = RedPointDataUtils.PickHighWeightRedData(redReturnGroup)
  if ret then
    return ret
  end
  ret = RedPointDataUtils.IsShowPoolsCurrencyEnough()
  if ret then
    return ret
  end
  for _, poolTid in pairs(sendPools) do
    ret = RedPointDataUtils.IsShowNormalWeaponPoolTargetedRed(poolTid)
    if ret then
      return ret
    end
  end
  return ret
end

function RedPointDataUtils.IsShowArena()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ArenaNew)
  ret = ret or RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ArenaAward)
  return ret
end

function RedPointDataUtils.IsShowArenaNew()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ArenaNew)
  return ret
end

function RedPointDataUtils.IsShowMock()
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MockCopy
end

function RedPointDataUtils.IsShowSchoolTowerNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AlternationSchoolTower, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.AlternationSchoolTower)
  if dat and dat.isNew then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  local redReturnGroup = {}
  table.insert(redReturnGroup, RedPointDataUtils.IsShowSchoolTowerByStageGroupType(cd.StageGroupType.AlternationSchoolTower))
  table.insert(redReturnGroup, RedPointDataUtils.IsShowSchoolTowerByStageGroupType(cd.StageGroupType.DisposableSchoolTower))
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, RedPointDataUtils.IsShowSchoolTowerByStageGroupType(cd.StageGroupType.DisposableSchoolTower)
end

function RedPointDataUtils.IsShowAbyssScorePrize()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AbyssChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.AbyssChallengeScorePrize
end

function RedPointDataUtils.IsShowAbyssRed()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AbyssChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.AbyssChallenge)
  if dat and dat.isNew then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  do return end
  return RedPointDataUtils.IsShowAbyssScorePrize
end

function RedPointDataUtils.IsShowSchoolTowerByStageGroupType(stageGroupType)
  local SchoolTowerDataUtils = require("Data.SchoolTowerDataUtils")
  local redReturnGroup = {}
  local disposableTowerIds = SchoolTowerDataUtils.GetTowerStageGroupIdByType(stageGroupType)
  if 0 == #disposableTowerIds then
    table.insert(redReturnGroup, false)
  else
    for _, id in pairs(disposableTowerIds) do
      table.insert(redReturnGroup, RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MainStageGetAward, {id}))
    end
  end
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, pairs(disposableTowerIds)
end

function RedPointDataUtils.PickHighWeightRedData(redReturnGroup)
  for _, data in pairs(redReturnGroup) do
    if data == RedPointDataUtils.RedAttrType.IsNew then
      return data
    end
  end
  for _, data in pairs(redReturnGroup) do
    if data == RedPointDataUtils.RedAttrType.Red then
      return data
    end
  end
  return false
end

function RedPointDataUtils.IsShowWeekCopyNew(stageTid)
  local args = stageTid and {stageTid}
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.WeekCopyNew, args)
  return ret
end

function RedPointDataUtils.IsShowWeekBossNew(stageGroupId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.WeekBossChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local args = stageGroupId and {stageGroupId}
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.WeekBossChallenge, args)
  if not stageGroupId and not ret then
    ret = RedPointDataUtils.IsTaskListRedByConstKey("WeekBossChallengePerfectRewardTaskGroup")
  end
  return ret
end

function RedPointDataUtils.IsShowDailyChallengeWeekRewardNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.DailyChallengeWeekReward
end

function RedPointDataUtils.IsShowDailyChallengeWeekAchieveRewardNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.DailyChallengeWeekAchieveReward
end

function RedPointDataUtils.IsMonthCardExpire()
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MonthCardExpire
end

function RedPointDataUtils.IsShowPVPRankReward()
  local red1 = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.PVPRankReward)
  return red1
end

function RedPointDataUtils.IsPVPChallengeTaskReward()
  do return TaskDataUtils.IsTaskTypeHaveReceiveState end
  return TaskDataUtils.IsTaskTypeHaveReceiveState, cd.TaskType.TaskType_PVPRewardTask
end

function RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(gameplayType)
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  if not seasonId or 0 == seasonId then
    return false
  end
  local taskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  if not taskTid or 0 == taskTid then
    return false
  end
  do return TaskDataUtils.IsTaskCanReward end
  return TaskDataUtils.IsTaskCanReward, taskTid
end

function RedPointDataUtils.IsPvpSeasonRotationTaskRewardAvailable()
  local sgt = CommonDefine.SeasonGameplayType
  return RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(sgt.PvpPreBuilt) or RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(sgt.PvpDraft)
end

function RedPointDataUtils.IsRailWayTaskCanReceive()
  do return TaskDataUtils.IsTaskTypeHaveReceiveState end
  return TaskDataUtils.IsTaskTypeHaveReceiveState, cd.TaskType.TaskType_RailWay
end

function RedPointDataUtils.IsRailWayEntryRed()
  local stageGroupTid = DT.GetOriginalConstant("RailWayStageGroupTid")
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupTid)
  if RedPointDataUtils.IsShowCareerLevelReward(CareerLevelDefine.CareerLevelType.RailWay) or RedPointDataUtils.IsRailWayTaskCanReceive() or RedPointDataUtils.IsMainStageResonanceShow(resonanceGroupId) or RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(CommonDefine.SeasonGameplayType.ConsciousnessRailway) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function RedPointDataUtils.IsShowCareerLevelReward(careerLevelType)
  do return CareerLevelModel.Instance.IsCareerCanReceive, CareerLevelModel.Instance end
  return CareerLevelModel.Instance.IsCareerCanReceive, CareerLevelModel.Instance, careerLevelType
end

function RedPointDataUtils.UpdateEmojiNew()
  if not DataCenter.redPointData or not DataCenter.redPointData[RedPointDataUtils.RedType.Item] then
    return
  end
  local RedType = RedPointDataUtils.RedType
  local itemRedData = DataCenter.redPointData[RedPointDataUtils.RedType.Item]
  if not itemRedData then
    return
  end
  local emojiRedData = DataCenter.redPointData[RedType.EmojiNew]
  if not emojiRedData then
    emojiRedData = {}
    DataCenter.redPointData[RedType.EmojiNew] = emojiRedData
  end
  for uid, redData in pairs(itemRedData) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData and ItemDataUtils.IsEmojiItem(itemData.tid) then
      emojiRedData[uid] = redData
    end
  end
end

function RedPointDataUtils.IsPVPEmojiNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.PVP, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local RedType = RedPointDataUtils.RedType
  local emojiRedData = DataCenter.redPointData[RedType.EmojiNew]
  if not emojiRedData then
    return false
  end
  for uid, singleRedData in pairs(emojiRedData) do
    if singleRedData.isNew and singleRedData.isNew >= 1 then
      print("--------------is pvp emoji new is new")
      return RedPointDataUtils.RedAttrType.IsNew
    end
  end
  return false
end

function RedPointDataUtils.IsEmojiNew(uid)
  local RedType = RedPointDataUtils.RedType
  local emojiRedData = DataCenter.redPointData[RedType.EmojiNew]
  if not emojiRedData then
    return false
  end
  local singleRedData = emojiRedData[uid]
  if singleRedData and singleRedData.isNew and singleRedData.isNew >= 1 then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  return false
end

function RedPointDataUtils.IsGiftBagRefresh()
  if RedPointDataUtils.IsShowEnergyCardRed() then
    do return end
    return RedPointDataUtils.IsShowEnergyCardRed, nil, nil, nil
  end
  local shopKey = MainShopDataUtils.GetShopRealType(cd.MainShopTypeTag.GiftBag)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Shop, shopKey)
  if not unlocked then
    return false
  end
  do return end
  return RedPointDataUtils.GetFirstClearShopListRed
end

function RedPointDataUtils.IsShowEnergyCardRed()
  local conditionLevel = DT.GetConstant("EnergyMonthlyCardDisplayConditions") or 0
  if conditionLevel > DataCenter.playerData.DRole.level then
    return false
  end
  local energyMonthCardRedData = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.EnergyCardExpire)
  if energyMonthCardRedData and energyMonthCardRedData[RedPointDataUtils.RedAttrType.IsNew] then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  return false
end

function RedPointDataUtils.IsShowClientRed(mainKey, subKey, redType)
  local isFirstOpen = ClientDataUtils.GetData(mainKey, subKey, CommonDefine.NumberTrue)
  if isFirstOpen == CommonDefine.NumberTrue then
    return redType
  end
  return false
end

function RedPointDataUtils.ClearClientRed(mainKey, subKey)
  local data = ClientDataUtils.GetData(mainKey, subKey, CommonDefine.NumberTrue)
  if data == CommonDefine.NumberTrue then
    ClientDataUtils.SetData(mainKey, subKey, CommonDefine.NumberFalse)
  end
end

function RedPointDataUtils.IsShowSocialInviteRed()
  if RedPointDataUtils.IsFeatureFirstOpen(cd.FeatureId.FriendInvitation) then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  local taskList = InvitationCodeModel.Instance:GetRewardTaskList()
  for _, taskTid in ipairs(taskList) do
    if TaskDataUtils.IsCanGetRward(taskTid) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  do return RedPointDataUtils.GetRedDataByTid, RedPointDataUtils.RedType.InvitationCode end
  return RedPointDataUtils.GetRedDataByTid, RedPointDataUtils.RedType.InvitationCode, 0, ipairs(taskList)
end

function RedPointDataUtils.ClearActivityTaskGroupFirstOpenRed(taskGroupTid, activityTid)
  local isOpen = ActivityDataUtils.IsActivityTaskGroupOpen(taskGroupTid, activityTid)
  if not isOpen then
    return
  end
  RedPointDataUtils.ClearClientRed(CommonDefine.ClientDataMainKey.ActivityTaskGroupFirstOpen, tostring(taskGroupTid))
end

function RedPointDataUtils.IsStageFirstClearGoodFirstOpen(shopTid)
  local saveKey = tostring(shopTid)
  do return RedPointDataUtils.IsShowClientRed, cd.ClientDataMainKey.FirstClearGoodsFirstOpen, saveKey end
  return RedPointDataUtils.IsShowClientRed, cd.ClientDataMainKey.FirstClearGoodsFirstOpen, saveKey, RedPointDataUtils.RedAttrType.IsNew
end

function RedPointDataUtils.ClearStageFirstClearGoodFirstOpen(shopTid)
  local saveKey = tostring(shopTid)
  RedPointDataUtils.ClearClientRed(cd.ClientDataMainKey.FirstClearGoodsFirstOpen, saveKey)
end

function RedPointDataUtils.IsLimitGoodFirstOpen(shopTid)
  local saveKey = tostring(shopTid)
  if MainShopDataUtils.IsOwnSkinInSale(shopTid) then
    return
  end
  do return RedPointDataUtils.IsShowClientRed, cd.ClientDataMainKey.LimitGoodFirstOpen, saveKey end
  return RedPointDataUtils.IsShowClientRed, cd.ClientDataMainKey.LimitGoodFirstOpen, saveKey, RedPointDataUtils.RedAttrType.IsNew
end

function RedPointDataUtils.ClearLimitGoodFirstOpen(shopTid)
  local saveKey = tostring(shopTid)
  RedPointDataUtils.ClearClientRed(cd.ClientDataMainKey.LimitGoodFirstOpen, saveKey)
end

function RedPointDataUtils.IsFeatureFirstOpen(featureId, subKey)
  subKey = subKey or PlayerDataUtils.GetFeatureMainTypeKey()
  local saveKey = featureId .. (subKey or 0)
  local isFirstOpen = ClientDataUtils.GetData(cd.ClientDataMainKey.FeatureFirstOpen, saveKey)
  if nil == isFirstOpen then
    local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureId, subKey)
    if isUnlock then
      ClientDataUtils.SetData(cd.ClientDataMainKey.FeatureFirstOpen, saveKey, cd.NumberTrue)
      return RedPointDataUtils.RedAttrType.IsNew
    end
  end
  return isFirstOpen == cd.NumberTrue and RedPointDataUtils.RedAttrType.IsNew
end

function RedPointDataUtils.ClearFeatureFirstOpen(featureId, subKey)
  local saveKey = featureId .. (subKey or 0)
  local data = ClientDataUtils.GetData(cd.ClientDataMainKey.FeatureFirstOpen, saveKey)
  if data == cd.NumberTrue then
    ClientDataUtils.SetData(cd.ClientDataMainKey.FeatureFirstOpen, saveKey, cd.NumberFalse)
  end
end

function RedPointDataUtils.HasFreeGoods()
  local ret = RedPointDataUtils.IsGiftBagRefresh()
  if ret then
    return ret
  end
  local advanceDc = RedPointDataUtils.MainShopHasFree(cd.MainShopTypeTag.AdvanceDC)
  local result = advanceDc
  ret = result and RedPointDataUtils.RedAttrType.Red or false
  if not ret then
    local isFree, redType = MainShopDataUtils.IsHaveFreeGoods()
    if isFree then
      ret = redType or RedPointDataUtils.RedAttrType.Red
    end
  end
  return ret
end

function RedPointDataUtils.MainShopHasFree(shopVisualType)
  local MainShopDataUtils = require("Data.MainShopDataUtils")
  local shopRealType = MainShopDataUtils.GetShopRealType(shopVisualType)
  local data = shopRealType and MainShopDataUtils.GetShopGoodsList(shopRealType) or nil
  if data then
    for _, item in pairs(data) do
      local result = 0 == item.price and item.isSell == false and false == item.lock
      if result then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowShop()
  local shopRedData = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.Shop)
  local tabTypeGroup = {}
  if shopRedData then
    local mainShopTypeList = ShopExtModel.Instance:GetMainShopTypeList(true)
    for _, shopTypeTid in ipairs(mainShopTypeList) do
      local redData = shopRedData[shopTypeTid]
      if redData and redData.isNew and redData.isNew >= 1 then
        table.insert(tabTypeGroup, MainShopDataUtils.GetShopTabType(shopTypeTid))
      end
    end
    for _, tabType in pairs(tabTypeGroup) do
      if MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(tabType) and MainShopDataUtils.GetShopDataByTag(tabType) ~= nil then
        local ret = RedPointDataUtils.GetShopTagRedData(tabType)
        if ret then
          return ret
        end
      end
    end
  end
  if RedPointDataUtils.IsShowLimitedTimeGiftBoxRed() then
    return RedPointDataUtils.RedAttrType.Red
  end
  if RedPointDataUtils.IsShowEnergyCardRed() then
    do return end
    return RedPointDataUtils.IsShowEnergyCardRed, pairs(tabTypeGroup)
  end
  if RedPointDataUtils.GetShopDataRed() then
    do return end
    return RedPointDataUtils.GetShopDataRed, pairs(tabTypeGroup)
  end
  do return end
  return RedPointDataUtils.HasFreeGoods, pairs(tabTypeGroup)
end

function RedPointDataUtils.GetShopTagRedData(typeTag)
  local multiUiGroups = MainShopDataUtils.GetMultiUIGroups()
  if multiUiGroups[typeTag] then
    local ret
    for _, childTypeTag in pairs(multiUiGroups[typeTag]) do
      ret = ret or RedPointDataUtils.GetShopTagRedData(childTypeTag)
      if ret == RedPointDataUtils.RedAttrType.IsNew then
        return ret
      end
    end
    return ret
  end
  if typeTag == cd.MainShopTypeTag.MoonCard then
    return false
  elseif typeTag == cd.MainShopTypeTag.GiftBag then
    local ret = RedPointDataUtils.IsGiftBagRefresh()
    if not ret then
      local isFree, redType = MainShopDataUtils.IsHaveFreeGoodsInShopType(typeTag)
      if isFree then
        return redType or RedPointDataUtils.RedAttrType.Red
      end
    end
    return ret
  elseif typeTag == cd.MainShopTypeTag.LimitedTimeGiftBox then
    do return end
    return RedPointDataUtils.IsShowLimitedTimeGiftBoxRed, MainShopDataUtils.IsHaveFreeGoodsInShopType(typeTag)
  end
  if not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(typeTag) then
    return false
  end
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.Shop, {
    MainShopDataUtils.GetShopRealType(typeTag)
  })
  if ret then
    return ret
  end
  ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MainShop, {
    MainShopDataUtils.GetShopRealType(typeTag)
  })
  if ret then
    return ret
  end
  local isFree, redType = MainShopDataUtils.IsHaveFreeGoodsInShopType(typeTag)
  if isFree then
    return redType or RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function RedPointDataUtils.IsShowLimitedTimeGiftBoxRed()
  local activityDataList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
  if not table.next(activityDataList) then
    return false
  end
  for _, activityData in ipairs(activityDataList) do
    if ActivityDataUtils.IsHaveLimitTimeReward(activityData.activityTid) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.GetFirstClearShopListRed()
  local uiBinder = UIManager.Instance.binder
  local tmpBinder = uiBinder:createChild()
  local model = tmpBinder:createModel(MainShopPanelModel)
  model:SetCurShopType(cd.MainShopTypeTag.GiftBag)
  local shopDatas = model.showShopItemList
  tmpBinder:teardown()
  for _, shopData in pairs(shopDatas or {}) do
    local shopTid = shopData.tid
    local shopCfg = DT.Shop[shopTid]
    if not shopCfg then
    else
      local red = false
      if shopCfg.UnlockCondType == CommonDefine.ShopUnlockType.StageFirstClear and MainShopDataUtils.CheckStageFirstClearGoodCanShow(shopData) then
        red = RedPointDataUtils.IsStageFirstClearGoodFirstOpen(shopTid)
      elseif shopCfg.OnSaleDate then
        if LimitTimeGiftUtils.IsExpiredLimitGiftShopItem(shopTid) then
          goto lbl_66
        end
        red = RedPointDataUtils.IsLimitGoodFirstOpen(shopTid)
      end
      if red then
        return red
      end
    end
    ::lbl_66::
  end
  return false
end

function RedPointDataUtils.GetShopDataRed()
  local shopDataList = ShopDataUtils.GetShopUpdateData()
  if not shopDataList then
    return false
  end
  for shopTid, shopData in pairs(shopDataList) do
    local shopCfg = DT.Shop[shopTid]
    if not shopCfg.OnSaleDate or LimitTimeGiftUtils.IsExpiredLimitGiftShopItem(shopTid) then
    else
      local checkOn = MainShopDataUtils.CheckShopItemIsOnSale(shopData.data)
      if checkOn then
        local red = RedPointDataUtils.IsLimitGoodFirstOpen(shopTid)
        if red then
          return red
        end
      end
    end
  end
  return false
end

function RedPointDataUtils.GetShopTypeRed(shopTypeTid)
  local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(shopTypeTid)
  if not shopTypeConfig then
    return false
  end
  local typeTag = shopTypeConfig.TypeTag
  if typeTag == cd.MainShopTypeTag.MoonCard then
    return false
  end
  if not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(typeTag) then
    return false
  end
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.Shop, {shopTypeTid})
  if ret then
    return ret
  end
  if typeTag == cd.MainShopTypeTag.GiftBag then
    do return end
    return RedPointDataUtils.IsGiftBagRefresh, {shopTypeTid}, shopTypeTid
  end
  return false
end

function RedPointDataUtils.GetShopRedByShopTypes(shopTypeList)
  local ret
  for _, shopTypeTid in ipairs(shopTypeList) do
    local isInOpenTime = MainShopDataUtils.IsShopInOpenTime(shopTypeTid)
    if not isInOpenTime then
    else
      ret = RedPointDataUtils.GetShopTypeRed(shopTypeTid) or ret
      if ret == RedPointDataUtils.RedAttrType.IsNew then
        return ret
      end
    end
  end
  return ret
end

function RedPointDataUtils.IsSurveyMailRed()
  if not DataCenter.mailData.surveyMails then
    return
  end
  for _, surveyMail in pairs(DataCenter.mailData.surveyMails) do
    if surveyMail and not surveyMail.read then
      return true
    end
  end
  return false
end

function RedPointDataUtils.IsMailBoxRed()
  local mainSubTypeKey = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Mail, mainSubTypeKey)
  if not unlocked then
    return false
  end
  if RedPointDataUtils.IsSurveyMailRed() then
    return RedPointDataUtils.RedAttrType.Red
  end
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.Mail)
  return ret
end

function RedPointDataUtils.IsShowMoneyDungeons()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MoneyDungeonsNew)
  ret = ret or RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MoneyDungeonsAward)
  return ret
end

function RedPointDataUtils.IsShowHomeTechRedPoint()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Institute, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.Technology)
  return ret
end

function RedPointDataUtils.IsShowAwakerVoiceRedPoint(awakerID)
  if AwakerVoiceModel.Instance:IsAwakerHaveUnlockPvpVoice(awakerID) then
    return "isNew"
  end
  local awaker = require("Data.AwakerDataUtils").GetAwakerData(awakerID)
  local curSkin = awaker and awaker.curSkin or 0
  for key, v in pairs(awaker.voices) do
    local cfg = DT.Voice[key]
    if cfg and cfg.AwakerID == awakerID and cfg.ShowInAwakerDate == cd.IsShowAwakerDate.Yes and v == cd.AwakerStoryVoiceState.Unlock then
      local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(cfg)
      if not unlockSkinItem then
        return "isNew"
      end
      if unlockSkinItem == curSkin then
        return "isNew"
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowStageGroupRedPoint(stageGroupId)
  if not stageGroupId then
    return false
  end
  local MainCopyDataUtils = require("Data.MainCopyDataUtils")
  local ResonanceDataUtils = require("Data.ResonanceDataUtils")
  local result = MainCopyDataUtils.IsShowStageGroupNew(stageGroupId)
  result = result or RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MainStageGetAward, {stageGroupId})
  result = result or RedPointDataUtils.IsShowStageGroupAchievementReward(stageGroupId)
  if not result then
    local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupId)
    result = RedPointDataUtils.IsMainStageResonanceShow(resonanceGroupId)
  end
  return result
end

function RedPointDataUtils.IsShowAwakerNewStoryRedPoint(awakerID)
  local awaker = require("Data.AwakerDataUtils").GetAwakerData(awakerID)
  if not awaker.stories then
    return false
  end
  for key, v in pairs(awaker.stories) do
    local cfg = DT.AwakerStory[key]
    if cfg and cfg.StoryType == cd.AwakerStoryType.Story and cfg.ActorIndex == awakerID and v == cd.AwakerStoryVoiceState.Unlock then
      return "isNew"
    end
  end
  return false
end

function RedPointDataUtils.IsTutorialRedPoint()
  local _, unlockedTutorial = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Tutorial)
  if unlockedTutorial then
    local tutorialRedData = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.Tutorial)
    local tutorialRed = RedPointDataUtils.ShowRedPointState(tutorialRedData)
    return tutorialRed or false
  end
end

function RedPointDataUtils.IsShowAwakerStoryRedPoint(awakerID)
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  if not AwakerDataUtils.HasOwnedAwaker(awakerID) then
    return false
  end
  local ret = RedPointDataUtils.IsShowAwakerVoiceRedPoint(awakerID)
  ret = ret or RedPointDataUtils.IsShowAwakerNewStoryRedPoint(awakerID)
  return ret or false
end

function RedPointDataUtils.IsShowTaskSystemRedPoint()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Task, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlock then
    return false
  end
  local _, unlockedTutorial = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Tutorial)
  local tutorialRed = unlockedTutorial and RedPointDataUtils.IsTutorialRedPoint() or false
  if tutorialRed then
    return tutorialRed
  end
  local _, unlockedFreeTrial = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.ResidentTrial)
  local freeTrialRed = unlockedFreeTrial and RedPointDataUtils.HasFreeTrialAward() or false
  if freeTrialRed then
    return freeTrialRed
  end
  local _, unlockedBattleTeaching = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.BattleTeaching)
  local battleTeachingRed = unlockedBattleTeaching and RedPointDataUtils.IsShowBattleTeachingEntryRed()
  if battleTeachingRed then
    return battleTeachingRed
  end
  local taskSystemIdxGroup = {
    cd.TaskServerIndex.PlayerLevel,
    cd.TaskServerIndex.School,
    cd.TaskServerIndex.Career,
    cd.TaskServerIndex.Achivement
  }
  local hasTaskCompoleted = false
  for _, serverIdx in pairs(taskSystemIdxGroup) do
    local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {}
    for _, value in pairs(taskList) do
      if value.state == cd.TaskState.Receive then
        hasTaskCompoleted = true
        break
      end
    end
  end
  local redReturnGroup = {}
  for _, idx in pairs(taskSystemIdxGroup) do
    local page = TaskModel.Instance:GetServerIndexPage(idx)
    if page and TaskModel.Instance:IsPageUnlocked(page) then
      table.insert(redReturnGroup, RedPointDataUtils.IsShowTaskRedPoint(idx))
    end
  end
  for _, data in pairs(redReturnGroup) do
    if data == RedPointDataUtils.RedAttrType.IsNew then
      return hasTaskCompoleted and data or false
    end
  end
  for _, data in pairs(redReturnGroup) do
    if data == RedPointDataUtils.RedAttrType.Red then
      return hasTaskCompoleted and data or false
    end
  end
  return false
end

function RedPointDataUtils.IsShowDispatchTaskRed()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Task, DT.GetConstant("TaskType_Appoint"))
  if not unlock then
    Logger.Info("[DispatchRed] IsShowDispatchTaskRed: feature not unlock, no red")
    return false
  end
  local ret = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.AppointTaskNew)
  if ret then
    Logger.Info(string.format("[DispatchRed] IsShowDispatchTaskRed: AppointTaskNew red, state=%s", tostring(ret)))
    return ret
  end
  local dispatchTasks = TaskDataUtils.GetTaskDataListBySvrIdx(cd.TaskServerIndex.Appoint)
  if dispatchTasks then
    for _, taskData in ipairs(dispatchTasks) do
      if taskData and taskData.state == cd.TaskState.Receive then
        Logger.Info("[DispatchRed] IsShowDispatchTaskRed: completed task can receive reward")
        return RedPointDataUtils.RedAttrType.Red
      end
    end
  end
  if TaskDataUtils.HasCanDispatchTaskRed() then
    Logger.Info("[DispatchRed] IsShowDispatchTaskRed: HasCanDispatchTaskRed true")
    return RedPointDataUtils.RedAttrType.Red
  end
  if 0 ~= TaskDataUtils.GetIsSpecialAppoint() then
    local unDispatched = TaskDataUtils.GetUnDispatchedTaskList()
    if unDispatched and #unDispatched > 0 then
      if TaskDataUtils.HasCanDispatchTaskRed() then
        Logger.Info("[DispatchRed] IsShowDispatchTaskRed: special appoint newbie red, HasCanDispatchTaskRed true")
        return RedPointDataUtils.RedAttrType.Red
      else
        Logger.Info("[DispatchRed] IsShowDispatchTaskRed: special appoint period but HasCanDispatchTaskRed false, no red")
      end
    else
      Logger.Info("[DispatchRed] IsShowDispatchTaskRed: special appoint period but no UnDispatched tasks, no red")
    end
  end
  Logger.Info("[DispatchRed] IsShowDispatchTaskRed: no red condition matched")
end

function RedPointDataUtils.RemoveDailyDispatchRed()
  local enableDispatch = TaskDataUtils.EnableDispatch()
  if not enableDispatch then
    return
  end
  local AppointTaskDailyRed = RedTypeDefine.RedType.AppointTaskDailyRed
  if not DataCenter.redPointData[AppointTaskDailyRed] then
    DataCenter.redPointData[AppointTaskDailyRed] = {}
  end
  DataCenter.redPointData[AppointTaskDailyRed].red = 0
  local now = TimeUtils.GetServerTime()
  local needUpdate = false
  local lastEnterTime = MobileFileDataManager.Instance:GetPlayerFileValue(cd.LocalSaveKey.DailyFirstDispatchRed)
  if lastEnterTime then
    local refreshTime = TimeUtils.GetFutureTime(1, TimeCfgUtils.ServerRefreshTime_2_Local(), lastEnterTime)
    if now >= refreshTime then
      needUpdate = true
    end
  else
    needUpdate = true
  end
  if needUpdate then
    MobileFileDataManager.Instance:SetPlayerFileValue(cd.LocalSaveKey.DailyFirstDispatchRed, now)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  end
end

function RedPointDataUtils.IsShowTaskRedPoint(serverIndex)
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Task, serverIndex)
  if not unlock then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.Task)
  if nil == dat then
    return false
  end
  local hasTaskCompoleted = false
  local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(serverIndex) or {}
  for _, value in pairs(taskList) do
    if value.state == cd.TaskState.Receive then
      hasTaskCompoleted = true
      break
    end
  end
  local ret = false
  local data = {}
  local haveNew = false
  for key, value in pairs(dat) do
    if type(value) == "table" and serverIndex and serverIndex == key then
      for k, v in pairs(value) do
        if "isNew" == k then
          data.isNew = v
          haveNew = true
        elseif "red" == k then
          data.red = v
        end
        ret = RedPointDataUtils.ShowRedPointState(data)
      end
    end
  end
  if haveNew then
    ret = RedPointDataUtils.ShowRedPointState({isNew = 1})
  end
  return hasTaskCompoleted and ret or false
end

function RedPointDataUtils.UpdateFreeTrialRed()
  FreeTrialController.Instance:UpdateFreeTrial()
end

function RedPointDataUtils.TrialStageHasAward(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  local result = TaskDataUtils.IsTaskCanReward(taskId)
  return result
end

function RedPointDataUtils.HasFreeTrialAward()
  do return FreeTrialController.Instance.HasFreeTrialAward end
  return FreeTrialController.Instance.HasFreeTrialAward, FreeTrialController.Instance
end

function RedPointDataUtils.IsShowTaskReceiveRedDot(pageList)
  for _, taskType in pairs(pageList) do
    local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(taskType)
    if not taskList then
    else
      if taskType == cd.TaskServerIndex.Daily then
        taskList = TaskDataUtils.RemoveJumpLockTasks(taskList)
      end
      for _, taskData in pairs(taskList) do
        if taskData.state == cd.TaskState.Receive then
          return "red"
        end
      end
    end
  end
  return false
end

local taskTabList = {
  [1] = cd.TaskServerIndex.Period
}

function RedPointDataUtils.IsShowBp()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local ret = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.BattlePass)
  ret = ret and (ret.isNew and "isNew" or nil)
  ret = ret or RedPointDataUtils.IsShowBpRewardRedDot()
  if BattlePassDataUtils.IsShowDoubleBpTag() then
    ret = nil
  end
  return ret
end

function RedPointDataUtils.IsShowCollectionFeature(feature, subKey, isFeatureUnlocked)
  if not feature then
    return false
  end
  subKey = subKey or PlayerDataUtils.GetFeatureMainTypeKey()
  if not isFeatureUnlocked then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, subKey)
    if not unlocked then
      return false
    end
  end
  if not isFeatureUnlocked then
    local redArgs = subKey ~= PlayerDataUtils.GetFeatureMainTypeKey() and {subKey} or nil
    local rst = RedPointDataUtils.GetRedPointState(feature, redArgs)
    if rst then
      return rst
    end
  end
  local collectionRedData = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.Collection)
  if not collectionRedData then
    return false
  end
  if subKey ~= PlayerDataUtils.GetFeatureMainTypeKey() then
    local groupDatas = ArtCollectionController.Instance:GetSubCollectDatasByFeature(feature, subKey)
    for _, groupData in pairs(groupDatas) do
      for _, collectTid in ipairs(groupData.list) do
        local isNew = collectionRedData[collectTid] and collectionRedData[collectTid].isNew and collectionRedData[collectTid].isNew >= 1
        local unlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
        if isNew and unlock then
          return RedPointDataUtils.RedAttrType.IsNew
        end
      end
    end
  else
    local featureIdMap = {}
    for i = 0, 10 do
      local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(feature, i)
      if featureCfg and featureCfg.ID then
        featureIdMap[featureCfg.ID] = true
      end
    end
    for collectTid, collectCfg in pairs(DT.CollectionHall) do
      if featureIdMap[collectCfg.CollectionType] then
        local isNew = (collectionRedData[collectTid] or {}).isNew
        isNew = isNew and isNew >= 1
        local unlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
        if isNew and unlock then
          return RedPointDataUtils.RedAttrType.IsNew
        end
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowCollectionItem(tid)
  local unlock = ArtCollectionController.Instance:IsUnlock(tid)
  if not unlock then
    return false
  end
  local dat = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.Collection)
  if not dat then
    return false
  end
  if dat[tid] and dat[tid].isNew and dat[tid].isNew >= 1 then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  return false
end

function RedPointDataUtils.IsShowAllCollection()
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.Collection
end

function RedPointDataUtils.NewAllCollectionReward()
  ArtCollectionRewardModel.Instance:UpdateTaskData()
  for _, rewardType in pairs(ArtCollectionDefine.RewardType) do
    if RedPointDataUtils.NewCollectionReward(rewardType) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.NewCGCollectionReward()
  local cgList = ArtCollectionDefine.CGList
  for _, rewardType in pairs(cgList) do
    if RedPointDataUtils.NewCollectionReward(rewardType) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.NewCollectionReward(rewardType)
  if not rewardType then
    return false
  end
  if rewardType == ArtCollectionDefine.CGType then
    do return end
    return RedPointDataUtils.NewCGCollectionReward, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local cfgList = ArtCollectionRewardModel.Instance:GetTaskCfg()[rewardType]
  local taskDataList = ArtCollectionRewardModel.Instance:GetTaskData()
  if cfgList and taskDataList then
    for _, taskId in pairs(cfgList) do
      if taskDataList[taskId] and taskDataList[taskId].state == CommonDefine.TaskState.Receive then
        return RedPointDataUtils.RedAttrType.Red
      end
    end
  end
  return false
end

function RedPointDataUtils.IsShowBpRewardRedDot()
  local bpRewardList = BattlePassDataUtils.GetRewardList()
  for _, data in pairs(bpRewardList) do
    local state = BattlePassDataUtils.GetRewardItemState(data.unlockLevel, data.bpRewardType, data.tid)
    if state == cd.BpRewardState.CanReceive and 0 ~= data.unlockLevel then
      return "red"
    end
  end
  if BattlePassDataUtils.GetExtraLvAwardNum() > 0 then
    return "red"
  end
  return false
end

function RedPointDataUtils.IsShowMainCopy()
  local SubplotRedUtils = require("Data.RedData.SubplotRedUtils")
  local redReturnGroup = {}
  table.insert(redReturnGroup, MainCopyDataUtils.IsShowMainCopyNew())
  table.insert(redReturnGroup, SubplotRedUtils.GetSmallSubplotRed())
  table.insert(redReturnGroup, SubplotRedUtils.GetLargeSubplotRed())
  table.insert(redReturnGroup, SubplotRedUtils.GetSpecialSubplotRed())
  table.insert(redReturnGroup, RedPointDataUtils.IsFeatureFirstOpen(cd.FeatureId.ConfessionEvent))
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, RedPointDataUtils.IsFeatureFirstOpen(cd.FeatureId.ConfessionEvent)
end

function RedPointDataUtils.IsMainStageResonanceShow(resonanceGroupId, isShowExtraItem, fromActivityId)
  if not resonanceGroupId then
    return
  end
  local ResonanceDataUtils = require("Data.ResonanceDataUtils")
  if ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId) == false then
    return
  end
  local redStatus
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  for k, v in pairs(resonanceConfigs) do
    redStatus = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.MainStageResonance, {
      v.ID
    })
    if redStatus then
      break
    end
  end
  return redStatus
end

function RedPointDataUtils.IsLargeSubplotGroupResonanceRedShow()
  local groupIdList = CopyExtModel.Instance:GetSublplotLargeGroupList()
  for _, groupId in pairs(groupIdList) do
    if SubplotRedUtils.CheckGroupRedValid(groupId) then
      local redStatus = RedPointDataUtils.IsStageGroupResonanceRedShow(groupId)
      if redStatus then
        return redStatus
      end
    end
  end
  return false
end

function RedPointDataUtils.IsStageGroupResonanceRedShow(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupTid)
  local redStatus = RedPointDataUtils.IsMainStageResonanceShow(resonanceGroupId)
  if redStatus then
    return redStatus
  end
  return false
end

function RedPointDataUtils.IsResonanceShow(resonanceId)
  do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MainStageResonance end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.MainStageResonance, {resonanceId}, resonanceId
end

function RedPointDataUtils.UpdateMainStageResonance(resonanceGroupId)
  local ResonanceDataUtils = require("Data.ResonanceDataUtils")
  if ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId) == false then
    return
  end
  local redpoint = DataCenter.redPointData
  if not redpoint[RedPointDataUtils.RedType.MainStageResonance] then
    redpoint[RedPointDataUtils.RedType.MainStageResonance] = {}
  end
  local mainStageResonanceReds = redpoint[RedPointDataUtils.RedType.MainStageResonance]
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  for k, v in pairs(resonanceConfigs or {}) do
    local isRed = ResonanceDataUtils.IsResonanceShowRed(v.ID)
    mainStageResonanceReds[v.ID] = mainStageResonanceReds[v.ID] or {}
    mainStageResonanceReds[v.ID].red = isRed and 1 or 0
  end
  local firstResonanceID = resonanceConfigs[1] and resonanceConfigs[1].ID or nil
  if firstResonanceID then
    mainStageResonanceReds[firstResonanceID] = mainStageResonanceReds[firstResonanceID] or {}
    mainStageResonanceReds[firstResonanceID].red = 0
  end
end

function RedPointDataUtils.UpdateMainStageResonanceByItemId(itemId)
  local resonanceCfgs = ResonanceDataUtils.GetResonanceGroupConfig()
  local upgradeCostItemsId = {}
  for k, v in pairs(resonanceCfgs) do
    ResonanceDataUtils.GetResonanceGroupAllConsumeMaterials(k, upgradeCostItemsId)
    if table.contains(upgradeCostItemsId, itemId) then
      RedPointDataUtils.UpdateMainStageResonance(k)
      GlobalDispatcher:Dispatch(NotifyId.OnResonanceDataChanged, k)
    end
  end
end

function RedPointDataUtils.IsShowResCopy()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.ResCopy, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local red = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ResCopyNew)
  if not red then
    do return RedPointDataUtils.IsTaskListRedByConstKey end
    return RedPointDataUtils.IsTaskListRedByConstKey, "DailyMaterialPerfectRewardTaskGroup"
  end
  return red
end

function RedPointDataUtils.IsShowResSubCopyNew(stageGroupId)
  do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.ResCopyNew end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.ResCopyNew, {stageGroupId}, stageGroupId
end

function RedPointDataUtils.IsShowTrinketCopy()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TrinketCopyNew)
  if not ret then
    ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TrinketCopy)
    return ret
  else
    return ret
  end
end

function RedPointDataUtils.IsShowTrinketNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.TrinketCopy, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    print("RedPointDataUtils.IsShowTrinketNew return false")
    return false
  end
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TrinketCopyNew)
  print("RedPointDataUtils.IsShowTrinketNew return ", table.tostring(ret))
  ret = ret or RedPointDataUtils.IsTaskListRedByConstKey("TrinketCopyPerfectRewardTaskGroup")
  return ret
end

function RedPointDataUtils.IsShowTrinketSubCopyNew(stageGroupId)
  do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.TrinketCopyNew end
  return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.TrinketCopyNew, {stageGroupId}, stageGroupId
end

function RedPointDataUtils.IsShowBattle()
  return RedPointDataUtils.IsShowResCopy() or RedPointDataUtils.IsShowMainCopy() or RedPointDataUtils.IsShowTrinketCopy()
end

function RedPointDataUtils.IsTaskListRedByConstKey(constKey)
  local allTaskMap = TaskDataUtils.GetConstKeyTaskMap(constKey)
  do return RedPointDataUtils.IsTaskListRed end
  return RedPointDataUtils.IsTaskListRed, allTaskMap
end

function RedPointDataUtils.IsTaskListRed(taskList)
  for _, taskData in pairs(taskList or {}) do
    if taskData.state == CommonDefine.TaskState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.IsShowNewExchange()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ExchangeNew)
  return ret
end

function RedPointDataUtils.IsShowNewCompose()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ComposeNew)
  if ret then
    return ret
  end
  if AlchemyCompositeExtModel.Instance:IsAnyCompositeRemainShowRed() then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function RedPointDataUtils.IsShowNewDecompose()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.DecomposeNew)
  return ret
end

function RedPointDataUtils.IsShowNewRecast()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.RecastNew)
  return ret
end

function RedPointDataUtils.IsShowNewItemConversion()
  local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.ItemConversion)
  return ret
end

function RedPointDataUtils.IsShowBagRedPoint()
  if AlchemyCompositeExtModel.Instance:IsAnyCompositeRemainShowRed() then
    return RedPointDataUtils.RedAttrType.Red
  end
  local list = ItemDataUtils.GetWeaponList()
  for _, item in ipairs(list) do
    local isRed = RedPointDataUtils.IsBackTrackShowRed(item.uid)
    if isRed then
      return "red"
    end
  end
  do return RedPointDataUtils.GetRedPointState end
  return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.SpecificItemOnceRed, ipairs(list)
end

function RedPointDataUtils.InitSpecificItemOnceRed()
  local specificItemList = DT.GetOriginalConstant("BagOnceReddotItemList")
  if not specificItemList or table.next(specificItemList) == nil then
    return
  end
  local SpecificItemOnceRed = RedTypeDefine.RedType.SpecificItemOnceRed
  local allRedData = DataCenter.redPointData
  for _, tid in ipairs(specificItemList) do
    local hasOwned = ItemDataUtils.GetItemNum(tid) > 0
    if tid and ItemDataUtils.GetItemConfig(tid) and hasOwned then
      local cacheKey = cd.LocalSaveKey.SpecificItemOnceRed .. tid
      local cacheRed = MobileFileDataManager.Instance:GetPlayerFileValue(cacheKey)
      local red = 0
      if cacheRed or nil == cacheRed then
        red = 1
      end
      if not allRedData[SpecificItemOnceRed] then
        allRedData[SpecificItemOnceRed] = {}
      end
      if not allRedData[SpecificItemOnceRed][tid] then
        allRedData[SpecificItemOnceRed][tid] = {}
      end
      allRedData[SpecificItemOnceRed][tid].red = red
    end
  end
end

function RedPointDataUtils.UpdateBackTrackRed(delay)
  if delay then
    FrameWaiter.OnNextFrame(function()
      RedPointDataUtils.UpdateBackTrackOnceRed()
      RedPointDataUtils.UpdateBackTrackResidentRed()
    end, 60)
  end
end

function RedPointDataUtils.UpdateBackTrackResidentRed()
  local allRedData = DataCenter.redPointData
  local backTrackdata = DataCenter.backTrackData.data
  local awakersMap = backTrackdata.openAwakers
  local weaponsMap = backTrackdata.openWeapons
  local backTrack = RedTypeDefine.RedType.BackTrack
  allRedData[backTrack] = {}
  if awakersMap then
    for tid, openData in pairs(awakersMap) do
      if 2 == openData.open then
        if not allRedData[backTrack][tid] then
          allRedData[backTrack][tid] = {}
        end
        allRedData[backTrack][tid].red = 1
      end
    end
  end
  if weaponsMap then
    for tid, openData in pairs(weaponsMap) do
      if 2 == openData.open then
        local uidMap = ItemDataUtils.GetItemUidMap(tonumber(tid))
        if uidMap then
          for uid, _ in pairs(uidMap) do
            if not allRedData[backTrack][uid] then
              allRedData[backTrack][uid] = {}
            end
            allRedData[backTrack][uid].red = 1
          end
        end
      end
    end
  end
end

function RedPointDataUtils.UpdateBackTrackOnceRed(delay)
  local function call(finishCall)
    local backTrackdata = DataCenter.backTrackData.data
    
    local awakersMap = backTrackdata.openAwakers
    local weaponsMap = backTrackdata.openWeapons
    if awakersMap then
      RedPointDataUtils._UpdateBackTrackOnceRed(awakersMap)
    end
    if weaponsMap then
      RedPointDataUtils._UpdateBackTrackOnceRed(weaponsMap, true)
    end
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
    if finishCall then
      finishCall()
    end
  end
  
  if delay then
    call(function()
      RedPointDataUtils.UpdateAwakerRed()
    end)
  else
    call()
  end
end

function RedPointDataUtils._UpdateBackTrackOnceRed(map, isWeapon)
  local allRedData = DataCenter.redPointData
  local backTrackOnce = RedTypeDefine.RedType.BackTrackOnce
  
  local function setFunc(exKey)
    local cacheKey = cd.LocalSaveKey.BackTrackOnce .. exKey
    local cacheRed = MobileFileDataManager.Instance:GetPlayerFileValue(cacheKey)
    local red = 0
    if nil == cacheRed or cacheRed >= 1 then
      red = 1
    end
    if not allRedData[backTrackOnce] then
      allRedData[backTrackOnce] = {}
    end
    if not allRedData[backTrackOnce][exKey] then
      allRedData[backTrackOnce][exKey] = {}
    end
    local oriValue = allRedData[backTrackOnce][exKey].red
    if not oriValue then
      allRedData[backTrackOnce][exKey].red = red
    end
    local resultValue = allRedData[backTrackOnce][exKey].red
    MobileFileDataManager.Instance:SetPlayerFileValue(cacheKey, resultValue)
  end
  
  for tid, openData in pairs(map) do
    if openData.open > 0 then
      if isWeapon then
        local uidMap = ItemDataUtils.GetItemUidMap(tonumber(tid))
        if uidMap then
          for uid, _ in pairs(uidMap) do
            setFunc(uid)
          end
        end
      else
        setFunc(tid)
      end
    end
  end
end

function RedPointDataUtils.ResetBackTrackOnceRed(tid)
  local allRedData = DataCenter.redPointData
  local backTrackOnce = RedTypeDefine.RedType.BackTrackOnce
  if not allRedData[backTrackOnce] then
    allRedData[backTrackOnce] = {}
  end
  if not allRedData[backTrackOnce][tid] then
    allRedData[backTrackOnce][tid] = {}
  end
  allRedData[backTrackOnce][tid].red = nil
  local cacheKey = cd.LocalSaveKey.BackTrackOnce .. tid
  MobileFileDataManager.Instance:SetPlayerFileValue(cacheKey, nil)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  RedPointDataUtils.UpdateAwakerRed()
end

function RedPointDataUtils.RemoveBackTrackOnceRed(tid)
  local allRedData = DataCenter.redPointData
  local backTrackOnce = RedTypeDefine.RedType.BackTrackOnce
  if not allRedData[backTrackOnce] then
    allRedData[backTrackOnce] = {}
  end
  if not allRedData[backTrackOnce][tid] then
    allRedData[backTrackOnce][tid] = {}
  end
  local resultValue = 0
  allRedData[backTrackOnce][tid].red = resultValue
  local cacheKey = cd.LocalSaveKey.BackTrackOnce .. tid
  MobileFileDataManager.Instance:SetPlayerFileValue(cacheKey, resultValue)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  RedPointDataUtils.UpdateAwakerRed()
end

function RedPointDataUtils.IsBackTrackShowOnceRed(uid)
  local redType = RedTypeDefine.RedType.BackTrackOnce
  do return RedPointDataUtils._IsBackTrackShowRed, uid end
  return RedPointDataUtils._IsBackTrackShowRed, uid, redType
end

function RedPointDataUtils.IsBackTrackResidentShowRed(uid)
  local redType = RedTypeDefine.RedType.BackTrack
  do return RedPointDataUtils._IsBackTrackShowRed, uid end
  return RedPointDataUtils._IsBackTrackShowRed, uid, redType
end

function RedPointDataUtils.IsBackTrackShowRed(uid)
  if not uid then
    return false
  end
  local settingData = SettingManager.Instance:GetSettingData(cd.SettingUniqueName.BackTrackItemHideRed)
  local tid = ItemDataUtils.GetItemDataByField("tid", uid)
  local isSettingHide = settingData and 1 == settingData
  local tidHasBackTrack = BackTrackDataUtils.GetTidHasBackTrack(tid)
  if isSettingHide and tidHasBackTrack then
    return false
  end
  if BackTrackDataUtils.IsWeaponOpen(nil, uid) then
    return true
  end
  local showOnceRed = RedPointDataUtils.IsBackTrackShowOnceRed(uid)
  local showResidentRed = RedPointDataUtils.IsBackTrackResidentShowRed(uid)
  return showOnceRed or showResidentRed
end

function RedPointDataUtils._IsBackTrackShowRed(tid, redType)
  local allRedData = DataCenter.redPointData
  local redType = redType
  if not allRedData[redType] then
    allRedData[redType] = {}
  end
  if not allRedData[redType][tid] then
    allRedData[redType][tid] = {}
  end
  local isRed = allRedData[redType][tid].red and allRedData[redType][tid].red >= 1
  if isRed and AwakerDataUtils.IsAwakerTid(tid) and not BackTrackDataUtils.IsEnableQilingBack(tid) and not BackTrackDataUtils.IsEnableTrainBack(tid) and not BackTrackDataUtils.IsEnableHeichiBack(tid) then
    isRed = false
  end
  return isRed
end

function RedPointDataUtils.UpdateSpecificItemOnceRed(itemTid, showRed)
  if not itemTid then
    return
  end
  if not ItemDataUtils.IsSpecificOnceRedItem(itemTid) then
    return
  end
  local SpecificItemOnceRed = RedTypeDefine.RedType.SpecificItemOnceRed
  local allRedData = DataCenter.redPointData
  if not allRedData[SpecificItemOnceRed] then
    allRedData[SpecificItemOnceRed] = {}
  end
  if not allRedData[SpecificItemOnceRed][itemTid] then
    allRedData[SpecificItemOnceRed][itemTid] = {}
  end
  local cacheKey = cd.LocalSaveKey.SpecificItemOnceRed .. itemTid
  local cacheRed = MobileFileDataManager.Instance:GetPlayerFileValue(cacheKey)
  if cacheRed ~= showRed then
    MobileFileDataManager.Instance:SetPlayerFileValue(cacheKey, showRed)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  end
  local red = showRed and 1 or 0
  DataCenter.redPointData[SpecificItemOnceRed][itemTid].red = red
end

function RedPointDataUtils.IsShowMainPanelRightBottomBtnRedPoint()
  local ret = RedPointDataUtils.NewAllCollectionReward()
  return ret
end

function RedPointDataUtils.GetBinder()
  local binder = RedPointDataUtils.binder
  if not binder then
    RedPointDataUtils.binder = Vue.newBinder({})
    binder = RedPointDataUtils.binder
  end
  return binder
end

function RedPointDataUtils.InitPlayerData()
  local redpoint = DataCenter.redPointData
  local binder = RedPointDataUtils.GetBinder()
  for key, data in pairs(redpoint) do
    if type(data) == "table" and data.localKey then
      local fKey = cd.LocalSaveKey.RedPoint .. data.localKey
      data.localValue = MobileFileDataManager.Instance:GetPlayerFileValue(fKey, nil) or data.localValue
      binder:BindToRaw(function(_, newValue, _)
        MobileFileDataManager.Instance:SetPlayerFileValue(fKey, newValue)
        MobileFileDataManager.Instance:OnSavePlayerFileInfo()
      end, function()
        return data.localValue
      end)
    end
  end
  local EventMgr = require("Managers.EventManager.EventMgr")
  binder:BindOnceEvent(EventMgr.Instance.OnOpenPlayerLocalFile, function()
    RedPointDataUtils.InitSpecialSkillRedByLocalData()
    RedPointDataUtils.InitSpecificItemOnceRed()
    RedPointDataUtils.UpdateBackTrackRed(true)
  end)
end

function RedPointDataUtils.InitClientRedData(serverData)
  DataCenter.redPointData = Vue.reactive({})
  local redpoint = DataCenter.redPointData
  redpoint[RedPointDataUtils.RedType.Awaker] = redpoint[RedPointDataUtils.RedType.Awaker] or {}
  redpoint[RedPointDataUtils.RedType.AwakerLevel] = redpoint[RedPointDataUtils.RedType.AwakerLevel] or {}
  redpoint[RedPointDataUtils.RedType.AwakerBreakthrough] = redpoint[RedPointDataUtils.RedType.AwakerBreakthrough] or {}
  redpoint[RedPointDataUtils.RedType.AwakerPotency] = redpoint[RedPointDataUtils.RedType.AwakerPotency] or {}
  redpoint[RedPointDataUtils.RedType.AwakerSkill] = redpoint[RedPointDataUtils.RedType.AwakerSkill] or {}
  redpoint[RedPointDataUtils.RedType.AwakerTrinket] = redpoint[RedPointDataUtils.RedType.AwakerTrinket] or {}
  redpoint[RedPointDataUtils.RedType.AwakerSpecialSkill] = redpoint[RedPointDataUtils.RedType.AwakerSpecialSkill] or {}
  redpoint[RedPointDataUtils.RedType.SummonUpPoolRed] = redpoint[RedPointDataUtils.RedType.SummonUpPoolRed] or {}
  redpoint[RedPointDataUtils.RedType.MainShop] = {}
  redpoint[RedPointDataUtils.RedType.TrinketCopy] = {}
  redpoint[RedPointDataUtils.RedType.MainStageResonance] = {}
  SocialRedUtils.Init()
  RedPointDataUtils.AddRedpointDataByServerNotice(serverData)
end

function RedPointDataUtils.InitNotOwnAwakerRed(awakerId)
  RedPointDataUtils.__InitNotOwnAwakerRed(RedPointDataUtils.RedType.Awaker, awakerId)
  RedPointDataUtils.__InitNotOwnAwakerRed(RedPointDataUtils.RedType.AwakerBreakthrough, awakerId)
  RedPointDataUtils.__InitNotOwnAwakerRed(RedPointDataUtils.RedType.AwakerSkill, awakerId)
  RedPointDataUtils.__InitNotOwnAwakerRed(RedPointDataUtils.RedType.AwakerPotency, awakerId)
  RedPointDataUtils.__InitNotOwnAwakerRed(RedPointDataUtils.RedType.AwakerTrinket, awakerId)
end

function RedPointDataUtils.__InitNotOwnAwakerRed(type, awakerId)
  local redpoint = DataCenter.redPointData
  local reds = redpoint[type]
  if reds and reds[awakerId] then
    reds[awakerId].red = 0
  end
end

function RedPointDataUtils.UpdateAwakerRed(awakerDat, isImmediate)
  local lateUpdateFunc
  if awakerDat then
    lateUpdateFunc = System.bind(RedPointDataUtils._UpdateAwakerRed, awakerDat)
  else
    lateUpdateFunc = RedPointDataUtils._UpdateAwakerRed
  end
  if isImmediate then
    lateUpdateFunc()
  else
    PopupQueManager.Instance:SetDelayRedUpdate(lateUpdateFunc)
  end
end

function RedPointDataUtils._UpdateAwakerRed(awakerDat)
  if AwakerDataUtils.isPreviewingAwakersData then
    return false
  end
  local redpoint = DataCenter.redPointData
  local awakers = {}
  local awakerDU = require("Data.AwakerDataUtils")
  if awakerDat then
    local awakerTid = awakerDat.tid
    if AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      awakers[awakerTid] = awakerDat
    else
      RedPointDataUtils.InitNotOwnAwakerRed(awakerTid)
    end
  else
    awakers = awakerDU.GetOwnedAwakerMap()
  end
  local baseSkillSlot = DT.GetConstant("AwakerSkillListNum")
  for tid, awaker in pairs(awakers) do
    local canUpgrade = false
    local canBreakthrough = awakerDU.IsCanBreakthrough(tid)
    redpoint[RedPointDataUtils.RedType.AwakerBreakthrough][tid] = redpoint[RedPointDataUtils.RedType.AwakerBreakthrough][tid] or {}
    redpoint[RedPointDataUtils.RedType.AwakerBreakthrough][tid].red = canBreakthrough and 1 or 0
    if awaker.skills then
      redpoint[RedPointDataUtils.RedType.AwakerSkill][tid] = redpoint[RedPointDataUtils.RedType.AwakerSkill][tid] or {}
      local skillRed = redpoint[RedPointDataUtils.RedType.AwakerSkill][tid]
      local tmp = {}
      local length = #DT.AwakerConfig[awaker.tid].SkillList
      for i = 1, math.min(length, baseSkillSlot) do
        tmp[i] = awaker.skills[i]
      end
      for slot, _ in ipairs(tmp) do
        skillRed[slot] = skillRed[slot] or {}
        skillRed[slot].red = awakerDU.IsSlotCanUpgrade(awaker, slot) and 1 or 0
      end
      for slot, skill in ipairs(awaker.skills) do
        if skill and skill.isBreakthroughSkill then
          skillRed[slot] = skillRed[slot] or {}
          skillRed[slot].red = awakerDU.CanBreakSkillActive(skill, awaker.currBreakthroughStar) and 1 or 0
        end
      end
    end
    local canPotencyUpgrade = awakerDU.HavePotencyCanUpgrade(awaker)
    redpoint[RedPointDataUtils.RedType.AwakerPotency][tid] = redpoint[RedPointDataUtils.RedType.AwakerPotency][tid] or {}
    redpoint[RedPointDataUtils.RedType.AwakerPotency][tid].red = canPotencyUpgrade and 1 or 0
    if awaker.trinkets then
      redpoint[RedPointDataUtils.RedType.AwakerTrinket][tid] = redpoint[RedPointDataUtils.RedType.AwakerTrinket][tid] or {}
      for i = 1, 6 do
        local redData = redpoint[RedPointDataUtils.RedType.AwakerTrinket][tid][i]
        if not redData then
          redData = {red = 0}
          redpoint[RedPointDataUtils.RedType.AwakerTrinket][tid][i] = redData
        end
        local hasRed = RedPointDataUtils.HasAwakerTrinketPartRed(tid, i)
        redData.red = hasRed and 1 or 0
      end
    end
    local showBackTrackRed = RedPointDataUtils.IsBackTrackShowRed(tid)
    redpoint[RedPointDataUtils.RedType.Awaker][tid] = redpoint[RedPointDataUtils.RedType.Awaker][tid] or {}
    redpoint[RedPointDataUtils.RedType.Awaker][tid].red = (canPotencyUpgrade or canUpgrade or showBackTrackRed) and 1 or 0
  end
end

function RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
  local redDatas = RedPointDataUtils.GetRedData(RedPointDataUtils.RedType.NewLotteryOpen)
  if not redDatas or type(redDatas) ~= "table" or not table.next(redDatas) then
    return false
  end
  local now = TimeUtils.GetServerTime()
  if not lotteryTid then
    for tid, redData in pairs(redDatas) do
      local cfg = DT.Lottery[tid]
      if not cfg then
      elseif cfg.OpenDate and now < cfg.OpenDate or cfg.CloseDate and now > cfg.CloseDate then
      elseif redData and redData.isNew and redData.isNew >= 1 then
        return RedPointDataUtils.RedAttrType.IsNew
      end
    end
    return false
  end
  local cfg = DT.Lottery[lotteryTid] or {}
  if now < (cfg.OpenDate or 0) or now > (cfg.CloseDate or math.huge) then
    return false
  end
  if redDatas[lotteryTid] and redDatas[lotteryTid].isNew and redDatas[lotteryTid].isNew >= 1 then
    return RedPointDataUtils.RedAttrType.IsNew
  end
  return false
end

function RedPointDataUtils.UpdateShopRed()
  local MainShopDataUtils = require("Data.MainShopDataUtils")
  if MainShopDataUtils.IsInitData() == false then
    return
  end
  local redpoint = DataCenter.redPointData
  if not redpoint[RedPointDataUtils.RedType.MainShop] then
    redpoint[RedPointDataUtils.RedType.MainShop] = {}
  end
  local mainShopRedData = redpoint[RedPointDataUtils.RedType.MainShop]
  for _, v in pairs(DT.ShopType) do
    local shopType = v.ID
    local isRed = MainShopDataUtils.HasFreeGoods(shopType)
    local redVal = isRed and 1 or 0
    if not mainShopRedData[shopType] then
      mainShopRedData[shopType] = {red = redVal}
    else
      mainShopRedData[shopType].red = redVal
    end
  end
end

function RedPointDataUtils.GetAwakerRedData(awakerTid, withoutOriUnlock)
  local retData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Awaker, awakerTid)
  if not retData then
    return {red = 0}
  end
  for _, value in pairs(retData) do
    if value and value >= 1 then
      return retData
    end
  end
  local AwakerRedUtils = require("Data.RedData.AwakerRedUtils")
  local breakthroughRedData = AwakerRedUtils.GetBreakthroughRedData(awakerTid)
  if breakthroughRedData and breakthroughRedData.red and breakthroughRedData.red >= 1 then
    return breakthroughRedData
  end
  if RedPointDataUtils.HasAwakerAffectionRedShow(awakerTid) or RedPointDataUtils.IsAwakerAffectionBreakthroughRedShow(awakerTid) then
    return {red = 1}
  end
  if not withoutOriUnlock and RedPointDataUtils.CanUnlock_OriAwaker(awakerTid) then
    return {red = 1}
  end
end

function RedPointDataUtils.UpdateTrinketCopyRed(copyID, value)
  local redpoint = DataCenter.redPointData
  if not redpoint[RedPointDataUtils.RedType.TrinketCopy] then
    redpoint[RedPointDataUtils.RedType.TrinketCopy] = {}
  end
  redpoint[RedPointDataUtils.RedType.TrinketCopy][copyID] = {red = value}
end

function RedPointDataUtils.HasAwakerTrinketPartRed(awakerTid, part)
  if not awakerTid or not part then
    return false
  end
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return false
  end
  local trinketData
  if awakerData.trinkets then
    for _part, uid in pairs(awakerData.trinkets) do
      if _part == part then
        trinketData = ItemDataUtils.GetItemByUid(uid)
        break
      end
    end
  end
  if nil == trinketData then
    local trinketPosItemMap = ItemDataUtils.GetTrinketMapByPos(part)
    for _, trinket in pairs(trinketPosItemMap) do
      if trinket and (not trinket.awaker or 0 == trinket.awaker) then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.HasAwakerTrinketRed(awakerTid)
  for i = 1, 6 do
    local red = RedPointDataUtils.HasAwakerTrinketPartRed(awakerTid, i)
    if red then
      return red
    end
  end
  return false
end

function RedPointDataUtils.HasAwakerWeaponRed(awakerTid)
  if not awakerTid then
    return false
  end
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return false
  end
  if not ItemDataUtils.HasEquipableGoodWeapon() then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local primaryWeaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, cd.WeaponSlotType.Primary)
  local secondaryWeaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, cd.WeaponSlotType.Secondary)
  if primaryWeaponSlot.unlocked and 0 == primaryWeaponSlot.weaponUid or secondaryWeaponSlot.unlocked and 0 == secondaryWeaponSlot.weaponUid then
    local equipedWeaponCfg
    if 0 ~= primaryWeaponSlot.weaponUid then
      local equipedWeapon = ItemDataUtils.GetItemByUid(primaryWeaponSlot.weaponUid)
      equipedWeaponCfg = DT.Item[equipedWeapon.tid]
    end
    if 0 ~= secondaryWeaponSlot.weaponUid then
      local equipedWeapon = ItemDataUtils.GetItemByUid(secondaryWeaponSlot.weaponUid)
      equipedWeaponCfg = DT.Item[equipedWeapon.tid]
    end
    if not equipedWeaponCfg then
      return true
    end
    local weaponMap = ItemDataUtils.GetEquipableGoodWeaponMap()
    for _, weapon in pairs(weaponMap) do
      local weaponCfg = DT.Item[weapon.tid]
      if weaponCfg.ID ~= equipedWeaponCfg.ID and (equipedWeaponCfg.Quality ~= "Orange" or weaponCfg.Quality ~= "Orange") then
        return true
      end
    end
  end
  return false
end

function RedPointDataUtils.HasAwakerWeaponEquipRed(awakerTid)
  if not awakerTid then
    return false
  end
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local slotType = cd.WeaponSlotType
  local primaryWeaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, slotType.Primary)
  local secondaryWeaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, slotType.Secondary)
  if primaryWeaponSlot.unlocked and primaryWeaponSlot.weaponUid > 0 and secondaryWeaponSlot.unlocked and secondaryWeaponSlot.weaponUid > 0 then
    return false
  end
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    local config = ItemDataUtils.GetItemConfig(v.tid)
    if config.Type == cd.ItemType.Weapon and (not v.awaker or 0 == v.awaker) then
      return true
    end
  end
  return false
end

function RedPointDataUtils.GetDonationBoxRed(args)
  local ret = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.ProduceBox, args)
  if ret then
    return ret
  end
  do return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.DonationBox end
  return RedPointDataUtils.GetRedPointState, RedTypeDefine.RedType.DonationBox, args
end

function RedPointDataUtils.IsShowBattleTeachingEntryRed()
  local stageGroupCfgList = StageGroupCfgUtils.GetDisplayStageGroupByType(CommonDefine.StageGroupType.BattleTeaching)
  for _, stageGroupCfg in pairs(stageGroupCfgList or {}) do
    local stageTidList = StageCfgUtils.GetStageTidListByStageGroupId(stageGroupCfg.ID)
    for _, stageTid in pairs(stageTidList or {}) do
      if RedPointDataUtils.IsShowBattleTeachingItemRed(stageTid) then
        return RedPointDataUtils.RedAttrType.IsNew
      end
    end
  end
  return false
end

function RedPointDataUtils.ClearBattleTeachingItemRed(stageTid)
  RedPointDataUtils.ClearClientRed(CommonDefine.ClientDataMainKey.BattleTeachingStage, tostring(stageTid))
end

function RedPointDataUtils.IsShowBattleTeachingItemRed(stageTid)
  do return RedPointDataUtils.IsShowClientRed, CommonDefine.ClientDataMainKey.BattleTeachingStage, (tostring(stageTid)) end
  return RedPointDataUtils.IsShowClientRed, CommonDefine.ClientDataMainKey.BattleTeachingStage, tostring(stageTid), RedPointDataUtils.RedAttrType.IsNew
end

function RedPointDataUtils.GetCommunityRed()
  if 1 ~= PlayerDataUtils.GetTranslateGratitudeRewardStatsData() then
    return RedPointDataUtils.RedAttrType.Red
  end
  local pkgInfo = SdkMgr.Instance:GetPkgInfo()
  local publishArea = pkgInfo and pkgInfo.publish_area
  for _, communityName in pairs(CommunityDefine.CommunityName) do
    local communityUrl = CommunityCfgUtils.GetCommunityUrl(communityName, publishArea)
    if communityUrl and 1 ~= PlayerDataUtils.GetAttentionCommunityStatsData(communityName) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.GetDailyTaskRedPoint()
  local tid = DataCenter.taskData.dailyTaskTid
  return TaskDataUtils.IsTaskCanReward(tid) and RedPointDataUtils.RedAttrType.Red or false
end

function RedPointDataUtils.GetWeekTaskRedPoint()
  local isHaveWeekReward = DailyChallengeModel.Instance:IsHaveWeekReward()
  return isHaveWeekReward and RedPointDataUtils.RedAttrType.Red or false
end

function RedPointDataUtils.GetDailyAchievementRed(taskList)
  if type(taskList) ~= "table" then
    taskList = {taskList}
  end
  return RedPointDataUtils.RedAttrType.Red or false
end

function RedPointDataUtils.IsShowDailyCopyNew()
  local dailyStageGroupId = DT.Constant.DailyChallengedSelecStageLevel.Data
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, dailyStageGroupId)
  if not unlocked then
    return false
  end
  local ret = RedPointDataUtils.IsShowDailyChallengeExpRewardNew()
  if ret then
    return ret
  end
  ret = RedPointDataUtils.IsShowDailyChallengeAchieveRewardNew()
  if ret then
    return ret
  end
  if RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(CommonDefine.SeasonGameplayType.ConsciousnessDiving) then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

function RedPointDataUtils.IsShowDailyChallengeAchieveRewardNew(parentTaskId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return DailyChallengeDataUtils.IsHaveAchievementReward end
  return DailyChallengeDataUtils.IsHaveAchievementReward, parentTaskId
end

function RedPointDataUtils.IsShowDailyChallengeExpRewardNew()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  for level = 1, DungeonTaskDataModel.Instance.maxLv do
    if CareerLevelModel.Instance:IsCareerLevelCanReceive(DailyChallengeDataUtils.careerLevelType, level) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.IsHaveLoginRewardToReceive()
  for _, rewardType in pairs(SettingDefine.LoginRewardType) do
    local state = SettingModel.Instance:GetLoginRewardState(rewardType)
    if state == CommonDefine.CommonState.GainPrize then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function RedPointDataUtils.ResetAll()
end

return RedPointDataUtils
