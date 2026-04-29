require("play_skill_phase_base_r")
_class("PlaySkillInstructionPhase", PlaySkillPhaseBase)
PlaySkillInstructionPhase = PlaySkillInstructionPhase

function PlaySkillInstructionPhase:PlayFlight(TT, casterEntity, phaseParam)
  local world = casterEntity:GetOwnerWorld()
  local phaseContext = SkillPhaseContext:New(world, casterEntity)
  local instructionParam = phaseParam
  local insArray = instructionParam:GetInstructionSet()
  local insIndex = 1
  local insSetCount = table.count(insArray)
  while 0 < insIndex and insIndex <= insSetCount do
    local instruction = insArray[insIndex]
    Log.debug("play skill instruction start:", instruction._className, " cast=", casterEntity:GetID())
    local nextInsLabel = instruction:DoInstruction(TT, casterEntity, phaseContext)
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

function PlaySkillInstructionPhase:PrepareToPlay(TT, casterEntity, phaseParam)
  local insArray = phaseParam:GetInstructionSet()
  for i = 1, #insArray do
    local instruction = insArray[i]
    if instruction.Prepare then
      instruction:Prepare(TT, casterEntity)
    end
  end
end

function PlaySkillInstructionPhase:_CalcNextLabel(insArray, nextInsLabel)
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
