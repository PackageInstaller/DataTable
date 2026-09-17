local this = class("achievementAwardTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFirstTpl()
  local tpl
  for k, v in pairs(self.data) do
    tpl = v
    return tpl
  end
  return nil
end

function this:getNextTplById(id)
  local tpl
  local flag = false
  for k, v in pairs(self.data) do
    if flag then
      tpl = v
      return tpl
    end
    if v.id == id then
      flag = true
    end
  end
  return nil
end

function this:getId(tpl)
  return tpl.id
end

function this:getIdByLessPoint(point)
  local id
  for _, v in pairs(self.data) do
    if point < v.achiPoint then
      break
    end
    id = v.id
  end
  return id
end

function this:getIdByPoint(point)
  local id
  for _, v in pairs(self.data) do
    if v.achiPoint == point then
      id = v.id
      break
    end
  end
  return id
end

function this:getIdByGreaterPoint(point)
  local id
  for _, v in pairs(self.data) do
    if point < v.achiPoint then
      id = v.id
      break
    end
  end
  return id
end

function this:getAchiPoint(tpl)
  return tpl.achiPoint
end

function this:getReward(tpl)
  return tpl.reward
end

return this
