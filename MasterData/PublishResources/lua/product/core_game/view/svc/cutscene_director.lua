_class("CutsceneDirector", Object)
CutsceneDirector = CutsceneDirector

function CutsceneDirector:Constructor(world)
  self._world = world
  self._phaseIndex = 0
  self._delayInfo = {}
end

function CutsceneDirector:NextPhaseIndex(phaseArray)
  if self._phaseIndex < #phaseArray then
    self._phaseIndex = self._phaseIndex + 1
    return self._phaseIndex
  end
end

function CutsceneDirector:CurPhaseIndex()
  return self._phaseIndex
end

function CutsceneDirector:CreateDelayInfo(index)
  self._delayInfo[index] = CutscenePhaseTime:New()
  return self._delayInfo[index]
end

function CutsceneDirector:DoPlayCutscenePhase(TT, cutSceneConfigID)
  local configSvc = self._world:GetService("Config")
  local cursceneData = configSvc:GetCutsceneConfig(cutSceneConfigID)
  local phaseArray = cursceneData:GetCutscenePhaseArray()
  local phaseTaskIDArray = {}
  while self:NextPhaseIndex(phaseArray) do
    local phaseIndex = self:CurPhaseIndex()
    local phaseData = phaseArray[phaseIndex]
    if phaseData == nil then
      Log.fatal("phase end ---------- phaseIndex= " .. phaseIndex)
      break
    end
    while not self:_CheckPhaseCanStart(phaseArray, phaseIndex) do
      YIELD(TT)
    end
    local timeData = self:CreateDelayInfo(phaseIndex)
    local insParam = phaseData:GetPhaseParam()
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:DoCutsceneInstruction(TT, insParam)
    end)
    table.insert(phaseTaskIDArray, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(phaseTaskIDArray) do
    YIELD(TT)
  end
  local cutsceneSvc = self._world:GetService("Cutscene")
  cutsceneSvc:ResetSkyBoxColor()
end

function CutsceneDirector:_CheckPhaseCanStart(phaseArray, phaseIndex)
  local timeData = self._delayInfo[phaseIndex]
  if timeData ~= nil then
    return false
  end
  local phaseData = phaseArray[phaseIndex]
  local delayfromPhase = phaseData:GetDelayFromPhase() or 0
  local delayTime = phaseData:GetDelayMS()
  local delayType = phaseData:GetDelayType()
  local curTick = GameGlobal:GetInstance():GetCurrentTime()
  if delayfromPhase <= 0 then
    return true
  end
  if delayfromPhase == phaseIndex then
    Log.error("[skill] delayfromPhase == phaseIndex " .. phaseIndex)
  end
  local prePhaseRundata = self._delayInfo[delayfromPhase]
  if prePhaseRundata == nil then
    return false
  end
  if delayType == CutsceneDelayType.AfterStart then
    if delayTime <= curTick - prePhaseRundata.StartTick then
      return true
    else
      return false
    end
  elseif delayType == CutsceneDelayType.AfterEnd then
    if 0 < prePhaseRundata.EndTick and delayTime <= curTick - prePhaseRundata.EndTick then
      return true
    else
      return false
    end
  else
    Log.error("[skill] error delaytype")
  end
end

function CutsceneDirector:DoCutsceneInstruction(TT, instructionParam)
  local phaseContext = CutscenePhaseContext:New(self._world)
  local insArray = instructionParam:GetInstructionSet()
  local insIndex = 1
  local insSetCount = table.count(insArray)
  while 0 < insIndex and insIndex <= insSetCount do
    local instruction = insArray[insIndex]
    Log.debug("play cutscene instruction start:", instruction._className)
    local nextInsLabel = instruction:DoInstruction(TT, phaseContext)
    if nextInsLabel then
      insIndex = self:_CalcNextLabel(insArray, nextInsLabel)
    else
      insIndex = insIndex + 1
    end
  end
  local phaseTaskList = phaseContext:GetPhaseTaskList()
  while not TaskHelper:GetInstance():IsAllTaskFinished(phaseTaskList) do
    YIELD(TT)
  end
end

function CutsceneDirector:_CalcNextLabel(insArray, nextInsLabel)
  if nextInsLabel == InstructionConst.PhaseEnd then
    return -1
  else
    for k, v in ipairs(insArray) do
      local ins = v
      local insLabel = ins:GetInstructionLabel()
      if insLabel ~= nil and insLabel == nextInsLabel then
        return k
      end
    end
  end
  Log.fatal("instruction label not match:", nextInsLabel)
  return -1
end
