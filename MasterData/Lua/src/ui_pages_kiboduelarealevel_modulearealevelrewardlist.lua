local module = class("moduleAreaLevelRewardList", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.rewardDatas = {}
end

function module.bind()
  return {
    tabReward = L_Const.ModuleInfo.CellIconBag
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  self.bind.tabReward:clear()
  self.bind.tabReward:insert_array(self.rewardDatas)
end

function module:setRewardDatas(rewardDatas)
  self.rewardDatas = rewardDatas
  self:refreshInfo()
end

function module:setAreaLevelData(areaType, level)
  if self.areaType == areaType and self.level == level then
    return
  end
  self.areaType = areaType
  self.level = level
  local isHasReward, rewards = L_PetDuelStore:getAreaLevelRewards(areaType, level)
  if not isHasReward then
    self:SetActive(false)
    return false
  end
  self:setRewardDatas(rewards)
  self:SetActive(true)
  return true
end

function module:close()
end

return module
