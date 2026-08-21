require("buff_type")
require("buff_logic_base")
_class("BuffLogicShieldToAtk", BuffLogicBase)
BuffLogicShieldToAtk = BuffLogicShieldToAtk

function BuffLogicShieldToAtk:Constructor(buffInstance, logicParam)
  self._atkMul = logicParam.atkMul or 0
end

function BuffLogicShieldToAtk:DoLogic()
  local e = self._entity
  local recoverEntity = e
  if e:PetPstID() then
    local matchType = self._world:MatchType()
    if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
      recoverEntity = e:Pet():GetOwnerTeamEntity()
    end
  end
  local buffCmpt = recoverEntity:BuffComponent()
  if buffCmpt == nil then
    return
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local curShieldValue = buffLogicService:GetHPShield(e)
  local buffSeqID = self:GetBuffSeq()
  local atkAdded = self._atkMul * curShieldValue
  buffLogicService:RemoveBaseAttack(self._entity, buffSeqID, ModifyBaseAttackType.AttackPercentage)
  buffLogicService:ChangeBaseAttack(e, buffSeqID, ModifyBaseAttackType.AttackPercentage, atkAdded)
  local result = BuffResultShieldToAtk:New(atkAdded)
  return result
end

_class("BuffLogicUndoShieldToAtk", BuffLogicBase)
BuffLogicUndoShieldToAtk = BuffLogicUndoShieldToAtk

function BuffLogicUndoShieldToAtk:DoLogic()
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffSeqID = self:GetBuffSeq()
  buffLogicService:RemoveBaseAttack(self._entity, buffSeqID, ModifyBaseAttackType.AttackPercentage)
end
