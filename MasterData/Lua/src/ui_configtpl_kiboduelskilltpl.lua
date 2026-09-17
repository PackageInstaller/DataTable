local this = class("kiboDuelSkillTpl")

function this:init(config)
  self.data = config
  self.skills = {}
  local skillId
  for _, tpl in ipairs(config) do
    skillId = self:getSkillId(tpl)
    self.skills[skillId] = tpl
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSkillId(tpl)
  return tpl.skillId
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return tpl.name
end

function this:getDefaultSkill(tpl)
  return tpl.defaultSkill
end

function this:getSkills()
  return self.skills
end

function this:getSkillIds()
  local skillIds = table.keys(self.skills)
  table.sort(skillIds, function(a, b)
    return a < b
  end)
  return skillIds
end

function this:isDefaultSkill(skillId)
  local tpl = self.skills[skillId]
  if not tpl then
    return false
  end
  return self:getDefaultSkill(tpl)
end

return this
