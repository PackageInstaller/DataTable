_class("BuffLogicCalcMoveScopeAndRecord", BuffLogicBase)
BuffLogicCalcMoveScopeAndRecord = BuffLogicCalcMoveScopeAndRecord

function BuffLogicCalcMoveScopeAndRecord:Constructor(buffInstance, logicParam)
end

function BuffLogicCalcMoveScopeAndRecord:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local moveScopeRecordCmpt = e:MoveScopeRecord()
  if not moveScopeRecordCmpt then
    Log.debug("BuffLogicCalcMoveScopeAndRecord no moveScopeRecord cmpt , entity=", e:GetID())
    return
  end
  if notify:GetNotifyType() ~= NotifyType.EntityMoveEnd then
    return
  end
  local moveEndNotify = notify
  local parentNotifyType = moveEndNotify:GetParentNotifyType()
  local moveScope = {}
  local posOld = moveEndNotify:GetPosOld()
  local posNew = moveEndNotify:GetPosNew()
  local offSet = moveScopeRecordCmpt:GetMoveOffSet()
  local posOldWithOffSet = posOld + offSet
  local posNewWithOffSet = posNew + offSet
  if parentNotifyType == NotifyType.HitBackEnd or parentNotifyType == NotifyType.TractionEnd or parentNotifyType == NotifyType.ForceMovement then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalculator = SkillScopeCalculator:New(utilScopeSvc)
    local scopeAngleFreeLine = SkillScopeCalculator_AngleFreeLine:New(scopeCalculator)
    local attackRange = {}
    local wholeRange = {}
    local fakeBodyArea = {
      Vector2(0, 0)
    }
    local scopeResult = scopeAngleFreeLine:CalcRange(nil, {noExtend = 1}, posNewWithOffSet, fakeBodyArea, nil, nil, posOldWithOffSet)
    table.Vector2Append(attackRange, scopeResult:GetAttackRange())
    moveScope = attackRange
  else
    table.insert(moveScope, posOldWithOffSet)
    table.insert(moveScope, posNewWithOffSet)
  end
  Log.debug("BuffLogicCalcMoveScopeAndRecord moveScope count =", #moveScope)
  moveScopeRecordCmpt:RecordMoveScope(moveScope)
end
