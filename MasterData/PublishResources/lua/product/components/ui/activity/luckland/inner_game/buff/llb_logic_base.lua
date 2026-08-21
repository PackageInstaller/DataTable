_class("LLBuffLogicBase", Object)
LLBuffLogicBase = LLBuffLogicBase

function LLBuffLogicBase:Constructor(buffObj, logicParam)
  self._buffObj = buffObj
  self._entity = buffObj:Entity()
  self._logicParam = logicParam
end

function LLBuffLogicBase:SetLogicIndex(index)
  self._logicIndex = index
end

function LLBuffLogicBase:GetLogicIndex()
  return self._logicIndex
end

function LLBuffLogicBase:DoLogic(notify)
end

function LLBuffLogicBase:GetLogicName()
  return self._logicParam.logic
end

function LLBuffLogicBase:GetBuffSeq()
  return self._buffObj:BuffSeqID()
end

function LLBuffLogicBase:GetEntity()
  return self._entity
end

function LLBuffLogicBase:GetLogicParam()
  return self._logicParam
end
