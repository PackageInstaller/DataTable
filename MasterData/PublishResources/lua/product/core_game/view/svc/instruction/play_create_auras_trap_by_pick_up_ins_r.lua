require("base_ins_r")
_class("PlayCreateAurasTrapByPickUpInstruction", BaseInstruction)
PlayCreateAurasTrapByPickUpInstruction = PlayCreateAurasTrapByPickUpInstruction

function PlayCreateAurasTrapByPickUpInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._trapEffDelayTime = tonumber(paramList.trapEffDelay) or 0
  self._trapEffID = tonumber(paramList.trapEffID)
  local strArray = paramList.trapAnimNames
  self._trapAnimNames = string.split(strArray, "|")
  self._flyStartOffset = tonumber(paramList.flyStartOffset) or 1
  self._flyRotateOffset = tonumber(paramList.flyRotateOffset) or -0.3
  self._flyStartHeight = tonumber(paramList.flyStartHeight) or 1
  self._flyEffDelayTime = tonumber(paramList.flyEffDelay) or 0
  self._flyEffID = tonumber(paramList.flyEffID)
  self._flyTotalTime = tonumber(paramList.flyTotalTime) or 1000
  strArray = paramList.flyAnimNames
  self._flyAnimNames = string.split(strArray, "|")
end

function PlayCreateAurasTrapByPickUpInstruction:GetCacheResource()
  local t = {}
  if self._trapID then
    local cfgTrap = Cfg.cfg_trap[self._trapID]
    if cfgTrap then
      for i, resPath in ipairs(cfgTrap.ResPath) do
        table.insert(t, {resPath, 1})
      end
    end
  end
  if self._trapEffID then
    local cfgEff = Cfg.cfg_effect[self._trapEffID]
    if cfgEff then
      table.insert(t, {
        cfgEff.ResPath,
        1
      })
    end
  end
  if self._flyEffID then
    local cfgEff = Cfg.cfg_effect[self._flyEffID]
    if cfgEff then
      table.insert(t, {
        cfgEff.ResPath,
        1
      })
    end
  end
  return t
end

function PlayCreateAurasTrapByPickUpInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if not skillEffectResultContainer then
    Log.error("PlayCreateAurasTrapByPickUp: result container is nil")
    return
  end
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.CreateAurasTrapByPickUp)
  if not resultArray then
    Log.error("PlayCreateAurasTrapByPickUp: result is nil")
    return
  end
  if #resultArray ~= 1 then
    Log.error("PlayCreateAurasTrapByPickUp: result count error, count=", #resultArray)
    return
  end
  local skillRes = resultArray[1]
  local trapEntity = world:GetEntityByID(skillRes:GetTrapEntityID())
  if not trapEntity then
    return
  end
  local pos = skillRes:GetPos()
  trapEntity:SetPosition(pos)
  local squareRingNum = skillRes:GetSquareRingNum()
  local trapRSvc = world:GetService("TrapRender")
  trapRSvc:CreateSingleTrapRender(TT, trapEntity, true)
  local effHolderCmpt = trapEntity:EffectHolder()
  if not effHolderCmpt then
    trapEntity:AddEffectHolder()
    effHolderCmpt = trapEntity:EffectHolder()
  end
  local flyEffEntityList, taskIDs = self:_PlayFly(TT, casterEntity, pos, squareRingNum)
  if 0 < #flyEffEntityList then
    for _, flyEffEntity in ipairs(flyEffEntityList) do
      effHolderCmpt:AttachEffectByEffectID(self._flyEffID, flyEffEntity:GetID())
    end
  end
  local trapEffEntity = self:_PlayAuras(TT, pos, squareRingNum, world)
  if trapEffEntity then
    effHolderCmpt:AttachEffectByEffectID(self._trapEffID, trapEffEntity:GetID())
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
end

function PlayCreateAurasTrapByPickUpInstruction:_PlayAuras(TT, pos, squareRingNum, world)
  local minX = pos.x - squareRingNum
  local maxX = pos.x + squareRingNum
  local minY = pos.y - squareRingNum
  local maxY = pos.y + squareRingNum
  if self._trapEffDelayTime > 0 then
    YIELD(TT, self._trapEffDelayTime)
  end
  if not self._trapEffID or self._trapEffID == 0 then
    return
  end
  local centerPos = pos
  local effectSvc = world:GetService("Effect")
  local trapEffEntity = effectSvc:CreateWorldPositionEffect(self._trapEffID, centerPos)
  local effObject = trapEffEntity:View():GetGameObject()
  local transWork = effObject.transform
  local scale = Vector3.New(maxX - minX + 1, 1, maxY - minY + 1)
  transWork:DOScale(scale, 0)
  self:_PlayAnimation(trapEffEntity, self._trapAnimNames)
  return trapEffEntity
end

function PlayCreateAurasTrapByPickUpInstruction:_PlayFly(TT, casterEntity, pos, squareRingNum)
  local flyEffEntityList = {}
  local world = casterEntity:GetOwnerWorld()
  local boardSvc = world:GetService("BoardRender")
  local effectSvc = world:GetService("Effect")
  if self._flyEffDelayTime > 0 then
    YIELD(TT, self._flyEffDelayTime)
  end
  local casterPos = casterEntity:GetRenderGridPosition()
  local casterDir = casterEntity:GetRenderGridDirection()
  local flyStartPos = casterPos + casterDir * self._flyStartOffset
  local v3StartPos = boardSvc:GridPos2RenderPos(flyStartPos)
  v3StartPos.y = v3StartPos.y + self._flyStartHeight
  local minX = pos.x - squareRingNum
  local maxX = pos.x + squareRingNum
  local minY = pos.y - squareRingNum
  local maxY = pos.y + squareRingNum
  local flysquareRingNumList = {}
  flysquareRingNumList[1] = Vector2(minX - 0.5, maxY + 0.5)
  flysquareRingNumList[2] = Vector2(maxX + 0.5, maxY + 0.5)
  flysquareRingNumList[3] = Vector2(minX - 0.5, minY - 0.5)
  flysquareRingNumList[4] = Vector2(maxX + 0.5, minY - 0.5)
  local centerPos = pos
  local trajectoryInfoArray = {}
  for _, endGridPos in ipairs(flysquareRingNumList) do
    local effEntity = effectSvc:CreatePositionEffect(self._flyEffID, v3StartPos)
    if effEntity then
      local effDir = centerPos - endGridPos
      effDir = effDir:Normalize()
      effEntity:SetDirection(effDir, self._flyRotateOffset)
      self:_PlayAnimation(effEntity, self._flyAnimNames)
      table.insert(flyEffEntityList, effEntity)
    end
    local endRenderPos = boardSvc:GridPos2RenderPos(endGridPos)
    endRenderPos.y = endRenderPos.y + self._flyStartHeight
    local trajectoryInfo = {
      startHeight = self._flyStartHeight,
      endHeight = 0,
      totalTime = self._flyTotalTime * 0.001,
      totalTimeMs = self._flyTotalTime,
      targetRenderPos = endRenderPos,
      currentTime = 0,
      trajectoryID = self._flyEffID,
      trajectoryEntity = effEntity
    }
    table.insert(trajectoryInfoArray, trajectoryInfo)
  end
  YIELD(TT)
  local taskIDs = {}
  for _, trajectoryInfo in ipairs(trajectoryInfoArray) do
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo)
    table.insert(taskIDs, taskID)
  end
  return flyEffEntityList, taskIDs
end

function PlayCreateAurasTrapByPickUpInstruction:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local transWork = effectObject.transform
  transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.OutQuart)
  YIELD(TT, trajectoryInfo.totalTimeMs)
end

function PlayCreateAurasTrapByPickUpInstruction:_PlayAnimation(entity, animNames)
  if not entity:HasView() then
    return
  end
  local go = entity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  if table.count(animNames) > 1 then
    anim:Stop()
    for i = 1, #animNames do
      anim:PlayQueued(animNames[i])
    end
  else
    anim:Play(animNames[1])
  end
end
