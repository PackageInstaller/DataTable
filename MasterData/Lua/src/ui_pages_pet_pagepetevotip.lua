local this = class("pagePetEvoTip", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    go_newFeatureUnlock = false,
    rankUpNodeActive = true,
    maxRankNodeActive = false,
    maxDotLineActive = false,
    petPropertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    go_cost = false,
    costList = L_Const.ModuleInfo.CellIconBag,
    currentStageText = "",
    nextStageText = "",
    maxStageText = "",
    costTitle = "",
    currentPixelIcon = "",
    nextPixelIcon = "",
    maxPixelIcon = "",
    currentGradeBase = "",
    maxGradeBase = "",
    modulePetFlashEftCur = {
      moduleName = "pages/pet/modulePetFlashEft"
    },
    modulePetFlashEftMax = {
      moduleName = "pages/pet/modulePetFlashEft"
    },
    go_canEvo = false,
    go_cantEvo = false,
    go_lock = false,
    txt_cantEvoLevelTip = ""
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClick_confirm()
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self.reqData = options.reqData
  self.petGuid = options.petGuid
  self.petItem = options.petItem or self.petGuid and L_PetStore:getPetItem(self.petGuid) or nil
  self.rankData = options.rankData or self.petItem and petRankTpl:getchildren(self.petItem.id) or {}
  self.nextPetId = not options.nextPetId and self.rankData and self.rankData.nextPetId
  self.levelNeed = not options.levelNeed and self.rankData and self.rankData.levelNeed
  self.levelNotMatch = options.levelNotMatch and true or false
  self.hasEvoItemConfig = options.hasEvoItemConfig and true or false
  self.evoItemList = options.evoItemList or {}
  self:refreshContent()
end

function this:close()
  this.super.close(self)
end

function this:refreshContent()
  local pet = self.petItem
  local rankData = self.rankData
  if pet == nil or table.isEmpty(rankData) then
    return
  end
  local tpl = petTpl:getTplById(pet.id)
  local nextTpl = petTpl:getTplById(self.nextPetId)
  if table.isEmpty(tpl) or table.isEmpty(nextTpl) then
    return
  end
  self.bind.rankUpNodeActive = true
  self.bind.maxRankNodeActive = false
  self.bind.maxDotLineActive = false
  local isSpecial = pet.isSpecialPet and pet:isSpecialPet() or false
  self.bind.currentPixelIcon = petTpl:getPetPixelIcon(tpl, isSpecial)
  self.bind.nextPixelIcon = petTpl:getPetPixelIcon(nextTpl, isSpecial)
  self.bind.currentStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(tpl))
  self.bind.nextStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(nextTpl))
  local modulePetFlashEftCur = self.modules and self.modules.modulePetFlashEftCur
  if modulePetFlashEftCur and modulePetFlashEftCur.setModulePetHasFlashEft then
    local hasFlashGene = pet.hasFlashGene and pet:hasFlashGene() or false
    modulePetFlashEftCur:setModulePetHasFlashEft(hasFlashGene)
  end
  self:initPetPropertyList(pet, rankData)
  self:initCostList(rankData)
  self:refreshNewFeatureUnlock(tpl, nextTpl)
  self:initCommonTip()
  self:refreshEvoState()
end

function this:refreshEvoState()
  if self.levelNotMatch then
    self.bind.go_canEvo = false
    self.bind.go_lock = true
    self.bind.go_cantEvo = false
  elseif self.lackUpCondition then
    self.bind.go_canEvo = false
    self.bind.go_lock = false
    self.bind.go_cantEvo = true
  else
    self.bind.go_canEvo = true
    self.bind.go_lock = false
    self.bind.go_cantEvo = false
  end
end

function this:refreshNewFeatureUnlock(currentTpl, nextTpl)
  local currentSkills = petTpl:getFeatureSkillList(currentTpl) or {}
  local nextSkills = petTpl:getFeatureSkillList(nextTpl) or {}
  self.bind.go_newFeatureUnlock = not this._isFeatureDictEqual(currentSkills, nextSkills)
end

function this._isFeatureDictEqual(a, b)
  for k, v in pairs(a) do
    if b[k] ~= v then
      return false
    end
  end
  for k, v in pairs(b) do
    if a[k] ~= v then
      return false
    end
  end
  return true
end

function this:initCostList(rankData)
  self.bind.costList:clear()
  self.lackUpCondition = false
  if not self.hasEvoItemConfig then
    self.bind.costTitle = ""
    self.bind.go_cost = false
    return
  end
  self.bind.costTitle = L_WordsTpl:getValue("ui_pet_rank_cost")
  local items = rankData.rankBreakthroughItem or {}
  local data = {}
  for i = 1, #items do
    local itemInfo = items[i]
    local itemType, itemId, itemCount
    if #itemInfo == 2 then
      itemType = L_Const.resType.commonItem
      itemId = itemInfo[1]
      itemCount = itemInfo[2]
    elseif #itemInfo == 3 then
      itemType = itemInfo[1]
      itemId = itemInfo[2]
      itemCount = itemInfo[3]
    end
    if not math.isEmpty(itemId) then
      local hasNum = L_ItemTplManager:getItemNum(itemType, itemId)
      local numTxt
      if itemCount > hasNum then
        numTxt = L_GameUtil.fillColor(hasNum, L_Const.colorHtml.red001)
        self.lackUpCondition = true
      else
        numTxt = tostring(hasNum)
      end
      table.insert(data, {
        itemNumTxt = numTxt .. "/" .. tostring(itemCount),
        itemType = itemType,
        itemId = itemId
      })
    end
  end
  self.bind.costList:insert_array(data)
  self.bind.go_cost = 0 < #data
end

function this:initPetPropertyList(pet, rankData)
  local currentLevel = pet.lv
  local nextLevel = pet.lv
  if rankData.levelNeed ~= nil and pet.lv <= rankData.levelNeed then
    nextLevel = rankData.levelNeed
  end
  local currentProperty = L_PetStore:getPetOriginalProperty(pet, currentLevel)
  local nextProperty = L_PetStore:getPetOriginalProperty(pet, nextLevel, self.nextPetId)
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  self.bind.petPropertyList:clear()
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for _, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local attrId = 0
    for _, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        attrId = k.rankId
        break
      end
    end
    local value = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(currentProperty, enumId))
    local addValueText = value
    if nextProperty then
      addValueText = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(nextProperty, enumId))
    end
    table.insert(propertyData, {
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      value = value,
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = attrId,
      controlValueColor = true,
      showAddBg = true,
      addValueText = addValueText
    })
  end
  self.bind.petPropertyList:insert_array(propertyData)
  local petGradeTpl = L_GameTpl:getPetGradeTpl()
  if currentProperty then
    local gradeTpl = petGradeTpl:getTplById(currentProperty.gradeRank)
    self.bind.currentGradeBase = petGradeTpl:getPetPixelBase(gradeTpl)
  end
end

function this:initCommonTip()
  local moduleTip = self.modules and self.modules.moduleCommonTipMedium
  if moduleTip == nil then
    return
  end
  local param = {}
  param.txtTitle = L_WordsTpl:getValue("ui_kibo_evolution_title")
  if self.levelNotMatch and self.levelNeed ~= nil then
    self.bind.txt_cantEvoLevelTip = L_WordsTpl:getTplById("notice_pet_lackLevel", {
      [0] = self.levelNeed
    })
  end
  param.txtConfirm = L_WordsTpl:getValue("common_window_1")
  moduleTip:initModule(param)
end

function this:onClick_confirm()
  if self.levelNotMatch then
    return
  end
  if self.lackUpCondition then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_evolution_need_item"))
    return
  end
  self:startPetEvolution()
end

function this:startPetEvolution()
  if self.isRankUpRequesting then
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PetEvolutionEntrance), 0)
    return
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem == nil then
    return
  end
  local oldSkillInfo = L_PetStore:getPetSkills(petItem, false, false, true)
  local oldPetData = table.clone(petItem)
  local data = self.reqData or {
    u64 = self.petGuid
  }
  self.isRankUpRequesting = true
  L_PetStore:setIsPlayingTimeLine(true)
  L_PetStore:req_changeRankUpPet(data, function(_, errorCode)
    self.isRankUpRequesting = false
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      L_PetStore:setIsPlayingTimeLine(false)
      return
    end
    local pet = L_PetStore:getPetItem(self.petGuid)
    local triggerCommonGetPet = L_CatalogStore and L_CatalogStore._triggerCommonGetPet
    if pet ~= nil and triggerCommonGetPet ~= nil then
      triggerCommonGetPet(L_CatalogStore, pet)
    end
    L_UI:close(self.pageName)
    L_UI:open("pagePetEvo", {
      guid = self.petGuid,
      prePetData = oldPetData,
      oldSkillInfo = oldSkillInfo
    })
  end)
end

return this
