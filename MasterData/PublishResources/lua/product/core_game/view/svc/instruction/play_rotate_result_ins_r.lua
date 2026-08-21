require("base_ins_r")
_class("PlayRotateResultInstruction", BaseInstruction)
PlayRotateResultInstruction = PlayRotateResultInstruction

function PlayRotateResultInstruction:Constructor(paramList)
end

function PlayRotateResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Rotate)
  if resultArray == nil then
    Log.fatal("PlayRotateResultInstruction, result is nil.")
    return
  end
  local dirNew = resultArray[1]:GetDirNew()
  casterEntity:SetDirection(dirNew)
end
