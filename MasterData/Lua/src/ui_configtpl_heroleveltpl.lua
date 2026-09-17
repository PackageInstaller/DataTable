local this = class("heroLevelTpl")

function this:init(config)
  self.data = config
  self.expSumData = {}
  local expSum = 0
  for i, v in ipairs(config) do
    self.expSumData[v.lv] = expSum
    expSum = expSum + v.exp
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSoldierRankSr(tpl)
  return tpl.soldier_rank_sr
end

function this:getLv(tpl)
  return tpl.lv
end

function this:getSoldierRankSsr(tpl)
  return tpl.soldier_rank_ssr
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getMaxLv()
  return math.max(table.unpack(table.keys(self.expSumData)))
end

function this:getStarLvCondition(lv)
  local condition = self.data[lv + 1].condition
  return condition[2]
end

function this:getMaxLvByCondition()
  local maxLv = self:getMaxLv()
  local lv = 1
  while maxLv > lv do
    local condition = self.data[lv + 1].condition
    if not (not condition or L_ConditionManager:singleIsComplete(condition)) then
      break
    end
    lv = lv + 1
  end
  return lv
end

function this:getExpSumToCurLevel(lv)
  return self.expSumData[lv]
end

function this:getLevelAndExpByExpSum(expSum)
  local level = 0
  local exp = 0
  if expSum == self.expSumData[self:getMaxLv()] then
    local maxLevelTpl = self.data[self:getMaxLv()]
    return maxLevelTpl.lv, maxLevelTpl.exp
  end
  for i, v in ipairs(self.expSumData) do
    if expSum < v then
      level = math.clamp(i - 1, 1, i)
      exp = expSum - self.expSumData[level]
      break
    end
  end
  return level, exp
end

return this
