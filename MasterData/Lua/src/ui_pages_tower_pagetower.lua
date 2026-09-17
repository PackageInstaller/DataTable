local this = class("pageTower", G_UIPageBase)
local towerTpl = L_GameTpl:getTowerTpl()

function this.bind()
  return {
    towerTitleText = "",
    seasonCountdownText = "",
    roundCountdownText = "",
    scoreText = "",
    battleEntryList = {
      moduleName = "pages/tower/moduleTowerBattleEntryItem"
    },
    moduleTowerTagDes = {
      moduleName = "pages/tower/moduleTowerTagDes"
    },
    activeTagDes = false
  }
end

function this.methods()
  return {
    onClick_scoreRewardBtn = function(self)
      L_UI:open("pageTowerScoreReward")
    end,
    onClick_buffPreviewBtn = function(self)
      self.bind.activeTagDes = true
    end
  }
end

function this:preOpen(options)
  L_TowerStore:listenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
  L_TowerStore:listenCallFunc(L_TowerStore.event.refreshTowerData, self.onRefreshTowerData, self)
  this.super.preOpen(self, options)
  self:updatePage()
end

function this:updatePage()
  self:updateTopBar()
  self:updateEntryList()
  self:updateTowerScore()
  self:setCountdown()
  local towerId = L_TowerStore:getTowerId()
  local towerConfig = towerTpl:getTplById(towerId)
  self.bind.towerTitleText = towerTpl:getTowerName(towerConfig)
  self.modules.moduleTowerTagDes:initView({
    callback = function()
      self.bind.activeTagDes = false
    end,
    title = L_WordsTpl:getValue(L_TowerConst.text.tag_title),
    des = towerTpl:getBuffDescription(towerConfig)
  })
end

function this:onRefreshTowerData()
  local st = L_UI:getPageStatus("pageTowerFormation")
  if st and st == "shown" then
    L_UI:close("pageTowerFormation")
  end
  self:updatePage()
end

function this:onRefreshTowerScore()
  self:updateTowerScore()
  self:setCountdown()
end

function this:setCountdown()
  self.bind.seasonCountdownText = L_WordsTpl:getValue(L_TowerConst.text.next_season_count, {
    [0] = 90
  })
  if self.roundTimer then
    Timer.remove(self.roundTimer)
  end
  self.bind.roundCountdownText = L_WordsTpl:getValue(L_TowerConst.text.next_round_count, {
    [0] = L_TimeUtil.getLeftWeekRefreshTime(true)
  })
  self.roundTimer = Timer.repeated(1, function()
    self.bind.roundCountdownText = L_WordsTpl:getValue(L_TowerConst.text.next_round_count, {
      [0] = L_TimeUtil.getLeftWeekRefreshTime(true)
    })
  end, self, self.gameObject)
end

function this:updateTopBar()
end

function this:updateEntryList()
  self.bind.battleEntryList:clear()
  local towerId = L_TowerStore:getTowerId()
  local battles = L_TowerManager:getTowerBattlesByTowerId(towerId)
  self.bind.battleEntryList:insert_array(battles)
end

function this:updateTowerScore()
  local currentScore = L_TowerStore:getTowerScore()
  local maxScore = L_TowerManager:getMaxScore()
  self.bind.scoreText = string.format(L_TowerConst.text.tower_score_text, currentScore, maxScore)
end

function this:close(options)
  this.super.close(self, options)
  L_TowerStore:unListenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
  L_TowerStore:unListenCallFunc(L_TowerStore.event.refreshTowerData, self.onRefreshTowerData, self)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.climbTower)
  callback(result)
end

return this
