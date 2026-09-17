local this = class("homeLaborTrainTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getBetweenLevelsExp(lastLevel, curLevel, lastExp, curExp)
  local allExp = 0
  for k, v in pairs(self.data) do
    if lastLevel <= k and k < curLevel then
      allExp = allExp + v.exp
    end
    if curLevel <= k then
      break
    end
  end
  allExp = allExp - lastExp + curExp
  return allExp
end

return this
