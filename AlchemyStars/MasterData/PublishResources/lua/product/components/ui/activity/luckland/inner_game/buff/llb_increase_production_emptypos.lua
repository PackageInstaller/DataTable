require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionEmptyPos", LLBuffLogicBase)
LLBuffLogicIncreaseProductionEmptyPos = LLBuffLogicIncreaseProductionEmptyPos

function LLBuffLogicIncreaseProductionEmptyPos:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionEmptyPos:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local emptyPosCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local totalPosCount = entityMgr:GetPosCount()
  local fightPets = entityMgr:GetFightPets()
  if fightPets then
    emptyPosCount = totalPosCount - #fightPets
    if emptyPosCount <= 0 then
      emptyPosCount = 0
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, emptyPosCount)
  end
end

function LLBuffLogicIncreaseProductionEmptyPos:DoLogicSingle(target, emptyPosCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * emptyPosCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * emptyPosCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * emptyPosCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * emptyPosCount)
    end
  end
end
