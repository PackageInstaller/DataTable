local this = class("pageTowerScoreReward", G_UIPageBase)

function this.bind()
  return {
    scoreList = {
      moduleName = "pages/tower/towerScoreRewardCell"
    }
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  L_TowerStore:listenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
  L_TowerStore:listenCallFunc(L_TowerStore.event.refreshTowerScoreReward, self.onRefreshTowerScore, self)
  this.super.preOpen(self, options)
  self:updatePage()
end

function this:updatePage()
  self:updateScoreList()
end

function this:updateScoreList()
  self.bind.scoreList:clear()
  local rewards = L_TowerManager:getRewards()
  self.bind.scoreList:insert_array(rewards)
end

function this:onRefreshTowerScore()
  self:updatePage()
end

function this:close(options)
  this.super.close(self, options)
  L_TowerStore:unListenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
  L_TowerStore:unListenCallFunc(L_TowerStore.event.refreshTowerScoreReward, self.onRefreshTowerScore, self)
end

return this
