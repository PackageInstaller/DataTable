require("base_ins_r")
_class("PlayAllAddHpTextInstruction", BaseInstruction)
PlayAllAddHpTextInstruction = PlayAllAddHpTextInstruction

function PlayAllAddHpTextInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.damageStageIndex) or 1
end

function PlayAllAddHpTextInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playDamageService = world:GetService("PlayDamage")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local addHpResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood, self._stageIndex)
  if not addHpResultArray then
    return
  end
  for i, addHpResult in ipairs(addHpResultArray) do
    local targetID = addHpResult:GetTargetID()
    local targetPos = addHpResult:GetGridPos()
    local addValue = addHpResult:GetAddValue()
    local skillID = skillEffectResultContainer:GetSkillID()
    local targetEntity = world:GetEntityByID(targetID)
    local damageShowType = playDamageService:SingleOrGrid(skillID)
    if targetEntity then
      local addHpDamageInfo = addHpResult:GetDamageInfo()
      addHpDamageInfo:SetShowType(damageShowType)
      addHpDamageInfo:SetRenderGridPos(targetPos)
      playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, addHpDamageInfo)
    else
      Log.error("[PlayInstruction_AddHpText] 没有找到目标， nSkillID = ", skillID, ", TargetID = ", targetID)
    end
  end
end
