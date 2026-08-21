require("buff_logic_base")
_class("BuffLogicSetMonsterDoppelganger", BuffLogicBase)
BuffLogicSetMonsterDoppelganger = BuffLogicSetMonsterDoppelganger

function BuffLogicSetMonsterDoppelganger:Constructor(buffInstance, logicParam)
  self._type = logicParam.type
  self._param = logicParam.param
  self._count = logicParam.count
end

function BuffLogicSetMonsterDoppelganger:DoLogic()
  local e = self._buffInstance:Entity()
  local monsterID = e:MonsterID()
  monsterID:SetDoppelgangerValue(0)
  monsterID:SetDoppelgangerParam({
    type = self._type,
    param = self._param,
    count = self._count
  })
end

_class("BuffLogicResetMonsterDoppelganger", BuffLogicBase)
BuffLogicResetMonsterDoppelganger = BuffLogicResetMonsterDoppelganger

function BuffLogicResetMonsterDoppelganger:DoLogic()
  local e = self._buffInstance:Entity()
  local monsterID = e:MonsterID()
  monsterID:SetDoppelgangerValue(nil)
end
