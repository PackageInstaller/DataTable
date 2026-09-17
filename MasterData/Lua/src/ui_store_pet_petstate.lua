local this = {}
local eggTpl = L_GameTpl:getPetEggTpl()
local petDna = L_GameTpl:getDnaTpl()
local petDnaType = L_GameTpl:getPetDnaTypeTpl()
local petHobbyTpl = L_GameTpl:getPetHobbyTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petTalentTpl = L_GameTpl:getPetTalentTpl()
local petInheritanceTpl = L_GameTpl:getPetAttributeinheritanceTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local gameConstTpl = L_GameTpl:getGameConstTpl()
local petVoiceWordsSystemTpl = L_GameTpl:getPetVoiceWordsSystemTpl()
local templateValueTpl = L_GameTpl:getTemplateValueTpl()
local _petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillsubAttrupTpl = L_GameTpl:getSkillsubAttrupTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _petStarSoulTpl = L_GameTpl:getPetStarSoulTpl()
local _iconographyTaskTpl = L_GameTpl:getIconographyTaskTpl()
local csHomeManager, csPetStore

local function comprehensionToTable(comprehension)
  if not comprehension then
    return {}
  end
  local result = {}
  if type(comprehension) == "userdata" and comprehension.Count ~= nil then
    for i = 0, comprehension.Count - 1 do
      table.insert(result, comprehension[i])
    end
  else
    for _, v in pairs(comprehension) do
      table.insert(result, v)
    end
  end
  return result
end

local function geneInfosToTable(geneInfos)
  if not geneInfos then
    return {}
  end
  local result = {}
  if type(geneInfos) == "userdata" and geneInfos.Count ~= nil then
    for i = 0, geneInfos.Count - 1 do
      table.insert(result, geneInfos[i])
    end
  else
    for _, v in pairs(geneInfos) do
      table.insert(result, v)
    end
  end
  return result
end

function this:init()
  this.super.init(self)
  self.emptyTbl = {}
  self.data = {
    selectGuids = {},
    curSelectedEggGuid = 0,
    curSelectedPetGuid = 0,
    petEggList = {},
    petList = {},
    tmpPetList = {},
    petBoxList = {},
    petBoxNameList = {},
    petBoxCustomNameList = {},
    petBoxIndex = {},
    friendPetList = {},
    petEntityGuidToEntityId = {},
    beta_bgIcon = {
      [1] = "Pet/tex_pet_frame_redonebg",
      [2] = "Pet/tex_pet_frame_greenonebg",
      [3] = "Pet/tex_pet_frame_yellowonebg",
      [4] = "Pet/tex_pet_frame_blueonebg",
      [5] = "Pet/tex_pet_frame_coloronebg"
    },
    alpha_bgIcon = {
      [1] = "Page/Pet/tex_pet_frame_redtwobg",
      [2] = "Page/Pet/tex_pet_frame_greentwobg",
      [3] = "Page/Pet/tex_pet_frame_yellowtwobg",
      [4] = "Page/Pet/tex_pet_frame_bluetwobg",
      [5] = "Page/Pet/tex_pet_frame_colortwobg"
    },
    link_bgIcon = {
      [1] = "Page/Pet/tex_pet_dec_redline",
      [2] = "Page/Pet/tex_pet_dec_greenline",
      [3] = "Page/Pet/tex_pet_dec_yellowline",
      [4] = "Page/Pet/tex_pet_dec_blueline",
      [5] = "Page/Pet/tex_pet_dec_colorline"
    },
    setHasInitSync = false,
    petMaxLevel = tonumber(petLevelTpl:getMaxLevel()),
    freeRewardNum = 0,
    lastFreeTime = 0,
    petSkillSlotList = gameConstTpl:getData("PET_SKILLDISPLAY", L_Const.GameTplType.list_int),
    petSpecialSkill = gameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int),
    petNormalSkill = gameConstTpl:getData("PET_SKILLLIST", L_Const.GameTplType.list_int),
    petRandomSkillRange = gameConstTpl:getData("PET_RPROPERTYSKILLLIST", L_Const.GameTplType.list_int),
    petFixedSkillRange = gameConstTpl:getData("PET_FPROPERTYSKILLLIST", L_Const.GameTplType.list_int),
    petBreakSkill = gameConstTpl:getData("PET_BREAKSKILLLIST", L_Const.GameTplType.int),
    petBoxLimit = gameConstTpl:getData("PET_BOX_LIMIT", L_Const.GameTplType.int),
    petBoxNum = gameConstTpl:getData("PET_BOX_NUM", L_Const.GameTplType.int),
    petSkillInfoQueue = L_Struct.getQueue(),
    isPlayingEvoTimeLine = false,
    free_egg_reward_num = 0,
    lockBoxIds = {}
  }
  self:getInitPetBox()
  self:initCachedData()
end

function this:initCachedData()
  self.cachedEggIncubationTime = {}
  self.cachedPetSixDimEnumOrder = {}
  local allEnum = _petLearingEnumTpl:getAllEnum(true)
  for _, enumTpl in ipairs(allEnum) do
    table.insert(self.cachedPetSixDimEnumOrder, _petLearingEnumTpl:getEnumNum(enumTpl))
  end
end

function this:resetCachedData()
  table.clear(self.cachedEggIncubationTime)
  table.clear(self.cachedPetSixDimEnumOrder)
end

function this:getCurSelectedEggGuid()
  return self.data.curSelectedEggGuid
end

function this:getPetEggCount()
  return table.count(self.data.petEggList)
end

function this:getPetEggList()
  return self.data.petEggList
end

function this:csGetPetEggList()
  local newPetEggList = {}
  for _, v in pairs(self.data.petEggList) do
    newPetEggList[#newPetEggList + 1] = v
  end
  table.sort(newPetEggList, function(a, b)
    if a ~= nil and b ~= nil and a.guid ~= nil and b.guid ~= nil then
      return a.guid < b.guid
    end
  end)
  return newPetEggList
end

function this:getUnhatchEggNum()
  local num = 0
  for _, v in pairs(self.data.petEggList) do
    if not L_PetStore:checkIsEggHatch(v.guid) then
      num = num + 1
    end
  end
  return num
end

function this:getPetBoxList(index)
  if index == nil then
    return self.data.petBoxList
  end
  if self.data.petBoxList[index] == nil then
    return nil
  end
  return self.data.petBoxList[index]
end

function this:getPetBoxIsFull(index)
  index = index >= self.data.petBoxNum and self.data.petBoxNum or index
  index = index <= 1 and 1 or index
  local count = 0
  for i, v in ipairs(self.data.petBoxList[index]) do
    if math.isEmpty(v) then
      return false, i
    end
    count = count + 1
  end
  return true
end

function this:getPetBoxIsEmpty(index)
  local count = 0
  for i, v in ipairs(self.data.petBoxList[index]) do
    if not math.isEmpty(v) then
      count = count + 1
    end
  end
  if count < 1 then
    return true
  else
    return false
  end
end

function this:getFirstOrderPet()
  for i = 1, 10 do
    if not self:getPetBoxIsEmpty(i) then
      return self:getPetBoxFirstPet(i)
    end
  end
  return nil
end

function this:getPetBoxFirstPet(index)
  for i, v in ipairs(self.data.petBoxList[index]) do
    if not math.isEmpty(v) then
      return v
    end
  end
  return 0
end

function this:getAllPetBoxIsFull()
  for i = 1, self.data.petBoxNum do
    local isFull, emptySlot = self:getPetBoxIsFull(i)
    if not isFull then
      return false, {index = i, slot = emptySlot}
    end
  end
  return true, nil
end

function this:getPetBoxName(index)
  local nameList = self:getPetBoxNameList()
  if not nameList then
    return ""
  end
  return nameList[index] or ""
end

function this:getPetBoxNameList()
  return self.data.petBoxNameList
end

function this:getPetBoxCustomName(index)
  local nameList = self.data.petBoxCustomNameList
  if not nameList then
    return ""
  end
  return nameList[index] or ""
end

function this:hasPetBoxCustomName(index)
  return not string.isEmpty(self:getPetBoxCustomName(index))
end

function this:getPetBoxNum()
  return self.data.petBoxNum
end

function this:getPetBoxDefaultName(index)
  return L_WordsTpl:getValue("ui_petState", {
    [0] = index
  })
end

function this:getPetBoxDisplayName(index, boxName)
  if string.isEmpty(boxName) then
    return self:getPetBoxDefaultName(index)
  end
  return boxName
end

function this:getInitPetBox()
  for i = 1, self.data.petBoxNum do
    self.data.petBoxList[i] = {}
    self.data.petBoxNameList[i] = self:getPetBoxDisplayName(i, self.data.petBoxNameList[i])
  end
  for _, v in ipairs(self.data.petBoxList) do
    for i = 1, self.data.petBoxLimit do
      v[i] = 0
    end
  end
end

function this:getPetFreeRewardNum()
  local lastFreeTime = self.data.lastFreeTime
  if lastFreeTime then
    local todayRefreshTime = math.ceil(C_TimeUtility.TimestampOfToday()) + 14400
    if lastFreeTime < todayRefreshTime then
      return 0
    end
  end
  return self.data.freeRewardNum
end

function this:getPetListCount()
  local count = 0
  for i, _ in pairs(self.data.petList) do
    count = count + 1
  end
  return count
end

function this:getPetCountIsOverBox()
  local count = self:getPetListCount()
  return count >= self.data.petBoxLimit * self.data.petBoxNum
end

function this:getIsPetBoxHasValidSlot()
  for index, _ in ipairs(self.data.petBoxList) do
    if not self:getPetBoxIsFull(index) and self:getBoxIsLock(index) == false then
      return true
    end
  end
  return false
end

function this:getPetList()
  local res = {}
  for _, v in pairs(self.data.petList) do
    if not v:getIsTrial() then
      table.insert(res, v)
    end
  end
  return res
end

function this:getPetGuidList()
  local res = {}
  for _, v in pairs(self.data.petList) do
    if not v:getIsTrial() then
      table.insert(res, v.guid)
    end
  end
  return res
end

function this:getFriendPetList()
  return self.data.friendPetList
end

function this:getPetMaxLevel(isLimit)
  if not isLimit then
    return self.data.petMaxLevel
  end
  local maxLv = self.data.petMaxLevel
  local lv = 1
  while maxLv > lv do
    local tpl = petLevelTpl:getTplById(lv + 1)
    if not tpl then
      break
    end
    local condition = petLevelTpl:getCondition(tpl)
    if not (table.isEmpty(condition) or L_ConditionManager:singleIsComplete(condition)) then
      break
    end
    lv = lv + 1
  end
  return lv
end

function this:getPetEggItem(uid, isCreate)
  local petEggList = self:getPetEggList()
  local entity = petEggList[uid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "pet.data.petEggItem").new()
    self.data.petEggList[uid] = entity
    entity.guid = uid
  end
  return entity
end

function this:getPetNum(configId)
  local data = {}
  local petList = self:getPetList()
  for _, v in pairs(petList) do
    if v:petCfgId() == configId then
      table.insert(data, v)
    end
  end
  return #data
end

function this:getPetEggNum(configId)
  local data = {}
  local petEggList = self:getPetEggList()
  for i, v in pairs(petEggList) do
    if v.configId == configId then
      table.insert(data, v)
    end
  end
  if table.isEmpty(data) then
    return 0
  end
  return #data
end

local hatchHouseGroupId = 3023

function this:getPetEggUnitState(uid, bldGuid)
  local hatchGuids = L_HomeStore:getHomeBuildingUidsByGroupId(hatchHouseGroupId)
  if not hatchGuids then
    return L_PetConst.PetEggState.Idle, self:getEggIncubationTime(self:getPetEggItem(uid).configId, bldGuid)
  end
  for _, guid in ipairs(hatchGuids) do
    local buildingDatas = L_HomeStore:getHomeBuildingByGuid(guid)
    if buildingDatas.hatch and buildingDatas.hatch.hatch_infos then
      for i = 1, #buildingDatas.hatch.hatch_infos do
        local hatchInfoUnit = buildingDatas.hatch.hatch_infos[i]
        if hatchInfoUnit.egg_guid == uid then
          if hatchInfoUnit.start_time <= 0 then
            return L_PetConst.PetEggState.QueueAndNotHatching, self:getEggIncubationTime(self:getPetEggItem(uid).configId, bldGuid)
          end
          if L_TimeUtil:getServerTime() >= hatchInfoUnit.finish_time then
            return L_PetConst.PetEggState.Hatched
          end
          if L_TimeUtil:getServerTime() >= hatchInfoUnit.start_time then
            local totalTime = hatchInfoUnit.finish_time - hatchInfoUnit.start_time
            return L_PetConst.PetEggState.Hatching, hatchInfoUnit.finish_time - L_TimeUtil:getServerTime(), totalTime
          end
        end
      end
    end
  end
  return L_PetConst.PetEggState.Idle, self:getEggIncubationTime(self:getPetEggItem(uid).configId, bldGuid)
end

function this:checkPetEggInHomeBuilding(eggUid, bldUid)
  local eggState = self:getPetEggUnitState(eggUid)
  if eggState == L_PetConst.PetEggState.Idle then
    return true
  end
  local hatchInfos = self:getHatchQueueInfo(bldUid)
  for i = 1, #hatchInfos do
    local hatchUnitInfo = hatchInfos[i]
    if hatchUnitInfo.egg_guid == eggUid then
      return true
    end
  end
  return false
end

function this:getHatchQueueInfo(guid)
  local buildingDatas = L_HomeStore:getHomeBuildingByGuid(guid)
  if buildingDatas and buildingDatas.hatch and buildingDatas.hatch.hatch_infos then
    return buildingDatas.hatch.hatch_infos
  end
  return {}
end

function this:checkHatchBldInHatchingState(bldUid)
  local hatchInfos = self:getHatchQueueInfo(bldUid)
  for i = 1, #hatchInfos do
    local hatchUnitInfo = hatchInfos[i]
    if hatchUnitInfo.egg_guid > 0 then
      if 0 >= hatchUnitInfo.start_time then
        return true
      elseif L_TimeUtil:getServerTime() < hatchUnitInfo.finish_time then
        return true
      end
    end
  end
  return false
end

function this:checkIsHaveSpecialPet(configId)
  local petList = self:getPetList()
  for i, v in pairs(petList) do
    if v.id == configId and v:getIsSpecialPet() then
      return true
    end
  end
  return false
end

function this:getPetItem(uid, isCreate)
  local entity = self.data.petList[uid]
  local tmpEntity = self.data.tmpPetList[uid]
  if entity == nil and tmpEntity == nil and isCreate then
    entity = require(L_R.store .. "pet.data.petItem").new()
    self.data.petList[uid] = entity
  end
  if entity == nil then
    return tmpEntity
  end
  return entity
end

function this:isOwnPet(uid)
  return self.data.petList[uid] ~= nil
end

function this:setTmpPetItem(petItemData)
  local entity = require(L_R.store .. "pet.data.petItem").new()
  local pet_tpl = petInfoTpl:getTplById(petItemData.configId)
  if not pet_tpl then
    errorf("没有该宠物的配置" .. petItemData.configId)
    return
  end
  if petItemData.petName == "" or petItemData.petName == nil then
    local pet_name = petInfoTpl:getName(pet_tpl, petItemData.color)
    entity.pet_name = pet_name
  else
    entity.pet_name = petItemData.petName
  end
  entity.guid = petItemData.guid
  entity.id = petItemData.configId
  entity.comprehension = petItemData.comprehensions or nil
  entity.skills = petItemData.inherentSkills or {}
  entity.feature = petItemData.feature
  entity.lv = petItemData.lv
  entity.exp = petItemData.exp
  entity.rank = petItemData.rank
  entity.hero_id = petItemData.heroId
  entity.petId = petItemData.configId
  entity.is_lock = petItemData.isLock
  entity.race = petInfoTpl:getRace(pet_tpl)
  entity.element = petInfoTpl:getElement(pet_tpl)
  entity.gene_state = petItemData.geneState
  entity.gene_infos = petItemData.geneInfos
  entity.mutation_info = petItemData.mutationInfo
  entity.ur_pos = petItemData.urPos
  entity.speed = petItemData.speed or 0
  entity.work_status = petItemData.workStatus
  entity.work_build = petItemData.workBuild
  entity.talent_id = petItemData.talentIds or {}
  entity.capacity_id = petItemData.capacityId
  entity.box_id = petItemData.boxId
  entity.roulette_pos = petItemData.roulettePos
  entity.satiety_val = petItemData.satietyVal or 0
  entity.canteen_id = petItemData.canteenId
  entity.work_pause = petItemData.workPause
  entity.satiety = entity.satietyVal
  entity.work_start_time = petItemData.workStartTime
  entity.special = petItemData.special or 0
  entity.catch_item = petItemData.catchItem
  entity.grade = petItemData.grade
  entity.base_lv = petItemData.baseLv
  entity.color = petItemData.color
  entity.laborInfoList = {}
  self.data.tmpPetList[petItemData.guid] = entity
end

function this:clearTmpPetItem()
  self.data.tmpPetList = {}
end

function this:getFriendPetItem(pid, guid, isCreate)
  if pid == nil then
    return nil
  end
  if self.data.friendPetList[pid] == nil then
    self.data.friendPetList[pid] = {}
  end
  local friendPetList = self.data.friendPetList[pid]
  local entity = friendPetList[guid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "pet.data.friendPetItem").new()
    self.data.friendPetList[pid][guid] = entity
  end
  return entity
end

function this:cleanFriendPetList()
  self.data.friendPetList = {}
end

function this:resetSelectGuids()
  self.data.selectGuids = {}
  self:call(self.event.setSelectReleasePet)
end

function this:getSelectGuids()
  return self.data.selectGuids
end

function this:setSelectGuids(guids)
  self.data.selectGuids = guids
  if #self.data.selectGuids ~= 0 then
    local lastGuid = self.data.selectGuids[#self.data.selectGuids]
    self:call(self.event.setSelectReleasePet, lastGuid)
  end
end

function this:setSelectReleasePet(guid)
  local key = table.keyOf(self.data.selectGuids, guid)
  local selectId
  local res = false
  if key ~= nil then
    table.remove(self.data.selectGuids, key)
  else
    table.insert(self.data.selectGuids, guid)
    selectId = guid
    res = true
  end
  self:call(self.event.setSelectReleasePet, selectId)
  return res
end

function this:setCurSelectPetId(guid)
  self.data.curSelectedPetGuid = guid
  self:call(self.event.setCurPetId, guid, true)
end

function this:getCurSelectPetId()
  return self.data.curSelectedPetGuid
end

function this:clickBoxFilter()
  self:call(self.event.clickBoxFilter)
end

function this:getPetSkillInfoQueue()
  return self.data.petSkillInfoQueue
end

function this:getIsPlayingTimeLine()
  return self.data.isPlayingEvoTimeLine
end

function this:setIsPlayingTimeLine(bool)
  self.data.isPlayingEvoTimeLine = bool
end

function this:getEggIncubationTime(petEggConfigId, bldUid, isProduct, previewPetGuid)
  local tpl = eggTpl:getTplById(petEggConfigId)
  local IncubationTime = eggTpl:getEggTime(tpl)
  bldUid = bldUid or 0
  local bldDatas = L_HomeStore:getHomeBuildingByGuid(bldUid)
  if bldDatas or previewPetGuid then
    local petGuid = previewPetGuid
    if isProduct and bldDatas and bldDatas.station_pet_guid and bldDatas.station_pet_guid ~= 0 then
      petGuid = bldDatas.station_pet_guid
    end
    local petData = petGuid and petGuid ~= 0 and L_PetStore:getPetItem(petGuid)
    local petEggHatchCondition = L_HomeBuffManager:getPetEggHatchCondition(petEggConfigId)
    local PetEggHatchTimeParams = {}
    PetEggHatchTimeParams.petGuid = petGuid
    PetEggHatchTimeParams.isProduct = isProduct
    if petData and petData.talent_id then
      PetEggHatchTimeParams.talentIds = petData.talent_id
    end
    local decreaseValue = L_HomeBuffManager:getPetEggHatchTimeValue(petEggConfigId, petEggHatchCondition, PetEggHatchTimeParams)
    local decreasePercent = L_HomeBuffManager:getPetEggHatchTimePercent(petEggConfigId, petEggHatchCondition, PetEggHatchTimeParams)
    local originTime = IncubationTime
    if isProduct and petGuid ~= nil and petGuid ~= 0 then
      local homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
      local laborType = homeBuildingProductionTpl:getLaborType(homeBuildingProductionTpl:getTplById(bldDatas.build_id))
      local productParams = {}
      productParams.petGuid = petGuid
      productParams.laborType = laborType
      productParams.isProduct = isProduct
      productParams.buildType = 12
      local timeAfterQualityReduct = L_HomeBuffManager:getQualityTimeReduct(homeBuildingProductionTpl, productParams, originTime)
      if originTime ~= 0 then
        local addValue = (originTime - timeAfterQualityReduct) / originTime
        decreasePercent = decreasePercent + addValue
      end
    end
    IncubationTime = IncubationTime * (1 - decreasePercent)
    IncubationTime = IncubationTime - decreaseValue
  end
  IncubationTime = math.floor(IncubationTime)
  local hatchMinTime = gameConstTpl:getData("HOME_HATCH_BOTTOM_TIME", L_Const.GameTplType.int)
  IncubationTime = IncubationTime >= hatchMinTime and IncubationTime or hatchMinTime
  return IncubationTime
end

function this:getEggElementId(uid)
  local tpl = eggTpl:getTplById(uid)
  local elementId = eggTpl:getElement(tpl)
  return elementId
end

function this:getPetPropertyMap(petGuid)
  local petData = self:getCsPetData(petGuid)
  if petData ~= nil then
    return petData.attrDict
  end
  return self.emptyTbl
end

function this:getPetPropertyGeneMap(petGuid)
  local petData = self:getCsPetData(petGuid)
  if petData ~= nil and petData.geneAttrDict ~= nil then
    return petData.geneAttrDict
  end
  return self.emptyTbl
end

function this:getPetPropertyNonGeneMap(petGuid)
  local petData = self:getCsPetData(petGuid)
  if petData ~= nil and petData.nonGeneAttrDict ~= nil then
    return petData.nonGeneAttrDict
  end
  return self.emptyTbl
end

function this:getPetPropertyInherentSkills(petGuid)
  local petData = self:getCsPetData(petGuid)
  if petData ~= nil then
    local skillData = {}
    for i, skill in pairs(petData.inherentSkills) do
      table.insert(skillData, skill)
    end
    return skillData
  end
  return self.emptyTbl
end

function this:getPetPropertyGeneSkills(petGuid)
  local petData = self:getCsPetData(petGuid)
  if petData ~= nil then
    local skillData = {}
    for i, skill in pairs(petData.geneSkills) do
      table.insert(skillData, skill)
    end
    return skillData
  end
  return self.emptyTbl
end

function this:getPetGeneExtraAttr(petData)
  local attr = {}
  local geneInfos = geneInfosToTable(petData and (petData.gene_infos or petData.geneInfos))
  for _, geneInfo in pairs(geneInfos) do
    local geneId = geneInfo.gene_id or geneInfo.geneId
    if not math.isEmpty(geneId) then
      geneId = tonumber(geneId) or geneId
      local skillCfg = _skillTpl:getTplById(geneId)
      if skillCfg ~= nil and _skillTpl:getSkillType(skillCfg) == L_Const.skillFuncType.number then
        local attrupCfg = _skillsubAttrupTpl:getTplById(geneId)
        local attributeList = attrupCfg ~= nil and _skillsubAttrupTpl:getAttributeList(attrupCfg) or nil
        for attrId, value in pairs(attributeList or {}) do
          attrId = tonumber(attrId) or attrId
          value = tonumber(value) or 0
          attr[attrId] = (attr[attrId] or 0) + value
        end
      end
    end
  end
  return attr
end

function this:getDisplayAttrValueFromAttrMap(extraAttr, attrEnumId, baseValue)
  baseValue = tonumber(baseValue) or 0
  if battleInfoTpl:getHasGroup(attrEnumId) then
    local group = battleInfoTpl:getGroupById(attrEnumId)
    local value = 0
    for _, tpl in pairs(group or {}) do
      local attrId = battleInfoTpl:getAttrVal(tpl)
      local attrValue = tonumber(extraAttr[attrId]) or 0
      local groupType = battleInfoTpl:getGroupType(tpl)
      if groupType == 1 then
        value = value + attrValue
      elseif groupType == 2 then
        if battleInfoTpl:getIsRatio(tpl) == 1 then
          attrValue = attrValue / 10000
        end
        value = value + baseValue * attrValue
      elseif groupType == 3 then
        value = value + attrValue
      end
    end
    return value
  end
  return tonumber(extraAttr[attrEnumId]) or 0
end

function this:getPetGeneExtraDisplayAttr(petData, attrEnumId, baseValue)
  return self:getDisplayAttrValueFromAttrMap(self:getPetGeneExtraAttr(petData), attrEnumId, baseValue)
end

function this:getPetServerGeneExtraDisplayAttr(petGuid, attrEnumId, baseValue)
  baseValue = tonumber(baseValue) or 0
  local geneAttrMap = self:getPetPropertyGeneMap(petGuid)
  
  local function getAttrValue(attrId)
    local attrInfo
    if type(geneAttrMap) == "userdata" then
      for k, v in pairs(geneAttrMap) do
        if k == attrId then
          attrInfo = v
          break
        end
      end
    else
      attrInfo = geneAttrMap[attrId]
    end
    if attrInfo == nil then
      return 0
    end
    return (tonumber(attrInfo.baseValue) or 0) + (tonumber(attrInfo.extraValue) or 0) + baseValue * (tonumber(attrInfo.percent) or 0)
  end
  
  if battleInfoTpl:getHasGroup(attrEnumId) then
    local group = battleInfoTpl:getGroupById(attrEnumId)
    local value = 0
    for _, tpl in pairs(group or {}) do
      value = value + getAttrValue(battleInfoTpl:getAttrVal(tpl))
    end
    return value
  end
  return getAttrValue(attrEnumId)
end

function this:getPetGeneExtraPropertyAttr(petData, property)
  local res = {}
  local geneExtraAttr = self:getPetGeneExtraAttr(petData)
  local handledGroup = {}
  for attrId, attrValue in pairs(geneExtraAttr) do
    local tpl = battleInfoTpl:getTplById(attrId)
    if tpl ~= nil and battleInfoTpl:getHasGroup(attrId) then
      local groupId = battleInfoTpl:getGroupId(tpl)
      if groupId ~= nil and not handledGroup[groupId] then
        local group = battleInfoTpl:getGroupById(groupId)
        local basicId = group and group[1] and battleInfoTpl:getAttrVal(group[1])
        local extraId = group and group[3] and battleInfoTpl:getAttrVal(group[3])
        local targetId = not math.isEmpty(extraId) and extraId or basicId
        local baseValue = basicId and property[basicId] or 0
        local value = self:getPetGeneExtraDisplayAttr(petData, groupId, baseValue)
        if targetId ~= nil then
          res[targetId] = (res[targetId] or 0) + value
        end
        handledGroup[groupId] = true
      end
    else
      res[attrId] = (res[attrId] or 0) + (tonumber(attrValue) or 0)
    end
  end
  return res
end

function this:getFilterPetData(petList, compareData)
  if table.isEmpty(petList) then
    return {}
  end
  local countList = {}
  for _, v in pairs(petList) do
    table.insert(countList, v)
  end
  if table.isEmpty(compareData) then
    return countList
  end
  local tempList = {}
  for k, n in pairs(compareData.raceFilter) do
    tempList[n] = n
  end
  local recoredMove = {}
  for k, n in pairs(countList) do
    local isExsist = false
    for i, v in pairs(n.race) do
      if tempList[v] ~= nil and not table.isEmpty(tempList) then
        isExsist = true
      end
    end
    if isExsist == false and not table.isEmpty(tempList) then
      table.insert(recoredMove, n.guid)
    end
  end
  for i, v in pairs(recoredMove) do
    for k, n in pairs(countList) do
      if n.guid == v then
        table.remove(countList, k)
        break
      end
    end
  end
  tempList = {}
  for k, n in pairs(compareData.elementFilter) do
    tempList[n] = n
  end
  recoredMove = {}
  for k, n in pairs(countList) do
    local isExsist = false
    for i, v in pairs(n.element) do
      if tempList[v] ~= nil and not table.isEmpty(tempList) then
        isExsist = true
      end
    end
    if isExsist == false and not table.isEmpty(tempList) then
      table.insert(recoredMove, n.guid)
    end
  end
  for i, v in pairs(recoredMove) do
    for k, n in pairs(countList) do
      if n.guid == v then
        table.remove(countList, k)
        break
      end
    end
  end
  tempList = {}
  for k, n in pairs(compareData.rideFilter) do
    tempList[n] = n
  end
  recoredMove = {}
  for k, n in pairs(countList) do
    local isExsist = false
    local index = {}
    if not math.isEmpty(n.speed) then
      table.insert(index, 1)
    end
    if petInfoTpl:getIsBattle(petInfoTpl:getTplById(n.id)) then
      table.insert(index, 2)
    end
    for i, v in pairs(index) do
      if tempList[v] ~= nil and not table.isEmpty(tempList) then
        isExsist = true
      end
    end
    if isExsist == false and not table.isEmpty(tempList) then
      table.insert(recoredMove, n.guid)
    end
  end
  for i, v in pairs(recoredMove) do
    for k, n in pairs(countList) do
      if n.guid == v then
        table.remove(countList, k)
        break
      end
    end
  end
  return countList
end

function this:getPetGene(guid, gene_id)
  local pet = self:getPetItem(guid)
  if pet ~= nil then
    local petGene = pet.gene_infos
    for i, v in pairs(petGene) do
      if v.gene_id == gene_id then
        local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
        local skillTpl = L_GameTpl:getSkillTpl()
        local tpl = skillLevelTpl:getTplByIdAndLevel(v.gene_id, v.gene_lv)
        if tpl ~= nil then
          local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
          local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
          local dnaRarity = petDna:getRarity(dnaTpl)
          local dnaIcon = petDna:getIcon(dnaTpl)
          local skillName = skillTpl:getName(nameTpl)
          local dnaLength = petDna:getLength(dnaTpl)
          local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
          local data = {
            geneId = v.gene_id,
            lv = v.gene_lv,
            describe = skillDescribe,
            name = skillName,
            starLv = v.gene_lv,
            rarity = dnaRarity,
            length = dnaLength,
            icon = dnaIcon
          }
          return data
        end
      end
    end
  end
  return nil
end

function this:getNewSkillSlotInfo(petData, petSlotInfo, add_guid)
  add_guid = add_guid or {}
  local updateSkill = {}
  local newSkill = {}
  local convertSkill = {}
  petData.id = petData.config_id
  petData.skills = petData.inherent_skills
  local innerSkills = self:getPetSkills(petData, false, false, true)
  local targetSlotList = {}
  for i, v in pairs(innerSkills) do
    targetSlotList[v.skillSlot] = v.skillSlot
  end
  local skill = petData.inherent_skills or {}
  petSlotInfo = petSlotInfo or {}
  local isNewPet = false
  if not table.isEmpty(add_guid) then
    for i, v in pairs(add_guid) do
      if v == petData.guid then
        isNewPet = true
        break
      end
    end
  end
  for _, v in pairs(skill) do
    if targetSlotList[v.skill_slot] then
      local curSlotData = petSlotInfo[v.skill_slot]
      if curSlotData == nil then
        table.insert(newSkill, v)
        petSlotInfo[v.skill_slot] = v
      elseif curSlotData.skill_id ~= v.skill_id or curSlotData.skill_lv ~= v.skill_lv then
        v.oldInfo = petSlotInfo[v.skill_slot]
        if curSlotData.skill_id ~= v.skill_id then
          table.insert(convertSkill, {old_Skill = curSlotData, convert_Skill = v})
        else
          table.insert(updateSkill, v)
        end
        petSlotInfo[v.skill_slot] = v
      end
    end
  end
  if 0 < #updateSkill and self.data.setHasInitSync == true and not isNewPet then
    self:call(self.event.updatePetSkill, updateSkill, 2)
  end
  if 0 < #newSkill and self.data.setHasInitSync == true and not isNewPet then
    self:call(self.event.getNewPetSkill, newSkill, 1)
  end
  if 0 < #convertSkill and self.data.setHasInitSync == true and not isNewPet then
    self:call(self.event.convertPetSkill, convertSkill, 3)
  end
  return petSlotInfo
end

function this:getAllPetEggGuid()
  local guidList = {}
  for i, v in pairs(self.data.petEggList) do
    table.insert(guidList, v.guid)
  end
  return guidList
end

function this:getPetFeatureSkill(pet)
  local innerSkills = pet.skills or {}
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local skillTpl = L_GameTpl:getSkillTpl()
  local randomSlot = self.data.petRandomSkillRange
  local fixedSlot = self.data.petFixedSkillRange
  local featureList = {}
  for _, n in pairs(innerSkills) do
    if n.skill_slot <= randomSlot[2] and n.skill_slot >= randomSlot[1] then
      table.insert(featureList, n)
    elseif n.skill_slot <= fixedSlot[2] and n.skill_slot >= fixedSlot[1] then
      table.insert(featureList, n)
    end
  end
  local freatureSkill = {}
  local skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
  for i, v in pairs(featureList) do
    local tpl = skillLevelTpl:getTplByIdAndLevel(v.skill_id, v.skill_lv)
    if tpl ~= nil then
      local skillId = skillLevelTpl:getSkillGroupId(tpl)
      local nameTpl = skillTpl:getTplById(tonumber(skillId))
      local skillName = skillTpl:getName(nameTpl)
      local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
      local skillIcon = skillTpl:getIcon(nameTpl)
      local tpl_skillSub = skillSubLogicTpl:getTplById(skillId)
      local skillCd = skillSubLogicTpl:getCoolDown(tpl_skillSub)
      table.insert(freatureSkill, {
        index = v.skill_id,
        skillLv = "Lv." .. v.skill_lv,
        skillLevelShow = false,
        levelLabel = true,
        skillCd = skillCd,
        itemIcon = skillIcon,
        describe = skillDescribe,
        skillName = skillName,
        skillSlot = v.skill_slot,
        skillElement = skillTpl:getSkillElement(nameTpl)
      })
    end
  end
  return freatureSkill
end

function this:getGenePetSkills(pet)
  local geneSkills = pet.gene_infos
  local data = {}
  if geneSkills ~= nil then
    for i = 0, geneSkills.Count - 1 do
      local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
      local skillTpl = L_GameTpl:getSkillTpl()
      local tpl = skillLevelTpl:getTplByIdAndLevel(geneSkills[i].geneId, 1)
      if tpl ~= nil then
        local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
        local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
        local dnaRarity = petDna:getRarity(dnaTpl)
        local skillName = skillTpl:getName(nameTpl)
        local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
        local skillIcon = skillTpl:getIcon(nameTpl)
        local dnaType = petDna:getDnaType(dnaTpl)
        local dnaTypeTpl = petDnaType:getTplById(dnaType)
        local dnaTypeName = petDnaType:getName(dnaTypeTpl)
        local dnaTypeIcon = petDnaType:getIcon(dnaTypeTpl)
        table.insert(data, {
          index = geneSkills[i].geneId,
          geneId = geneSkills[i].geneId,
          skillLv = "Lv." .. geneSkills[i].geneLv,
          skillLevelShow = geneSkills[i].geneLv ~= 0,
          levelLabel = false,
          itemIcon = skillIcon,
          describe = skillDescribe,
          skillName = skillName,
          starLv = geneSkills[i].geneLv,
          rarity = dnaRarity,
          genePos = geneSkills[i].pos,
          petId = pet.guid,
          dnaType = dnaType,
          dnaTypeName = dnaTypeName,
          dnaTypeIcon = dnaTypeIcon,
          skillLevelTpl = tpl
        })
      end
    end
  end
  local list = {}
  for i, v in pairs(data) do
    table.insert(list, v)
  end
  return list
end

function this:getDataByGuid(list, pos)
  local data = {}
  if pos <= #list then
    data = {
      petId = list[pos].petId,
      rarity = list[pos].rarity,
      skillName = list[pos].skillName,
      geneId = list[pos].geneId,
      skillDescribe = list[pos].describe,
      describe = list[pos].describe,
      dnaTypeIcon = list[pos].dnaTypeIcon,
      show_lockBg = false,
      skillLevelTpl = list[pos].skillLevelTpl
    }
    return data
  else
    return nil
  end
end

function this:getPetKiboDuelSkills(pet)
  local tpl = petInfoTpl:getTplById(pet.id)
  local skills = petInfoTpl:getKiboSkillList(tpl)
  local innerSkills = pet.skills or {}
  local skillLvByIdMap = {}
  for _, s in pairs(innerSkills) do
    skillLvByIdMap[s.skill_id] = s.skill_lv
  end
  local kiboDuelSkillList = {}
  for _, v in pairs(skills) do
    if v[1] == self.data.petSpecialSkill then
      table.insert(kiboDuelSkillList, {
        slot = v[1],
        id = v[2],
        level = skillLvByIdMap[v[2]] or 1
      })
    end
  end
  for _, v in pairs(skills) do
    if v[1] == 1 or v[1] == 2 then
      table.insert(kiboDuelSkillList, {
        slot = v[1],
        id = v[2],
        level = skillLvByIdMap[v[2]] or 1
      })
    end
  end
  local _skill = petInfoTpl:getKiboBPropertyskillList(tpl)
  for k, v in pairs(_skill) do
    table.insert(kiboDuelSkillList, {
      slot = k,
      id = v,
      level = 1
    })
  end
  local skills = {}
  for i, v in ipairs(kiboDuelSkillList) do
    local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
    local skillTpl = L_GameTpl:getSkillTpl()
    local skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
    local tpl = skillLevelTpl:getTplByIdAndLevel(v.id, v.level)
    if tpl ~= nil then
      local skillId = skillLevelTpl:getSkillGroupId(tpl)
      local nameTpl = skillTpl:getTplById(tonumber(skillId))
      local skillName = skillTpl:getName(nameTpl)
      local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
      local skillIcon = skillTpl:getIcon(nameTpl)
      local tpl_skillSub = skillSubLogicTpl:getTplById(skillId)
      local skillCd = skillSubLogicTpl:getkiBoVersusCoolDown(tpl_skillSub)
      local skillPowerName = skillLevelTpl:getSkillPowerName(tpl)
      local skillPower = skillLevelTpl:getSkillPower(tpl)
      local skillPowerType = skillLevelTpl:getSkillPowerType(tpl)
      table.insert(skills, {
        index = v.slot,
        skillLv = "Lv." .. v.level,
        skillId = v.id,
        skillCd = skillCd,
        skillLevelShow = false,
        levelLabel = true,
        itemIcon = skillIcon,
        describe = skillDescribe,
        skillName = skillName,
        skillElement = skillTpl:getSkillElement(nameTpl),
        skillSlot = v.slot,
        skillLevelTpl = tpl,
        skillPowerName = skillPowerName,
        skillPower = skillPower,
        name = skillPowerType
      })
    end
  end
  return skills
end

function this:getPetSkills(pet, showLockSkills, showGeneSkills, showInnerSkills, isKiboArena)
  local innerSkills = pet.skills or {}
  local geneSkills = pet.gene_infos or {}
  local innerData = {}
  if showInnerSkills == true then
    local tpl = petInfoTpl:getTplById(pet.id)
    local fixedSkillList = petInfoTpl:getFixedSkillList(tpl)
    local filter = {}
    for i, v in pairs(fixedSkillList) do
      filter[i] = v
    end
    local specialSkill = {}
    local normalSkill = {}
    local breakSkill = {}
    local totalSkill = {}
    for _, v in pairs(innerSkills) do
      if v.skill_slot == self.data.petSpecialSkill then
        table.insert(specialSkill, v)
      end
      if v.skill_slot >= self.data.petNormalSkill[1] and v.skill_slot <= self.data.petNormalSkill[2] and filter[v.skill_slot] == nil then
        table.insert(normalSkill, v)
      end
      if v.skill_slot == self.data.petBreakSkill then
        table.insert(breakSkill, v)
      end
    end
    table.fill(totalSkill, specialSkill)
    table.fill(totalSkill, normalSkill)
    table.fill(totalSkill, breakSkill)
    for i, v in ipairs(totalSkill) do
      local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
      local skillTpl = L_GameTpl:getSkillTpl()
      local skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
      local tpl = skillLevelTpl:getTplByIdAndLevel(v.skill_id, v.skill_lv)
      if tpl ~= nil then
        local skillId = skillLevelTpl:getSkillGroupId(tpl)
        local nameTpl = skillTpl:getTplById(tonumber(skillId))
        local skillName = skillTpl:getName(nameTpl)
        local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
        local skillIcon = skillTpl:getIcon(nameTpl)
        local tpl_skillSub = skillSubLogicTpl:getTplById(skillId)
        local skillCd = skillSubLogicTpl:getCoolDown(tpl_skillSub)
        local skillPowerName = skillLevelTpl:getSkillPowerName(tpl)
        local skillPower = skillLevelTpl:getSkillPower(tpl)
        local skillPowerType = skillLevelTpl:getSkillPowerType(tpl)
        table.insert(innerData, {
          index = v.skill_slot,
          skillLv = "Lv." .. v.skill_lv,
          skillId = v.skill_id,
          skillCd = skillCd,
          skillLevelShow = false,
          levelLabel = true,
          itemIcon = skillIcon,
          describe = skillDescribe,
          skillName = skillName,
          skillElement = skillTpl:getSkillElement(nameTpl),
          skillSlot = v.skill_slot,
          skillLevelTpl = tpl,
          skillPowerName = skillPowerName,
          skillPower = skillPower,
          name = skillPowerType
        })
      end
    end
  end
  local data = {}
  if showGeneSkills == true then
    local unlockConditions = L_PetManager:getGeneUnlockConditions()
    if geneSkills ~= nil then
      for _, n in pairs(geneSkills) do
        local lock = pet.lv < (unlockConditions[n.pos] or 0)
        local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
        local skillTpl = L_GameTpl:getSkillTpl()
        local skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
        local tpl = skillLevelTpl:getTplByIdAndLevel(n.gene_id or n.geneId, 1)
        if showLockSkills == false then
          if lock == false and tpl ~= nil then
            local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
            local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
            local dnaRarity = petDna:getRarity(dnaTpl)
            local skillName = skillTpl:getName(nameTpl)
            local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
            local skillIcon = skillTpl:getIcon(nameTpl)
            local dnaType = petDna:getDnaType(dnaTpl)
            local dnaTypeTpl = petDnaType:getTplById(dnaType)
            local dnaTypeName = petDnaType:getName(dnaTypeTpl)
            local dnaTypeIcon = petDnaType:getIcon(dnaTypeTpl)
            local tpl_skillSub = skillSubLogicTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
            local skillCd = skillSubLogicTpl:getCoolDown(tpl_skillSub)
            local skillPowerName = skillLevelTpl:getSkillPowerName(tpl)
            local skillPower = skillLevelTpl:getSkillPower(tpl)
            local skillPowerType = skillLevelTpl:getSkillPowerType(tpl)
            local geneId = n.gene_id or n.geneId
            local geneLv = n.gene_lv or n.geneLv
            table.insert(data, {
              index = geneId,
              geneId = geneId,
              skillLv = "Lv." .. geneLv,
              skillLevelShow = geneLv ~= 0,
              levelLabel = false,
              itemIcon = skillIcon,
              describe = skillDescribe,
              skillName = skillName,
              skillCd = skillCd,
              starLv = geneLv,
              rarity = dnaRarity,
              genePos = n.pos,
              petId = pet.guid,
              dnaType = dnaType,
              dnaTypeName = dnaTypeName,
              dnaTypeIcon = dnaTypeIcon,
              skillLevelTpl = tpl,
              skillPowerName = skillPowerName,
              skillPower = skillPower,
              name = skillPowerType,
              isKiboArena = isKiboArena
            })
          end
        elseif tpl ~= nil then
          local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
          local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
          local dnaRarity = petDna:getRarity(dnaTpl)
          local skillName = skillTpl:getName(nameTpl)
          local tpl_skillSub = skillSubLogicTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
          local skillCd = skillSubLogicTpl:getCoolDown(tpl_skillSub)
          local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
          local skillIcon = skillTpl:getIcon(nameTpl)
          local dnaType = petDna:getDnaType(dnaTpl)
          local dnaTypeTpl = petDnaType:getTplById(dnaType)
          local dnaTypeName = petDnaType:getName(dnaTypeTpl)
          local dnaTypeIcon = petDnaType:getIcon(dnaTypeTpl)
          local skillPowerName = skillLevelTpl:getSkillPowerName(tpl)
          local skillPower = skillLevelTpl:getSkillPower(tpl)
          local skillPowerType = skillLevelTpl:getSkillPowerType(tpl)
          local geneId = n.gene_id or n.geneId
          local geneLv = n.gene_lv or n.geneLv
          table.insert(data, {
            index = geneId,
            geneId = geneId,
            skillLv = "Lv." .. geneLv,
            skillLevelShow = geneLv ~= 0,
            levelLabel = false,
            itemIcon = skillIcon,
            describe = skillDescribe,
            skillName = skillName,
            skillCd = skillCd,
            starLv = geneLv,
            rarity = dnaRarity,
            genePos = n.pos,
            show_lockBg = lock == true,
            petId = pet.guid,
            dnaType = dnaType,
            dnaTypeName = dnaTypeName,
            dnaTypeIcon = dnaTypeIcon,
            skillLevelTpl = tpl,
            skillPowerName = skillPowerName,
            skillPower = skillPower,
            name = skillPowerType,
            isKiboArena = isKiboArena
          })
        end
      end
    end
  end
  local list = {}
  for i, v in pairs(innerData) do
    table.insert(list, v)
  end
  for i, v in pairs(data) do
    table.insert(list, v)
  end
  if showGeneSkills == false and showInnerSkills == true then
    return innerData
  end
  return list
end

function this:getPetComprehension(petData)
  local comprehension = petData.comprehension
  local comprehensionLst = comprehensionToTable(comprehension)
  local comprehensionSortList = {}
  for i = 1, #comprehensionLst do
    local enumNum = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    for n, k in pairs(comprehensionLst) do
      if k.attr_id == enumNum then
        comprehensionSortList[i] = k
        break
      end
    end
  end
  local comprehensionLstRank = {}
  for i = 1, #comprehensionSortList do
    local enumData = _petLearingEnumTpl:getTplByEnumId(comprehensionSortList[i].attr_id)
    local comprehensionRangeList = petLearningAblityTpl:getTplByEnumId(enumData.id)
    for k, v in pairs(comprehensionRangeList) do
      if comprehensionSortList[i].value <= v.range[2] and comprehensionSortList[i].value > v.range[1] then
        comprehensionLstRank[i] = {
          id = v.id,
          enumId = comprehensionSortList[i].attr_id
        }
        break
      end
    end
  end
  local property = {}
  property.comprehensionRank = comprehensionLstRank
  return property
end

function this:getPetProperty(petData, lv, rankUpPetId, debug)
  local tempLv = lv or petData.lv
  local baseValue = templateValueTpl:getPetConfigAtt(petData.id, tempLv)
  local heroInheritance = {}
  local petLv_limit_switch = L_GameConstTpl:getData("PET_LEVEL_LIMIT_SWITCH", L_Const.GameTplType.int)
  if not math.isEmpty(petData.hero_id) then
    local hero = L_HeroStore:getHero(petData.hero_id)
    local heroLevel = L_HeroStore:getHeroLevel(hero)
    if heroLevel <= petData.lv and petLv_limit_switch == 1 then
      tempLv = heroLevel
    end
    heroInheritance = self:getHeroInheritanceAttr(hero, petData.favor_lv or 0)
  end
  if rankUpPetId ~= nil then
    baseValue = templateValueTpl:getPetConfigAtt(rankUpPetId, tempLv)
  end
  local petConfig = petInfoTpl:getTplById(petData.id)
  local comprehension = petData.comprehension
  local comprehensionLst = comprehensionToTable(comprehension)
  local comprehensionSortList = {}
  for i = 1, #comprehensionLst do
    if _petLearingEnumTpl:getTplById(i) then
      local enumNum = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
      for _, k in ipairs(comprehensionLst) do
        if k.attr_id == enumNum then
          comprehensionSortList[i] = k
          break
        end
      end
    end
  end
  local comprehensionLstRank = {}
  for i = 1, #comprehensionSortList do
    if comprehensionSortList[i] ~= nil then
      local enumData = _petLearingEnumTpl:getTplByEnumId(comprehensionSortList[i].attr_id)
      local comprehensionRangeList = petLearningAblityTpl:getTplByEnumId(enumData.id)
      for k, v in pairs(comprehensionRangeList) do
        if comprehensionSortList[i].value <= v.range[2] and comprehensionSortList[i].value > v.range[1] then
          comprehensionLstRank[i] = {
            id = v.id,
            enumId = comprehensionSortList[i].attr_id
          }
          break
        end
      end
    end
  end
  local hobbyTpl = petHobbyTpl:getTplById(petData.feature)
  local factors = petHobbyTpl:getBaseAttribute(hobbyTpl)
  local hobbyFactor = {}
  local petbaseAttributeList = {}
  local comprehensionFactor = {}
  for i = 1, #_petLearingEnumTpl:getAllEnum() do
    petbaseAttributeList[i] = baseValue[_petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))]
    hobbyFactor[i] = factors[_petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))]
    heroInheritance[i] = heroInheritance[i] or 0
    comprehensionFactor[i] = 1
    for _, v in pairs(comprehensionLst) do
      if _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i)) == v.attr_id then
        comprehensionFactor[i] = v.value / 100
        break
      end
    end
  end
  local property, finishGroup = self:getAttribute(petbaseAttributeList, hobbyFactor, comprehensionFactor, heroInheritance)
  local extraHeritance = {}
  if not math.isEmpty(petData.hero_id) then
    local hero = L_HeroStore:getHero(petData.hero_id)
    extraHeritance = self:getExtraInheritanceAttr(hero, finishGroup, petData.favor_lv or 0)
  end
  local geneExtraAttr = self:getPetGeneExtraPropertyAttr(petData, property)
  for i, v in pairs(geneExtraAttr) do
    if baseValue[i] or property[i] then
      extraHeritance[i] = (extraHeritance[i] or 0) + v
    end
  end
  local catalogAttr = L_CatalogStore:getPetAllAttr(petData.id)
  for i, v in pairs(catalogAttr) do
    extraHeritance[i] = (extraHeritance[i] or 0) + v
  end
  local templateId = petInfoTpl:getStarsoulId(petConfig)
  local starSoulAttr = _petStarSoulTpl:getUpgradeCumulativeAttr(templateId, petData.stage, petData.node)
  if starSoulAttr and not table.isEmpty(starSoulAttr) then
    for attrId, addVal in pairs(starSoulAttr) do
      extraHeritance[attrId] = (extraHeritance[attrId] or 0) + addVal
    end
  end
  local debugStrs = {}
  if debug then
    for i = 1, 6 do
      local debugStr = ""
      debugStr = debugStr .. L_WordsTpl:getValue("ui_systemMessage_25") .. petbaseAttributeList[i]
      debugStr = debugStr .. L_WordsTpl:getValue("ui_pageHomeCenterPetStationedManage_01") .. tempLv
      debugStr = debugStr .. L_WordsTpl:getValue("ui_systemMessage_26") .. hobbyFactor[i]
      debugStr = debugStr .. L_WordsTpl:getValue("ui_systemMessage_27") .. comprehensionFactor[i]
      debugStr = debugStr .. L_WordsTpl:getValue("ui_systemMessage_28") .. heroInheritance[i]
      debugStrs[i] = debugStr
    end
  end
  local forBattleProperty = self:getBattleStructProperty(petbaseAttributeList, hobbyFactor, comprehensionFactor, heroInheritance, baseValue, extraHeritance)
  for i, v in pairs(property) do
    baseValue[i] = v
  end
  for i, v in pairs(extraHeritance) do
    baseValue[i] = (baseValue[i] or 0) + v
  end
  if petData:getPetAbilityLimited() then
    local decayRatio = 1 - petData:getPetAbilityAllAttriDecay() / 10000
    for attrId, _ in pairs(property) do
      if petInheritanceTpl:getTplByAttrId(attrId) ~= nil then
        baseValue[attrId] = baseValue[attrId] * decayRatio
      end
    end
  end
  property = baseValue
  property.battlStructProperty = forBattleProperty
  property.comprehensionRank = comprehensionLstRank
  local grade, gradeRank = L_PetStore:getPetGradeNew(petData.guid)
  property.grade = grade
  property.gradeRank = gradeRank
  return property, debugStrs
end

function this:getPetOriginalProperty(petData, lv, rankUpPetId, isKiboArena)
  local tempLv = lv or petData.lv
  local baseValue = templateValueTpl:getPetConfigAtt(petData.id, tempLv)
  if rankUpPetId ~= nil then
    baseValue = templateValueTpl:getPetConfigAtt(rankUpPetId, tempLv)
  end
  local petConfig = petInfoTpl:getTplById(petData.id)
  if isKiboArena then
    local templateId = petInfoTpl:getGetKiboArenaBaseTemplateID(petConfig)
    baseValue = templateValueTpl:getPetConfigAtt(templateId, tempLv, isKiboArena)
  end
  local comprehension = petData.comprehension
  local comprehensionList = comprehensionToTable(comprehension)
  local comprehensionSortList = {}
  for i = 1, #comprehensionList do
    local enumNum = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    for _, v in pairs(comprehensionList) do
      if v.attr_id == enumNum then
        comprehensionSortList[i] = v
        break
      end
    end
  end
  local comprehensionLstRank = {}
  for i = 1, #comprehensionSortList do
    local enumData = _petLearingEnumTpl:getTplByEnumId(comprehensionSortList[i].attr_id)
    local comprehensionRangeList = petLearningAblityTpl:getTplByEnumId(enumData.id)
    for k, v in pairs(comprehensionRangeList) do
      if comprehensionSortList[i].value <= v.range[2] and comprehensionSortList[i].value > v.range[1] then
        comprehensionLstRank[i] = {
          id = v.id,
          enumId = comprehensionSortList[i].attr_id
        }
        break
      end
    end
  end
  local hobbyTpl = petHobbyTpl:getTplById(petData.feature)
  local factors = petHobbyTpl:getBaseAttribute(hobbyTpl)
  local hobbyFactor = {}
  local petbaseAttributeList = {}
  local comprehensionFactor = {}
  for i = 1, #_petLearingEnumTpl:getAllEnum() do
    petbaseAttributeList[i] = baseValue[_petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))]
    hobbyFactor[i] = factors[_petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))]
    for _, v in pairs(comprehensionList) do
      local attrId = v.attr_id or v.attrId
      if _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i)) == attrId then
        comprehensionFactor[i] = v.value / 100
        break
      end
    end
  end
  local property, _ = self:getAttribute(petbaseAttributeList, hobbyFactor, comprehensionFactor, {})
  for i, v in pairs(property) do
    baseValue[i] = v
  end
  local geneExtraAttr = self:getPetGeneExtraPropertyAttr(petData, baseValue)
  for i, v in pairs(geneExtraAttr) do
    baseValue[i] = (baseValue[i] or 0) + v
  end
  if not isKiboArena then
    local catalogAttr = L_CatalogStore:getPetAllAttr(petData.id)
    for i, v in pairs(catalogAttr) do
      baseValue[i] = (baseValue[i] or 0) + v
    end
  end
  local templateId = petInfoTpl:getStarsoulId(petConfig)
  local starSoulAttr = _petStarSoulTpl:getUpgradeCumulativeAttr(templateId, petData.stage, petData.node)
  if starSoulAttr and not table.isEmpty(starSoulAttr) then
    for attrId, addVal in pairs(starSoulAttr) do
      baseValue[attrId] = (baseValue[attrId] or 0) + addVal
    end
  end
  if petData:getPetAbilityLimited() and not isKiboArena then
    local decayRatio = 1 - petData:getPetAbilityAllAttriDecay() / 10000
    for attrId, _ in pairs(property) do
      if petInheritanceTpl:getTplByAttrId(attrId) ~= nil then
        baseValue[attrId] = baseValue[attrId] * decayRatio
      end
    end
  end
  property = baseValue
  property.comprehensionRank = comprehensionLstRank
  property.grade, property.gradeRank = L_PetStore:getPetGradeNew(petData.guid)
  return property
end

function this:getPetSixDimEnumOrder()
  if table.isEmpty(self.cachedPetSixDimEnumOrder) then
    local allEnum = _petLearingEnumTpl:getAllEnum(true)
    for _, enumTpl in ipairs(allEnum) do
      table.insert(self.cachedPetSixDimEnumOrder, _petLearingEnumTpl:getEnumNum(enumTpl))
    end
  end
  return self.cachedPetSixDimEnumOrder
end

function this:getPetComprehensionSixDimLevel(petData)
  local comprehensionList = comprehensionToTable(petData and petData.comprehension)
  local comprehensionLevelMap = {}
  for _, comprehension in ipairs(comprehensionList) do
    local attrId = comprehension.attr_id or comprehension.attrId
    if attrId ~= nil then
      comprehensionLevelMap[attrId] = {
        currentLevel = comprehension.level or 0,
        initLevel = comprehension.init_level or comprehension.initLevel or 0,
        comprehensionValue = comprehension.value or comprehension.Value or 0
      }
    end
  end
  local enumOrder = self:getPetSixDimEnumOrder()
  local result = {}
  for _, enumId in ipairs(enumOrder) do
    local enumTpl = _petLearingEnumTpl:getTplByEnumId(enumId)
    local pack = comprehensionLevelMap[enumId]
    table.insert(result, {
      enumId = enumId,
      enumTplId = enumTpl and _petLearingEnumTpl:getId(enumTpl) or 0,
      currentLevel = pack and pack.currentLevel or 0,
      initLevel = pack and pack.initLevel or 0,
      comprehensionValue = pack and pack.comprehensionValue or 0
    })
  end
  return result
end

function this:getPotentialWeightByLevel(potentialLevel, weightCfg)
  if table.isEmpty(weightCfg) or table.isEmpty(weightCfg[1]) or table.isEmpty(weightCfg[2]) then
    return 0
  end
  local thresholdList = weightCfg[1]
  local weightList = weightCfg[2]
  for i, upper in ipairs(thresholdList) do
    if potentialLevel <= upper then
      return weightList[i] or weightList[#weightList] or 0
    end
  end
  return weightList[#weightList] or 0
end

function this:getPetSixDimPotentialQualification(petData)
  local sixDimList = self:getPetComprehensionSixDimLevel(petData)
  local petTpl = petInfoTpl:getTplById(petData.id)
  local attrRecommend = petTpl and petTpl.attrRecommend or {}
  local recommendMain = attrRecommend[1]
  local recommendSub = attrRecommend[2]
  local EL = gameConstTpl:getData("KIBO_AVERAGE_POTENTIAL_LEVEL", L_Const.GameTplType.int) or 0
  local MI = gameConstTpl:getData("KIBO_MIN_POTENTIAL_LEVEL", L_Const.GameTplType.int) or 0
  local mainWeightCfg = gameConstTpl:getData("ARRAY_MAIN_POTENTIAL_WEIGHT", L_Const.GameTplType.list_list_int) or {}
  local secondWeightCfg = gameConstTpl:getData("ARRAY_SECOND_POTENTIAL_WEIGHT", L_Const.GameTplType.list_list_int) or {}
  local onlyWeightCfg = gameConstTpl:getData("ARRAY_ONLY_POTENTIAL_WEIGHT", L_Const.GameTplType.list_list_int) or {}
  local recommendCount = table.count(attrRecommend)
  local totalIV = 0
  for _, dim in ipairs(sixDimList) do
    local potentialLevel = dim.currentLevel or 0
    local isMainRecommend = recommendMain ~= nil and dim.enumId == recommendMain
    local isSubRecommend = recommendSub ~= nil and dim.enumId == recommendSub
    local iv = 0
    if isMainRecommend then
      local weightCfg = recommendCount == 1 and onlyWeightCfg or mainWeightCfg
      local amtl1 = self:getPotentialWeightByLevel(potentialLevel, weightCfg)
      iv = (potentialLevel - EL) * amtl1
    elseif isSubRecommend then
      local amtl2 = self:getPotentialWeightByLevel(potentialLevel, secondWeightCfg)
      iv = (potentialLevel - EL) * amtl2
    else
      iv = math.max(potentialLevel - EL, MI)
    end
    totalIV = totalIV + iv
  end
  return totalIV
end

function this:getPetTalentGradeTplByTotalIV(totalIV)
  local allTalentGradeList = petTalentTpl:getAllList() or {}
  for _, tpl in ipairs(allTalentGradeList) do
    local grade = petTalentTpl:getGrade(tpl)
    local minVal = grade[1]
    local maxVal = grade[2]
    if minVal ~= nil and maxVal ~= nil and totalIV >= minVal and totalIV <= maxVal then
      return tpl
    end
  end
end

function this:getAttribute(baseValue, hobbyFactor, comprehension, heroInheritance)
  local newValue = {}
  local finishAttrId = {}
  for i, v in ipairs(baseValue) do
    local attrEnumId = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    heroInheritance[i] = heroInheritance[i] or 0
    if battleInfoTpl:getHasGroup(attrEnumId) then
      local group = battleInfoTpl:getGroupById(attrEnumId)
      local basicId = battleInfoTpl:getAttrVal(group[1])
      local perId = battleInfoTpl:getAttrVal(group[2])
      local extraId = battleInfoTpl:getAttrVal(group[3])
      newValue[basicId] = 0
      newValue[perId] = 0
      newValue[extraId] = 0
      finishAttrId[basicId] = 1
      finishAttrId[perId] = 1
      finishAttrId[extraId] = 1
      if battleInfoTpl:getIsRatio(battleInfoTpl:getTplById(attrEnumId)) == 0 then
        local data = v * hobbyFactor[i] * comprehension[i]
        newValue[basicId] = data
        newValue[extraId] = heroInheritance[i]
      else
        newValue[basicId] = v + hobbyFactor[i] * 100 + comprehension[i] * 100
        newValue[extraId] = heroInheritance[i]
      end
    else
      local base, extra = 0
      finishAttrId[attrEnumId] = 1
      if battleInfoTpl:getIsRatio(battleInfoTpl:getTplById(attrEnumId)) == 0 then
        base = v * hobbyFactor[i] * comprehension[i]
        extra = heroInheritance[i]
        newValue[attrEnumId] = base + extra
      else
        base = v + hobbyFactor[i] * 100 + comprehension[i] * 100
        extra = heroInheritance[i]
        newValue[attrEnumId] = base + extra
      end
    end
  end
  return newValue, finishAttrId
end

function this:getPetAttrFruitPreviewPropertyDeltaMap(petData, preUseFruitInfoList, previewLv)
  local previewMap = {}
  if petData == nil then
    return previewMap
  end
  local previewLevel = previewLv or petData.lv
  local hasAttrFruitPreview = not table.isEmpty(preUseFruitInfoList)
  local hasExpFruitPreview = previewLevel ~= petData.lv
  if not hasAttrFruitPreview and not hasExpFruitPreview then
    return previewMap
  end
  local petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
  local petTalentUpgradeTpl = L_GameTpl:getPetTalentUpgradeTpl()
  local addComprehensionExpList = {}
  local curLevelMap = {}
  for _, comprehension in ipairs(comprehensionToTable(petData.comprehension)) do
    local attrId = comprehension.attr_id or comprehension.attrId
    if attrId then
      curLevelMap[attrId] = comprehension.level or 0
    end
  end
  for _, petLearingEnumTpl in pairs(_petLearingEnumTpl:getAllEnum(true)) do
    addComprehensionExpList[_petLearingEnumTpl:getEnumNum(petLearingEnumTpl)] = 0
  end
  for _, preUseFruitInfo in pairs(preUseFruitInfoList or {}) do
    local feedTpl = petFeedItemTpl:getTplById(preUseFruitInfo.itemId)
    if feedTpl then
      for _, effectParam in pairs(petFeedItemTpl:getEffectParamList(feedTpl)) do
        local attrEnumNum = effectParam[1]
        addComprehensionExpList[attrEnumNum] = addComprehensionExpList[attrEnumNum] + effectParam[2] * preUseFruitInfo.itemNum
      end
    end
  end
  
  local function getPropertyAtLevel(pet, lv)
    if not math.isEmpty(pet.hero_id) then
      return self:getPetProperty(pet, lv)
    end
    return self:getPetOriginalProperty(pet, lv)
  end
  
  local oldProperty = getPropertyAtLevel(petData, petData.lv)
  local newPetItem = table.clone(petData)
  local newComprehensionList = {}
  for _, comprehension in ipairs(comprehensionToTable(petData.comprehension)) do
    table.insert(newComprehensionList, table.clone(comprehension))
  end
  newPetItem.comprehension = newComprehensionList
  local targetLevelMap = {}
  for _, comprehension in ipairs(newComprehensionList) do
    local attrId = comprehension.attr_id or comprehension.attrId
    local addExp = addComprehensionExpList[attrId] or 0
    if 0 < addExp then
      local curLevel = comprehension.level or 0
      local curExp = comprehension.cur_exp or 0
      local maxNeedExp = petTalentUpgradeTpl:getMaxNeedExpOfOneComprehension(attrId)
      local curComprehensionExp = curExp + petTalentUpgradeTpl:getNeedExpOfTargetComprehensionTargetLevel(attrId, curLevel)
      if maxNeedExp <= addExp + curComprehensionExp then
        addExp = maxNeedExp - curComprehensionExp
      end
      if 0 < addExp then
        local targetLevel = petTalentUpgradeTpl:getTargetLevelByAttrEnumNumCurLevelCurExpAddExp(attrId, curLevel, curExp, addExp)
        targetLevelMap[attrId] = targetLevel
        if curLevel < targetLevel then
          comprehension.level = targetLevel
          local upgradeTpl = petTalentUpgradeTpl:getTplByAttrEnumNumAndLevel(attrId, targetLevel)
          comprehension.value = petTalentUpgradeTpl:getStartValue(upgradeTpl)
        end
      end
    end
  end
  local newProperty = getPropertyAtLevel(newPetItem, previewLevel)
  for _, petLearingEnumTpl in ipairs(_petLearingEnumTpl:getAllEnum(true)) do
    local enumId = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
    local oldValue = self:getPetAttFinalValue(oldProperty, enumId)
    local newValue = self:getPetAttFinalValue(newProperty, enumId)
    local delta = newValue - oldValue
    local targetLevel = targetLevelMap[enumId]
    local curLevel = curLevelMap[enumId] or 0
    if delta ~= 0 or targetLevel and targetLevel > curLevel then
      previewMap[enumId] = {
        delta = delta,
        targetLevel = targetLevel or curLevel
      }
    end
  end
  return previewMap
end

function this:getPetAttFinalValue(petProperty, attrEnumId, petGuid)
  local value
  if battleInfoTpl:getHasGroup(attrEnumId) then
    local group = battleInfoTpl:getGroupById(attrEnumId)
    local basicId = battleInfoTpl:getAttrVal(group[1])
    local perId = battleInfoTpl:getAttrVal(group[2])
    local extraId = battleInfoTpl:getAttrVal(group[3])
    petProperty[basicId] = petProperty[basicId] or 0
    petProperty[perId] = 0
    petProperty[extraId] = petProperty[extraId] or 0
    value = math.round(petProperty[basicId] + petProperty[extraId])
  else
    value = petProperty[attrEnumId] and math.round(petProperty[attrEnumId]) or 0
  end
  if petGuid ~= nil then
    local battleValue = self:getPetAttributeValueInFormation(petGuid, attrEnumId)
    if battleValue ~= nil then
      value = battleValue
    end
  end
  return value
end

function this:getPetAttributeValueInFormation(petGuid, attrId)
  local posIndexInFormation = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getCurFormationType(), nil, petGuid) - 1
  if 0 <= posIndexInFormation then
    local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(posIndexInFormation)
    if petCsEntity and petCsEntity.data and petCsEntity.data.UUID == petGuid then
      local aliveProperty = petCsEntity.data.aliveProperty
      local current = C_MyFloatUtility.GetFloat(aliveProperty:GetBattlePropertyCurrentValue(attrId))
      return math.round(current)
    end
  end
end

function this:getPetAttSplitValue(petProperty, attrEnumId, petGuid)
  local baseValue, addValue
  local haveExtraId = false
  local stagePetPropBase, stagePetPropAdd
  if battleInfoTpl:getHasGroup(attrEnumId) then
    local tpl_tmp = battleInfoTpl:getTplById(attrEnumId)
    local groupId = battleInfoTpl:getGroupId(tpl_tmp)
    local group = battleInfoTpl:getGroupById(attrEnumId)
    local basicId = battleInfoTpl:getAttrVal(group[1])
    local perId = battleInfoTpl:getAttrVal(group[2])
    local extraId = battleInfoTpl:getAttrVal(group[3])
    if extraId ~= 0 then
      haveExtraId = true
    end
    petProperty[basicId] = petProperty[basicId] or 0
    petProperty[perId] = petProperty[perId] or 0
    petProperty[extraId] = petProperty[extraId] or 0
    baseValue = petProperty[basicId] or 0
    addValue = petProperty[extraId]
    stagePetPropBase, stagePetPropAdd = baseValue, addValue
  else
    baseValue = petProperty[attrEnumId] or 0
    addValue = 0
    stagePetPropBase, stagePetPropAdd = baseValue, addValue
  end
  if petGuid ~= nil then
    local petItem = self:getPetItem(petGuid)
    local petData = petItem or self:getCsPetData(petGuid)
    local isPetEquipped = petData ~= nil and (not math.isEmpty(petData.hero_id) or not math.isEmpty(petData.heroId))
    local battleValue = self:getPetAttributeValueInFormation(petGuid, attrEnumId)
    local battleProperty = L_PetStore:getBattleStructPropertyNew(petGuid, isPetEquipped and self:getPetPropertyNonGeneMap(petGuid) or nil)
    for k, v in ipairs(battleProperty) do
      if v.id == attrEnumId then
        baseValue = math.round(v.baseValue)
        addValue = 0
        if battleValue ~= nil then
          local tmpExtra = battleValue - baseValue
          if isPetEquipped or haveExtraId then
            addValue = math.round(tmpExtra)
          else
            baseValue = battleValue
          end
        else
          addValue = math.round(v.extraValue)
        end
      end
    end
    local geneExtraValue
    local needSplitGeneExtra = false
    local geneExtraInBaseValue = not battleInfoTpl:getHasGroup(attrEnumId) or not haveExtraId
    if isPetEquipped then
      geneExtraValue = self:getPetServerGeneExtraDisplayAttr(petGuid, attrEnumId, baseValue)
      needSplitGeneExtra = battleValue == nil and not math.isEmpty(geneExtraValue)
    else
      geneExtraValue = self:getPetGeneExtraDisplayAttr(petData, attrEnumId, baseValue)
      if petItem ~= nil and petItem:getPetAbilityLimited() and petInheritanceTpl:getTplByAttrId(attrEnumId) ~= nil then
        geneExtraValue = geneExtraValue * (1 - petItem:getPetAbilityAllAttriDecay() / 10000)
      end
      if geneExtraInBaseValue then
        needSplitGeneExtra = not math.isEmpty(geneExtraValue)
      else
        baseValue = math.round(stagePetPropBase or baseValue)
        addValue = tonumber(stagePetPropAdd) or 0
        needSplitGeneExtra = false
      end
    end
    if needSplitGeneExtra then
      if isPetEquipped then
        addValue = (addValue or 0) + geneExtraValue
      else
        if geneExtraValue > baseValue then
          geneExtraValue = baseValue
        end
        baseValue = baseValue - geneExtraValue
        addValue = (addValue or 0) + geneExtraValue
      end
    end
  end
  return baseValue, addValue
end

local SpecialExtraSpeedStatusAttrIdEnum = {
  [1039] = 1039,
  [1040] = 1040,
  [1041] = 1041,
  [1042] = 1042
}
local PlayerMountStatueToAttrIdEnum = {
  [L_Const.WorldMapPlayerMountStatusType.WMPMST_GROUND] = 1039,
  [L_Const.WorldMapPlayerMountStatusType.WMPMST_FLY] = 1040,
  [L_Const.WorldMapPlayerMountStatusType.WMPMST_WATER_SURFACE] = 1041,
  [L_Const.WorldMapPlayerMountStatusType.WMPMST_COUNT] = 1042
}

function this:getBattleStructPropertyNew(petGuid, petAttrMap)
  local petAtrrMap = petAttrMap or self:getPetPropertyMap(petGuid)
  local result = {}
  for arrtId, attrInfo in pairs(petAtrrMap) do
    local attrValue = attrInfo.baseValue + attrInfo.extraValue
    if battleInfoTpl:getHasGroup(arrtId) then
      local battInfoCfg = battleInfoTpl:getTplById(arrtId)
      local groupId = battleInfoTpl:getGroupId(battInfoCfg)
      local groupType = battleInfoTpl:getGroupType(battInfoCfg)
      if not result[groupId] then
        result[groupId] = {
          id = groupId,
          baseValue = 0,
          percent = 0,
          extraValue = 0
        }
      end
      local value = attrValue
      if groupType == 1 then
        result[groupId].baseValue = result[groupId].baseValue + attrInfo.baseValue
      elseif groupType == 2 then
        if battleInfoTpl:getIsRatio(battInfoCfg) == 1 then
          value = value / 10000
        end
        result[groupId].percent = result[groupId].percent + value
      elseif groupType == 3 then
        result[groupId].extraValue = result[groupId].extraValue + value
      end
    else
      local battInfoCfg = battleInfoTpl:getTplById(arrtId)
      if not result[arrtId] then
        result[arrtId] = {
          id = arrtId,
          baseValue = 0,
          percent = 0,
          extraValue = 0
        }
      end
      local value = attrValue
      result[arrtId].baseValue = result[arrtId].baseValue + value
      if SpecialExtraSpeedStatusAttrIdEnum[arrtId] then
        local mountStatus = L_PlayerStore:getMountStatus()
        local attrPropertId = PlayerMountStatueToAttrIdEnum[mountStatus]
        if attrPropertId and arrtId == attrPropertId then
          if battleInfoTpl:getIsRatio(battInfoCfg) == 1 then
            value = value / 10000
          end
          if not result[35] then
            result[35] = {
              id = 35,
              baseValue = 0,
              percent = 0,
              extraValue = 0
            }
          end
          result[35].percent = result[35].percent + value
          if not result[36] then
            result[36] = {
              id = 36,
              baseValue = 0,
              percent = 0,
              extraValue = 0
            }
          end
          result[36].percent = result[36].percent + value
        end
      end
    end
  end
  return table.toArray(result)
end

function this:getBattleStructProperty(baseValue, hobbyFactor, comprehension, heroInheritance, baseAttributeList, extraHeritance)
  local newValue = {}
  local index = {}
  local result = {}
  for i, v in ipairs(baseValue) do
    local attrEnumId = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    heroInheritance[i] = heroInheritance[i] or 0
    if battleInfoTpl:getHasGroup(attrEnumId) then
      local group = battleInfoTpl:getGroupById(attrEnumId)
      local basicId = battleInfoTpl:getAttrVal(group[1])
      local perId = battleInfoTpl:getAttrVal(group[2])
      local extraId = battleInfoTpl:getAttrVal(group[3])
      newValue[basicId] = 0
      newValue[perId] = 0
      newValue[extraId] = 0
      if battleInfoTpl:getIsRatio(battleInfoTpl:getTplById(attrEnumId)) == 0 then
        local data = v * hobbyFactor[i] * comprehension[i]
        newValue[basicId] = data
        newValue[extraId] = heroInheritance[i]
      else
        newValue[basicId] = v + hobbyFactor[i] * 100 + comprehension[i] * 100
        newValue[extraId] = heroInheritance[i]
      end
      table.insert(result, {
        id = attrEnumId,
        baseValue = math.round(newValue[basicId]),
        percent = newValue[perId],
        extraValue = math.round(newValue[extraId])
      })
    else
      local base, extra = 0
      if battleInfoTpl:getIsRatio(battleInfoTpl:getTplById(attrEnumId)) == 0 then
        base = v * hobbyFactor[i] * comprehension[i]
        extra = heroInheritance[i]
        newValue[attrEnumId] = base + extra
      else
        base = v + hobbyFactor[i] * 100 + comprehension[i] * 100
        extra = heroInheritance[i]
        newValue[attrEnumId] = base + extra
      end
      table.insert(result, {
        id = attrEnumId,
        baseValue = math.round(base),
        percent = 0,
        extraValue = math.round(extra)
      })
    end
    index[attrEnumId] = true
  end
  for i, v in pairs(baseAttributeList) do
    if not index[i] then
      table.insert(result, {
        id = i,
        baseValue = math.round(v),
        percent = 0,
        extraValue = math.round(extraHeritance[i] == nil and 0 or extraHeritance[i])
      })
      index[i] = true
    end
  end
  return result
end

function this:getInheritanceValue(heroGuid, attrVal, extraAttrVal, adjustment_1, adjustment_2, coefficient)
  local property = L_AttributeManager:getMergeHeroAtt(heroGuid)
  local _, baseValue, addValue = L_AttributeManager:getHeroAttSplitValue(property, attrVal)
  return math.floor((baseValue + adjustment_1 + addValue + adjustment_2) * coefficient)
end

function this:getHeroInheritanceAttr(heroData, favorLv)
  local inheritanceAttr = {}
  local coefficient = _petFavorabilityTpl:getLvEffect(favorLv) / 10000
  local heroGuid = L_HeroStore:getHeroGuid(heroData)
  for i = 1, #_petLearingEnumTpl:getAllEnum() do
    local attrId = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    local inheritance = petInheritanceTpl:getTplByAttrId(attrId)
    if inheritance ~= nil then
      if inheritance.attrVal == L_Const.battleAtt.ATK then
        inheritanceAttr[i] = self:getInheritanceValue(heroGuid, L_Const.battleAtt.ATK, L_Const.battleAtt.EXTRA_ATK, inheritance.adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_ATK).adjustment, coefficient)
      elseif inheritance.attrVal == L_Const.battleAtt.DEF then
        inheritanceAttr[i] = self:getInheritanceValue(heroGuid, L_Const.battleAtt.DEF, L_Const.battleAtt.EXTRA_DEF, inheritance.adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_DEF).adjustment, coefficient)
      elseif inheritance.attrVal == L_Const.battleAtt.MDEF then
        inheritanceAttr[i] = self:getInheritanceValue(heroGuid, L_Const.battleAtt.MDEF, L_Const.battleAtt.EXTRA_MDEF, inheritance.adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_MDEF).adjustment, coefficient)
      elseif inheritance.attrVal == L_Const.battleAtt.MAXHP then
        inheritanceAttr[i] = self:getInheritanceValue(heroGuid, L_Const.battleAtt.MAXHP, L_Const.battleAtt.EXTRA_MAXHP, inheritance.adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_MAXHP).adjustment, coefficient)
      else
        local value_1 = L_AttributeManager:getAttValueByHeroGuid(heroGuid, inheritance.attrVal)
        inheritanceAttr[i] = math.floor((value_1 + inheritance.adjustment) * coefficient)
      end
    end
  end
  return inheritanceAttr
end

function this:getExtraInheritanceAttr(heroData, finishGroup, favorLv)
  local inheritanceAttr = {}
  local coefficient = _petFavorabilityTpl:getLvEffect(favorLv) / 10000
  local heroGuid = L_HeroStore:getHeroGuid(heroData)
  for _, v in pairs(petInheritanceTpl:getAllData()) do
    local attrId = petInheritanceTpl:getAttrVal(v)
    if not finishGroup[attrId] then
      local value_1 = L_AttributeManager:getAttValueByHeroGuid(heroGuid, attrId)
      local adjustment = petInheritanceTpl:getAdjustment(v)
      inheritanceAttr[attrId] = math.floor((value_1 + adjustment) * coefficient)
    end
  end
  return inheritanceAttr
end

function this:getAttrInheritFromHero(heroInfo, favorLv)
  local attr = {}
  local coefficient = _petFavorabilityTpl:getLvEffect(favorLv) / 10000
  local heroGuid = L_HeroStore:getHeroGuid(heroInfo)
  for _, v in pairs(petInheritanceTpl:getAllData()) do
    local attrId = petInheritanceTpl:getAttrVal(v)
    if attrId ~= L_Const.battleAtt.EXTRA_ATK and attrId ~= L_Const.battleAtt.EXTRA_DEF and attrId ~= L_Const.battleAtt.EXTRA_MDEF and attrId ~= L_Const.battleAtt.EXTRA_MAXHP then
      local value = 0
      local adjustment = petInheritanceTpl:getAdjustment(v)
      if attrId == L_Const.battleAtt.ATK then
        value = self:getInheritanceValue(heroGuid, L_Const.battleAtt.ATK, L_Const.battleAtt.EXTRA_ATK, adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_ATK).adjustment, coefficient)
      elseif attrId == L_Const.battleAtt.DEF then
        value = self:getInheritanceValue(heroGuid, L_Const.battleAtt.DEF, L_Const.battleAtt.EXTRA_DEF, adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_DEF).adjustment, coefficient)
      elseif attrId == L_Const.battleAtt.MDEF then
        value = self:getInheritanceValue(heroGuid, L_Const.battleAtt.MDEF, L_Const.battleAtt.EXTRA_MDEF, adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_MDEF).adjustment, coefficient)
      elseif attrId == L_Const.battleAtt.MAXHP then
        value = self:getInheritanceValue(heroGuid, L_Const.battleAtt.MAXHP, L_Const.battleAtt.EXTRA_MAXHP, adjustment, petInheritanceTpl:getTplByAttrId(L_Const.battleAtt.EXTRA_MAXHP).adjustment, coefficient)
      else
        local value_1 = L_AttributeManager:getAttValueByHeroGuid(heroGuid, attrId)
        value = math.floor((value_1 + adjustment) * coefficient)
      end
      attr[attrId] = value
    end
  end
  return attr
end

function this:getPetGeneValue(petGene, lockState)
  local totalGeneValue = 0
  local gene = petGene or {}
  for i, v in pairs(gene) do
    local index = math.ceil(v.pos / 2)
    local lock = lockState < index and true or false
    if not lock then
      local petDnaTpl = petDna:getTplById(v.gene_id)
      local rarity = petDna:getRarity(petDnaTpl)
      totalGeneValue = totalGeneValue + v.gene_lv * rarity
    end
  end
  return totalGeneValue
end

function this:judgePetHasSpecialGene(petGuid)
  local petItem = self:getPetItem(petGuid)
  if not petItem then
    return false
  end
  return petItem:hasFlashGene()
end

function this:getPetGradeNew(petGuid)
  local petItem = self:getPetItem(petGuid)
  if not petItem then
    return 0, 0
  end
  local totalScore = petItem:getPetGrade()
  local petCfg = petInfoTpl:getTplById(petItem.id)
  local petRank = petCfg and petInfoTpl:getPetStage(petCfg) or 1
  local petRare = petCfg and petCfg.petrare or 0
  local gradeRank = self:calGradeRank(totalScore, petRank, petRare)
  return totalScore, gradeRank
end

function this:calGradeRank(totalScore, petRank, petRare)
  local minScore = gameConstTpl:getData("PET_GRADE_SCORE_MIN", L_Const.GameTplType.int)
  totalScore = math.max(totalScore, minScore)
  local allGradeRank = petGradeTpl:getAllData()
  local group = {}
  for i, v in ipairs(allGradeRank) do
    if v.petRank == petRank and v.petRare == petRare then
      table.insert(group, v)
    end
  end
  table.sort(group, function(a, b)
    return a.grade[1] < b.grade[1]
  end)
  local gradeRank = 1
  for i, v in ipairs(group) do
    if totalScore >= v.grade[1] and totalScore <= v.grade[2] then
      gradeRank = i
      break
    end
  end
  return gradeRank
end

function this:getPetGrade(pet, baseAttributeList)
  local totalScore = 0
  local petCfg = petInfoTpl:getTplById(pet.id)
  local isSpecial = pet.isSpecialPet and pet:isSpecialPet() or pet.special
  totalScore = totalScore + petInfoTpl:getGradeScore(petCfg, isSpecial)
  local petGradeAttrScore = gameConstTpl:getData("PET_GRADE_ATTR_SCORE", L_Const.GameTplType.dict_int_int)
  for attrId, v in pairs(petGradeAttrScore) do
    local battleInfoCfg = battleInfoTpl:getTplById(attrId)
    local value = baseAttributeList[attrId] or 0
    value = 0 < battleInfoTpl:getIsRatio(battleInfoCfg) and value / 10000 or value
    if attrId == 8 then
      value = 1 <= value and value - 1 or 0
    end
    totalScore = totalScore + value * (v / 10000)
  end
  local petGradeAttrEleBattleInfoScore = gameConstTpl:getData("PET_GRADE_ATTR_ELE_BATTLEINFO_ID", L_Const.GameTplType.list_int)
  local ratio = gameConstTpl:getData("PET_GRADE_ATTR_ELE_SCORE", L_Const.GameTplType.int)
  for _, attrId in ipairs(petGradeAttrEleBattleInfoScore) do
    local battleInfoCfg = battleInfoTpl:getTplById(attrId)
    local value = baseAttributeList[attrId] or 0
    value = 0 < battleInfoTpl:getIsRatio(battleInfoCfg) and value / 10000 or value
    totalScore = totalScore + value * (ratio / 10000)
  end
  local petGene = pet.gene_infos
  if pet.gene_infos then
    for i, v in pairs(petGene) do
      local petDnaTpl = petDna:getTplById(v.gene_id)
      totalScore = totalScore + petDna:getGradeScore(petDnaTpl)
    end
  end
  totalScore = math.floor(totalScore)
  local minScore = gameConstTpl:getData("PET_GRADE_SCORE_MIN", L_Const.GameTplType.int)
  totalScore = math.max(totalScore, minScore)
  local allGradeRank = petGradeTpl:getAllData()
  local gradeRank = 1
  for i, v in ipairs(allGradeRank) do
    if totalScore >= v.grade[1] and totalScore <= v.grade[2] then
      gradeRank = v.id
      break
    end
  end
  return totalScore, gradeRank
end

function this:getPetOriginalCost(petCfgId)
  local tempTpl = templateValueTpl:getTplById(petCfgId)
  if tempTpl == nil then
    errorf("奇波配置不存在" .. tostring(petCfgId))
    return 0
  end
  return templateValueTpl:getPetBaseAttribute(tempTpl)[L_Const.kiBoDuelEnum.petCost] or 0
end

function this:getRangeValueComprehension(is_small, standardValue, comprehension)
  local comprehensionList = {}
  local comprehensionSortList = {}
  local comprehensionTbl = comprehensionToTable(comprehension)
  for i = 1, #comprehensionTbl do
    local enumNum = _petLearingEnumTpl:getEnumNum(_petLearingEnumTpl:getTplById(i))
    for _, k in ipairs(comprehensionTbl) do
      if k.attr_id == enumNum then
        comprehensionSortList[i] = k
        break
      end
    end
  end
  local index = standardValue
  if 9 <= standardValue then
    index = 9
  elseif standardValue < 1 then
    index = 1
  end
  if is_small == false then
    for i = 1, #comprehensionSortList do
      local enumData = _petLearingEnumTpl:getTplByEnumId(comprehensionSortList[i].attr_id)
      local comprehensionRangeList = petLearningAblityTpl:getTplByEnumId(enumData.id)
      for k = 1, #comprehensionRangeList - (index - 1) do
        if comprehensionSortList[i].value <= comprehensionRangeList[k].range[2] and comprehensionSortList[i].value > comprehensionRangeList[k].range[1] then
          table.insert(comprehensionList, {
            value = comprehensionSortList[i].value,
            attr_id = comprehensionSortList[i].attr_id,
            rankId = comprehensionRangeList[k].id
          })
          break
        end
      end
    end
  else
    for i = 1, #comprehensionSortList do
      local enumData = _petLearingEnumTpl:getTplByEnumId(comprehensionSortList[i].attr_id)
      local comprehensionRangeList = petLearningAblityTpl:getTplByEnumId(enumData.id)
      for k = 1 + (#comprehensionRangeList - (index - 1)), #comprehensionRangeList do
        if comprehensionSortList[i].value <= comprehensionRangeList[k].range[2] and comprehensionSortList[i].value > comprehensionRangeList[k].range[1] then
          table.insert(comprehensionList, {
            value = comprehensionSortList[i].value,
            attr_id = comprehensionSortList[i].attr_id,
            rankId = comprehensionRangeList[k].id
          })
          break
        end
      end
    end
  end
  table.sort(comprehensionList, function(a, b)
    return a.value > b.value
  end)
  return comprehensionList
end

function this:getGeneComponentIcon(type, color)
  if type == 1 then
    return 0 < color and self.data.beta_bgIcon[color] or "Pages/Pet/tex_pet_frame_onebg"
  elseif type == 2 then
    return 0 < color and self.data.alpha_bgIcon[color] or "Pages/Pet/tex_pet_frame_twobg"
  elseif type == 3 then
    return 0 < color and self.data.link_bgIcon[color] or "Pages/Pet/tex_pet_dec_line"
  end
end

function this:getSaveBoxIndexKey()
  local pId = L_PlayerStore:getPlayerId()
  local key = string.format(self.saveKey.save_curBoxIndex, pId)
  local val = C_PlayerPrefsUtility.GetInt(key)
  return val
end

local petVoiceFormatStr = "Play_QVO_System_%s_%s"

function this:playPetVoiceSound(petId, type)
  return L_AudioUtil.playSound(string.format(petVoiceFormatStr, petId, type))
end

function this:clearFlyMsg()
  while true do
    local data = AzurWorld.FlymsgManager:PopFlymsg("petEvolution_flyMsg")
    if data == nil then
      return
    end
  end
end

function this:playEvolutionTimeline(guid)
  local pet = self:getPetItem(guid)
  local oldSkillInfo = self:getPetSkills(pet, false, false, true)
  local oldPetData = table.clone(pet)
  local data = {u64 = guid}
  self:req_changeRankUpPet(data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      L_CatalogStore:_triggerCommonGetPet(pet)
      L_UI:open("pagePetEvo", {
        guid = guid,
        prePetData = oldPetData,
        oldSkillInfo = oldSkillInfo
      })
    end
  end)
end

function this:openPagePetEvoTip(petGuid)
  local petItem = L_PetStore:getPetItem(petGuid)
  if petItem == nil then
    return
  end
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(petItem.id)
  local levelNeed = rankData.levelNeed
  local levelNotMatch = levelNeed == nil or levelNeed > petItem.lv
  
  local function checkPetHasEvoItemConfig(inRankData)
    local costItems = inRankData.rankBreakthroughItem or {}
    for i = 1, #costItems do
      local itemInfo = costItems[i]
      local itemId
      if #itemInfo == 2 then
        itemId = itemInfo[1]
      elseif #itemInfo == 3 then
        itemId = itemInfo[2]
      end
      if not math.isEmpty(itemId) then
        return true
      end
    end
    return false
  end
  
  local hasEvoItemConfig = checkPetHasEvoItemConfig(rankData)
  local previewData = {
    reqData = {u64 = petGuid},
    petGuid = petGuid,
    petItem = petItem,
    rankData = rankData,
    nextPetId = rankData.nextPetId,
    levelNeed = rankData.levelNeed,
    levelNotMatch = levelNotMatch,
    hasEvoItemConfig = hasEvoItemConfig,
    evoItemList = rankData.rankBreakthroughItem or {}
  }
  L_UI:open("pagePetEvoTip", previewData)
end

function this:refreshPetEntityGuidToEntityId(bAdd, guid, entityId)
  if not bAdd then
    self.data.petEntityGuidToEntityId[guid] = nil
    return
  end
  self.data.petEntityGuidToEntityId[guid] = entityId
end

function this:getPetEntityId(guid)
  return self.data.petEntityGuidToEntityId[guid]
end

function this:checkIsEggHatch(eggUid)
  local eggInfo = L_PetStore:getPetEggItem(eggUid)
  if eggInfo and eggInfo.hatch_state == 0 then
    return false
  end
  return true
end

function this:getPetGeneMutationNewSaveKey(uid)
  return string.format("%s_%s_%s", L_PlayerStore:getPlayerId(), "petGeneMutationNew", uid)
end

function this:getPetGeneMutationNewSaveKeyByPos(uid, pos)
  return string.format("%s_%s_%s_%s", L_PlayerStore:getPlayerId(), "petGeneMutationNew", uid, pos)
end

function this:checkIsNewGene(uid, pos)
  return C_PlayerPrefsUtility.GetInt(self:getPetGeneMutationNewSaveKeyByPos(uid, pos)) == pos + 1
end

function this:getCsPetData(petGuid)
  csHomeManager = csHomeManager or AzurWorld.HomeMgr
  csPetStore = csPetStore or csHomeManager:GetPetStore()
  return csPetStore:GetPet(petGuid)
end

function this:getPetConfigId(csPetData)
  return csPetData.configId
end

function this:getPetLaborInfoList(csPetData)
  local laborInfoList = {}
  local csLaborInfoList = csPetData:GetLaborInfoList()
  for i = 0, csLaborInfoList.Count - 1 do
    local csLaborInfo = csLaborInfoList[i]
    local laborInfo = {}
    laborInfo.laborId = csLaborInfo.laborId
    laborInfo.laborGrade = csLaborInfo.laborGrade
    laborInfo.upperLaborGrade = csLaborInfo.upperLaborGrade
    table.insert(laborInfoList, laborInfo)
  end
  return laborInfoList
end

function this:getPetTalentIdList(csPetData)
  local talentIdList = {}
  local csTalentIds = csPetData.talentIds
  for i = 0, csTalentIds.Count - 1 do
    table.insert(talentIdList, csTalentIds[i])
  end
  return talentIdList
end

function this:getPetIsFreeWork(csPetData)
  if csPetData then
    return csPetData:GetIsInHomeHub()
  end
  return false
end

function this:getPetIsDesignated(csPetData)
  return csPetData:GetIsStationLock()
end

function this:getPetSatietyVal(csPetData)
  return csPetData:GetSatietyVal()
end

function this:getPetWorkPause(csPetData)
  return csPetData:GetWorkPause()
end

function this:getPetCanteenId(csPetData)
  return csPetData:GetCanteenId()
end

function this:getWorkBuildingGuid(csPetData)
  return csPetData:GetWorkBuildingGuid()
end

function this:getPetAutoWorkStatus(csPetData)
  return csPetData:GetAutoWorkState()
end

function this:getPetIsWorking(csPetData)
  return csPetData:IsWorking()
end

function this:getBoxIsLock(boxId)
  if not self.data.lockBoxIds then
    return false
  end
  return table.indexOf(self.data.lockBoxIds, boxId) ~= false
end

function this:getLockBoxIds()
  return self.data.lockBoxIds
end

function this:getRecommendPetList(heroConfigId)
  local tpl = _heroTpl:getTplById(heroConfigId)
  if not tpl then
    return {}
  end
  local petTable = _heroTpl:getHeroRecommendPet(tpl)
  if not petTable then
    return {}
  end
  local ownedPetList = self:getPetList()
  local ownedByConfigId = {}
  for _, pet in pairs(ownedPetList) do
    local cfgId = pet:petCfgId()
    if not ownedByConfigId[cfgId] then
      ownedByConfigId[cfgId] = {}
    end
    table.insert(ownedByConfigId[cfgId], pet)
  end
  local result = {}
  for type, petIdList in pairs(petTable) do
    for _, petConfigId in ipairs(petIdList) do
      local petCfg = petInfoTpl:getTplById(petConfigId)
      local ownedPets = ownedByConfigId[petConfigId]
      if ownedPets and not table.isEmpty(ownedPets) then
        for _, pet in ipairs(ownedPets) do
          table.insert(result, {
            petConfigId = petConfigId,
            type = type,
            name = petCfg and petInfoTpl:getName(petCfg) or "",
            petIcon = petCfg and petInfoTpl:getPetIcon(petCfg) or "",
            guid = pet.guid,
            lv = pet.lv,
            rank = pet.rank,
            grade = pet.grade
          })
        end
      end
    end
  end
  return result
end

function this:canUpgradeStarSoul(petGuid)
  local pet = L_PetStore:getPetItem(petGuid)
  if pet == nil then
    return false
  end
  local petTpl = petInfoTpl:getTplById(pet.petId)
  local templateId = petInfoTpl:getStarsoulId(petTpl)
  local starSoulTpl = _petStarSoulTpl:getTplByStageNode(templateId, pet.stage, pet.node)
  if not starSoulTpl or not petTpl then
    return false
  end
  local maxStage = _petStarSoulTpl:getMaxStage(templateId)
  if maxStage <= pet.stage then
    return false
  end
  local condition = _petStarSoulTpl:getUnlockCondition(starSoulTpl)
  if not L_ConditionManager:singleIsComplete(condition) then
    return false
  end
  local itemId = petInfoTpl:getStarsoulItem(petTpl)
  local itemNum = _petStarSoulTpl:getCostKiBoNum(starSoulTpl)
  if itemId and itemNum then
    local curCnt = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, itemId)
    if itemNum > curCnt then
      return false
    end
  end
  local costItemList = L_DataUtil.parseRewardConfig(_petStarSoulTpl:getCost(starSoulTpl))
  if costItemList and not table.isEmpty(costItemList) then
    for _, reward in pairs(costItemList) do
      local curCnt = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId)
      if curCnt < reward.itemNum then
        return false
      end
    end
  end
  return true
end

function this:checkPetHasDeviantGene(guid, limitCount, excludeGenePos)
  if not guid then
    return false
  end
  local petItem = self:getPetItem(guid)
  if not petItem then
    return false
  end
  local geneSkills = self:getPetSkills(petItem, true, true, false)
  if not geneSkills then
    return false
  end
  local deviantCount = 0
  for i, gene in ipairs(geneSkills) do
    if excludeGenePos and gene.genePos == excludeGenePos then
    elseif self:isDeviantGene(gene.geneId) then
      deviantCount = deviantCount + 1
    end
  end
  return limitCount <= deviantCount
end

function this:isDeviantGene(geneId)
  if not geneId then
    return false
  end
  local dnaTpl = petDna:getTplById(geneId)
  return dnaTpl ~= nil and petDna:getNestCoopTag(dnaTpl) == 1
end

function this:getShiningPetDnaRarity()
  return 6
end

function this:isInnateGene(genePos, geneId)
  if genePos ~= 1 then
    return false
  end
  if not geneId then
    return true
  end
  local dnaTpl = petDna:getTplById(geneId)
  return dnaTpl ~= nil and petDna:getTalentDnaType(dnaTpl) == 1
end

function this:getGeneDisplayName(skillName, genePos, change, geneId)
  if change then
    skillName = skillName or ""
    genePos = genePos or ""
    if self:isInnateGene(genePos, geneId) then
      return L_Lang:get(L_WordsTpl:getValue("ui_pet_talentdna_text1"), {
        [0] = skillName
      })
    end
    return skillName
  end
  return skillName
end

function this:getPetCatalogInfo(petId)
  local catalogInfo = L_CatalogStore:getPetCatalogByPetId(petId)
  if catalogInfo then
    local curTask = catalogInfo.tasks and catalogInfo.tasks[1] or nil
    local curTaskId = curTask and curTask.task_id or nil
    if not curTaskId then
      C_MJLog.LogError("pet id: " .. tostring(petId) .. " no data")
      return 0, 0
    end
    local curNum = curTask.count
    local maxTaskId = self:_getMaxTaskId(curTaskId)
    local maxTaskCond = _iconographyTaskTpl:getTplById(maxTaskId).taskcondition or {}
    local maxNum = maxTaskCond[4] or 0
    return curNum, maxNum
  else
    return 0, 0
  end
end

function this:_getMaxTaskId(taskId)
  if _iconographyTaskTpl:getTplById(taskId).nextTaskId ~= 0 then
    return self:_getMaxTaskId(_iconographyTaskTpl:getTplById(taskId).nextTaskId)
  else
    return taskId
  end
end

function this:getIsSpecial(petGuid)
  local petData = L_PetStore:getPetItem(petGuid)
  return petData:getIsSpecialPet()
end

function this:getIsFlash(petGuid)
  local petData = L_PetStore:getPetItem(petGuid)
  return petData:hasFlashGene()
end

function this:getIsColor(petGuid)
  local petData = L_PetStore:getPetItem(petGuid)
  return petData:isStarColorPet()
end

return this
