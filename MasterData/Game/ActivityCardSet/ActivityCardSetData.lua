local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityCardSetData = class("ActivityCardSetData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.CardSet
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ActivityCardSetData:InitActCardSetData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  local actId = self:GetActId()
  self.__cardSetMainCfg = ConfigData.activity_card_main[actId]
  self:UpdateCardSetData(msg)
  self:_InitDifficultRead(actId)
end

function ActivityCardSetData:_InitDifficultRead(actId)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local cfgTab = ConfigData.activity_card_diff[actId]
  for diffId, cfg in pairs(cfgTab) do
    if cfg.is_unlock_default then
      saveUserData:SetCardSetDifficultRead(actId, diffId)
    end
  end
end

function ActivityCardSetData:UpdateCardSetData(msg)
  self.__highestScore = 0
  local oldDataDic = self.__dataDic or table.emptytable
  self.__dataDic = {}
  for _, storageMsg in pairs(msg.storage) do
    local cat = storageMsg.cat
    if cat == CardSetEnum.eSetType.normal and oldDataDic[cat] ~= nil and oldDataDic[cat].round ~= storageMsg.round then
      local lastDiffPassTimesDic = oldDataDic[cat].diffPassTimes
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local actId = self:GetActId()
      saveUserData:SetCardSetLastDiffPassTimesDic(actId, lastDiffPassTimesDic)
    end
    self.__dataDic[cat] = storageMsg
  end
  self.__diffpassTimesDic = msg.passTimes
  self.__usedCardDic = msg.useDiffCards
  self.__usedDiffCardNum = 0
  self.__rewindDataDic = msg.normalHistoryRoundData
  self:GenUsedDiffCardNum()
  self.__rankRoundData = msg.rankRoundData
  for k, v in pairs(msg.rankPassData) do
    self.__highestScore = self.__highestScore + v.score
  end
  if self.__lastRankRoundId == nil or self.__lastRankRoundId == 0 then
    self.__lastRankRoundId = msg.lastRankRoundId
  end
  self:_UpdBpReward(msg.bp)
  self:__RefreshlAllRedBuleDot()
end

function ActivityCardSetData:GetCdStDataByCat(cat)
  return self.__dataDic[cat]
end

function ActivityCardSetData:SetActCdStLastPlayMode(playType)
  self.__lastPlayType = playType
end

function ActivityCardSetData:GetActCdStLastPlayMode()
  return self.__lastPlayType
end

function ActivityCardSetData:GenUsedDiffCardNum()
  self.__usedDiffCardNum = 0
  for cardId, num in pairs(self.__usedCardDic) do
    self.__usedDiffCardNum = self.__usedDiffCardNum + 1
  end
end

function ActivityCardSetData:GetCardSetDungeonId()
  return self.__cardSetMainCfg.dungeon_id
end

function ActivityCardSetData:GetCardSetNormalModeDiffList()
  return self.__cardSetMainCfg.normal_diff
end

function ActivityCardSetData:GetCardSetRankModeDiffList()
  return self.__cardSetMainCfg.rank_diff
end

function ActivityCardSetData:GetActCardSetPassDiffTimes(playType, diffId)
  local storageMsg = self:GetCdStDataByCat(playType)
  return storageMsg and storageMsg.diffPassTimes[diffId] or 0
end

function ActivityCardSetData:IsUnlockActCardSetRank()
  local cfg = self.__cardSetMainCfg
  return CheckCondition.CheckLua(cfg.rank_unlock_condition, cfg.pre_para1, cfg.pre_para2, cfg.pre_para3)
end

function ActivityCardSetData:GetUnlockDesActCardSetRank()
  local cfg = self.__cardSetMainCfg
  return CheckCondition.GetUnlockInfoLua(cfg.rank_unlock_condition, cfg.pre_para1, cfg.pre_para2, cfg.pre_para3)
end

function ActivityCardSetData:GetUnlockActCardSetRankTs()
  local cfg = self.__cardSetMainCfg
  for index, coditon in ipairs(cfg.rank_unlock_condition) do
    if coditon == CheckerTypeId.TimeRange then
      local startTime = cfg.pre_para1[index]
      return true, startTime
    end
  end
  return false
end

function ActivityCardSetData:IsUnlockActCardSetRewind()
  local cfg = self.__cardSetMainCfg
  return CheckCondition.CheckLua(cfg.revert_unlock_condition, cfg.revert_pre_para1, cfg.revert_pre_para2, cfg.revert_pre_para3)
end

function ActivityCardSetData:GetUnlockDesActCardSetRewind()
  local cfg = self.__cardSetMainCfg
  return CheckCondition.GetUnlockInfoLua(cfg.revert_unlock_condition, cfg.revert_pre_para1, cfg.revert_pre_para2, cfg.revert_pre_para3)
end

function ActivityCardSetData:GetActCardSetRankId()
  return self.__cardSetMainCfg.rank_id
end

function ActivityCardSetData:GetActCardSetRankHighestScore()
  return self.__highestScore
end

function ActivityCardSetData:JedgeIsCadrdSetDiffPassed(diffId, needNum)
  return (self.__diffpassTimesDic[diffId] or 0) >= (needNum or 1)
end

function ActivityCardSetData:GetCadrdSetDiffPassedTimes(diffId)
  return self.__diffpassTimesDic[diffId] or 0
end

function ActivityCardSetData:JedgeIsCadrdSetUsedDiffCard(num)
  return num <= self.__usedDiffCardNum
end

function ActivityCardSetData:GetCadrdSetUsedDiffCard()
  return self.__usedDiffCardNum
end

function ActivityCardSetData:JedgeIsCadrdSetUseCard4CertainTimes(cardId, needNum)
  return (self.__usedCardDic[cardId] or 0) >= (needNum or 1)
end

function ActivityCardSetData:IsCardSetNormalRoundComplete(roundId)
  local normalMsg = self.__dataDic[CardSetEnum.eSetType.normal]
  if normalMsg == nil then
    return false
  end
  return roundId < normalMsg.round
end

function ActivityCardSetData:GetCadrdSetUseCard4CertainTimes(cardId)
  return self.__usedCardDic[cardId] or 0
end

function ActivityCardSetData:_UpdBpReward(bpMsg)
  if self.__bpMsg ~= nil and self.__bpMsg.level == bpMsg.level and self.__bpMsg.exp == bpMsg.exp and self.__bpMsg.rewardLv == bpMsg.rewardLv then
    return
  end
  self.__bpMsg = bpMsg
  MsgCenter:Broadcast(eMsgEventId.OnCardSetBpChange)
end

function ActivityCardSetData:GetCsRewardBpCfg()
  if self.__cardSetMainCfg.reward_bp_id == 0 then
    return nil
  end
  local cfg = ConfigData.activity_card_reward_bp[self.__cardSetMainCfg.reward_bp_id]
  if cfg == nil then
    error("cant get activity_card_reward_bp, id:" .. tostring(self.__cardSetMainCfg.reward_bp_id))
  end
  return cfg
end

function ActivityCardSetData:GetCsBpLevel()
  return self.__bpMsg.level, self.__bpMsg.exp
end

function ActivityCardSetData:GetCsBpRewardTotalExp()
  local curLv, curEpx = self:GetCsBpLevel()
  local totalExp = curEpx
  for i = 1, curLv - 1 do
    local lvCfg = self:GetCsBpLevelCfg(i)
    totalExp = totalExp + lvCfg.need_num
  end
  return totalExp
end

function ActivityCardSetData:GetCsBpLevelPicked()
  return self.__bpMsg.rewardLv
end

function ActivityCardSetData:GetCsBpLevelCfg(level)
  local rewardCfgList = self:GetCsRewardBpCfg()
  if rewardCfgList == nil then
    return
  end
  local rewardCfg
  if level > #rewardCfgList then
    rewardCfg = rewardCfgList[#rewardCfgList]
  else
    rewardCfg = rewardCfgList[level]
  end
  return rewardCfg
end

function ActivityCardSetData:IsCsBpCanPickReward()
  if self.__bpMsg == nil then
    return false
  end
  return self.__bpMsg.level > self.__bpMsg.rewardLv
end

function ActivityCardSetData:GetCardSetRewardItemId()
  return self.__cardSetMainCfg.reward_item_id
end

function ActivityCardSetData:GetCardSetScoreItemId()
  return self.__cardSetMainCfg.score_item_id
end

function ActivityCardSetData:GetCardSetScoreItemIdByType(cardType)
  if cardType == CardSetEnum.eSetType.rank then
    return self:GetCardSetScoreItemId()
  else
    return self:GetCardSetRewardItemId()
  end
end

function ActivityCardSetData:GetCardSetPotionItemId()
  return self.__cardSetMainCfg.potion_item_id
end

function ActivityCardSetData:IsActCardSetTicketsEnough()
  return PlayerDataCenter:GetItemCount(self.__cardSetMainCfg.tickets_id) >= self.__cardSetMainCfg.tickets_num or PlayerDataCenter:GetItemCount(self.__cardSetMainCfg.timed_tickets_id) >= self.__cardSetMainCfg.timed_tickets_num
end

function ActivityCardSetData:GetActCardSetTicketsId()
  return self.__cardSetMainCfg.tickets_id
end

function ActivityCardSetData:GetActCardSetTimeTicketsId()
  return self.__cardSetMainCfg.timed_tickets_id
end

function ActivityCardSetData:GetActCardSetMainResIdList()
  return self.__cardSetMainCfg.resource_item_id
end

function ActivityCardSetData:GetActCardSetMainGuideId()
  return self.__cardSetMainCfg.guide_id
end

function ActivityCardSetData:GetActCardSetTipsId()
  return self.__cardSetMainCfg.tips_id
end

function ActivityCardSetData:GetActCardSetRewardTaskIdList()
  local actGeneralCfg = ConfigData.activity_general[self:GetActFrameId()]
  if actGeneralCfg == nil then
    return {}
  end
  return actGeneralCfg.once_quest
end

function ActivityCardSetData:GetActCardSetRewindDataDic()
  return self.__rewindDataDic
end

function ActivityCardSetData:GetActCardSetRoundBestScore(roundId)
  local roundMsg = self.__rewindDataDic[roundId]
  return roundMsg and roundMsg.rewardScore or 0
end

function ActivityCardSetData:GetActCsRankRoundMsg()
  return self.__rankRoundData
end

function ActivityCardSetData:GetActCsRankLastRoundId()
  if self.__lastRankRoundId == nil or self.__lastRankRoundId == 0 then
    return 1
  end
  return self.__lastRankRoundId
end

function ActivityCardSetData:RefreshCardSetBlueFirstEnterRankTask()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local node = actRed:AddChild(CardSetEnum.reddotType.firstEnterTaskBlue)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self:GetActId()
  local isEntereted = saveUserData:GetCardSetIsEnterRankTask(actId)
  if not isEntereted then
    node:SetRedDotCount(1)
    return
  end
  node:SetRedDotCount(0)
end

function ActivityCardSetData:RefreshCardSetRedRankTask()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local node = actRed:AddChild(CardSetEnum.reddotType.rankTask)
  local taskList = self:GetActCardSetRewardTaskIdList()
  for _, taskId in ipairs(taskList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData:CheckComplete() then
      node:SetRedDotCount(1)
      return
    end
  end
  node:SetRedDotCount(0)
end

function ActivityCardSetData:RefreshCardSetRedBpReward()
  local node = self:GetActChildRedDot(CardSetEnum.reddotType.bpReward)
  node:SetRedDotCount(self:IsCsBpCanPickReward() and 1 or 0)
end

function ActivityCardSetData:__RefreshlAllRedBuleDot()
  self:RefreshCardSetRedRankTask()
  self:RefreshCardSetBlueFirstEnterRankTask()
  self:RefreshCardSetRedBpReward()
end

function ActivityCardSetData:ReSetActivityReddotRoot(reddotNode)
  local oldNode = self:GetActivityReddot()
  for _, nodeId in pairs(CardSetEnum.reddotType) do
    oldNode:RemoveChild(nodeId)
  end
  self.__reddotCumstomRootNode = reddotNode
  self:__RefreshlAllRedBuleDot()
end

function ActivityCardSetData:GetActivityReddot()
  if self.__reddotCumstomRootNode ~= nil then
    return self.__reddotCumstomRootNode
  end
  if self.actInfo == nil then
    return nil
  end
  return self.actInfo:GetActivityReddotNode()
end

function ActivityCardSetData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(CardSetEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityCardSetData:SetActCsRankLastRoundId(roundId)
  self.__lastRankRoundId = roundId
end

return ActivityCardSetData
