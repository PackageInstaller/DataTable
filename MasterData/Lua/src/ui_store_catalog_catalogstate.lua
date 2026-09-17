local this = {}
local _petTpl = L_GameTpl:getPetTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _iconographyLevelTpl = L_GameTpl:getIconographyLevelTpl()

function this:init()
  this.super.init(self)
  self.data = {
    petCatalogMap = {},
    setHasInitSync = false,
    setCatalogHasInitSync = false,
    petCatalog = {},
    petAttr = {},
    petElementAttr = {},
    catalogFlyReadyCnt = false,
    readyTipInfo = nil,
    redDotDict = {},
    cachedPetCatalogNew = {},
    waitGetRewardInfo = {},
    canGetReward = false
  }
end

function this:getAllCatalog()
  return self.data
end

function this:getHasInitSync()
  return self.data.setHasInitSync
end

function this:getPetCatalog()
  return self.data.petCatalogMap or {}
end

function this:isGetPet(petId)
  return self.data.petCatalogMap[petId] and self.data.petCatalogMap[petId] > 0
end

function this:getPetCatalogByPetId(petId)
  if not petId then
    return
  end
  return self.data.petCatalog[petId]
end

function this:getPetIdSurveycoefficient(petId)
  local petCatalogData = self:getPetCatalogByPetId(petId) or {}
  local level = petCatalogData.lv or 1
  local _prevLevelTpl = _iconographyLevelTpl:getTplByLvPetId(level, petId)
  local value = _iconographyLevelTpl:getSurveycoefficient(_prevLevelTpl)
  return value
end

function this:getElementLv(eId)
  if not eId then
    return 0
  end
  local result = 0
  for petId, petInfo in pairs(self.data.petCatalog) do
    local targetPetTpl = _petTpl:getTplById(petId)
    if targetPetTpl then
      local mainElement = _petTpl:getFirstElement(targetPetTpl)
      if mainElement == eId then
        result = result + (petInfo.lv or 0)
      end
    else
      C_MJLog.LogError("pet config petId not found: " .. tostring(petId))
    end
  end
  return result
end

function this:getPetAllAttr(petId)
  local result = {}
  for attrId, attrVal in pairs(self.data.petAttr[petId] or {}) do
    if not result[attrId] then
      result[attrId] = 0
    end
    result[attrId] = result[attrId] + attrVal
  end
  local mainElement = _petTpl:getFirstElement(_petTpl:getTplById(petId))
  for attrId, valDict in pairs(self.data.petElementAttr[mainElement] or {}) do
    if not result[attrId] then
      result[attrId] = 0
    end
    for _, val in pairs(valDict) do
      result[attrId] = result[attrId] + val
    end
  end
  return result
end

function this:getElementAllAttr(eId)
  local result = {}
  for attrId, valDict in pairs(self.data.petElementAttr[eId] or {}) do
    if not result[attrId] then
      result[attrId] = 0
    end
    for _, val in pairs(valDict) do
      result[attrId] = result[attrId] + val
    end
  end
  return result
end

function this:getAttrAddVal(petId, attrId)
  local all = self:getPetAllAttr(petId)
  local attrGroup = _battleInfoTpl:getGroupIdById(attrId)
  if attrGroup and attrGroup[1] then
    local result = 0
    for aId, v in pairs(all) do
      local aGroup = _battleInfoTpl:getGroupIdById(aId)
      if aGroup and aGroup[1] and aGroup[1] == attrGroup[1] and (aGroup[2] == 1 or aGroup[2] == 3) then
        result = result + v
      end
    end
    return result
  end
  if all and all[attrId] then
    return all[attrId]
  end
  return 0
end

function this:getHasNew()
  for petId, _ in pairs(self.data.petCatalog) do
    local key = "petCatalogNew" .. tostring(petId)
    if self.data.cachedPetCatalogNew[key] == nil then
      self.data.cachedPetCatalogNew[key] = L_CommonUtil.getLocalValue(key)
    end
    local _status = self.data.cachedPetCatalogNew[key]
    if tostring(self.data.cachedPetCatalogNew[key]) == "true" then
      return true
    end
  end
  return false
end

function this:getIsNew(petId)
  local key = "petCatalogNew" .. tostring(petId)
  if self.data.cachedPetCatalogNew[key] == nil then
    self.data.cachedPetCatalogNew[key] = L_CommonUtil.getLocalValue(key)
  end
  if tostring(self.data.cachedPetCatalogNew[key]) == "true" then
    return true
  end
  return false
end

return this
