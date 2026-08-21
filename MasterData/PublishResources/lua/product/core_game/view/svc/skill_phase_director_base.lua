_class("SkillPhaseDirectorBase", Object)
SkillPhaseDirectorBase = SkillPhaseDirectorBase

function SkillPhaseDirectorBase:Constructor(world)
  self._world = world
  self._phaseIndex = 0
  self._delayInfo = {}
end

function SkillPhaseDirectorBase:NextPhaseIndex(casterEntity, skillPhaseArray)
  if self._phaseIndex < #skillPhaseArray then
    self._phaseIndex = self._phaseIndex + 1
    return self._phaseIndex
  end
end

function SkillPhaseDirectorBase:CurPhaseIndex()
  return self._phaseIndex
end

function SkillPhaseDirectorBase:CreateDelayInfo(index)
  self._delayInfo[index] = SkillPhaseTaskRunData:New()
  return self._delayInfo[index]
end

function SkillPhaseDirectorBase:DoPlaySkillPhase(TT, casterEntity, skillPhaseArray, funcDic)
  local phaseTaskIDArray = {}
  local oldpos = casterEntity:GridLocation().Position
  local olddir = casterEntity:GridLocation().Direction
  local revert_pos_dir = false
  for phaseIndex = 1, #skillPhaseArray do
    local phaseData = skillPhaseArray[phaseIndex]
    local phaseParam = phaseData:GetPhaseParam()
    local phaseType = phaseParam:GetPhaseType()
    local func = funcDic[phaseType]
    func:PrepareToPlay(TT, casterEntity, phaseParam)
  end
  while self:NextPhaseIndex(casterEntity, skillPhaseArray) do
    local phaseIndex = self:CurPhaseIndex()
    local phaseData = skillPhaseArray[phaseIndex]
    if phaseData == nil then
      Log.fatal("phase end ---------- phaseIndex= " .. phaseIndex)
      break
    end
    while not self:_CheckPhaseCanStart(skillPhaseArray, phaseIndex) do
      YIELD(TT)
    end
    local runData = self:CreateDelayInfo(phaseIndex)
    local phaseData = skillPhaseArray[phaseIndex]
    local posdirParam = phaseData:GetPosDirParam()
    local phaseParam = phaseData:GetPhaseParam()
    local phaseType = phaseParam:GetPhaseType()
    local func = funcDic[phaseType]
    Log.notice("entity " .. casterEntity:GetID() .. " start skill phase " .. phaseIndex, " phaseType=", GetEnumKey("SkillViewPhaseType", phaseType))
    if posdirParam then
      revert_pos_dir = true
      local pos = posdirParam:GetPos()
      local dir = posdirParam:GetDir()
      casterEntity:SetLocation(pos, dir)
    end
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      func:BeginPlay(TT, casterEntity, phaseParam)
      func:PlayFlight(TT, casterEntity, phaseParam, phaseIndex)
      func:EndPlay(TT, casterEntity, phaseParam)
      runData.EndTick = GameGlobal:GetInstance():GetCurrentTime()
    end)
    table.insert(phaseTaskIDArray, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(phaseTaskIDArray) do
    YIELD(TT)
  end
  if revert_pos_dir then
    casterEntity:SetLocation(oldpos, olddir)
  end
end

function SkillPhaseDirectorBase:_CheckPhaseCanStart(skillPhaseArray, phaseIndex)
  local runndata = self._delayInfo[phaseIndex]
  if runndata ~= nil then
    return false
  end
  local phaseData = skillPhaseArray[phaseIndex]
  local delayfromPhase = phaseData:GetDelayFromPhase() or 0
  local delayTime = phaseData:GetDelayMS()
  local delayType = phaseData:GetDelayType()
  local curTick = GameGlobal:GetInstance():GetCurrentTime()
  if delayfromPhase <= 0 then
    return true
  end
  if delayfromPhase == phaseIndex then
    error("[skill] delayfromPhase == phaseIndex " .. phaseIndex)
  end
  local prePhaseRundata = self._delayInfo[delayfromPhase]
  if prePhaseRundata == nil then
    return false
  end
  if delayType == SkillDelayType.Delay_AfterStart then
    if delayTime <= curTick - prePhaseRundata.StartTick then
      return true
    else
      return false
    end
  elseif delayType == SkillDelayType.Delay_AfterEnd then
    if 0 < prePhaseRundata.EndTick and delayTime <= curTick - prePhaseRundata.EndTick then
      return true
    else
      return false
    end
  elseif delayType == SkillDelayType.Delay_AfterEvent then
    if delayTime <= curTick - prePhaseRundata.StartTick then
      return true
    else
      return false
    end
  else
    Log.error("[skill] error delaytype")
  end
end
