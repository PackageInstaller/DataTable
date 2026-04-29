require("play_skill_phase_base_r")
_class("PlaySkillTrainHitBackPhase", PlaySkillPhaseBase)
PlaySkillTrainHitBackPhase = PlaySkillTrainHitBackPhase

function PlaySkillTrainHitBackPhase:PlayFlight(TT, casterEntity, phaseParam)
  local trainHitBackParam = phaseParam
  local hitAnimationName = trainHitBackParam:GetHitAnimationName()
  local hitFirstEffectID = trainHitBackParam:GetHitFirstEffectID()
  local hitRepeatEffectID = trainHitBackParam:GetHitRepeatEffectID()
  local castHideAnimation = trainHitBackParam:GetHideAnimationName()
  local castShowAnimation = trainHitBackParam:GetShowAnimationName()
  local boardCenterPos = trainHitBackParam:GetBoardCenterPos()
  local MultiMonsterHitDelayTime = trainHitBackParam:GetMultiMonsterHitDelayTime()
  local casterInTrainHigh = trainHitBackParam:GetCasterInTrainHigh()
  local hitBackSpeed = trainHitBackParam:GetHitBackSpeed()
  local trainEffectDelay = trainHitBackParam:GetTrainEffectDelay()
  local finishDelayTime = trainHitBackParam:GetFinishDelayTime()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  skillEffectResultContainer:GetEffectResultsAsArray()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local trainEffectID = trainHitBackParam:GetTrainEffectID()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local directionType = renderPickUpComponent:GetLastPickUpDirection()
  self:SetAnimationState(casterEntity)
  casterEntity:SetAnimatorControllerTriggers({castHideAnimation})
  local taskIds = {}
  local taskId = GameGlobal.TaskManager():CoreGameStartTask(self._DoCasterHide, self, trainHitBackParam:GetHideParam(1), casterEntity)
  table.insert(taskIds, taskId)
  YIELD(TT, trainEffectDelay)
  local castPos = casterEntity:GridLocation().Position
  local casterPosition = casterEntity:View():GetGameObject().transform.position
  local trainCenterPos = self:_GetTrainEffectCenterPos(directionType, castPos, boardCenterPos)
  local sEffect = self._world:GetService("Effect")
  local trainEffectEntity = sEffect:CreateWorldPositionDirectionEffect(trainEffectID, trainCenterPos, self:_GetDirection(directionType))
  local CasterGO = casterEntity:View():GetGameObject()
  local lastForward = CasterGO.transform.forward
  self:_DoCasterShow(TT, trainHitBackParam:GetShowParam(1), casterEntity)
  local view = trainEffectEntity:View()
  local trainEffectGO = view:GetGameObject()
  local trainCasterTransForm = GameObjectHelper.FindChild(trainEffectGO.transform, "renwu")
  self:_MoveCasterPosition(casterEntity, trainCasterTransForm.position, casterInTrainHigh)
  local casterForward = self:_GetDirection(directionType)
  CasterGO.transform.forward = Vector3(casterForward.x, 0, casterForward.y)
  local trainEffectEntityID = trainEffectEntity:GetID()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local attackRange = scopeResult:GetAttackRange()
  local boardServiceRender = self._world:GetService("BoardRender")
  local isFinalAttackReal = skillEffectResultContainer:IsFinalAttack()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local targetIDResultArray = skillEffectResultContainer:GetEffectResultsAsTargetIdDic(SkillEffectType.Damage)
  local beHit = {}
  local lastHitTime = {}
  local casterMove = true
  local inBoard = false
  local finalAttack = false
  if isFinalAttackReal then
    self.finalAttackPos, self.finalAttackEntityID = self:_SortIDArray(targetIDResultArray, directionType, attackRange)
    skillEffectResultContainer:SetFinalAttackEntityID(self.finalAttackEntityID)
  end
  local utilDataSvc = self._world:GetService("UtilData")
  while self._world:GetEntityByID(trainEffectEntityID) do
    if casterMove then
      self:_MoveCasterPosition(casterEntity, trainCasterTransForm.position, casterInTrainHigh)
      local trainCasterGridPosition = boardServiceRender:BoardRenderPos2GridPos(trainCasterTransForm.position)
      if utilDataSvc:IsValidPiecePos(trainCasterGridPosition) and not utilDataSvc:IsPosBlock(trainCasterGridPosition, BlockFlag.Skill | BlockFlag.SkillSkip) then
        inBoard = true
      end
    end
    local trainHeadTransForm = GameObjectHelper.FindChild(trainEffectGO.transform, "chetou")
    local trainTailTF = GameObjectHelper.FindChild(trainEffectGO.transform, "chewei")
    local trainHeadPosition = boardServiceRender:BoardRenderPos2GridPos(trainHeadTransForm.position)
    local trainTailPosition = boardServiceRender:BoardRenderPos2GridPos(trainTailTF.position)
    local currentTime = GameGlobal:GetInstance():GetCurrentTime()
    if targetIDResultArray then
      for _, result in pairs(targetIDResultArray) do
        local targetEntityID = result:GetTargetID()
        local targetEntity = self._world:GetEntityByID(targetEntityID)
        if targetEntity ~= nil then
          do
            local targetGridPos = boardServiceRender:GetEntityRealTimeGridPos(targetEntity)
            local monster_body_area_cmpt = targetEntity:BodyArea()
            local monster_body_area = monster_body_area_cmpt:GetArea()
            local monsterBodyArea = {}
            for k, v in pairs(monster_body_area) do
              table.insert(monsterBodyArea, Vector2(targetGridPos.x + v.x, targetGridPos.y + v.y))
            end
            local isInTrainInterval = false
            if not table.intable(beHit, targetEntityID) then
              for k, v in pairs(monsterBodyArea) do
                if self:_InTrainInterval(trainHeadPosition, trainTailPosition, targetGridPos, directionType) then
                  isInTrainInterval = true
                  break
                end
              end
            end
            if isInTrainInterval then
              table.insert(beHit, targetEntityID)
              local resultList = {}
              for k, v in pairs(damageResultArray) do
                if result:GetTargetID() == v:GetTargetID() then
                  table.insert(resultList, v)
                end
              end
              if 1 < #resultList then
                local firstHit, SencondHit = self:SortMonsterBeHit(monsterBodyArea, resultList, attackRange, directionType)
                for k, v in ipairs(firstHit) do
                  finalAttack = self:_IsRealFinalAttack(isFinalAttackReal, v:GetGridPos(), targetEntity:GetID())
                  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitFirstEffectID):SetHandleBeHitParam_DamageInfo(v:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(v:GetGridPos()):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(finalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_HitBackSpeed(hitBackSpeed)
                  local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
                    self:SkillService():HandleBeHit(TT, beHitParam)
                  end)
                  table.insert(taskIds, taskId)
                end
                YIELD(TT, MultiMonsterHitDelayTime)
                for k, v in ipairs(SencondHit) do
                  finalAttack = self:_IsRealFinalAttack(isFinalAttackReal, v:GetGridPos(), targetEntity:GetID())
                  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitRepeatEffectID):SetHandleBeHitParam_DamageInfo(v:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(v:GetGridPos()):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(finalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_HitBackSpeed(hitBackSpeed)
                  local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
                    self:SkillService():HandleBeHit(TT, beHitParam)
                  end)
                  table.insert(taskIds, taskId)
                end
              else
                finalAttack = self:_IsRealFinalAttack(isFinalAttackReal, resultList[1]:GetGridPos(), targetEntity:GetID())
                local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitFirstEffectID):SetHandleBeHitParam_DamageInfo(resultList[1]:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(resultList[1]:GetGridPos()):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(finalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_HitBackSpeed(hitBackSpeed)
                local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
                  self:SkillService():HandleBeHit(TT, beHitParam)
                  YIELD(TT, MultiMonsterHitDelayTime)
                  if targetEntity:EffectHolder() then
                    sEffect:CreateEffect(hitRepeatEffectID, targetEntity)
                  end
                end)
                table.insert(taskIds, taskId)
              end
            end
          end
        end
      end
    end
    if casterMove == true and inBoard then
      casterMove = false
      local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        self:_DoCasterHide(TT, trainHitBackParam:GetHideParam(2), casterEntity)
        CasterGO.transform.forward = lastForward
        CasterGO.transform.position = casterPosition
        self:_DoCasterShow(TT, trainHitBackParam:GetShowParam(2), casterEntity)
        casterEntity:SetAnimatorControllerTriggers({castShowAnimation})
      end)
      table.insert(taskIds, taskId)
    end
    YIELD(TT)
  end
  YIELD(TT, finishDelayTime)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
end

function PlaySkillTrainHitBackPhase:_GetTrainEffectCenterPos(directionType, casterPos, boardCenterPos)
  local trainCenterPos = Vector2.zero
  if directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Down then
    trainCenterPos = Vector2(casterPos.x, boardCenterPos.y)
  elseif directionType == HitBackDirectionType.Left or directionType == HitBackDirectionType.Right then
    trainCenterPos = Vector2(boardCenterPos.x, casterPos.y)
  end
  return trainCenterPos
end

function PlaySkillTrainHitBackPhase:_InTrainInterval(trainHeadGridPos, trainTailGridPos, targetGridPos, directionType)
  if directionType == HitBackDirectionType.Up then
    return targetGridPos.y <= trainHeadGridPos.y and targetGridPos.y >= trainTailGridPos.y
  elseif directionType == HitBackDirectionType.Down then
    return targetGridPos.y >= trainHeadGridPos.y and targetGridPos.y <= trainTailGridPos.y
  elseif directionType == HitBackDirectionType.Left then
    return targetGridPos.x >= trainHeadGridPos.x and targetGridPos.x <= trainTailGridPos.x
  elseif directionType == HitBackDirectionType.Right then
    return targetGridPos.x <= trainHeadGridPos.x and targetGridPos.x >= trainTailGridPos.x
  end
end

function PlaySkillTrainHitBackPhase:_GetDirection(directionType)
  if directionType == HitBackDirectionType.Up then
    return Vector2(0, 1)
  elseif directionType == HitBackDirectionType.Down then
    return Vector2(0, -1)
  elseif directionType == HitBackDirectionType.Left then
    return Vector2(-1, 0)
  elseif directionType == HitBackDirectionType.Right then
    return Vector2(1, 0)
  else
    return Vector2(0, 0)
  end
end

function PlaySkillTrainHitBackPhase:_DoCasterHide(TT, param, casterEntity)
  if param.hideEffectDelayTime then
    YIELD(TT, param.hideEffectDelayTime)
  end
  if param.hideEffectID then
    self._world:GetService("Effect"):CreateEffect(param.hideEffectID, casterEntity)
  end
  if param.hideAnimationDelayTime then
    YIELD(TT, param.hideAnimationDelayTime)
  end
  casterEntity:View():GetGameObject():SetActive(false)
end

function PlaySkillTrainHitBackPhase:_DoCasterShow(TT, param, casterEntity)
  if param.showEffectDelayTime then
    YIELD(TT, param.showEffectDelayTime)
  end
  if param.showEffectID then
    self._world:GetService("Effect"):CreateEffect(param.showEffectID, casterEntity)
  end
  if param.showAnimationDelayTime then
    YIELD(TT, param.showAnimationDelayTime)
  end
  casterEntity:View():GetGameObject():SetActive(true)
end

function PlaySkillTrainHitBackPhase:_MoveCasterPosition(casterEntity, trainPosition, high)
  local gameObject = casterEntity:View():GetGameObject()
  gameObject.transform.position = Vector3(trainPosition.x, trainPosition.y + high, trainPosition.z)
end

function PlaySkillTrainHitBackPhase:SetAnimationState(casterEntity)
  local gameObject = casterEntity:View().ViewWrapper.GameObject
  local rootGO = gameObject.transform:Find("Root")
  local animator = rootGO:GetComponent("Animator")
  animator.keepAnimatorControllerStateOnDisable = true
end

function PlaySkillTrainHitBackPhase:SortMonsterBeHit(monsterBodyArea, resultList, attackRange, directionType)
  local beHitPosition = {}
  for k, v in pairs(monsterBodyArea) do
    if table.icontains(attackRange, v) then
      table.insert(beHitPosition, v)
    end
  end
  local cmpFun
  if directionType == HitBackDirectionType.Up then
    function cmpFun(p1, p2)
      if p1.y == p2.y then
        return p1.x < p2.x
      end
      return p1.y < p2.y
    end
  elseif directionType == HitBackDirectionType.Down then
    function cmpFun(p1, p2)
      if p1.y == p2.y then
        return p1.x > p2.x
      end
      return p1.y > p2.y
    end
  elseif directionType == HitBackDirectionType.Left then
    function cmpFun(p1, p2)
      if p1.x == p2.x then
        return p1.y > p2.y
      end
      return p1.x > p2.x
    end
  elseif directionType == HitBackDirectionType.Right then
    function cmpFun(p1, p2)
      if p1.x == p2.x then
        return p1.y < p2.y
      end
      return p1.x < p2.x
    end
  end
  table.sort(beHitPosition, cmpFun)
  local firstIndex = #beHitPosition / 2
  local firstHitResult = {}
  local secondHitResult = {}
  for k, pos in pairs(beHitPosition) do
    for _, v in pairs(resultList) do
      if v:GetGridPos() == pos then
        if k <= firstIndex then
          table.insert(firstHitResult, v)
        else
          table.insert(secondHitResult, v)
        end
      end
    end
  end
  return firstHitResult, secondHitResult
end

function PlaySkillTrainHitBackPhase:_SortIDArray(targetIDResultArray, directionType, attackRange)
  local beHitPosition = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, result in pairs(targetIDResultArray) do
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local monster_body_area_cmpt = targetEntity:BodyArea()
    local monster_body_area = monster_body_area_cmpt:GetArea()
    if targetEntity ~= nil and targetEntity:HasDeadFlag() or targetEntity:HasTeamDeadMark() then
      local targetGridPos = boardServiceRender:GetEntityRealTimeGridPos(targetEntity)
      for _, v in ipairs(monster_body_area) do
        local pos = Vector2(targetGridPos.x + v.x, targetGridPos.y + v.y)
        if table.icontains(attackRange, pos) then
          table.insert(beHitPosition, pos)
        end
      end
    end
  end
  local cmpFun
  if directionType == HitBackDirectionType.Up then
    function cmpFun(p1, p2)
      return p1.y < p2.y
    end
  elseif directionType == HitBackDirectionType.Down then
    function cmpFun(p1, p2)
      return p1.y > p2.y
    end
  elseif directionType == HitBackDirectionType.Left then
    function cmpFun(p1, p2)
      return p1.x > p2.x
    end
  elseif directionType == HitBackDirectionType.Right then
    function cmpFun(p1, p2)
      return p1.x < p2.x
    end
  end
  table.sort(beHitPosition, cmpFun)
  local finalAttackPos = beHitPosition[#beHitPosition]
  local finalEntityID
  for _, result in pairs(targetIDResultArray) do
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity ~= nil then
      local targetGridPos = boardServiceRender:GetEntityRealTimeGridPos(targetEntity)
      local monster_body_area_cmpt = targetEntity:BodyArea()
      local monster_body_area = monster_body_area_cmpt:GetArea()
      for _, v in ipairs(monster_body_area) do
        local pos = Vector2(targetGridPos.x + v.x, targetGridPos.y + v.y)
        if pos == finalAttackPos then
          finalEntityID = targetEntityID
        end
      end
    end
  end
  return finalAttackPos, finalEntityID
end

function PlaySkillTrainHitBackPhase:_IsRealFinalAttack(isFinalAttack, gridPos, entityID)
  if isFinalAttack and self.finalAttackPos then
    return self.finalAttackPos.x == gridPos.x and self.finalAttackPos.y == gridPos.y and self.finalAttackEntityID == entityID
  else
    return false
  end
end

function PlaySkillTrainHitBackPhase:GetCacheResource()
  local t = {}
  if BattleConst.MonsterDeadEffectLight and BattleConst.MonsterDeadEffectLight > 0 then
    table.insert(t, {
      Cfg.cfg_effect[BattleConst.MonsterDeadEffectLight].ResPath,
      1
    })
  end
  if BattleConst.MonsterDeadEffectDark and 0 < BattleConst.MonsterDeadEffectDark then
    table.insert(t, {
      Cfg.cfg_effect[BattleConst.MonsterDeadEffectDark].ResPath,
      1
    })
  end
  return t
end
