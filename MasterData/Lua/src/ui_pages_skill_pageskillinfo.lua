local this = class("pageSkillInfo", G_UIPageBase)
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()

function this.bind()
  return {
    txt_skillTagName = nil,
    img_icon = nil,
    txt_name = nil,
    txt_level = nil,
    list_att = {
      moduleName = "pages/HeroPanel/talent/cellTalentAttrItem"
    },
    active_btnUpgrade = false,
    txt_desc = nil,
    active_subDesc = false,
    txt_subDesc = nil,
    txt_subTitle = "",
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    go_leftBtn = false,
    go_rightBtn = false
  }
end

function this.methods()
  return {
    onClick_leftBtn = function(self)
      print("=======================左切")
      self._curIndex = (self._curIndex - 1) % #self.skillList
      if self._curIndex <= 0 then
        self._curIndex = #self.skillList
      end
      self._skillId = self.skillList[self._curIndex].skillId
      self:initSkillInfo()
    end,
    onClick_rightBtn = function(self)
      print("=======================右切")
      self._curIndex = self._curIndex % #self.skillList + 1
      self._skillId = self.skillList[self._curIndex].skillId
      self:initSkillInfo()
    end,
    onClick_jumpBtn = function(self)
      if self._canLevelUp then
        local hero = self._heroItemInfo
        L_HeroManager:showHeroSelection(L_Const.heroModuleType.Talent, L_HeroStore:getHeroGuid(hero), {
          jumpRank = self._jumpRank,
          jumpRuneId = self._jumpRuneId
        })
        L_UI:close(self.pageName)
      end
    end,
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  options = options or {}
  self._heroItemInfo = options.hero
  self._skillId = options.skillId
  self._isPreview = options.isPreview
  self.skillList = options.skillList
  self._curIndex = 1
  if self.skillList and #self.skillList > 0 then
    self.bind.go_leftBtn = true
    self.bind.go_rightBtn = true
    for key, value in pairs(self.skillList) do
      if value.skillId == self._skillId then
        self._curIndex = key
        break
      end
    end
  else
    self.bind.go_leftBtn = false
    self.bind.go_rightBtn = false
  end
  self:initCommonTipModule()
  self:initSkillInfo()
  self.bind.txt_subTitle = L_WordsTpl:getValue("ui_skill_info_desc_title")
end

function this:close(options)
  this.super.close(self, options)
end

function this:initCommonTipModule()
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    hideConfirm = true,
    hideCancel = true,
    txtTitle = L_WordsTpl:getValue("ui_pageskillinfo_describe")
  })
end

function this:initSkillInfo()
  self:getCanLevelUp()
  local tpl_skill = _skillTpl:getTplById(self._skillId)
  self.bind.img_icon = _skillTpl:getIcon(tpl_skill)
  self.bind.txt_name = _skillTpl:getName(tpl_skill)
  local skill_list = L_HeroManager:getHeroSystemSkillList(self._heroItemInfo)
  local skill, index = table.ipairsFind(skill_list, function(value)
    return value.skillId == self._skillId
  end)
  skill = skill or {}
  local skillLevel = skill.skillLevel or 1
  local isUnlock = not math.isEmpty(index)
  local levelTxt = L_WordsTpl:getValue("menu_common_lock")
  local isMaxLevel = false
  if isUnlock then
    isMaxLevel = skillLevel >= skillLevelTpl:getMaxLevelById(self._skillId)
    levelTxt = isMaxLevel and L_WordsTpl:getValue("menu_common_lvMax") or string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), skillLevel)
  end
  self.bind.active_btnUpgrade = self._canLevelUp and not isMaxLevel and isUnlock
  self.bind.txt_level = levelTxt
  local skillType = _skillTpl:getSkillDisplayType(tpl_skill)
  self.bind.txt_skillTagName = L_WordsTpl:getValue(string.format("menu_skill_type%s", skillType + 1))
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(self._skillId, skillLevel)
  local subId = skillLevelTpl:getSubSkillId(tpl_skillLevel)
  local tpl_skillSub = _skillsubLogicTpl:getTplById(subId)
  local temp = {}
  local val1 = _skillsubLogicTpl:getCoolDown(tpl_skillSub) / 1000
  if val1 ~= 0 then
    table.insert(temp, {
      attrIcon = "UI/Atlas/Skill/tex_icon_skillstatus_lq.png",
      name = L_WordsTpl:getValue("ui_pageskillinfo_cd"),
      value = L_WordsTpl:getValue("menu_skill_coolDownTime", {
        [0] = val1
      }),
      bgEnable = true
    })
  end
  local val2 = _skillsubLogicTpl:getSpCost(tpl_skillSub)
  if val2 ~= 0 then
    table.insert(temp, {
      attrIcon = "UI/Atlas/Skill/tex_icon_skillstatus_nlxh.png",
      name = L_WordsTpl:getValue("ui_pageskillinfo_energy_consumption"),
      value = tostring(_skillsubLogicTpl:getSpCost(tpl_skillSub)),
      bgEnable = false
    })
  end
  self.bind.list_att:clear()
  self.bind.list_att:insert_array(temp)
  self.bind.txt_desc = L_GameUtil.getSkillDesc(self._skillId, skillLevel)
  local specialDes = skillLevelTpl:getSkillSpecialDesc(tpl_skillLevel)
  self.bind.active_subDesc = not string.isEmpty(specialDes)
  self.bind.txt_subDesc = specialDes
end

function this:getCanLevelUp()
  self._canLevelUp = false
  if self._isPreview or self._heroItemInfo == nil then
    return
  end
  local sysSkills = L_HeroManager:getHeroSystemSkillList(self._heroItemInfo)
  local curRank = L_HeroStore:getHeroRank(self._heroItemInfo)
  local maxRank = talentRankTpl:getHeroMaxVisibleRankNum(L_HeroStore:getHeroConfigId(self._heroItemInfo))
  local runes = L_HeroStore:getHeroRuneIds(self._heroItemInfo)
  for rank = curRank, maxRank do
    local rankTpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(self._heroItemInfo), rank)
    local rankBreakItems = talentRankTpl:getRankBreakthroughItem(rankTpl)
    for k, id in ipairs(rankBreakItems) do
      local runeTpl = talentRuneTpl:getTplById(id)
      local isEquiped = false
      if rank == curRank then
        isEquiped = not math.isEmpty(runes[k])
      end
      if not isEquiped then
        local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
        for _, skill in ipairs(runeSkills) do
          local skillId = sysSkills[skill[1] + 1].skillId
          if self._skillId == skillId then
            self._canLevelUp = true
            self._jumpRank = rank
            self._jumpRuneId = id
            break
          end
        end
      end
      if self._canLevelUp then
        break
      end
    end
    if self._canLevelUp then
      break
    end
  end
end

return this
