local module = class("modulePetBoxAttrInfo", G_UIModuleBase)
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local RADAR_OFFSET_KEY_PREFIX = {
  "_InnerOffset",
  "_MiddleOffset"
}
local PREVIEW_MIDDLE_COLOR = C_Color(0.7019607843137254, 0.7686274509803922, 0.9294117647058824, 1)
local _PreviewRadarTweenDuration = 0.4
local _BaseRadarTweenDuration = 0.5
local RADAR_SLOT_BY_ENUM_INDEX = {
  0,
  5,
  4,
  3,
  2,
  1
}

local function clamp01(value)
  if value == nil then
    return 0
  end
  if value < 0 then
    return 0
  end
  if 1 < value then
    return 1
  end
  return value
end

local function applyAttrModuleData(attrModule, data, abilityLimit, petConfigId)
  if attrModule == nil or attrModule.bind == nil then
    return
  end
  if attrModule.setData then
    attrModule:setData(data, abilityLimit, petConfigId)
  end
end

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    moduleAttr1 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    },
    moduleAttr2 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    },
    moduleAttr3 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    },
    moduleAttr4 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    },
    moduleAttr5 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    },
    moduleAttr6 = {
      moduleName = "pages/pet/new/cellAttrItemPetTalent"
    }
  }
end

function module.methods()
  return {
    onClick_attrDetail = function(self)
      self:showAttrDetail()
    end
  }
end

function module:created(...)
  module.super.created(self, ...)
  self:_initRadarMaterial()
end

function module:open()
end

function module:close()
  self:_killPreviewRadarTween()
  self:_killBaseRadarTween()
  self:_setPreviewRadarVisible(false)
end

function module:destroy()
  self:_destroyRadarMaterial()
end

function module:setGuid(petGuid, isKiboArena)
  local pet = L_PetStore:getPetItem(petGuid)
  self.pet = pet
  self._previewAttrMap = {}
  self._previewDisplayMiddle = nil
  self:_killPreviewRadarTween()
  if math.isEmpty(pet) then
    self._propertyData = nil
    self._abilityLimit = false
    self._petConfigId = nil
    self._baseRadarOffsets = nil
    self._curPetGuid = nil
    self:_killBaseRadarTween()
    for i = 1, 6 do
      applyAttrModuleData(self.modules["moduleAttr" .. tostring(i)], nil, false, nil)
    end
    self:_setHexagonRadar({
      inner = {},
      middle = {}
    })
    self:_setPreviewRadarVisible(false)
    return
  end
  local sixDimList = L_PetStore:getPetComprehensionSixDimLevel(pet)
  local innateRatioMap = {}
  local currentRatioMap = {}
  for _, dim in ipairs(sixDimList) do
    innateRatioMap[dim.enumId] = clamp01((dim.initLevel or 0) / 9)
    currentRatioMap[dim.enumId] = clamp01((dim.currentLevel or 0) / 9)
  end
  local radarOffsets = {
    inner = {},
    middle = {}
  }
  for _, dim in ipairs(sixDimList) do
    local enumId = dim.enumId
    if enumId ~= nil then
      radarOffsets.inner[enumId] = innateRatioMap[enumId] or 0
      radarOffsets.middle[enumId] = currentRatioMap[enumId] or 0
    end
  end
  local property
  if not math.isEmpty(pet.hero_id) and not isKiboArena then
    property = L_PetStore:getPetProperty(pet, nil, nil, nil)
  else
    property = L_PetStore:getPetOriginalProperty(pet, nil, nil, isKiboArena)
  end
  local petGuid = pet.guid
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for i, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local enumDetailTpl = petLearningEnumTpl:getTplByEnumId(enumId)
    local dim = sixDimList[i]
    local comprehensionValue = dim and dim.comprehensionValue or 0
    local currentLevel = dim and dim.currentLevel or 0
    local initLevel = dim and dim.initLevel or 0
    local totalVal = L_PetStore:getPetAttFinalValue(property, enumId, petGuid)
    local valueText = battleInfoTpl:getShowTxtComma(enumId, totalVal)
    table.insert(propertyData, {
      attrIcon = enumDetailTpl and petLearningEnumTpl:getNewIcon(enumDetailTpl) or "",
      colorIcon = enumDetailTpl and petLearningEnumTpl:getIconColor(enumDetailTpl) or "",
      value = valueText,
      name = enumDetailTpl and petLearningEnumTpl:getName(enumDetailTpl) or "",
      attrEnumId = enumId,
      attrEnumTplId = petLearningEnumTpl:getId(v),
      comprehensionValue = comprehensionValue,
      currentLevel = currentLevel,
      initLevel = initLevel
    })
  end
  local abilityLimit = pet:getPetAbilityLimited()
  self._propertyData = propertyData
  self._abilityLimit = abilityLimit
  self._petConfigId = pet.id
  local oldOffsets = self._baseRadarOffsets
  local oldPetGuid = self._curPetGuid
  self._curPetGuid = petGuid
  self._baseRadarOffsets = radarOffsets
  self:_applyPropertyDataToCells()
  local needsTween = false
  if oldPetGuid == petGuid and oldOffsets and oldOffsets.middle then
    for enumId, newVal in pairs(radarOffsets.middle) do
      local oldVal = oldOffsets.middle[enumId] or 0
      if newVal > oldVal + 1.0E-4 then
        needsTween = true
        break
      end
    end
  end
  if needsTween then
    self:_killPreviewRadarTween()
    self._previewDisplayMiddle = nil
    self:_setPreviewRadarVisible(false)
    self:_playRadarTween(true, radarOffsets.inner, oldOffsets.middle, radarOffsets.middle)
  else
    self:_killBaseRadarTween()
    self:_setHexagonRadar(self._baseRadarOffsets)
  end
  self:_applyPreviewRadarOffsets()
end

function module:setPreviewPropertyDeltaMap(previewMap)
  self._previewAttrMap = previewMap or {}
  self:_applyPropertyDataToCells()
  self:_applyPreviewRadarOffsets()
end

function module:_buildPreviewRadarTargetOffsets()
  local inner = {}
  local middle = {}
  local hasPreview = false
  for enumId, value in pairs(self._baseRadarOffsets.middle or {}) do
    inner[enumId] = value
    middle[enumId] = value
  end
  if not table.isEmpty(self._propertyData) then
    for _, data in ipairs(self._propertyData) do
      local enumId = data.attrEnumId
      local previewInfo = self._previewAttrMap and self._previewAttrMap[enumId]
      local targetLevel = previewInfo and previewInfo.targetLevel
      local curLevel = data.currentLevel or 0
      if targetLevel and targetLevel > curLevel then
        hasPreview = true
        middle[enumId] = clamp01(targetLevel / 9)
      end
    end
  end
  return inner, middle, hasPreview
end

function module:_applyPreviewRadarOffsets()
  if table.isEmpty(self._baseRadarOffsets) then
    self:_killPreviewRadarTween()
    self._previewDisplayMiddle = nil
    self:_setPreviewRadarVisible(false)
    return
  end
  local inner, middle, hasPreview = self:_buildPreviewRadarTargetOffsets()
  if not hasPreview then
    self:_killPreviewRadarTween()
    self._previewDisplayMiddle = nil
    self:_setPreviewRadarVisible(false)
    return
  end
  self:_initPrevireMaterial()
  if self.previewRadarMaterial == nil then
    return
  end
  self:_setPreviewRadarVisible(true)
  self.previewRadarMaterial:SetColor("_MiddleColor", PREVIEW_MIDDLE_COLOR)
  local fromMiddle = {}
  for enumId, toVal in pairs(middle) do
    local displayed = self._previewDisplayMiddle and self._previewDisplayMiddle[enumId]
    fromMiddle[enumId] = displayed or inner[enumId] or toVal
  end
  local needsTween = false
  for enumId, toVal in pairs(middle) do
    if toVal > (fromMiddle[enumId] or 0) + 1.0E-4 then
      needsTween = true
      break
    end
  end
  if needsTween then
    self:_playRadarTween(false, inner, fromMiddle, middle)
  else
    self:_killPreviewRadarTween()
    self:_applyPreviewRadarMaterial(inner, middle)
    self:_syncPreviewDisplayMiddle(middle)
  end
end

function module:_setPreviewRadarVisible(visible)
  if self.previewRadarImage == nil and self.bindComponents then
    self.previewRadarImage = self.bindComponents.imgPreviewRadarRenderer
  end
  if self.previewRadarImage ~= nil then
    self.previewRadarImage.gameObject:SetActive(visible)
  end
end

function module:_applyPropertyDataToCells()
  if table.isEmpty(self._propertyData) then
    return
  end
  for i = 1, 6 do
    local data = self._propertyData[i]
    if data then
      local previewInfo = self._previewAttrMap and self._previewAttrMap[data.attrEnumId]
      local previewDelta = previewInfo and previewInfo.delta
      data.previewDelta = previewDelta and 0 < previewDelta and previewDelta or nil
      local targetLevel = previewInfo and previewInfo.targetLevel
      local curLevel = data.currentLevel or 0
      data.previewTargetLevel = targetLevel and targetLevel > curLevel and targetLevel or nil
    end
    local attrModule = self.modules["moduleAttr" .. tostring(i)]
    applyAttrModuleData(attrModule, data, self._abilityLimit, self._petConfigId)
  end
end

function module:showAttrDetail()
  local pet = self.pet
  if math.isEmpty(pet) then
    return
  end
  L_UI:open("pageProperty", {
    petData = pet,
    detailId = L_Const.propertyDetail.kiBo
  })
end

function module:_initRadarMaterial()
  if self.radarImage == nil and self.bindComponents then
    self.radarImage = self.bindComponents.imgRadarRenderer
  end
  if self.radarImage == nil then
    return
  end
  if self._originalRadarMaterial == nil then
    self._originalRadarMaterial = self.radarImage.sharedMaterial or self.radarImage.material
  end
  if self._originalRadarMaterial == nil then
    return
  end
  if self.radarMaterial ~= nil then
    return
  end
  self.radarMaterial = C_UnityObject.Instantiate(self._originalRadarMaterial)
  self.radarImage.material = self.radarMaterial
end

function module:_initPrevireMaterial()
  if self.previewRadarImage == nil and self.bindComponents then
    self.previewRadarImage = self.bindComponents.imgPreviewRadarRenderer
  end
  if self.previewRadarImage == nil then
    return
  end
  if self._originalRadarMaterial == nil then
    return
  end
  if self.previewRadarMaterial ~= nil then
    return
  end
  self.previewRadarMaterial = C_UnityObject.Instantiate(self._originalRadarMaterial)
  self.previewRadarImage.material = self.previewRadarMaterial
end

function module:_destroyRadarMaterial()
  self:_killPreviewRadarTween()
  self:_killBaseRadarTween()
  if self.radarMaterial then
    if self.radarImage and self._originalRadarMaterial then
      self.radarImage.material = self._originalRadarMaterial
    end
    C_UnityObject.Destroy(self.radarMaterial)
    self.radarMaterial = nil
  end
  if self.previewRadarMaterial then
    if self.previewRadarImage and self._originalRadarMaterial then
      self.previewRadarImage.material = self._originalRadarMaterial
    end
    C_UnityObject.Destroy(self.previewRadarMaterial)
    self.previewRadarMaterial = nil
  end
end

function module:_setHexagonRadarOnMaterial(material, offsets)
  if material == nil then
    return
  end
  material:SetFloat("_GlobalAlpha", 1)
  material:DisableKeyword("_GROWTH_ON")
  local innerOffsets = offsets and offsets.inner or {}
  local middleOffsets = offsets and offsets.middle or {}
  local allEnum = petLearningEnumTpl:getAllEnum(true)
  for i = 1, 6 do
    local enumTpl = allEnum[i]
    local enumId = enumTpl and petLearningEnumTpl:getEnumNum(enumTpl)
    local innerOffsetValue = enumId and innerOffsets[enumId] or 0
    local middleOffsetValue = enumId and middleOffsets[enumId] or 0
    local slotIndex = RADAR_SLOT_BY_ENUM_INDEX[i] or i - 1
    local innerKey = RADAR_OFFSET_KEY_PREFIX[1] .. tostring(slotIndex)
    local middleKey = RADAR_OFFSET_KEY_PREFIX[2] .. tostring(slotIndex)
    material:SetFloat(innerKey, clamp01(innerOffsetValue))
    material:SetFloat(middleKey, clamp01(middleOffsetValue))
  end
end

function module:_setHexagonRadar(offsets)
  self:_initRadarMaterial()
  if self.radarMaterial == nil then
    return
  end
  self:_setHexagonRadarOnMaterial(self.radarMaterial, {
    inner = offsets and offsets.inner or {},
    middle = offsets and offsets.middle or {}
  })
end

function module:_applyPreviewRadarMaterial(inner, middle)
  if self.previewRadarMaterial == nil then
    return
  end
  self:_setHexagonRadarOnMaterial(self.previewRadarMaterial, {inner = inner, middle = middle})
end

function module:_syncPreviewDisplayMiddle(middle)
  self._previewDisplayMiddle = {}
  for enumId, value in pairs(middle or {}) do
    self._previewDisplayMiddle[enumId] = value
  end
end

function module:_getPreviewRadarTweenCurve()
  local curveHolder = self.bindComponents and self.bindComponents.previewRadarCurveHolder
  if curveHolder ~= nil and curveHolder.curves ~= nil and curveHolder.curves.Count > 0 then
    return curveHolder.curves[0]
  end
  return nil
end

function module:_killPreviewRadarTween()
  if self._previewRadarTween then
    self._previewRadarTween:Kill()
    self._previewRadarTween = nil
  end
end

function module:_killBaseRadarTween()
  if self._baseRadarTween then
    self._baseRadarTween:Kill()
    self._baseRadarTween = nil
  end
end

function module:_playRadarTween(isBase, inner, fromMiddle, toMiddle)
  if isBase then
    self:_killBaseRadarTween()
    self:_initRadarMaterial()
    if self.radarMaterial == nil then
      return
    end
  else
    self:_killPreviewRadarTween()
  end
  local duration = isBase and _BaseRadarTweenDuration or _PreviewRadarTweenDuration
  
  local function getter()
    return 0
  end
  
  local function setter(t)
    local currentMiddle = {}
    for enumId, toVal in pairs(toMiddle) do
      local fromVal = fromMiddle[enumId] or not isBase and inner[enumId] or 0
      if toVal > fromVal then
        currentMiddle[enumId] = fromVal + (toVal - fromVal) * t
      else
        currentMiddle[enumId] = toVal
      end
    end
    if isBase then
      self:_setHexagonRadarOnMaterial(self.radarMaterial, {inner = inner, middle = currentMiddle})
    else
      self:_applyPreviewRadarMaterial(inner, currentMiddle)
      self:_syncPreviewDisplayMiddle(currentMiddle)
    end
  end
  
  local tween = DOTween.To(getter, setter, 1, duration)
  local curve = self:_getPreviewRadarTweenCurve()
  if curve ~= nil then
    tween:SetEase(curve)
  else
    tween:SetEase(Tweening.Ease.OutQuad)
  end
  tween:OnComplete(function()
    if isBase then
      self._baseRadarTween = nil
      self:_setHexagonRadar(self._baseRadarOffsets)
    else
      self._previewRadarTween = nil
      self:_applyPreviewRadarMaterial(inner, toMiddle)
      self:_syncPreviewDisplayMiddle(toMiddle)
    end
  end)
  if isBase then
    self._baseRadarTween = tween
  else
    self._previewRadarTween = tween
  end
end

return module
