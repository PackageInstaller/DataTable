_class("PlayPetMoyeChainSkillInstruction", BaseInstruction)
PlayPetMoyeChainSkillInstruction = PlayPetMoyeChainSkillInstruction

function PlayPetMoyeChainSkillInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flyTime = tonumber(paramList.flyTime) or 500
  self._flyTrace = tonumber(paramList.flyTrace) or 1
  self._offsetX = tonumber(paramList.offsetx) or 0
  self._offsetY = tonumber(paramList.offsety) or 0
  self._offsetZ = tonumber(paramList.offsetz) or 0
  self._isBlock = tonumber(paramList.isBlock) or 1
  self._yieldTimeScale = tonumber(paramList.yieldTimeScale) or 0
  self._yieldTime = tonumber(paramList.yieldTime) or 0
  self._centerGridEffectID = tonumber(paramList.centerGridEffectID)
  self._trapIDs = {}
  local trapIDs = paramList.trapIDs
  if trapIDs then
    local array = string.split(trapIDs, "|")
    for _, str in ipairs(array) do
      table.insert(self._trapIDs, tonumber(str))
    end
  end
end

function PlayPetMoyeChainSkillInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  if self._centerGridEffectID and 0 < self._centerGridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._centerGridEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayPetMoyeChainSkillInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DynamicCenterDamage) or {}
  local result = resultArray[1]
  if not result then
    return
  end
  local damageResults = result:GetDamageResults()
  local finalCenterPos = result:GetFinalCenter()
  for _, damageResult in ipairs(damageResults) do
    local damageGridPos = damageResult:GetGridPos()
    if damageGridPos == finalCenterPos then
      local boardRenderSvc = world:GetService("BoardRender")
      local targetEntityID = damageResult:GetTargetID()
      local targetEntity = world:GetEntityByID(targetEntityID)
      local offset = Vector3(self._offsetX, self._offsetY, self._offsetZ)
      local trajectoryBeginPos = casterEntity:View():GetGameObject().transform:TransformPoint(offset)
      local trajectoryEndPos = targetEntity:GridLocation():Center()
      trajectoryEndPos = boardRenderSvc:GridPos2RenderPos(trajectoryEndPos)
      local trajectoryDir = trajectoryEndPos - trajectoryBeginPos
      local trajectoryEffectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, trajectoryBeginPos)
      trajectoryEffectEntity:SetDirection(trajectoryDir)
      YIELD(TT, self._yieldTimeScale)
      local flyTime = self._flyTime / 1000
      local trajectoryGO = trajectoryEffectEntity:View():GetGameObject()
      trajectoryGO.transform:DOMove(trajectoryEndPos, flyTime, false)
      YIELD(TT, self._yieldTime)
      local viewCenterPos = damageResult:GetGridPos()
      local effectService = world:GetService("Effect")
      effectService:CreateCommonGridEffect(self._centerGridEffectID, viewCenterPos, casterEntity:GetRenderGridDirection())
    end
  end
  local playSkillService = world:GetService("PlaySkill")
  for _, damageResult in ipairs(damageResults) do
    local damageInfo = damageResult:GetDamageInfo(1)
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    local damageGridPos = damageResult:GetGridPos()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillEffectResultContainer:GetSkillID())
    playSkillService:HandleBeHit(TT, beHitParam)
  end
  local chainAttackDataList = self:_GetChainAttackDataByEntityID(world, casterEntity:GetID())
  if chainAttackDataList then
    for _, chainAttackDatas in pairs(chainAttackDataList) do
      for _, chainAttackData in pairs(chainAttackDatas) do
        local skillEffectResults = chainAttackData:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
        if skillEffectResults then
          for i = 1, #skillEffectResults do
            local summonTrapResult = skillEffectResults[i]
            local trapID = summonTrapResult:GetTrapID()
            if table.icontains(self._trapIDs, trapID) then
              GameGlobal.TaskManager():CoreGameStartTask(function()
                self:_ShowTrapFromSummonTrap(TT, world, summonTrapResult)
              end)
            end
          end
        end
      end
    end
  end
end

function PlayPetMoyeChainSkillInstruction:_ShowTrapFromSummonTrap(TT, world, summonTrapResult)
  local posSummon = summonTrapResult:GetPos()
  local dirSummon = summonTrapResult:GetDir()
  local trapID = summonTrapResult:GetTrapID()
  local entityIDList = summonTrapResult:GetTrapIDList()
  if #entityIDList == 0 then
    return
  end
  for _, entityID in ipairs(entityIDList) do
    local trapEntity = world:GetEntityByID(entityID)
    if trapEntity then
      local cTrap = trapEntity:TrapID()
      local trapIDMatch = cTrap and cTrap:GetTrapID() == trapID
      if cTrap and trapIDMatch and not trapEntity:HasDeadMark() then
        self:_ShowTrap(TT, world, trapEntity, posSummon, dirSummon)
      end
    end
  end
end

function PlayPetMoyeChainSkillInstruction:_ShowTrap(TT, world, trapEntity, posSummon)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
end

function PlayPetMoyeChainSkillInstruction:_GetChainAttackDataByEntityID(world, casterEntityID)
  local renderBoardEntity = world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetChainSkillDataList(casterEntityID)
  return chainAttackData
end
