local this = class("moduleTalentDetail", G_UIModuleBase)
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local heroTpl = L_GameTpl:getHeroTpl()
local colNum = 2

function this.bind()
  return {
    cellTalentSkillBonusInfo = {
      moduleName = "pages/HeroPanel/talent/cellTalentSkillBonusInfo"
    },
    attributeList = {
      moduleName = "pages/HeroPanel/talent/cellTalentAttributeBonus"
    },
    attributeBgList = {
      moduleName = "pages/HeroPanel/talent/cellAttrBg"
    },
    toggle_isSkillInfoEmpty = false,
    toggle_isAttrInfoEmpty = false
  }
end

function this.methods()
  return {
    onClick_hide = function(self)
      self:emit("onClick_empty")
    end
  }
end

function this:initModule(data)
  self.rank = data.rank
  self.currentRunes = data.runes
  self.heroConfigId = data.heroConfigId
  self.bind.attributesTitle = L_WordsTpl:getValue("ui_talent_detail_title")
  self.bind.emptyTips = L_WordsTpl:getValue("talent_page_no_upgrade")
  local attributes, skills = self:getAccumulatedInfo()
  local attributeData = {}
  for k, v in pairs(attributes) do
    table.insert(attributeData, {attributeId = k, value = v})
  end
  table.sort(attributeData, function(a, b)
    return a.attributeId < b.attributeId
  end)
  local skillData = {}
  local tpl = heroTpl:getTplById(self.heroConfigId)
  local systemSkillIdList = heroTpl:getSkillSystem(tpl)
  for i = 1, 4 do
    table.insert(skillData, {
      index = i,
      skillId = systemSkillIdList[i],
      addLevel = skills[i - 1] or 0
    })
  end
  self.modules.cellTalentSkillBonusInfo:initData(skillData)
  self.bind.toggle_isSkillInfoEmpty = #skillData == 0
  local attributeNum = #attributeData
  local rowNum = math.ceil(attributeNum / colNum)
  local attributeBgList = {}
  for i = 1, rowNum do
    table.insert(attributeBgList, {
      toggle_isNone = i % 2 == 1
    })
  end
  self.bind.toggle_isAttrInfoEmpty = attributeNum == 0
  if 0 < attributeNum then
    self.bind.attributeList:clear()
    self.bind.attributeList:insert_array(attributeData)
    self.bind.attributeBgList:clear()
    self.bind.attributeBgList:insert_array(attributeBgList)
  end
end

function this:getAccumulatedInfo()
  local attributes = {}
  local skillInfo = {}
  local ranks = talentRankTpl:getHeroRankTpls(self.heroConfigId)
  for i = 1, self.rank - 1 do
    if ranks[i] ~= nil then
      local runes = talentRankTpl:getRankBreakthroughItem(ranks[i])
      local breakAttributes = talentRankTpl:getAttribute(ranks[i])
      for id, v in pairs(breakAttributes) do
        self:addAttribute(attributes, id, v)
      end
      for _, runeId in pairs(runes) do
        self:dealRune(runeId, skillInfo, attributes)
      end
    end
  end
  for _, runeId in pairs(self.currentRunes) do
    if not math.isEmpty(runeId) then
      self:dealRune(runeId, skillInfo, attributes)
    end
  end
  return attributes, skillInfo
end

function this:dealRune(runeId, skillInfo, attributes)
  local runeTpl = talentRuneTpl:getTplById(runeId)
  local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
  for _, skill in pairs(runeSkills) do
    if skillInfo[skill[1]] == nil then
      skillInfo[skill[1]] = 0
    end
    skillInfo[skill[1]] = skillInfo[skill[1]] + skill[2]
  end
  local runeAttributes = talentRuneTpl:getRuneAttribute(runeTpl)
  for id, v in pairs(runeAttributes) do
    self:addAttribute(attributes, id, v)
  end
end

function this:addAttribute(attributes, id, v)
  if attributes[id] == nil then
    attributes[id] = 0
  end
  attributes[id] = attributes[id] + v
end

return this
