local this = class("moduleRankUpPet", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()

function this.bind()
  return {
    rankUpNodeActive = true,
    maxRankNodeActive = false,
    maxDotLineActive = false,
    splitDotLineActive = true,
    lockTipsActive = false,
    upgradeBtnActive = true,
    tipsActive = true,
    petPropertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    costList = L_Const.ModuleInfo.CellIconBag,
    lockText = "",
    currentStageText = "",
    nextStageText = "",
    maxStageText = "",
    costTitle = "",
    tipText = "",
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
    }
  }
end

function this.methods()
  return {
    onClick_upgradeBtn = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PetEvolutionEntrance))
        return
      end
      if self.lackUpCondition then
        L_PetManager:petHintInfo(3)
        return
      end
      if self.isRankUpRequesting then
        return
      end
      local data = {
        u64 = self.petGuid
      }
      local pet = L_PetStore:getPetItem(self.petGuid)
      local oldSkillInfo = L_PetStore:getPetSkills(pet, false, false, true)
      local oldPetData = table.clone(pet)
      L_PetStore:setIsPlayingTimeLine(true)
      self.isRankUpRequesting = true
      L_PetStore:req_changeRankUpPet(data, function(rspData, errorCode)
        self.isRankUpRequesting = false
        if not L_UI:checkPageShown("pagePet") then
          return
        end
        if errorCode == L_Const.errorCode.ErrCodeSucc then
          if self.parent then
            self.parent:playEvolutionTimeline(self.petGuid, oldPetData, oldSkillInfo)
          end
          self:show()
        end
      end)
    end
  }
end

function this:show()
  local tpl_uiTopBar = uiTopBarTpl:getTplByPageName("pagePet")
  local resource = uiTopBarTpl:getResourceBar(tpl_uiTopBar, 2)
  local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
  C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
  self.bind.costTitle = L_WordsTpl:getValue("ui_pet_rank_cost")
  self.bind.tipText = L_WordsTpl:getValue("ui_pet_rank_tips")
  local selectGuid = L_PetStore:getCurSelectPetId()
  if selectGuid ~= 0 then
    self.petGuid = selectGuid
  end
  if self.petGuid == nil or self.petGuid == 0 then
    return
  end
  local pet = L_PetStore:getPetItem(L_PetStore:getCurSelectPetId())
  local tpl = petTpl:getTplById(pet.id)
  if table.isEmpty(tpl) then
    if pet.id then
      errorf("petInfo表找不到id ： " .. pet.id, 2)
    else
      errorf("宠物guid " .. self.petGuid .. " 没找到对应pet id", 2)
    end
    return
  end
  L_ReddotManager:registerReddot(self.bindComponents.rankUpReddot, string.format(L_ReddotManager.DotDef.PetRankUp, self.petGuid))
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(pet.id)
  local nextStageId = rankData.nextPetId
  self.isMaxStage = math.isEmpty(nextStageId)
  self:initPetPropertyList()
  self.bind.rankUpNodeActive = not self.isMaxStage
  self.bind.maxRankNodeActive = self.isMaxStage
  self.bind.splitDotLineActive = not self.isMaxStage
  self.bind.upgradeBtnActive = not self.isMaxStage
  self.bind.lockTipsActive = self.isMaxStage
  self.bind.tipsActive = not self.isMaxStage
  self.isLackLevel = pet.lv < rankData.levelNeed
  if self.isMaxStage then
    self.bind.maxPixelIcon = petTpl:getPetPixelIcon(tpl, pet:isSpecialPet())
    self.modules.modulePetFlashEftMax:setModulePetHasFlashEft(pet:hasFlashGene())
    self.bind.maxStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(tpl))
    self.bind.costList:clear()
    self.bind.lockText = L_WordsTpl:getValue("ui_pet_rank_limit_tips")
  else
    local nextTpl = petTpl:getTplById(nextStageId)
    self.bind.currentPixelIcon = petTpl:getPetPixelIcon(tpl, pet:isSpecialPet())
    self.modules.modulePetFlashEftCur:setModulePetHasFlashEft(pet:hasFlashGene())
    self.bind.nextPixelIcon = petTpl:getPetPixelIcon(nextTpl, pet:isSpecialPet())
    self.bind.currentStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(tpl))
    self.bind.nextStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(nextTpl))
    self:initCostList()
    self.bind.lockTipsActive = self.isLackLevel
    self.bind.upgradeBtnActive = not self.isLackLevel
    self.bind.lockText = L_WordsTpl:getValue("ui_pet_rank_lack_condition")
    if self.isLackLevel then
      self.bind.lockText = L_WordsTpl:getTplById("notice_pet_lackLevel", {
        [0] = rankData.levelNeed
      })
    end
  end
end

function this:initCostList()
  self.bind.costList:clear()
  local pet = L_PetStore:getPetItem(L_PetStore:getCurSelectPetId())
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(pet.id)
  local item = rankData.rankBreakthroughItem
  local data = {}
  self.lackUpCondition = false
  for i = 1, #item do
    local itemInfo = item[i]
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
      local num = ""
      local requireItem = L_ItemManager:parseItem(itemType, itemId)
      if requireItem.num > 99999 then
        requireItem.num = 99999
      end
      local hasNum = L_ItemTplManager:getItemNum(itemType, itemId)
      if itemCount > hasNum then
        num = L_GameUtil.fillColor(hasNum, L_Const.colorHtml.red001)
        self.lackUpCondition = true
      else
        num = tostring(hasNum)
      end
      table.insert(data, {
        itemNumTxt = num .. "/" .. tostring(itemCount),
        itemType = itemType,
        itemId = itemId
      })
    end
  end
  self.bind.costList:insert_array(data)
end

function this:initPetPropertyList()
  local pet = L_PetStore:getPetItem(L_PetStore:getCurSelectPetId())
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(pet.id)
  local property, currentProperty
  local nextStageId = rankData.nextPetId
  if math.isEmpty(nextStageId) then
    currentProperty = L_PetStore:getPetOriginalProperty(pet)
  else
    local level = pet.lv
    if pet.lv < rankData.levelNeed then
      level = rankData.levelNeed
    end
    currentProperty = L_PetStore:getPetOriginalProperty(pet, level)
    property = L_PetStore:getPetOriginalProperty(pet, level, nextStageId)
  end
  local comprehensionGroup = currentProperty.comprehensionRank
  local comprehension = {}
  for i = 1, #comprehensionGroup do
    local ablityTpl = petLearningAblityTpl:getTplById(comprehensionGroup[i].id)
    local score = petLearningAblityTpl:getScore(ablityTpl)
    comprehension[comprehensionGroup[i].enumId] = score
  end
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  self.bind.petPropertyList:clear()
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for i, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local id = 0
    for n, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        id = k.rankId
        break
      end
    end
    local value = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(currentProperty, enumId))
    local addValueText = value
    local showAddBg = not math.isEmpty(nextStageId)
    if showAddBg then
      addValueText = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(property, enumId))
    end
    table.insert(propertyData, {
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      value = value,
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = id,
      controlValueColor = true,
      showAddBg = showAddBg,
      addValueText = addValueText
    })
  end
  self.bind.petPropertyList:insert_array(propertyData)
  local petGradeTpl = L_GameTpl:getPetGradeTpl()
  if currentProperty then
    local gradeTpl = petGradeTpl:getTplById(currentProperty.gradeRank)
    if math.isEmpty(nextStageId) then
      self.bind.maxGradeBase = petGradeTpl:getPetPixelBase(gradeTpl)
    else
      self.bind.currentGradeBase = petGradeTpl:getPetPixelBase(gradeTpl)
    end
  end
end

return this
