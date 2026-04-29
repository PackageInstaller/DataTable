_class("SwapPetTeamOrderCalculator", Object)
SwapPetTeamOrderCalculator = SwapPetTeamOrderCalculator

function SwapPetTeamOrderCalculator:Constructor(world)
  self._world = world
end

function SwapPetTeamOrderCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
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

function SwapPetTeamOrderCalculator:CalculateOneTarget(casterEntity, effectParam, targetEntity)
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
  local curPetPstID = eTarget:PetPstID():GetPstID()
  local curTeamOrderIndex, targetTeamOrderIndex, swapTargetPetPstID = self:_GetSwapTeamOrderIndex(eTarget, effectParam, tOldTeamOrder)
  if not (curTeamOrderIndex and targetTeamOrderIndex) or not swapTargetPetPstID then
    return
  end
  if curTeamOrderIndex == targetTeamOrderIndex then
    return
  end
  local checkLeaderCondiSuccess = self._CheckSwapLeaderCondition(curTeamOrderIndex, targetTeamOrderIndex, curPetPstID, swapTargetPetPstID)
  if not checkLeaderCondiSuccess then
    return
  end
  local tTeamOrder = {}
  for k, v in ipairs(cTeam:GetTeamOrder()) do
    if nHelpPetPstID and nHelpPetPstID == v then
    else
      table.insert(tTeamOrder, v)
    end
  end
  local orderCount = #tTeamOrder
  if curTeamOrderIndex > orderCount or targetTeamOrderIndex > orderCount then
    return
  end
  tTeamOrder[curTeamOrderIndex], tTeamOrder[targetTeamOrderIndex] = tTeamOrder[targetTeamOrderIndex], tTeamOrder[curTeamOrderIndex]
  if nHelpPetPstID then
    table.insert(tTeamOrder, nHelpPetPstID)
  end
  local result = SkillEffectResult_SwapPetTeamOrder:New(eTarget:GetID(), tOldTeamOrder, tTeamOrder)
  return result
end

function SwapPetTeamOrderCalculator:_GetSwapTeamOrderIndex(curEntity, effectParam, teamOrder)
  local curTeamOrderIndex, swapTargetPetPstID, swapTargetOrderIndex
  local cPstID = curEntity:PetPstID()
  local curPstID = cPstID:GetPstID()
  local cTeam = curEntity:Pet():GetOwnerTeamEntity():Team()
  local nHelpPetPstID = cTeam:GetHelpPetPstID()
  local targetTeamOrderIndex = effectParam:GetTargetOrderIndex()
  local targetTeamOrderType = effectParam:GetTargetOrderType()
  if SwapPetTeamOrderType.TEAM_LEADER == targetTeamOrderType then
    targetTeamOrderIndex = 1
  elseif SwapPetTeamOrderType.TEAM_TAIL == targetTeamOrderType then
    local tailIndex
    for k, v in ipairs(teamOrder) do
      local ePet = cTeam:GetPetEntityByPetPstID(v)
      if nHelpPetPstID ~= v and not ePet:HasPetDeadMark() then
        tailIndex = k
      end
    end
    targetTeamOrderIndex = tailIndex
  elseif SwapPetTeamOrderType.CASTER_SELECT_TEAM_POS == targetTeamOrderType then
    local validSelectPos, validSelectTarget
    local cTeam = curEntity:Pet():GetOwnerTeamEntity():Team()
    local selected = cTeam:GetSelectedTeamOrderPosition()
    local GLOBALteamOrder = cTeam:GetTeamOrder()
    validSelectPos = 0 < selected and selected <= #GLOBALteamOrder
    local isSelfTeamLeader = cTeam:GetTeamLeaderEntity():GetID() == curEntity:GetID()
    local pstID = GLOBALteamOrder[selected]
    local selectedPetEntity = pstID and cTeam:GetPetEntityByPetPstID(pstID)
    if selectedPetEntity and not selectedPetEntity:PetPstID():IsHelpPet() then
      validSelectTarget = not isSelfTeamLeader or not selectedPetEntity:BuffComponent():HasFlag(BuffFlags.SealedCurse) and not selectedPetEntity:BuffComponent():HasFlag(BuffFlags.Pet1702361NotLinkLine)
    end
    if not validSelectPos or not validSelectTarget then
      Log.error(self._className, "validSelectPos = ", tostring(validSelectPos), "validSelectTarget = ", validSelectTarget)
      return
    end
    targetTeamOrderIndex = selected
  elseif SwapPetTeamOrderType.OFFSET == targetTeamOrderType then
    for index, value in ipairs(teamOrder) do
      if nHelpPetPstID and nHelpPetPstID == value then
      elseif curPstID == value then
        curTeamOrderIndex = index
      end
    end
    targetTeamOrderIndex = curTeamOrderIndex + targetTeamOrderIndex
    if targetTeamOrderIndex == 0 then
      targetTeamOrderIndex = 1
    elseif targetTeamOrderIndex > table.count(teamOrder) then
      targetTeamOrderIndex = table.count(teamOrder)
    end
  end
  for index, value in ipairs(teamOrder) do
    if nHelpPetPstID and nHelpPetPstID == value then
    else
      if curPstID == value then
        curTeamOrderIndex = index
      end
      if targetTeamOrderIndex == index then
        swapTargetPetPstID = value
      end
    end
  end
  swapTargetOrderIndex = targetTeamOrderIndex
  return curTeamOrderIndex, swapTargetOrderIndex, swapTargetPetPstID
end

function SwapPetTeamOrderCalculator:_CheckSwapLeaderCondition(curTeamOrderIndex, targetTeamOrderIndex, curPetPstID, swapTargetPetPstID)
  if curTeamOrderIndex == 1 or targetTeamOrderIndex == 1 then
    local newLeaderPstID
    if curTeamOrderIndex == 1 then
      newLeaderPstID = swapTargetPetPstID
    elseif targetTeamOrderIndex == 1 then
      newLeaderPstID = curPetPstID
    end
    if newLeaderPstID then
      local svcBattle = self._world:GetService("Battle")
      local canSwapTeamLeader = svcBattle:CanBeTeamLeader(newLeaderPstID)
      if not canSwapTeamLeader then
        return false
      end
    end
  end
  return true
end
