_class("ShuffleTeamOrderCalculator", Object)
ShuffleTeamOrderCalculator = ShuffleTeamOrderCalculator

function ShuffleTeamOrderCalculator:Constructor(world)
  self._world = world
end

function ShuffleTeamOrderCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
  for _, entityID in ipairs(targetIDs) do
    local entity = self._world:GetEntityByID(entityID)
    local result = self:_CalculateTeam(casterEntity, effectParam, entity)
    if result then
      skillEffectResultContainer:AddEffectResult(result)
    end
  end
end

function ShuffleTeamOrderCalculator:_CalculateTeam(casterEntity, effectParam, teamEntity)
  if not teamEntity:HasTeam() then
    return
  end
  local oldLeaderPstID = teamEntity:Team():GetTeamLeaderEntity():PetPstID():GetPstID()
  local newLeaderPstID
  local tOldTeamOrder = {}
  for k, v in ipairs(teamEntity:Team():GetTeamOrder()) do
    tOldTeamOrder[k] = v
  end
  local svcBattle = self._world:GetService("Battle")
  local candidate = svcBattle:GetFirstLeaderCandidate(teamEntity)
  if candidate then
    newLeaderPstID = candidate:PetPstID():GetPstID()
    svcBattle:ChangeLocalTeamLeader(newLeaderPstID)
  end
  local tTeamOrder = {}
  for k, v in ipairs(teamEntity:Team():GetTeamOrder()) do
    tTeamOrder[k] = v
  end
  local nNonShuffledLeaderPstID = tTeamOrder[1]
  local cTeam = teamEntity:Team()
  local cfgShufflePos = effectParam:GetShufflePos()
  local shuffleData = {}
  local helpPstID
  for _, pos in ipairs(cfgShufflePos) do
    if tTeamOrder[pos] then
      local pstID = tTeamOrder[pos]
      local e = cTeam:GetPetEntityByPetPstID(pstID)
      if not e:PetPstID():IsHelpPet() then
        table.insert(shuffleData, pstID)
      else
        helpPstID = pstID
      end
    end
  end
  local randomLSvc = self._world:GetService("RandomLogic")
  local shuffledPstIDs = {}
  while 0 < #shuffleData do
    local index = randomLSvc:LogicRand(1, #shuffleData)
    table.insert(shuffledPstIDs, table.remove(shuffleData, index))
  end
  local tNewTeamOrder = {}
  for orderIndex, pstID in ipairs(tTeamOrder) do
    if not table.icontains(cfgShufflePos, orderIndex) then
      table.insert(tNewTeamOrder, pstID)
    else
      table.insert(tNewTeamOrder, table.remove(shuffledPstIDs))
    end
  end
  if helpPstID then
    table.insert(tNewTeamOrder, helpPstID)
  end
  local cTeam = teamEntity:Team()
  cTeam:SetTeamOrder(tNewTeamOrder)
  self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(teamEntity, tOldTeamOrder, tNewTeamOrder))
  local result = SkillEffectResult_ShuffleTeamOrder:New(teamEntity:GetID(), oldLeaderPstID, newLeaderPstID, tOldTeamOrder, tNewTeamOrder)
  casterEntity:SkillContext():GetResultContainer():AddEffectResult(result)
end
