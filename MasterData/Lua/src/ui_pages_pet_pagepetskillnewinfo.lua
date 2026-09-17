local page = class("pagePetSkillNewInfo", G_UIPageBase)

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {}
end

function page.bind()
  return {
    txt_petLevel = "",
    convertInfo = false,
    updateInfo = false,
    oldInfo = "",
    newInfo = "",
    oldSkillImg = "",
    newSkillImg = "",
    oldSkillLv = "",
    newSkillLv = "",
    oldSkillName = "",
    newSkillName = "",
    skillList = {
      moduleName = "pages/Pet/cellSkillItem"
    }
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    skillList = {
      onClick_Choose = function(self, index, data)
        self:clickSkillList(index, data)
      end
    }
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self:initPage(options.skillInfo, options.type, options.guid)
end

function page:close(options)
  page.super.close(self, options)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
end

function page:initPage(skillInfo, type, guid)
  if type == 1 then
    self.bind.infoTips = L_WordsTpl:getValue("ui_pagePetSkillNewInfo_01")
    self.bind.updateInfo = true
    self.bind.convertInfo = false
    self:refreshSkillList(skillInfo)
  elseif type == 2 then
    self.bind.infoTips = L_WordsTpl:getValue("ui_pagePetSkillNewInfo_02")
    self.bind.updateInfo = true
    self.bind.convertInfo = false
    self:refreshSkillList(skillInfo)
  elseif type == 3 then
    self.bind.updateInfo = false
    self.bind.convertInfo = true
    self:refreshSkillInfo(skillInfo)
  end
  local pet = L_PetStore:getPetItem(guid)
  self.bind.txt_petLevel = tostring(pet.lv)
end

function page:refreshSkillList(skillInfo)
  local innerSkills = skillInfo
  local innerData = {}
  local index = 1
  for _, n in pairs(innerSkills) do
    local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
    local skillTpl = L_GameTpl:getSkillTpl()
    local tpl = skillLevelTpl:getTplByIdAndLevel(n.skill_id, n.skill_lv)
    if tpl ~= nil then
      local skillId = skillLevelTpl:getSkillGroupId(tpl)
      local nameTpl = skillTpl:getTplById(tonumber(skillId))
      local skillName = skillTpl:getName(nameTpl)
      local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
      local skillIcon = skillTpl:getIcon(nameTpl)
      local oldInfo = n.oldInfo
      table.insert(innerData, {
        index = index,
        skillLv = "Lv." .. n.skill_lv,
        skillLevelShow = false,
        levelLabel = true,
        itemIcon = skillIcon,
        describe = skillDescribe,
        skillName = skillName,
        skillSlot = n.skill_slot,
        skillElement = skillTpl:getSkillElement(nameTpl),
        oldLv = oldInfo and oldInfo.skill_lv
      })
      index = index + 1
    end
  end
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(innerData)
end

function page:refreshSkillInfo(skillInfo)
  local data = skillInfo[1]
  local old = data.old_Skill
  local new = data.convert_Skill
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local skillTpl = L_GameTpl:getSkillTpl()
  local old_tpl = skillLevelTpl:getTplByIdAndLevel(old.skill_id, old.skill_lv)
  if old_tpl ~= nil then
    local skillId = skillLevelTpl:getSkillGroupId(old_tpl)
    local nameTpl = skillTpl:getTplById(tonumber(skillId))
    local skillName = skillTpl:getName(nameTpl)
    local skillDescribe = skillLevelTpl:getSkillDescribe(old_tpl)
    local skillIcon = skillTpl:getIcon(nameTpl)
    self.bind.oldSkillLv = "Lv." .. new.skill_lv
    self.bind.oldSkillImg = skillIcon
    self.bind.oldInfo = skillDescribe
    self.bind.oldSkillName = skillName
  end
  local new_tpl = skillLevelTpl:getTplByIdAndLevel(new.skill_id, new.skill_lv)
  if new_tpl ~= nil then
    local skillId = skillLevelTpl:getSkillGroupId(new_tpl)
    local nameTpl = skillTpl:getTplById(tonumber(skillId))
    local skillName = skillTpl:getName(nameTpl)
    local skillDescribe = skillLevelTpl:getSkillDescribe(new_tpl)
    local skillIcon = skillTpl:getIcon(nameTpl)
    self.bind.newSkillLv = "Lv." .. new.skill_lv
    self.bind.newSkillImg = skillIcon
    self.bind.newInfo = skillDescribe
    self.bind.newSkillName = skillName
  end
end

function page:clickSkillList(index, data)
  for i = 1, #self.bind.skillList do
    if i == index then
      local skillData = {
        skillIcon = data.itemIcon,
        skillLevelShow = data.skillLevelShow,
        levelLabel = data.levelLabel,
        skillLv = data.skillLv,
        skillName = data.skillName,
        describe = data.describe,
        starLv = data.starLv ~= nil and data.starLv or 0,
        rarity = data.rarity ~= nil and data.rarity or 1
      }
      L_UI:open("pageShowPetSkill", {optionData = skillData})
      break
    end
  end
end

return page
