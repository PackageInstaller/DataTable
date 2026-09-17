local this = class("accessoryScoreTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getID(tpl)
  return tpl.ID
end

function this:getScore(tpl)
  return tpl.score
end

function this:getTplByScore(value)
  for k, v in pairs(self.data) do
    if value >= self:getMinScore(v) and value <= self:getMaxScore(v) then
      local tpl = self:getTplById(k)
      return tpl
    end
  end
  return nil
end

function this:getMinScore(tpl)
  return tpl.score[1]
end

function this:getMaxScore(tpl)
  return tpl.score[2]
end

function this:getAllLevelMaxScore()
  local max
  for k, v in pairs(self.data) do
    max = self:getMaxScore(v)
  end
  return max
end

function this:getIcon(tpl)
  return tpl.icon
end

return this
