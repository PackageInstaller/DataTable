local this = class("moduleBattlePetCatchBonusTip", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
local _skillLevelPetDnaTpl = L_GameTpl:getSkillLevelTpl()
local _skillPetDnaTpl = L_GameTpl:getSkillTpl()
local _petDnaTpl = L_GameTpl:getDnaTpl()
local petDnaIcon = {
  [1] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz04.png",
  [2] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz04.png",
  [3] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz03.png",
  [4] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz02.png",
  [5] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz01.png",
  [6] = "UI/Atlas/PetScan/tex_starlink_lens_bg_yz06.png"
}
local petDnaGradeIcon = {
  [1] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg6.png",
  [2] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg6.png",
  [3] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg5.png",
  [4] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg4.png",
  [5] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg3.png",
  [6] = "UI/Atlas/PetScan/tex_pet_bg_ratingbg2.png"
}

function this.bind()
  return {
    active_tip = false,
    active_catch_rate_title = true,
    active_catch_rate_info = false,
    module_rate_title = {
      moduleName = "pages/pet/new/moduleBattlePetCatchRateTitle"
    },
    module_petBox_rating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    },
    txt_base_catch_rate = "",
    txt_card = "",
    txt_name = "",
    txt_level = "",
    list_catch_rate_info = {
      moduleName = "pages/pet/new/cellBattlePetCatchRate"
    },
    list_petCatchBonueIcon = {
      moduleName = "pages/battle/cellPetCatchBonueIcon"
    },
    active_catch_line1 = true,
    active_catch_line_bg1 = true,
    active_catch_TitleA = false,
    active_catch_InfoA = false,
    active_btn_Info = false,
    active_prompt = false,
    txt_prompt_level = ""
  }
end

function this.methods()
  return {
    onClick_btn = function(self)
      self:emit("onClick")
    end
  }
end

function this:setPetData(data, isDetails)
  self.petInfo = data
  self.isDetails = isDetails
end

function this:onGetCatchInfo()
  self.catchPetInfo = {
    grade = 5666,
    petLenId = 1800003,
    geneSize = 3,
    geneInfos = {
      {geneLv = 2, geneId = 531010},
      {geneLv = 2, geneId = 531023},
      {geneLv = 4, geneId = 531050}
    }
  }
end

function this:onMonsterHistoryCatchInfoUpdate()
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  self.catchPetInfo = C_PetStore:GetTargetMonsterEntityHistoryCatchPetInfo(self.monsterEntity.data.UUID)
  if self.catchPetInfo == nil then
    return
  end
  local scanLevel = L_PetManager:getScanLevelById(self.catchPetInfo.petLenId)
  self:playScanAnim()
  self.bind.active_catch_TitleA = scanLevel >= L_Const.ScanLevel.FIRST_LEVEL_SCAN
  self.bind.active_catch_InfoA = scanLevel >= L_Const.ScanLevel.SECOND_LEVEL_SCAN
  if self.catchPetInfo.rank ~= 0 then
    self.modules.module_petBox_rating:setLockGrade(self.catchPetInfo.rank)
  end
  if self.catchPetInfo.petLenId ~= 0 then
    self.modules.module_petBox_rating:setScanLevel(self.catchPetInfo.petLenId)
  end
  local tab = {}
  if scanLevel == L_Const.ScanLevel.SECOND_LEVEL_SCAN then
    for i = 1, self.catchPetInfo.geneSize do
      table.insert(tab, {rank = 0})
    end
    self.bind.list_petCatchBonueIcon:clear()
    self.bind.list_petCatchBonueIcon:insert_array(tab)
  elseif scanLevel == L_Const.ScanLevel.THIRDLY_LEVEL_SCAN then
    for i = 0, self.catchPetInfo.geneSize - 1 do
      local id = self.catchPetInfo.geneInfos[i].geneId
      local rarity = _petDnaTpl:getRarity(_petDnaTpl:getTplById(id))
      table.insert(tab, {rank = rarity})
    end
    self.bind.list_petCatchBonueIcon:clear()
    self.bind.list_petCatchBonueIcon:insert_array(tab)
  end
end

function this:onMonsterHistoryCatchInfoUpdateDetail()
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  self.catchPetInfo = C_PetStore:GetTargetMonsterEntityHistoryCatchPetInfo(self.monsterEntity.data.UUID)
  if self.catchPetInfo == nil then
    return
  end
  local scanLevel = L_PetManager:getScanLevelById(self.catchPetInfo.petLenId)
  self.bind.active_catch_TitleA = scanLevel >= L_Const.ScanLevel.FIRST_LEVEL_SCAN
  self.bind.active_catch_InfoA = scanLevel >= L_Const.ScanLevel.THIRDLY_LEVEL_SCAN
  if self.catchPetInfo.rank ~= 0 then
    self.modules.module_petBox_rating:setLockGrade(self.catchPetInfo.rank)
  end
  if self.catchPetInfo.petLenId ~= 0 then
    self.modules.module_petBox_rating:setScanLevel(self.catchPetInfo.petLenId)
  end
  local tab = {}
  if scanLevel == L_Const.ScanLevel.SECOND_LEVEL_SCAN then
  elseif scanLevel == L_Const.ScanLevel.THIRDLY_LEVEL_SCAN then
    for i = 0, self.catchPetInfo.geneSize - 1 do
      local geneId = self.catchPetInfo.geneInfos[i].geneId
      local tpl = _skillLevelPetDnaTpl:getTplByIdAndLevel(geneId, 1)
      local skillTpl = _skillPetDnaTpl:getTplById(geneId)
      local rarity = _petDnaTpl:getRarity(_petDnaTpl:getTplById(geneId))
      table.insert(tab, {
        geneId = geneId,
        skillName = _skillPetDnaTpl:getName(skillTpl),
        rarity = rarity,
        describe = _skillLevelPetDnaTpl:getSkillDetailDescribe(tpl)
      })
    end
    self.bind.list_petTipsGene:clear()
    self.bind.list_petTipsGene:insert_array(tab)
  end
end

function this:open()
  self:initIndexParams()
  self.monsterEntity = nil
  self.bind.active_btn_Info = L_DeviceTpl:getIsPc()
  self.index = 0
  self.bind.active_tip = false
  self.bind.txt_card = L_WordsTpl:getValue("ui_starlink_catch_basic_factor")
  self.grade = nil
  self.geneData = nil
end

function this:initIndexParams()
  if self.indexEnum == nil then
    self.indexEnum = {
      finalValue = 0,
      baseShowValue = 1,
      hp = 2,
      graph = 3,
      food = 4,
      nestCoop = 5,
      Link = 6,
      guarantee = 7
    }
  end
end

function this:show()
  if not table.isEmpty(self.petInfo) then
    self:setSelectMonster()
  end
end

function this:hide()
  self.bind.active_tip = false
end

local function hasTwoDecimalPlaces(value)
  local EPSILON = 1.0E-9
  local roundedToTwo = math.floor(value * 100 + 0.5) / 100
  local roundedToOne = math.floor(value * 10 + 0.5) / 10
  return EPSILON < math.abs(roundedToTwo - roundedToOne)
end

function this:FixSingleValue(value)
  if math.abs(value) >= 1 then
    value = math.floor(value * 10) / 10
  else
    value = math.floor(value * 100) / 100
  end
  return value
end

function this:FixCatchRateShowList(list)
  local resultList = {}
  local finalValue = list:GetFloat(0)
  local totalValue = 0
  if 1 <= finalValue then
    totalValue = math.floor(finalValue * 10 + 0.5) / 10
  else
    totalValue = math.floor(finalValue * 100 + 0.5) / 100
  end
  local baseValue = self:FixSingleValue(list:GetFloat(1))
  local hp = self:FixSingleValue(list:GetFloat(2))
  local graph = self:FixSingleValue(list:GetFloat(3))
  local food = self:FixSingleValue(list:GetFloat(4))
  local nestCoop = self:FixSingleValue(list:GetFloat(5))
  local link = self:FixSingleValue(list:GetFloat(6))
  local guarantee = self:FixSingleValue(list:GetFloat(7))
  local offsetValue = totalValue - baseValue - hp - link - graph - food - guarantee - nestCoop
  baseValue = baseValue + offsetValue
  if math.abs(baseValue) < 1.0E-7 then
    baseValue = 0
  end
  table.insert(resultList, totalValue)
  table.insert(resultList, baseValue)
  table.insert(resultList, hp)
  table.insert(resultList, graph)
  table.insert(resultList, food)
  table.insert(resultList, nestCoop)
  table.insert(resultList, link)
  table.insert(resultList, guarantee)
  return resultList
end

function this:setSelectMonster()
  if table.isEmpty(self.petInfo) then
    return
  end
  self.index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if self.index < 0 then
    return
  end
  self.monsterEntity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[self.index]
  if not self.monsterEntity.entity:CanBeChosen() then
    self:hide()
    return
  end
  local foodBuffValue = 0
  local itemId = L_GameConstTpl:getData("STAR_LINK_UI_QUICK_USE_MEAL_LUCKY", L_Const.GameTplType.int)
  local elementId = _foodTpl:getBuffElementId(itemId)
  local entityData = (C_EntityManager.ControllingEntity or {}).data
  if entityData ~= nil then
    local element = entityData.elementProperty:GetExistElement(elementId)
    if element ~= nil then
      foodBuffValue = L_GameConstTpl:getData("FOOD_FORTUNE_VALUE", L_Const.GameTplType.int)
    end
  end
  local partCatchRateList = self.monsterEntity.entity.data.catchProperty:GetCatchRateInfos(self.monsterEntity.entity.data, foodBuffValue)
  local count = partCatchRateList.count or 0
  if count <= 0 then
    return
  end
  local fixedRateList = self:FixCatchRateShowList(partCatchRateList)
  local finalCatchRate = fixedRateList[1]
  self.modules.module_rate_title:setData(finalCatchRate)
  self.bind.txt_name = self.monsterEntity.entity.data.configName
  local petLevel = 0
  if self.monsterEntity.entity.data.BelongUnit then
    local lv = AzurWorld.ScanMgr:OnGetScanPetLevel(self.monsterEntity.entity.data.BelongUnit)
    petLevel = lv
    self.bind.txt_level = "lv." .. tostring(lv)
  else
    petLevel = self.monsterEntity.entity.data.level
    self.bind.txt_level = "lv." .. tostring(petLevel)
  end
  local catchCurrencyNum = L_PlayerStore:getCurrencyNum(L_Const.currencyType.catchForce)
  if petLevel <= catchCurrencyNum then
    self.bind.active_prompt = false
  else
    self.bind.active_prompt = true
    self.bind.txt_prompt_level = L_WordsTpl:getValue("ui_starlink_board_kibo_level", {
      [0] = catchCurrencyNum
    })
  end
  self:onMonsterHistoryCatchInfoUpdate()
  self:initIndexParams()
  local infos = {}
  for index = 2, count - 1 do
    local rateValue = fixedRateList[index + 1]
    local insert = true
    if rateValue == 0 then
      if index == self.indexEnum.food or index == self.indexEnum.guarantee or index == self.indexEnum.graph then
        insert = false
      end
      if index == self.indexEnum.nestCoop then
        local curModule = L_WorldManager:getCurModule()
        if curModule ~= L_Const.worldModule.nestCoop then
          insert = false
        end
      end
    end
    if insert then
      local info = {
        petCatchRateIndex = index,
        isDetails = self.isDetails,
        petCatchRateValue = rateValue
      }
      infos[#infos + 1] = info
    end
  end
  local baseShowValue = fixedRateList[2]
  self:updateInfos(baseShowValue, infos)
  self:showTip()
  return finalCatchRate
end

function this:setModuleRateTitle(rate)
  self.modules.module_rate_title:setTxtRate(rate)
end

function this:updateInfos(baseShowValue, infos)
  self:showBaseValue(baseShowValue)
  self:showInfoList(infos)
end

function this:showBaseValue(baseShowValue)
  local hasTwoDecimals = hasTwoDecimalPlaces(baseShowValue)
  if math.abs(baseShowValue) >= 1 and not hasTwoDecimals then
    self.bind.txt_base_catch_rate = ("%.1f%%"):format(baseShowValue)
  else
    self.bind.txt_base_catch_rate = ("%.2f%%"):format(baseShowValue)
  end
end

function this:showInfoList(infos)
  self.bind.active_catch_line1 = 4 < #infos
  self.bind.active_catch_line_bg1 = 4 < #infos
  self.bind.list_catch_rate_info:clear()
  self.bind.list_catch_rate_info:insert_array(infos)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.lineBgGroup1)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.catchRateInfo)
end

function this:showTip()
  self.bind.active_tip = true
end

function this:playScanAnim()
  if self.bind.active_tip and self.parent.isCatchEvent then
    self.bindComponents.anim_Board:Play("anim_scan_tips_small_fresh")
    self.parent:SetCatchEventState(false)
  end
end

return this
