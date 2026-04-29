_class("BuffResultCastSkill", BuffResultBase)
BuffResultCastSkill = BuffResultCastSkill

function BuffResultCastSkill:Constructor(skillID, skillHolderID, skillHolderType, castPos)
  self._skillID = skillID
  self._skillHolderID = skillHolderID
  self._skillHolderType = skillHolderType
  self._castPos = castPos
  self._notSetLocation = 0
  self._attackPosArray = {}
  self._skillDeadMonsterEntityIDList = {}
end

function BuffResultCastSkill:GetSkillID()
  return self._skillID
end

function BuffResultCastSkill:GetSkillHolderID()
  return self._skillHolderID
end

function BuffResultCastSkill:GetSkillHolderType()
  return self._skillHolderType
end

function BuffResultCastSkill:GetCastPos()
  return self._castPos
end

function BuffResultCastSkill:SetTarget(targetId, targetPos)
  self._targetID = targetId
  self._targetPos = targetPos
end

function BuffResultCastSkill:GetTargetID()
  return self._targetID
end

function BuffResultCastSkill:GetTargetPos()
  return self._targetPos
end

function BuffResultCastSkill:SetSkillResultOnPosAndTarget(res)
  self._skillResultOnPosAndTarget = res
end

function BuffResultCastSkill:GetSkillResultOnPosAndTarget()
  return self._skillResultOnPosAndTarget
end

function BuffResultCastSkill:SetTeleportPos(oldpos, newpos)
  self._oldPos = oldpos
  self._newPos = newpos
end

function BuffResultCastSkill:GetTeleportPos()
  return self._oldPos, self._newPos
end

function BuffResultCastSkill:SetTrigger(triggers)
  self._trigger = triggers
end

function BuffResultCastSkill:GetTrigger()
  return self._trigger
end

function BuffResultCastSkill:SetStartTask(task)
  self._startTask = task
end

function BuffResultCastSkill:GetStartTask()
  return self._startTask
end

function BuffResultCastSkill:SetUseSuperEntityView(use)
  self._useSuperEntityView = use
end

function BuffResultCastSkill:GetUseSuperEntityView()
  return self._useSuperEntityView
end

function BuffResultCastSkill:SetNotSetLocation(state)
  self._notSetLocation = state
end

function BuffResultCastSkill:GetNotSetLocationState()
  return self._notSetLocation
end

function BuffResultCastSkill:SetSkillResult(result)
  self._skillResult = result
end

function BuffResultCastSkill:GetSkillResult()
  return self._skillResult
end

function BuffResultCastSkill:SetPlayerHPChangeData(defenderID, casterID, hPPercent, changeHP)
  self._playerHPChangeDefenderID = defenderID
  self._playerHPChangeCasterID = casterID
  self._playerHPChangehPPercent = hPPercent
  self._playerHPChangeChangeHP = changeHP
end

function BuffResultCastSkill:GetPlayerHPChangeData()
  return self._playerHPChangeDefenderID, self._playerHPChangeCasterID, self._playerHPChangehPPercent, self._playerHPChangeChangeHP
end

function BuffResultCastSkill:SetDeadEntityID(id)
  self._deadEntityID = id
end

function BuffResultCastSkill:GetDeadEntityID()
  return self._deadEntityID
end

function BuffResultCastSkill:SetCheckFinalAttack(checkFinalAttack)
  self._checkFinalAttack = checkFinalAttack
end

function BuffResultCastSkill:GetCheckFinalAttack()
  return self._checkFinalAttack
end

function BuffResultCastSkill:SetTotalLayer(n)
  self._totalLayerCount = n
end

function BuffResultCastSkill:GetTotalLayer()
  return self._totalLayerCount
end

function BuffResultCastSkill:SetViewMatchUseLayerCount(viewMatchUseLayerCount)
  self._viewMatchUseLayerCount = viewMatchUseLayerCount
end

function BuffResultCastSkill:GetViewMatchUseLayerCount()
  return self._viewMatchUseLayerCount
end

function BuffResultCastSkill:SetLayer(n)
  self._layerCount = n
end

function BuffResultCastSkill:GetLayer()
  return self._layerCount
end

function BuffResultCastSkill:SetLayerName(layerName)
  self._layerName = layerName
end

function BuffResultCastSkill:GetLayerName()
  return self._layerName
end

function BuffResultCastSkill:SetNotifyIsOwnerSummoner(notifyIsOwnerSummoner)
  self._notifyIsOwnerSummoner = notifyIsOwnerSummoner
end

function BuffResultCastSkill:GetNotifyIsOwnerSummoner()
  return self._notifyIsOwnerSummoner
end

function BuffResultCastSkill:SetNotifyMoveEndPos(pos)
  self._notifyMoveEndPos = pos
end

function BuffResultCastSkill:GetNotifyMoveEndPos()
  return self._notifyMoveEndPos
end

function BuffResultCastSkill:SetNotifySyncMovePathIndex(pathIndex)
  self._notifySyncMoveEndPathIndex = pathIndex
end

function BuffResultCastSkill:GetNotifySyncMovePathIndex()
  return self._notifySyncMoveEndPathIndex
end

function BuffResultCastSkill:GetAttackPosArray()
  return self._attackPosArray
end

function BuffResultCastSkill:SetAttackPosArray(t)
  self._attackPosArray = t
end

function BuffResultCastSkill:SetNotifyEntityID(id)
  self._notifyEntityID = id
end

function BuffResultCastSkill:GetNotifyEntityID()
  return self._notifyEntityID
end

function BuffResultCastSkill:SetSuperGridTriggerEndPos(v)
  self._superGridTriggerEndPos = v
end

function BuffResultCastSkill:GetSuperGridTriggerEndPos()
  return self._superGridTriggerEndPos
end

function BuffResultCastSkill:SetPoorGridTriggerEndPos(v)
  self._poorGridTriggerEndPos = v
end

function BuffResultCastSkill:GetPoorGridTriggerEndPos()
  return self._poorGridTriggerEndPos
end

function BuffResultCastSkill:SetIsSuperGridTriggerStart(bSuperGrid)
  self._isSuperGridTriggerStart = bSuperGrid
end

function BuffResultCastSkill:GetIsSuperGridTriggerStart()
  return self._isSuperGridTriggerStart
end

function BuffResultCastSkill:SetSuperGridTriggerStartPos(v)
  self._superGridTriggerStartPos = v
end

function BuffResultCastSkill:GetSuperGridTriggerStartPos()
  return self._superGridTriggerStartPos
end

function BuffResultCastSkill:SetSuperGridTriggerStartByActiveSkill(bActiveSkill)
  self._superGridTriggerStartByActiveSkill = bActiveSkill
end

function BuffResultCastSkill:IsSuperGridTriggerStartByActiveSkill()
  return self._superGridTriggerStartByActiveSkill
end

function BuffResultCastSkill:ReplaceCasterPos(v2)
  self._castPos = v2
end

function BuffResultCastSkill:SetPet1601781MultiCastCount(val)
  self._pet1601781MultiCastCount = val
end

function BuffResultCastSkill:GetPet1601781MultiCastCount()
  return self._pet1601781MultiCastCount
end

function BuffResultCastSkill:SetGridConvertOldPosIndexPieceType(t)
  self._gridConvertOldPosIndexPieceType = t
end

function BuffResultCastSkill:GetGridConvertOldPosIndexPieceType()
  return self._gridConvertOldPosIndexPieceType
end

function BuffResultCastSkill:SetGridConvertNewPosIndexPieceType(t)
  self._gridConvertNewPosIndexPieceType = t
end

function BuffResultCastSkill:GetGridConvertNewPosIndexPieceType()
  return self._gridConvertNewPosIndexPieceType
end

function BuffResultCastSkill:SetPetAbsorbSuperGridTrapPos(v)
  self._petAbsorbSuperGridTrapPos = v
end

function BuffResultCastSkill:GetPetAbsorbSuperGridTrapPos()
  return self._petAbsorbSuperGridTrapPos
end

function BuffResultCastSkill:SetMonsterWalkPos(v)
  self._monsterWalkPos = v
end

function BuffResultCastSkill:GetMonsterWalkPos()
  return self._monsterWalkPos
end

function BuffResultCastSkill:SetNotifyChainSkillTimeIndex(v)
  self._notifyChainSkillTimeIndex = v
end

function BuffResultCastSkill:GetNotifyChainSkillTimeIndex()
  return self._notifyChainSkillTimeIndex
end

function BuffResultCastSkill:SetNotifyChainSkillStageIndex(v)
  self._notifyChainSkillStageIndex = v
end

function BuffResultCastSkill:GetNotifyChainSkillStageIndex()
  return self._notifyChainSkillStageIndex
end

function BuffResultCastSkill:SetNotifyChainSkillId(v)
  self._notifyChainSkillId = v
end

function BuffResultCastSkill:GetNotifyChainSkillId()
  return self._notifyChainSkillId
end

function BuffResultCastSkill:SetCurLayer(layer)
  self._curLayer = layer
end

function BuffResultCastSkill:GetCurLayer()
  return self._curLayer
end

function BuffResultCastSkill:SetUseCurAndTotalLayer(useCurAndTotalLayer)
  self._useCurAndTotalLayer = useCurAndTotalLayer
end

function BuffResultCastSkill:IsUseCurAndTotalLayer()
  return self._useCurAndTotalLayer
end

function BuffResultCastSkill:SetSkillDeadMonsterEntityIDList(idList)
  self._skillDeadMonsterEntityIDList = idList
end

function BuffResultCastSkill:GetSkillDeadMonsterEntityIDList()
  return self._skillDeadMonsterEntityIDList
end

function BuffResultCastSkill:SetMovePos(movePos)
  self._movePos = movePos
end

function BuffResultCastSkill:GetMovePos()
  return self._movePos
end

function BuffResultCastSkill:SetSkillResultOnPos(res)
  self._skillResultOnPos = res
end

function BuffResultCastSkill:GetSkillResultOnPos()
  return self._skillResultOnPos
end

function BuffResultCastSkill:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function BuffResultCastSkill:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end

_class("BuffResultCastSkillOnPosAndTarget", Object)
BuffResultCastSkillOnPosAndTarget = BuffResultCastSkillOnPosAndTarget

function BuffResultCastSkillOnPosAndTarget:Constructor()
  self._holder = {}
end

function BuffResultCastSkillOnPosAndTarget:AddSkillResult(pos, targetId, skillResult)
  local hash = Vector2.Pos2Index(pos)
  local t = self._holder[hash]
  if not t then
    t = {}
    self._holder[hash] = t
  end
  t[targetId] = skillResult
end

function BuffResultCastSkillOnPosAndTarget:GetSkillResult(pos, targetId)
  local hash = Vector2.Pos2Index(pos)
  local t = self._holder[hash]
  if t then
    local ret = t[targetId]
    t[targetId] = nil
    if not next(t) then
      self._holder[hash] = nil
    end
    return ret
  end
end

function BuffResultCastSkillOnPosAndTarget:ClearSkillResults()
  self._holder = {}
end

_class("BuffResultCastSkillOnPos", Object)
BuffResultCastSkillOnPos = BuffResultCastSkillOnPos

function BuffResultCastSkillOnPos:Constructor()
  self._holder = {}
end

function BuffResultCastSkillOnPos:AddSkillResult(pos, skillResult)
  local hash = Vector2.Pos2Index(pos)
  self._holder[hash] = skillResult
end

function BuffResultCastSkillOnPos:GetSkillResult(pos)
  local hash = Vector2.Pos2Index(pos)
  return self._holder[hash]
end

function BuffResultCastSkillOnPos:ClearSkillResults()
  self._holder = {}
end
