_class("BuffViewCastSkill", BuffViewBase)
BuffViewCastSkill = BuffViewCastSkill

function BuffViewCastSkill:IsNotifyMatch(notify)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local skillHolder = self._world:GetEntityByID(result:GetSkillHolderID())
  local skillHolderType = result:GetSkillHolderType()
  local attackPos = result:GetTargetPos()
  local targetId = result:GetTargetID()
  local casterPos = result:GetCastPos()
  if skillHolderType == SkillHolderType.AttackPosTargetId then
    local entity = self._entity
    if self._entity:HasTeam() then
      entity = self._entity:GetTeamLeaderPetEntity()
    end
    local attackIndexMatch = true
    if result:GetNormalAttackIndex() and notify.GetNormalAttackIndex and notify:GetNormalAttackIndex() then
      attackIndexMatch = result:GetNormalAttackIndex() == notify:GetNormalAttackIndex()
    end
    return attackPos == notify:GetAttackPos() and targetId == notify:GetDefenderEntity():GetID() and notify:GetNotifyEntity():GetID() == entity:GetID() and attackIndexMatch
  end
  if skillHolderType == SkillHolderType.MovePos then
    local pos = result:GetMovePos()
    return result:GetMovePos() == self:GetCasterSkillOnMovePosByNotify(notify)
  end
  if notify:GetNotifyType() == NotifyType.GridConvert then
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity == self._entity then
      return false
    end
    if not notifyEntity:HasRenderBoard() and result:GetNotifyEntityID() ~= notifyEntity:GetID() then
      return false
    end
    if self:HasTriggerType(TriggerType.PossessedGridConverted) then
      local convertInfoArray = notify:GetConvertInfoArray()
      for _, convertInfo in ipairs(convertInfoArray) do
        local pos = convertInfo:GetPos()
        if pos == casterPos then
          local oldPieceType = convertInfo:GetBeforePieceType()
          local newPieceType = convertInfo:GetAfterPieceType()
          local posIndex2OldPieceType = result:GetGridConvertOldPosIndexPieceType()
          local posIndex2NewPieceType = result:GetGridConvertNewPosIndexPieceType()
          local posIndex = Vector2.Pos2Index(pos)
          if oldPieceType == posIndex2OldPieceType[posIndex] and newPieceType == posIndex2NewPieceType[posIndex] then
            return true
          end
        end
      end
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.Teleport then
    local posOld, posNew = result:GetTeleportPos()
    return posOld == notify:GetPosOld() and posNew == notify:GetPosNew()
  end
  if notify:GetNotifyType() == NotifyType.PlayerHPChange then
    local defenderID, casterID, hPPercent, changeHP = result:GetPlayerHPChangeData()
    return defenderID == notify:GetNotifyEntity():GetID() and casterID == notify:GetDamageSrcEntity() and (notify:GetMaxHP() == 0 or hPPercent == notify:GetHPPercent()) and changeHP == notify:GetChangeHP()
  end
  if notify:GetNotifyType() == NotifyType.MonsterDead then
    local deadEntityID = result:GetDeadEntityID()
    local deadMonsterEntity = notify:GetNotifyEntity()
    return deadEntityID == deadMonsterEntity:GetID()
  end
  if notify.__attackPosMatchRequired and notify:GetNotifyType() == NotifyType.GridConvert then
    local attackPos = {}
    for _, info in ipairs(notify:GetConvertInfoArray()) do
      table.insert(attackPos, info:GetPos())
    end
    local attackPosMatch = false
    for _, v2 in ipairs(attackPos) do
      attackPosMatch = attackPosMatch or table.icontains(result:GetAttackPosArray(), v2)
    end
    return attackPosMatch
  end
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    if notify:GetLayerName() ~= result:GetLayerName() then
      return false
    end
    local viewMatchUseLayerCount = result:GetViewMatchUseLayerCount()
    if viewMatchUseLayerCount then
      return result:GetLayer() == n:GetLayer()
    else
      if result:IsUseCurAndTotalLayer() and result:GetCurLayer() ~= n:GetLayer() then
        return false
      end
      if result:GetTotalLayer() ~= n:GetTotalCount() then
        return false
      end
    end
  end
  if notify and notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    return result:GetNotifyMoveEndPos() == notify:GetPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.SyncMoveEachMoveEnd then
    local bMatch = result:GetNotifyMoveEndPos() == notify:GetPos() and result:GetNotifySyncMovePathIndex() == notify:GetPathIndex()
    return bMatch
  end
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    return result:GetNotifyMoveEndPos() == notify:GetPosEnd()
  end
  if notify and notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd then
    return result:GetNotifyMoveEndPos() == notify:GetPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd then
    return result:GetSuperGridTriggerEndPos() == notify:GetTriggerPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
    return result:GetPoorGridTriggerEndPos() == notify:GetTriggerPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.TrapSkillStart then
    local superGridTriggerSkillID = 500202
    if notify:GetSkillID() == superGridTriggerSkillID and result:GetIsSuperGridTriggerStart() then
      if notify:GetIsActiveSkillFake() then
        if result:IsSuperGridTriggerStartByActiveSkill() then
          return true
        else
          return false
        end
      elseif result:GetSuperGridTriggerStartPos() == notify:GetNotifyPos() then
        return true
      else
        return false
      end
    end
    if result:GetSuperGridTriggerStartPos() and notify:GetNotifyPos() then
      return result:GetSuperGridTriggerStartPos() == notify:GetNotifyPos()
    end
  end
  local pet1601671 = {
    NotifyType.Pet1601781SkillHolder1,
    NotifyType.Pet1601781SkillHolder2,
    NotifyType.Pet1601781SkillHolder3
  }
  if notify and table.icontains(pet1601671, notify:GetNotifyType()) then
    local chainSkillTypes = {
      SkillEffect_WeikeNotify_SkillType.ChainSkill1,
      SkillEffect_WeikeNotify_SkillType.ChainSkill2,
      SkillEffect_WeikeNotify_SkillType.ChainSkill3
    }
    local triggerSkillType = notify:GetSkillType()
    if not table.icontains(chainSkillTypes, triggerSkillType) then
      return notify:GetCasterPos() == casterPos
    else
      local isPosValid = notify:GetCasterPos() == casterPos
      local isMultiCastCountValid = notify:GetMultiCastCount() == result:GetPet1601781MultiCastCount()
      return isPosValid and isMultiCastCountValid
    end
  end
  if notify and notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
    return result:GetPetAbsorbSuperGridTrapPos() == notify:GetNotifyPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    return result:GetMonsterWalkPos() == notify:GetWalkPos()
  end
  if notify and notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    return result:GetNotifyMoveEndPos() == notify:GetPosNew()
  end
  if notify and notify:GetNotifyType() == NotifyType.ChainSkillAttackEnd then
    local entityCheckPass = false
    local atkEntity = notify:GetNotifyEntity()
    if atkEntity then
      entityCheckPass = result:GetNotifyEntityID() == atkEntity:GetID()
    end
    local skillTimeIndexPass = result:GetNotifyChainSkillTimeIndex() == notify:GetChainSkillTimeIndex()
    local skillStageIndexPass = notify.GetChainSkillStageIndex and result:GetNotifyChainSkillStageIndex() == notify:GetChainSkillStageIndex()
    local skillIdPass = result:GetNotifyChainSkillId() == notify:GetChainSkillId()
    return entityCheckPass and skillTimeIndexPass and skillStageIndexPass and skillIdPass
  end
  if result:GetNotifyIsOwnerSummoner() == 1 then
    local ownerSummonerEntity = self._entity:GetSummonerEntity()
    if not ownerSummonerEntity then
      return false
    end
    return notify:GetNotifyEntity():GetID() == ownerSummonerEntity:GetID()
  end
  local triggers = result:GetTrigger()
  if triggers then
    for i = 1, #triggers do
      local trigger = triggers[i]
      if trigger:GetTriggerType() == TriggerType.NotifyMe then
        if notify:GetNotifyEntity() == self._entity then
          return true
        else
          return false
        end
      end
    end
  end
  return true
end

function BuffViewCastSkill:PlayView(TT, notify)
  local result = self._buffResult
  local skillID = result:GetSkillID()
  local skillHolder = self._world:GetEntityByID(result:GetSkillHolderID())
  local skillHolderType = result:GetSkillHolderType()
  local attackPos = result:GetTargetPos()
  local targetId = result:GetTargetID()
  local casterPos = result:GetCastPos()
  local startTask = result:GetStartTask()
  local useSuperView = result:GetUseSuperEntityView()
  local deadMonsterEntityIdList = result:GetSkillDeadMonsterEntityIDList()
  if deadMonsterEntityIdList then
    for _, eid in ipairs(deadMonsterEntityIdList) do
      local e = self._world:GetEntityByID(eid)
      e:AddDeadFlag()
    end
  end
  if skillHolderType == SkillHolderType.AttackPosTargetId then
    local castSkillOnPosAndTarget = result:GetSkillResultOnPosAndTarget()
    local attackPos = notify:GetAttackPos()
    local targetId = notify:GetDefenderEntity():GetID()
    local skillResult = castSkillOnPosAndTarget:GetSkillResult(attackPos, targetId)
    if not skillResult then
      Log.error("BuffViewCastSkill AttackPosTargetId no result! attackPos=", attackPos, " targetId=", targetId)
      return
    end
    skillHolder:SkillRoutine():SetResultContainer(skillResult)
    Log.debug("BuffViewCastSkill skillID=", skillID, " attackPos=", attackPos, " targetId=", targetId)
  elseif skillHolderType == SkillHolderType.MovePos then
    local castSkillOnPos = result:GetSkillResultOnPos()
    local movePos = self:GetCasterSkillOnMovePosByNotify(notify)
    local skillResult = castSkillOnPos:GetSkillResult(movePos)
    if not skillResult then
      Log.error("BuffViewCastSkill MovePos no result! movePos=", movePos)
      return
    end
    skillHolder:SkillRoutine():SetResultContainer(skillResult)
    Log.debug("BuffViewCastSkill skillID=", skillID, " movePos=", movePos)
  else
    local skillResult = result:GetSkillResult()
    skillHolder:SkillRoutine():SetResultContainer(skillResult)
  end
  if not skillHolder:HasEffectController() and result:GetNotSetLocationState() == 0 then
    skillHolder:SetPosition(skillHolder:GetGridPosition() + skillHolder:GetGridOffset())
  end
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  self:_PatchFinalAttackForSpecificPet(skillHolder, result)
  if startTask == 0 then
    playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
    if deadMonsterEntityIdList and 0 < #deadMonsterEntityIdList then
      local sMonsterShowRender = self._world:GetService("MonsterShowRender")
      sMonsterShowRender:DoAllMonsterDeadRender(TT)
    end
  else
    local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
      if deadMonsterEntityIdList and 0 < #deadMonsterEntityIdList then
        local sMonsterShowRender = self._world:GetService("MonsterShowRender")
        sMonsterShowRender:DoAllMonsterDeadRender(TT)
      end
    end)
    playSkillSvc:AddWaitFreeTask(nTaskID)
  end
end

function BuffViewCastSkill:_PatchFinalAttackForSpecificPet(skillHolder, result)
  if not skillHolder:EntityType():IsSkillHolder() then
    return
  end
  local container = skillHolder:SkillRoutine():GetResultContainer()
  local utilData = skillHolder:GetOwnerWorld():GetService("UtilData")
  local checkFinalAttack = result:GetCheckFinalAttack()
  if checkFinalAttack == 1 and utilData:IsFinalAttack() then
    container:SetFinalAttack(true)
  end
  local casterEntity = skillHolder:GetSuperEntity()
  if not casterEntity:HasPetPstID() then
    return
  end
end

function BuffViewCastSkill:GetCasterSkillOnMovePosByNotify(notify)
  local utilCalc = self._world:GetService("UtilCalc")
  return utilCalc:GetCastSkillOnMovePosByNotify(notify)
end
