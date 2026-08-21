_class("PetChainSkillAttack", Object)
PetChainSkillAttack = PetChainSkillAttack

function PetChainSkillAttack:Constructor(world)
  self._world = world
end

function PetChainSkillAttack:_GetChainSkillPhaseArray(casterEntity, skillID)
  local configService = self._world:GetService("Config")
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
  end
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  return skillPhaseArray
end

function PetChainSkillAttack:_CheckFinalAttack(skillEffectResultContainer, casterEntity)
  local damageReslut = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageReslut == nil then
    skillEffectResultContainer:SetFinalAttack(false)
  else
    skillEffectResultContainer:SetFinalAttack(true)
    self:_SortForFinalAttack(damageReslut, casterEntity)
    local skillDamageResult = damageReslut[#damageReslut]
    local finalAttackEnemyID = skillDamageResult:GetTargetID()
    skillEffectResultContainer:SetFinalAttackEntityID(finalAttackEnemyID)
  end
end

function PetChainSkillAttack:_SortForFinalAttack(skillDamageResultArray, casterEntity)
  if skillDamageResultArray == nil or #skillDamageResultArray <= 1 then
    return skillDamageResultArray
  end
  local count = #skillDamageResultArray
  
  local function CmpBodyAreafunc(skillDamageEffectResult1, skillDamageEffectResult2)
    local areaCount1 = self:_GetAreaCount(skillDamageEffectResult1)
    local areaCount2 = self:_GetAreaCount(skillDamageEffectResult2)
    return areaCount1 < areaCount2
  end
  
  table.sort(skillDamageResultArray, CmpBodyAreafunc)
  local lastSkillDamageResult = skillDamageResultArray[count]
  local maxAreaCount = self:_GetAreaCount(lastSkillDamageResult)
  local sortByAreaArray = {}
  for _, v in ipairs(skillDamageResultArray) do
    local curAreaCount = self:_GetAreaCount(v)
    if curAreaCount == maxAreaCount then
      sortByAreaArray[#sortByAreaArray + 1] = v
    end
  end
  local areaArrayCount = #sortByAreaArray
  if areaArrayCount <= 1 then
    return skillDamageResultArray
  else
    local function CmpDistancefunc(skillDamageEffectResult1, skillDamageEffectResult2)
      local dis1 = self:_GetDistanceToPlayer(skillDamageEffectResult1, casterEntity)
      
      local dis2 = self:_GetDistanceToPlayer(skillDamageEffectResult2, casterEntity)
      return dis1 < dis2
    end
    
    table.sort(sortByAreaArray, CmpDistancefunc)
    local maxDistanceResult = sortByAreaArray[areaArrayCount]
    table.removev(skillDamageResultArray, maxDistanceResult)
    skillDamageResultArray[#skillDamageResultArray + 1] = maxDistanceResult
  end
end

function PetChainSkillAttack:_GetAreaCount(skillDamageResult)
  local entityID = skillDamageResult:GetTargetID()
  local entity = self._world:GetEntityByID(entityID)
  if entity == nil then
    return 0
  end
  local bodyAreaCmpt = entity:BodyArea()
  local areaCount = 0
  if bodyAreaCmpt ~= nil then
    areaCount = bodyAreaCmpt:GetAreaCount()
  end
  return areaCount
end

function PetChainSkillAttack:_GetDistanceToPlayer(skillDamageResult, casterEntity)
  local playerPos = casterEntity:GridLocation().Position
  local gridPos = skillDamageResult:GetGridPos()
  return Vector2.Distance(gridPos, playerPos)
end

function PetChainSkillAttack:GetPetForward(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local casterPos = casterEntity:GridLocation().Position
  local damageResultList = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultList or table.count(damageResultList) == 0 then
    return
  end
  local beAttackEntityID = damageResultList[1]:GetTargetID()
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  if not targetEntity then
    return
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local damagePosList = {}
  for i, result in ipairs(damageResultList) do
    if result:GetGridPos() then
      table.insert(damagePosList, result:GetGridPos())
    end
  end
  
  local function cmpFunc(damageResultPos1, damageResultPos2)
    local dis1 = Vector2.Distance(damageResultPos1, casterPos)
    local dis2 = Vector2.Distance(damageResultPos2, casterPos)
    if dis1 == dis2 then
      return get_index(casterPos, damageResultPos1) < get_index(casterPos, damageResultPos2)
    else
      return dis1 < dis2
    end
  end
  
  table.sort(damagePosList, cmpFunc)
  local dir = damagePosList[1] - casterPos
  return dir
end

function PetChainSkillAttack:_IsLastPlayChainSkill(casterEntity)
  local playerEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local cChainSkillSequence = playerEntity:ChainSkillSequence()
  local arr = {
    playerEntity:GetID()
  }
  if cChainSkillSequence.ChainSkillSeqTable then
    for i, v in ipairs(cChainSkillSequence.ChainSkillSeqTable) do
      table.insert(arr, v)
    end
  end
  if arr[table.count(arr)] == casterEntity:GetID() then
    return true
  end
  return false
end

function PetChainSkillAttack:_ShowChainAttackMonsterDead(TT)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT)
end

function PetChainSkillAttack:_OnResultDeadEntityAddDeadFlag(casterEntityID, chainTimeIndex, chainStageIndex)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local deadEntityIdList = chainAtkResCmpt:GetDeadEntityIDListByPet(casterEntityID)
  chainStageIndex = chainStageIndex or 1
  if deadEntityIdList[chainTimeIndex] and deadEntityIdList[chainTimeIndex][chainStageIndex] then
    local deadList = deadEntityIdList[chainTimeIndex][chainStageIndex]
    for _, eid in ipairs(deadList) do
      local e = self._world:GetEntityByID(eid)
      e:AddDeadFlag()
    end
  end
end

function PetChainSkillAttack:GetReplaceEntity(casterEntity)
  local buffViewCmpt = casterEntity:BuffView()
  local replaceChainEntityID = buffViewCmpt:GetBuffValue("ReplaceEntityID")
  local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
  if not replaceChainEntity then
    return
  end
  return replaceChainEntity
end
