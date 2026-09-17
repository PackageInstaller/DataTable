local module = class("cellSkillAddItem", G_UIModuleBase)
local skillTpl = L_GameTpl:getSkillTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillDisplayType = {
  Normal = 0,
  Skill = 1,
  SuperSkill = 2,
  PassiveSkill = 3,
  ProductionSkill = 4,
  ExpandSkill = 5,
  TalentSkill = 6,
  WeaponSkill = 10
}

function module.bind()
  return {
    skillIcon = "",
    skillName = "",
    skillTypeName = "",
    curLevel = "",
    nextLevel = "",
    attrDescribeList = {
      moduleName = "pages/HeroPanel/talent/cellAttrDescribe"
    },
    currentLevelActive = true,
    arrowActive = true
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  local hero = L_HeroStore:getHero(self.bind.heroGuid)
  local sysSkills = L_HeroManager:getHeroSystemSkillList(hero)
  local serverData, i = table.ipairsFind(sysSkills, function(v)
    return v.skillId == self.bind.skillId
  end)
  if self.bind.currentLevel == nil then
    self.bind.currentLevel = serverData.skillLevel
  end
  local nextLevel = self.bind.currentLevel + self.bind.addLevel
  local maxLevel = skillLevelTpl:getMaxLevelById(self.bind.skillId)
  nextLevel = math.min(nextLevel, maxLevel)
  self.bind.curLevel = string.concat("Lv.", self.bind.currentLevel)
  self.bind.nextLevel = string.concat("Lv.", nextLevel)
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillIcon = skillTpl:getIcon(tpl)
  self.bind.skillName = skillTpl:getName(tpl)
  self.bind.skillTypeName = self:getDisplayTypeName(skillTpl:getSkillDisplayType(tpl))
  local levelTpl = skillLevelTpl:getTplByIdAndLevel(self.bind.skillId, self.bind.currentLevel)
  local propertyName_list = skillLevelTpl:getName(levelTpl)
  local propertyValueCur_list = skillLevelTpl:getValue(levelTpl)
  local propertyValueNext_list = skillLevelTpl:getValue(skillLevelTpl:getTplByIdAndLevel(self.bind.skillId, nextLevel))
  local propertyData = {}
  for k = 1, #propertyName_list do
    if propertyValueCur_list[i] ~= propertyValueNext_list[k] then
      local prop = {
        nameTxt = propertyName_list[k],
        curValue = tostring(propertyValueCur_list[k]),
        nextValue = tostring(propertyValueNext_list[k]),
        bg = k % 2 ~= 0
      }
      table.insert(propertyData, prop)
    end
  end
  self.bind.attrDescribeList:clear()
  self.bind.attrDescribeList:insert_array(propertyData)
  Timer.once(0.1, function()
    if not self.isBind then
      return
    end
    if self.bindComponents.rectSkillContent then
      self.bindComponents.rectSkillContent.pivot = C_Vector2(0, 1)
      self.bindComponents.rectSkillContent.anchoredPosition = C_Vector2(0, 0)
    end
  end, self, self.gameObject)
end

function module:getDisplayTypeName(displayType)
  if displayType == skillDisplayType.Skill then
    return L_WordsTpl:getValue("talent_page_skill_type_2")
  elseif displayType == skillDisplayType.SuperSkill then
    return L_WordsTpl:getValue("talent_page_skill_type_3")
  elseif displayType == skillDisplayType.ExpandSkill then
    return L_WordsTpl:getValue("talent_page_skill_type_4")
  end
  return L_WordsTpl:getValue("talent_page_skill_type_1")
end

return module
