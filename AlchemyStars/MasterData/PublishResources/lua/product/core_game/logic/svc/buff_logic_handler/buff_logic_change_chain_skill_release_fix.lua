_class("BuffLogicChangeChainSkillReleaseFix", BuffLogicBase)
BuffLogicChangeChainSkillReleaseFix = BuffLogicChangeChainSkillReleaseFix

function BuffLogicChangeChainSkillReleaseFix:Constructor(buffInstance, logicParam)
  self._fixVal = logicParam.val
  self._buffInstance.changeChainSkillReleaseFix_runCount = 0
end

function BuffLogicChangeChainSkillReleaseFix:DoLogic()
  local cAttr = self:GetEntity():Attributes()
  if not cAttr or not cAttr:GetAttribute("ChainSkillReleaseFix") then
    return
  end
  self._buffInstance.changeChainSkillReleaseFix_runCount = self._buffInstance.changeChainSkillReleaseFix_runCount + 1
  local changeVal = self._fixVal * self._buffInstance.changeChainSkillReleaseFix_runCount
  local bfsvc = self._world:GetService("BuffLogic")
  bfsvc:ChangeChainSkillReleaseFix(self:GetEntity(), self:GetBuffSeq(), changeVal)
  local val = cAttr:GetAttribute("ChainSkillReleaseFix")
  local res = DataAttributeResult:New(self:GetEntity():GetID(), "ChainSkillReleaseFix", val)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function BuffLogicChangeChainSkillReleaseFix:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicUndoChangeChainSkillReleaseFix", BuffLogicBase)
BuffLogicUndoChangeChainSkillReleaseFix = BuffLogicUndoChangeChainSkillReleaseFix

function BuffLogicUndoChangeChainSkillReleaseFix:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeChainSkillReleaseFix:DoLogic()
  local cAttr = self:GetEntity():Attributes()
  if not cAttr or not cAttr:GetAttribute("ChainSkillReleaseFix") then
    return
  end
  local bfsvc = self._world:GetService("BuffLogic")
  bfsvc:RemoveChainSkillReleaseFix(self:GetEntity(), self:GetBuffSeq())
  local val = cAttr:GetAttribute("ChainSkillReleaseFix")
  local res = DataAttributeResult:New(self:GetEntity():GetID(), "ChainSkillReleaseFix", val)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  self._buffInstance.changeChainSkillReleaseFix_runCount = 0
end

function BuffLogicUndoChangeChainSkillReleaseFix:DoOverlap()
end
