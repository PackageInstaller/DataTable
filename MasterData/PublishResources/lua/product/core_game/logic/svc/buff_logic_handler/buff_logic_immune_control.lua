_class("BuffLogicSetImmuneControl", BuffLogicBase)
BuffLogicSetImmuneControl = BuffLogicSetImmuneControl

function BuffLogicSetImmuneControl:Constructor(buffInstance, logicParam)
  self._layerNum = logicParam.layerNum
end

function BuffLogicSetImmuneControl:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.ImmuneControl)
end

_class("BuffLogicResetImmuneControl", BuffLogicBase)
BuffLogicResetImmuneControl = BuffLogicResetImmuneControl

function BuffLogicResetImmuneControl:Constructor(buffInstance, logicParam)
  self._layerNum = logicParam.layerNum
end

function BuffLogicResetImmuneControl:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.ImmuneControl)
end
