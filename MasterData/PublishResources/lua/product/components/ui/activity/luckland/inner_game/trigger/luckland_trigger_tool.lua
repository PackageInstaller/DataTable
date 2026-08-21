_class("LuckLandTriggerTool", Singleton)
LuckLandTriggerTool = LuckLandTriggerTool

function LuckLandTriggerTool.Compare(compareType, count1, count2)
  if compareType == LuckLandTriggerCompareType.Less then
    return count1 < count2
  elseif compareType == LuckLandTriggerCompareType.LessEqual then
    return count1 <= count2
  elseif compareType == LuckLandTriggerCompareType.Equal then
    return count1 == count2
  elseif compareType == LuckLandTriggerCompareType.MoreThan then
    return count2 < count1
  elseif compareType == LuckLandTriggerCompareType.MoreThanEqual then
    return count2 <= count1
  end
  return false
end

function LuckLandTriggerTool.TagCheck(tagType, tagTypeParam, compareType, count, targetPet, distance)
  local petCount = 0
  local pets = LuckLandTriggerTool.GetPetsByTag(tagType, tagTypeParam)
  if pets and 0 < #pets then
    if targetPet and distance then
      for _, pet in pairs(pets) do
        if distance >= LuckLandTriggerTool.Distance(pet, targetPet) then
          petCount = petCount + 1
        end
      end
    else
      petCount = #pets
    end
  end
  return LuckLandTriggerTool.Compare(compareType, petCount, count)
end

function LuckLandTriggerTool.GetPetsByTag(tagType, tagTypeParam)
  local pets
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  if entityMgr then
    if tagType == LLPetTagType.Element then
      pets = entityMgr:GetFightPetsByElement(tagTypeParam)
    elseif tagType == LLPetTagType.Camp then
      pets = entityMgr:GetFightPetsByCamp(tagTypeParam)
    elseif tagType == LLPetTagType.Level then
      pets = entityMgr:GetFightPetsByLevel(tagTypeParam)
    elseif tagType == LLPetTagType.Res then
      pets = entityMgr:GetFightPetsByResType(tagTypeParam)
    elseif tagType == LLPetTagType.ElementOrCamp then
      local elementType = tagTypeParam[1]
      local campType = tagTypeParam[2]
      local elementPets = entityMgr:GetFightPetsByElement(elementType)
      local campPets = entityMgr:GetFightPetsByCamp(campType)
      if elementPets then
        pets = elementPets
      end
      if campPets then
        if pets then
          local function contain(pet)
            for _, _pet in pairs(pets) do
              if _pet:ID() == pet:ID() then
                return true
              end
            end
            return false
          end
          
          for _, petEntity in pairs(campPets) do
            if not contain(petEntity) then
              table.insert(pets, petEntity)
            end
          end
        else
          pets = campPets
        end
      end
    end
  end
  return pets
end

function LuckLandTriggerTool.CalcPetsRange(pets, targetPet, distance)
  for _, pet in pairs(pets) do
    if pet:ID() ~= targetPet:ID() and distance < LuckLandTriggerTool.Distance(pet, targetPet) then
      return false
    end
  end
  return true
end

function LuckLandTriggerTool.Distance(pet1, pet2)
  return math.abs(pet1:GetPos() - pet2:GetPos())
end

function LuckLandTriggerTool.CheckPetPos(posType, pet)
  local pos = pet:GetPos()
  if posType == LuckLandTriggerPosType.Morning then
    return table.icontains(LuckLandConst.MorningPosList, pos)
  elseif posType == LuckLandTriggerPosType.Midday then
    return table.icontains(LuckLandConst.MiddayPosList, pos)
  elseif posType == LuckLandTriggerPosType.Night then
    return table.icontains(LuckLandConst.NightPosList, pos)
  elseif posType == LuckLandTriggerPosType.Bag then
    return LuckLandInnerGameHelper.GetBackpackPetDataByID(pet:ID()) ~= nil
  end
  return false
end
