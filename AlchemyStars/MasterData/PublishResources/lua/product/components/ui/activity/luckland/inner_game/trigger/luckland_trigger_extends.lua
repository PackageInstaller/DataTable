require("luckland_trigger_base")
_class("LLTTNone", LuckLandTriggerBase)
LLTTNone = LLTTNone

function LLTTNone:IsSatisfied(notify)
  return false
end

_class("LLTTAlways", LuckLandTriggerBase)
LLTTAlways = LLTTAlways

function LLTTAlways:IsSatisfied(notify)
  return true
end

_class("LLTTProb", LuckLandTriggerBase)
LLTTProb = LLTTProb

function LLTTProb:IsSatisfied(notify)
  local prob = self._param[1]
  local r = math.random(1, 100)
  return prob > r
end

_class("LLTTPetIDCount", LuckLandTriggerBase)
LLTTPetIDCount = LLTTPetIDCount

function LLTTPetIDCount:IsSatisfied(notify)
  local templateID = self:GetTriggerParamByIndex(1)
  local compareType = self:GetTriggerParamByIndex(2)
  local count = self:GetTriggerParamByIndex(3)
  local petCount = 0
  if templateID then
    local pets = LuckLandInnerGameHelper.GetFightPetsDataByTemplateID(templateID)
    if pets then
      petCount = #pets
    end
  end
  return LuckLandTriggerTool.Compare(compareType, petCount, count)
end

_class("LLTTPetTagCount", LuckLandTriggerBase)
LLTTPetTagCount = LLTTPetTagCount

function LLTTPetTagCount:IsSatisfied(notify)
  local tagType = self:GetTriggerParamByIndex(1)
  local tagTypeParam = self:GetTriggerParamByIndex(2)
  local operateType = self:GetTriggerParamByIndex(3)
  local compareType = self:GetTriggerParamByIndex(4)
  local count = self:GetTriggerParamByIndex(5)
  if tagType and tagTypeParam and operateType and compareType and count then
    if tagType == LLPetTagType.ElementOrCamp then
      tagTypeParam = {}
      tagTypeParam[1] = self:GetTriggerParamByIndex(2)
      tagTypeParam[2] = self:GetTriggerParamByIndex(3)
      operateType = self:GetTriggerParamByIndex(4)
      compareType = self:GetTriggerParamByIndex(5)
      count = self:GetTriggerParamByIndex(6)
    end
    return LuckLandTriggerTool.TagCheck(tagType, tagTypeParam, compareType, count)
  end
  return false
end

_class("LLTTDisNPetTagCount", LuckLandTriggerBase)
LLTTDisNPetTagCount = LLTTDisNPetTagCount

function LLTTDisNPetTagCount:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if not entity then
    return
  end
  local tagType = self:GetTriggerParamByIndex(1)
  local tagTypeParam = self:GetTriggerParamByIndex(2)
  local operateType = self:GetTriggerParamByIndex(3)
  local compareType = self:GetTriggerParamByIndex(4)
  local count = self:GetTriggerParamByIndex(5)
  local distance = self:GetTriggerParamByIndex(6)
  if tagType and tagTypeParam and operateType and compareType and count then
    if tagType == LLPetTagType.ElementOrCamp then
      tagTypeParam = {}
      tagTypeParam[1] = self:GetTriggerParamByIndex(2)
      tagTypeParam[2] = self:GetTriggerParamByIndex(3)
      operateType = self:GetTriggerParamByIndex(4)
      compareType = self:GetTriggerParamByIndex(5)
      count = self:GetTriggerParamByIndex(6)
      distance = self:GetTriggerParamByIndex(7)
    end
    return LuckLandTriggerTool.TagCheck(tagType, tagTypeParam, compareType, count, entity, distance)
  end
  return false
end

_class("LLTTMonsterCount", LuckLandTriggerBase)
LLTTMonsterCount = LLTTMonsterCount

function LLTTMonsterCount:IsSatisfied(notify)
  local monsters = LuckLandInnerGameHelper.GetFightMonsterData()
  if monsters then
    local count = self:GetTriggerParamByIndex(1)
    return count < #monsters
  end
  return false
end

_class("LLTTPetPos", LuckLandTriggerBase)
LLTTPetPos = LLTTPetPos

function LLTTPetPos:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if entity and entity:GetEntityType() == LuckLandEntityType.Pet then
    local pos = entity:GetPos()
    if pos then
      local PosType = self:GetTriggerParamByIndex(1)
      if PosType then
        if PosType == LuckLandTriggerPosType.Morning then
          return table.icontains(LuckLandConst.MorningPosList, pos)
        elseif PosType == LuckLandTriggerPosType.Midday then
          return table.icontains(LuckLandConst.MiddayPosList, pos)
        elseif PosType == LuckLandTriggerPosType.Night then
          return table.icontains(LuckLandConst.NightPosList, pos)
        elseif PosType == LuckLandTriggerPosType.Bag then
          return LuckLandInnerGameHelper.GetBackpackPetDataByID(entity:ID()) ~= nil
        end
      end
    end
  end
  return false
end

_class("LLTTIsLeader", LuckLandTriggerBase)
LLTTIsLeader = LLTTIsLeader

function LLTTIsLeader:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if entity then
    local pos = entity:GetPos()
    if pos then
      return pos == LuckLandConst.MorningPosList[1]
    end
  end
  return false
end

_class("LLTTIsTail", LuckLandTriggerBase)
LLTTIsTail = LLTTIsTail

function LLTTIsTail:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if entity then
    local pos = entity:GetPos()
    if pos then
      local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
      if entityMgr then
        local fightPets = entityMgr:GetFightPets()
        if fightPets and 1 < #fightPets then
          local lastPet = fightPets[#fightPets]
          if lastPet then
            return pos == lastPet:GetPos()
          end
        end
      end
    end
  end
  return false
end

_class("LLTTIsSameElementLT", LuckLandTriggerBase)
LLTTIsSameElementLT = LLTTIsSameElementLT

function LLTTIsSameElementLT:IsSatisfied(notify)
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  if entityMgr then
    local fightPets = entityMgr:GetFightPets()
    if fightPets and 1 < #fightPets then
      local firstPet = fightPets[1]
      local lastPet = fightPets[#fightPets]
      if firstPet and lastPet then
        return firstPet:Element() == lastPet:Element()
      end
    end
  end
  return false
end

_class("LLTTIsElementTriplet", LuckLandTriggerBase)
LLTTIsElementTriplet = LLTTIsElementTriplet

function LLTTIsElementTriplet:IsSatisfied(notify)
  local module = LuckLandInnerGameHelper.GetLuckLandGameModule()
  if module then
    local mgr = module:GetEntityMng()
    if mgr then
      local fightPets = mgr:GetFightPets()
      if fightPets then
        local elements = {}
        for _, petEntity in ipairs(fightPets) do
          local element = petEntity:Element()
          local pos = petEntity:GetPos()
          if not elements[element] then
            elements[element] = {}
          end
          table.insert(elements[element], pos)
        end
        for _, posList in pairs(elements) do
          if 3 <= #posList then
            local linkCount = 1
            local prePos = posList[1]
            for i = 2, #posList do
              if posList[i] - prePos == 1 then
                linkCount = linkCount + 1
              elseif linkCount < 3 then
                linkCount = 1
              end
              prePos = posList[i]
              if 3 <= linkCount then
                return true
              end
            end
          end
        end
      end
    end
  end
  return false
end

_class("LLTTIsDeletingSelf", LuckLandTriggerBase)
LLTTIsDeletingSelf = LLTTIsDeletingSelf

function LLTTIsDeletingSelf:IsSatisfied(notify)
  local params = notify:GetNotifyParams()
  if not LLNTDeletePet:IsInstanceOfType(notify) or not params then
    return false
  end
  local notifyEntity = notify:GetNotifyEntity()
  local isSelf = self._param[1]
  if isSelf == LuckLandTriggerIsSelf.True then
    return notifyEntity == params[1]
  elseif isSelf == LuckLandTriggerIsSelf.False then
    return notifyEntity ~= params[1]
  end
  return false
end

_class("LLTTElementCount", LuckLandTriggerBase)
LLTTElementCount = LLTTElementCount

function LLTTElementCount:IsSatisfied(notify)
  local compareType = self:GetTriggerParamByIndex(1)
  local count = self:GetTriggerParamByIndex(2)
  local elementCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  if entityMgr then
    local elementTable = {}
    local fightPets = entityMgr:GetFightPets()
    if fightPets then
      for _, pet in pairs(fightPets) do
        if not table.icontains(elementTable, pet:Element()) then
          table.insert(elementTable, pet:Element())
        end
      end
    end
    elementCount = #elementTable
  end
  return LuckLandTriggerTool.Compare(compareType, elementCount, count)
end

_class("LLTTPosHasPet", LuckLandTriggerBase)
LLTTPosHasPet = LLTTPosHasPet

function LLTTPosHasPet:IsSatisfied(notify)
  local posType = self:GetTriggerParamByIndex(1)
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  if entityMgr then
    local fightPets = entityMgr:GetFightPets()
    for _, pet in pairs(fightPets) do
      if LuckLandTriggerTool.CheckPetPos(posType, pet) then
        return true
      end
    end
  end
  return false
end
