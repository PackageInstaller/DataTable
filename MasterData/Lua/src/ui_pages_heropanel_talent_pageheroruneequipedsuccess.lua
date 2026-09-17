local this = class("pageHeroRuneEquipedSuccess", G_UIPageBase)
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()

function this.bind()
  return {
    title = "",
    skillList = {
      moduleName = "pages/heroPanel/talent/cellSkillLevelItem"
    },
    propList = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    },
    skillListActive = false,
    levelLimitNodeActive = false,
    splitLineNodeActive = false,
    propListActive = false,
    beforeLevelLimit = "",
    curLevelLimit = "",
    equipTopActive = false,
    rankUpTopActive = false,
    euipedTitle = "",
    runeIcon = "",
    moduleSuccessTips = {
      moduleName = "modulePages/moduleSuccessTip"
    }
  }
end

local attrBaseName = {
  [L_Const.battleAtt.MAXHP] = "info_attr_basic_hp",
  [L_Const.battleAtt.ATK] = "info_attr_basic_atk",
  [L_Const.battleAtt.DEF] = "info_attr_basic_def",
  [L_Const.battleAtt.MDEF] = "info_attr_basic_mdef"
}

function this.methods()
  return {
    onClick_closeAdvance = function(self)
      if L_UI:checkPageOpen(self.pageName) then
        L_UI:close(self.pageName)
      end
    end
  }
end

function this:preOpen(options)
  self.options = options
  self:initPage()
end

function this:initPage()
  local heroGuid = self.options.heroGuid
  self.hero = L_HeroStore:getHero(heroGuid)
  self.bind.levelLimitNodeActive = self.options.isRankUp
  self.bind.skillListActive = not self.options.isRankUp
  self.bind.rankUpTopActive = self.options.isRankUp
  self.bind.equipTopActive = not self.options.isRankUp
  self.bind.title = L_Const.Number2Roma[L_HeroStore:getHeroRank(self.hero)]
  self.bind.euipedTitle = L_WordsTpl:getValue("ui_hero_rune_equip_success")
  if self.options.isRankUp then
    self:initLevelLimitNode()
  else
    self:initSkills()
  end
  self:initPropList()
  if self.options.runeId ~= nil then
    local runeTpl = talentRuneTpl:getTplById(self.options.runeId)
    local itemId = talentRuneTpl:getRuneItem(runeTpl)
    local item = L_ItemTplManager:getCommonItem(itemId)
    self.bind.runeIcon = item.icon
  end
end

function this:initLevelLimitNode()
  local configId = L_HeroStore:getHeroConfigId(self.hero)
  local curRank = L_HeroStore:getHeroRank(self.hero)
  local beforeTpl = talentRankTpl:getHeroRankTpl(configId, curRank - 1)
  local curTpl = talentRankTpl:getHeroRankTpl(configId, curRank)
  self.bind.beforeLevelLimit = tostring(talentRankTpl:getRankLevelLimit(beforeTpl))
  self.bind.curLevelLimit = tostring(talentRankTpl:getRankLevelLimit(curTpl))
end

function this:initSkills()
  local skills = {}
  for i = 0, self.options.serverResp.skills.Count - 1 do
    table.insert(skills, self.options.serverResp.skills[i])
  end
  local sysSkills = L_HeroManager:getHeroSystemSkillList(self.hero)
  local tmp = {}
  for k, skill in ipairs(skills) do
    local sysSkill = table.find(sysSkills, function(v)
      return skill.skillId == v.skillId
    end)
    table.insert(tmp, {
      skillId = skill.skillId,
      curLevel = tostring(sysSkill.skillLevel),
      beforeLevel = tostring(sysSkill.skillLevel - skill.addLevel)
    })
  end
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(tmp)
end

function this:initPropList()
  local property = {}
  for i, v in pairs(L_HeroStore:getHeroPropertyMap(self.options.heroGuid)) do
    if table.containsValue(L_Const.SpecialAttList, i) then
      property[i] = v / 10000
    else
      property[i] = v
    end
    property[i] = math.floor(property[i])
  end
  local attrs = {}
  if self.options.serverResp.atrrs then
    for i = 0, self.options.serverResp.atrrs.Count - 1 do
      table.insert(attrs, self.options.serverResp.atrrs[i])
    end
  end
  local tmp = {}
  for i, attr in ipairs(attrs) do
    local curValue = property[attr.attrId] or 0
    curValue = curValue - attr.attrVal
    if curValue < 0 then
      curValue = 0
    end
    local tpl = battleInfoTpl:getTplById(attr.attrId)
    local strName = L_WordsTpl:getValue(attrBaseName[attr.attrId])
    table.insert(tmp, {
      toggle_state = false,
      curAttr = battleInfoTpl:getShowTxtComma(attr.attrId, curValue),
      nextAttr = battleInfoTpl:getShowTxtComma(attr.attrId, property[attr.attrId] or 0),
      name = string.isEmpty(strName) and battleInfoTpl:getName(tpl) or strName,
      icon = battleInfoTpl:getIcon(tpl),
      active_icon = true,
      id = attr.attrId
    })
  end
  table.sort(tmp, function(a, b)
    return a.id < b.id
  end)
  for i, item in ipairs(tmp) do
    item.toggle_state = i % 2 == 0
  end
  self.bind.propList:clear()
  self.bind.propListActive = 0 < #tmp
  self.bind.splitLineNodeActive = 0 < #tmp
  self.bind.propList:insert_array(tmp)
end

function this:close()
end

return this
