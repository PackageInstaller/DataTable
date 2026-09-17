local this = class("templateValueTpl")

function this:init(config)
  self.data = config
  self.factorIndex = {
    [L_Const.battleAtt.ATK] = 10000,
    [L_Const.battleAtt.DEF] = 10000,
    [L_Const.battleAtt.MDEF] = 10000,
    [L_Const.battleAtt.MAXHP] = 10000,
    [L_Const.battleAtt.WEEKNESS_VALUE] = 10000,
    [L_Const.battleAtt.MASTERY] = 10000,
    [L_Const.battleAtt.BREAK_VALUE] = 10000
  }
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getBaseAttribute(tpl)
  return tpl.baseAttribute
end

function this:getPetBaseAttribute(tpl)
  local baseAttribute = {}
  for i, v in pairs(tpl.baseAttribute) do
    baseAttribute[i] = v
  end
  return baseAttribute
end

function this:getPetConfigAtt(petId, petLv, isKiboDuelArena)
  local tpl_base = self:getTplById(petId)
  local tpl_growth = self:getTplById(5001000 + petLv)
  if isKiboDuelArena then
    tpl_growth = self:getTplById(5002000 + petLv)
  end
  local baseValue = self:getBaseAttribute(tpl_base)
  local factorValue = self:getBaseAttribute(tpl_growth)
  local newValue = {}
  for i, v in pairs(baseValue) do
    if factorValue[i] then
      if self.factorIndex[i] then
        newValue[i] = v * factorValue[i] / self.factorIndex[i]
      else
        newValue[i] = v * factorValue[i]
      end
    end
  end
  return newValue
end

return this
