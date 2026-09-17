local this = class("skillTpl")

function this:init(config)
  self.data = config
  self.parentSkillDict = {}
  for _, v in pairs(config) do
    if not math.isEmpty(v.parentSkill) then
      if not self.parentSkillDict[v.parentSkill] then
        self.parentSkillDict[v.parentSkill] = {}
      end
      table.insert(self.parentSkillDict[v.parentSkill], v.id)
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSkillType(tpl)
  return tpl.skillType
end

function this:getSkillDisplayType(tpl)
  return tpl.skillDisplayType
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getIcon(tpl)
  return L_Config:getPathByHash(tpl.icon)
end

function this:getBattleSkillIcon(tpl)
  return L_Config:getPathByHash(tpl.battleSkillIcon)
end

function this:getSkillElement(tpl)
  return tpl.skillElement
end

function this:getParentSkill(tpl)
  return tpl.parentSkill
end

function this:getChildSkills(tpl)
  return self.parentSkillDict[tpl.id] or {}
end

function this:getSkillDisplayType(tpl)
  return tpl.skillDisplayType
end

function this:getSkillType(tpl)
  return tpl.skillType
end

function this:getSkillShowResponse(tpl)
  return tpl.skillShowResponse == 1
end

return this
