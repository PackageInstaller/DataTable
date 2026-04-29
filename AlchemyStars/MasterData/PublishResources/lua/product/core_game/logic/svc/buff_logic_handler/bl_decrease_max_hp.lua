_class("BuffLogicDecreaseMaxHP", BuffLogicBase)
BuffLogicDecreaseMaxHP = BuffLogicDecreaseMaxHP

function BuffLogicDecreaseMaxHP:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue
  assert(self._mulValue, "DecreaseMaxHP: parameter [mulValue] is required. ")
  assert(self._mulValue < 1 and self._mulValue > 0, "DecreaseMaxHP: mulValue is invalid. Range is (0, 1). ")
end

function BuffLogicDecreaseMaxHP:DoLogic()
  local entity = self._buffInstance:Entity()
  local matchType = self._world:MatchType()
  if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze and entity:HasPetPstID() then
    entity = entity:Pet():GetOwnerTeamEntity()
  end
  if entity:Attributes():GetCurrentHP() == 0 then
    return
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local baseMaxHp = entity:Attributes():CalcMaxHp()
  local val = math.floor(baseMaxHp * self._mulValue)
  local ret = calcDamage:DecreaseTargetMaxHP(entity:GetID(), val, self:GetBuffSeq())
  local damageInfo = DamageInfo:New(baseMaxHp - val, DamageType.Real)
  calcDamage:DecreaseTargetHP(entity, damageInfo)
  local buffResult = BuffResultDecreaseMaxHP:New(entity:GetID(), damageInfo, ret)
  return buffResult
end
