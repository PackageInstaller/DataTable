local module = class("moduleSkill", require("ui.pages.HeroPanel.moduleHeroBase"))
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
local heroTpl = L_GameTpl:getHeroTpl()
local _skillTpl = L_GameTpl:getSkillTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    curSelectSkillId = nil,
    isMaterialEnough = false,
    lastSelect = nil,
    curSelectIndex = 1
  }
end

function module.bind()
  return {
    isShowLockByLevel = false,
    lockByLevelTxt = "",
    curLevelTxt = "",
    curNameTxt = "",
    isShowLevelUpBtn = true,
    isLevelUpBtnEnable = true,
    tagImageBox = {
      moduleName = "pages/HeroPanel/skill/cellSkillTagBox"
    },
    isShowCurrency = true,
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    propertyList = {
      moduleName = "pages/HeroPanel/skill/cellUniqueSkill"
    },
    levelUpModule = {
      moduleName = "pages/HeroPanel/skill/cellSkillPropertyItem"
    },
    levelPropertyList = {
      moduleName = "pages/HeroPanel/skill/cellSkillPropertyItem"
    },
    costList = {
      moduleName = "modulePages/cellIcon"
    },
    costCurrencyIconPath = "",
    costNumTxt = "",
    skillList = {
      moduleName = "pages/HeroPanel/skill/cellHeroSkillIcon"
    },
    descList = {
      moduleName = "pages/HeroPanel/skill/cellSkillDescItem"
    },
    confirmBtnInteract = true,
    confirmBtnActive = true,
    levelUpBlockBtnActive = false,
    infoToggleIsOn = true,
    levelUpToggleIsOn = false,
    maxLevelTipActive = false,
    maxLevelText = "",
    levelTextActive = true
  }
end

function module.methods()
  return {
    onClick_levelUp = function(self)
      if self:isPreviewMode() then
        return
      end
      self.bind.levelUpToggleIsOn = true
      self:refreshStatus(true)
      self:playTabSwicth("anim_heroes_skill_switch2uplevel")
    end,
    onClick_confirm = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroSkillUpgrade))
        return
      end
      if self:isPreviewMode() then
        return
      end
      if self:checkMaterialAndGoldEnough() then
        local hero = L_HeroStore:getHero(self.heroGuid)
        local tpl = heroTpl:getTplById(L_HeroStore:getHeroConfigId(hero))
        local index = heroTpl:getSkillIndex(tpl, self.data.curSelectSkillId)
        self.parent:setMaskActive(true)
        AzurWorld.heroMgr:ReqUpgradeHeroSkill(self.heroGuid, index, function()
          self:playLevelUpAni()
          self.data.lastSelect = self.bind.skillList[self.data.curSelectIndex]
          L_UI:open("pageHeroSkillAdvanceSuccess", {
            heroId = self.heroGuid,
            skillId = self.data.curSelectSkillId,
            propertyData = self.propertyData
          })
        end)
      end
    end,
    onClick_infoToggle = function(self, isOn)
      if isOn then
        self:refreshStatus(false)
        self:playTabSwicth("anim_heroes_skill_switch1detail")
      end
    end,
    onClick_levelUpToggle = function(self, isOn)
      if self:isPreviewMode() then
        return
      end
      if isOn then
        self:refreshStatus(true)
        self:playTabSwicth("anim_heroes_skill_switch2uplevel")
      end
    end,
    onClick_levelUpBlockBtn = function(self)
      if self:isPreviewMode() then
        return
      end
      local hero = self:getHero(self.heroGuid)
      local skill_list = L_HeroManager:getHeroSystemSkillList(hero)
      local serverData
      for _, v in pairs(skill_list) do
        if v.skillId == self.data.curSelectSkillId then
          serverData = v
          break
        end
      end
      if not serverData then
        return
      end
      if self.isSkillLocked then
        L_FlyMsgManager:showNormalMsg(self.bind.lockByLevelTxt)
        return
      end
      local isMaxLevel = skillLevelTpl:getMaxLevelById(serverData.skillId) <= serverData.skillLevel
      if isMaxLevel then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_skillup_max"))
      else
        L_FlyMsgManager:showNormalMsg(self.bind.lockByLevelTxt)
      end
    end,
    skillList = {
      onClick = function(self, bind)
        local skillId = bind.skillId
        if self.data.lastSelect then
          self.data.lastSelect.isActive = false
        end
        bind.isActive = true
        self.data.lastSelect = bind
        self.data.curSelectSkillId = skillId
        self.isSkillLocked = self:getSkillIslocked(self.data.curSelectSkillId)
        if self.isSkillLocked and self.isShowLevelUpPanel then
          self:playTabSwicth("anim_heroes_skill_switch1detail")
        end
        self:refreshCurInfoPanel()
        if self.isShowLevelUpPanel then
          self:refreshLevelUpPanel(true)
        end
        self:setPointsActive(bind.index)
        self.data.curSelectIndex = bind.index + 1
        self:playSwitchAni()
      end
    }
  }
end

function module:playTabSwicth(animName)
  self.bindComponents.statusAnim:Stop()
  self.bindComponents.statusAnim:Play(animName)
end

function module:open()
  self.isShowInfoPanel = true
  self.isShowLevelUpPanel = false
  self.bind.infoToggleIsOn = self.isShowInfoPanel
  L_HeroStore:listenCallFunc(L_HeroStore.event.setCurHeroGuid, self.onEvent_setCurHeroID, self)
end

function module:close()
  L_HeroStore:unListenCallFunc(L_HeroStore.event.setCurHeroGuid, self.onEvent_setCurHeroID)
  if self.levelupAniTimer then
    Timer.remove(self.levelupAniTimer)
  end
  self.levelupAniTimer = nil
end

function module:initPage()
  module.super.initPage(self)
  self:refreshPage(self.data.curSelectIndex ~= nil)
end

function module:refreshPage(isRemainLastSkillId)
  self.heroGuid = self:getModeController():getSelectGuid()
  self:setPointsActive(0)
  self.data.curSelectSkillId = nil
  local hero = self:getHero(self.heroGuid)
  local skills = L_HeroManager:getHeroSystemSkillList(hero)
  if not isRemainLastSkillId then
    self.data.curSelectIndex = 1
  end
  if self.data.curSelectIndex > #skills then
    self.data.curSelectIndex = 1
  end
  self.data.curSelectSkillId = skills[self.data.curSelectIndex].skillId
  local isSkillLocked = self:getSkillIslocked(self.data.curSelectSkillId)
  if isSkillLocked and self.isShowLevelUpPanel and not self:isPreviewMode() then
    self:playTabSwicth("anim_heroes_skill_switch1detail")
    self.isShowLevelUpPanel = false
    self.isShowInfoPanel = true
  end
  self:initSkillList(true)
  self:refreshCurInfoPanel()
  if self.isShowLevelUpPanel then
    self:refreshLevelUpPanel(true)
  end
  self:setSkillListActive()
end

function module:setSkillListActive()
  self.data.lastSelect = self.bind.skillList[self.data.curSelectIndex]
end

function module:refreshShowLevelUp(isShow)
  self.bind.isShowLevelUpBtn = isShow and not self:isPreviewMode()
end

function module:refreshCurInfoPanel()
  if not self.data.curSelectSkillId then
    return
  end
  local hero = self:getHero(self.heroGuid)
  local serverData, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == self.data.curSelectSkillId
  end)
  self.isSkillLocked = self:getSkillIslocked(self.data.curSelectSkillId)
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, serverData.skillLevel)
  local tpl_skill = _skillTpl:getTplById(self.data.curSelectSkillId)
  local tpl_skillSub = _skillsubLogicTpl:getTplById(skillLevelTpl:getSubSkillId(tpl_skillLevel))
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.skillStrength)
  self.bind.curNameTxt = _skillTpl:getName(tpl_skill)
  self:checkLevelUpUnlock()
  self:refreshShowLevelUp(self.bind.isLevelUpBtnEnable)
  self.modules.tagImageBox:tryInitModule(tpl_skill)
  self.bind.propertyList:clear()
  if _skillsubLogicTpl:getCoolDown(tpl_skillSub) > 0 then
    self.bind.propertyList:insert({
      icon = "Page/Skill/tex_icon_skillstatus_lq",
      propertyNameTxt = L_WordsTpl:getValue("notice_hero_skillCoolDown"),
      changedValueTxt = L_WordsTpl:getValue("menu_skill_coolDownTime", {
        [0] = _skillsubLogicTpl:getCoolDown(tpl_skillSub) / 1000
      })
    })
  end
  if 0 < _skillsubLogicTpl:getSpCost(tpl_skillLevel) then
    self.bind.propertyList:insert({
      icon = "Page/Skill/tex_icon_skillstatus_nlxh",
      propertyNameTxt = L_WordsTpl:getValue("notice_hero_skillConsume"),
      changedValueTxt = tostring(_skillsubLogicTpl:getSpCost(tpl_skillLevel))
    })
  end
  self.modules.moduleCurrency:refreshRes(tpl_sys)
  self.bind.descList:clear()
  local list = {}
  local desc = L_GameUtil.getSkillDesc(self.data.curSelectSkillId, serverData.skillLevel)
  local descs = string.split(desc, "\n")
  for i, v in ipairs(descs) do
    if not string.isEmpty(v) then
      table.insert(list, {descText = v})
    end
  end
  self.bind.descList:insert_array(list)
end

function module:refreshLevelUpPanel(isInit)
  self.data.isMaterialEnough = true
  local skillList_item = self:getSkillItem(self.data.curSelectSkillId)
  local tpl = skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, skillList_item.levelNum)
  local propertyName_list = skillLevelTpl:getName(tpl)
  local propertyValueCur_list = skillLevelTpl:getValue(tpl)
  local nextLevel = skillList_item.levelNum + 1
  local isMaxLevel = skillLevelTpl:getMaxLevelById(self.data.curSelectSkillId) <= skillList_item.levelNum
  if isMaxLevel then
    nextLevel = skillList_item.levelNum
  end
  local propertyValueNext_list = skillLevelTpl:getValue(skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, nextLevel))
  local material_list = skillLevelTpl:getItem(tpl)
  self.bind.costCurrencyIconPath = L_ItemManager:parseCurrencyItem(2).icon
  self.bind.costNumTxt = tostring(skillLevelTpl:getGold(tpl))
  self.bind.levelTextActive = not isMaxLevel
  self.modules.levelUpModule:tryInitModule(L_WordsTpl:getValue("menu_skill_levelUpTitle"), string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), skillList_item.levelNum), string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), skillList_item.levelNum + 1))
  if isMaxLevel then
    self.bind.maxLevelText = string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), skillList_item.levelNum)
  else
    self.bind.maxLevelText = ""
  end
  local propertyData = {}
  local propertyToAdvance = {}
  for i = 1, #propertyName_list do
    local prop = {
      propertyNameTxt = propertyName_list[i],
      changedValueTxt = propertyValueCur_list[i],
      txt_afterValue = propertyValueNext_list[i]
    }
    if isMaxLevel then
      prop.txt_afterValue = L_GameUtil.fillColor(prop.changedValueTxt, L_Const.colorHtml.grey003)
      prop.changedValueTxt = ""
    end
    table.insert(propertyData, prop)
    local tmp = {
      toggle_state = i % 2 > 0,
      name = propertyName_list[i],
      curAttr = propertyValueCur_list[i],
      nextAttr = propertyValueNext_list[i],
      active_icon = false
    }
    table.insert(propertyToAdvance, tmp)
  end
  self.propertyData = propertyToAdvance
  if isInit then
    self.bind.levelPropertyList:clear()
    self.bind.levelPropertyList:insert_array(propertyData)
  else
    for i = 1, #self.bind.levelPropertyList do
      self.bind.levelPropertyList:change(i, propertyData[i])
    end
  end
  local list2 = {}
  for i = 1, #material_list do
    local itemId = material_list[i][1]
    local haveNum = C_BagMgr:getItemNumByItemId(itemId)
    local keep_num = ""
    if haveNum < material_list[i][2] then
      keep_num = string.format("<color=#FF0000>%s</color>/%s", haveNum, material_list[i][2])
      self.data.isMaterialEnough = false
    else
      keep_num = string.format("%s/%s", haveNum, material_list[i][2])
    end
    table.insert(list2, {
      itemId = itemId,
      itemNumTxt = keep_num,
      itemType = L_Const.resType.commonItem,
      showStar = 0
    })
  end
  self.bind.costList:clear()
  self.bind.costList:insert_array(list2)
end

function module:playSwitchAni()
  self.bindComponents.moduleHeroSkill:Stop()
  self.bindComponents.moduleHeroSkill:Play("anim_heroes_skill_switch")
end

function module:playLevelUpAni()
  self.bindComponents.skillLevelUp:Stop()
  self.bindComponents.skillLevelUp:Play("anim_heroes_skill_levelup")
  local skillCell = self.bind.skillList:getItemCls(self.data.curSelectIndex)
  if skillCell then
    skillCell:playLevelUpAni()
  end
  for i = 1, #self.bind.levelPropertyList do
    local propertyCell = self.bind.levelPropertyList:getItemCls(i)
    if propertyCell then
      propertyCell:playLevelUpAni(i)
    end
  end
  if self.levelupAniTimer then
    Timer.remove(self.levelupAniTimer)
  end
  self.levelupAniTimer = Timer.once(0.7, function()
    self:refreshCurInfoPanel()
    self:refreshLevelUpPanel()
    self:initSkillList()
    self:refreshStatus(true)
    self.parent:setMaskActive(false)
    Timer.remove(self.levelupAniTimer)
    self.levelupAniTimer = nil
  end, self)
end

function module:initSkillList(isInit)
  local hero = self:getHero(self.heroGuid)
  local skillMap = L_HeroManager:getHeroSystemSkillList(hero)
  local list = {}
  local index = 0
  for _, skill in ipairs(skillMap) do
    local skillId = skill.skillId
    local tpl = _skillTpl:getTplById(skillId)
    local level = skill.skillLevel
    local type = _skillTpl:getSkillDisplayType(tpl)
    local isMaxLevel = level >= skillLevelTpl:getMaxLevelById(skillId)
    local levelTxt = isMaxLevel and L_WordsTpl:getValue("menu_common_lvMax") or string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), level)
    table.insert(list, {
      isActive = skillId == self.data.curSelectSkillId,
      levelTxt = levelTxt,
      levelNum = level,
      iconPath = _skillTpl:getIcon(tpl),
      isLevel = true,
      isblankBg = true,
      levelText = levelTxt,
      heroId = self.heroGuid,
      skillId = skillId,
      index = index,
      isPreview = self:isPreviewMode(),
      isLock = self:getSkillIslocked(skillId),
      showRed = true
    })
    index = index + 1
  end
  if isInit then
    self.bind.skillList:clear()
    self.bind.skillList:insert_array(list)
  else
    for i, v in ipairs(list) do
      self.bind.skillList:change(i, v)
    end
  end
end

function module:getSkillIslocked(skillId)
  local hero = self:getHero(self.heroGuid)
  if not hero then
    return true
  end
  local serverData, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == skillId
  end)
  if serverData.skillLevel == 1 then
    local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(skillId, serverData.skillLevel)
    self.targetLevel = skillLevelTpl:getHeroLevel(tpl_skillLevel)
    self.targetRank = skillLevelTpl:getHeroRank(tpl_skillLevel)
    self.isLockByLevel = L_HeroStore:getHeroLevel(hero) < self.targetLevel
    self.isLockByRank = L_HeroStore:getHeroRank(hero) < self.targetRank
    if self.isLockByLevel or self.isLockByRank then
      return true
    end
  end
  return false
end

function module:getSkillItem(skillId)
  for i = 1, #self.bind.skillList do
    if self.bind.skillList:getValue(i, "skillId") == skillId then
      return self.bind.skillList:getValue(i)
    end
  end
end

function module:onEvent_setCurHeroID(heroID, oldHeroID)
  self:refreshPage(self.data.curSelectIndex ~= nil)
  self.bindComponents.moduleHeroSkill:Stop()
  self.bindComponents.moduleHeroSkill:Play("anim_heroes_skill_tmp")
end

function module:getTimelineState()
  return L_Const.heroTimelineState.Skill
end

function module:setPointsActive(index)
  for i = 0, self.bindComponents.listbg.childCount - 1 do
    self.bindComponents.listbg:GetChild(i).gameObject:ActiveTrans(false)
  end
  if index then
    self.bindComponents.listbg:GetChild(index).gameObject:ActiveTrans(true)
  end
end

function module:checkMaterialAndGoldEnough()
  local hero = self:getHero(self.heroGuid)
  local skill, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == self.data.curSelectSkillId
  end)
  local tpl = skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, skill.skillLevel)
  if not self.data.isMaterialEnough then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_skillup_lackitem"))
    return false
  elseif skillLevelTpl:getGold(tpl) > L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_common_lackGold"))
    return false
  end
  return true
end

function module:refreshStatus(isShowLevelUp)
  if self:isPreviewMode() then
    return
  end
  local hero = self:getHero(self.heroGuid)
  local serverData, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == self.data.curSelectSkillId
  end)
  local canLevelUp = not self:getSkillIslocked(self.data.curSelectSkillId)
  self.isShowLevelUpPanel = isShowLevelUp and canLevelUp
  self.isShowInfoPanel = not isShowLevelUp or not canLevelUp
  self.bind.infoToggleIsOn = self.isShowInfoPanel
  self:checkLevelUpUnlock()
  if self.isShowLevelUpPanel then
    self:refreshLevelUpPanel(true)
  end
end

function module:checkLevelUpUnlock()
  local hero = self:getHero(self.heroGuid)
  local serverData, i = table.ipairsFind(L_HeroManager:getHeroSystemSkillList(hero), function(v)
    return v.skillId == self.data.curSelectSkillId
  end)
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, serverData.skillLevel + 1)
  local canUp = skillLevelTpl:getCanUp(skillLevelTpl:getTplByIdAndLevel(self.data.curSelectSkillId, serverData.skillLevel))
  local isLockByRank = false
  local isLockByLevel = false
  local requiredHeroLevel = 1
  local requiredHeroRank = 1
  local isMaxLevel = skillLevelTpl:getMaxLevelById(serverData.skillId) <= serverData.skillLevel
  if tpl_skillLevel then
    requiredHeroLevel = skillLevelTpl:getHeroLevel(tpl_skillLevel)
    requiredHeroRank = skillLevelTpl:getHeroRank(tpl_skillLevel)
    isLockByLevel = requiredHeroLevel > L_HeroStore:getHeroLevel(hero)
    isLockByRank = requiredHeroRank > L_HeroStore:getHeroRank(hero)
  end
  local canOpenUp = not self.isSkillLocked
  self.bind.isShowLockByLevel = self.isSkillLocked or not self:isPreviewMode() and (isLockByLevel or isLockByRank)
  self.bind.isLevelUpBtnEnable = not self.bind.isShowLockByLevel and not isMaxLevel
  self.bind.confirmBtnActive = not self.bind.isShowLockByLevel and not isMaxLevel
  self.bind.confirmBtnInteract = self.bind.confirmBtnActive
  self.bind.curLevelTxt = isMaxLevel and L_WordsTpl:getValue("menu_common_lvMax") or string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), serverData.skillLevel)
  self.bind.maxLevelTipActive = isMaxLevel and not self.isSkillLocked
  if self.isSkillLocked then
    self.bind.lockByLevelTxt = self:getUnlockTips(self.isLockByRank, self.isLockByLevel, self.targetRank, self.targetLevel)
  else
    self.bind.lockByLevelTxt = self:getUnlockTips(isLockByRank, isLockByLevel, requiredHeroRank, requiredHeroLevel)
  end
  self.bind.levelUpBlockBtnActive = not canOpenUp or self:isPreviewMode()
  self.bind.infoToggleIsOn = not canOpenUp
  return canOpenUp
end

function module:getUnlockTips(isLockByRank, isLockByLevel, requiredHeroRank, requiredHeroLevel)
  local lockTips = ""
  if isLockByRank and not isLockByLevel then
    if self.isSkillLocked then
      lockTips = sL_WordsTpl:getValue("notice_skillunlock_rank", {
        [0] = requiredHeroRank
      })
    else
      lockTips = L_WordsTpl:getValue("notice_skillUp_rank", {
        [0] = requiredHeroRank
      })
    end
  elseif isLockByLevel and not isLockByRank then
    if self.isSkillLocked then
      lockTips = L_WordsTpl:getValue("notice_skillunlock_level", {
        [0] = requiredHeroLevel
      })
    else
      lockTips = L_WordsTpl:getValue("notice_skillUp_level", {
        [0] = requiredHeroLevel
      })
    end
  elseif isLockByRank and isLockByLevel then
    if self.isSkillLocked then
      lockTips = L_WordsTpl:getValue("notice_skillunlock_levelrank", {
        [1] = requiredHeroLevel,
        [2] = requiredHeroRank
      })
    else
      lockTips = L_WordsTpl:getValue("notice_skillUp_levelRank", {
        [1] = requiredHeroLevel,
        [2] = requiredHeroRank
      })
    end
  end
  return lockTips
end

function module:show(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Skill, true)
end

function module:hide(options)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Skill, false)
end

return module
