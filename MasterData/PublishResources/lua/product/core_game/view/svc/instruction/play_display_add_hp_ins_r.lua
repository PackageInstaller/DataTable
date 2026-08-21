require("base_ins_r")
_class("PlayDisplayAddHPInstruction", BaseInstruction)
PlayDisplayAddHPInstruction = PlayDisplayAddHPInstruction

function PlayDisplayAddHPInstruction:Constructor(paramList)
end

function PlayDisplayAddHPInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local totalValue = 0
  local addHpDamageInfo = DamageInfo:New(0, DamageType.Recover)
  local eachGridAddBloodResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.EachGridAddBlood)
  if eachGridAddBloodResultArray then
    for k, v in pairs(eachGridAddBloodResultArray) do
      totalValue = totalValue + v:GetAddValue()
      addHpDamageInfo:MergeDamageInfo(v:GetDamageInfo())
    end
  end
  local eachTrapAddBloodResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.EachTrapAddBlood)
  if eachTrapAddBloodResultArray then
    for k, v in pairs(eachTrapAddBloodResultArray) do
      totalValue = totalValue + v:GetAddValue()
      addHpDamageInfo:MergeDamageInfo(v:GetDamageInfo())
    end
  end
  local addBloodResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if addBloodResultArray then
    for k, v in pairs(addBloodResultArray) do
      totalValue = totalValue + v:GetAddValue()
      addHpDamageInfo:MergeDamageInfo(v:GetDamageInfo())
    end
  end
  if eachGridAddBloodResultArray == nil and addBloodResultArray == nil and eachTrapAddBloodResultArray == nil then
    return
  end
  if casterEntity:HasPetPstID() then
    casterEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  if casterEntity:EntityType() and casterEntity:EntityType():IsPetShadow() then
    local teamEntity = world:Player():GetLocalTeamEntity()
    casterEntity = teamEntity
  end
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(casterEntity, addHpDamageInfo)
end
