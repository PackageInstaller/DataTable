local this = class("towerStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "tower.towerState"))
this:importPartialClass(require(L_R.store .. "tower.towerAction"))
this.event = {
  refreshTowerData = "tower_refreshData",
  refreshTowerScore = "tower_refreshScore",
  refreshTowerScoreReward = "tower_refreshReward"
}

function this:getTowerId()
  return self.data.towerId
end

function this:getTowerScore()
  return self.data.score
end

function this:getScoreRewardRecord()
  return self.data.scoreRewardRecord
end

function this:getFirstRewardRecord()
  return self.data.firstRewardRecord
end

return this
