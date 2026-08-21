require("llb_logic_base")
_class("LLBuffLogicMoveTarget", LLBuffLogicBase)
LLBuffLogicMoveTarget = LLBuffLogicMoveTarget

function LLBuffLogicMoveTarget:Constructor(buffObj, logicParam)
  self._moveType = logicParam.moveType
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicMoveTarget:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  if 1 < #targets then
    Log.error("[LuckLand] LLBuffLogicMoveTarget DoLogic target count over 1!")
  end
  local target = targets[1]
  local moveLength = self:DoLogicSingle(target) or 0
  if self._incType and not target:HasDeleteFlag() then
    if self._incType == LuckLandIncType.Accumulate then
      if self._fixVal then
        target:AddAccFixValue(self._fixVal * moveLength)
      end
      if self._perVal then
        target:AddAccPerValue(self._perVal * moveLength)
      end
    elseif self._incType == LuckLandIncType.Temp then
      if self._fixVal then
        target:AddTempFixValue(self._fixVal * moveLength)
      end
      if self._perVal then
        target:AddTempPerValue(self._perVal * moveLength)
      end
    end
  end
end

function LLBuffLogicMoveTarget:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if self._moveType == LuckLandConst.BVK_MoveToFirst then
      return target:GetLuckLandModule():GetEntityMng():MovePetToFirst(target)
    elseif self._moveType == LuckLandConst.BVK_MoveToLast then
      return target:GetLuckLandModule():GetEntityMng():MovePetToLast(target)
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
    if self._moveType == LuckLandConst.BVK_MoveToFirst then
      return target:GetLuckLandModule():GetEntityMng():MoveMonsterToFirst(target)
    elseif self._moveType == LuckLandConst.BVK_MoveToLast then
      return target:GetLuckLandModule():GetEntityMng():MoveMonsterToLast(target)
    end
  end
end
