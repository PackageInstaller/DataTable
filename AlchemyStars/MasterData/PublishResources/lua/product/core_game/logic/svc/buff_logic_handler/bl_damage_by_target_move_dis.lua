_class("BuffLogicDamageByTargetMoveDis", BuffLogicBase)
BuffLogicDamageByTargetMoveDis = BuffLogicDamageByTargetMoveDis

function BuffLogicDamageByTargetMoveDis:Constructor(buffInstance, logicParam)
  self._fixedDamage = logicParam.fixedDamage
end

function BuffLogicDamageByTargetMoveDis:DoLogic(notify)
  local dis, targetEntity = self:GetTargetMoveDisAndTarget(notify)
  if dis == 0 or not targetEntity then
    return
  end
  local blsvc = self._world:GetService("BuffLogic")
  local damageParam = {
    fixedDamage = self._fixedDamage,
    layer = dis,
    formulaID = 169
  }
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), self._entity, targetEntity, damageParam)
  local buffResult = BuffResultAddPoison:New(damageInfo, recoverDamageInfos)
  return buffResult
end

function BuffLogicDamageByTargetMoveDis:GetTargetMoveDisAndTarget(notify)
  local dis = 0
  local targetEntity
  if notify:GetNotifyType() == NotifyType.HitBackEnd or notify:GetNotifyType() == NotifyType.TractionEnd then
    local boardSvr = self._world:GetService("BoardLogic")
    local maxTeleportRing = math.max(boardSvr:GetCurBoardMaxX(), boardSvr:GetCurBoardMaxY())
    local casterEntity = notify:GetNotifyEntity()
    local posStart = notify:GetPosStart()
    local posEnd = notify:GetPosEnd()
    for i = 1, maxTeleportRing do
      local ringRange = ComputeScopeRange.ComputeRange_SquareRing(posStart, 1, i)
      if table.Vector2Include(ringRange, posEnd) then
        dis = i
        break
      end
    end
    targetEntity = notify:GetDefender()
  end
  return dis, targetEntity
end
