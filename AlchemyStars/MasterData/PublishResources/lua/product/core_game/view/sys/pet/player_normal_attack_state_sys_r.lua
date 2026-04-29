_class("PlayerNormalAttackStateSystem_Render", ReactiveSystem)
PlayerNormalAttackStateSystem_Render = PlayerNormalAttackStateSystem_Render

function PlayerNormalAttackStateSystem_Render:Constructor(world)
  self._world = world
end

function PlayerNormalAttackStateSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.MoveFSM)
  }, {"Added"})
  return c
end

function PlayerNormalAttackStateSystem_Render:Filter(entity)
  if not entity:HasMoveFSM() then
    return false
  end
  local move_fsm_cmpt = entity:MoveFSM()
  local cur_state_id = move_fsm_cmpt:GetMoveFSMCurStateID()
  if cur_state_id == PlayerActionStateID.NormalAttack then
    return true
  end
  return false
end

function PlayerNormalAttackStateSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:HandleAttack(entities[i])
  end
end

function PlayerNormalAttackStateSystem_Render:HandleAttack(entity)
  local normalAttackData = self:_GetPetNormalAttackData(entity)
  local pathPointAttackDic = normalAttackData:GetPathAttackData()
  local boardServiceRender = self._world:GetService("BoardRender")
  local curActorPos = boardServiceRender:GetRealEntityGridPos(entity)
  local lastDamagePoint = self:_CalcLastNormalDamagePathPoint(normalAttackData)
  local hasNormalAttackData = normalAttackData:HasPathPointNormalAttackData(curActorPos)
  if hasNormalAttackData then
    for pathPointPos, pathPointAttackData in pairs(pathPointAttackDic) do
      if pathPointPos == curActorPos then
        Log.debug("[attack] _HandlePlayAttack pathPointPos ", pathPointPos.x, " ", pathPointPos.y)
        TaskManager:GetInstance():CoreGameStartTask(self._PlayAttackToTarget, self, entity, pathPointAttackData, pathPointPos, lastDamagePoint)
        return
      end
    end
  else
    self._world:EventDispatcher():Dispatch(GameEventType.NormalAttackFinish, 1, entity:GetID())
  end
end

function PlayerNormalAttackStateSystem_Render:_GetPetNormalSkillID(entity)
  local skillID = entity:SkillInfo():GetNormalSkillID()
  return skillID
end

function PlayerNormalAttackStateSystem_Render:_GetPetNormalAttackData(entity)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local normalAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
  local normalAttackData = normalAtkResCmpt:GetPetNormalAttackResult(entity:GetID())
  return normalAttackData
end

function PlayerNormalAttackStateSystem_Render:_PlayAttackToTarget(TT, casterEntity, pathPointAttackData, pathPointPos, lastDamagePoint)
  local configService = self._world:GetService("Config")
  local playSkillService = self._world:GetService("PlaySkill")
  casterEntity:SetViewVisible(true)
  local attackGridDic = pathPointAttackData:GetAttackGridDic()
  local attackGridDicAdditional = pathPointAttackData:GetAttackGridDicAdditional()
  local freezeTimeScale = false
  local isLastTeamMember = self:_IsLastTeamMember(casterEntity)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local normalAtkRes = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
  local isFinalAtk = normalAtkRes:GetPlayNormalAttackFinalAttack()
  if isLastTeamMember == true and isFinalAtk == true and lastDamagePoint == pathPointPos then
    freezeTimeScale = true
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local normalSkillBeforeMove = utilDataSvc:GetEntityBuffValue(casterEntity, "NormalSkillBeforeMove")
  local orderArray = pathPointAttackData:GetPetOrderGridArray(casterEntity, pathPointPos)
  local attackCount = #orderArray
  if casterEntity:BuffView():GetBuffValue("ForcePetNormalAttackAfterMove") then
    local cRenderChain = self._world:GetRenderBoardEntity():RenderChainPath()
    if cRenderChain:GetRenderChainPath()[1] == pathPointPos then
      orderArray = {}
      attackCount = 0
    else
      orderArray = {pathPointPos}
      attackCount = 1
    end
  end
  for k, beAttackPos in ipairs(orderArray) do
    local attackGridData = self:_GetAttackGridPointData(attackGridDic, beAttackPos)
    local attackGridDataAdditional = self:_GetAttackGridPointData(attackGridDicAdditional, beAttackPos)
    if attackGridDataAdditional then
      local lastIndex = k - 1
      if orderArray[lastIndex] and orderArray[lastIndex] == beAttackPos then
        attackGridData = attackGridDataAdditional
      end
    end
    local effectResultDict = attackGridData:GetEffectResultDict()
    if effectResultDict and 0 < table.count(effectResultDict) then
      local skillId = attackGridData:GetAttackGridSkillId()
      local skillEffectResultContainer = SkillEffectResultContainer:New()
      skillEffectResultContainer:SetEffectResultDict(effectResultDict)
      skillEffectResultContainer:SetSkillID(skillId)
      skillEffectResultContainer:SetNormalAttack(true)
      skillEffectResultContainer:SetNormalAttackBeAttackOriPos(beAttackPos)
      if k == attackCount and freezeTimeScale == true then
        skillEffectResultContainer:SetFinalAttack(true)
      end
      if k == attackCount then
        skillEffectResultContainer:SetLastNormalAttackAtOnGrid(true)
      else
        skillEffectResultContainer:SetLastNormalAttackAtOnGrid(false)
      end
      casterEntity:SkillRoutine():ClearSkillRoutine()
      casterEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
      local skinId = 1
      if casterEntity:MatchPet() then
        skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
      end
      local skillConfigData = configService:GetSkillConfigData(skillId, casterEntity)
      local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
      local waitTaskID = playSkillService:StartSkillRoutine(casterEntity, skillPhaseArray, skillId)
      if not normalSkillBeforeMove then
        while not self:_IsTaskFinished(waitTaskID) do
          YIELD(TT)
        end
      end
    end
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer ~= nil then
    skillEffectResultContainer:SetNormalAttack(false)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.NormalAttackFinish, 1, casterEntity:GetID())
end

function PlayerNormalAttackStateSystem_Render:_GetAttackGridPointData(attackGridDic, checkPos)
  for beAttackPosIndex, attackGridData in pairs(attackGridDic) do
    local beAttackPos = Vector2.Index2Pos(beAttackPosIndex)
    if beAttackPos == checkPos then
      return attackGridData
    end
  end
  return nil
end

function PlayerNormalAttackStateSystem_Render:_IsTaskFinished(taskID)
  local task = TaskManager:GetInstance():FindTask(taskID)
  if task ~= nil then
    return false
  else
  end
  return true
end

function PlayerNormalAttackStateSystem_Render:_IsLastTeamMember(curPetEntity)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local rroundteam = renderBoardEntity:RenderRoundTeam()
  local roundTeam = rroundteam:GetRoundTeam()
  return roundTeam[#roundTeam] == curPetEntity:GetID()
end

function PlayerNormalAttackStateSystem_Render:_CalcLastNormalDamagePathPoint(pathNormalAttackData)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local rchainpath = renderBoardEntity:RenderChainPath()
  local chainPath = rchainpath:GetRenderChainPath()
  if not chainPath then
    return nil
  end
  local chainPathCount = #chainPath
  for index = chainPathCount, 1, -1 do
    local pathPoint = chainPath[index]
    local hasDamage = pathNormalAttackData:HasPathPointNormalDamage(pathPoint)
    if hasDamage == true then
      return pathPoint
    end
  end
  return nil
end
