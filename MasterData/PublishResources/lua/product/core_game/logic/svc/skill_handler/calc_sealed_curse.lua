require("calc_base")
_class("SkillEffectCalc_SealedCurse", SkillEffectCalc_Base)
SkillEffectCalc_SealedCurse = SkillEffectCalc_SealedCurse

function SkillEffectCalc_SealedCurse:DoSkillEffectCalculator(calcParam)
  local results = {}
  local targets = calcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(calcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_SealedCurse:_CalculateSingleTarget(calcParam, entityID)
  if entityID < 0 then
    return
  end
  local ePet = self._world:GetEntityByID(entityID)
  if not ePet:HasPet() then
    return
  end
  local cPet = ePet:Pet()
  local eTeam = cPet:GetOwnerTeamEntity()
  local cTeam = eTeam:Team()
  local oldTeamLeaderPstID = cTeam:GetTeamLeaderEntity():PetPstID():GetPstID()
  local newTeamLeaderPstID
  if cTeam:GetTeamLeaderEntity():GetID() == entityID then
    local svcBattle = self._world:GetService("Battle")
    local eNewTeamLeader = svcBattle:GetFirstLeaderCandidate(eTeam)
    if not eNewTeamLeader then
      Log.info(self._className, "no new team leader, no curse this time. ")
      return
    end
    newTeamLeaderPstID = eNewTeamLeader:PetPstID():GetPstID()
  end
  local curseBuffID = calcParam:GetSkillEffectParam():GetCurseBuffID()
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffIns = buffLogicService:AddBuff(curseBuffID, ePet)
  local tTeamOrder = cTeam:CloneTeamOrder()
  local tNewTeamOrder = cTeam:CloneTeamOrder()
  local changeTeamLeaderMode = calcParam:GetSkillEffectParam():GetChangeTeamLeaderMode()
  if changeTeamLeaderMode == SkillEffect_SealedCurse_SealMode.SwapWithNewTeamLeader then
    local index = 1
    for i, pstID in ipairs(tTeamOrder) do
      if pstID == newTeamLeaderPstID then
        index = i
        break
      end
    end
    local formerPstID = tNewTeamOrder[1]
    tNewTeamOrder[1] = newTeamLeaderPstID
    tNewTeamOrder[index] = formerPstID
  elseif changeTeamLeaderMode == SkillEffect_SealedCurse_SealMode.CastFormerLeaderToTail then
    local t = {}
    t[1] = newTeamLeaderPstID
    local helpPetPstID = cTeam:GetHelpPetPstID()
    for i = 2, #tNewTeamOrder do
      local pstID = tNewTeamOrder[i]
      if pstID ~= newTeamLeaderPstID and pstID ~= oldTeamLeaderPstID and pstID ~= helpPetPstID then
        table.insert(t, pstID)
      end
    end
    table.insert(t, oldTeamLeaderPstID)
    if helpPetPstID then
      table.insert(t, helpPetPstID)
    end
    tNewTeamOrder = t
  end
  local result = SkillEffectResult_SealedCurse:New(ePet:GetID(), curseBuffID, buffIns:BuffSeq(), oldTeamLeaderPstID, newTeamLeaderPstID)
  result:SetOldTeamOrder(tTeamOrder)
  result:SetNewTeamOrder(tNewTeamOrder)
  return {result}
end
