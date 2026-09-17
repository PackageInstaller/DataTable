local this = {}
local _dungeonEntrustDifficultyTpl = L_GameTpl:getDungeonEntrustDifficultyTpl()
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()

function this:init()
  this.super.init(self)
  self.data = {
    entrustInfo = {},
    entrustReward = {},
    trainTaskRecord = {},
    entrustKiboInfo = {},
    multiCoopInfo = {},
    multiCoopReward = {},
    runeInfoRecord = {}
  }
end

function this:getFirstCanReceiveStarNum(entrustType, difficulty)
  difficulty = difficulty or 0
  local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(entrustType, difficulty)
  if not modeInfo then
    return 0, -1
  end
  for _, v in ipairs(modeInfo) do
    if not self:checkEntrustRewardReceived(v.id) then
      return v.starNum, v.id
    end
  end
  return modeInfo[#modeInfo].starNum, -1
end

function this:getCanReceiveRewardIdList(entrustType, curStarNum, difficulty)
  difficulty = difficulty or 0
  local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(entrustType, difficulty)
  if not modeInfo then
    return nil
  end
  local rewardIdList
  for _, v in ipairs(modeInfo) do
    if curStarNum >= v.starNum and not self:checkEntrustRewardReceived(v.id) then
      rewardIdList = rewardIdList or {}
      table.insert(rewardIdList, v.id)
    end
  end
  return rewardIdList
end

function this:getEntrustStarNumByDifficulty(entrustType, difficulty)
  local starNum = 0
  if entrustType == L_Const.EntrustTypeEnum.AreaEntrust then
    for id, v in pairs(self.data.entrustInfo) do
      local cfg = _dungeonEntrustTpl:getTplById(id)
      if cfg then
        starNum = starNum + v.entrust_star
      else
        warn("配置中不存在的数据：" .. tostring(id))
      end
    end
    return starNum
  elseif entrustType == L_Const.EntrustTypeEnum.PetDuel then
    for id, v in pairs(self.data.entrustKiboInfo) do
      starNum = starNum + v.entrust_star
    end
  end
  return starNum
end

function this:getEntrustLevelStar(levelId)
  if not self.data.entrustInfo[levelId] then
    return 0
  end
  return self.data.entrustInfo[levelId].entrust_star
end

function this:getEntrustLevelStarBit(levelId)
  if not self.data.entrustInfo[levelId] then
    return 0
  end
  return self.data.entrustInfo[levelId].star
end

function this:getEntrustKiboLevelStar(levelId)
  if not self.data.entrustKiboInfo[levelId] then
    return 0
  end
  return self.data.entrustKiboInfo[levelId].entrust_star
end

function this:getEntrustKiboLevelStarBit(levelId)
  if not self.data.entrustKiboInfo[levelId] then
    return 0
  end
  return self.data.entrustKiboInfo[levelId].star
end

function this:getEntrustKiboSucTime(levelId)
  if not self.data.entrustKiboInfo[levelId] then
    return 0
  end
  return self.data.entrustKiboInfo[levelId].success_time
end

function this:checkEntrustKiboBattleSuc(levelIdLevel)
  if levelIdLevel == nil then
    return true
  end
  if #levelIdLevel == 0 then
    return true
  elseif 1 < #levelIdLevel then
    errorf("kibo battle levelIdLevel length > 1")
  end
  local levelId = levelIdLevel[1]
  if self.data.entrustKiboInfo[levelId] == nil then
    return false
  end
  return 0 < self.data.entrustKiboInfo[levelId].success_time
end

function this:isEntrustKiboBattleLevel(levelId)
  if levelId == nil then
    return false
  end
  local duelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
  local list = duelGroupTpl:getValue()
  for level_id, v in pairs(list) do
    if level_id == levelId then
      return true
    end
  end
  return false
end

function this:isActivityEntrustLevel(levelId)
  if levelId == nil then
    return false
  end
  local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local list = gameEventKiboDuleTpl:getData()
  for level_id, v in pairs(list) do
    if v.kiboDuelId == levelId then
      return true
    end
  end
  return false
end

function this:getEntrustBuffByLevelId(levelId)
  if levelId == nil then
    return false
  end
  local buffList = {}
  local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local list = gameEventKiboDuleTpl:getData()
  for level_id, v in pairs(list) do
    if v.kiboDuelId == levelId then
      for _, buff in pairs(v.buff) do
        table.insert(buffList, buff)
      end
      break
    end
  end
  return buffList
end

function this:getActivityIdByDuelID(levelId)
  local activityId = 0
  if levelId == nil then
    return activityId
  end
  local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local list = gameEventKiboDuleTpl:getData()
  for level_id, v in pairs(list) do
    if v.kiboDuelId == levelId then
      activityId = level_id
      break
    end
  end
  return activityId
end

function this:checkEntrustLevelSuc(levelId)
  if not levelId then
    return false
  end
  return self:getEntrustLevelStar(levelId) > 0
end

function this:checkEntrustRewardReceived(rewardId)
  if not self.data.entrustReward[rewardId] then
    return false
  end
  return self.data.entrustReward[rewardId].reward_time > 0
end

function this:checkDifficultyUnlock(difficulty, bShowTips)
  local cfg = _dungeonEntrustDifficultyTpl:getTplById(difficulty)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonEntrustDifficultyTpl:getUnlockCondition(cfg))
  if not bShowTips then
    return isComplete
  end
  if not isComplete then
    local results = L_ConditionManager:getDescs(_dungeonEntrustDifficultyTpl:getUnlockCondition(cfg))
    L_FlyMsgManager:showNormalMsg(results[lockIndex])
    return false
  end
  return true
end

function this:checkEntrustLevelShow(levelId)
  local cfg = _dungeonEntrustTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonEntrustTpl:getTaskShow(cfg))
  return isComplete
end

function this:checkEntrustLevelUnlock(levelId)
  local cfg = _dungeonEntrustTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonEntrustTpl:getTaskUnlock(cfg))
  if not isComplete then
    local results = L_ConditionManager:getDescs(_dungeonEntrustTpl:getTaskUnlock(cfg))
    return isComplete, results[lockIndex]
  end
  return isComplete
end

function this:getMultiCoopLevelStar(levelId)
  if not self.data.multiCoopInfo[levelId] then
    return 0
  end
  return self.data.multiCoopInfo[levelId].entrust_rank, self.data.multiCoopInfo[levelId].entrust_score
end

function this:checkMultiCoopLevelSuc(levelId)
  if not levelId then
    return false
  end
  return self:getMultiCoopLevelStar(levelId) > 0
end

function this:checkMultiCoopLevelShow(levelId)
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonCrisisCrusadeTpl:getTaskShow(cfg))
  return isComplete
end

function this:checkMultiCoopLevelUnlock(levelId)
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_dungeonCrisisCrusadeTpl:getTaskUnlock(cfg))
  if not isComplete then
    local results = L_ConditionManager:getDescs(_dungeonCrisisCrusadeTpl:getTaskUnlock(cfg))
    return isComplete, results[lockIndex]
  end
  return isComplete
end

function this:getIsTrainTaskCompleted(trainTaskId)
  return self.data.trainTaskRecord[trainTaskId] == true
end

function this:setCurChallengeEntrustId(id)
  self.data.curChallengeEntrustId = id
end

function this:getCurChallengeEntrustId()
  return self.data.curChallengeEntrustId
end

function this:setIsRuneJump(bJump)
  self.data.runeInfoRecord.bRuneJump = bJump
end

function this:getIsRuneJump()
  return self.data.runeInfoRecord.bRuneJump
end

function this:setIsRuneRestore(value)
  self.data.bRuneRestore = value
end

function this:getIsRuneRestore()
  return self.data.bRuneRestore
end

function this:setRuneJumpEntrustId()
  return self.data.runeInfoRecord.EntrustId and self.data.runeInfoRecord.EntrustId or 0
end

function this:setCurLackRuneInfo(info)
  self.data.runeInfoRecord.runeId = info.runeId
  self.data.runeInfoRecord.needTargetNum = info.needTargetNum
  self.data.runeInfoRecord.heroGuid = info.heroGuid
  self.data.runeInfoRecord.canEquip = info.canEquip
  self.data.runeInfoRecord.currentRank = info.currentRank
  self.data.runeInfoRecord.heroGuid = info.heroGuid
  self.data.runeInfoRecord.isEquiped = info.isEquiped
  self.data.runeInfoRecord.slotId = info.slotId
  self.data.runeInfoRecord.itemId = info.itemId
  self.data.runeInfoRecord.EntrustId = info.EntrustId
  self.data.runeInfoRecord.curWorldId = AzurWorldInstance.CurWorldId
end

function this:getCurLackRuneId()
  return self.data.runeInfoRecord.runeId
end

function this:getRestoreCurWorldId()
  return self.data.runeInfoRecord.curWorldId
end

function this:getCurLackRuneItemId()
  return self.data.runeInfoRecord.itemId
end

function this:getCurLackRuneNum()
  return self.data.runeInfoRecord.needTargetNum
end

function this:setRuneComponentState(state)
  self.data.runeInfoRecord.state = state
end

function this:openRuneRelatedPage()
  print("==================AzurWorldInstance.CurWorldId", AzurWorldInstance.CurWorldId)
  if self.data.runeInfoRecord.curWorldId and AzurWorldInstance.CurWorldId and self.data.runeInfoRecord.curWorldId == AzurWorldInstance.CurWorldId and self:getIsRuneRestore() then
    if self.data.runeInfoRecord.state == 2 or self.data.runeInfoRecord.state == 3 then
      if self.data.runeInfoRecord.heroGuid then
        L_SystemBreakManager.jumpToPageHero(L_SystemConst.enum.science, {
          heroId = self.data.runeInfoRecord.heroGuid
        }, function()
          self:openPageHeroTalentInfo()
          self:clearRuneRecord()
        end)
      end
    else
      self:clearRuneRecord()
    end
  end
end

function this:openPageHeroTalentInfo(openCallBack)
  L_UI:open("pageHeroTalentInfo", {
    canEquip = self.data.runeInfoRecord.canEquip,
    currentRank = self.data.runeInfoRecord.currentRank,
    heroGuid = self.data.runeInfoRecord.heroGuid,
    isEquiped = self.data.runeInfoRecord.isEquiped,
    runeId = self.data.runeInfoRecord.runeId,
    slotId = self.data.runeInfoRecord.slotId
  }, function()
    if openCallBack then
      openCallBack()
    end
  end)
end

function this:openPageRuneCompose(openCallBack)
  L_UI:open("pageRuneCompose", {
    canEquip = self.data.runeInfoRecord.canEquip,
    currentRank = self.data.runeInfoRecord.currentRank,
    heroGuid = self.data.runeInfoRecord.heroGuid,
    isEquiped = self.data.runeInfoRecord.isEquiped,
    runeId = self.data.runeInfoRecord.runeId,
    slotId = self.data.runeInfoRecord.slotId,
    itemId = self.data.runeInfoRecord.itemId
  }, function()
    if openCallBack then
      openCallBack()
    end
  end)
end

function this:openRuneComposeTips()
  local bCanCompose, materiaList = L_RuneStore:bCanCompose(self.data.runeInfoRecord.itemId, 1)
  local data = {
    txtContent = L_WordsTpl:getValue("residual_code_entruststate_01"),
    itemList = materiaList,
    confirmCallback = function()
      print("=====================开始一键合成")
      
      local function callback(rspdata, rspData)
        if rspdata.equip then
          AzurWorld.heroMgr:ReqHeroRuneEquip(self.data.runeInfoRecord.heroGuid, {
            self.data.runeInfoRecord.slotId
          }, function(errCode, rspData)
            if L_UI:checkPageOpen("pageHeroTalentInfo") then
              L_UI:close("pageHeroTalentInfo")
            end
            Timer.once(2, function()
              self.isBreak = false
            end)
            L_AudioUtil.playSound("Play_SFX_System_UI_StarGift_Equip")
          end)
        end
      end
      
      local data = {
        item_id = self.data.runeInfoRecord.itemId,
        num = 1,
        equip = true
      }
      L_RuneStore:req_CSProtoComposeRune(data, callback)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:clearRuneRecord()
  self.data.runeInfoRecord = {}
  self.data.bRuneRestore = false
end

function this:refershKiboData()
  local _kiboDuleGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
  local dataList = _kiboDuleGroupTpl:getValue()
  for _, data in pairs(dataList) do
    local tpl = _kiboDuleGroupTpl:getTplById(data.id)
    local condition = _kiboDuleGroupTpl:getUnlockCondition(tpl)
    local tmp_lock, results, lockIndex = L_ConditionManager:isComplete(condition)
    local pre_level_id = _kiboDuleGroupTpl:getPreCondition(data.id)
    local is_unlock_pre_level = L_EntrustStore:checkEntrustKiboBattleSuc(pre_level_id)
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustBattleTask, data.id) and is_unlock_pre_level then
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.EntrustBattleTask, data.id)
    else
      L_ReddotManager:markNew(L_ReddotManager.DotDef.EntrustBattleTask, data.id)
    end
  end
end

return this
