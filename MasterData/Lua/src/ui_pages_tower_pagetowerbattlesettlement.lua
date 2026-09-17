local this = class("pageTowerBattleSettlement", G_UIPageBase)

function this.bind()
  return {
    passTimeText = "",
    scoreText = "",
    rewardList = L_Const.ModuleInfo.CellIcon,
    repeatReward = L_Const.ModuleInfo.CellIcon
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      if self.battleData.closePageCallback then
        self.battleData.closePageCallback()
      end
      L_UI:close(self.pageName)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.climbTower)
      L_TowerManager:setCurrentBattleData(nil)
    end
  }
end

function this:preOpen(options)
  self.battleData = options
  this.super.preOpen(self, options)
  self:updatePage()
end

function this:updatePage()
  local currentScore = L_TowerStore:getTowerScore()
  local maxScore = L_TowerManager:getMaxScore()
  self.bind.scoreText = string.format(L_TowerConst.text.tower_score_text, currentScore, maxScore)
  self.modules.repeatReward:setGeneralContent(3, 354008, {
    itemNum = self.battleData.scoreReward
  })
  self:updateRewardList()
  local startTime = L_TowerManager:getBattleStartTime()
  self.bind.passTimeText = L_TimeUtil.secondToLangString(L_TimeUtil.getServerTime() - startTime)
end

function this:updateRewardList()
  local rewards = L_DataUtil.parseRewardConfig(self.battleData.reward)
  local isGot = self.battleData.isPassBattle
  for _, reward in ipairs(rewards) do
    reward.activeReward = isGot
  end
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(rewards)
end

function this:escHandle()
end

return this
