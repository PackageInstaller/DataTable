local this = class("pageProperty", G_UIPageBase)
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local detailsTpl = L_GameTpl:getDetailsTpl()
local soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessorySetTpl = L_GameTpl:getAccessorySetTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    txt_title_fontSize = 20,
    battleTagList = {
      moduleName = "pages/propertyPanel/cellBattleType"
    },
    groupList = {
      moduleName = "pages/propertyPanel/cellPropertyGroup"
    },
    soulessenceList = {
      moduleName = "pages/propertyPanel/cellHeroSoulessence"
    },
    accessorySpecialityList = {
      moduleName = "pages/propertyPanel/cellAccessorySpeciality"
    },
    accessoryEffectList = {
      moduleName = "pages/propertyPanel/cellAccessoryEffect"
    },
    active_battleTagList = false,
    groupListActive = true,
    soulessenceListAcitive = false,
    accessorySpecialityListActive = false,
    accessoryEffectListActive = false,
    groupListY = 1,
    active_guideArrow = false,
    active_annoyTip = false,
    txt_curCatchForce = "",
    txt_targetCatchForceDesc = "",
    txt_annoyDesc = ""
  }
end

function this.methods()
  return {
    onClick_closeBg = function(self)
      L_UI:close(self.pageName)
    end,
    onValueChanged = function(self, data)
      if not self.contentHeightOver then
        return
      end
      if data.y < 0.001 then
        if self.bind.active_guideArrow then
          self.bind.active_guideArrow = false
        end
      elseif not self.bind.active_guideArrow then
        self.bind.active_guideArrow = true
      end
    end
  }
end

function this:open(options)
  self:initModule(options)
end

function this:setPanelActive(isShow)
end

function this:initModule(options)
  self.options = options
  local tpl = detailsTpl:getTplById(options.detailId)
  self.showType = detailsTpl:getPage(tpl)
  if not L_DeviceTpl:getIsPc() then
    self.bind.txt_title_fontSize = 22
  end
  self:refreshList()
  Timer.once(0, function()
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectContent)
    self:checkGuideArrowShowByContentHeight()
  end, self)
end

function this:refreshList()
  self:resetView()
  self:refreshHeroBattleTagView()
  self:refreshDetailView()
  self:refreshSpiritView()
  self:refreshEquipmentView()
end

function this:checkGuideArrowShowByContentHeight()
  local height = self.bindComponents.verticalLayoutGroupContent.preferredHeight
  self.contentHeightOver = height > self.bindComponents.rectBackground.rect.height - 80
  self.bind.active_guideArrow = self.contentHeightOver
end

function this:resetView()
  self.bind.groupListY = 1
  self.bind.active_battleTagList = false
  self.bind.groupListActive = false
  self.bind.soulessenceListAcitive = false
  self.bind.accessorySpecialityListActive = false
  self.bind.accessoryEffectListActive = false
end

function this:refreshHeroBattleTagView()
  if self.showType == L_Const.propertyPageType.equipment or self.showType == L_Const.propertyPageType.kiBo then
    return
  end
  local heroItem
  if self.showType == L_Const.propertyPageType.heroPreview then
    heroItem = self.options.heroData
  else
    heroItem = L_HeroStore:getHero(L_HeroStore:getHeroGuid(self.options.heroData))
  end
  local heroCfgId = L_HeroStore:getHeroConfigId(heroItem)
  local heroCfg = _heroTpl:getTplById(heroCfgId)
  local heroTagInfo = _heroTpl:getBattleTag(heroCfg)
  local tagInfoList = {}
  if heroTagInfo and 0 < #heroTagInfo then
    self.bind.active_battleTagList = true
    for _, v in ipairs(heroTagInfo) do
      table.insert(tagInfoList, {tagId = v})
    end
  end
  self.bind.battleTagList:clear()
  self.bind.battleTagList:insert_array(tagInfoList)
end

function this:refreshDetailView()
  self.bind.groupListActive = true
  local attDic = {}
  local groups
  if self.showType ~= L_Const.propertyPageType.kiBo then
    if self.options.isPreview then
      attDic = L_AttributeManager:parseHeroConfigAttByHero(self.options.heroData, self.options.heroData.heroId)
    else
      local heroId = L_HeroStore:getHeroGuid(self.options.heroData)
      self.guid = heroId
      for i, v in pairs(L_HeroStore:getHeroPropertyMap(heroId)) do
        if table.containsValue(L_Const.SpecialAttList, i) then
          attDic[i] = i == 5 and math.floor(v / 10000) or math.round(v / 10000)
        else
          attDic[i] = math.round(v)
        end
      end
      if self.showType == L_Const.propertyPageType.equipment then
        self.equipmentAtt = L_AttributeManager:getMergeHeroAtt(self.guid, {2, 3})
      end
    end
    groups = L_AttributeManager:getPropertiesForDisplay(L_Const.roleType.hero, attDic, self.guid)
  end
  if self.showType == L_Const.propertyPageType.kiBo and self.options.petData ~= nil then
    attDic = L_PetStore:getPetProperty(self.options.petData)
    local guid = self.options.petData.guid
    groups = L_AttributeManager:getPropertiesForDisplay(L_Const.roleType.pet, attDic, guid)
    self:checkShowAnnoy()
  end
  self.bind.groupList:clear()
  self.bind.groupList:insert_array(groups)
end

function this:checkShowAnnoy()
  local guid = self.options.petData.guid
  local pet = L_PetStore:getPetItem(guid)
  if pet == nil then
    return
  end
  local isLimit = pet:getPetAbilityLimited()
  self.bind.active_annoyTip = isLimit
  if isLimit then
    self.bind.txt_curCatchForce = tostring(L_PlayerStore:getCurrencyNum(L_Const.currencyType.catchForce))
    self.bind.txt_targetCatchForceDesc = L_WordsTpl:getValue("ui_text_starlink_ability_kibo_free", {
      [0] = tostring(pet:getNoAnnoyMinCatchForce())
    })
    self.bind.txt_annoyDesc = L_WordsTpl:getValue("ui_text_starlink_ability_kibo_suppress", {
      [0] = tostring(math.round(pet:getPetAbilityAllAttriDecay() / 100))
    })
  end
end

function this:refreshSpiritView()
  if self.showType ~= L_Const.propertyPageType.hero and self.showType ~= L_Const.propertyPageType.equipment then
    return
  end
  local heroId = L_HeroStore:getHeroGuid(self.options.heroData)
  local hero = L_HeroStore:getHero(heroId)
  local spiritGuid = L_HeroStore:getHeroSoulEssenceGuid(hero)
  local spirit = C_SoulEssenceMgr:getsoulessenceItem(spiritGuid, false)
  self.bind.soulessenceListAcitive = spirit ~= nil
  if not spirit then
    return
  end
  self:refreshsoulessenceList(spirit)
end

function this:refreshsoulessenceList(spirit)
  local skills = {}
  local spiritId = spirit.soulEssenceId
  local tpl = soulessenceTpl:getTplById(spiritId)
  local reishiSkill = soulessenceTpl:getReishiSkill(tpl)
  table.insert(skills, {
    star = spirit.star,
    skillId = reishiSkill,
    guid = spirit.guid,
    spiritId = spiritId
  })
  self.bind.soulessenceList:clear()
  self.bind.soulessenceList:insert_array(skills)
end

function this:refreshEquipmentView()
  if self.showType ~= L_Const.propertyPageType.hero and self.showType ~= L_Const.propertyPageType.equipment then
    return
  end
  local heroId = L_HeroStore:getHeroGuid(self.options.heroData)
  local hero = L_HeroStore:getHero(heroId)
  local accessories = L_HeroStore:getHeroAccessoryGuidList(hero)
  if self:checkAccessoriesEmpty(accessories) then
    return
  end
  self:refreshAccessoryEffectList(accessories)
end

function this:checkAccessoriesEmpty(accessories)
  for k, v in ipairs(accessories) do
    if not math.isEmpty(v) then
      return false
    end
  end
  return true
end

function this:refreshAccessoryEffectList(accessories)
  local res = self:getSuitEffect(accessories)
  local data = {}
  for _, v in pairs(res) do
    table.insert(data, v)
  end
  table.sort(data, function(a, b)
    return a.suitId < b.suitId
  end)
  self.bind.accessoryEffectListActive = 0 < #data
  if 0 < #data then
    self.bind.accessoryEffectList:clear()
    self.bind.accessoryEffectList:insert_array({
      {suites = data}
    })
  end
end

function this:getSuitEffect(accessories)
  local res = {}
  for _, guid in ipairs(accessories) do
    if not math.isEmpty(guid) then
      local serverData = C_AccessoryMgr:getAccessory(guid)
      local accessoryId = serverData.accessoryId
      local wearHero = serverData.wearHero
      local tpl_accessory = _accessoryTpl:getTplById(accessoryId)
      local suitId = _accessoryTpl:getSetId(tpl_accessory)
      if 0 < suitId and not res[suitId] then
        local suitTxtData = C_AccessoryMgr:getSuitDesc(accessoryId)
        local heroAccessoryGuidList = accessories
        local suitNum = 1
        local tplCur = _accessoryTpl:getTplById(accessoryId)
        local posCur = _accessoryTpl:getType(tplCur)
        local setCur = _accessoryTpl:getSetId(tplCur)
        for _, guidTmp in pairs(heroAccessoryGuidList) do
          if not math.isEmpty(guidTmp) and guidTmp ~= guid and not math.isEmpty(setCur) then
            local serverDataTmp = C_AccessoryMgr:getAccessory(guidTmp)
            local tplTmp = _accessoryTpl:getTplById(serverDataTmp.accessoryId)
            local posTmp = _accessoryTpl:getType(tplTmp)
            local setTmp = _accessoryTpl:getSetId(tplTmp)
            if setTmp == setCur then
              if self.options.isPreview and posCur ~= posTmp then
                suitNum = suitNum + 1
              elseif not self.options.isPreview and serverDataTmp.wearHero == wearHero then
                suitNum = suitNum + 1
              end
            end
          end
        end
        for i, v in pairs(suitTxtData.suit) do
          if suitNum >= v.index then
            suitTxtData.suit[i].active = true
          end
        end
        local tpl_set = _accessorySetTpl:getTplById(_accessoryTpl:getSetId(tplCur))
        local suitSkillList = _accessorySetTpl:getSkill(tpl_set)
        local maxSuitNum = suitSkillList[#suitSkillList][1]
        local txt_suitName = string.format("%s(%s/%s)", suitTxtData.name, suitNum, maxSuitNum)
        for i, v in pairs(suitTxtData.suit) do
          if v.active then
            if not res[suitId] then
              res[suitId] = {
                suitId = suitId,
                des = {},
                suitName = txt_suitName
              }
            end
            table.insert(res[suitId].des, v.desc)
          end
        end
      end
    end
  end
  return res
end

function this:refreshAccessorySpecialityList(accessories)
  local res = {}
  for _, guid in ipairs(accessories) do
    if not math.isEmpty(guid) then
      local serverData = C_AccessoryMgr:getAccessory(guid)
      local att = C_AccessoryMgr:getPackAtt(serverData)
      for _, subAtt in pairs(att.subAtt) do
        if subAtt.isSkill and not subAtt.bLock then
          res[subAtt.skillId] = subAtt
        end
      end
    end
  end
  local skillAtt = {}
  for _, v in pairs(res) do
    table.insert(skillAtt, v)
  end
  table.sort(skillAtt, function(a, b)
    return a.skillId < b.skillId
  end)
  for i, skills in ipairs(skillAtt) do
    skills.isShowBg = i % 2 == 0
  end
  self.bind.accessorySpecialityListActive = 0 < #skillAtt
  if 0 < #skillAtt then
    self.bind.accessorySpecialityList:clear()
    self.bind.accessorySpecialityList:insert_array({
      {skills = skillAtt}
    })
  end
end

return this
