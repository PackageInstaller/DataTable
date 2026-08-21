_class("ChangePetTeamOrderCalculator", Object)
ChangePetTeamOrderCalculator = ChangePetTeamOrderCalculator

function ChangePetTeamOrderCalculator:Constructor(world)
  self._world = world
end

function ChangePetTeamOrderCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local generalEffectCalc = GeneralEffectCalculator:New(self._world)
  local finalScopeFilterParam = effectParam:GetScopeFilterParam()
  local scopeResult = generalEffectCalc:_CalcSkillEffectScopeResult(casterEntity, effectParam, finalScopeFilterParam)
  local targetIDs = generalEffectCalc:_CalcSkillEffectTargetList(casterEntity, scopeResult, effectParam)
  local t = {}
  for _, entityID in ipairs(targetIDs) do
    local entity = self._world:GetEntityByID(entityID)
    local result = self:CalculateOneTarget(casterEntity, effectParam, entity)
    if result then
      skillEffectResultContainer:AddEffectResult(result)
      table.insert(t, result)
    end
  end
  return t
end

function ChangePetTeamOrderCalculator:CalculateOneTarget(casterEntity, effectParam, targetEntity)
  local eTarget = targetEntity
  if eTarget:HasSuperEntity() then
    eTarget = targetEntity:GetSuperEntity()
  end
  if not eTarget:HasPetPstID() then
    return
  end
  if eTarget:PetPstID():IsHelpPet() then
    return
  end
  local cTeam = eTarget:Pet():GetOwnerTeamEntity():Team()
  local tOldTeamOrder = cTeam:CloneTeamOrder()
  local nHelpPetPstID = cTeam:GetHelpPetPstID()
  local eTeam = eTarget:Pet():GetOwnerTeamEntity()
  local cTeam = eTeam:Team()
  local nTargetPetPstID = eTarget:PetPstID():GetPstID()
  local tTeamOrder = {}
  local tDead = {}
  for k, v in ipairs(cTeam:GetTeamOrder()) do
    local e = cTeam:GetPetEntityByPetPstID(v)
    if (not nHelpPetPstID or nHelpPetPstID ~= v) and nTargetPetPstID ~= v then
      if e:HasPetDeadMark() then
        table.insert(tDead, v)
      else
        table.insert(tTeamOrder, v)
      end
    end
  end
  if effectParam:GetTargetOrder() == ChangePetTeamOrderTargetOrder.TeamLeader then
    table.insert(tTeamOrder, 1, nTargetPetPstID)
  elseif effectParam:GetTargetOrder() == ChangePetTeamOrderTargetOrder.TeamTail then
    table.insert(tTeamOrder, nTargetPetPstID)
  end
  if nHelpPetPstID then
    local e = cTeam:GetPetEntityByPetPstID(nHelpPetPstID)
    if e:HasPetDeadMark() then
      table.appendArray(tTeamOrder, tDead)
      table.insert(tTeamOrder, nHelpPetPstID)
    else
      table.insert(tTeamOrder, nHelpPetPstID)
      table.appendArray(tTeamOrder, tDead)
    end
  else
    table.appendArray(tTeamOrder, tDead)
  end
  local result = SkillEffectResult_ChangePetTeamOrder:New(eTarget:GetID(), tOldTeamOrder, tTeamOrder)
  return result
end
