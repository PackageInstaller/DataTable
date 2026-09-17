local this = class("towerManager")
require("ui.manager.tower.towerConst")

function this:initReward()
  self.maxScore = 0
  self.rewards = {}
  local towerRewardTpl = L_GameTpl:getTowerRewardTpl()
  local config = towerRewardTpl:getConfig()
  for _, tpl in pairs(config) do
    local isRewarded = L_TowerManager:isScoreRewardGot(towerRewardTpl:getId(tpl))
    local prop = 0
    if isRewarded then
      prop = 10000
    end
    table.insert(self.rewards, {
      id = towerRewardTpl:getId(tpl),
      score = towerRewardTpl:getScore(tpl),
      reward = self:parseReward(towerRewardTpl:getReward(tpl), isRewarded),
      order = towerRewardTpl:getId(tpl) + prop
    })
    if towerRewardTpl:getScore(tpl) > self.maxScore then
      self.maxScore = towerRewardTpl:getScore(tpl)
    end
  end
  table.sort(self.rewards, function(a, b)
    return a.order < b.order
  end)
end

function this:parseReward(rewards, isRewarded)
  local res = {}
  for _, v in pairs(rewards) do
    table.insert(res, {
      itemType = v[1],
      itemId = v[2],
      activeReward = isRewarded,
      itemNum = v[3]
    })
  end
  return res
end

function this:getRewards()
  self:initReward()
  return self.rewards
end

function this:getMaxScore()
  if not self.maxScore then
    self:initReward()
  end
  return self.maxScore
end

function this:getTowerBattlesByTowerId(towerId)
  local towerBattleTpl = L_GameTpl:getTowerBattleTpl()
  local battles = towerBattleTpl:getTowerBattlesByTowerId(towerId)
  local res = {}
  for _, battle in ipairs(battles) do
    table.insert(res, {
      battleData = {
        Id = towerBattleTpl:getId(battle),
        towerId = towerId,
        order = towerBattleTpl:getOrder(battle),
        battleId = towerBattleTpl:getBattleId(battle),
        levelName = towerBattleTpl:getLevelName(battle),
        enemyId = towerBattleTpl:getEnemyId(battle),
        reward = towerBattleTpl:getReward(battle),
        scoreReward = towerBattleTpl:getScoreReward(battle)
      }
    })
  end
  table.sort(res, function(a, b)
    return a.battleData.order < b.battleData.order
  end)
  return res
end

function this:getTowerBattleData(towerId, order)
  local battles = self:getTowerBattlesByTowerId(towerId)
  for _, battle in ipairs(battles) do
    if battle.battleData.order == order then
      return battle.battleData
    end
  end
end

function this:isScoreRewardGot(Id)
  local scoreRewardRecord = L_TowerStore:getScoreRewardRecord()
  return table.containsValue(scoreRewardRecord, Id)
end

function this:isReachScore(score)
  local currentScore = L_TowerStore:getTowerScore()
  return score <= currentScore
end

function this:isBattlePassed(order)
  local firstRewardRecord = L_TowerStore:getFirstRewardRecord()
  return table.containsValue(firstRewardRecord, order)
end

function this:isBattleUnlocked(order)
  local firstRewardRecord = L_TowerStore:getFirstRewardRecord()
  local max = 0
  for _, v in ipairs(firstRewardRecord) do
    if v == order then
      return true
    end
    if v > max then
      max = v
    end
  end
  return order <= max + 1
end

function this:startTowerBattle(battleData)
  self.currentBattleData = battleData
  self.currentBattleData.isPassBattle = self:isBattlePassed(battleData.order)
  self.battleStartTime = L_TimeUtil.getServerTime()
  printf("pageTowerBattleStartTime", "pageTowerBattleStartTime: " .. self.battleStartTime)
end

function this:setCurrentBattleData(battleData)
  self.currentBattleData = battleData
end

function this:getCurrentBattleData()
  return self.currentBattleData
end

function this:getBattleStartTime()
  return self.battleStartTime
end

function this:getTowerFormation(order)
  local res = {}
  local posData = L_FormationStore:getFormationPosData(L_FormationConst.FormationType.tower, order)
  for _, heroId in ipairs(posData) do
    if not math.isEmpty(heroId) then
      table.insert(res, heroId)
    end
  end
  return res
end

function this:updateFormation(order, heroId)
  local formation = self:getTowerFormation(order)
  local res = {}
  local bRemove = false
  for k, id in ipairs(formation) do
    if id == heroId then
      bRemove = true
    else
      table.insert(res, {hero_id = id})
    end
  end
  if not bRemove then
    local heroMaxNum = L_GameTpl:getGameConstTpl():getData("FORMATION_NUMBER", L_Const.GameTplType.int)
    if heroMaxNum > #res then
      table.insert(res, {hero_id = heroId})
    end
  end
  return res
end

return this
