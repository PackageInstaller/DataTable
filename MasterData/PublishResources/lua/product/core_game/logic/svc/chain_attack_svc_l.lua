require("base_service")
_class("ChainAttackServiceLogic", BaseService)
ChainAttackServiceLogic = ChainAttackServiceLogic

function ChainAttackServiceLogic:_DoLogicCalcChainSkill(teamEntity)
  if self._world:RunAtServer() then
    local pets = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(pets) do
      local skillPetData = e:SkillPetAttackData()
      skillPetData:ClearPetChainAttackData()
    end
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillLogicService = self._world:GetService("SkillLogic")
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPieceType = logicChainPathCmpt:GetLogicPieceType()
  utilScopeSvc:SelectTarget(teamEntity, chainPieceType)
  local battleStatCmpt = self._world:BattleStat()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local chainNum = logicChainPathCmpt:GetChainRateAtIndex(#chainPath)
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local isSuperChain = chainNum >= superChainCount
  if isSuperChain then
    battleStatCmpt:AddSuperChainCount(teamEntity)
  end
  battleStatCmpt:SetRoundSuperChain(isSuperChain)
  battleStatCmpt:SetRoundChainPath(chainPath)
  if self:CanCalcChainSkill(teamEntity) then
    local skillCastPos = teamEntity:GridLocation():GetGridPos()
    skillLogicService:CalcChainSkillDamage(teamEntity, skillCastPos)
  else
    local ntChainSkip = NTChainSkillTurnStartSkipped:New(teamEntity)
    self._world:GetService("Trigger"):Notify(ntChainSkip)
  end
  local normalSkillKillCount = battleStatCmpt:GetNormalAttackKillCount()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  local chainSkillKill = #monsterGroup:GetEntities() - normalSkillKillCount
  battleStatCmpt:SetOneChainKillCount(teamEntity, chainSkillKill)
end

function ChainAttackServiceLogic:CanCalcChainSkill(teamEntity)
  if teamEntity:HasTeamDeadMark() then
    return false
  end
  if teamEntity:BuffComponent():HasFlag(BuffFlags.Benumb) then
    return false
  end
  return true
end
