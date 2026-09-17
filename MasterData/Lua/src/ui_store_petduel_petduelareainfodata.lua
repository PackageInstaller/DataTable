local this = class("petDuelAreaInfoData")
local areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()

function this:ctor()
  self.id = nil
  self.exp = nil
  self.lvl = nil
  self.gotLvlReward = nil
  self.lastExp = nil
  self.lastLvl = nil
end

function this:updateServerData(serverData)
  local lastExp = self.exp
  local lastLvl = self.lvl
  self.id = serverData.id
  self.exp = serverData.exp
  self.lvl = serverData.lvl
  self.lastExp = lastExp or self.exp
  self.lastLvl = lastLvl or self.lvl
  self.gotLvlReward = {}
  if serverData.got_lvl_reward then
    for _, v in ipairs(serverData.got_lvl_reward) do
      self.gotLvlReward[v] = true
    end
  end
  self.gotLvlReward[1] = true
end

function this:getId()
  return self.id
end

function this:getExp()
  return self.exp or 0
end

function this:getlvl()
  return self.lvl or 1
end

function this:getlastExp()
  return self.lastExp
end

function this:getLastlvl()
  return self.lastLvl
end

function this:isGotReward(level)
  return self.gotLvlReward[level] == true
end

function this:getCompleteLvls()
  local lvls = {}
  local curlvl = self:getlvl()
  for lvl = 1, curlvl do
    if not self:isGotReward(lvl) then
      table.insert(lvls, lvl)
    end
  end
  return lvls
end

function this:getLvlStatus(level)
  local lvl = self:getlvl()
  if level > lvl then
    return L_Const.commonRewardStatus.notComp
  end
  if self:isGotReward(level) then
    return L_Const.commonRewardStatus.got
  end
  return L_Const.commonRewardStatus.complete
end

function this:getExpDelta()
  local addExp = 0
  local lastExp = self.lastExp or 0
  if self.lastLvl < self.lvl then
    for i = self.lastLvl, self.lvl - 1 do
      local maxExp = areaLeveTpl:getMaxExp(self.id, i)
      addExp = addExp + (maxExp - lastExp)
      lastExp = 0
    end
    addExp = addExp + self.exp
  else
    addExp = math.max(self.exp - lastExp, 0)
  end
  return addExp
end

function this:resetRecordData()
  self.lastExp = self.exp
  self.lastLvl = self.lvl
end

return this
