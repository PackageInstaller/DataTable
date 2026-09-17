local this = class("fishTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getBaitTime(tpl)
  return tpl.baitTime
end

function this:getBait(tpl)
  return tpl.bait
end

function this:getShape(tpl)
  return tpl.shape
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

function this:getStrength(tpl)
  return tpl.strength
end

function this:getStrength(tpl)
  return tpl.strength
end

function this:getErrors(tpl)
  return tpl.errors
end

function this:getMusicScore(tpl)
  return tpl.musicScore
end

function this:getFishName(tpl)
  return L_Config:provider(tpl.fishName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getIconL(tpl)
  local icon = L_Config:getPathByHash(tpl.fishIllustrationResource)
  return icon
end

function this:getLockDesc(tpl)
  return L_Config:provider(tpl.lockDescription)
end

function this:getLengthQuality(tpl, length)
  local min = tpl.shape[1]
  local max = tpl.shape[2]
  local lengthLerp = (max - min) / 3
  if length <= min + lengthLerp then
    return 1
  elseif length > min + lengthLerp and length <= min + lengthLerp * 2 then
    return 2
  elseif length > min + lengthLerp * 2 then
    return 3
  end
end

return this
