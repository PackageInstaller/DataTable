_class("PreviewChainSkillRangeComponent", Object)
PreviewChainSkillRangeComponent = PreviewChainSkillRangeComponent

function PreviewChainSkillRangeComponent:Constructor()
  self._enablePreviewChainSkillRange = false
  self._flashChainSkill = true
  self._curPreviewTypeIndex = 0
  self._previewMaxTime = 1000
  self._curTypeViewStartTime = 0
  self._chainSkillRangeOutlineEntityDic = ChainSkillRangeOutlineEntityDic:New()
  self._petSingleEntityDic = {}
  self._snipeEffectEntityDic = {}
  self._addHPPetDic = {}
  self._previewAttackElementType = {}
  self._previewPetID = {}
  self._previewTypeList = {}
end

function PreviewChainSkillRangeComponent:EnablePreviewChainSkillRange(enable)
  self._enablePreviewChainSkillRange = enable
end

function PreviewChainSkillRangeComponent:GetPreviewChainSkillRangeEnable()
  return self._enablePreviewChainSkillRange
end

function PreviewChainSkillRangeComponent:ResetPreviewChainSkillData()
  self._flashChainSkill = true
  self._curPreviewTypeIndex = 0
  self._curTypeViewStartTime = 0
end

function PreviewChainSkillRangeComponent:GetChainSkillRangeOutlineDic()
  return self._chainSkillRangeOutlineEntityDic
end

function PreviewChainSkillRangeComponent:IsFlashChainSkillRange()
  return self._flashChainSkill
end

function PreviewChainSkillRangeComponent:SetChainSkillRangeFlash(isFlashRange)
  self._flashChainSkill = isFlashRange
end

function PreviewChainSkillRangeComponent:GetPreviewTypeIndex()
  return self._curPreviewTypeIndex
end

function PreviewChainSkillRangeComponent:SetPreviewTypeIndex(previewTypeIndex)
  self._curPreviewTypeIndex = previewTypeIndex
end

function PreviewChainSkillRangeComponent:GetPreviewShowTime()
  return self._previewMaxTime
end

function PreviewChainSkillRangeComponent:GetPreviewStartTime()
  return self._curTypeViewStartTime
end

function PreviewChainSkillRangeComponent:SetPreviewStartTime(previewStartTime)
  self._curTypeViewStartTime = previewStartTime
end

function PreviewChainSkillRangeComponent:GetChainSkillRangeCount()
  return self._chainSkillRangeOutlineEntityDic:GetChainSkillOutlineEntityCount()
end

function PreviewChainSkillRangeComponent:GetChainSkillSingleEntityDic()
  return self._petSingleEntityDic
end

function PreviewChainSkillRangeComponent:AddChainSkillSingleEntityDic(previewIndex, entityID)
  if not self._petSingleEntityDic[previewIndex] then
    self._petSingleEntityDic[previewIndex] = {}
  end
  table.insert(self._petSingleEntityDic[previewIndex], entityID)
end

function PreviewChainSkillRangeComponent:GetChainSkillAddHPPetDic()
  return self._addHPPetDic
end

function PreviewChainSkillRangeComponent:AddChainSkillAddHPPetDic(previewIndex, entityID)
  self._addHPPetDic[previewIndex] = entityID
end

function PreviewChainSkillRangeComponent:CheckPreviewIndexData(previewIndex, previewType)
  if not previewType then
    return false
  end
  if previewType == PreviewChainSkillType.Range then
    if not self._chainSkillRangeOutlineEntityDic:HasPreviewIndex(previewIndex) then
      return false
    end
  elseif previewType == PreviewChainSkillType.SingleEntity then
    if not self._petSingleEntityDic[previewIndex] then
      return false
    end
  elseif previewType == PreviewChainSkillType.AddHP then
    if not self._addHPPetDic[previewIndex] then
      return false
    end
  elseif previewType == PreviewChainSkillType.RangeAndSingleEntity then
    if not self._chainSkillRangeOutlineEntityDic:HasPreviewIndex(previewIndex) then
      return false
    end
    if not self._petSingleEntityDic[previewIndex] then
      return false
    end
  end
  return true
end

function PreviewChainSkillRangeComponent:GetPreviewChainSkillTypeByPreviewIndex(previewIndex)
  if self:CheckPreviewIndexData(previewIndex, self._previewTypeList[previewIndex]) then
    return self._previewTypeList[previewIndex]
  end
  return PreviewChainSkillType.None
end

function PreviewChainSkillRangeComponent:SetPreviewTypeByPreviewIndex(previewIndex, previewType)
  self._previewTypeList[previewIndex] = previewType
end

function PreviewChainSkillRangeComponent:HasSnipeEffect(entityID)
  if self._snipeEffectEntityDic[entityID] then
    return true
  else
    return false
  end
end

function PreviewChainSkillRangeComponent:AddSnipeEffect(masterEntityID, effectEntity)
  self._snipeEffectEntityDic[masterEntityID] = effectEntity
end

function PreviewChainSkillRangeComponent:GetSnipeEffectList()
  return self._snipeEffectEntityDic
end

function PreviewChainSkillRangeComponent:GetPreviewChainSkillSingleEffectList(previewIndex)
  local targetEntityList = self._petSingleEntityDic[previewIndex]
  local effectEntityList = {}
  for i, id in ipairs(targetEntityList) do
    local effectEntity = self._snipeEffectEntityDic[id]
    table.insert(effectEntityList, effectEntity)
  end
  return effectEntityList
end

function PreviewChainSkillRangeComponent:GetChainSkillAddHPPetEntityID(previewIndex)
  return self._addHPPetDic[previewIndex]
end

function PreviewChainSkillRangeComponent:AddChainSkillAttackElementType(previewIndex, elementType)
  self._previewAttackElementType[previewIndex] = elementType
end

function PreviewChainSkillRangeComponent:GetChainSkillAttackElementType(previewIndex)
  return self._previewAttackElementType[previewIndex]
end

function PreviewChainSkillRangeComponent:ClearPreviewChainSkill()
  self._addHPPetDic = {}
  self._petSingleEntityDic = {}
  self._snipeEffectEntityDic = {}
  self._previewAttackElementType = {}
  self._previewPetID = {}
  self._previewTypeList = {}
end

function PreviewChainSkillRangeComponent:HasPreviewChainSkillData()
  if self._chainSkillRangeOutlineEntityDic:GetChainSkillOutlineEntityCount() ~= 0 or next(self._petSingleEntityDic) or next(self._addHPPetDic) then
    return true
  else
    return false
  end
end

function PreviewChainSkillRangeComponent:AddPreviewPetID(previewIndex, petEntityID)
  self._previewPetID[previewIndex] = petEntityID
end

function PreviewChainSkillRangeComponent:GetPreviewPetID(previewIndex)
  return self._previewPetID[previewIndex]
end

function Entity:PreviewChainSkillRange()
  return self:GetComponent(self.WEComponentsEnum.PreviewChainSkillRange)
end

function Entity:HasPreviewChainSkillRange()
  return self:HasComponent(self.WEComponentsEnum.PreviewChainSkillRange)
end

function Entity:AddPreviewChainSkillRange()
  local index = self.WEComponentsEnum.PreviewChainSkillRange
  local component = PreviewChainSkillRangeComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewChainSkillRange()
  local index = self.WEComponentsEnum.PreviewChainSkillRange
  local component = PreviewChainSkillRangeComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewChainSkillRange()
  if self:HasPreviewChainSkillRange() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewChainSkillRange)
  end
end

local PreviewChainSkillType = {
  None = 0,
  Range = 1,
  SingleEntity = 2,
  AddHP = 3,
  RangeAndSingleEntity = 4
}
_enum("PreviewChainSkillType", PreviewChainSkillType)
