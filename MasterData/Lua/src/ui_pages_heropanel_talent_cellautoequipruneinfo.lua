local this = class("cellAutoEquipRuneInfo", G_UIModuleBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    runeNameText = "",
    equipedTipActive = false,
    attributeList = {
      moduleName = "pages/HeroPanel/talent/cellTalentAttrItem"
    },
    skillDesList = {
      moduleName = "pages/HeroPanel/talent/cellSkillAddItem"
    },
    itemIcon = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.equipedTipActive = self.bind.isEquiped
  local runeTpl = talentRuneTpl:getTplById(self.bind.runeId)
  local itemId = talentRuneTpl:getRuneItem(runeTpl)
  local item = L_ItemTplManager:getCommonItem(itemId)
  self.bind.itemIcon = item.icon
  self.bind.runeNameText = item.name
  self.isLackRune = C_BagMgr:getItemNumByItemId(itemId) <= 0
  local attributes = talentRuneTpl:getRuneAttribute(runeTpl)
  local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
  self:initAttributeList(attributes)
  self:initRuneSkillList(runeSkills)
end

function this:initAttributeList(attributes)
  local propertyData = {}
  for i, v in pairs(attributes) do
    local strName = L_WordsTpl:getValue(L_Const.attrBaseName[i])
    table.insert(propertyData, {
      attrIcon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(i)),
      value = L_WordsTpl:getValue("ui_hero_rune_atttribute_add", {
        [0] = battleInfoTpl:getShowTxtComma(i, v)
      }),
      name = string.isEmpty(strName) and battleInfoTpl:getName(battleInfoTpl:getTplById(i)) or strName,
      id = i
    })
  end
  table.sort(propertyData, function(a, b)
    return a.id < b.id
  end)
  for i, v in ipairs(propertyData) do
    v.bgEnable = i % 2 ~= 0
  end
  self.bind.attributeList:clear()
  self.bind.attributeList:insert_array(propertyData)
end

function this:initRuneSkillList(runeSkills)
  self.bind.skillDesList:clear()
  local hero = L_HeroStore:getHero(self.bind.heroGuid)
  local sysSkills = L_HeroManager:getHeroSystemSkillList(hero)
  local skillData = {}
  for _, skill in ipairs(runeSkills) do
    table.insert(skillData, {
      skillId = sysSkills[skill[1] + 1].skillId,
      addLevel = skill[2],
      heroGuid = self.bind.heroGuid
    })
  end
  self.bind.skillDesList:insert_array(skillData)
end

return this
