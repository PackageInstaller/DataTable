_class("BuffLogicAddLight", BuffLogicBase)
BuffLogicAddLight = BuffLogicAddLight

function BuffLogicAddLight:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddLight:DoLogic()
  local e = self._buffInstance:Entity()
  local svc = self._buffInstance:World():GetService("Maze")
  svc:AddLight(self._addvalue)
end
