_class("BuffLogicSetFinalBehitDamageParam", BuffLogicBase)
BuffLogicSetFinalBehitDamageParam = BuffLogicSetFinalBehitDamageParam

function BuffLogicSetFinalBehitDamageParam:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent
end

function BuffLogicSetFinalBehitDamageParam:DoLogic()
  local e = self._buffInstance:Entity()
  local cpt = e:Attributes()
  cpt:Modify("FinalBehitDamageParam", -self._percent / 100)
end
