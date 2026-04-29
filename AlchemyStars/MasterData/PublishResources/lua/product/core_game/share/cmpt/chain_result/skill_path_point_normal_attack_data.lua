_class("SkillPathPointNormalAttackData", Object)
SkillPathPointNormalAttackData = SkillPathPointNormalAttackData

function SkillPathPointNormalAttackData:Constructor()
  self._attackGridDic = {}
  self._attackGridDicAdditional = {}
end

function SkillPathPointNormalAttackData:GetAttackGridDic()
  return self._attackGridDic
end

function SkillPathPointNormalAttackData:GetAttackGridDicAdditional()
  return self._attackGridDicAdditional
end

function SkillPathPointNormalAttackData:GetPetOrderGridArray(petEntity, pathPosition)
  local orderGridArray = {}
  local buffComponent = petEntity:BuffComponent()
  local normalAttackCrossTwoCount = buffComponent:GetBuffValue("NormalAttackCrossTwoCount")
  if normalAttackCrossTwoCount and 0 < normalAttackCrossTwoCount then
    orderGridArray = self:GetOrderGridArrayCrossTwo(pathPosition)
  else
    orderGridArray = self:GetOrderGridArray(pathPosition)
  end
  return orderGridArray
end

function SkillPathPointNormalAttackData:GetOrderGridArray(pathPointPos)
  local orderArray = {}
  self:_CheckAttackPoint(pathPointPos, 0, 1, orderArray)
  self:_CheckAttackPoint(pathPointPos, 1, 0, orderArray)
  self:_CheckAttackPoint(pathPointPos, 0, -1, orderArray)
  self:_CheckAttackPoint(pathPointPos, -1, 0, orderArray)
  self:_CheckAttackPoint(pathPointPos, 1, 1, orderArray)
  self:_CheckAttackPoint(pathPointPos, 1, -1, orderArray)
  self:_CheckAttackPoint(pathPointPos, -1, -1, orderArray)
  self:_CheckAttackPoint(pathPointPos, -1, 1, orderArray)
  return orderArray
end

function SkillPathPointNormalAttackData:_CheckAttackPoint(pathPointPos, disx, disy, orderArray)
  local attackPos = Vector2(0, 0)
  attackPos.x = pathPointPos.x + disx
  attackPos.y = pathPointPos.y + disy
  local posIndex = Vector2.Pos2Index(attackPos)
  local isKey = table.iskey(self._attackGridDic, posIndex)
  if isKey == true then
    orderArray[#orderArray + 1] = attackPos
  end
  local isKeyAdditional = table.iskey(self._attackGridDicAdditional, posIndex)
  if isKeyAdditional == true then
    orderArray[#orderArray + 1] = attackPos
  end
end

function SkillPathPointNormalAttackData:GetOrderGridArrayCrossTwo(pathPointPos)
  local orderArray = {}
  local hasAddAttack = true
  hasAddAttack = self:_CheckAttackPointHaveAttackData(pathPointPos, 0, 1, orderArray)
  if hasAddAttack == false then
    self:_CheckAttackPoint(pathPointPos, 0, 2, orderArray)
  end
  hasAddAttack = self:_CheckAttackPointHaveAttackData(pathPointPos, 1, 0, orderArray)
  if hasAddAttack == false then
    self:_CheckAttackPoint(pathPointPos, 2, 0, orderArray)
  end
  hasAddAttack = self:_CheckAttackPointHaveAttackData(pathPointPos, 0, -1, orderArray)
  if hasAddAttack == false then
    self:_CheckAttackPoint(pathPointPos, 0, -2, orderArray)
  end
  hasAddAttack = self:_CheckAttackPointHaveAttackData(pathPointPos, -1, 0, orderArray)
  if hasAddAttack == false then
    self:_CheckAttackPoint(pathPointPos, -2, 0, orderArray)
  end
  return orderArray
end

function SkillPathPointNormalAttackData:_CheckAttackPointHaveAttackData(pathPointPos, disx, disy, orderArray)
  local orderArrayCount1 = #orderArray
  self:_CheckAttackPoint(pathPointPos, disx, disy, orderArray)
  local orderArrayCount2 = #orderArray
  return orderArrayCount1 < orderArrayCount2
end

function SkillPathPointNormalAttackData:GetPathPointAttackCount()
  return table.count(self._attackGridDic)
end

function SkillPathPointNormalAttackData:AddAttackGridData(beAttackPosition, targetEntityID, skillId, petEntityID, casterPos)
  local hasAttackGridData = self:HasAttackInfo(beAttackPosition, targetEntityID)
  if hasAttackGridData ~= true then
    local attackGridData = AttackGridData:New(targetEntityID, nil, beAttackPosition, skillId, petEntityID)
    local posIndex = Vector2.Pos2Index(beAttackPosition)
    self._attackGridDic[posIndex] = attackGridData
  else
    Log.fatal("Already has attack grid data")
  end
end

function SkillPathPointNormalAttackData:HasAttackGridData(beAttackPosition)
  local posIndex = Vector2.Pos2Index(beAttackPosition)
  return table.iskey(self._attackGridDic, posIndex)
end

function SkillPathPointNormalAttackData:HasAttackInfo(beAttackPosition, targetEntityID)
  local hasPos = self:HasAttackGridData(beAttackPosition)
  local hasTarget = false
  for k, v in pairs(self._attackGridDic) do
    local attackGridData = v
    local curIDList = attackGridData:GetTargetIdList()
    if curIDList then
      for i = 1, #curIDList do
        if curIDList[i] == targetEntityID then
          hasTarget = true
        end
      end
    end
  end
  if hasPos == true or hasTarget == true then
    return true
  end
  return false
end

function SkillPathPointNormalAttackData:AddAttackGridDataOnlyCheckPos(beAttackPosition, targetEntityID, skillId, petEntityID, casterPos)
  local hasAttackGridData = self:HasAttackInfoOnlyCheckPos(beAttackPosition, targetEntityID)
  if hasAttackGridData ~= true then
    local attackGridData = AttackGridData:New(targetEntityID, nil, beAttackPosition, skillId, petEntityID)
    local posIndex = Vector2.Pos2Index(beAttackPosition)
    self._attackGridDic[posIndex] = attackGridData
  else
    Log.fatal("Already has attack grid data")
  end
end

function SkillPathPointNormalAttackData:HasAttackInfoOnlyCheckPos(beAttackPosition, targetEntityID)
  local hasPos = self:HasAttackGridData(beAttackPosition)
  if hasPos == true then
    return true
  end
  return false
end

function SkillPathPointNormalAttackData:AddAttackGridDataAdditional(beAttackPosition, targetEntityID, skillId, petEntityID, casterPos)
  local hasAttackGridData = self:HasAttackInfoOnlyCheckPos(beAttackPosition, targetEntityID)
  if hasAttackGridData == true then
    local attackGridData = AttackGridData:New(targetEntityID, nil, beAttackPosition, skillId, petEntityID)
    local posIndex = Vector2.Pos2Index(beAttackPosition)
    self._attackGridDicAdditional[posIndex] = attackGridData
  else
    Log.fatal("Already has attack grid data")
  end
end
