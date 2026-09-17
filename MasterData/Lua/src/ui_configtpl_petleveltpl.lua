local this = class("petLevelTpl")

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

function this:getLv(tpl)
  return tpl.lv
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getMaxLevel()
  return #self.data
end

function this:getExpSumToCurLevel(lv)
  return self.expSumData[lv]
end

function this:getLevelAndExpByExpSum(expSum)
  local level = 1
  local exp = 0
  if expSum == self.expSumData[self:getMaxLevel()] then
    local maxLevelTpl = self.data[self:getMaxLevel()]
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

function this:getCondition(tpl)
  return tpl.condition
end

return this
