local this = class("homeTechnologyTpl")

function this:init(config)
  self.data = config
  self.tplIdCache = {}
  for tplId, tpl in pairs(config) do
    self.tplIdCache[tpl.type] = self.tplIdCache[tpl.type] or {}
    self.tplIdCache[tpl.type][tpl.level] = tplId
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getEffectParameter(tpl)
  return tpl.effectParameter
end

function this:getId(tpl)
  return tpl.id
end

function this:getObjName(tpl)
  return L_Config:provider(tpl.objName)
end

function this:getBuffCondition(tpl)
  return tpl.buffCondition
end

function this:getUnlockCondi1(tpl)
  return tpl.unlockCondi1
end

function this:getNewTechnologyProduct(tpl)
  return tpl.newTechnologyProduct
end

function this:getBuffParams(tpl)
  return tpl.buffParams
end

function this:getBuffInfo(tpl)
  return tpl.buffId, tpl.buffParams, tpl.buffCondition, tpl.buffConditionLogic == 2
end

function this:getEffectDescription(tpl)
  return L_Config:provider(tpl.effectDescription)
end

function this:getBuffId(tpl)
  return tpl.buffId
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getTechnologyEffectId(tpl)
  return tpl.technologyEffectId
end

function this:getPoint(tpl)
  return tpl.point
end

function this:getType(tpl)
  return tpl.type
end

function this:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(techTreeId, techLevel)
  if techLevel == 0 then
    techLevel = 1
  end
  return self.tplIdCache[techTreeId][techLevel]
end

return this
