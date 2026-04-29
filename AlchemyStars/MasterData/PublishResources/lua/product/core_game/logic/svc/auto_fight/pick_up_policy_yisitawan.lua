require("pick_up_policy_base")
_class("PickUpPolicy_YiSiTaWan", PickUpPolicy_Base)
PickUpPolicy_YiSiTaWan = PickUpPolicy_YiSiTaWan

function PickUpPolicy_YiSiTaWan:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam, canCastTrap = self:_CalPickPosPolicy_PetYiSiTaWan(petEntity, activeSkillID)
  if canCastTrap then
    local autoFightSvc = self._world:GetService("AutoFight")
    autoFightSvc:SetCastPetTrapSkillPetEntity(petEntity)
  end
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_YiSiTaWan:_CalPickPosPolicy_PetYiSiTaWan(casterEntity, activeSkillID)
  local configService = self._world:GetService("Config")
  local utilDataSvc = self._world:GetService("UtilData")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local canPickTrap = false
  local pickPosPolicyParam = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if pickPosPolicyParam then
    canPickTrap = pickPosPolicyParam.canPickTrap
  end
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamMembers) do
    if petEntity:GetID() ~= casterEntity:GetID() then
      local cPstId = petEntity:PetPstID()
      local pstId = cPstId:GetPstID()
      if utilDataSvc:IsHasExtraChainFlag(pstId) then
        return nil, nil, nil, nil, canPickTrap
      end
    end
  end
  local petPstID, teamIndex
  local pets = teamEntity:Team():GetTeamPetEntities()
  local atkNum = 0
  for _, petEntity in ipairs(pets) do
    if atkNum < petEntity:Attributes():GetAttack() and petEntity:GetID() ~= casterEntity:GetID() then
      atkNum = petEntity:Attributes():GetAttack()
      petPstID = petEntity:PetPstID():GetPstID()
      teamIndex = teamEntity:Team():GetTeamIndexByPetPstID(petPstID)
    end
  end
  if not petPstID or not teamIndex then
    return nil, nil, nil, nil, canPickTrap
  end
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:CheckPetCanCastSkill(casterEntity, activeSkillID, petPstID) then
    return {teamIndex}, {teamIndex}, {teamIndex}, {petPstID, teamIndex}, canPickTrap
  else
    return nil, nil, nil, nil, canPickTrap
  end
end
