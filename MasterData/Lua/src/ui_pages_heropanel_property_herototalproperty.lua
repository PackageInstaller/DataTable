local this = class("heroTotalProperty", G_UIModuleBase)
local _heroLevelTpl = L_GameTpl:getHeroLevelTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()

function this.bind()
  return {
    color_nationBg = C_Color(1, 1, 1, 1),
    nation = "BSCommon/tex_icon_nation_01",
    heroName = "",
    currentLv = "",
    maxLv = "",
    lvSlider = 0,
    lvUpBtn = true,
    heroPropertyItem = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    moduleHeroShowStar = {
      moduleName = "pages/HeroPanel/moduleHeroShowStar"
    },
    nameDecalText = "",
    skillList = {
      moduleName = "pages/heroPanel/skill/cellHeroSkillIcon"
    },
    curExpValueText = "",
    maxExpValueText = "",
    rankText = "",
    rankList = {},
    go_GiveGift = false,
    go_resetModBtn = false,
    go_heroCustomClothes = false,
    go_HeroClothing = false,
    go_HeroClothingNew = false,
    txt_giveGiftHeroCloth = "",
    txt_giveGiftDecorate = "",
    active_singleElement = false,
    active_doubleElement = false,
    img_elementBG = "",
    img_mainElementBG = "",
    img_subElementBG = "",
    img_professionIcon = "",
    txt_profession = "",
    img_heroGradeBg = "",
    img_grade = "",
    go_arrow = false,
    txt_heroGrade = "",
    active_heroGradeStar1 = false,
    active_heroGradeStar2 = false,
    active_heroGradeStar3 = false,
    active_heroGradeStar4 = false,
    active_heroGradeStar5 = false,
    active_heroGradeStar6 = false,
    moduleHeroFavorabilityArea = {
      moduleName = "pages/heroPanel/moduleHeroFavorabilityArea"
    }
  }
end

function this.methods()
  return {
    onClick_detailsBtn = function(self)
      L_UI:open("pageHeroProperty", {
        heroGuid = self.parent.heroGuid,
        showCurrentProperty = self.parent:showCurrentProperty(),
        showArrow = false,
        bPreview = self.parent:isPreviewMode()
      })
    end,
    onClick_levelUpBtn = function(self)
      self.parent:onClickLevelUp()
    end,
    onClick_professionIcon = function(self)
      local heroId = self:getHeroId()
      local hero = self.parent:getHero(heroId)
      L_UI:open("pageElementalRestraint", {
        heroTplId = L_HeroStore:getHeroConfigId(hero),
        initTab = 1
      })
    end,
    skillList = {
      onClick = function(self, bind)
        local skillId = bind.skillId
        L_UI:open("pageSkillInfo", {
          isPreview = self.parent:isPreviewMode(),
          hero = self.parent:getHero(self:getHeroId()),
          skillId = skillId,
          skillList = self.skillList
        })
      end
    },
    onClick_TalentBtn = function(self)
      if self.parent:isPreviewMode() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("cannotcheck"))
        return
      end
      local hero = self.parent:getHero(self:getHeroId())
      L_HeroManager:showHeroSelection(L_Const.heroModuleType.Talent, L_HeroStore:getHeroGuid(hero))
    end,
    OnClick_btnGift = function(self)
      L_HeroVoiceManager:stopHeroVoice()
      L_UI:open("PageGiveGift", {
        heroID = self.parent:getModeController():getSelectConfigId(),
        heroGuid = self.parent.heroGuid,
        openCallback = function()
          if self.parent.parent and self.parent.parent.isBind then
            self.parent.parent.bind.goAniRoot = false
          end
        end,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    onClick_resetMod = function(self)
    end,
    onClick_decorate = function(self)
      local isUnlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.mainHeroClothing)
      if not isUnlock then
        return
      end
      if self:GetSourceLuaPageOptions("failure_jump") then
        L_FlyMsgManager:showNormalMsgByKey("common_jump_ban_tips")
        return
      end
      if L_GameUtil.checkClothingBlocked() then
        return
      end
      L_UI:open("pageCustomClothes")
    end,
    onClick_heroClothing = function(self)
      if self:GetSourceLuaPageOptions("failure_jump") then
        L_FlyMsgManager:showNormalMsgByKey("common_jump_ban_tips")
        return
      end
      if L_GameUtil.checkClothingBlocked() then
        return
      end
      local heroId = AzurWorld.heroMgr:GetHero(self.parent.heroGuid).configId
      L_UI:open("pageHeroClothing", {heroId = heroId})
    end,
    onClick_singleElement = function(self)
      local heroId = self:getHeroId()
      local hero = self.parent:getHero(heroId)
      L_UI:open("pageElementalRestraint", {
        heroTplId = L_HeroStore:getHeroConfigId(hero),
        initTab = 0
      })
    end,
    onClick_doubleElement = function(self)
      local heroId = self:getHeroId()
      local hero = self.parent:getHero(heroId)
      L_UI:open("pageElementalRestraint", {
        heroTplId = L_HeroStore:getHeroConfigId(hero),
        initTab = 0
      })
    end,
    onClick_heroGrade = function(self)
      if not self.parent:checkCanShowGrade() then
        return
      end
      if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
        L_FlyMsgManager:showNormalMsg(L_GameTpl:getWordsTpl():getValue("notice_hero_grade_ride_limit"))
        return
      end
      self.parent.parent:on_BottomFuncSelChange(L_Const.heroModuleType.Grade)
    end
  }
end

function this:getHeroLv()
  local hero = self.parent:getHero(self:getHeroId())
  return L_HeroStore:getHeroLevel(hero)
end

function this:getHeroId()
  return self.parent.heroGuid
end

function this:open()
  self.isFirstOpen = true
  self.bind.txt_heroGrade = L_WordsTpl:getValue("ui_hero_dec_03")
  self.bind.txt_giveGiftHeroCloth = L_WordsTpl:getValue("ui_pagehero_1")
  self.bind.txt_giveGiftDecorate = L_WordsTpl:getValue("ui_pagehero_1")
end

function this:show()
  local isPreview = self.parent:isPreviewMode()
  if not isPreview then
    local defaultHeroGuid = L_HeroStore:getDefaultHeroGuid()
    if self.parent.heroGuid ~= defaultHeroGuid then
      self:refreshHeroClothing()
    end
  end
end

function this:refreshHeroProperty()
  local hero = self.parent:getHero(self:getHeroId())
  self.heroConfigId = hero.configId
  if self.parent:isPreviewMode() and self.isFirstOpen then
    local heroId = self:getHeroId()
    local hero = self.parent:getHero(heroId)
    local lv = L_HeroStore:getHeroLevel(hero)
    if lv == 1 then
      self.bindComponents.heroPropertyAnimation:Play("anim_herodetail_init")
    end
    self.isFirstOpen = false
  end
  self:refreshHeroPropertyTotal()
  self:refreshHeroProfession()
  self:refreshHeroGrade()
  self:refreshCustomHeroVisibility()
  local favorArea = self.modules.moduleHeroFavorabilityArea
  if favorArea then
    favorArea:setData(self.parent.heroGuid, self.heroConfigId, self.parent:getModeController(), function()
      L_HeroVoiceManager:stopHeroVoice()
      L_UI:open("PageGiveGift", {
        heroID = self.parent:getModeController():getSelectConfigId(),
        heroGuid = self.parent.heroGuid,
        openCallback = function()
          if self.parent.parent and self.parent.parent.isBind then
            self.parent.parent.bind.goAniRoot = false
          end
        end,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end)
  end
  self.modules.moduleHeroFavorabilityArea:refreshHeroFavorabilityInfo()
  self.bind.go_GiveGift = false
  self.bind.go_resetModBtn = false
  self.bind.go_HeroClothing = false
  local isPageTypeNotDetail = self.parent.parent.options.pageType ~= L_Const.heroPageType.DetailMode
  local isPreview = self.parent:isPreviewMode()
  if not isPreview then
    local defaultHeroGuid = L_HeroStore:getDefaultHeroGuid()
    if self.parent.heroGuid == defaultHeroGuid then
      if isPageTypeNotDetail then
        self:refreshResetActive()
      end
    else
      if isPageTypeNotDetail then
        self:refreshGiftActive()
      end
      self:refreshHeroClothing()
    end
  end
end

function this:playTotalPreviewAnimation(isMax)
  if isMax then
    self.bindComponents.heroPropertyAnimation:Play("anim_herodetail_fresh100")
  else
    self.bindComponents.heroPropertyAnimation:Play("anim_herodetail_fresh1")
  end
end

function this:refreshHeroProfession()
  local heroTpl = L_GameTpl:getHeroTpl()
  local heroId = self:getHeroId()
  local hero = self.parent:getHero(heroId)
  local tpl = heroTpl:getTplById(L_HeroStore:getHeroConfigId(hero))
  local elementId = heroTpl:getElement(tpl)
  local doubleElement = false
  local subElementId = heroTpl:getSubElement(tpl)
  if subElementId ~= nil and 0 < subElementId then
    doubleElement = true
  end
  local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
  local mainElementTypeTpl = _elementTypeTpl:getTplById(elementId)
  if doubleElement then
    self.bind.active_doubleElement = true
    self.bind.active_singleElement = false
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.img_mainElementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.main)
    self.bind.img_subElementBG = _elementTypeTpl:getElementIcon(subElementTypeTpl, L_Const.elementIconType.sub)
  else
    self.bind.active_doubleElement = false
    self.bind.active_singleElement = true
    self.bind.img_elementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.single)
  end
  local position = heroTpl:getPosition(tpl)
  local professionTpl = L_GameTpl:getProfessionTpl()
  self.bind.nameDecalText = heroTpl:getEnglishName(tpl)
  local nationId = heroTpl:getNations(tpl)
  local groupsTpl = L_GameTpl:getGroupsTpl()
  local iconPath = groupsTpl:getIcon(groupsTpl:getTplById(nationId), L_Const.nationTextureIndex.nationLarge)
  if not string.isEmpty(iconPath) then
    self.bind.nation = iconPath
  end
  self.bind.img_professionIcon = professionTpl:getIcon(professionTpl:getTplById(position), 2)
  self.bind.txt_profession = professionTpl:getName(professionTpl:getTplById(position))
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self:getHeroId(), heroConfigId)
  local clothingData = L_GameTpl:getHeroClothingTpl():getTplById(clothingId)
  if clothingData ~= nil then
    local _, backgroundColor = C_ColorUtility.TryParseHtmlString(clothingData.uibackgroundColor)
    self.bind.color_nationBg = backgroundColor
  end
end

function this:refreshHeroGrade()
  local heroId = self:getHeroId()
  local hero = self.parent:getHero(heroId, self.parent:showCurrentProperty())
  local heroGrade = L_HeroStore:getHeroStar(hero)
  self.bind.go_arrow = heroGrade ~= 0
  self.bind.img_grade = "UI/Page/HeroDetail/tex_hero_icon_star_0" .. heroGrade + 2 .. ".png"
  for i = 1, 6 do
    self.bind["active_heroGradeStar" .. tostring(i)] = heroGrade >= i
  end
  self.bind.img_heroGradeBg = string.format("UI/Icon/HeroGradeBg/tex_herodetail_bg_%s.png", L_HeroStore:getHeroConfigId(hero))
  local normalMode = not self.parent:isPreviewMode() and not self.parent:showCurrentProperty()
  if normalMode then
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format(L_ReddotManager.DotDef.HeroGrade, self.parent.heroGuid), self.bindComponents.redotNormalGrade.gameObject)
  else
    self.bindComponents.redotNormalGrade.gameObject:SetActive(normalMode)
  end
end

function this:refreshHeroPropertyTotal()
  local attId = battleInfoTpl:getShowTypeOutsideAttrs()
  self.bind.gold = false
  self.bind.expCount = ""
  local heroId = self:getHeroId()
  local hero = self.parent:getHero(heroId)
  local rank = L_HeroStore:getHeroRank(hero)
  self.bind.rankText = L_Const.Number2Roma[rank]
  local valueList = {}
  local propertyData = {}
  local attDic = {}
  if self.parent:isPreviewMode() then
    if not self.parent:showCurrentProperty() then
      local heroPreview = L_AttributeManager:parseHeroConfigAttByHero(hero, L_HeroStore:getHeroLevel(hero))
      valueList = heroPreview
    else
      local csEntity = L_PlayerManager:getAllHeroCsEntity()[heroId]
      if csEntity then
        local aliveProperty = csEntity.data.aliveProperty
        for i, v in pairs(attId) do
          local current = C_MyFloatUtility.GetFloat(aliveProperty:GetBattlePropertyCurrentValue(v))
          if table.containsValue(L_Const.SpecialAttList, v) then
            valueList[v] = v == 5 and math.floor(current) or math.round(current)
          else
            valueList[v] = math.round(current)
          end
        end
      end
    end
  else
    for i, v in pairs(L_HeroStore:getHeroPropertyMap(hero.guid)) do
      if table.containsValue(L_Const.SpecialAttList, i) then
        attDic[i] = i == 5 and math.floor(v / 10000) or math.round(v / 10000)
      else
        attDic[i] = math.round(v)
      end
    end
    for i, v in pairs(attId) do
      local id, value = L_AttributeManager:getHeroAttValue(attDic, v)
      valueList[v] = value
    end
  end
  for i, v in ipairs(attId) do
    table.insert(propertyData, {
      attrIcon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(v)),
      value = battleInfoTpl:getShowTxt(v, valueList[v]),
      name = battleInfoTpl:getName(battleInfoTpl:getTplById(v)),
      color_bg = C_Color(1, 1, 1, i % 2 == 1 and 0.7 or 0.5)
    })
  end
  self.bind.heroPropertyItem:clear()
  self.bind.heroPropertyItem:insert_array(propertyData)
  local configId = heroId
  local data = AzurWorld.heroMgr:GetHero(heroId)
  if data ~= nil then
    configId = data.configId
    hero.lv = data.lv
  end
  if self.parent:isPreviewMode() then
    if self.parent:showCurrentProperty() then
      if configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female) then
        self.bind.heroName = L_PlayerStore:getPlayerName()
      else
        self.bind.heroName = L_HeroManager:getHeroName(heroId)
      end
    else
      self.bind.heroName = L_HeroManager:getHeroName(heroId, configId)
    end
  else
    self.bind.heroName = L_HeroManager:getHeroName(heroId)
  end
  local heroTpl = L_GameTpl:getHeroTpl()
  local tpl = heroTpl:getTplById(L_HeroStore:getHeroConfigId(hero))
  self.modules.moduleHeroShowStar:refreshStar(heroTpl:getRarity(tpl) + 1)
  local lv = L_HeroStore:getHeroLevel(hero)
  self.maxLv = _heroLevelTpl:getMaxLvByCondition()
  self.bind.currentLv = self:lvChange(lv, self.maxLv)
  if self.parent:showCurrentProperty() then
    self.bind.maxLv = string.format("/%d", _heroLevelTpl:getMaxLv())
  else
    self.bind.maxLv = string.format("/%d", self.maxLv)
  end
  local tpl = _heroLevelTpl:getTplById(L_HeroStore:getHeroLevel(hero))
  if self.parent:isPreviewMode() then
    if lv == _heroLevelTpl:getMaxLv() then
      self.bind.lvSlider = 1
      self.bind.curExpValueText = "MAX"
      self.bind.maxExpValueText = "/MAX"
    else
      self.bind.lvSlider = 0
      self.bind.curExpValueText = tostring(L_HeroStore:getHeroExp(hero))
      self.bind.maxExpValueText = string.format("/%d", _heroLevelTpl:getExp(tpl))
    end
  elseif lv == _heroLevelTpl:getMaxLv() then
    self.bind.lvSlider = 1
    self.bind.lvUpBtn = false
    self.bind.curExpValueText = "MAX"
    self.bind.maxExpValueText = "/MAX"
  elseif lv == self.maxLv then
    self.bind.active_expValueText = true
    self.bind.lvSlider = 0
    self.bind.lvUpBtn = true
    local previousTpl = _heroLevelTpl:getTplById(L_HeroStore:getHeroLevel(hero))
    self.bind.curExpValueText = "0"
    self.bind.maxExpValueText = string.format("/%d", _heroLevelTpl:getExp(previousTpl))
  else
    self.bind.lvSlider = L_HeroStore:getHeroExp(hero) / _heroLevelTpl:getExp(tpl)
    self.bind.lvUpBtn = true
    self.bind.curExpValueText = tostring(L_HeroStore:getHeroExp(hero))
    self.bind.maxExpValueText = string.format("/%d", _heroLevelTpl:getExp(tpl))
  end
  if self.bind.lvUpBtn == true then
    self.bind.lvUpBtn = not self.parent:isPreviewMode()
  end
  self:skillListSet()
  self:refreshRankList(hero)
end

function this:lvChange(lv, limitLv)
  if lv < 10 then
    return string.format("0%d", lv)
  end
  return tostring(lv)
end

function this:sliderChange(value)
  return 0.1 + value * 0.8
end

function this:skillListSet()
  self.bind.skillList:clear()
  local hero = self.parent:getHero(self:getHeroId())
  local skillMap = L_HeroManager:getHeroSystemSkillList(hero)
  local skillTpl = L_GameTpl:getSkillTpl()
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  self.skillList = {}
  local index = 0
  for i, skill in ipairs(skillMap) do
    if 5 < i then
      break
    end
    local skillId = skill.skillId
    local tpl = skillTpl:getTplById(skillId)
    local level = skill.skillLevel
    local type = skillTpl:getSkillDisplayType(tpl)
    local isMaxLevel = level >= skillLevelTpl:getMaxLevelById(skillId)
    local levelTxt = isMaxLevel and L_WordsTpl:getValue("menu_common_lvMax") or string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), level)
    table.insert(self.skillList, {
      levelTxt = levelTxt,
      levelNum = level,
      iconPath = skillTpl:getIcon(tpl),
      borderImgColor = L_Const.skillBorderIcon[type],
      isLevel = true,
      isblankBg = true,
      levelText = levelTxt,
      heroId = self.heroGuid,
      skillId = skillId,
      index = index,
      isPreview = true
    })
    index = index + 1
  end
  self.bind.skillList:insert_array(self.skillList)
end

function this:skillListChoice(id)
  for i = 1, #self.bind.skillList do
    if self.bind.skillList:getValue(i, "skillId") == id then
      self.bind.skillList:change(i, {choice = true})
    else
      self.bind.skillList:change(i, {choice = false})
    end
  end
end

function this:refreshRankList(hero)
  local rankTpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), L_HeroStore:getHeroRank(hero))
  local itemsNum = #talentRankTpl:getRankBreakthroughItem(rankTpl)
  local runes = L_HeroStore:getHeroRuneIds(hero)
  local temp = {}
  local activateRuneNum = 0
  for i = 1, itemsNum do
    table.insert(temp, {})
    if not math.isEmpty(runes[i]) then
      activateRuneNum = activateRuneNum + 1
    end
  end
  self.bind.rankList:clear()
  self.bind.rankList:insert_array(temp)
  for i = 1, #self.bind.rankList do
    local cell = self.bind.rankList:getItemCls(i)
    cell.bindComponents.toggle_activateRank.isOn = i <= activateRuneNum
  end
end

function this:refreshGiftActive()
  local isNeedShowGift = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.present)
  self.bind.go_GiveGift = false
  self.bind.go_giftReddot = false
  AzurWorld.RedDotMgr:BindRedDotRenderer("Gift_" .. self.parent.heroGuid, self.bindComponents.redotNormal.gameObject)
end

function this:refreshHeroClothing()
  local heroGuid = self.parent.heroGuid
  local curHeroId = AzurWorld.heroMgr:GetHero(heroGuid).configId
  local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local isNeedShow = self:getNeedShowHeroClothing(heroGuid, curHeroId, _heroClothingTpl)
  self.bind.go_HeroClothing = isNeedShow
  self.bindComponents.redDotHeroClothing.gameObject:SetActive(false)
  if isNeedShow then
    local key = string.format(L_ReddotManager.DotDef.HeroClothing, heroGuid)
    AzurWorld.RedDotMgr:BindRedDotRenderer(key, self.bindComponents.redDotHeroClothing.gameObject)
    local hasRedDot = AzurWorld.RedDotMgr:GetRedDotState(key)
    local isNew = false
    if not hasRedDot then
      for k, v in pairs(_heroClothingTpl.data) do
        local heroId = _heroClothingTpl:getHero(v)
        if k ~= heroId and heroId == curHeroId and AzurWorld.heroMgr:IsHeroClothingNew(v.clothingid) then
          isNew = true
          break
        end
      end
    end
    self.bind.go_HeroClothingNew = isNew
  end
end

function this:getNeedShowHeroClothing(heroGuid, curHeroId, _heroClothingTpl)
  local isNeedShow = false
  local unlock = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.heroClothing)
  if not unlock then
    return isNeedShow
  end
  for k, v in pairs(_heroClothingTpl.data) do
    local heroId = _heroClothingTpl:getHero(v)
    if k ~= heroId and heroId == curHeroId and v.isUnlock then
      isNeedShow = true
      break
    end
  end
  return isNeedShow
end

function this:refreshResetActive()
end

function this:refreshCustomHeroVisibility()
  local isPreview = self.parent:isPreviewMode()
  if isPreview then
    self.bind.go_heroCustomClothes = not isPreview
    return
  end
  local defaultHeroGuid = L_HeroStore:getDefaultHeroGuid()
  if self.parent.heroGuid ~= defaultHeroGuid then
    self.bind.go_heroCustomClothes = false
  else
    self.bind.go_heroCustomClothes = true
  end
end

return this
