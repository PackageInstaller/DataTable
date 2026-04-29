_class("PlayChangeSanMaxInstruction", BaseInstruction)
PlayChangeSanMaxInstruction = PlayChangeSanMaxInstruction

function PlayChangeSanMaxInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local rsvcFeature = world:GetService("FeatureRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeSanMax)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    local val = result:GetDeltaVal()
    local old = result:GetOldSanValue()
    local current = result:GetNewSanValue()
    local debtVal = result:GetDebtValue()
    local modifyTimes = result:GetModifyTimes()
    local curMaxVal = result:GetNewSanMaxValue()
    rsvcFeature:NotifySanMaxValueChange(current, old, val, curMaxVal)
    if val ~= 0 then
      local nt = NTSanValueChange:New(current, old, debtVal, modifyTimes)
      world:GetService("PlayBuff"):PlayBuffView(TT, nt)
    end
  end
end
