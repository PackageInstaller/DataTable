_class("PlayRecoverFromGreyHPInstruction", BaseInstruction)
PlayRecoverFromGreyHPInstruction = PlayRecoverFromGreyHPInstruction

function PlayRecoverFromGreyHPInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.RecoverFromGreyHP)
  if not resultArray then
    return
  end
  local tTaskID = {}
  local playDamageService = world:GetService("PlayDamage")
  for _, result in ipairs(resultArray) do
    local addHpDamageInfo = result:GetDamageInfo()
    casterEntity:ReplaceGreyHP(result:GetCurrentGreyVal())
    local tid = playDamageService:AsyncUpdateHPAndDisplayDamage(casterEntity, addHpDamageInfo)
    if tid then
      table.insert(tTaskID, tid)
    end
  end
  local cHP = casterEntity:HP()
  local greyVal = cHP:GetGreyHP()
  local redhp = cHP:GetRedHP()
  local maxhp = cHP:GetMaxHP()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossGreyHP, casterEntity:GetID(), greyVal, redhp, maxhp)
  while not TaskHelper:GetInstance():IsAllTaskFinished(tTaskID) do
    YIELD(TT)
  end
end
