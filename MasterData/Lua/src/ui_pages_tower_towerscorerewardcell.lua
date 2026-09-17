local module = class("towerScoreRewardCell", G_UIModuleBase)

function module.bind()
  return {
    rewardedIconActive = false,
    greyBtnActive = false,
    getBtnActive = false,
    notifyBtnActive = false,
    scoreDesText = "",
    rewardList = L_Const.ModuleInfo.CellIcon
  }
end

function module.methods()
  return {
    onClick_getBtn = function(self)
      L_TowerStore:req_towerScoreReward(self.bind.id, function()
      end)
    end
  }
end

function module:refresh()
  self.bind.scoreDesText = L_WordsTpl:getValue(L_TowerConst.text.tower_score_arrive_text, {
    [0] = tostring(self.bind.score)
  })
  local isRewardGot = L_TowerManager:isScoreRewardGot(self.bind.id)
  local isReachScore = L_TowerManager:isReachScore(self.bind.score)
  self.bind.rewardedIconActive = isRewardGot
  self.bind.greyBtnActive = false
  if isRewardGot then
    self.bind.getBtnActive = false
    self.bind.notifyBtnActive = false
  else
    self.bind.getBtnActive = isReachScore
    self.bind.notifyBtnActive = not isReachScore
  end
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(self.bind.reward)
end

return module
