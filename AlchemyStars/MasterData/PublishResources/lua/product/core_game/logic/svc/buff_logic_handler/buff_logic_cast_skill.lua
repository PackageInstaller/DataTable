_class("BuffLogicCastSkill", BuffLogicBase)
BuffLogicCastSkill = BuffLogicCastSkill

function BuffLogicCastSkill:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
  self._skillHolderName = logicParam.skillHolderName
  self._skillHolderType = logicParam.skillHolderType or SkillHolderType.DefaultSkillRoutine
  self._useNotifyEntityPos = logicParam.useNotifyEntityPos or 0
  self._notSetLocation = logicParam.notSetLocation or 0
  self._useNotifyPos = logicParam.useNotifyPos or 0
  self._startTask = logicParam.startTask or 0
  self._useSuperView = logicParam.useSuperView or 0
  self._useSuperAttr = logicParam.useSuperAttr or 1
  self._useSuperPetAttackData = logicParam.useSuperPetAttackData or 0
  self._checkFinalAttack = logicParam.checkFinalAttack or 0
  self._viewMatchUseLayerCount = logicParam.viewMatchUseLayerCount or 0
  self._notifyIsOwnerSummoner = logicParam.notifyIsOwnerSummoner or 0
  self._checkTrapDie = logicParam.checkTrapDie
  self._checkMonsterDie = logicParam.checkMonsterDie
  self._useNotifyEntityTeamPos = logicParam.useNotifyEntityTeamPos or 0
  self._useNotifyBodyArea = logicParam.useNotifyBodyArea or 0
  self._createSkillHolderEveryTime = logicParam.createSkillHolderEveryTime or 0
  self._useBuffCasterAlignment = logicParam.useBuffCasterAlignment
  self._overrideSkillScopeByBuff = logicParam.overrideSkillScopeByBuff
  self._useNotifyConvertScope = logicParam.useNotifyConvertScope
  self._viewMatchUseLayerCountAndTotalCount = logicParam.viewMatchUseLayerCountAndTotalCount or 0
end

function BuffLogicCastSkill:DoLogic(notify, triggers)
  local e = self._buffInstance:Entity()
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local skillHolder
  if self._skillHolderName == "self" then
    skillHolder = e
  else
    if not self._skillHolderName then
      local entityService = self._world:GetService("LogicEntity")
      skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
      local skillHolderName = "SkillHolder" .. skillHolder:GetID()
      if self._createSkillHolderEveryTime == 0 then
        self._skillHolderName = skillHolderName
      end
      e:AddSkillHolder(skillHolderName, skillHolder:GetID())
      skillHolder:AddSuperEntity(e)
      skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
      local alignmentEntity = e
      if self._useBuffCasterAlignment then
        local context = self._buffInstance:Context()
        if context then
          local casterEntity = context.casterEntity
          if casterEntity then
            alignmentEntity = casterEntity
          end
        end
      end
      skillHolder:ReplaceAlignment(alignmentEntity:Alignment():GetAlignmentType())
      skillHolder:ReplaceGameTurn(alignmentEntity:GameTurn():GetGameTurn())
    else
      local skillHolderID = e:GetSkillHolder(self._skillHolderName)
      if not skillHolderID then
        local entityService = self._world:GetService("LogicEntity")
        skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
        e:AddSkillHolder(self._skillHolderName, skillHolder:GetID())
        skillHolder:AddSuperEntity(e)
        skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
        local alignmentEntity = e
        if self._useBuffCasterAlignment then
          local context = self._buffInstance:Context()
          if context then
            local casterEntity = context.casterEntity
            if casterEntity then
              alignmentEntity = casterEntity
            end
          end
        end
        skillHolder:ReplaceAlignment(alignmentEntity:Alignment():GetAlignmentType())
        skillHolder:ReplaceGameTurn(alignmentEntity:GameTurn():GetGameTurn())
      else
        skillHolder = self._world:GetEntityByID(skillHolderID)
      end
    end
    if self._useSuperAttr == 1 then
      local superAttributesComponent = e:Attributes()
      if not skillHolder:HasAttributes() then
        skillHolder:AddAttributes()
      end
      local modifierDic = superAttributesComponent:CloneAttributes()
      skillHolder:Attributes():SetModifierDic(modifierDic)
      local element = e:Element()
      skillHolder:ReplaceElement(element:GetPrimaryType(), element:GetSecondaryType())
    end
    if self._useSuperView == 1 then
      skillHolder:SuperEntityComponent():SetUseSuperEntityViewState(true)
    end
    if self._useSuperPetAttackData == 1 then
      skillHolder:SuperEntityComponent():SetUseSuperPetAttackData(true)
    end
  end
  if self._useNotifyEntityPos == 1 then
    local posEntity = e
    if e:HasSuperEntity() then
      posEntity = e:GetSuperEntity()
    end
    skillHolder:SetGridPosition(posEntity:GetGridPosition())
    skillHolder:ReplaceBodyArea(posEntity:BodyArea():GetArea())
  end
  if self._useNotifyEntityTeamPos == 1 then
    local posEntity = e
    if e:HasSuperEntity() then
      posEntity = e:GetSuperEntity()
    end
    if posEntity:HasPet() then
      skillHolder:ReplaceBodyArea(posEntity:BodyArea():GetArea())
      posEntity = posEntity:Pet():GetOwnerTeamEntity()
      skillHolder:SetGridPosition(posEntity:GetGridPosition())
    end
  end
  if self._useNotifyPos == 1 then
    skillHolder:SetGridPosition(notify:GetNotifyPos())
    skillHolder:ReplaceBodyArea(e:BodyArea():GetArea())
  end
  if self._useNotifyBodyArea == 1 then
    skillHolder:ReplaceBodyArea(notify:GetNotifyBodyArea())
  end
  local overrideScopeResult
  if self._overrideSkillScopeByBuff then
    local cBuff = self:GetEntity():BuffComponent()
    overrideScopeResult = cBuff:GetBuffValue(string.format(BattleConst.BuffCalcScopeKeyFormat, self._overrideSkillScopeByBuff))
  end
  if notify and notify:GetNotifyType() == NotifyType.GridConvertSubordinate and self._useNotifyConvertScope then
    local centerPos = self:GetEntity():GetGridPosition()
    local range = notify:GetConvertScope()
    if range then
      overrideScopeResult = SkillScopeResult:New(SkillScopeType.Cross, centerPos, range, range)
    else
      return
    end
  end
  Log.info("Skill Record cast skill, buff skillID=", self._skillID, " casterEntityID=", skillHolder:GetID())
  local uniqueBattleStat = self._world:BattleStat()
  uniqueBattleStat:AffixBeginSkillDamageRecord(skillHolder:GetID(), self._skillID)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(skillHolder, self._skillID, nil, overrideScopeResult)
  local affixRecordSkillDamageTargetCount = uniqueBattleStat:AffixEndSkillDamageRecordAndGetCount(skillHolder:GetID(), self._skillID)
  Log.info("Skill Record end skill, buff skillID=", self._skillID, " casterEntityID=", skillHolder:GetID(), " targetCount=", affixRecordSkillDamageTargetCount)
  local calcEndNotify = NTBuffLogicCastSkillCalcEffectEnd:New(skillHolder, self._skillID)
  calcEndNotify:SetSkillDamageTargetCount(affixRecordSkillDamageTargetCount)
  self._world:GetService("Trigger"):Notify(calcEndNotify)
  local buffResult = BuffResultCastSkill:New(self._skillID, skillHolder:GetID(), self._skillHolderType, e:GetGridPosition())
  buffResult:SetTrigger(triggers)
  buffResult:SetStartTask(self._startTask)
  buffResult:SetUseSuperEntityView(self._useSuperView)
  buffResult:SetCheckFinalAttack(self._checkFinalAttack)
  buffResult:SetNotifyIsOwnerSummoner(self._notifyIsOwnerSummoner)
  local attackPos, targetId
  if self._skillHolderType == SkillHolderType.AttackPosTargetId then
    local castSkillOnPosAndTarget = BuffResultCastSkillOnPosAndTarget:New()
    attackPos = notify:GetAttackPos()
    targetId = notify:GetDefenderEntity():GetID()
    local result = skillHolder:SkillContext():GetResultContainer()
    castSkillOnPosAndTarget:AddSkillResult(attackPos, targetId, result)
    skillHolder:ReplaceSkillContext()
    buffResult:SetTarget(targetId, attackPos)
    buffResult:SetSkillResultOnPosAndTarget(castSkillOnPosAndTarget)
  elseif self._skillHolderType == SkillHolderType.MovePos then
    local castSkillOnPos = BuffResultCastSkillOnPos:New()
    local pos = self:GetCasterSkillOnMovePosByNotify(notify)
    local result = skillHolder:SkillContext():GetResultContainer()
    castSkillOnPos:AddSkillResult(pos, result)
    skillHolder:ReplaceSkillContext()
    buffResult:SetMovePos(pos)
    buffResult:SetSkillResultOnPos(castSkillOnPos)
  else
    local result = skillHolder:SkillContext():GetResultContainer()
    buffResult:SetSkillResult(result)
    skillHolder:ReplaceSkillContext()
  end
  if notify then
    if notify:GetNotifyType() == NotifyType.Teleport then
      buffResult:SetTeleportPos(notify:GetPosOld(), notify:GetPosNew())
    end
    if notify:GetNotifyType() == NotifyType.PlayerHPChange then
      buffResult:SetPlayerHPChangeData(notify:GetNotifyEntity():GetID(), notify:GetDamageSrcEntity(), notify:GetHPPercent(), notify:GetChangeHP())
    end
    if notify:GetNotifyType() == NotifyType.MonsterDead then
      local deadMonsterEntity = notify:GetNotifyEntity()
      buffResult:SetDeadEntityID(deadMonsterEntity:GetID())
    end
    if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
      local lbsvc = self._world:GetService("BuffLogic")
      local count = lbsvc:GetBuffTotalLayer(e, notify:GetLayerName())
      buffResult:SetTotalLayer(count)
      buffResult:SetLayerName(notify:GetLayerName())
      local curLayer = lbsvc:GetBuffLayer(e, notify:GetLayerType())
      buffResult:SetCurLayer(curLayer)
      buffResult:SetUseCurAndTotalLayer(self._viewMatchUseLayerCountAndTotalCount)
      if self._viewMatchUseLayerCount == 1 then
        local layer = notify:GetLayer()
        buffResult:SetViewMatchUseLayerCount(self._viewMatchUseLayerCount)
        buffResult:SetLayer(layer)
      end
    end
    if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
      buffResult:SetNotifyMoveEndPos(notify:GetPos())
    end
    if notify:GetNotifyType() == NotifyType.SyncMoveEachMoveEnd then
      buffResult:SetNotifyMoveEndPos(notify:GetPos())
      local pathIndex = notify:GetPathIndex()
      buffResult:SetNotifySyncMovePathIndex(pathIndex)
    end
    if notify:GetNotifyType() == NotifyType.HitBackEnd then
      buffResult:SetNotifyMoveEndPos(notify:GetPosEnd())
    end
    if notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd then
      buffResult:SetNotifyMoveEndPos(notify:GetPos())
    end
    if notify:GetNotifyType() == NotifyType.GridConvert then
      local attackPos = {}
      local oldPosIndexPieceType = {}
      local newPosIndexPieceType = {}
      for _, info in ipairs(notify:GetConvertInfoArray()) do
        table.insert(attackPos, info:GetPos())
        local posIndex = Vector2.Pos2Index(info:GetPos())
        local oldPieceType = info:GetBeforePieceType()
        local newPieceType = info:GetAfterPieceType()
        oldPosIndexPieceType[posIndex] = oldPieceType
        newPosIndexPieceType[posIndex] = newPieceType
      end
      buffResult:SetAttackPosArray(attackPos)
      buffResult:SetGridConvertOldPosIndexPieceType(oldPosIndexPieceType)
      buffResult:SetGridConvertNewPosIndexPieceType(newPosIndexPieceType)
      buffResult:SetNotifyEntityID(notify:GetNotifyEntity():GetID())
    end
    if notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd then
      buffResult:SetSuperGridTriggerEndPos(notify:GetTriggerPos())
    end
    if notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
      buffResult:SetPoorGridTriggerEndPos(notify:GetTriggerPos())
    end
    if notify:GetNotifyType() == NotifyType.TrapSkillStart then
      local superGridTriggerSkillID = 500202
      if notify:GetSkillID() == superGridTriggerSkillID then
        buffResult:SetIsSuperGridTriggerStart(true)
        if notify:GetIsActiveSkillFake() then
          buffResult:SetSuperGridTriggerStartByActiveSkill(true)
        end
      end
      buffResult:SetSuperGridTriggerStartPos(notify:GetNotifyPos())
    end
    local pet1601671 = {
      NotifyType.Pet1601781SkillHolder1,
      NotifyType.Pet1601781SkillHolder2,
      NotifyType.Pet1601781SkillHolder3
    }
    if table.icontains(pet1601671, notify:GetNotifyType()) then
      buffResult:ReplaceCasterPos(notify:GetCasterPos())
      buffResult:SetPet1601781MultiCastCount(notify:GetMultiCastCount())
    end
    if notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
      buffResult:SetPetAbsorbSuperGridTrapPos(notify:GetNotifyPos())
    end
    if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
      buffResult:SetMonsterWalkPos(notify:GetWalkPos())
    end
    if notify:GetNotifyType() == NotifyType.ChainSkillAttackEnd then
      buffResult:SetNotifyEntityID(notify:GetNotifyEntity():GetID())
      buffResult:SetNotifyChainSkillId(notify:GetChainSkillId())
      buffResult:SetNotifyChainSkillTimeIndex(notify:GetChainSkillTimeIndex())
      buffResult:SetNotifyChainSkillStageIndex(notify:GetChainSkillStageIndex())
    end
    if notify:GetNotifyType() == NotifyType.EntityMoveEnd then
      local walkPos = notify:GetPosNew()
      buffResult:SetNotifyMoveEndPos(walkPos)
    end
    if notify.GetNormalAttackIndex then
      buffResult:SetNormalAttackIndex(notify:GetNormalAttackIndex())
    end
  end
  buffResult:SetNotSetLocation(self._notSetLocation)
  if self._checkTrapDie then
    self:_DoLogicTrapDie()
  end
  if self._checkMonsterDie then
    local deadIDList = self:_DoLogicMonsterDead()
    buffResult:SetSkillDeadMonsterEntityIDList(deadIDList)
  end
  return buffResult
end

function BuffLogicCastSkill:GetCasterSkillOnMovePosByNotify(notify)
  local utilCalc = self._world:GetService("UtilCalc")
  return utilCalc:GetCastSkillOnMovePosByNotify(notify)
end

function BuffLogicCastSkill:_DoLogicTrapDie()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:CalcAllTrapDeadMark()
  local data = DataDeadMarkResult:New()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if e:HasDeadMark() then
      data:AddDeadEntityID(e:GetID())
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function BuffLogicCastSkill:_DoLogicMonsterDead()
  local drops = {}
  local deadEntityIDList = {}
  self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local deadEntityList = {}
  for _, id in ipairs(deadEntityIDList) do
    deadEntityList[#deadEntityList + 1] = self._world:GetEntityByID(id)
  end
  return deadEntityIDList
end

function BuffLogicCastSkill:_DoLogicCheckNewDead()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local cAttributes = e:Attributes()
    local curHp = cAttributes:GetCurrentHP()
    if curHp <= 0 and not e:HasDeadMark() then
      return true
    end
  end
  return false
end

function BuffLogicCastSkill:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    sMonsterShowLogic:AddMonsterDeadMark(e)
  end
  local tmpDrops, tmpDeadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic()
  table.appendArray(drops, tmpDrops)
  table.appendArray(deadEntityIDList, tmpDeadEntityIDList)
  local hasNewDead = self:_DoLogicCheckNewDead()
  if hasNewDead then
    self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  end
end

function BuffLogicCastSkill:_OnSyncBuffFormSuperToSkillHolder(e, skillHolder)
  local superBuffCmpt = e:BuffComponent()
  local skillHolderBuffCmpt = skillHolder:BuffComponent()
  local lockHPAlways = superBuffCmpt:GetBuffValue("LockHPAlways")
  local lockHPByRound = superBuffCmpt:GetBuffValue("LockHPByRound")
  local lockHPType = superBuffCmpt:GetBuffValue("LockHPType")
  local lockHPList = superBuffCmpt:GetBuffValue("LockHPList")
  skillHolderBuffCmpt:SetBuffValue("LockHPAlways", lockHPAlways)
  skillHolderBuffCmpt:SetBuffValue("LockHPByRound", lockHPByRound)
  skillHolderBuffCmpt:SetBuffValue("LockHPType", lockHPType)
  skillHolderBuffCmpt:SetBuffValue("LockHPList", lockHPList)
end
