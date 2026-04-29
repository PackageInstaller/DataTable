_class("BuffLogicSetChainAcrossSelectMonster", BuffLogicBase)
BuffLogicSetChainAcrossSelectMonster = BuffLogicSetChainAcrossSelectMonster

function BuffLogicSetChainAcrossSelectMonster:Constructor(buffInstance, logicParam)
  self._remove = logicParam.remove or 0
end

function BuffLogicSetChainAcrossSelectMonster:DoLogic()
  local e = self._buffInstance:Entity()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:SetChainAcrossSelectMonster(self._remove == 1, e:GetID())
  local buffResult = BuffResultSetChainAcrossSelectMonster:New(self._remove == 1, e:GetID())
  return buffResult
end
