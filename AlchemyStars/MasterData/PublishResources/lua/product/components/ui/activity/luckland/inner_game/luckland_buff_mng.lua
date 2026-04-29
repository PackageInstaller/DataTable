_class("LLBuffMng", Object)
LLBuffMng = LLBuffMng

function LLBuffMng:Constructor()
  self._buffSeqID = 1000
  self._buffTargetCtor = LuckLandTargetCalculator:New()
end

function LLBuffMng:Dispose()
  self._buffSeqID = 1000
end

function LLBuffMng:CreateBuff(buffID, entity)
  self._buffSeqID = self._buffSeqID + 1
  local llBuff = LuckLandBuff:New(self._buffSeqID, buffID, entity)
  return llBuff
end

function LLBuffMng:CreateBuffLogic(buffObj, logicCfg)
  if not logicCfg or not next(logicCfg) then
    return nil
  end
  local logicArray = {}
  for _, cfg in ipairs(logicCfg) do
    local subLogic = self:CreateLogic(buffObj, cfg)
    logicArray[#logicArray + 1] = subLogic
  end
  return logicArray
end

function LLBuffMng:CreateLogic(buffObj, logicParam)
  local logicName = string.trim(logicParam.logic)
  local logicPrototype = Classes["LLBuffLogic" .. logicName]
  if not logicPrototype then
    local buffLogicName = "LLBuffLogic" .. logicParam.logic
    Log.exception("LLBuffMng:CreateLogic() not find logic:", buffLogicName, " config Logic:", logicParam.logic)
    return
  end
  return logicPrototype:New(buffObj, logicParam)
end

function LLBuffMng:AddBuff(buffID, entity)
  if entity == nil then
    Log.fatal("[LLBuffMng] AddBuff failed, entity is nil. BuffID: ", buffID)
  end
  local buff = self:CreateBuff(buffID, entity)
  return buff
end

function LLBuffMng:CalculateBuffTarget(targetType, targetParam, buffOwner)
  return self._buffTargetCtor:CalculateBuffTarget(targetType, targetParam, buffOwner)
end
