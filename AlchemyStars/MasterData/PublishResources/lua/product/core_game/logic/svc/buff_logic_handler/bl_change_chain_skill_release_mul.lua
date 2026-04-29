_class("BuffLogicChangeChainSkillReleaseMul", BuffLogicBase)
BuffLogicChangeChainSkillReleaseMul = BuffLogicChangeChainSkillReleaseMul

function BuffLogicChangeChainSkillReleaseMul:Constructor(buffInstance, logicParam)
  self._mul = logicParam.val
  self._runCount = 0
end

function BuffLogicChangeChainSkillReleaseMul:DoLogic()
  local cAttr = self:GetEntity():Attributes()
  if not cAttr or not cAttr:GetAttribute("ChainSkillReleaseMul") then
    return
  end
  self._runCount = self._runCount + 1
  local changeVal = self._mul * self._runCount
  local bfsvc = self._world:GetService("BuffLogic")
  bfsvc:ChangeChainSkillReleaseMul(self:GetEntity(), self:GetBuffSeq(), changeVal)
  local val = cAttr:GetAttribute("ChainSkillReleaseMul")
  local res = DataAttributeResult:New(self:GetEntity():GetID(), "ChainSkillReleaseMul", val)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function BuffLogicChangeChainSkillReleaseMul:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicUndoChangeChainSkillReleaseMul", BuffLogicBase)
BuffLogicUndoChangeChainSkillReleaseMul = BuffLogicUndoChangeChainSkillReleaseMul

function BuffLogicUndoChangeChainSkillReleaseMul:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeChainSkillReleaseMul:DoLogic()
  local cAttr = self:GetEntity():Attributes()
  if not cAttr or not cAttr:GetAttribute("ChainSkillReleaseMul") then
    return
  end
  local bfsvc = self._world:GetService("BuffLogic")
  bfsvc:RemoveChainSkillReleaseMul(self:GetEntity(), self:GetBuffSeq())
  local val = cAttr:GetAttribute("ChainSkillReleaseMul")
  local res = DataAttributeResult:New(self:GetEntity():GetID(), "ChainSkillReleaseMul", val)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end
