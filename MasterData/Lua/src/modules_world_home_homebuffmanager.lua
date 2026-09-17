local this = class("homeBuffManager", G_EventManagerBase)
this:importPartialClass(require(L_R.world.home .. "homeBuffManagerEffect"))
this:importPartialClass(require(L_R.world.home .. "homeBuffManagerCondition"))
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _HomeBuffTpl = L_GameTpl:getHomeBuffTpl()
local _TechTpl = L_GameTpl:getHomeTechnologyTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _domainTpl = L_GameTpl:getDomainTpl()
local _homeBuildingBuffWorldTpl = L_GameTpl:getHomeBuildingBuffWorldTpl()
local _homeLaborEfficiencyTpl = L_GameTpl:getHomeLaborEfficiencyTpl()

function this:ctor()
  this.super.ctor(self)
  self._testBuffs = {}
end

local GetBuffParam = {
  petGuid = 0,
  talentIds = {},
  onlyPermanent = false
}
local rawBuffData = {
  buffId = 0,
  conditions = {},
  buffValue = 0,
  buffParams = {},
  buffSource = {},
  desc = nil
}

function this:getBuff(buffId, conditions, params)
  conditions = conditions or {}
  params = params or {}
  local buffData = self:_getInitBuff(buffId, conditions)
  local buffTpl = _HomeBuffTpl:getTplById(buffId)
  if not buffTpl then
    errorf("配了不存在的buff" .. buffId)
    return 0
  end
  buffData = self:_mergeBuffValue(buffData, self:_getBuff_Test(buffId, conditions))
  if params.petGuid and params.petGuid ~= 0 and not params.isProduct then
    buffData = self:_mergeBuffValue(buffData, self:_getBuff_Pet(buffId, conditions, {
      params.petGuid
    }))
  elseif params.petGuids and not params.isProduct then
    buffData = self:_mergeBuffValue(buffData, self:_getBuff_Pet(buffId, conditions, params.petGuids))
  end
  if params.talentIds then
    buffData = self:_mergeBuffValue(buffData, self:_getBuff_PetTalent(buffId, conditions, params.talentIds))
  end
  buffData = self:_mergeBuffValue(buffData, self:_getBuff_Science(buffId, conditions))
  return buffData
end

function this:_getInitBuff(buffId, conditions)
  local buffData = {
    buffId = buffId,
    conditions = conditions,
    buffValue = 0,
    buffParams = {},
    buffSource = {},
    desc = ""
  }
  return buffData
end

function this:_getBuff_Test(buffId, conditions)
  local valueList = {}
  for _, buff in pairs(self._testBuffs) do
    if buff.buffId == buffId and self:_checkBuffCondition(conditions, buff.conditions) then
      table.insert(valueList, buff.params)
    end
  end
  return {valueList = valueList}
end

local GetPetBuffLog = {}
local PetTalentId2BuffIdList = {}
local PetLaborId2BuffIdList = {}

function this:_getBuff_Pet(buffId, conditions, petGuids)
  local buffTpl = _HomeBuffTpl:getTplById(buffId)
  local valueList = {}
  local sourceTalentId, sourcePetGuid, sourceLaborId
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_HomeStore = C_HomeManager:GetHomeStore()
  for _, petGuid in pairs(petGuids) do
    local C_PetData = C_PetStore:GetPet(petGuid)
    if L_CommonUtil.isValid(C_PetData) then
      table.clear(PetTalentId2BuffIdList)
      for i = 0, C_PetData.talentIds.Count - 1 do
        local talentId = C_PetData.talentIds[i]
        local talentTpl = _HomeTalentTpl:getTplById(talentId)
        local buffs, params, buffCondition, isOr = _HomeTalentTpl:getBuffInfo(talentTpl)
        PetTalentId2BuffIdList[talentId] = buffs
        for i = 1, #buffs do
          if buffs[i] == buffId and self:_checkBuffCondition(conditions, buffCondition, isOr) then
            table.insert(valueList, params[i])
            sourceTalentId = talentId
            sourcePetGuid = petGuid
          end
        end
      end
      local workBuildGuid = C_PetData.workBuild or -1
      local C_LaborInfoList = C_PetData:GetLaborInfoList()
      local homeBuildData = C_HomeManager:GetHomeStore():GetBuildData(workBuildGuid)
      local C_HomeRanchDataDic = C_HomeManager:GetHomeStore().HomeRanchDataDic
      local laborTypeOfBuild
      if L_CommonUtil.isValid(homeBuildData) then
        local buildId = homeBuildData.buildId
        local buildingTpl = _homeBuildingTpl:getTplById(buildId)
        local buildingGroup = _homeBuildingTpl:getGroupId(buildingTpl)
        if buildingGroup == L_HomeConst.HomeBuildingGroupIdType.GENG_ZUO_XIAO_WU then
          local auto = homeBuildData.auto
          local plantPetGuid, waterPetGuid, harvestPetGuid
          if auto then
            plantPetGuid = auto.plantPetGuid
            waterPetGuid = auto.waterPetGuid
            harvestPetGuid = auto.harvestPetGuid
          end
          if plantPetGuid and plantPetGuid == petGuid then
            laborTypeOfBuild = L_HomeConst.HomeLaborId.GENG_ZUO
          elseif waterPetGuid and waterPetGuid == petGuid then
            laborTypeOfBuild = L_HomeConst.HomeLaborId.JIAO_SHUI
          elseif harvestPetGuid and harvestPetGuid == petGuid then
            laborTypeOfBuild = L_HomeConst.HomeLaborId.GENG_ZUO
          end
        else
          local homeBuildingProductionTpl = _homeBuildingProductionTpl:getTplById(buildId)
          laborTypeOfBuild = _homeBuildingProductionTpl:getLaborType(homeBuildingProductionTpl)
        end
      else
        for _, homeRanchData in pairs(C_HomeRanchDataDic) do
          if homeRanchData.harvestPetGuid == petGuid then
            laborTypeOfBuild = L_HomeConst.HomeLaborId.ZHAO_LIAO
          end
        end
      end
      if laborTypeOfBuild then
        table.clear(PetLaborId2BuffIdList)
        for i = 0, C_LaborInfoList.Count - 1 do
          local C_LaborInfo = C_LaborInfoList[i]
          local laborId = C_LaborInfo.laborId
          if self:checkIsLaborIdMatchBuild(laborId, laborTypeOfBuild) then
            local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
            local buffIdListOfLabor = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)
            PetLaborId2BuffIdList[laborId] = buffIdListOfLabor
            for _, buffIdOfLabor in pairs(buffIdListOfLabor) do
              if buffIdOfLabor == buffId then
                local laborGrade = C_LaborInfo.laborGrade
                local buffValue = self:getLaborBuffValue(laborId, laborGrade, buffIdOfLabor)
                table.insert(valueList, {buffValue})
                sourcePetGuid = petGuid
                sourceLaborId = laborId
              end
            end
          end
        end
      end
    end
  end
  local tempBuffData = self:_getInitBuff(buffId, conditions)
  tempBuffData = self:_mergeBuffValue(tempBuffData, {valueList = valueList})
  local source = {
    petGuid = sourcePetGuid,
    talentId = sourceTalentId,
    laborId = sourceLaborId,
    buff = tempBuffData
  }
  GetPetBuffLog.buffId = buffId
  GetPetBuffLog.petGuid = petGuids[1]
  GetPetBuffLog.buffValueList = valueList
  GetPetBuffLog.PetTalentId2BuffIdList = PetTalentId2BuffIdList
  GetPetBuffLog.PetLaborId2BuffIdList = PetLaborId2BuffIdList
  GetPetBuffLog.sourceTalentId = sourceTalentId
  GetPetBuffLog.sourceLaborId = sourceLaborId
  printf("获取宠物buff", GetPetBuffLog)
  return {valueList = valueList, source = source}
end

function this:checkIsLaborIdMatchBuild(laborId, laborTypeOfBuild)
  if type(laborTypeOfBuild) == "number" then
    return laborId == laborTypeOfBuild
  end
  if type(laborTypeOfBuild) == "table" then
    for _, laborIdOfBuild in pairs(laborTypeOfBuild) do
      if laborId == laborIdOfBuild then
        return true
      end
    end
  end
  return false
end

function this:_getBuff_PetTalent(buffId, conditions, talentIds)
  local buffTpl = _HomeBuffTpl:getTplById(buffId)
  local valueList = {}
  for _, talentId in ipairs(talentIds) do
    local talentTpl = _HomeTalentTpl:getTplById(talentId)
    local buffs, params, buffCondition, isOr = _HomeTalentTpl:getBuffInfo(talentTpl)
    for i = 1, #buffs do
      if buffs[i] == buffId and self:_checkBuffCondition(conditions, buffCondition, isOr) then
        table.insert(valueList, params[i])
      end
    end
  end
  return {valueList = valueList}
end

local ScienceBuffLog = {}

function this:_getBuff_Science(buffId, conditions)
  local buffTpl = _HomeBuffTpl:getTplById(buffId)
  local valueList = {}
  local techId = 0
  local ids = L_TechnologyStore:getAllCurTechnologyList()
  for _, id in ipairs(ids) do
    local tpl = _TechTpl:getTplById(id)
    local buffIds, buffParams, buffCondition, isOr = _TechTpl:getBuffInfo(tpl)
    if self:_checkBuffCondition(conditions, buffCondition, isOr) then
      for i = 1, #buffIds do
        if buffIds[i] == buffId then
          table.insert(valueList, buffParams[i])
          techId = math.max(techId, id)
        end
      end
    end
  end
  local tempBuffData = self:_getInitBuff(buffId, conditions)
  tempBuffData = self:_mergeBuffValue(tempBuffData, {valueList = valueList})
  if techId ~= 0 then
    ScienceBuffLog.buffId = buffId
    ScienceBuffLog.homeTechnologyId = techId
    ScienceBuffLog.valueList = valueList
    C_MJLog.LogInfo(string.format("获取科技buff-> buffId:%d, 家园科技id:%d", buffId, techId), C_ELogModule.Home)
  else
    C_MJLog.LogInfo("获取科技buff 没有科技使该buff生效", C_ELogModule.Home)
  end
  return {
    valueList = valueList,
    source = {techId = techId, buff = tempBuffData}
  }
end

function this:_mergeBuffValue(buffData, target, mergeType)
  local values
  local buffTpl = _HomeBuffTpl:getTplById(buffData.buffId)
  local mergeType = mergeType or _HomeBuffTpl:getAlgorithmType(buffTpl)
  local valueType = _HomeBuffTpl:getType(buffTpl)
  if valueType == L_HomeConst.buffValueType.PERCENT then
    values = {}
    for i = 1, #(target.valueList or {}) do
      values[i] = table.clone(target.valueList[i])
      values[i][1] = values[i][1] / 10000
    end
  else
    values = target.valueList or {}
  end
  if mergeType == L_HomeConst.buffMergeType.ADD then
    for _, v in ipairs(values) do
      buffData.buffValue = buffData.buffValue + v[1]
    end
  elseif mergeType == L_HomeConst.buffMergeType.BOOL then
    for _, v in ipairs(values) do
      buffData.buffValue = buffData.buffValue + v[1]
    end
  elseif mergeType == L_HomeConst.buffMergeType.SKILL then
    for _, param in ipairs(values) do
      table.insert(buffData.buffParams, param)
    end
  elseif mergeType == L_HomeConst.buffMergeType.REPLACE then
    for _, v in ipairs(values) do
      buffData.buffValue = math.max(buffData.buffValue + v[1])
    end
  elseif mergeType == L_HomeConst.buffMergeType.ADD_MUL then
    for _, v in ipairs(values) do
      buffData.buffValue = (1 + buffData.buffValue) * (1 + v[1]) - 1
    end
  elseif mergeType == L_HomeConst.buffMergeType.MINUS_MUL then
    for _, v in ipairs(values) do
      buffData.buffValue = 1 - (1 - buffData.buffValue) * (1 - v[1])
    end
  elseif mergeType == L_HomeConst.buffMergeType.MIN then
    for _, v in ipairs(values) do
      if buffData.buffValue == 0 then
        buffData.buffValue = v[1]
      else
        buffData.buffValue = math.min(buffData.buffValue, v[1])
      end
    end
  end
  if target.source then
    table.insert(buffData.buffSource, target.source)
  end
  return buffData
end

function this:_checkBuffCondition(condtions, tplConditions, isOr)
  if isOr then
    for _, oneCondition in ipairs(tplConditions) do
      if not math.isEmpty(oneCondition[1]) and condtions[oneCondition[1]] == oneCondition[2] then
        return true
      end
    end
    return false
  else
    for _, oneCondition in ipairs(tplConditions) do
      if not math.isEmpty(oneCondition[1]) and condtions[oneCondition[1]] ~= oneCondition[2] then
        return false
      end
    end
    return true
  end
end

function this:getDisplayValue(buffId, buffParsedValue, noDecimal)
  local buffTpl = _HomeBuffTpl:getTplById(buffId)
  local valueType = _HomeBuffTpl:getType(buffTpl)
  if valueType == L_HomeConst.buffValueType.NORMAL then
    return tostring(buffParsedValue)
  elseif valueType == L_HomeConst.buffValueType.PERCENT then
    if noDecimal then
      local showBuffValue = buffParsedValue * 100
      local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
      local showBuffValueFloatPart = showBuffValue % 1 - showBuffValue % 1 % 0.1
      showBuffValue = showBuffValueIntPart + showBuffValueFloatPart
      return string.format("%s%%", showBuffValue)
    else
      return string.format("%s%%", buffParsedValue * 100)
    end
  elseif valueType == L_HomeConst.buffValueType.TIME then
    return L_TimeUtil.secondToString(buffParsedValue)
  elseif valueType == L_HomeConst.buffValueType.PET_CAPTURE then
    local captureDivide = L_GameConstTpl:getData("KIBO_CAPTURE_COEFFICIENT_POINT", L_Const.GameTplType.list_int)
    if buffParsedValue < captureDivide[1] then
      return L_WordsTpl:getValue("KIBO_CAPTURE_COEFFICIENT_LOW_TEXT")
    elseif buffParsedValue < captureDivide[2] then
      return L_WordsTpl:getValue("KIBO_CAPTURE_COEFFICIENT_MEDIUM_TEXT")
    else
      return L_WordsTpl:getValue("KIBO_CAPTURE_COEFFICIENT_HIGH_TEXT")
    end
  end
end

local LaborBuffId2ValueGetFunc = {
  [L_HomeConst.buffId.PRODUCT_REDUCE_TIME_PERCENT] = "getTimeReduct",
  [L_HomeConst.buffId.CROP_SEED_SAVE_PROB] = "getSeedRecycle",
  [L_HomeConst.buffId.CROP_HARVEST_SEED_HARVEST] = "getSeedHarvest",
  [L_HomeConst.buffId.CROP_REDUCE_TIME_PERCENT] = "getWaterTimeReduct",
  [L_HomeConst.buffId.ACCESSORY_REDUCE_TIME_PERCENT] = "getAccessoryTimeReduct",
  [L_HomeConst.buffId.COLLECT_REDUCE_TIME_PERCENT] = "getGatherTimeReduct",
  [L_HomeConst.buffId.EGG_REDUCE_TIME_PERCENT] = "getEggTimeReduct",
  [L_HomeConst.buffId.RANCH_REDUCE_TIME_PERCENT] = "getPastureTimeReduct"
}

function this:getLaborBuffValue(laborId, laborGrade, buffId)
  local buffValue = 0
  if LaborBuffId2ValueGetFunc[buffId] ~= nil then
    local tpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
    if not tpl then
      C_MJLog.LogError("[家园工种buff] homeLaborEfficiencyTpl没有此评分配置: " .. laborGrade, C_ELogModule.Home)
      return buffValue
    end
    buffValue = _homeLaborEfficiencyTpl[LaborBuffId2ValueGetFunc[buffId]](_homeLaborEfficiencyTpl, tpl)
    C_MJLog.LogInfo(string.format("[家园工种buff] homeLaborEfficiency value计算->工种id:%d, 工种评分:%d, buffId:%d, 最终计算数值:%f", laborId, laborGrade, buffId, buffValue), C_ELogModule.Home)
    return buffValue
  end
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local buffValueParameter = 2000
  buffValue = math.floor(2.05 * (laborGrade / 100 - 0.01) * (laborGrade / 100 - 0.01) * buffValueParameter + buffValueParameter)
  C_MJLog.LogInfo(string.format("[家园工种buff] 常规value计算->工种id:%d, 工种评分:%d, buffId:%d, 最终计算数值:%f", laborId, laborGrade, buffId, buffValue), C_ELogModule.Home)
  return buffValue
end

function this:getWildBuffBuildList()
  local list = {}
  local C_HomeManager = AzurWorld.HomeMgr
  local C_WildBuffBuildStore = C_HomeManager:GetWildBuffBuildStore()
  local buffBuildList = C_WildBuffBuildStore:OnGetHadBuildBuffBuildIdList()
  local count = buffBuildList.Count
  for i = 0, count - 1 do
    local buffBuildId = buffBuildList[i]
    local tpl = _homeBuildingBuffWorldTpl:getTplById(buffBuildId)
    local buffList = _homeBuildingBuffWorldTpl:getCurBuffList(tpl)
    for _, value in ipairs(buffList) do
      local buffId = value.buffId
      local buffParam = value.buffParam
      local buffCondition = value.buffCondition
      local conditions = {}
      for m = 1, #buffCondition, 2 do
        conditions[buffCondition[m]] = buffCondition[m + 1]
      end
      local desc = value.desc
      local isSameBuff = false
      for _, buffData in ipairs(list) do
        if buffData.buffId == buffId then
          local originCondition = buffData.conditions
          isSameBuff = self:_checkBuffCondition(originCondition, conditions)
          if isSameBuff then
            self:_mergeBuffValue(buffData, {
              valueList = {buffParam}
            })
            break
          end
        end
      end
      if not isSameBuff then
        local buffData = self:_getInitBuff(buffId, conditions)
        buffData.desc = desc
        self:_mergeBuffValue(buffData, {
          valueList = {buffParam}
        })
        table.insert(list, buffData)
      end
    end
  end
  return list
end

function this:getWildBuffBuildDataByBuffId(buffId, buffCondition)
  local buffData
  local C_HomeManager = AzurWorld.HomeMgr
  local C_WildBuffBuildStore = C_HomeManager:GetWildBuffBuildStore()
  local buffBuildList = C_WildBuffBuildStore:OnGetHadBuildBuffBuildIdList()
  local count = buffBuildList.Count
  for i = 0, count - 1 do
    local buffBuildId = buffBuildList[i]
    local tpl = _homeBuildingBuffWorldTpl:getTplById(buffBuildId)
    local buffList = _homeBuildingBuffWorldTpl:getCurBuffList(tpl)
    for _, value in ipairs(buffList) do
      local isSameBuff = false
      local conditions
      if buffId == value.buffId then
        conditions = {}
        for m = 1, #value.buffCondition, 2 do
          conditions[value.buffCondition[m]] = value.buffCondition[m + 1]
        end
        isSameBuff = self:_checkBuffCondition(buffCondition, conditions)
      end
      if isSameBuff then
        if buffData ~= nil then
          buffData = self:_mergeBuffValue(buffData, {
            valueList = {
              value.buffParam
            }
          })
        else
          buffData = self:_getInitBuff(buffId, conditions)
          buffData = self:_mergeBuffValue(buffData, {
            valueList = {
              value.buffParam
            }
          })
        end
      end
    end
  end
  return buffData
end

function this:getIsHadWildBuffBuild(collectionId, needDefaultBuffBuildId)
  local C_HomeManager = AzurWorld.HomeMgr
  local C_WildBuffBuildStore = C_HomeManager:GetWildBuffBuildStore()
  local isHadBuild = C_WildBuffBuildStore:OnIsHadBuildByCollectId(collectionId)
  local buildId = 0
  if isHadBuild then
    buildId = C_WildBuffBuildStore:OnGetBuffBuildIdByCollectId(collectionId)
  elseif needDefaultBuffBuildId then
    buildId = C_WildBuffBuildStore:OnGetInitBuffBuildIdByCollectId(collectionId)
  end
  return isHadBuild, buildId
end

return this
