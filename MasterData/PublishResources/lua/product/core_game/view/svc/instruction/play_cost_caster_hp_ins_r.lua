require("base_ins_r")
_class("PlayCostCasterHPInstruction", BaseInstruction)
PlayCostCasterHPInstruction = PlayCostCasterHPInstruction

function PlayCostCasterHPInstruction:Constructor(paramList)
end

function PlayCostCasterHPInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.CostCasterHP)
  local damageResult = damageResultArray[curDamageIndex]
  local damageInfo = damageResult:GetDamageInfo()
  if not damageInfo then
    Log.fatal("### damageInfo is nil. curDamageIndex, ", curDamageIndex)
    return
  end
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(casterEntity, damageInfo)
end
