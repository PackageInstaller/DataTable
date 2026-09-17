local this = class("iconographyLevelTpl")

function this:init(config)
  self.data = config
  self._dict = {}
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByLvPetId(level, petId)
  local id = level
  if self._dict[petId] and self._dict[petId][level] then
    return self.data[self._dict[petId][level]]
  end
  for i, tpl in pairs(self.data) do
    if tpl.petid == petId and tpl.iconographyLevel == level then
      id = i
      break
    end
  end
  self._dict[petId] = self._dict[petId] or {}
  self._dict[petId][level] = id
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getSurveycoefficient(tpl)
  return tpl.surveycoefficient
end

function this:getId(tpl)
  return tpl.id
end

function this:getPetid(tpl)
  return tpl.petid
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getType(tpl)
  return tpl.attrReward
end

function this:getIconographyLevel(tpl)
  return tpl.iconographyLevel
end

function this:getText(tpl)
  return L_Config:provider(tpl.text)
end

return this
