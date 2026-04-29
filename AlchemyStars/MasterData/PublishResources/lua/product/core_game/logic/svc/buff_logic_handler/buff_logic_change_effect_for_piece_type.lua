_class("BuffLogicChangeEffectForPieceType", BuffLogicBase)
BuffLogicChangeEffectForPieceType = BuffLogicChangeEffectForPieceType

function BuffLogicChangeEffectForPieceType:Constructor(buffInstance, logicParam)
end

function BuffLogicChangeEffectForPieceType:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local gridPos = e:GetGridPosition()
  local pos, beforePieceType, afterPieceType
  local notifyType = notify:GetNotifyType()
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(gridPos)
  if notifyType == NotifyType.GridConvert then
    local convertInfo = notify:GetConvertInfoAt(gridPos)
    if not convertInfo then
      return
    end
    pos = convertInfo:GetPos()
    if pos ~= gridPos then
      return
    end
    beforePieceType = convertInfo:GetBeforePieceType()
    afterPieceType = convertInfo:GetAfterPieceType()
  elseif notifyType == NotifyType.BuffLoad or notifyType == NotifyType.ActiveSkillAttackEnd or notifyType == NotifyType.TrapShow then
    pos = gridPos
    beforePieceType = 0
    afterPieceType = pieceType
  end
  local buffResult = BuffResultChangeEffectForPieceType:New(notifyType, pos, beforePieceType, afterPieceType)
  return buffResult
end
