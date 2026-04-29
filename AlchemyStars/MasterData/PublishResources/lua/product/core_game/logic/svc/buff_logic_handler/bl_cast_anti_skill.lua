local AntiAttackSkillType = {
  Normal = 1,
  AfterLoadSomeRound = 2,
  NightKing = 3
}
_enum("AntiAttackSkillType", AntiAttackSkillType)
_class("BuffLogicCastAntiSkill", BuffLogicBase)
BuffLogicCastAntiSkill = BuffLogicCastAntiSkill

function BuffLogicCastAntiSkill:Constructor(buffInstance, logicParam)
  self._type = logicParam.type or AntiAttackSkillType.Normal
  self._lockRound = logicParam.lockRound
  local battleStat = self._world:BattleStat()
  self._loadRoundCount = battleStat:GetLevelTotalRoundCount()
  self._skillID = logicParam.skillID
  self._startTask = logicParam.startTask or 0
end

function BuffLogicCastAntiSkill:DoLogic()
  if self._type == AntiAttackSkillType.AfterLoadSomeRound then
    local battleStat = self._world:BattleStat()
    local curRound = battleStat:GetLevelTotalRoundCount()
    if curRound - self._loadRoundCount < self._lockRound then
      return
    end
  end
  if self._type == AntiAttackSkillType.NightKing and not self:IsNightKingCanCounterAttack() then
    return
  end
  local e = self._buffInstance:Entity()
  local curHp = e:Attributes():GetCurrentHP()
  if curHp <= 0 then
    return
  end
  local skillHolder = e
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(skillHolder, self._skillID)
  local result = skillHolder:SkillContext():GetResultContainer()
  skillHolder:ReplaceSkillContext()
  local buffResult = BuffResultCastAntiSkill:New(self._skillID, skillHolder:GetID(), result, self._startTask)
  return buffResult
end

function BuffLogicCastAntiSkill:IsNightKingCanCounterAttack()
  local ownEntity = self._buffInstance:Entity()
  local myPos = ownEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if not utilScopeSvc:IsNightKingCanCounterAttack(ownEntity, teamEntity) then
    Log.fatal("NightKingCanCounterAttack Failure")
    return false
  end
  local newDir, newBodyArea = utilScopeSvc:GetCounterAttackSwitchBodyArea(ownEntity, teamEntity)
  for i = 2, #newBodyArea do
    local area = newBodyArea[i]
    local newPos = area + myPos
    if utilScopeSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) then
      Log.fatal("NightKingCanCounterAttack Failure")
      return false
    end
  end
  return true
end
