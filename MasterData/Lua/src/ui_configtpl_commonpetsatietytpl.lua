local this = class("commonPetSatietyTpl")

function this:init(config)
  self.data = config
  self.satietyLevelDic = {}
  local level = 1
  for _, tpl in pairs(config) do
    for min, max in pairs(tpl.satiety) do
      min = min / 10000
      max = max / 10000
      self.satietyLevelDic[level] = {min = min, max = max}
    end
    level = level + 1
  end
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSatiety(tpl)
  return tpl.satiety
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return tpl.name
end

function this:getFastMoveSpeedMp(tpl)
  return tpl.fast_move_speed_mp
end

function this:getMoveSpeedSp(tpl)
  return tpl.move_speed_sp / 10000.0
end

function this:getSatietyLevel(level)
  return self.satietyLevelDic[level]
end

return this
