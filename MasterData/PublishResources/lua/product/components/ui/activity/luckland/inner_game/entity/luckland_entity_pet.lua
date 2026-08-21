_class("LLEntityPet", LuckLandEntity)
LLEntityPet = LLEntityPet

function LLEntityPet:InitData(templateID)
  self._entityType = LuckLandEntityType.Pet
  self._cfg = self._configMng:GetPetConfigData(templateID)
  self._resType = self._cfg:GetPetResType()
  self._resBase = self._cfg:GetPetResBase()
  self._levelType = self._cfg:GetPetLevel()
  self._elementType = self._cfg:GetPetType()
  self._campType = self._cfg:GetPetCamp()
  self._countDown = self._cfg:GetCountDown()
  self._isUnique = self._cfg:IsPetUnique()
end

function LLEntityPet:SetGenIndex(index)
  self._genIndex = index
end

function LLEntityPet:SetFightState(isFight)
  self._isFight = isFight
end

function LLEntityPet:IsFight()
  return self._isFight
end

function LLEntityPet:GetPos()
  return self._gameModule:GetEntityMng():GetFightPetPos(self)
end

function LLEntityPet:AddCountDownNum(addVal)
  if self._countDown == nil or addVal == nil then
    return
  end
  self._countDown = self._countDown + addVal
end

function LLEntityPet:HasDeleteFlag()
  return self._delFlag
end

function LLEntityPet:SetDeleteFlag()
  self._delFlag = true
end

function LLEntityPet:GetParamByTag(tagType)
  if tagType == LLPetTagType.Element then
    return self._elementType
  elseif tagType == LLPetTagType.Camp then
    return self._campType
  elseif tagType == LLPetTagType.Level then
    return self._levelType
  elseif tagType == LLPetTagType.Res then
    return self._resType
  end
end

function LLEntityPet:Element()
  return self._elementType
end

function LLEntityPet:Camp()
  return self._campType
end

function LLEntityPet:Level()
  return self._levelType
end

function LLEntityPet:ResType()
  return self._resType
end
