require("buff_logic_base")
_class("BuffLogicChangeAttackByOwnerHPPercent", BuffLogicBase)
BuffLogicChangeAttackByOwnerHPPercent = BuffLogicChangeAttackByOwnerHPPercent

function BuffLogicChangeAttackByOwnerHPPercent:Constructor(buffInstance, logicParam)
  self._paramA = logicParam.paramA or 0
  self._paramB = logicParam.paramB or 0
  self._startHPPercent = logicParam.startHPPercent or 0
  self._endHPPercent = logicParam.endHPPercent or 1
end

function BuffLogicChangeAttackByOwnerHPPercent:DoLogic()
  local ownerEntity = self._buffInstance:Entity()
  local useEntity = ownerEntity
  if self._world:MatchType() ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze and ownerEntity:HasPetPstID() then
    useEntity = ownerEntity:Pet():GetOwnerTeamEntity()
  end
  if not ownerEntity:Attributes() then
    return
  end
  local attrCmpt = useEntity:Attributes()
  if not attrCmpt then
    return
  end
  local maxHP = attrCmpt:CalcMaxHp()
  local curHP = attrCmpt:GetCurrentHP()
  local hpPercent = curHP / maxHP
  local val = 0
  if hpPercent < self._startHPPercent then
    val = self._paramB
  elseif hpPercent >= self._startHPPercent and hpPercent < self._endHPPercent then
    val = (hpPercent - self._startHPPercent) * self._paramA + self._paramB
  elseif hpPercent >= self._endHPPercent then
    val = (self._endHPPercent - self._startHPPercent) * self._paramA + self._paramB
  end
  if val <= -1 then
    val = -1
  end
  self._buffLogicService:ChangeBaseAttack(ownerEntity, self:GetBuffSeq(), ModifyBaseAttackType.AttackPercentage, val)
end

function BuffLogicChangeAttackByOwnerHPPercent:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicChangeAttackByOwnerHPPercentUndo", BuffLogicBase)
BuffLogicChangeAttackByOwnerHPPercentUndo = BuffLogicChangeAttackByOwnerHPPercentUndo

function BuffLogicChangeAttackByOwnerHPPercentUndo:Constructor(buffInstance, logicParam)
end

function BuffLogicChangeAttackByOwnerHPPercentUndo:DoLogic()
  local ownerEntity = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(ownerEntity, self:GetBuffSeq(), ModifyBaseAttackType.AttackPercentage)
end

function BuffLogicChangeAttackByOwnerHPPercentUndo:DoOverlap(logicParam)
  return self:DoLogic()
end
