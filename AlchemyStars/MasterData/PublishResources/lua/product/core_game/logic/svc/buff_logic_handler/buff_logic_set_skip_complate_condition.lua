require("buff_logic_base")
_class("BuffLogicSetSkipComplateCondition", BuffLogicBase)
BuffLogicSetSkipComplateCondition = BuffLogicSetSkipComplateCondition

function BuffLogicSetSkipComplateCondition:Constructor(buffInstance, logicParam)
  self._skip = logicParam.skip
end

function BuffLogicSetSkipComplateCondition:DoLogic()
  local e = self._buffInstance:Entity()
  local monsterID = e:MonsterID()
  if not monsterID then
    return
  end
  monsterID:SetSkipComplateCondition(self._skip)
end
