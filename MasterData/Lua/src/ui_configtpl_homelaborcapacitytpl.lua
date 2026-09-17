local this = class("homeLaborCapacityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLaborType(tpl)
  return tpl.laborType
end

function this:getLaborCapacityId(tpl)
  return tpl.laborCapacityId
end

function this:getIconLight(tpl)
  return tpl.icon[1]
end

function this:getIconDark(tpl)
  return tpl.icon[2]
end

function this:getBevTree(tpl)
  return tpl.bevTree
end

function this:getSubBehaviourTree(tpl)
  return tpl.subBehaviourTree
end

function this:getBackgroundIcon(tpl)
  return tpl.backgroundIcon
end

function this:getLaborCapacityName(tpl)
  return L_Config:provider(tpl.laborCapacityName)
end

function this:getSatietyScore(tpl)
  return tpl.satietyScore
end

function this:getCostSatiety(tpl)
  if not table.isEmpty(tpl.satietyScore) then
    return tpl.satietyScore[1]
  end
end

function this:getBevId(tpl)
  return tpl.bevId
end

function this:getCostSatietyTime(tpl)
  if not table.isEmpty(tpl.satietyScore) then
    return tpl.satietyScore[2]
  end
end

return this
